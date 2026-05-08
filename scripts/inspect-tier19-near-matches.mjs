import fs from 'node:fs/promises'
import { Client } from 'pg'

const envText = await fs.readFile('.env.local', 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()

const patterns = ['supabase','%supabase%','%launch%','%neon%','%planet%','%optim%','%apollo%','%clearbit%','%6sense%','%demand%','%chargebee%','%spiff%','%captiv%','%front%','%brandf%','%bynder%','%statsig%','%copilot%money%','%monarch%','%rocket%money%']
for (const p of patterns) {
  const r = await c.query(`SELECT slug, name FROM tools WHERE slug ILIKE $1 OR name ILIKE $1 ORDER BY slug LIMIT 5`, [p])
  if (r.rows.length) {
    console.log(`Pattern '${p}':`)
    for (const row of r.rows) console.log(`  ${row.slug.padEnd(28)} -> ${row.name}`)
  }
}
await c.end()
