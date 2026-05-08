import fs from 'node:fs/promises'
import { Client } from 'pg'

const envText = await fs.readFile('.env.local', 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()
const r = await c.query(`SELECT category, primary_tags, COUNT(*)::int n FROM tasks WHERE status='published' GROUP BY category, primary_tags ORDER BY category, n DESC`)
let prev = null
for (const row of r.rows) {
  if (prev !== row.category) { console.log(`\n=== ${row.category} ===`); prev = row.category }
  console.log(`  ${row.n.toString().padStart(3)}  ${JSON.stringify(row.primary_tags)}`)
}
await c.end()
