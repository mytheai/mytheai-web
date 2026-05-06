import fs from 'node:fs/promises'
import { Client } from 'pg'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')
const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(envText.split('\n').filter(l => l.includes('=')).map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] }))
const client = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()
const slugs = ['mathgpt','socratic','quizlet-q-chat','nearpod-ai','eduaide-ai','duetto','revinate','siteminder','atomize','leapsome','paradox-ai','betterup','pyn','peakon','smokeball','definely','filevine','relativity','lexion','brightflag','glint','drata','vercel','netlify','supabase','stripe','mercury','canary-technologies','teams','play-ht','github-copilot','notion','microsoft-365-copilot','ticktick','phind','mem','chorus','seekout','clockwise']
const { rows } = await client.query('SELECT slug,name FROM tools WHERE slug = ANY($1) ORDER BY slug', [slugs])
const found = new Map(rows.map(r => [r.slug, r.name]))
slugs.forEach(s => console.log(`${found.has(s) ? '✓' : '✗'}  ${s.padEnd(28)} ${found.get(s) || ''}`))
await client.end()
