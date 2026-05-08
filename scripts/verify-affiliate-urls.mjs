// Verify affiliate URL coverage across catalog.
// Reads DATABASE_URL from .env.local. Reports:
//   - Total tools with non-default affiliate_url (i.e. affiliate_url != website_url AND not null)
//   - Coverage % across full catalog
//   - List of "live" tools (slug + affiliate URL host) for spot-check
//
// Run: node --env-file=.env.local scripts/verify-affiliate-urls.mjs

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { Client } from 'pg'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')

const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const DATABASE_URL = env.DATABASE_URL
if (!DATABASE_URL) {
  console.error('ERROR: DATABASE_URL missing from .env.local')
  process.exit(1)
}

const client = new Client({ connectionString: DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()

try {
  const totalRes = await client.query(`SELECT COUNT(*)::int AS total FROM tools`)
  const liveRes = await client.query(`
    SELECT slug, name, affiliate_url, website_url
    FROM tools
    WHERE affiliate_url IS NOT NULL
      AND TRIM(affiliate_url) != ''
      AND affiliate_url != website_url
    ORDER BY slug
  `)
  const sameRes = await client.query(`
    SELECT COUNT(*)::int AS same
    FROM tools
    WHERE affiliate_url IS NULL
       OR TRIM(affiliate_url) = ''
       OR affiliate_url = website_url
  `)

  const total = totalRes.rows[0].total
  const liveCount = liveRes.rows.length
  const sameCount = sameRes.rows[0].same
  const coveragePct = total > 0 ? ((liveCount / total) * 100).toFixed(1) : '0.0'

  console.log(`\n=== Affiliate URL coverage ===`)
  console.log(`Total tools in catalog:           ${total}`)
  console.log(`Tools with live affiliate URL:    ${liveCount}  (${coveragePct}%)`)
  console.log(`Tools with default website_url:   ${sameCount}  (no affiliate or same as website)`)
  console.log()

  if (liveCount === 0) {
    console.log('No live affiliate URLs yet. Apply via affiliate-application-template.md first.')
  } else {
    console.log(`=== Live affiliate URLs (${liveCount}) ===`)
    liveRes.rows.forEach(r => {
      let host = '?'
      try { host = new URL(r.affiliate_url).host } catch { host = '(invalid URL)' }
      console.log(`  ${r.slug.padEnd(30)} ${r.name.padEnd(28)} -> ${host}`)
    })
  }

  console.log(`\nTarget: 80%+ coverage on top 20 head-term tools by Q4 2026.`)
  console.log(`Update affiliate-tracker.md snapshot row with date + ${liveCount}/${total} (${coveragePct}%).`)
} finally {
  await client.end()
}
