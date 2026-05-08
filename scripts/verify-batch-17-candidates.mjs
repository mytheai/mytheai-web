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

const candidates = {
  'ai-for-customer-onboarding-checklists': {
    cat: 'customer-success',
    picks: ['gainsight', 'vitally', 'planhat', 'totango', 'custify', 'userpilot', 'pendo']
  },
  'ai-for-revenue-dashboards': {
    cat: 'data-analytics',
    picks: ['hex', 'mode', 'omni', 'lightdash', 'julius-ai', 'metabase', 'tableau', 'looker']
  },
  'ai-for-ad-creatives': {
    cat: 'design',
    picks: ['adcreative-ai', 'canva', 'picsart', 'bannerbear', 'creatopy']
  },
  'ai-for-code-review': {
    cat: 'dev',
    picks: ['qodo', 'codium', 'sourcegraph', 'codacy', 'github-copilot', 'cursor', 'aider', 'continue-dev']
  },
  'ai-for-invoice-management': {
    cat: 'finance',
    picks: ['stampli', 'ramp', 'brex', 'airbase', 'tipalti', 'docyt', 'vic-ai']
  },
  'ai-for-employee-benefits': {
    cat: 'hr-recruiting',
    picks: ['rippling', 'gusto', 'hibob', 'bamboohr', 'lattice']
  },
  'ai-for-event-promotion': {
    cat: 'marketing',
    picks: ['hubspot', 'klaviyo', 'mailerlite', 'omnisend', 'activecampaign', 'mailchimp']
  },
  'ai-for-vendor-scorecards': {
    cat: 'ops',
    picks: ['drata', 'secureframe', 'vanta', 'aikido-security', 'ironclad']
  },
  'ai-for-reading-summaries': {
    cat: 'productivity',
    picks: ['readwise', 'glasp', 'mem-ai', 'notion-ai', 'humata', 'chatpdf']
  },
  'ai-for-interview-transcripts': {
    cat: 'research',
    picks: ['otter-ai', 'fireflies-ai', 'dovetail', 'descript', 'sembly-ai', 'grain']
  },
  'ai-for-quote-generation': {
    cat: 'sales',
    picks: ['dealhub', 'qwilr', 'pandadoc', 'proposify', 'better-proposals']
  },
  'ai-for-ticket-tagging': {
    cat: 'support',
    picks: ['intercom', 'gorgias', 'freshchat', 'gladly', 'forethought', 'zoho-desk']
  },
  'ai-for-product-changelogs': {
    cat: 'writing',
    picks: ['notion-ai', 'gitbook', 'document360', 'slab', 'guru', 'tettra']
  },
}

console.log('=== Gate B verification ===\n')
let totalPass = 0
let totalFail = 0
const passDetails = {}

for (const [taskSlug, { cat, picks }] of Object.entries(candidates)) {
  const { rows } = await client.query(
    `SELECT slug, name, rating, review_count, tags FROM tools WHERE slug = ANY($1::text[]) ORDER BY rating DESC NULLS LAST, review_count DESC NULLS LAST`,
    [picks]
  )
  const found = rows.map(r => r.slug)
  const missing = picks.filter(p => !found.includes(p))
  const status = found.length >= 3 ? '✓ PASS' : '✗ FAIL'
  console.log(`\n[${cat}] ${taskSlug} → ${status} (${found.length}/${picks.length})`)
  for (const r of rows.slice(0, 5)) console.log(`  ✓ ${r.slug.padEnd(28)} ★${r.rating ?? '?'}`)
  if (missing.length) console.log(`  ✗ missing: ${missing.join(', ')}`)
  if (found.length >= 3) {
    totalPass++
    passDetails[taskSlug] = { cat, picks: found.slice(0, Math.min(5, found.length)) }
  } else totalFail++
}

console.log(`\n\n=== SUMMARY: ${totalPass} PASS, ${totalFail} FAIL ===`)
console.log('\n=== Final picks (top 5 each) ===')
for (const [task, info] of Object.entries(passDetails)) {
  console.log(`${task} (${info.cat}): ${info.picks.join(', ')}`)
}

await client.end()
