// Gate B for tasks-batch-12 (S126 Phase 3 batch 4): verify each task slug has >=3 mappable tools.
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
  // === RESEARCH (5) ===
  'ai-for-customer-interviews': ['dovetail', 'lookback', 'respondent', 'userlytics', 'maze'],
  'ai-for-research-tagging': ['dovetail', 'maze', 'sprig', 'lookback'],
  'ai-for-user-journey-mapping': ['dovetail', 'sprig', 'optimal-workshop', 'maze'],
  'ai-for-qualitative-coding': ['dovetail', 'maze', 'lookback', 'sprig'],
  'ai-for-research-recruiting': ['respondent', 'userlytics', 'dscout', 'dovetail'],
  // === CUSTOMER-SUCCESS (5) ===
  'ai-for-customer-engagement': ['intercom', 'gainsight', 'vitally', 'planhat'],
  'ai-for-customer-insights': ['intercom', 'dovetail', 'sprig', 'gainsight'],
  'ai-for-success-dashboards': ['gainsight', 'vitally', 'planhat', 'totango'],
  'ai-for-customer-research': ['dovetail', 'sprig', 'lookback', 'maze'],
  'ai-for-onboarding-tracking': ['userpilot', 'pendo', 'gainsight', 'vitally'],
  // === FINANCE (5) ===
  'ai-for-financial-projections': ['pilot', 'bench', 'zeni', 'docyt', 'airbase'],
  'ai-for-investor-updates': ['pilot', 'bench', 'zeni', 'docyt'],
  'ai-for-board-prep': ['pilot', 'bench', 'zeni', 'docyt'],
  'ai-for-saas-metrics': ['chartmogul', 'baremetrics', 'profitwell'],
  'ai-for-billing-reconciliation': ['tipalti', 'airbase', 'pandadoc', 'docyt'],
  // === DEV (3) ===
  'ai-for-code-review-comments': ['cursor', 'copilot-microsoft', 'codeium', 'replit', 'tabnine'],
  'ai-for-dev-onboarding': ['cursor', 'copilot-microsoft', 'replit', 'codeium'],
  'ai-for-shell-scripts': ['cursor', 'copilot-microsoft', 'codeium', 'replit'],
  // === SUPPORT (4) ===
  'ai-for-support-routing': ['gorgias', 'intercom', 'freshchat', 'zoho-desk'],
  'ai-for-help-center': ['document360', 'intercom', 'gorgias', 'zoho-desk', 'helpjuice'],
  'ai-for-support-quality-assurance': ['intercom', 'zoho-desk', 'gorgias', 'freshchat'],
  'ai-for-faq-bots': ['intercom', 'forethought', 'freshchat', 'capacity'],
  // === HR-RECRUITING (5) ===
  'ai-for-employee-development': ['lattice', 'culture-amp', '15five'],
  'ai-for-job-descriptions': ['notion-ai', 'copy-ai', 'jasper', 'writesonic'],
  'ai-for-promotion-decisions': ['lattice', 'culture-amp', '15five', 'eightfold'],
  'ai-for-360-feedback': ['lattice', 'culture-amp', '15five'],
  'ai-for-talent-pipeline': ['eightfold', 'beamery', 'lever', 'greenhouse', 'ashby'],
  'ai-for-employee-coaching': ['lattice', 'culture-amp', '15five'],
  // === OPS (5) ===
  'ai-for-knowledge-transfer': ['notion-ai', 'coda', 'document360', 'gitbook', 'guru'],
  'ai-for-meeting-coordination': ['cal-com', 'reclaim-ai', 'sunsama', 'motion'],
  'ai-for-purchase-orders': ['airbase', 'ramp', 'brex', 'tipalti'],
  'ai-for-vendor-onboarding': ['airbase', 'ramp', 'brex', 'tipalti'],
  'ai-for-asset-management': ['notion-ai', 'airtable', 'coda'],
  // === DESIGN (3) ===
  'ai-for-color-palettes': ['figma', 'canva-ai', 'adobe-firefly'],
  'ai-for-design-systems': ['figma', 'uizard', 'penpot'],
  'ai-for-app-icons': ['figma', 'canva-ai', 'adobe-firefly', 'midjourney'],
  // === DATA-ANALYTICS (3) ===
  'ai-for-marketing-analytics': ['hubspot', 'klaviyo', 'intercom', 'activecampaign'],
  'ai-for-spreadsheet-analysis': ['julius-ai', 'formula-bot', 'akkio', 'seek-ai', 'outerbase'],
  'ai-for-sales-analytics': ['gong-io', 'clari', 'modjo', 'avoma'],
  // === SALES (5) ===
  'ai-for-sales-meetings': ['gong-io', 'avoma', 'modjo', 'sembly-ai', 'fireflies-ai'],
  'ai-for-sales-onboarding': ['gong-io', 'lavender', 'modjo', 'avoma'],
  'ai-for-sales-content': ['gamma-app', 'storydoc', 'qwilr', 'pitch'],
  'ai-for-quote-generation': ['dealhub', 'loopio', 'qwilr', 'pandadoc'],
  'ai-for-deal-rooms': ['storydoc', 'qwilr', 'gamma-app', 'pitch'],
  // === MARKETING (5) ===
  'ai-for-content-ideas': ['jasper', 'copy-ai', 'writesonic', 'anyword', 'rytr'],
  'ai-for-marketing-personas': ['hubspot', 'klaviyo', 'intercom'],
  'ai-for-blog-promotion': ['buffer', 'hootsuite', 'publer', 'sprout-social'],
  'ai-for-marketing-roi': ['hubspot', 'klaviyo', 'activecampaign'],
  'ai-for-customer-acquisition': ['hubspot', 'klaviyo', 'intercom'],
  'ai-for-product-marketing': ['hubspot', 'jasper', 'copy-ai', 'writesonic'],
  // === WRITING (1) ===
  'ai-for-storytelling': ['copy-ai', 'jasper', 'sudowrite', 'writesonic'],
  // === PRODUCTIVITY (3) ===
  'ai-for-priority-management': ['reclaim-ai', 'motion', 'sunsama'],
  'ai-for-personal-knowledge-management': ['notion-ai', 'coda', 'mem-ai'],
  'ai-for-async-communication': ['slack', 'notion-ai', 'loom', 'grain'],
  'ai-for-survey-piping': ['sprig', 'dovetail', 'maze'],
}

console.log('=== Batch 12 Gate B mappability check ===\n')
let totalSlugs = 0, passSlugs = 0, failSlugs = 0
const passes = []
const fails = []
for (const [taskSlug, picks] of Object.entries(editorPicks)) {
  totalSlugs++
  const { rows } = await client.query(
    `SELECT slug, name, rating FROM tools WHERE slug = ANY($1::text[]) ORDER BY rating DESC, review_count DESC NULLS LAST`,
    [picks]
  )
  const found = rows.map(r => r.slug)
  const missing = picks.filter(p => !found.includes(p))
  const status = found.length >= 3 ? 'PASS' : 'FAIL'
  if (status === 'PASS') {
    passSlugs++
    passes.push({ taskSlug, found, missing })
  } else {
    failSlugs++
    fails.push({ taskSlug, found, missing })
  }
  console.log(`${status}  ${taskSlug.padEnd(40)} ${found.length}/${picks.length}  found=[${found.join(',')}]${missing.length ? `  missing=[${missing.join(',')}]` : ''}`)
}

console.log(`\n=== Summary: ${passSlugs}/${totalSlugs} PASS, ${failSlugs} FAIL ===`)
if (fails.length) {
  console.log('\nFAIL list (DROP these):')
  for (const f of fails) console.log(`  ${f.taskSlug}: only ${f.found.length} found`)
}

await client.end()
