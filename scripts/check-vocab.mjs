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

const { rows } = await client.query(
  `SELECT DISTINCT unnest(integrations) AS tag, COUNT(*) AS n
   FROM tools
   WHERE array_length(integrations, 1) > 0
   GROUP BY tag
   ORDER BY n DESC, tag ASC`
)
console.log('Integration tag controlled vocabulary (currently used in DB):')
for (const r of rows) {
  console.log(`  ${r.tag.padEnd(20)} ${r.n}`)
}

await client.end()
