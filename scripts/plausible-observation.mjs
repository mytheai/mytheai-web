// Plausible 24-48h post-deploy observation helper.
// Pulls Outbound + CompareView + TrustStackVisit event counts from Plausible
// API and prints a comparison table for click-through analysis.
//
// Setup:
//   1. Get a Plausible API key: https://plausible.io/settings/personal/api-keys
//   2. Add to .env.local: PLAUSIBLE_API_KEY=...
//   3. Confirm site ID matches your Plausible dashboard (default: mytheai.io)
//
// Run:
//   node --env-file=.env.local scripts/plausible-observation.mjs
//
// Exits 0 even on no data (Plausible returns empty arrays for new periods).

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const envText = await fs.readFile(path.join(__dirname, '..', '.env.local'), 'utf-8')
const env = Object.fromEntries(envText.split('\n').filter(l => l.includes('=')).map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] }))

const apiKey = env.PLAUSIBLE_API_KEY
const siteId = env.PLAUSIBLE_SITE_ID || 'mytheai.com'
if (!apiKey) {
  console.error('Missing PLAUSIBLE_API_KEY in .env.local')
  console.error('Get one at: https://plausible.io/settings/personal/api-keys')
  process.exit(1)
}

const fetchPlausible = async (params, attempt = 1) => {
  const qs = new URLSearchParams({ site_id: siteId, ...params }).toString()
  const url = `https://plausible.io/api/v1/stats/breakdown?${qs}`
  try {
    const res = await fetch(url, { headers: { Authorization: `Bearer ${apiKey}` } })
    if (!res.ok) {
      const status = res.status
      const text = await res.text()
      // Retry transient 5xx (Plausible infra timeouts) up to 3x with backoff
      if (attempt < 3 && status >= 500) {
        await new Promise(r => setTimeout(r, 800 * attempt))
        return fetchPlausible(params, attempt + 1)
      }
      throw new Error(`Plausible ${status}: ${text.slice(0, 120)}`)
    }
    return res.json()
  } catch (e) {
    if (attempt < 3 && /fetch failed|ETIMEDOUT|ECONNRESET/i.test(e.message)) {
      await new Promise(r => setTimeout(r, 600 * attempt))
      return fetchPlausible(params, attempt + 1)
    }
    throw e
  }
}

const periods = ['day', '7d']
console.log(`Site: ${siteId}\n`)

for (const period of periods) {
  console.log(`=== Period: ${period} ===`)
  try {
    const events = await fetchPlausible({
      property: 'event:name',
      period,
      metrics: 'visitors,events',
    })
    if (!events.results || events.results.length === 0) {
      console.log('  (no events recorded)')
      continue
    }
    events.results.forEach(r => {
      const name = (r.name ?? '(unnamed)').toString()
      console.log(`  ${name.padEnd(30)} visitors=${r.visitors}  events=${r.events}`)
    })

    // Outbound by tool surface
    console.log(`\n  Outbound by surface:`)
    const surfaces = await fetchPlausible({
      property: 'event:props:tool',
      period,
      filters: 'event:name==Outbound',
      metrics: 'visitors,events',
    })
    if (surfaces.results && surfaces.results.length > 0) {
      surfaces.results.forEach(r => {
        // Plausible prop-breakdown returns the prop name as the key (e.g., r.tool), not r.name
        const name = (r.tool ?? r.name ?? '(no tool prop)').toString()
        console.log(`    ${name.padEnd(28)} visitors=${r.visitors}  events=${r.events}`)
      })
    } else {
      console.log('    (no outbound events)')
    }
  } catch (e) {
    console.log(`  Error: ${e.message}`)
  }
  console.log()
}

console.log('Read S94 Action 5 brief for what to look for:')
console.log('- Outbound rate per surface (which CTA placement converts best?)')
console.log('- Compare page CompareView vs auto-fallback ratio')
console.log('- Mobile bounce rate vs desktop')
