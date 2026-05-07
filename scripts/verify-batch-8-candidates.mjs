// Phase 2 batch 4 candidates - target +23 to push 177 → 200 hit Phase 2 target.
// Mid-tail across well-stocked categories from S97-S105 Mode D.
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
  // FINANCE expansion (10 -> 13)
  { slug: 'ai-for-finance-automation',     category: 'finance',          primary_tags: ['finance'],                       picks: ['ramp','brex','airbase','tipalti','vic-ai','bench','zeni','docyt'] },
  { slug: 'ai-for-corporate-cards',        category: 'finance',          primary_tags: ['finance'],                       picks: ['ramp','brex','airbase'] },
  { slug: 'ai-for-vendor-payments',        category: 'finance',          primary_tags: ['finance'],                       picks: ['tipalti','airbase','stampli','ramp','brex','vic-ai'] },

  // CUSTOMER-SUCCESS expansion (11 -> 13)
  { slug: 'ai-for-quarterly-business-reviews', category: 'customer-success', primary_tags: ['customer-service'],          picks: ['gainsight','planhat','vitally','totango','catalyst','churnzero'] },
  { slug: 'ai-for-customer-journey-mapping',   category: 'customer-success', primary_tags: ['customer-service'],          picks: ['gainsight','planhat','vitally','custify','akita'] },

  // HR-RECRUITING expansion (11 -> 13)
  { slug: 'ai-for-resume-screening',       category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['ashby','greenhouse','lever','bamboohr','eightfold','beamery','rippling'] },
  { slug: 'ai-for-candidate-sourcing',     category: 'hr-recruiting',    primary_tags: ['hr'],                            picks: ['beamery','eightfold','lever','greenhouse','ashby','metaview','goodtime'] },

  // OPS expansion (11 -> 14, biggest catch-up)
  { slug: 'ai-for-ops-automation',         category: 'ops',              primary_tags: ['automation','productivity'],     picks: ['n8n','zapier','make','workato','tray-io','integrately','albato'] },
  { slug: 'ai-for-document-workflow',      category: 'ops',              primary_tags: ['productivity'],                  picks: ['docusign-ai','pandadoc','adobe-sign','ironclad','oneflow','contractbook','juro'] },
  { slug: 'ai-for-rfp-management',         category: 'ops',              primary_tags: ['productivity'],                  picks: ['loopio','qwilr','dealhub','pandadoc','better-proposals'] },

  // SUPPORT expansion (11 -> 13)
  { slug: 'ai-for-conversation-summaries', category: 'support',          primary_tags: ['meeting-ai','customer-service'], picks: ['gong-io','modjo','fireflies-ai','otter-ai','avoma','sembly-ai','fathom'] },
  { slug: 'ai-for-support-analytics',      category: 'support',          primary_tags: ['customer-service','analytics'],  picks: ['intercom','zoho-desk','front-app','groove','freshchat','liveagent','helpjuice'] },

  // DATA-ANALYTICS expansion (12 -> 14)
  { slug: 'ai-for-data-modeling',          category: 'data-analytics',   primary_tags: ['analytics'],                     picks: ['rows','deepnote','julius-ai','akkio','formula-bot','hal9','seek-ai'] },
  { slug: 'ai-for-customer-analytics',     category: 'data-analytics',   primary_tags: ['analytics'],                     picks: ['chartmogul','baremetrics','segment','plausible','formula-bot','akkio','sprig'] },

  // RESEARCH expansion (12 -> 13)
  { slug: 'ai-for-research-synthesis',     category: 'research',         primary_tags: ['research'],                      picks: ['dovetail','maze','sprig','lookback','respondent','dscout'] },

  // DESIGN expansion (14 -> 15)
  { slug: 'ai-for-website-design',         category: 'design',           primary_tags: ['design','code-ai'],               picks: ['framer','relume','lovable','vercel-v0','bolt','uizard','visily','galileo-ai'] },

  // DEV expansion (13 -> 15)
  { slug: 'ai-for-llm-orchestration',      category: 'dev',              primary_tags: ['code-ai','automation'],           picks: ['dify','flowise','langflow','langsmith','together-ai','crewai'] },
  { slug: 'ai-for-ai-agents',              category: 'dev',              primary_tags: ['code-ai','automation'],           picks: ['crewai','dify','langflow','agentops','wordware','devin-ai','cline'] },

  // SALES expansion (14 -> 15)
  { slug: 'ai-for-discovery-calls',        category: 'sales',            primary_tags: ['meeting-ai','crm-sales'],         picks: ['gong-io','modjo','avoma','fireflies-ai','fathom','sembly-ai'] },

  // MARKETING expansion (15 -> 16)
  { slug: 'ai-for-content-distribution',   category: 'marketing',        primary_tags: ['social-media-ai'],                picks: ['hootsuite','publer','planable','contentstudio','sprinklr','agorapulse','loomly','metricool','vista-social'] },

  // WRITING expansion (20 -> 22)
  { slug: 'ai-for-creative-writing',       category: 'writing',          primary_tags: ['writing-ai'],                     picks: ['sudowrite','jasper','copy-ai','writesonic','novelai'] },
  { slug: 'ai-for-email-subject-lines',    category: 'writing',          primary_tags: ['writing-ai'],                     picks: ['jasper','copy-ai','anyword','writesonic','frase'] },

  // PRODUCTIVITY expansion (23 -> 24)
  { slug: 'ai-for-task-management',        category: 'productivity',     primary_tags: ['productivity'],                   picks: ['asana','monday','clickup','linear','notion-ai','todoist','trello'] },
]

console.log(`=== Phase 2 batch 4: ${candidates.length} candidates ===\n`)

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
