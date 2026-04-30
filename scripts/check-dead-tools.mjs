#!/usr/bin/env node
// Scans every tool's website_url + checks against manual override list.
// Outputs: dead-tools-report.json + remove-dead-tools.sql + suspect-tools.md
//
// Conservative flagging policy:
//   DEAD (auto-delete): DNS fail, ECONNRESET, ECONNREFUSED, 404, 410, parked-domain redirect,
//                        TLS cert error, AND slugs in MANUAL_DEAD_SLUGS below.
//   SUSPECT (user reviews): 403, timeout, 5xx, anything ambiguous. Listed but NOT auto-deleted.
//   ALIVE: 2xx, 3xx redirect to non-parking destination.
//
// Run: node scripts/check-dead-tools.mjs (from web/ directory)

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')

// Add slugs here that you have personally verified dead in a browser.
// They will be auto-deleted along with script-detected dead tools.
const MANUAL_DEAD_SLUGS = [
  'shorts-ai',
  'detangle-ai',
  'lensa-ai',
  // add more here after manual verification
]

const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(
  envText
    .split('\n')
    .filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => {
      const [k, ...rest] = l.split('=')
      return [k.trim(), rest.join('=').trim()]
    })
)
const SUPABASE_URL = env.NEXT_PUBLIC_SUPABASE_URL
const SUPABASE_KEY = env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY
if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('Missing Supabase credentials in .env.local')
  process.exit(1)
}

console.log('Fetching tools from Supabase...')
const fetchAll = async () => {
  const all = []
  let offset = 0
  const PAGE = 1000
  while (true) {
    const r = await fetch(
      `${SUPABASE_URL}/rest/v1/tools?select=slug,name,website_url&order=slug&offset=${offset}&limit=${PAGE}`,
      { headers: { apikey: SUPABASE_KEY, Authorization: `Bearer ${SUPABASE_KEY}` } }
    )
    if (!r.ok) {
      console.error(`Supabase error: ${r.status} ${await r.text()}`)
      process.exit(1)
    }
    const batch = await r.json()
    all.push(...batch)
    if (batch.length < PAGE) break
    offset += PAGE
  }
  return all
}
const tools = await fetchAll()
console.log(`Loaded ${tools.length} tools.`)

const PARKING_HOSTS = [
  'sedo.com',
  'sedoparking.com',
  'godaddy.com/domain',
  'dan.com',
  'hugedomains.com',
  'parkingcrew.net',
  'afternic.com',
  'expireddomains.net',
  'undeveloped.com',
  'bodis.com',
  'parklogic.com',
]

const BROWSER_UA =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'

async function singleAttempt(url, timeoutMs) {
  const controller = new AbortController()
  const timer = setTimeout(() => controller.abort(), timeoutMs)
  try {
    const res = await fetch(url, {
      method: 'GET',
      signal: controller.signal,
      redirect: 'follow',
      headers: {
        'User-Agent': BROWSER_UA,
        Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9',
        'Accept-Encoding': 'gzip, deflate, br',
        'Cache-Control': 'no-cache',
      },
    })
    clearTimeout(timer)
    const finalUrl = res.url
    const code = res.status
    const isParked = PARKING_HOSTS.some(d => finalUrl.toLowerCase().includes(d))
    if (isParked) return { status: 'parked', code, finalUrl }
    if (code >= 200 && code < 400) return { status: 'alive', code, finalUrl }
    if (code === 404 || code === 410) return { status: 'dead', code, finalUrl }
    if (code === 403 || code === 429) return { status: 'suspect-blocked', code, finalUrl }
    if (code >= 500) return { status: 'server-error', code, finalUrl }
    return { status: 'http-error', code, finalUrl }
  } catch (err) {
    clearTimeout(timer)
    const c = err.cause?.code || err.code
    const msg = String(err.cause?.message || err.message)
    if (err.name === 'AbortError') return { status: 'timeout' }
    if (c === 'ENOTFOUND') return { status: 'dns-failed', error: c }
    if (c === 'ECONNREFUSED') return { status: 'refused', error: c }
    if (c === 'ECONNRESET') return { status: 'reset', error: c }
    if (c === 'CERT_HAS_EXPIRED' || c === 'ERR_TLS_CERT_ALTNAME_INVALID' || msg.includes('certificate'))
      return { status: 'cert-error', error: c || 'cert' }
    return { status: 'error', error: String(c || err.message).slice(0, 80) }
  }
}

const RETRYABLE = new Set(['timeout', 'reset', 'server-error', 'error'])
const CONFIRM_THRESHOLD = 2

async function checkUrl(url) {
  if (!url) return { status: 'no-url' }
  let lastResult = null
  for (let i = 0; i < CONFIRM_THRESHOLD; i++) {
    const r = await singleAttempt(url, 25000)
    if (r.status === 'alive') return r
    if (!RETRYABLE.has(r.status)) return r
    lastResult = r
    if (i < CONFIRM_THRESHOLD - 1) await new Promise(res => setTimeout(res, 2000))
  }
  return lastResult
}

const CONCURRENCY = 6
const queue = [...tools]
const results = []
let done = 0

async function worker() {
  while (queue.length) {
    const tool = queue.shift()
    if (!tool) break
    const r = await checkUrl(tool.website_url)
    results.push({ ...tool, ...r })
    done++
    if (done % 50 === 0 || done === tools.length) {
      process.stdout.write(`  ${done}/${tools.length} checked\n`)
    }
  }
}

console.log(`Checking URLs (${CONCURRENCY} parallel, 25s timeout, 2x retry)...`)
const t0 = Date.now()
await Promise.all(Array.from({ length: CONCURRENCY }, () => worker()))
const elapsed = ((Date.now() - t0) / 1000).toFixed(1)
console.log(`Done in ${elapsed}s.\n`)

// Conservative classification
const DEFINITELY_DEAD = ['dead', 'parked', 'dns-failed', 'refused', 'reset', 'cert-error', 'no-url']
const SUSPECT = ['suspect-blocked', 'timeout', 'server-error', 'http-error', 'error']

const definitelyDead = results.filter(r => DEFINITELY_DEAD.includes(r.status))
const suspect = results.filter(r => SUSPECT.includes(r.status))
const alive = results.filter(r => r.status === 'alive')

// Merge with manual override list
const manualSet = new Set(MANUAL_DEAD_SLUGS)
const definitelyDeadSlugs = new Set(definitelyDead.map(r => r.slug))
const manualOnly = MANUAL_DEAD_SLUGS.filter(s => !definitelyDeadSlugs.has(s))
const allDeadSlugs = [...new Set([...definitelyDead.map(r => r.slug), ...MANUAL_DEAD_SLUGS])].sort()

console.log('Summary:')
console.log(`  alive:           ${alive.length}`)
console.log(`  definitely dead: ${definitelyDead.length}  (will be in DELETE SQL)`)
console.log(`  manual override: ${manualOnly.length}      (also in DELETE SQL)`)
console.log(`  suspect:         ${suspect.length}      (manual review - see suspect-tools.md)`)
console.log(`  TOTAL TO DELETE: ${allDeadSlugs.length}`)

console.log('\nDefinitely dead by reason:')
const grouped = {}
for (const r of definitelyDead) (grouped[r.status] ??= []).push(r.slug)
for (const [s, slugs] of Object.entries(grouped)) {
  console.log(`  ${s}: ${slugs.length} - ${slugs.join(', ')}`)
}
if (manualOnly.length) console.log(`  manual: ${manualOnly.length} - ${manualOnly.join(', ')}`)

await fs.writeFile(
  path.join(WEB_ROOT, 'dead-tools-report.json'),
  JSON.stringify(
    {
      generated_at: new Date().toISOString(),
      total: tools.length,
      counts: { alive: alive.length, dead: definitelyDead.length, suspect: suspect.length, manual: manualOnly.length },
      manual_dead_slugs: MANUAL_DEAD_SLUGS,
      dead: definitelyDead,
      suspect,
    },
    null,
    2
  )
)

const suspectMd = [
  '# Suspect Tools - Manual Review',
  '',
  `Generated ${new Date().toISOString()} - ${suspect.length} tools need manual verification.`,
  '',
  'These tools returned timeouts, 403, or 5xx responses. They might be alive (anti-bot, slow CDN)',
  'or actually dead. Open each URL in a browser to verify.',
  '',
  '## How to use this list',
  '',
  '1. Open each URL below in a browser.',
  '2. If site is dead/closed, copy the slug to `MANUAL_DEAD_SLUGS` in `scripts/check-dead-tools.mjs`.',
  '3. Re-run `node scripts/check-dead-tools.mjs` to regenerate the SQL.',
  '',
  '## Suspect tools',
  '',
  '| Slug | URL | Status | Code/Error |',
  '|---|---|---|---|',
  ...suspect
    .sort((a, b) => a.slug.localeCompare(b.slug))
    .map(r => `| \`${r.slug}\` | ${r.website_url} | ${r.status} | ${r.code ?? r.error ?? ''} |`),
]
await fs.writeFile(path.join(WEB_ROOT, 'suspect-tools.md'), suspectMd.join('\n'))

const sqlPath = path.join(WEB_ROOT, 'remove-dead-tools.sql')
if (allDeadSlugs.length === 0) {
  await fs.writeFile(sqlPath, '-- No dead tools detected.\n')
} else {
  const list = allDeadSlugs.map(s => `  '${s.replace(/'/g, "''")}'`).join(',\n')
  const sql = `-- Auto-generated by scripts/check-dead-tools.mjs at ${new Date().toISOString()}
-- ${allDeadSlugs.length} dead tools (${definitelyDead.length} script-detected + ${manualOnly.length} manual).
-- Wrapped in BEGIN/COMMIT - either everything deletes or nothing changes.

BEGIN;

-- 1. Remove from comparisons (FK references tool_a_slug, tool_b_slug)
DELETE FROM comparisons
WHERE tool_a_slug IN (
${list}
)
   OR tool_b_slug IN (
${list}
);

-- 2. Remove click tracking
DELETE FROM tool_clicks
WHERE tool_slug IN (
${list}
);

-- 3. Remove tools
DELETE FROM tools
WHERE slug IN (
${list}
);

COMMIT;

-- After running, run: node scripts/clean-top10.mjs   (removes dead slugs from top10.ts)
`
  await fs.writeFile(sqlPath, sql)
}

console.log('\nGenerated:')
console.log('  dead-tools-report.json  (full report)')
console.log('  suspect-tools.md        (manual review checklist)')
console.log(`  remove-dead-tools.sql   (${allDeadSlugs.length} DELETE statements)`)

console.log('\nNext steps:')
console.log('  1. Review suspect-tools.md - open each URL in browser')
console.log('  2. Add confirmed-dead slugs to MANUAL_DEAD_SLUGS at top of scripts/check-dead-tools.mjs')
console.log('  3. Re-run script to regenerate SQL with new dead list')
console.log('  4. Run remove-dead-tools.sql in Supabase SQL Editor')
console.log('  5. Run: node scripts/clean-top10.mjs')
