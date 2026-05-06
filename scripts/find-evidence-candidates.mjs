// S110: find next-tier head-term tools WITHOUT scores_evidence, ranked by review_count.
import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { Client } from 'pg'
const __dirname = path.dirname(fileURLToPath(import.meta.url))
const envText = await fs.readFile(path.join(__dirname, '..', '.env.local'), 'utf-8')
const env = Object.fromEntries(envText.split('\n').filter(l => l.includes('=')).map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] }))
const client = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()

const { rows } = await client.query(`
  SELECT slug, name, rating, review_count, tags, website_url
  FROM tools
  WHERE scores_evidence IS NULL
  ORDER BY review_count DESC NULLS LAST
  LIMIT 60
`)
console.log(`Top 60 tools without scores_evidence (head-term + tier-2):\n`)
rows.forEach((t, i) => {
  console.log(`${(i+1).toString().padStart(3)}. ${t.slug.padEnd(28)} ${(t.rating||0)}★ ${(t.review_count||0).toString().padStart(7)}  ${t.website_url || '-'}`)
})
await client.end()
