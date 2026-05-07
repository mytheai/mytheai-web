// Phase 0 Gate B verification: confirm editor-picked tool slugs exist in catalog.

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

const editorPicks = {
  'ai-for-cold-emails': ['lavender', 'lemlist', 'instantly', 'smartlead', 'apollo-io', 'smartwriter', 'lemcal', 'reply-io'],
  'ai-for-meeting-summaries': ['fireflies-ai', 'otter-ai', 'fathom', 'grain', 'sembly-ai', 'avoma', 'tactiq', 'read-ai', 'meetgeek', 'supernormal'],
  'ai-for-blog-outlines': ['jasper', 'copy-ai', 'writesonic', 'surfer-seo', 'frase', 'neuronwriter', 'scalenut', 'koala-ai', 'longshot-ai'],
  'ai-for-invoice-ocr': ['rossum', 'docyt', 'vic-ai', 'stampli', 'tipalti', 'airbase', 'ramp', 'brex', 'pandadoc'],
  'ai-for-customer-support': ['intercom', 'gorgias', 'freshchat', 'drift', 'gladly', 'plain', 'helpjuice', 'forethought', 're-amaze', 'zoho-desk', 'liveagent', 'capacity'],
}

console.log('=== Editor-pick existence check ===\n')
for (const [taskSlug, picks] of Object.entries(editorPicks)) {
  console.log(`\n${taskSlug}:`)
  const { rows } = await client.query(
    `SELECT slug, name, rating, tags FROM tools WHERE slug = ANY($1::text[]) ORDER BY rating DESC, review_count DESC NULLS LAST`,
    [picks]
  )
  const found = rows.map(r => r.slug)
  const missing = picks.filter(p => !found.includes(p))
  for (const r of rows) console.log(`  ✓ ${r.slug.padEnd(28)} ★${r.rating}  tags=[${r.tags.join(',')}]`)
  for (const m of missing) console.log(`  ✗ ${m.padEnd(28)} NOT IN CATALOG`)
  console.log(`  → ${found.length}/${picks.length} found, ${missing.length} missing`)
  if (found.length < 3) console.log(`  ⚠️ GATE B FAIL: <3 valid picks`)
}

await client.end()
