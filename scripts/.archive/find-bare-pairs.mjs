// Find compare pairs that are in the DB but NOT yet enriched in compareEnrichment.ts.
// Output candidates for Block C.1.
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

const { rows } = await client.query(`SELECT slug FROM comparisons ORDER BY slug`)
const allDbPairs = rows.map(r => r.slug)

const enrichmentTs = await fs.readFile(path.join(WEB_ROOT, 'src/data/compareEnrichment.ts'), 'utf-8')
const enrichedKeys = new Set(
  [...enrichmentTs.matchAll(/^  '([a-z0-9-]+-vs-[a-z0-9-]+)':/gm)].map(m => m[1])
)

const bare = allDbPairs.filter(s => !enrichedKeys.has(s))
console.log('Total DB pairs:', allDbPairs.length)
console.log('Enriched in TS:', enrichedKeys.size)
console.log('Bare (need enrichment):', bare.length)
console.log()
console.log('BARE PAIRS:')
console.log(bare.join('\n'))

await client.end()
