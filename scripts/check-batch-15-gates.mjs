// Batch 15 Gate A (slug conflicts) + Gate B (mappability) combined check.
import fs from 'node:fs/promises'
import { Client } from 'pg'

const envText = await fs.readFile('.env.local', 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()

// Editor picks per candidate task slug.
const editorPicks = {
  // === UNBLOCKED FROM TIER 19 (7) ===
  'ai-for-feature-flags': ['launchdarkly', 'statsig', 'optimizely'],
  'ai-for-database-migrations': ['planetscale', 'neon', 'supabase'],
  'ai-for-revenue-recognition': ['chargebee', 'stripe', 'baremetrics'],
  'ai-for-brand-asset-management': ['frontify', 'brandfolder', 'bynder'],
  'ai-for-personal-finance': ['copilot-money', 'monarch-money', 'rocket-money'],
  'ai-for-buyer-intent': ['6sense', 'demandbase', 'clearbit', 'apollo'],
  'ai-for-sales-compensation': ['captivateiq', 'spiff', 'salesforce-einstein'],

  // === FRESH FINANCE (4) ===
  'ai-for-cash-management': ['ramp', 'brex', 'mercury', 'airbase'],
  'ai-for-financial-modeling': ['mosaic', 'datarails', 'cube', 'pilot'],
  'ai-for-payroll-automation': ['rippling', 'gusto', 'justworks'],
  'ai-for-expense-management': ['ramp', 'brex', 'airbase', 'tipalti'],

  // === FRESH DEV (4) ===
  'ai-for-serverless-functions': ['vercel', 'netlify', 'supabase', 'neon'],
  'ai-for-edge-computing': ['vercel', 'netlify', 'railway'],
  'ai-for-build-pipelines': ['vercel', 'netlify', 'github', 'railway'],
  'ai-for-staging-environments': ['vercel', 'netlify', 'railway', 'supabase'],

  // === FRESH DESIGN (3) ===
  'ai-for-design-handoff': ['frontify', 'brandfolder', 'penpot'],
  'ai-for-creative-collaboration': ['frontify', 'brandfolder', 'bynder', 'penpot'],
  'ai-for-design-feedback': ['frontify', 'brandfolder', 'penpot'],

  // === FRESH SALES (4) ===
  'ai-for-account-based-marketing': ['6sense', 'demandbase', 'clearbit', 'apollo'],
  'ai-for-call-recording-analysis': ['gong-io', 'modjo', 'avoma', 'laxis'],
  'ai-for-revenue-operations': ['gainsight', 'clari', 'affinity'],
  'ai-for-sales-training': ['lavender', 'modjo', 'gong-io'],

  // === FRESH HR (4) ===
  'ai-for-applicant-tracking': ['lever', 'greenhouse', 'ashby', 'eightfold'],
  'ai-for-hiring-pipeline': ['lever', 'greenhouse', 'ashby', 'beamery'],
  'ai-for-recruiting-analytics': ['eightfold', 'beamery', 'lever', 'greenhouse'],
  'ai-for-candidate-experience': ['lever', 'greenhouse', 'ashby', 'beamery'],

  // === FRESH OPS (4) ===
  'ai-for-vendor-onboarding': ['drata', 'secureframe', 'vanta'],
  'ai-for-soc2-readiness': ['drata', 'secureframe', 'vanta'],
  'ai-for-procurement-automation': ['ramp', 'brex', 'airbase', 'tipalti'],
  'ai-for-audit-trails': ['drata', 'secureframe', 'vanta', 'aikido-security'],

  // === FRESH MARKETING (3) ===
  'ai-for-conversion-rate-optimization': ['optimizely', 'statsig', 'launchdarkly', 'mixpanel'],
  'ai-for-ab-testing-strategy': ['statsig', 'launchdarkly', 'optimizely'],
  'ai-for-personalization-engines': ['optimizely', 'statsig', 'segment', 'launchdarkly'],

  // === FRESH RESEARCH (3) ===
  'ai-for-research-archives': ['dovetail', 'maze', 'sprig', 'lookback'],
  'ai-for-research-coordination': ['dovetail', 'respondent', 'userlytics', 'dscout'],
  'ai-for-research-operations': ['dovetail', 'maze', 'sprig'],

  // === FRESH CS (3) ===
  'ai-for-account-health': ['gainsight', 'vitally', 'clari'],
  'ai-for-success-metrics': ['gainsight', 'vitally', 'totango', 'planhat'],
  'ai-for-customer-success-management': ['gainsight', 'vitally', 'totango', 'planhat'],

  // === FRESH PRODUCTIVITY (3) ===
  'ai-for-team-wikis': ['notion', 'gitbook', 'document360', 'slab'],
  'ai-for-async-communication': ['loom', 'notion', 'slack'],
  'ai-for-second-brain': ['notion', 'mem-ai', 'readwise'],

  // === FRESH DATA-ANALYTICS (3) ===
  'ai-for-product-experimentation': ['statsig', 'launchdarkly', 'optimizely', 'mixpanel'],
  'ai-for-database-analytics': ['snowflake', 'dbt', 'atlan', 'fivetran'],
  'ai-for-business-metrics': ['mixpanel', 'amplitude', 'heap', 'posthog'],
}

const allSlugs = Object.keys(editorPicks)
console.log(`=== Batch 15 Gate A: slug conflicts (${allSlugs.length} candidates) ===`)
const existing = await c.query(`SELECT slug FROM tasks WHERE slug = ANY($1::text[])`, [allSlugs])
const conflicted = new Set(existing.rows.map(r => r.slug))
let gateAPassCount = 0
for (const slug of allSlugs) {
  const status = conflicted.has(slug) ? 'CONFLICT' : 'PASS'
  if (status === 'PASS') gateAPassCount++
  console.log(`  ${status.padEnd(8)} ${slug}`)
}
console.log(`\nGate A: ${gateAPassCount}/${allSlugs.length} PASS\n`)

console.log(`=== Batch 15 Gate B: mappability (≥3 picks) ===`)
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
