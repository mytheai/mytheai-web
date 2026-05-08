// Gate B for tasks-batch-14 (S128 Phase 3 batch 6).
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
  // data-analytics (4)
  'ai-for-data-warehouse': ['snowflake', 'dbt', 'fivetran', 'atlan'],
  'ai-for-product-metrics': ['mixpanel', 'amplitude', 'posthog', 'heap'],
  'ai-for-attribution-modeling': ['mixpanel', 'amplitude', 'heap', 'segment'],
  'ai-for-event-analytics': ['mixpanel', 'amplitude', 'heap', 'posthog', 'segment'],
  // dev (5)
  'ai-for-platform-engineering': ['vercel', 'netlify', 'railway', 'github'],
  'ai-for-feature-flags': ['posthog', 'launchdarkly', 'statsig', 'optimizely'],
  'ai-for-observability': ['datadog', 'sentry', 'bugsnag'],
  'ai-for-database-migrations': ['planetscale', 'neon', 'supabase'],
  'ai-for-cloud-monitoring': ['datadog', 'sentry', 'bugsnag', 'pagerduty'],
  // finance (4)
  'ai-for-finops': ['ramp', 'brex', 'airbase', 'tipalti'],
  'ai-for-treasury-management': ['ramp', 'brex', 'mercury', 'airbase'],
  'ai-for-revenue-recognition': ['chargebee', 'stripe', 'baremetrics'],
  'ai-for-cap-table-management': ['carta', 'pulley'],
  // customer-success replacements (1)
  'ai-for-customer-lifecycle': ['gainsight', 'vitally', 'totango', 'planhat'],
  // customer-success (2)
  'ai-for-account-planning': ['gainsight', 'clari', 'affinity'],
  'ai-for-renewal-forecasting': ['gainsight', 'vitally', 'churnzero', 'clari'],
  // research (3)
  'ai-for-research-repository': ['dovetail', 'maze', 'sprig'],
  'ai-for-customer-discovery': ['dovetail', 'maze', 'sprig', 'typeform'],
  'ai-for-feedback-synthesis': ['dovetail', 'sprig', 'lookback', 'maze'],
  // research replacement (1)
  'ai-for-research-recruiting': ['respondent', 'userlytics', 'dscout'],
  // support (4)
  'ai-for-call-center-analytics': ['gong-io', 'modjo', 'level-ai', 'sembly-ai'],
  'ai-for-omnichannel-support': ['zendesk', 'freshdesk', 'intercom', 'gorgias'],
  'ai-for-support-knowledge': ['zendesk', 'intercom', 'document360', 'guru'],
  'ai-for-ticket-prioritization': ['zendesk', 'freshdesk', 'intercom', 'gorgias'],
  // design (2)
  'ai-for-brand-asset-management': ['frontify', 'brandfolder', 'bynder'],
  'ai-for-product-mockups': ['uizard', 'galileo-ai', 'visily', 'relume'],
  // design replacement (1)
  'ai-for-design-systems': ['frontify', 'brandfolder', 'bynder'],
  // productivity (2)
  'ai-for-personal-finance': ['copilot-money', 'monarch-money', 'rocket-money'],
  'ai-for-team-handbooks': ['notion', 'gitbook', 'document360', 'slab'],
  // productivity replacement (1)
  'ai-for-shared-calendars': ['cal-com', 'reclaim-ai', 'clockwise', 'motion'],
  // sales (3)
  'ai-for-buyer-intent': ['6sense', 'demandbase', 'clearbit', 'apollo-io'],
  'ai-for-account-mapping': ['affinity', 'clari', 'gong-io'],
  'ai-for-sales-compensation': ['captivateiq', 'spiff', 'salesforce-einstein'],
  // writing (3)
  'ai-for-internal-communications': ['notion', 'slack', 'guru', 'slab'],
  'ai-for-professional-bios': ['copy-ai', 'jasper', 'writesonic', 'rytr'],
  'ai-for-recipe-writing': ['copy-ai', 'jasper', 'writesonic', 'rytr'],
  // marketing (1)
  'ai-for-link-building': ['surfer-seo', 'ahrefs', 'semrush', 'frase'],
}

console.log('=== Batch 14 Gate B mappability check ===\n')
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
if (fails.length) {
  console.log('\nFAIL list (DROP these):')
  for (const f of fails) console.log(`  ${f.taskSlug}: ${f.found.length} found  missing=[${f.missing.join(',')}]`)
}

await client.end()
