// Gate B for tasks-batch-11 (S125 Phase 3 batch 3): verify each task slug has >=3 mappable tools in catalog.
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
  'ai-for-fact-checking': ['originality-ai', 'copyleaks', 'winston-ai', 'gptzero', 'scite'],
  'ai-for-thematic-analysis': ['dovetail', 'maze', 'lookback', 'sprig', 'dscout'],
  'ai-for-user-testing': ['dovetail', 'maze', 'lookback', 'sprig', 'dscout', 'respondent', 'userlytics'],
  'ai-for-academic-summarization': ['elicit', 'consensus', 'scispace', 'humata', 'scite'],
  'ai-for-paper-discovery': ['elicit', 'consensus', 'scispace', 'scite', 'humata'],
  'ai-for-research-operations': ['dovetail', 'maze', 'lookback', 'sprig', 'optimal-workshop'],
  // === CUSTOMER-SUCCESS (5) ===
  'ai-for-feature-adoption': ['userpilot', 'pendo', 'gainsight', 'vitally', 'planhat'],
  'ai-for-customer-loyalty': ['klaviyo', 'mailchimp', 'braze', 'customer-io', 'omnisend'],
  'ai-for-customer-marketing': ['klaviyo', 'mailchimp', 'braze', 'customer-io', 'hubspot'],
  'ai-for-customer-data': ['segment', 'rudderstack', 'hubspot', 'salesforce', 'klaviyo'],
  'ai-for-cs-automation': ['intercom', 'gainsight', 'vitally', 'planhat', 'totango'],
  'ai-for-customer-experience': ['intercom', 'gainsight', 'qualtrics', 'medallia', 'sprinklr'],
  'ai-for-customer-effort-score': ['intercom', 'gainsight', 'qualtrics', 'sprig', 'vitally'],
  // === FINANCE (4) ===
  'ai-for-fundraising-prep': ['pilot', 'bench', 'docyt', 'zeni', 'airbase'],
  'ai-for-cash-management': ['ramp', 'brex', 'airbase', 'tipalti'],
  'ai-for-equity-management': ['carta', 'pulley'],
  'ai-for-financial-dashboards': ['airbase', 'ramp', 'brex', 'baremetrics', 'chartmogul'],
  // === DEV (4) ===
  'ai-for-error-monitoring': ['sentry', 'datadog', 'bugsnag', 'rollbar'],
  'ai-for-deployment-automation': ['vercel', 'netlify', 'railway', 'render'],
  'ai-for-llm-monitoring': ['langsmith', 'langfuse', 'helicone', 'arize'],
  'ai-for-code-translation': ['cursor', 'copilot-microsoft', 'codeium', 'replit', 'tabnine'],
  // === SUPPORT (4) ===
  'ai-for-support-tickets': ['intercom', 'zendesk', 'freshchat', 'gorgias', 'zoho-desk'],
  'ai-for-escalation-management': ['intercom', 'gorgias', 'freshchat', 'zoho-desk', 'liveagent'],
  'ai-for-chat-routing': ['intercom', 'drift', 'gorgias', 'freshchat', 'crisp'],
  'ai-for-customer-service-automation': ['intercom', 'gorgias', 'freshchat', 'forethought', 'capacity'],
  // === HR-RECRUITING (3) ===
  'ai-for-employee-handbook': ['notion-ai', 'coda', 'gitbook', 'document360', 'guru'],
  'ai-for-onboarding-checklists': ['notion-ai', 'lattice', 'bamboohr', 'rippling', 'gusto'],
  'ai-for-compensation-management': ['rippling', 'bamboohr', 'lattice', '15five', 'gusto'],
  'ai-for-skills-assessment': ['lattice', '15five', 'culture-amp', 'leapsome', 'eightfold'],
  // === OPS (3) ===
  'ai-for-incident-management': ['datadog', 'pagerduty', 'sentry'],
  'ai-for-compliance-monitoring': ['drata', 'vanta', 'secureframe', 'aikido-security'],
  'ai-for-vendor-risk': ['drata', 'vanta', 'secureframe', 'aikido-security'],
  'ai-for-team-coordination': ['slack', 'asana', 'clickup', 'monday', 'notion-ai'],
  // === DESIGN (3) ===
  'ai-for-brand-design': ['canva-ai', 'figma', 'adobe-firefly', 'looka', 'uizard'],
  'ai-for-banner-ads': ['canva-ai', 'adcreative-ai', 'adobe-firefly', 'figma'],
  'ai-for-character-design': ['leonardo-ai', 'midjourney', 'krea-ai', 'scenario', 'flux'],
  // === DATA-ANALYTICS (3) ===
  'ai-for-data-quality': ['monte-carlo', 'datadog', 'fivetran', 'dbt'],
  'ai-for-data-pipelines': ['fivetran', 'segment', 'rudderstack', 'dbt', 'airbyte'],
  'ai-for-business-metrics': ['chartmogul', 'baremetrics', 'profitwell', 'datadog'],
  'ai-for-data-discovery': ['atlan', 'select-star', 'dbt', 'datadog'],
  // === SALES (3) ===
  'ai-for-sales-strategy': ['gong-io', 'chorus', 'clari', 'salesforce'],
  'ai-for-buyer-enablement': ['storydoc', 'gamma-app', 'pitch', 'beautiful-ai', 'qwilr'],
  'ai-for-sales-presentations': ['gamma-app', 'pitch', 'beautiful-ai', 'storydoc', 'tome'],
  'ai-for-pipeline-coaching': ['gong-io', 'modjo', 'avoma', 'sembly-ai', 'salesforce'],
  'ai-for-objection-handling': ['gong-io', 'modjo', 'lavender', 'chorus', 'sembly-ai'],
  // === MARKETING (3) ===
  'ai-for-content-promotion': ['buffer', 'hootsuite', 'publer', 'sprout-social', 'metricool'],
  'ai-for-conversion-optimization': ['intercom', 'hubspot', 'mutiny', 'unbounce', 'klaviyo'],
  'ai-for-audience-research': ['sparktoro', 'similarweb', 'audiense', 'hubspot'],
  'ai-for-marketing-operations': ['hubspot', 'marketo', 'activecampaign', 'mailchimp', 'klaviyo'],
  // === WRITING (1) ===
  'ai-for-microcopy': ['copy-ai', 'jasper', 'writer-com', 'anyword'],
  'ai-for-product-copy': ['copy-ai', 'jasper', 'writesonic', 'anyword', 'hypotenuse-ai'],
  'ai-for-script-writing': ['jasper', 'copy-ai', 'writesonic', 'sudowrite', 'rytr'],
  // === PRODUCTIVITY (2) ===
  'ai-for-time-blocking': ['reclaim-ai', 'motion', 'sunsama', 'cal-com'],
  'ai-for-meeting-templates': ['notion-ai', 'coda', 'fellow', 'fireflies-ai'],
  'ai-for-team-performance': ['lattice', '15five', 'culture-amp', 'leapsome'],
}

console.log('=== Batch 11 Gate B mappability check ===\n')
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
  console.log(`${status}  ${taskSlug.padEnd(38)} ${found.length}/${picks.length}  found=[${found.join(',')}]${missing.length ? `  missing=[${missing.join(',')}]` : ''}`)
}

console.log(`\n=== Summary: ${passSlugs}/${totalSlugs} PASS, ${failSlugs} FAIL ===`)
console.log('\nPASS list (use these in tasks-batch-11.sql):')
for (const p of passes) console.log(`  ${p.taskSlug}: picks=[${p.found.join(',')}]${p.missing.length ? `  (drop missing: ${p.missing.join(',')})` : ''}`)
if (fails.length) {
  console.log('\nFAIL list (DROP these):')
  for (const f of fails) console.log(`  ${f.taskSlug}: only ${f.found.length} found  missing=[${f.missing.join(',')}]`)
}

await client.end()
