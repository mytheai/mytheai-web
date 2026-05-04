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
const client = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()

const { rows: filledRows } = await client.query(
  `SELECT COUNT(*)::int as c FROM tools WHERE array_length(integrations, 1) > 0`
)
console.log('Tools with integrations seeded:', filledRows[0].c)

const tier5 = ['pinecone','cohere','langchain','mistral','groq','replicate','kling','pika','leonardo-ai','playground-ai','submagic','sudowrite','wordtune','rytr','anytype','tana','reflect','todoist','motion','sunsama','akiflow','superhuman','savvycal','activepieces','pipedream','bardeen','glean','consensus','elicit','framer']
const { rows: tier5Rows } = await client.query(
  `SELECT slug FROM tools WHERE slug = ANY($1::text[]) AND array_length(integrations, 1) > 0 ORDER BY slug`,
  [tier5]
)
console.log('Tier 5 tools with integrations seeded:', tier5Rows.length, '/', tier5.length)
if (tier5Rows.length !== tier5.length) {
  const seeded = tier5Rows.map(r => r.slug)
  console.log('MISSING:', tier5.filter(s => !seeded.includes(s)).join(', '))
}

await client.end()
