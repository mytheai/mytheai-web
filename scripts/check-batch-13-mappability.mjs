// Gate B for tasks-batch-13 (S127 Phase 3 batch 5).
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
  // === UNBLOCKED FROM PRIOR BATCH FAILURES (10 - thanks to Block A) ===
  'ai-for-data-pipelines': ['fivetran', 'dbt', 'segment', 'rudderstack'],
  'ai-for-error-monitoring': ['sentry', 'datadog', 'bugsnag'],
  'ai-for-incident-management': ['datadog', 'pagerduty', 'sentry'],
  'ai-for-deployment-automation': ['vercel', 'netlify', 'railway'],
  'ai-for-llm-monitoring': ['langsmith', 'langfuse', 'helicone'],
  'ai-for-data-quality': ['monte-carlo', 'dbt', 'fivetran', 'datadog'],
  'ai-for-data-discovery': ['atlan', 'dbt', 'datadog'],
  'ai-for-compliance-monitoring': ['drata', 'secureframe', 'vanta', 'aikido-security'],
  'ai-for-vendor-risk': ['drata', 'secureframe', 'vanta', 'aikido-security'],
  'ai-for-audience-research': ['sparktoro', 'similarweb', 'hubspot'],
  // === FRESH BRAINSTORM (17) ===
  'ai-for-startup-finance': ['pilot', 'bench', 'zeni', 'docyt', 'ramp', 'brex'],
  'ai-for-event-tracking': ['segment', 'rudderstack', 'hubspot'],
  'ai-for-rag-applications': ['langchain', 'crewai', 'langflow', 'hugging-face'],
  'ai-for-prompt-engineering': ['langfuse', 'helicone', 'langsmith'],
  'ai-for-talent-pipeline': ['eightfold', 'beamery', 'lever', 'greenhouse', 'ashby'],
  'ai-for-360-feedback': ['lattice', 'culture-amp', '15five'],
  'ai-for-employee-coaching': ['lattice', 'culture-amp', '15five'],
  'ai-for-game-art': ['midjourney', 'leonardo-ai', 'flux', 'krea-ai'],
  'ai-for-storyboards': ['midjourney', 'leonardo-ai', 'flux'],
  'ai-for-photo-editing': ['photoroom', 'picsart', 'runway'],
  'ai-for-research-tagging': ['dovetail', 'maze', 'sprig', 'lookback'],
  'ai-for-ticket-deflection': ['intercom', 'gorgias', 'forethought', 'freshchat'],
  'ai-for-conversation-analytics': ['intercom', 'gainsight', 'gong-io', 'sembly-ai'],
  'ai-for-data-engineering': ['dbt', 'fivetran', 'segment', 'rudderstack'],
  'ai-for-billing-automation': ['tipalti', 'airbase', 'pandadoc', 'docyt'],
  'ai-for-saas-operations': ['airbase', 'ramp', 'brex', 'vanta', 'rippling'],
  'ai-for-cybersecurity-monitoring': ['vanta', 'aikido-security', 'drata', 'secureframe', 'snyk'],
}

console.log('=== Batch 13 Gate B mappability check ===\n')
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
