// Phase 1 batch 4 candidates - Gate A (slug conflicts) + Gate B (mappability) verification.
// Target: +8-12 tasks to close 50-target. Backup queue + fresh broadening ideas.

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

const candidates = [
  // backup queue (8)
  { slug: 'ai-for-image-generation',     category: 'design',           primary_tags: ['image-ai'],                   picks: ['midjourney','dall-e','stable-diffusion','leonardo-ai','flux','ideogram','recraft','firefly'] },
  { slug: 'ai-for-customer-onboarding',  category: 'customer-success', primary_tags: ['ai-assistants','productivity'], picks: ['userpilot','pendo','appcues','chameleon','whatfix','intercom'] },
  { slug: 'ai-for-transcription',        category: 'productivity',     primary_tags: ['voice-audio','productivity'],  picks: ['otter-ai','rev','descript','sonix','fireflies-ai','tactiq','notta'] },
  { slug: 'ai-for-personalization',      category: 'marketing',        primary_tags: ['marketing'],                   picks: ['mutiny','intellimize','dynamic-yield','optimizely','segment'] },
  { slug: 'ai-for-ab-testing',           category: 'marketing',        primary_tags: ['marketing','data-analytics'],  picks: ['optimizely','vwo','convert','ab-tasty','statsig','posthog'] },
  { slug: 'ai-for-website-builders',     category: 'design',           primary_tags: ['design','code-ai'],            picks: ['framer','webflow','wix','squarespace','durable-co','dorik'] },
  { slug: 'ai-for-roadmap-planning',     category: 'productivity',     primary_tags: ['productivity'],                picks: ['productboard','aha-io','roadmunk','airfocus','craft-io'] },
  { slug: 'ai-for-product-research',     category: 'research',         primary_tags: ['research'],                    picks: ['dovetail','maze','sprig','typeform','userlytics','lookback'] },

  // fresh broadening (7)
  { slug: 'ai-for-marketing-automation', category: 'marketing',        primary_tags: ['marketing','email-marketing'], picks: ['hubspot','marketo','braze','customer-io','iterable','klaviyo','activecampaign'] },
  { slug: 'ai-for-cold-calling',         category: 'sales',            primary_tags: ['sales-engagement'],            picks: ['gong-io','orum','nooks','regie-ai','koncert','outreach'] },
  { slug: 'ai-for-voice-assistants',     category: 'dev',              primary_tags: ['voice-audio','ai-assistants'], picks: ['vapi','bland-ai','retell','voiceflow','synthflow','play-ht'] },
  { slug: 'ai-for-product-tours',        category: 'customer-success', primary_tags: ['ai-assistants'],               picks: ['pendo','appcues','userpilot','chameleon','userflow','whatfix'] },
  { slug: 'ai-for-sql-generation',       category: 'data-analytics',   primary_tags: ['code-ai','data-analytics'],    picks: ['julius-ai','seek-ai','formula-bot','outerbase','akkio'] },
  { slug: 'ai-for-mind-mapping',         category: 'productivity',     primary_tags: ['productivity'],                picks: ['mindmeister','whimsical','miro','lucidspark','xmind','milanote'] },
  { slug: 'ai-for-prototyping',          category: 'design',           primary_tags: ['design','code-ai'],            picks: ['v0','uizard','galileo-ai','visily','subframe','relume'] },
]

console.log(`=== Phase 1 batch 4: ${candidates.length} candidates ===\n`)

const top10Src = await fs.readFile(path.join(WEB_ROOT, 'src/data/top10.ts'), 'utf-8')
const useCasesSrc = await fs.readFile(path.join(WEB_ROOT, 'src/data/useCases.ts'), 'utf-8')
const top10Slugs = [...top10Src.matchAll(/slug:\s*'([^']+)'/g)].map(m => m[1])
const useCaseSlugs = [...useCasesSrc.matchAll(/slug:\s*'([^']+)'/g)].map(m => m[1])

console.log('=== GATE A: slug conflicts ===\n')
const aPass = []
const aFail = []
for (const c of candidates) {
  const conflicts = []
  const r1 = await client.query(`SELECT slug FROM tasks WHERE slug = $1`, [c.slug])
  if (r1.rows.length) conflicts.push('tasks')
  const r2 = await client.query(`SELECT slug FROM tools WHERE slug = $1`, [c.slug])
  if (r2.rows.length) conflicts.push('tools')
  const r3 = await client.query(`SELECT slug FROM comparisons WHERE slug = $1`, [c.slug])
  if (r3.rows.length) conflicts.push('comparisons')
  if (top10Slugs.includes(c.slug)) conflicts.push('top10')
  if (useCaseSlugs.includes(c.slug)) conflicts.push('use-cases')
  if (conflicts.length) {
    console.log(`  x ${c.slug.padEnd(40)} CONFLICT: ${conflicts.join(',')}`)
    aFail.push(c.slug)
  } else {
    console.log(`  ok ${c.slug}`)
    aPass.push(c.slug)
  }
}
console.log(`\nGate A: ${aPass.length}/${candidates.length} pass`)

console.log('\n=== GATE B: mappability ===\n')
const results = []
for (const c of candidates) {
  if (aFail.includes(c.slug)) continue
  const { rows } = await client.query(
    `SELECT slug, name, rating, review_count, tags FROM tools WHERE slug = ANY($1::text[]) ORDER BY rating DESC NULLS LAST, review_count DESC NULLS LAST`,
    [c.picks]
  )
  const found = rows.map(r => r.slug)
  const missing = c.picks.filter(p => !found.includes(p))
  const status = found.length >= 3 ? 'PASS' : 'FAIL'
  console.log(`\n${c.slug} [${status}]`)
  console.log(`  found ${found.length}/${c.picks.length}: ${found.join(', ')}`)
  if (missing.length) console.log(`  missing: ${missing.join(', ')}`)
  results.push({ ...c, found, missing, valid_picks: rows.slice(0, 5).map(r => r.slug), gate_b: status })
}

console.log('\n\n=== SUMMARY ===')
const pass = results.filter(r => r.gate_b === 'PASS')
const fail = results.filter(r => r.gate_b === 'FAIL')
console.log(`PASS (${pass.length}): ${pass.map(r => r.slug).join(', ')}`)
console.log(`FAIL (${fail.length}): ${fail.map(r => r.slug).join(', ')}`)

console.log('\n=== FINAL VALID PICKS (top 5 sorted by rating) ===')
for (const r of pass) {
  console.log(`${r.slug}: [${r.valid_picks.join(',')}]`)
}

await client.end()
