import fs from 'node:fs/promises'
import { Client } from 'pg'

const envText = await fs.readFile('.env.local', 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()

const targets = ['notion','stripe','justworks','mosaic','datarails','cube','snowflake','github','notion-ai','mem-ai']
for (const t of targets) {
  const r = await c.query(`SELECT slug, name FROM tools WHERE slug ILIKE $1 OR name ILIKE $1 LIMIT 3`, [`%${t}%`])
  console.log(`${t}:`)
  for (const row of r.rows) console.log(`  ${row.slug.padEnd(25)} -> ${row.name}`)
}
await c.end()
