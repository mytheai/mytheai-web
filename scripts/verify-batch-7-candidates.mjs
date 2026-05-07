// Phase 2 batch 3 candidates - target underserved verticals + retry deferred S118
// (ops, hr-recruiting, finance, customer-success, support, data-analytics, research,
// sales, dev, marketing, design, productivity).
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
  // OPS expansion (only 4 tasks pre-batch - lowest of all 13 categories)
  { slug: 'ai-for-vendor-management',     category: 'ops',              primary_tags: ['productivity'],                  picks: ['ironclad','juro','contractbook','oneflow','pandadoc'] },
  { slug: 'ai-for-procurement',           category: 'ops',              primary_tags: ['finance'],                       picks: ['ramp','brex','airbase','tipalti','vic-ai'] },
  { slug: 'ai-for-spend-analysis',        category: 'ops',              primary_tags: ['finance'],                       picks: ['ramp','brex','airbase','vic-ai','baremetrics'] },
  { slug: 'ai-for-policy-management',     category: 'ops',              primary_tags: ['note-taking'],                   picks: ['notion-ai','document360','gitbook','slab','slite'] },
  { slug: 'ai-for-business-process',      category: 'ops',              primary_tags: ['automation','productivity'],     picks: ['n8n','zapier','make','workato','integrately'] },
  { slug: 'ai-for-contract-negotiation',  category: 'ops',              primary_tags: ['productivity'],                  picks: ['ironclad','juro','draftwise','spellbook-ai','contractbook'] },
  { slug: 'ai-for-internal-audit',        category: 'ops',              primary_tags: ['analytics'],                     picks: ['secureframe','aikido-security','wiz','orca-security'] },

  // HR-RECRUITING expansion (5 pre-batch, second-lowest)
  { slug: 'ai-for-employee-engagement',   category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['lattice','culture-amp','15five','workday'] },
  { slug: 'ai-for-hr-analytics',          category: 'hr-recruiting',    primary_tags: ['hr','analytics'],                picks: ['lattice','culture-amp','workday','rippling','bamboohr'] },
  { slug: 'ai-for-learning-development',  category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['docebo','talentlms','ispring','360learning','litmos'] },
  { slug: 'ai-for-time-tracking',         category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['rippling','gusto','bamboohr','clockify'] },
  { slug: 'ai-for-1-on-1s',               category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['lattice','15five','culture-amp','leapsome'] },
  { slug: 'ai-for-talent-acquisition',    category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['greenhouse','lever','workday','ashby','eightfold'] },

  // FINANCE expansion (7 pre-batch)
  { slug: 'ai-for-cash-flow',             category: 'finance',          primary_tags: ['finance'],                       picks: ['ramp','brex','baremetrics','airbase','pilot'] },
  { slug: 'ai-for-spend-management',      category: 'finance',          primary_tags: ['finance'],                       picks: ['ramp','brex','airbase','vic-ai','tipalti'] },
  { slug: 'ai-for-financial-close',       category: 'finance',          primary_tags: ['finance'],                       picks: ['pilot','bench','zeni','docyt','baremetrics'] },

  // CUSTOMER-SUCCESS expansion (8 pre-batch)
  { slug: 'ai-for-product-adoption',      category: 'customer-success', primary_tags: ['customer-service'],              picks: ['pendo','userpilot','intercom','gainsight'] },
  { slug: 'ai-for-customer-advocacy',     category: 'customer-success', primary_tags: ['customer-service'],              picks: ['gainsight','vitally','planhat','totango','custify'] },
  { slug: 'ai-for-cs-playbooks',          category: 'customer-success', primary_tags: ['customer-service'],              picks: ['gainsight','vitally','planhat','totango','catalyst'] },

  // SUPPORT expansion (8 pre-batch)
  { slug: 'ai-for-self-service',          category: 'support',          primary_tags: ['customer-service'],              picks: ['zendesk','freshdesk','intercom','document360','helpjuice'] },
  { slug: 'ai-for-agent-assistance',      category: 'support',          primary_tags: ['customer-service'],              picks: ['zendesk','freshdesk','intercom','forethought','gladly'] },
  { slug: 'ai-for-call-center',           category: 'support',          primary_tags: ['customer-service'],              picks: ['zendesk','intercom','freshdesk','dialpad','aircall'] },

  // DATA-ANALYTICS expansion (9 pre-batch)
  { slug: 'ai-for-anomaly-detection',     category: 'data-analytics',   primary_tags: ['analytics'],                     picks: ['tableau','looker','metabase','akkio','julius-ai'] },
  { slug: 'ai-for-cohort-analysis',       category: 'data-analytics',   primary_tags: ['analytics'],                     picks: ['tableau','looker','metabase','julius-ai','rows'] },
  { slug: 'ai-for-predictive-analytics',  category: 'data-analytics',   primary_tags: ['analytics'],                     picks: ['akkio','obviously-ai','tableau','metabase','seek-ai'] },

  // RESEARCH expansion (9 pre-batch)
  { slug: 'ai-for-interview-analysis',    category: 'research',         primary_tags: ['research'],                      picks: ['dovetail','sprig','lookback','dscout','respondent'] },
  { slug: 'ai-for-deep-research',         category: 'research',         primary_tags: ['research'],                      picks: ['perplexity','claude','elicit','scispace','julius-ai'] },
  { slug: 'ai-for-survey-summarization',  category: 'research',         primary_tags: ['research'],                      picks: ['dovetail','sprig','typeform','maze','lookback'] },

  // SALES expansion (9 pre-batch)
  { slug: 'ai-for-rev-ops',               category: 'sales',            primary_tags: ['crm-sales'],                     picks: ['gong-io','clari','salesforce-einstein','hubspot','close-crm'] },
  { slug: 'ai-for-sales-enablement',      category: 'sales',            primary_tags: ['crm-sales'],                     picks: ['gong-io','qwilr','pandadoc','proposify','dealhub'] },
  { slug: 'ai-for-territory-planning',    category: 'sales',            primary_tags: ['crm-sales'],                     picks: ['hubspot','salesforce-einstein','clari','close-crm'] },
  { slug: 'ai-for-pipeline-management',   category: 'sales',            primary_tags: ['crm-sales'],                     picks: ['hubspot','salesforce-einstein','clari','close-crm','pipedrive'] },

  // DEV expansion (10 pre-batch)
  { slug: 'ai-for-code-search',           category: 'dev',              primary_tags: ['code-ai'],                       picks: ['cursor','copilot-microsoft','claude','supermaven','cline'] },
  { slug: 'ai-for-bug-fixing',            category: 'dev',              primary_tags: ['code-ai'],                       picks: ['cursor','copilot-microsoft','claude','cline','codium'] },
  { slug: 'ai-for-devops',                category: 'dev',              primary_tags: ['code-ai'],                       picks: ['copilot-microsoft','claude','cursor','cline'] },

  // MARKETING expansion (13 pre-batch)
  { slug: 'ai-for-landing-pages',         category: 'marketing',        primary_tags: ['writing-ai'],                    picks: ['jasper','copy-ai','anyword','framer','writesonic'] },
  { slug: 'ai-for-marketing-attribution', category: 'marketing',        primary_tags: ['analytics'],                     picks: ['hubspot','salesforce-einstein','plausible'] },

  // DESIGN expansion (12 pre-batch)
  { slug: 'ai-for-ui-design',             category: 'design',           primary_tags: ['design'],                        picks: ['uizard','galileo-ai','visily','v0','relume'] },
  { slug: 'ai-for-icon-generation',       category: 'design',           primary_tags: ['image-ai'],                      picks: ['midjourney','leonardo-ai','ideogram','picsart'] },
  { slug: 'ai-for-color-palettes',        category: 'design',           primary_tags: ['design'],                        picks: ['canva','adobe-firefly','figma-ai','khroma'] },

  // PRODUCTIVITY expansion (22 pre-batch, lighter)
  { slug: 'ai-for-research-summaries',    category: 'productivity',     primary_tags: ['research','productivity'],       picks: ['perplexity','claude','elicit','scispace','julius-ai'] },
  { slug: 'ai-for-pitch-emails',          category: 'sales',            primary_tags: ['crm-sales','writing-ai'],        picks: ['lavender','lemlist','jasper','copy-ai','smartlead'] },
]

console.log(`=== Phase 2 batch 3: ${candidates.length} candidates ===\n`)

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
