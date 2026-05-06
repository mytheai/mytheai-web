import fs from 'node:fs/promises'
import { Client } from 'pg'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
const __dirname = path.dirname(fileURLToPath(import.meta.url))
const envText = await fs.readFile(path.join(__dirname, '..', '.env.local'), 'utf-8')
const env = Object.fromEntries(envText.split('\n').filter(l => l.includes('=')).map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] }))
const client = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()
const { rows } = await client.query(`SELECT slug FROM tools WHERE slug ILIKE 'dall%' OR slug ILIKE 'tome%' OR slug ILIKE 'gran%' OR slug ILIKE 'pave%' OR slug ILIKE 'workspace%' OR slug ILIKE '%openai%' ORDER BY slug`)
rows.forEach(r => console.log(r.slug))
await client.end()
