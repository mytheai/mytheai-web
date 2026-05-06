import fs from 'node:fs/promises'
import { Client } from 'pg'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
const __dirname = path.dirname(fileURLToPath(import.meta.url))
const envText = await fs.readFile(path.join(__dirname, '..', '.env.local'), 'utf-8')
const env = Object.fromEntries(envText.split('\n').filter(l => l.includes('=')).map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] }))
const client = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()
const slugs = ['flux','ideogram','stable-diffusion','midjourney','dalle','dall-e-3']
const { rows } = await client.query('SELECT slug FROM tools WHERE slug = ANY($1)', [slugs])
const found = new Set(rows.map(r => r.slug))
slugs.forEach(s => console.log(`${found.has(s) ? '✓' : '✗'}  ${s}`))
await client.end()
