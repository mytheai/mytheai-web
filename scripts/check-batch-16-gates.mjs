// Batch 16 Gate A (slug conflicts) + Gate B (mappability) combined check.
import fs from 'node:fs/promises'
import { Client } from 'pg'

const envText = await fs.readFile('.env.local', 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()

const editorPicks = {
  // === support (33 -> 38, +5) ===
  'ai-for-customer-onboarding-flows': ['intercom', 'gainsight', 'vitally', 'totango'],
  'ai-for-support-escalation': ['zendesk', 'intercom', 'freshchat', 'gladly'],
  'ai-for-voice-of-customer': ['qualtrics', 'sprinklr', 'dovetail', 'sprig'],
  'ai-for-self-service-portals': ['zendesk', 'intercom', 'gladly', 'document360'],
  'ai-for-support-team-coaching': ['gong-io', 'avoma', 'modjo', 'lavender'],

  // === writing (33 -> 38, +5) ===
  'ai-for-linkedin-articles': ['jasper', 'copy-ai', 'writesonic', 'lavender'],
  'ai-for-technical-blogs': ['jasper', 'writer', 'frase', 'scalenut'],
  'ai-for-white-papers': ['jasper', 'writer', 'copy-ai', 'writesonic'],
  'ai-for-ebook-writing': ['jasper', 'sudowrite', 'writesonic', 'copy-ai'],
  'ai-for-sales-copy': ['copy-ai', 'jasper', 'anyword', 'lavender'],

  // === finance (34 -> 38, +4) ===
  'ai-for-financial-planning': ['mosaic', 'pilot', 'baremetrics', 'chartmogul'],
  'ai-for-credit-management': ['highradius', 'ramp', 'brex', 'airbase'],
  'ai-for-bookkeeping-automation': ['bench', 'pilot', 'zeni', 'docyt'],
  'ai-for-vendor-payments-automation': ['tipalti', 'ramp', 'airbase', 'stampli'],

  // === ops (34 -> 38, +4) ===
  'ai-for-incident-response': ['pagerduty', 'datadog', 'sentry', 'aikido-security'],
  'ai-for-policy-automation': ['drata', 'secureframe', 'vanta', 'aikido-security'],
  'ai-for-business-continuity-planning': ['drata', 'secureframe', 'vanta'],
  'ai-for-knowledge-operations': ['guru', 'document360', 'gitbook', 'slab'],

  // === research (34 -> 38, +4) ===
  'ai-for-user-personas': ['dovetail', 'maze', 'sprig', 'respondent'],
  'ai-for-jobs-to-be-done': ['dovetail', 'sprig', 'maze', 'respondent'],
  'ai-for-focus-groups': ['dovetail', 'respondent', 'userlytics', 'dscout'],
  'ai-for-research-design': ['dovetail', 'maze', 'sprig', 'lookback'],

  // === customer-success (35 -> 38, +3) ===
  'ai-for-cs-segmentation': ['gainsight', 'vitally', 'totango', 'planhat'],
  'ai-for-value-realization': ['gainsight', 'vitally', 'totango', 'planhat'],
  'ai-for-cs-playbooks-automation': ['gainsight', 'vitally', 'totango', 'planhat'],

  // === data-analytics (35 -> 38, +3) ===
  'ai-for-time-series-analysis': ['mixpanel', 'amplitude', 'heap', 'snowflake'],
  'ai-for-predictive-modeling': ['akkio', 'obviously-ai', 'mixpanel', 'amplitude'],
  'ai-for-data-pipelines-monitoring': ['monte-carlo', 'datadog', 'fivetran', 'dbt'],

  // === design (35 -> 38, +3) ===
  'ai-for-design-tokens': ['frontify', 'penpot', 'brandfolder'],
  'ai-for-creative-briefs': ['frontify', 'brandfolder', 'bynder', 'penpot'],
  'ai-for-design-iteration': ['frontify', 'penpot', 'brandfolder'],

  // === dev (35 -> 38, +3) ===
  'ai-for-test-automation': ['cursor', 'github-copilot', 'codeium', 'tabnine'],
  'ai-for-devsecops': ['snyk', 'aikido-security', 'socket-dev', 'cycode'],
  'ai-for-developer-onboarding': ['cursor', 'github-copilot', 'sourcegraph'],

  // === hr-recruiting (35 -> 38, +3) ===
  'ai-for-workforce-planning': ['lattice', 'culture-amp', '15five', 'eightfold'],
  'ai-for-succession-planning': ['eightfold', 'lattice', 'culture-amp'],
  'ai-for-exit-interviews': ['lattice', 'culture-amp', '15five'],

  // === marketing (35 -> 38, +3) ===
  'ai-for-viral-marketing': ['hubspot', 'klaviyo', 'mailchimp'],
  'ai-for-growth-hacking': ['mixpanel', 'amplitude', 'heap', 'posthog'],
  'ai-for-content-syndication': ['hubspot', 'mailchimp', 'klaviyo', 'beehiiv'],

  // === productivity (35 -> 38, +3) ===
  'ai-for-weekly-reviews': ['notion-ai', 'mem-ai', 'readwise'],
  'ai-for-deep-work': ['reclaim-ai', 'cal-com', 'motion'],
  'ai-for-personal-okrs': ['notion-ai', 'mem-ai', 'lattice'],

  // === sales (35 -> 38, +3) ===
  'ai-for-outbound-sequences': ['lemlist', 'smartlead', 'reply-io', 'lavender'],
  'ai-for-win-loss-analysis': ['gong-io', 'modjo', 'avoma', 'clari'],
  'ai-for-sales-territory-planning': ['salesforce-einstein', 'clari', 'gainsight', 'affinity'],
}

const allSlugs = Object.keys(editorPicks)
console.log(`=== Batch 16 Gate A: slug conflicts (${allSlugs.length} candidates) ===`)
const existing = await c.query(`SELECT slug FROM tasks WHERE slug = ANY($1::text[])`, [allSlugs])
const conflicted = new Set(existing.rows.map(r => r.slug))
let gateAPassCount = 0
for (const slug of allSlugs) {
  const status = conflicted.has(slug) ? 'CONFLICT' : 'PASS'
  if (status === 'PASS') gateAPassCount++
  if (status === 'CONFLICT') console.log(`  ${status.padEnd(8)} ${slug}`)
}
console.log(`\nGate A: ${gateAPassCount}/${allSlugs.length} PASS\n`)

console.log(`=== Batch 16 Gate B: mappability (>=3 picks) ===`)
let gateBPassCount = 0, gateBFails = []
for (const [slug, picks] of Object.entries(editorPicks)) {
  if (conflicted.has(slug)) continue
  const r = await c.query(`SELECT slug FROM tools WHERE slug = ANY($1::text[])`, [picks])
  const found = r.rows.map(row => row.slug)
  const missing = picks.filter(p => !found.includes(p))
  const status = found.length >= 3 ? 'PASS' : 'FAIL'
  if (status === 'PASS') gateBPassCount++
  else gateBFails.push({ slug, found, missing })
  console.log(`  ${status.padEnd(4)} ${slug.padEnd(46)} ${found.length}/${picks.length}  found=[${found.join(',')}]${missing.length ? `  missing=[${missing.join(',')}]` : ''}`)
}
const gateAPasses = allSlugs.filter(s => !conflicted.has(s))
console.log(`\nGate B: ${gateBPassCount}/${gateAPasses.length} PASS, ${gateBFails.length} FAIL`)
if (gateBFails.length) {
  console.log(`\nFAIL list (DROP):`)
  for (const f of gateBFails) console.log(`  ${f.slug}: ${f.found.length} found, missing=[${f.missing.join(',')}]`)
}
console.log(`\n=== FINAL: ${gateBPassCount}/${allSlugs.length} candidates ship-ready ===`)

await c.end()
