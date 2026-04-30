#!/usr/bin/env node
// Second-pass verifier for suspect tools.
// Uses DNS lookup + alternative endpoints (/robots.txt, /favicon.ico) that
// anti-bot/Cloudflare typically whitelist, to distinguish:
//   - DNS-resolved + at least one endpoint reachable → ALIVE (just bot-blocked main page)
//   - DNS fail OR all endpoints fail → DEAD
// Auto-merges newly-confirmed dead slugs into remove-dead-tools.sql.
//
// Run: node scripts/verify-suspects.mjs (after check-dead-tools.mjs)

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import dns from 'node:dns/promises'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')

const report = JSON.parse(await fs.readFile(path.join(WEB_ROOT, 'dead-tools-report.json'), 'utf-8'))
const suspect = report.suspect ?? []
console.log(`Verifying ${suspect.length} suspect tools with multi-endpoint probing...`)

const BROWSER_UA =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'

const PROBE_PATHS = ['/robots.txt', '/favicon.ico', '/sitemap.xml', '/']

async function dnsResolve(hostname) {
  try {
    await dns.lookup(hostname)
    return true
  } catch {
    return false
  }
}

async function tryEndpoint(url, timeoutMs) {
  const controller = new AbortController()
  const timer = setTimeout(() => controller.abort(), timeoutMs)
  try {
    const res = await fetch(url, {
      method: 'GET',
      signal: controller.signal,
      redirect: 'follow',
      headers: {
        'User-Agent': BROWSER_UA,
        Accept: '*/*',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    })
    clearTimeout(timer)
    if (res.status >= 200 && res.status < 400) return { ok: true, code: res.status, finalUrl: res.url }
    return { ok: false, code: res.status }
  } catch (err) {
    clearTimeout(timer)
    return { ok: false, error: String(err.cause?.code || err.message).slice(0, 60) }
  }
}

async function verifyOne(tool) {
  let hostname
  try {
    hostname = new URL(tool.website_url).hostname
  } catch {
    return { ...tool, verdict: 'dead', reason: 'invalid-url' }
  }
  const dnsOk = await dnsResolve(hostname)
  if (!dnsOk) return { ...tool, verdict: 'dead', reason: 'dns-failed' }

  const origin = `https://${hostname}`
  const probes = []
  for (const p of PROBE_PATHS) {
    const res = await tryEndpoint(origin + p, 15000)
    probes.push({ path: p, ...res })
    if (res.ok) return { ...tool, verdict: 'alive', reason: `probe-${p}-ok-${res.code}`, probes }
  }
  // DNS resolves but every endpoint fails - parking page or hung server
  const allTimedOut = probes.every(p => String(p.error || '').includes('AbortError') || p.code === undefined)
  return {
    ...tool,
    verdict: allTimedOut ? 'still-suspect' : 'dead',
    reason: allTimedOut ? 'all-probes-timeout' : 'all-probes-failed',
    probes,
  }
}

const CONCURRENCY = 8
const queue = [...suspect]
const verified = []
let done = 0
async function worker() {
  while (queue.length) {
    const t = queue.shift()
    if (!t) break
    const v = await verifyOne(t)
    verified.push(v)
    done++
    if (done % 20 === 0 || done === suspect.length) {
      process.stdout.write(`  ${done}/${suspect.length} verified\n`)
    }
  }
}
const t0 = Date.now()
await Promise.all(Array.from({ length: CONCURRENCY }, () => worker()))
console.log(`Done in ${((Date.now() - t0) / 1000).toFixed(1)}s.\n`)

const newlyDead = verified.filter(v => v.verdict === 'dead')
const confirmedAlive = verified.filter(v => v.verdict === 'alive')
const stillSuspect = verified.filter(v => v.verdict === 'still-suspect')

console.log('Verification results:')
console.log(`  newly confirmed dead:     ${newlyDead.length}`)
console.log(`  confirmed alive:          ${confirmedAlive.length}`)
console.log(`  still ambiguous:          ${stillSuspect.length}`)

if (newlyDead.length) {
  console.log('\nNewly confirmed dead:')
  for (const t of newlyDead) console.log(`  - ${t.slug} (${t.reason})`)
}
if (stillSuspect.length) {
  console.log('\nStill ambiguous (DNS resolves but everything times out - manual check):')
  for (const t of stillSuspect) console.log(`  - ${t.slug} (${t.website_url})`)
}

// Save verification report
await fs.writeFile(
  path.join(WEB_ROOT, 'verify-suspects-report.json'),
  JSON.stringify({ generated_at: new Date().toISOString(), verified }, null, 2)
)

// Combine: existing dead + manual + newly-dead, regenerate SQL
const existingDead = new Set([
  ...(report.dead?.map(r => r.slug) ?? []),
  ...(report.manual_dead_slugs ?? []),
])
const newlyDeadSlugs = newlyDead.map(t => t.slug)
const allDead = [...new Set([...existingDead, ...newlyDeadSlugs])].sort()

console.log(`\nTotal dead now: ${allDead.length} (${existingDead.size} existing + ${newlyDeadSlugs.length} new)`)

const list = allDead.map(s => `  '${s.replace(/'/g, "''")}'`).join(',\n')
const sql = `-- Auto-generated ${new Date().toISOString()}
-- ${allDead.length} dead tools (${existingDead.size} existing + ${newlyDeadSlugs.length} newly verified).
-- Wrapped in BEGIN/COMMIT.

BEGIN;

DELETE FROM comparisons WHERE tool_a_slug IN (
${list}
) OR tool_b_slug IN (
${list}
);

DELETE FROM tool_clicks WHERE tool_slug IN (
${list}
);

DELETE FROM tools WHERE slug IN (
${list}
);

COMMIT;
`
await fs.writeFile(path.join(WEB_ROOT, 'remove-dead-tools.sql'), sql)

// Update report.json so clean-top10.mjs picks up new deaths
const updatedReport = {
  ...report,
  dead: [...(report.dead ?? []), ...newlyDead.map(t => ({ slug: t.slug, name: t.name, status: 'verified-dead', reason: t.reason }))],
  manual_dead_slugs: report.manual_dead_slugs ?? [],
  suspect: stillSuspect,
}
await fs.writeFile(path.join(WEB_ROOT, 'dead-tools-report.json'), JSON.stringify(updatedReport, null, 2))

console.log('\nFiles updated:')
console.log(`  remove-dead-tools.sql      (${allDead.length} dead, regenerated)`)
console.log(`  dead-tools-report.json     (merged)`)
console.log(`  verify-suspects-report.json (full verification log)`)
console.log('\nNext: run remove-dead-tools.sql in Supabase, then `node scripts/clean-top10.mjs`')
