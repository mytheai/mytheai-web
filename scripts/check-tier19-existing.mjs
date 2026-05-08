import fs from 'node:fs/promises'
import { Client } from 'pg'

const envText = await fs.readFile('.env.local', 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()

const candidates = [
  'launchdarkly','statsig','optimizely',
  'planetscale','neon','supabase',
  'frontify','brandfolder','bynder',
  'chargebee',
  'copilot-money','monarch-money','rocket-money',
  '6sense','demandbase','clearbit','apollo-io',
  'captivateiq','spiff'
]

const r = await c.query(`SELECT slug, name FROM tools WHERE slug = ANY($1::text[]) ORDER BY slug`, [candidates])
console.log(`=== Already in catalog (${r.rows.length}/${candidates.length}) ===`)
for (const row of r.rows) console.log(`  ${row.slug.padEnd(20)} -> ${row.name}`)

const found = r.rows.map(row => row.slug)
const missing = candidates.filter(c => !found.includes(c))
console.log(`\n=== Missing (${missing.length}) - candidates for tier 19 ===`)
for (const m of missing) console.log(`  ${m}`)

await c.end()
