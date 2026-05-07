// Phase 2 batch 2 candidates - mid-tail tasks across underserved verticals
// (finance, customer-success, sales, marketing-ops, e-commerce, dev, support).
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
  // FINANCE expansion (only 3 tasks pre-batch)
  { slug: 'ai-for-financial-reporting',  category: 'finance',          primary_tags: ['finance'],                       picks: ['zeni','pilot','bench','baremetrics','ramp'] },
  { slug: 'ai-for-accounts-payable',     category: 'finance',          primary_tags: ['finance'],                       picks: ['tipalti','stampli','ramp','vic-ai','airbase'] },
  { slug: 'ai-for-tax-preparation',      category: 'finance',          primary_tags: ['finance'],                       picks: ['bench','pilot','zeni','docyt'] },
  { slug: 'ai-for-budgeting',            category: 'finance',          primary_tags: ['finance'],                       picks: ['ramp','brex','airbase','baremetrics'] },

  // HR-RECRUITING expansion (only 2 tasks pre-batch)
  { slug: 'ai-for-payroll',              category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['rippling','bamboohr','gusto'] },
  { slug: 'ai-for-employee-onboarding',  category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['rippling','bamboohr','lattice','culture-amp','workday'] },
  { slug: 'ai-for-performance-reviews',  category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['lattice','culture-amp','15five','leapsome'] },

  // MARKETING-OPS expansion (only 7 tasks pre-batch)
  { slug: 'ai-for-survey-creation',      category: 'data-analytics',   primary_tags: ['research','productivity'],       picks: ['typeform','sprig','dovetail','maze','lookback'] },
  { slug: 'ai-for-brand-voice',          category: 'marketing',        primary_tags: ['writing-ai'],                    picks: ['jasper','copy-ai','anyword','writesonic','hypotenuse-ai'] },
  { slug: 'ai-for-content-strategy',     category: 'marketing',        primary_tags: ['seo-marketing','writing-ai'],    picks: ['surfer-seo','frase','scalenut','jasper','copy-ai'] },
  { slug: 'ai-for-event-marketing',      category: 'marketing',        primary_tags: ['email-marketing'],               picks: ['hubspot','klaviyo','mailerlite','activecampaign'] },
  { slug: 'ai-for-influencer-marketing', category: 'marketing',        primary_tags: ['social-media'],                  picks: ['creatoriq','contentstudio','taplio','hypefury','agorapulse'] },

  // CUSTOMER-SUCCESS expansion (only 4 tasks pre-batch)
  { slug: 'ai-for-account-management',         category: 'customer-success', primary_tags: ['customer-service'],         picks: ['gainsight','totango','vitally','planhat','custify'] },
  { slug: 'ai-for-renewal-management',         category: 'customer-success', primary_tags: ['customer-service'],         picks: ['gainsight','totango','vitally','churnzero'] },
  { slug: 'ai-for-customer-segmentation',      category: 'marketing',        primary_tags: ['email-marketing','crm-sales'], picks: ['hubspot','klaviyo','intercom','salesforce-einstein','activecampaign'] },
  { slug: 'ai-for-nps-tracking',               category: 'customer-success', primary_tags: ['research'],                 picks: ['typeform','sprig','dovetail','maze'] },
  { slug: 'ai-for-customer-health-scores',     category: 'customer-success', primary_tags: ['customer-service'],         picks: ['gainsight','totango','vitally','planhat','catalyst'] },

  // SALES expansion (only 5 tasks pre-batch)
  { slug: 'ai-for-sales-forecasting',    category: 'sales',            primary_tags: ['crm-sales'],                     picks: ['gong-io','hubspot','salesforce-einstein','clari','close-crm'] },
  { slug: 'ai-for-deal-summaries',       category: 'sales',            primary_tags: ['meeting-tools','crm-sales'],     picks: ['gong-io','modjo','avoma','sembly-ai','fathom'] },
  { slug: 'ai-for-sales-coaching',       category: 'sales',            primary_tags: ['crm-sales'],                     picks: ['gong-io','modjo','avoma','lavender'] },
  { slug: 'ai-for-cpq',                  category: 'sales',            primary_tags: ['crm-sales'],                     picks: ['pandadoc','qwilr','proposify','dealhub','loopio'] },

  // DEV expansion
  { slug: 'ai-for-test-generation',      category: 'dev',              primary_tags: ['code-ai'],                       picks: ['cursor','copilot-microsoft','claude','cline','supermaven'] },
  { slug: 'ai-for-documentation',        category: 'dev',              primary_tags: ['code-ai','writing-ai'],          picks: ['claude','copilot-microsoft','gitbook','document360','notion-ai'] },
  { slug: 'ai-for-pair-programming',     category: 'dev',              primary_tags: ['code-ai'],                       picks: ['cursor','copilot-microsoft','claude','cline','supermaven'] },

  // DATA-ANALYTICS expansion
  { slug: 'ai-for-bi-reports',           category: 'data-analytics',   primary_tags: ['analytics'],                     picks: ['tableau','metabase','looker','julius-ai','rows'] },
  { slug: 'ai-for-survey-analysis',      category: 'data-analytics',   primary_tags: ['research'],                      picks: ['dovetail','sprig','lookback','maze'] },

  // RESEARCH expansion
  { slug: 'ai-for-market-research',      category: 'research',         primary_tags: ['research'],                      picks: ['perplexity','elicit','scispace','consensus','julius-ai'] },
  { slug: 'ai-for-competitive-analysis', category: 'research',         primary_tags: ['research'],                      picks: ['perplexity','claude','julius-ai','elicit'] },
  { slug: 'ai-for-data-collection',      category: 'research',         primary_tags: ['research'],                      picks: ['typeform','sprig','dovetail','maze'] },

  // PRODUCTIVITY/OPS expansion
  { slug: 'ai-for-standup-summaries',    category: 'productivity',     primary_tags: ['meeting-tools','productivity'],  picks: ['notion-ai','fathom','fireflies-ai','sembly-ai','otter-ai'] },
  { slug: 'ai-for-project-status-reports', category: 'productivity',   primary_tags: ['project-management'],            picks: ['monday','asana','clickup','notion-ai','linear'] },
  { slug: 'ai-for-personal-knowledge',   category: 'productivity',     primary_tags: ['note-taking'],                   picks: ['mem-ai','reflect','notion-ai','readwise','tana'] },

  // E-COMMERCE expansion
  { slug: 'ai-for-product-listings',     category: 'writing',          primary_tags: ['writing-ai','ecommerce'],        picks: ['jasper','copy-ai','anyword','hypotenuse-ai','writesonic'] },
  { slug: 'ai-for-shopify',              category: 'marketing',        primary_tags: ['ecommerce'],                     picks: ['shopify-magic','gorgias','klaviyo','omnisend'] },

  // SUPPORT expansion
  { slug: 'ai-for-customer-routing',     category: 'support',          primary_tags: ['customer-service'],              picks: ['zendesk','freshdesk','intercom','front-app','gladly'] },
  { slug: 'ai-for-feedback-categorization', category: 'support',       primary_tags: ['research','customer-service'],   picks: ['typeform','dovetail','sprig','maze'] },
  { slug: 'ai-for-live-chat',            category: 'support',          primary_tags: ['customer-service'],              picks: ['intercom','drift','tidio','gladly','freshchat'] },

  // WRITING expansion
  { slug: 'ai-for-bios',                 category: 'writing',          primary_tags: ['writing-ai'],                    picks: ['jasper','copy-ai','anyword','writesonic'] },
  { slug: 'ai-for-podcast-scripts',      category: 'writing',          primary_tags: ['writing-ai','voice-audio'],      picks: ['descript','podcastle','riverside','jasper','copy-ai'] },
  { slug: 'ai-for-youtube-scripts',      category: 'writing',          primary_tags: ['writing-ai','video-ai'],         picks: ['jasper','copy-ai','opus-clip','descript'] },

  // DESIGN expansion
  { slug: 'ai-for-style-guides',         category: 'design',           primary_tags: ['design','writing-ai'],           picks: ['jasper','claude','copy-ai','anyword'] },
  { slug: 'ai-for-graphic-design',       category: 'design',           primary_tags: ['design','image-ai'],              picks: ['canva','picsart','photoroom','remove-bg'] },
]

console.log(`=== Phase 2 batch 2: ${candidates.length} candidates ===\n`)

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
