// Verify 2 backup candidates to fill the 17th slot.

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

const backups = [
  { slug: 'ai-for-presentations',       category: 'design',     primary_tags: ['design'],         picks: ['gamma-app','beautiful-ai','slidebean','decktopus','visme','genially','pitch'] },
  { slug: 'ai-for-translation',         category: 'productivity', primary_tags: ['productivity'], picks: ['deepl','lilt','unbabel','transifex','crowdin','trados','smartling'] },
]

for (const c of backups) {
  console.log(`\n=== ${c.slug} ===`)
  // Gate A
  const r1 = await client.query(`SELECT slug FROM tasks WHERE slug = $1`, [c.slug])
  const r2 = await client.query(`SELECT slug FROM tools WHERE slug = $1`, [c.slug])
  const r3 = await client.query(`SELECT slug FROM comparisons WHERE slug = $1`, [c.slug])
  const conflicts = []
  if (r1.rows.length) conflicts.push('tasks')
  if (r2.rows.length) conflicts.push('tools')
  if (r3.rows.length) conflicts.push('comparisons')
  console.log(`Gate A: ${conflicts.length === 0 ? 'PASS' : 'FAIL ' + conflicts.join(',')}`)

  // Gate B
  const { rows } = await client.query(
    `SELECT slug, name, rating FROM tools WHERE slug = ANY($1::text[]) ORDER BY rating DESC NULLS LAST`,
    [c.picks]
  )
  const found = rows.map(r => r.slug)
  const missing = c.picks.filter(p => !found.includes(p))
  console.log(`Gate B: ${found.length >= 3 ? 'PASS' : 'FAIL'} (${found.length}/${c.picks.length})`)
  console.log(`  found: ${found.join(', ')}`)
  if (missing.length) console.log(`  missing: ${missing.join(', ')}`)
}

await client.end()
