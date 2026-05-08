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
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()
const r = await c.query(`SELECT category, COUNT(*) as n FROM tasks WHERE status='published' GROUP BY category ORDER BY n DESC, category`)
console.log('=== Task count by category ===')
let total = 0
for (const row of r.rows) { console.log(`  ${row.category.padEnd(20)} ${row.n}`); total += parseInt(row.n) }
console.log(`  TOTAL                ${total}`)
await c.end()
