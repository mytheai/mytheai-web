import fs from 'node:fs/promises'
import { Client } from 'pg'

const envText = await fs.readFile('.env.local', 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()

const r = await c.query(`SELECT * FROM tools WHERE slug = 'sentry' LIMIT 1`)
if (r.rows[0]) {
  for (const [k, v] of Object.entries(r.rows[0])) {
    const str = JSON.stringify(v)
    console.log(`${k.padEnd(30)} ${str ? str.slice(0, 120) : v}`)
  }
}
await c.end()
