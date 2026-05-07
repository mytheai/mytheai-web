// Phase 2 batch 1 candidates - mid-tail tasks across underserved verticals + broadening.
// Tier-A editorial cadence (3-sentence intro, 1-sentence methodology, 3 FAQs per plan §6).

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
  // writing mid-tail
  { slug: 'ai-for-cover-letters',         category: 'writing', primary_tags: ['writing-ai'],                picks: ['jasper','copy-ai','writesonic','quillbot','grammarly'] },
  { slug: 'ai-for-press-releases',        category: 'writing', primary_tags: ['writing-ai'],                picks: ['jasper','copy-ai','anyword','writesonic','scalenut'] },
  { slug: 'ai-for-case-studies',          category: 'writing', primary_tags: ['writing-ai'],                picks: ['jasper','scalenut','copy-ai','anyword','writesonic'] },
  { slug: 'ai-for-tweets',                category: 'writing', primary_tags: ['writing-ai','social-media'], picks: ['jasper','copy-ai','taplio','typefully','hypefury'] },
  { slug: 'ai-for-linkedin-posts',        category: 'writing', primary_tags: ['writing-ai','social-media'], picks: ['taplio','jasper','copy-ai','hypefury','typefully'] },
  { slug: 'ai-for-instagram-captions',    category: 'writing', primary_tags: ['writing-ai','social-media'], picks: ['jasper','copy-ai','predis-ai','anyword','writesonic'] },
  { slug: 'ai-for-meta-descriptions',     category: 'writing', primary_tags: ['writing-ai','seo-marketing'], picks: ['surfer-seo','jasper','frase','scalenut','neuronwriter'] },
  { slug: 'ai-for-tagline-generation',    category: 'writing', primary_tags: ['writing-ai'],                picks: ['copy-ai','jasper','anyword','writesonic','hypotenuse-ai'] },
  { slug: 'ai-for-email-replies',         category: 'writing', primary_tags: ['writing-ai'],                picks: ['lavender','grammarly','notion-ai','copy-ai','jasper'] },
  { slug: 'ai-for-property-descriptions', category: 'writing', primary_tags: ['writing-ai'],                picks: ['jasper','copy-ai','anyword','writesonic','hypotenuse-ai'] },
  { slug: 'ai-for-job-postings',          category: 'hr-recruiting', primary_tags: ['writing-ai'],          picks: ['jasper','copy-ai','anyword','writesonic'] },

  // design mid-tail
  { slug: 'ai-for-pitch-decks',           category: 'design', primary_tags: ['design'],                     picks: ['gamma-app','beautiful-ai','decktopus','visme','slidebean'] },
  { slug: 'ai-for-mockup-generation',     category: 'design', primary_tags: ['design','code-ai'],           picks: ['uizard','galileo-ai','visily','v0','relume'] },
  { slug: 'ai-for-music-generation',      category: 'design', primary_tags: ['voice-audio'],                picks: ['suno','udio','mubert','soundraw'] },

  // productivity mid-tail
  { slug: 'ai-for-pdf-summarization',     category: 'productivity', primary_tags: ['productivity'],         picks: ['chatpdf','notion-ai','perplexity','humata','readwise'] },
  { slug: 'ai-for-meeting-agendas',       category: 'productivity', primary_tags: ['meeting-ai','productivity'], picks: ['fathom','fireflies-ai','avoma','notion-ai','sembly-ai'] },
  { slug: 'ai-for-action-items',          category: 'productivity', primary_tags: ['meeting-ai'],           picks: ['fathom','fireflies-ai','otter-ai','avoma','sembly-ai'] },
  { slug: 'ai-for-meeting-minutes',       category: 'productivity', primary_tags: ['meeting-ai'],           picks: ['fathom','fireflies-ai','otter-ai','avoma','notion-ai'] },
  { slug: 'ai-for-calendar-management',   category: 'productivity', primary_tags: ['productivity'],         picks: ['motion','reclaim-ai','cal-com'] },
  { slug: 'ai-for-journaling',            category: 'productivity', primary_tags: ['productivity'],         picks: ['mem-ai','reflect','notion-ai'] },

  // dev mid-tail
  { slug: 'ai-for-code-explanation',      category: 'dev', primary_tags: ['code-ai'],                       picks: ['claude','copilot-microsoft','cursor','tabnine','codeium'] },
  { slug: 'ai-for-code-refactoring',      category: 'dev', primary_tags: ['code-ai'],                       picks: ['cursor','copilot-microsoft','claude','tabnine','codeium'] },
  { slug: 'ai-for-regex',                 category: 'dev', primary_tags: ['code-ai'],                       picks: ['claude','copilot-microsoft','cursor','formula-bot'] },
  { slug: 'ai-for-database-queries',      category: 'dev', primary_tags: ['code-ai','data-analytics'],      picks: ['julius-ai','seek-ai','outerbase','formula-bot','akkio'] },

  // healthcare vertical (well-stocked from prior tiers)
  { slug: 'ai-for-clinical-notes',        category: 'productivity', primary_tags: ['ai-assistants'],        picks: ['heidi-health','freed-ai','abridge','ambience-healthcare','suki-ai','nuance-dax','deepscribe'] },
  { slug: 'ai-for-medical-scribes',       category: 'productivity', primary_tags: ['ai-assistants'],        picks: ['heidi-health','freed-ai','abridge','ambience-healthcare','suki-ai','nuance-dax','deepscribe'] },

  // legal vertical (S102/S104 stocked)
  { slug: 'ai-for-contract-drafting',     category: 'ops', primary_tags: ['writing-ai'],                    picks: ['ironclad','contractbook','harvey-ai','draftwise','spellbook-ai','juro','oneflow'] },
  { slug: 'ai-for-contract-review',       category: 'ops', primary_tags: ['writing-ai'],                    picks: ['ironclad','zuva','draftwise','harvey-ai','spellbook-ai'] },
  { slug: 'ai-for-legal-research',        category: 'research', primary_tags: ['research'],                 picks: ['harvey-ai','spellbook-ai','perplexity'] },

  // education vertical (S103/S104 stocked)
  { slug: 'ai-for-essay-writing',         category: 'writing', primary_tags: ['writing-ai'],                picks: ['jasper','copy-ai','quillbot','grammarly','writesonic'] },
  { slug: 'ai-for-quiz-generation',       category: 'productivity', primary_tags: ['productivity'],         picks: ['mentimeter','conker','edpuzzle-ai','curipod','classpoint'] },
  { slug: 'ai-for-lesson-plans',          category: 'productivity', primary_tags: ['productivity'],         picks: ['curipod','diffit','magicschool-ai','almanack-ai','brisk-teaching'] },
  { slug: 'ai-for-tutoring',              category: 'productivity', primary_tags: ['ai-assistants'],        picks: ['khanmigo','synthesis-tutor','almanack-ai','photomath'] },

  // CS/support mid-tail
  { slug: 'ai-for-ticket-classification', category: 'support', primary_tags: ['ai-assistants'],             picks: ['zendesk','freshdesk','intercom','forethought','freshchat'] },
  { slug: 'ai-for-faq-generation',        category: 'support', primary_tags: ['ai-assistants'],             picks: ['zendesk','freshdesk','notion-ai','document360','intercom'] },
  { slug: 'ai-for-churn-prediction',      category: 'customer-success', primary_tags: ['data-analytics'],   picks: ['gainsight','totango','vitally','catalyst','planhat','custify'] },

  // HR (eightfold/lever stock)
  { slug: 'ai-for-recruiting',            category: 'hr-recruiting', primary_tags: ['hr-recruiting'],       picks: ['eightfold','lever','beamery','ashby','metaview','greenhouse','goodtime'] },

  // research mid-tail
  { slug: 'ai-for-academic-writing',      category: 'research', primary_tags: ['research','writing-ai'],    picks: ['jasper','elicit','perplexity','scispace','quillbot'] },
  { slug: 'ai-for-citation-management',   category: 'research', primary_tags: ['research'],                 picks: ['scispace','elicit','perplexity','consensus'] },

  // data-analytics mid-tail
  { slug: 'ai-for-data-cleaning',         category: 'data-analytics', primary_tags: ['data-analytics'],     picks: ['julius-ai','formula-bot','rows','deepnote'] },
  { slug: 'ai-for-data-visualization',    category: 'data-analytics', primary_tags: ['data-analytics'],     picks: ['julius-ai','tableau','metabase','looker','rows','deepnote'] },
]

console.log(`=== Phase 2 batch 1: ${candidates.length} candidates ===\n`)

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
    aPass.push(c.slug)
  }
}
console.log(`Gate A: ${aPass.length}/${candidates.length} pass`)

console.log('\n=== GATE B: mappability ===\n')
const results = []
for (const c of candidates) {
  if (aFail.includes(c.slug)) continue
  const { rows } = await client.query(
    `SELECT slug, name, rating, review_count, tags FROM tools WHERE slug = ANY($1::text[]) ORDER BY rating DESC NULLS LAST, review_count DESC NULLS LAST`,
    [c.picks]
  )
  const found = rows.map(r => r.slug)
  const status = found.length >= 3 ? 'PASS' : 'FAIL'
  console.log(`${c.slug.padEnd(40)} [${status}] ${found.length}/${c.picks.length}: ${found.join(',')}`)
  results.push({ ...c, found, valid_picks: rows.slice(0, 5).map(r => r.slug), gate_b: status })
}

console.log('\n=== SUMMARY ===')
const pass = results.filter(r => r.gate_b === 'PASS')
const fail = results.filter(r => r.gate_b === 'FAIL')
console.log(`PASS (${pass.length}): ${pass.map(r => r.slug).join(', ')}`)
console.log(`FAIL (${fail.length}): ${fail.map(r => r.slug).join(', ')}`)

console.log('\n=== FINAL VALID PICKS ===')
for (const r of pass) {
  console.log(`${r.slug}: [${r.valid_picks.join(',')}] (cat:${r.category}, tags:${r.primary_tags.join(',')})`)
}

await client.end()
