// Phase 3 batch 1 candidates - target +30-35 mid-tail to push 200 -> 230+ (Phase 3 begins).
// Continue Tier-A cadence: 3-sentence intro + 1-sentence methodology + 3 FAQs.
// Long-tail across all 13 categories building on S97-S105 Mode D backfill.

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
  // CUSTOMER-SUCCESS expansion (13 -> 15)
  { slug: 'ai-for-customer-retention',     category: 'customer-success', primary_tags: ['customer-service'],          picks: ['gainsight','totango','churnzero','vitally','planhat','catalyst','custify'] },
  { slug: 'ai-for-account-expansion',      category: 'customer-success', primary_tags: ['customer-service'],          picks: ['gainsight','planhat','vitally','totango','catalyst'] },

  // HR-RECRUITING expansion (13 -> 18)
  { slug: 'ai-for-employee-feedback',      category: 'hr-recruiting',    primary_tags: ['hr'],                        picks: ['lattice','culture-amp','15five','officevibe','leapsome'] },
  { slug: 'ai-for-employee-surveys',       category: 'hr-recruiting',    primary_tags: ['hr'],                        picks: ['culture-amp','15five','lattice','qualtrics','glint'] },
  { slug: 'ai-for-pto-management',         category: 'hr-recruiting',    primary_tags: ['hr'],                        picks: ['rippling','bamboohr','lever','greenhouse'] },
  { slug: 'ai-for-job-interviews',         category: 'hr-recruiting',    primary_tags: ['hr'],                        picks: ['metaview','goodtime','ashby','greenhouse','lever'] },
  { slug: 'ai-for-onboarding-workflows',   category: 'hr-recruiting',    primary_tags: ['hr','automation'],           picks: ['rippling','bamboohr','sapling','lever','greenhouse'] },

  // OPS expansion (14 -> 18)
  { slug: 'ai-for-okr-tracking',           category: 'ops',              primary_tags: ['productivity','hr'],          picks: ['lattice','15five','culture-amp','leapsome','bamboohr'] },
  { slug: 'ai-for-it-tickets',             category: 'ops',              primary_tags: ['customer-service','automation'], picks: ['freshchat','zoho-desk','intercom','front-app','liveagent','zendesk'] },
  { slug: 'ai-for-process-documentation',  category: 'ops',              primary_tags: ['productivity','documentation'],  picks: ['notion-ai','coda','slab','guru','document360','gitbook','tettra'] },
  { slug: 'ai-for-supplier-onboarding',    category: 'ops',              primary_tags: ['productivity'],              picks: ['ironclad','oneflow','contractbook','juro'] },

  // SUPPORT expansion (13 -> 16)
  { slug: 'ai-for-knowledge-management',   category: 'support',          primary_tags: ['customer-service','documentation'], picks: ['guru','helpjuice','document360','slab','tettra','bloomfire','gitbook'] },
  { slug: 'ai-for-multilingual-support',   category: 'support',          primary_tags: ['translation','customer-service'], picks: ['crowdin','lokalise','transifex','unbabel','lilt'] },
  { slug: 'ai-for-help-articles',          category: 'support',          primary_tags: ['customer-service','writing-ai'], picks: ['helpjuice','document360','intercom','zoho-desk','front-app'] },

  // SALES expansion (15 -> 18)
  { slug: 'ai-for-sales-decks',            category: 'sales',            primary_tags: ['crm-sales','presentation'],  picks: ['gamma-app','beautiful-ai','pitch','decktopus','tome'] },
  { slug: 'ai-for-meeting-prep',           category: 'sales',            primary_tags: ['meeting-ai','crm-sales'],     picks: ['avoma','gong-io','grain','fireflies-ai','sembly-ai'] },
  { slug: 'ai-for-prospecting',            category: 'sales',            primary_tags: ['crm-sales','automation'],     picks: ['lavender','lemlist','smartlead','reply-io','instantly','clay'] },

  // MARKETING expansion (16 -> 20)
  { slug: 'ai-for-content-marketing',      category: 'marketing',        primary_tags: ['writing-ai','seo-ai'],         picks: ['jasper','copy-ai','writesonic','scalenut','frase'] },
  { slug: 'ai-for-podcast-marketing',      category: 'marketing',        primary_tags: ['social-media-ai'],            picks: ['castmagic','repurpose-io','swell-ai','descript','opus-clip'] },
  { slug: 'ai-for-webinar-promotion',      category: 'marketing',        primary_tags: ['marketing'],                  picks: ['hubspot','klaviyo','activecampaign','mailchimp','marketo'] },
  { slug: 'ai-for-marketing-emails',       category: 'marketing',        primary_tags: ['marketing'],                  picks: ['mailchimp','klaviyo','hubspot','activecampaign','beehiiv','mailerlite','omnisend'] },

  // WRITING expansion (22 -> 24)
  { slug: 'ai-for-rewriting',              category: 'writing',          primary_tags: ['writing-ai'],                 picks: ['quillbot','grammarly','wordtune','jasper','copy-ai'] },
  { slug: 'ai-for-paraphrasing',           category: 'writing',          primary_tags: ['writing-ai'],                 picks: ['quillbot','wordtune','grammarly','jasper','frase'] },

  // DESIGN expansion (15 -> 18)
  { slug: 'ai-for-illustrations',          category: 'design',           primary_tags: ['design'],                     picks: ['midjourney','leonardo-ai','ideogram','stable-diffusion','dall-e','flux','recraft'] },
  { slug: 'ai-for-thumbnails',             category: 'design',           primary_tags: ['design','social-media-ai'],   picks: ['canva','photoroom','picsart','midjourney','leonardo-ai'] },
  { slug: 'ai-for-explainer-videos',       category: 'design',           primary_tags: ['design','code-ai'],           picks: ['synthesia','heygen','d-id','runway','pika'] },

  // DATA-ANALYTICS expansion (14 -> 17)
  { slug: 'ai-for-data-storytelling',      category: 'data-analytics',   primary_tags: ['analytics'],                  picks: ['julius-ai','akkio','formula-bot','rows','deepnote','seek-ai'] },
  { slug: 'ai-for-product-analytics',      category: 'data-analytics',   primary_tags: ['analytics'],                  picks: ['pendo','userpilot','sprig','segment','plausible','heap','amplitude'] },
  { slug: 'ai-for-revenue-analytics',      category: 'data-analytics',   primary_tags: ['analytics'],                  picks: ['chartmogul','baremetrics','tableau','looker','mode'] },

  // DEV expansion (15 -> 16)
  { slug: 'ai-for-jupyter-notebooks',      category: 'dev',              primary_tags: ['code-ai','analytics'],         picks: ['deepnote','julius-ai','hex','observable','akkio'] },

  // PRODUCTIVITY expansion (24 -> 25)
  { slug: 'ai-for-meeting-followups',      category: 'productivity',     primary_tags: ['meeting-ai'],                 picks: ['grain','avoma','gong-io','fireflies-ai','fathom','sembly-ai'] },

  // RESEARCH expansion (13 -> 14)
  { slug: 'ai-for-research-questions',     category: 'research',         primary_tags: ['research'],                   picks: ['dovetail','maze','sprig','typeform','lookback','respondent','dscout'] },

  // FINANCE expansion (13 -> 15)
  { slug: 'ai-for-financial-statements',   category: 'finance',          primary_tags: ['finance'],                    picks: ['bench','zeni','pilot','docyt','quickbooks','xero'] },
  { slug: 'ai-for-month-end-close',        category: 'finance',          primary_tags: ['finance'],                    picks: ['bench','zeni','pilot','docyt','vic-ai'] },
]

console.log(`=== Phase 3 batch 1: ${candidates.length} candidates ===\n`)

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
    console.log(`  x ${c.slug.padEnd(45)} CONFLICT: ${conflicts.join(',')}`)
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
  console.log(`${c.slug.padEnd(45)} [${status}] ${found.length}/${c.picks.length}: ${found.join(',')}`)
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
