// Final audit pass - catches zombie sites that pass HTTP 200 but have no real favicon
// (the symptom user reported with aWhere). Also re-probes Cloudflare-rejected suspects
// with a real User-Agent to bypass naive WAF blocking.
//
// Run: node scripts/final-audit.mjs
//
// Output: scripts/final-audit-report.json + scripts/final-audit-suspects.md

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')

const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...rest] = l.split('='); return [k.trim(), rest.join('=').trim()] })
)

const SUPABASE_URL = env.NEXT_PUBLIC_SUPABASE_URL
const SUPABASE_KEY = env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY

const REAL_UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'

// Google s2/favicons returns a ~600-byte default globe icon when no favicon found.
// Real favicons are usually 1.5KB-15KB. Anything <800 bytes = no real favicon.
const FAVICON_DEFAULT_SIZE_THRESHOLD = 800

async function fetchTools() {
  const r = await fetch(`${SUPABASE_URL}/rest/v1/tools?select=slug,name,website_url&order=slug.asc`, {
    headers: { apikey: SUPABASE_KEY, Authorization: `Bearer ${SUPABASE_KEY}` }
  })
  if (!r.ok) throw new Error(`Supabase fetch failed: ${r.status}`)
  return await r.json()
}

function hostname(url) {
  try { return new URL(url).hostname.replace(/^www\./, '') } catch { return null }
}

async function probeDomain(url) {
  if (!url) return { ok: false, reason: 'no-url' }
  try {
    const ctrl = new AbortController()
    const timer = setTimeout(() => ctrl.abort(), 12000)
    const r = await fetch(url, {
      method: 'GET',
      headers: { 'User-Agent': REAL_UA, 'Accept': 'text/html,*/*' },
      redirect: 'follow',
      signal: ctrl.signal,
    })
    clearTimeout(timer)
    const text = await r.text().catch(() => '')
    const lower = text.toLowerCase().slice(0, 5000)
    const isParking = /domain (is )?for sale|buy this domain|parked|godaddy|sedo|expired|domain expired|hugedomains/i.test(lower)
    return {
      ok: r.status >= 200 && r.status < 400 && !isParking && text.length > 200,
      status: r.status,
      finalUrl: r.url,
      bodyLen: text.length,
      parking: isParking,
      reason: isParking ? 'parking-page' : (r.status >= 400 ? `http-${r.status}` : (text.length <= 200 ? 'thin-body' : null)),
    }
  } catch (e) {
    return { ok: false, reason: e.code || e.name || String(e).slice(0, 80) }
  }
}

async function probeFavicon(host) {
  if (!host) return { ok: false, size: 0, reason: 'no-host' }
  try {
    const ctrl = new AbortController()
    const timer = setTimeout(() => ctrl.abort(), 8000)
    const r = await fetch(`https://www.google.com/s2/favicons?domain=${host}&sz=128`, {
      signal: ctrl.signal,
    })
    clearTimeout(timer)
    if (!r.ok) return { ok: false, size: 0, reason: `http-${r.status}` }
    const buf = await r.arrayBuffer()
    const size = buf.byteLength
    return {
      ok: size >= FAVICON_DEFAULT_SIZE_THRESHOLD,
      size,
      reason: size < FAVICON_DEFAULT_SIZE_THRESHOLD ? 'default-globe' : null,
    }
  } catch (e) {
    return { ok: false, size: 0, reason: e.code || String(e).slice(0, 60) }
  }
}

console.log('Fetching tools from Supabase...')
const tools = await fetchTools()
console.log(`Auditing ${tools.length} tools (favicon + domain probe with real UA)...`)

const results = []
let i = 0
const CONCURRENCY = 12

async function processTool(t) {
  const host = hostname(t.website_url)
  const [domain, fav] = await Promise.all([probeDomain(t.website_url), probeFavicon(host)])
  return {
    slug: t.slug,
    name: t.name,
    url: t.website_url,
    host,
    domain,
    favicon: fav,
    classification: classify(domain, fav),
  }
}

function classify(domain, fav) {
  // DEAD: domain explicitly fails (DNS/cert/404/parking) AND no real favicon
  if (!domain.ok && (domain.reason || '').match(/ENOTFOUND|EAI_AGAIN|CERT|http-404|http-410|parking-page|http-3[0-9]{2}/)) {
    return 'dead'
  }
  // ZOMBIE: domain returns 200/403 but body is thin AND favicon is default = abandoned
  if (!fav.ok && fav.reason === 'default-globe' && (!domain.ok || domain.bodyLen < 1500)) {
    return 'zombie'
  }
  // SUSPECT: one signal failed, other inconclusive
  if (!domain.ok || !fav.ok) return 'suspect'
  return 'alive'
}

const queue = [...tools]
const workers = Array.from({ length: CONCURRENCY }, async () => {
  while (queue.length) {
    const t = queue.shift()
    if (!t) break
    i++
    if (i % 50 === 0) console.log(`  ${i}/${tools.length}...`)
    const result = await processTool(t)
    results.push(result)
  }
})
await Promise.all(workers)

const dead = results.filter(r => r.classification === 'dead')
const zombie = results.filter(r => r.classification === 'zombie')
const suspect = results.filter(r => r.classification === 'suspect')
const alive = results.filter(r => r.classification === 'alive')

console.log(`\nResults:`)
console.log(`  alive:   ${alive.length}`)
console.log(`  suspect: ${suspect.length}`)
console.log(`  zombie:  ${zombie.length}  (passes HTTP probe but no real favicon - aWhere-style)`)
console.log(`  dead:    ${dead.length}`)

const reportPath = path.join(__dirname, 'final-audit-report.json')
await fs.writeFile(reportPath, JSON.stringify({ generated_at: new Date().toISOString(), summary: { alive: alive.length, suspect: suspect.length, zombie: zombie.length, dead: dead.length }, dead, zombie, suspect }, null, 2))
console.log(`\nFull report: ${reportPath}`)

const md = []
md.push(`# Final audit report - ${new Date().toISOString().split('T')[0]}`)
md.push('')
md.push(`Total: ${tools.length} | alive: ${alive.length} | suspect: ${suspect.length} | zombie: ${zombie.length} | dead: ${dead.length}`)
md.push('')

if (dead.length) {
  md.push('## DEAD (auto-delete eligible)')
  md.push('')
  for (const r of dead) {
    md.push(`- **${r.slug}** | ${r.url} | domain: ${r.domain.reason} | favicon: ${r.favicon.reason ?? 'ok'}`)
  }
  md.push('')
}

if (zombie.length) {
  md.push('## ZOMBIE (likely dead - aWhere-style: HTTP ok but no real favicon + thin body)')
  md.push('')
  for (const r of zombie) {
    md.push(`- **${r.slug}** | ${r.url} | domain status: ${r.domain.status ?? r.domain.reason} | body: ${r.domain.bodyLen ?? 0} bytes | favicon size: ${r.favicon.size} bytes`)
  }
  md.push('')
}

if (suspect.length) {
  md.push('## SUSPECT (manual review required)')
  md.push('')
  for (const r of suspect) {
    md.push(`- **${r.slug}** | ${r.url} | domain: ${r.domain.ok ? `${r.domain.status} body=${r.domain.bodyLen}` : r.domain.reason} | favicon: ${r.favicon.ok ? `${r.favicon.size}b` : r.favicon.reason}`)
  }
  md.push('')
}

const mdPath = path.join(__dirname, 'final-audit-suspects.md')
await fs.writeFile(mdPath, md.join('\n'))
console.log(`Markdown summary: ${mdPath}`)
