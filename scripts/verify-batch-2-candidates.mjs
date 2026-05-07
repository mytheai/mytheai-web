// Phase 1 batch 2 candidates - Gate A (slug conflicts) + Gate B (mappability) verification.
// Source: tool catalog use_cases mining + editorial brainstorm (Option B per S113).

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

// 24 candidates - editorial brainstorm by category from plan section 10.
// Each has primary_tags (drives fallback fetch) + picks (editor-ranked, Gate B verified).
const candidates = [
  // writing/content
  { slug: 'ai-for-social-media-posts',  category: 'writing',  primary_tags: ['writing-ai','social-media'],     picks: ['jasper','copy-ai','ocoya','buffer','predis-ai','taplio','hootsuite','contentstudio'] },
  { slug: 'ai-for-product-descriptions', category: 'writing', primary_tags: ['writing-ai','e-commerce'],       picks: ['copy-ai','jasper','anyword','writesonic','copysmith','hypotenuse-ai'] },
  { slug: 'ai-for-email-newsletters',   category: 'marketing', primary_tags: ['writing-ai','email-marketing'], picks: ['beehiiv','mailerlite','klaviyo','copy-ai','omnisend','mailchimp'] },
  { slug: 'ai-for-seo-content',         category: 'marketing', primary_tags: ['writing-ai','seo-marketing'],   picks: ['surfer-seo','frase','neuronwriter','scalenut','jasper','koala-ai'] },
  { slug: 'ai-for-headlines',           category: 'writing',  primary_tags: ['writing-ai'],                    picks: ['copy-ai','jasper','anyword','writesonic'] },

  // image/design
  { slug: 'ai-for-logo-design',         category: 'design',   primary_tags: ['image-ai','design'],             picks: ['looka','brandmark','logoai','designs-ai'] },
  { slug: 'ai-for-headshots',           category: 'design',   primary_tags: ['image-ai'],                      picks: ['aragon-ai','headshot-pro','photo-ai','secta-labs'] },
  { slug: 'ai-for-product-photos',      category: 'design',   primary_tags: ['image-ai','e-commerce'],         picks: ['photoroom','pebblely','booth-ai','flair-ai','claid-ai'] },
  { slug: 'ai-for-image-upscaling',     category: 'design',   primary_tags: ['image-ai'],                      picks: ['magnific','upscayl','topaz-photo-ai','krea-ai'] },

  // video
  { slug: 'ai-for-video-editing',       category: 'design',   primary_tags: ['video-ai'],                      picks: ['descript','runway','capcut','kapwing','veed-io','opus-clip'] },
  { slug: 'ai-for-video-subtitles',     category: 'design',   primary_tags: ['video-ai'],                      picks: ['kapwing','veed-io','descript','submagic','captions-ai'] },
  { slug: 'ai-for-talking-avatars',     category: 'design',   primary_tags: ['video-ai'],                      picks: ['heygen','synthesia','d-id','hour-one','colossyan'] },

  // voice/audio
  { slug: 'ai-for-voice-cloning',       category: 'design',   primary_tags: ['voice-audio'],                   picks: ['elevenlabs','play-ht','resemble-ai','murf-ai'] },
  { slug: 'ai-for-podcast-editing',     category: 'design',   primary_tags: ['voice-audio'],                   picks: ['descript','podcastle','riverside','auphonic','alitu'] },

  // code/dev
  { slug: 'ai-for-code-review',         category: 'dev',      primary_tags: ['code-ai'],                       picks: ['codium','sourcegraph','codacy','qodo','snyk'] },
  { slug: 'ai-for-debugging',           category: 'dev',      primary_tags: ['code-ai'],                       picks: ['cursor','copilot-microsoft','claude','sourcegraph','tabnine'] },
  { slug: 'ai-for-unit-tests',          category: 'dev',      primary_tags: ['code-ai'],                       picks: ['codium','copilot-microsoft','cursor','qodo'] },

  // marketing/sales
  { slug: 'ai-for-keyword-research',    category: 'marketing', primary_tags: ['seo-marketing'],                picks: ['surfer-seo','frase','keyword-insights','neuronwriter','scalenut'] },
  { slug: 'ai-for-ad-copy',             category: 'marketing', primary_tags: ['writing-ai'],                   picks: ['copy-ai','anyword','jasper','persado','adcreative-ai'] },

  // research / data
  { slug: 'ai-for-research-papers',     category: 'research', primary_tags: ['research'],                      picks: ['perplexity','elicit','scite','scispace','consensus'] },
  { slug: 'ai-for-data-analysis',       category: 'data-analytics', primary_tags: ['data-analytics'],          picks: ['julius-ai','akkio','polymer','deepnote','formula-bot'] },

  // productivity
  { slug: 'ai-for-note-taking',         category: 'productivity', primary_tags: ['productivity'],              picks: ['notion-ai','mem-ai','reflect','otter-ai','fathom'] },

  // hr-recruiting
  { slug: 'ai-for-resume-screening',    category: 'hr-recruiting', primary_tags: ['hr-recruiting'],            picks: ['eightfold','paradox-ai','fetcher','hiretual','manatal'] },

  // customer-success
  { slug: 'ai-for-chatbots',            category: 'customer-success', primary_tags: ['ai-assistants'],         picks: ['intercom','drift','ada-ai','tidio','manychat','chatfuel'] },
]

console.log(`=== Phase 1 batch 2: ${candidates.length} candidates ===\n`)

// Gate A: slug conflicts (tasks/tools/comparisons + TS files)
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
    console.log(`  ✗ ${c.slug.padEnd(36)} CONFLICT: ${conflicts.join(',')}`)
    aFail.push(c.slug)
  } else {
    console.log(`  ✓ ${c.slug}`)
    aPass.push(c.slug)
  }
}
console.log(`\nGate A: ${aPass.length}/${candidates.length} pass`)

// Gate B: mappability (>=3 valid picks in catalog)
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

// Summary
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
