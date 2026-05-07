// Phase 3 batch 2 candidates - target +40-50 mid-tail to push 234 -> 280+ tasks.
// Continue Tier-A cadence: 3-sentence intro + 1-sentence methodology + 3 FAQs.
// Balanced spread across all 13 categories.

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
  // FINANCE expansion (15 -> 19)
  { slug: 'ai-for-tax-compliance',         category: 'finance',          primary_tags: ['finance'],                       picks: ['docyt','zeni','pilot','bench','vic-ai'] },
  { slug: 'ai-for-audit-prep',             category: 'finance',          primary_tags: ['finance'],                       picks: ['pilot','bench','docyt','zeni'] },
  { slug: 'ai-for-cfo-services',           category: 'finance',          primary_tags: ['finance'],                       picks: ['pilot','zeni','bench','docyt'] },
  { slug: 'ai-for-receipt-tracking',       category: 'finance',          primary_tags: ['finance'],                       picks: ['ramp','brex','airbase','expensify','rydoo'] },

  // CUSTOMER-SUCCESS expansion (15 -> 18)
  { slug: 'ai-for-csm-productivity',       category: 'customer-success', primary_tags: ['customer-service'],              picks: ['vitally','planhat','gainsight','catalyst','totango'] },
  { slug: 'ai-for-success-plans',          category: 'customer-success', primary_tags: ['customer-service'],              picks: ['gainsight','planhat','vitally','totango','churnzero'] },
  { slug: 'ai-for-onboarding-emails',      category: 'customer-success', primary_tags: ['customer-service','marketing'],   picks: ['intercom','hubspot','klaviyo','activecampaign','customer-io'] },

  // HR-RECRUITING expansion (18 -> 22)
  { slug: 'ai-for-employee-recognition',   category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['lattice','15five','culture-amp','leapsome','bonusly'] },
  { slug: 'ai-for-internal-mobility',      category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['eightfold','beamery','lattice','workday','rippling'] },
  { slug: 'ai-for-career-pathing',         category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['lattice','leapsome','culture-amp','15five','bamboohr'] },
  { slug: 'ai-for-job-offers',             category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['ashby','greenhouse','lever','rippling'] },

  // OPS expansion (18 -> 22)
  { slug: 'ai-for-business-intelligence',  category: 'ops',              primary_tags: ['analytics'],                     picks: ['tableau','looker','metabase','mode','rows','akkio'] },
  { slug: 'ai-for-runbooks',               category: 'ops',              primary_tags: ['productivity','documentation'],   picks: ['notion-ai','coda','slab','document360','guru'] },
  { slug: 'ai-for-reporting-automation',   category: 'ops',              primary_tags: ['analytics','automation'],         picks: ['rows','julius-ai','akkio','formula-bot','deepnote'] },
  { slug: 'ai-for-change-management',      category: 'ops',              primary_tags: ['productivity','documentation'],   picks: ['notion-ai','coda','slab','asana','monday'] },

  // SUPPORT expansion (16 -> 19)
  { slug: 'ai-for-csat-surveys',           category: 'support',          primary_tags: ['customer-service','research'],    picks: ['typeform','sprig','maze','dovetail'] },
  { slug: 'ai-for-canned-responses',       category: 'support',          primary_tags: ['customer-service'],               picks: ['intercom','front-app','zoho-desk','liveagent','freshchat'] },
  { slug: 'ai-for-customer-conversations', category: 'support',          primary_tags: ['customer-service'],               picks: ['intercom','front-app','gorgias','crisp','helpscout'] },

  // SALES expansion (18 -> 22)
  { slug: 'ai-for-account-research',       category: 'sales',            primary_tags: ['crm-sales'],                     picks: ['clay','apollo-io','zoominfo','lavender','reply-io'] },
  { slug: 'ai-for-sales-emails',           category: 'sales',            primary_tags: ['crm-sales','writing-ai'],         picks: ['lavender','lemlist','copy-ai','jasper','reply-io','smartlead'] },
  { slug: 'ai-for-deal-progression',       category: 'sales',            primary_tags: ['crm-sales','meeting-ai'],         picks: ['gong-io','modjo','avoma','salesforce-einstein'] },
  { slug: 'ai-for-revenue-intelligence',   category: 'sales',            primary_tags: ['crm-sales','analytics'],          picks: ['gong-io','modjo','clari','people-ai','outreach'] },

  // MARKETING expansion (20 -> 24)
  { slug: 'ai-for-marketing-funnels',      category: 'marketing',        primary_tags: ['marketing'],                     picks: ['hubspot','klaviyo','marketo','activecampaign','intercom'] },
  { slug: 'ai-for-customer-stories',       category: 'marketing',        primary_tags: ['marketing','writing-ai'],         picks: ['jasper','copy-ai','writesonic','frase'] },
  { slug: 'ai-for-newsletter-writing',     category: 'marketing',        primary_tags: ['writing-ai','marketing'],         picks: ['beehiiv','jasper','copy-ai','substack','convertkit'] },
  { slug: 'ai-for-product-launches',       category: 'marketing',        primary_tags: ['marketing'],                     picks: ['hubspot','klaviyo','activecampaign','beehiiv','mailchimp'] },

  // WRITING expansion (24 -> 27)
  { slug: 'ai-for-resumes',                category: 'writing',          primary_tags: ['writing-ai'],                    picks: ['jasper','copy-ai','grammarly','rytr','writesonic'] },
  { slug: 'ai-for-bullet-points',          category: 'writing',          primary_tags: ['writing-ai'],                    picks: ['jasper','copy-ai','grammarly','wordtune','quillbot'] },
  { slug: 'ai-for-amazon-listings',        category: 'writing',          primary_tags: ['writing-ai'],                    picks: ['copy-ai','jasper','anyword','writesonic','rytr'] },

  // DESIGN expansion (18 -> 21)
  { slug: 'ai-for-product-photos',         category: 'design',           primary_tags: ['design'],                        picks: ['photoroom','picsart','midjourney','flux','remove-bg'] },
  { slug: 'ai-for-stock-photos',           category: 'design',           primary_tags: ['design'],                        picks: ['midjourney','leonardo-ai','flux','dall-e','ideogram'] },
  { slug: 'ai-for-social-banners',         category: 'design',           primary_tags: ['design','social-media-ai'],       picks: ['canva','photoroom','picsart','midjourney','leonardo-ai'] },

  // DATA-ANALYTICS expansion (17 -> 20)
  { slug: 'ai-for-trend-analysis',         category: 'data-analytics',   primary_tags: ['analytics'],                     picks: ['julius-ai','akkio','formula-bot','rows','deepnote'] },
  { slug: 'ai-for-spreadsheet-formulas',   category: 'data-analytics',   primary_tags: ['analytics','productivity'],       picks: ['formula-bot','rows','julius-ai','akkio'] },
  { slug: 'ai-for-funnel-analysis',        category: 'data-analytics',   primary_tags: ['analytics'],                     picks: ['amplitude','heap','pendo','sprig','segment'] },

  // DEV expansion (16 -> 20)
  { slug: 'ai-for-code-comments',          category: 'dev',              primary_tags: ['code-ai'],                       picks: ['cursor','copilot-microsoft','aider','codeium','tabnine'] },
  { slug: 'ai-for-react-components',       category: 'dev',              primary_tags: ['code-ai','design'],               picks: ['vercel-v0','lovable','bolt','relume','uizard'] },
  { slug: 'ai-for-web-scraping',           category: 'dev',              primary_tags: ['code-ai','automation'],           picks: ['firecrawl','clay','apify','browse-ai'] },
  { slug: 'ai-for-mobile-app-design',      category: 'dev',              primary_tags: ['design','code-ai'],               picks: ['vercel-v0','lovable','bolt','uizard','galileo-ai'] },

  // PRODUCTIVITY expansion (25 -> 27)
  { slug: 'ai-for-todo-lists',             category: 'productivity',     primary_tags: ['productivity'],                  picks: ['todoist','asana','clickup','linear','notion-ai'] },
  { slug: 'ai-for-personal-assistants',    category: 'productivity',     primary_tags: ['productivity'],                  picks: ['claude','chatgpt','gemini','perplexity','poe'] },

  // RESEARCH expansion (14 -> 18)
  { slug: 'ai-for-survey-design',          category: 'research',         primary_tags: ['research'],                      picks: ['typeform','maze','dovetail','sprig','lookback'] },
  { slug: 'ai-for-user-interviews',        category: 'research',         primary_tags: ['research'],                      picks: ['dovetail','lookback','respondent','dscout','userlytics'] },
  { slug: 'ai-for-paper-summaries',        category: 'research',         primary_tags: ['research'],                      picks: ['julius-ai','jasper','copy-ai','perplexity','humata'] },
  { slug: 'ai-for-academic-citations',     category: 'research',         primary_tags: ['research'],                      picks: ['julius-ai','perplexity','humata','jasper'] },
]

console.log(`=== Phase 3 batch 2: ${candidates.length} candidates ===\n`)

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
