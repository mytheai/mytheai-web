// Pre-batch-16 state check: category counts, total published tasks
import fs from 'node:fs/promises'
import { Client } from 'pg'

const envText = await fs.readFile('.env.local', 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()

const total = await c.query(`SELECT COUNT(*)::int AS n FROM tasks WHERE status='published'`)
console.log(`Total published tasks: ${total.rows[0].n}`)

const cats = await c.query(`
  SELECT category, COUNT(*)::int AS n
  FROM tasks
  WHERE status='published'
  GROUP BY category
  ORDER BY n ASC, category ASC
`)
console.log(`\n=== Category spread ===`)
for (const r of cats.rows) console.log(`  ${r.category.padEnd(20)} ${r.n}`)

const tools = await c.query(`SELECT COUNT(*)::int AS n FROM tools`)
console.log(`\nTools: ${tools.rows[0].n}`)

const integ = await c.query(`SELECT COUNT(*)::int AS n FROM tools WHERE integrations IS NOT NULL AND array_length(integrations, 1) > 0`)
console.log(`Tools w/ integrations: ${integ.rows[0].n}`)

await c.end()
