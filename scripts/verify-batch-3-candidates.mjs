// Phase 1 batch 3 candidates - Gate A (slug conflicts) + Gate B (mappability) verification.
// Source: editorial brainstorm prioritizing under-covered categories (sales/dev/ops/finance/support/hr).

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
  // sales (5)
  { slug: 'ai-for-sales-outreach',      category: 'sales',      primary_tags: ['sales-engagement','email-marketing'], picks: ['lemlist','lavender','reply-io','smartlead','outreach','salesloft','apollo-io'] },
  { slug: 'ai-for-lead-generation',     category: 'sales',      primary_tags: ['sales-engagement'],                   picks: ['apollo-io','clay','seamless-ai','zoominfo','hunter','cognism'] },
  { slug: 'ai-for-proposal-writing',    category: 'sales',      primary_tags: ['sales-engagement','writing-ai'],      picks: ['proposify','qwilr','pandadoc','better-proposals','dealhub','loopio'] },
  { slug: 'ai-for-sales-calls',         category: 'sales',      primary_tags: ['sales-engagement','meeting-ai'],      picks: ['gong-io','chorus','modjo','sembly-ai','avoma'] },
  { slug: 'ai-for-rfp-responses',       category: 'sales',      primary_tags: ['sales-engagement'],                   picks: ['loopio','responsive-ai','better-proposals','proposify','qwilr'] },

  // dev (3)
  { slug: 'ai-for-code-completion',     category: 'dev',        primary_tags: ['code-ai'],                            picks: ['cursor','copilot-microsoft','tabnine','codeium','supermaven'] },
  { slug: 'ai-for-api-documentation',   category: 'dev',        primary_tags: ['code-ai'],                            picks: ['mintlify','readme','scalar','postman','stoplight'] },
  { slug: 'ai-for-pull-request-review', category: 'dev',        primary_tags: ['code-ai'],                            picks: ['graphite','codium','codacy','qodo','sourcegraph'] },

  // ops (4) - new category with 0 entries
  { slug: 'ai-for-meeting-scheduling',  category: 'ops',        primary_tags: ['productivity'],                       picks: ['calendly','cal-com','reclaim-ai','clockwise','motion'] },
  { slug: 'ai-for-workflow-automation', category: 'ops',        primary_tags: ['automation'],                         picks: ['zapier','make','n8n','workato','integrately'] },
  { slug: 'ai-for-document-extraction', category: 'ops',        primary_tags: ['automation'],                         picks: ['rossum','parashift','docparser','nanonets','tipalti'] },
  { slug: 'ai-for-form-building',       category: 'ops',        primary_tags: ['productivity'],                       picks: ['typeform','jotform','tally','fillout','feathery'] },

  // support (2)
  { slug: 'ai-for-helpdesk',            category: 'support',    primary_tags: ['ai-assistants'],                      picks: ['zendesk','freshdesk','intercom','help-scout','front-app'] },
  { slug: 'ai-for-knowledge-base',      category: 'support',    primary_tags: ['ai-assistants','productivity'],       picks: ['gitbook','document360','intercom','notion-ai','guru','slab'] },

  // finance (3)
  { slug: 'ai-for-expense-tracking',    category: 'finance',    primary_tags: ['finance-accounting'],                 picks: ['ramp','brex','expensify','airbase','divvy'] },
  { slug: 'ai-for-bookkeeping',         category: 'finance',    primary_tags: ['finance-accounting'],                 picks: ['bench','pilot','zeni','baremetrics','docyt'] },
  { slug: 'ai-for-financial-forecasting', category: 'finance',  primary_tags: ['finance-accounting','data-analytics'], picks: ['mosaic','datarails','cube','akkio','julius-ai'] },

  // data-analytics (2)
  { slug: 'ai-for-dashboards',          category: 'data-analytics', primary_tags: ['data-analytics'],                 picks: ['metabase','tableau','power-bi','looker','preset','rows'] },
  { slug: 'ai-for-spreadsheet-automation', category: 'data-analytics', primary_tags: ['data-analytics'],              picks: ['formula-bot','rows','julius-ai','deepnote','akkio'] },

  // research (1)
  { slug: 'ai-for-literature-review',   category: 'research',   primary_tags: ['research'],                           picks: ['elicit','scispace','scite','consensus','perplexity'] },

  // productivity (3)
  { slug: 'ai-for-translation',         category: 'productivity', primary_tags: ['productivity'],                     picks: ['deepl','lilt','unbabel','transifex','crowdin'] },
  { slug: 'ai-for-summarization',       category: 'productivity', primary_tags: ['productivity'],                     picks: ['otter-ai','fathom','fireflies-ai','notion-ai','glasp','readwise'] },
  { slug: 'ai-for-grammar-checking',    category: 'productivity', primary_tags: ['writing-ai'],                       picks: ['grammarly','languagetool','prowriting-aid','quillbot','originality-ai'] },

  // marketing (1)
  { slug: 'ai-for-content-calendars',   category: 'marketing',  primary_tags: ['social-media','marketing'],           picks: ['contentstudio','buffer','hootsuite','loomly','publer','planable'] },

  // customer-success (1)
  { slug: 'ai-for-customer-feedback',   category: 'customer-success', primary_tags: ['research'],                     picks: ['typeform','sprig','dovetail','maze','userpilot'] },

  // writing (1)
  { slug: 'ai-for-website-copy',        category: 'writing',    primary_tags: ['writing-ai'],                         picks: ['jasper','copy-ai','anyword','writesonic','copysmith','hypotenuse-ai'] },
]

console.log(`=== Phase 1 batch 3: ${candidates.length} candidates ===\n`)

// Gate A: slug conflicts
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
    console.log(`  ok ${c.slug}`)
    aPass.push(c.slug)
  }
}
console.log(`\nGate A: ${aPass.length}/${candidates.length} pass`)

// Gate B: mappability
console.log('\n=== GATE B: mappability ===\n')
const results = []
for (const c of candidates) {
  if (aFail.includes(c.slug)) continue
  const { rows } = await client.query(
    `SELECT slug, name, rating, review_count, tags FROM tools WHERE slug = ANY($1::text[]) ORDER BY rating DESC NULLS LAST, review_count DESC NULLS LAST`,
    [c.picks]
  )
  const found = rows.map(r => r.slug)
  const missing = c.picks.filter(p => !found.includes(p))
  const status = found.length >= 3 ? 'PASS' : 'FAIL'
  console.log(`\n${c.slug} [${status}]`)
  console.log(`  found ${found.length}/${c.picks.length}: ${found.join(', ')}`)
  if (missing.length) console.log(`  missing: ${missing.join(', ')}`)
  results.push({ ...c, found, missing, valid_picks: rows.slice(0, 5).map(r => r.slug), gate_b: status })
}

console.log('\n\n=== SUMMARY ===')
const pass = results.filter(r => r.gate_b === 'PASS')
const fail = results.filter(r => r.gate_b === 'FAIL')
console.log(`PASS (${pass.length}): ${pass.map(r => r.slug).join(', ')}`)
console.log(`FAIL (${fail.length}): ${fail.map(r => r.slug).join(', ')}`)

console.log('\n=== FINAL VALID PICKS (top 5 sorted by rating) ===')
for (const r of pass) {
  console.log(`${r.slug}: [${r.valid_picks.join(',')}]`)
}

await client.end()
