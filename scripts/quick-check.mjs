import fs from 'node:fs/promises'
import { Client } from 'pg'

const envText = await fs.readFile('.env.local', 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()
const targets = ['linear','chartmogul','recurly','paddle','maxio','docyt','vic-ai','bench','hibob','bamboohr','deel','remote-com','workable','jobvite','seekout','linear-app','asana']
const r = await c.query(`SELECT slug, name FROM tools WHERE slug = ANY($1::text[])`, [targets])
for (const row of r.rows) console.log(`  ${row.slug.padEnd(15)} -> ${row.name}`)
console.log(`\nMissing:`)
for (const t of targets) if (!r.rows.find(row => row.slug === t)) console.log(`  ${t}`)
await c.end()
