// Phase 0 helper: gates new task slugs against collisions with existing namespaces.
// Cross-checks: tasks (DB), top10 (TS), use-cases (TS), tools (DB), comparisons (DB).
//
// Usage:
//   node --env-file=.env.local scripts/check-task-slug-conflicts.mjs <slug>
//   node --env-file=.env.local scripts/check-task-slug-conflicts.mjs ai-for-cold-emails ai-for-meeting-summaries

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { Client } from 'pg'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')

const slugs = process.argv.slice(2)
if (slugs.length === 0) {
  console.error('Usage: node --env-file=.env.local scripts/check-task-slug-conflicts.mjs <slug> [<slug2> ...]')
  process.exit(1)
}

// Format gate
const SLUG_RE = /^[a-z0-9]+(-[a-z0-9]+)*$/
const PREFIX = 'ai-for-'
const formatErrors = []
for (const s of slugs) {
  if (!SLUG_RE.test(s)) formatErrors.push(`${s}: not lowercase-kebab-case`)
  if (s.length > 60) formatErrors.push(`${s}: ${s.length} chars (>60 max)`)
  if (!s.startsWith(PREFIX)) formatErrors.push(`${s}: must start with "${PREFIX}"`)
  if (/\d{4}/.test(s)) formatErrors.push(`${s}: contains year (slug must be evergreen)`)
}
if (formatErrors.length) {
  console.error('Format errors:')
  for (const e of formatErrors) console.error(`  ✗ ${e}`)
  process.exit(1)
}

const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const client = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()

// Load TS-side namespaces
const top10Src = await fs.readFile(path.join(WEB_ROOT, 'src/data/top10.ts'), 'utf-8')
const useCasesSrc = await fs.readFile(path.join(WEB_ROOT, 'src/data/useCases.ts'), 'utf-8')
const top10Slugs = [...top10Src.matchAll(/slug:\s*'([^']+)'/g)].map(m => m[1])
const useCaseSlugs = [...useCasesSrc.matchAll(/slug:\s*'([^']+)'/g)].map(m => m[1])

let anyConflict = false
for (const slug of slugs) {
  console.log(`\nChecking: ${slug}`)
  const conflicts = []

  // tasks table
  const { rows: existingTasks } = await client.query(
    `SELECT slug, status FROM tasks WHERE slug = $1`,
    [slug]
  )
  if (existingTasks.length) conflicts.push(`tasks.${slug} exists (status=${existingTasks[0].status})`)

  // tools table
  const { rows: existingTools } = await client.query(
    `SELECT slug FROM tools WHERE slug = $1`,
    [slug]
  )
  if (existingTools.length) conflicts.push(`tools.${slug} exists`)

  // comparisons table
  const { rows: existingCompare } = await client.query(
    `SELECT slug FROM comparisons WHERE slug = $1`,
    [slug]
  )
  if (existingCompare.length) conflicts.push(`comparisons.${slug} exists`)

  // top10 + use-cases (TS)
  if (top10Slugs.includes(slug)) conflicts.push(`top10.${slug} exists`)
  if (useCaseSlugs.includes(slug)) conflicts.push(`use-cases.${slug} exists`)

  // Soft-warn on close synonyms (singular/plural diff only)
  const candidates = [
    slug.endsWith('s') ? slug.slice(0, -1) : slug + 's',
    slug.replace(/-/g, ''),
  ].filter(c => c !== slug)
  for (const c of candidates) {
    const { rows: r1 } = await client.query(`SELECT slug FROM tasks WHERE slug = $1`, [c])
    if (r1.length) conflicts.push(`tasks.${c} (close synonym) exists`)
    if (top10Slugs.includes(c)) conflicts.push(`top10.${c} (close synonym) exists`)
    if (useCaseSlugs.includes(c)) conflicts.push(`use-cases.${c} (close synonym) exists`)
  }

  if (conflicts.length) {
    console.log(`  ✗ CONFLICTS:`)
    for (const c of conflicts) console.log(`     - ${c}`)
    anyConflict = true
  } else {
    console.log(`  ✓ no conflicts`)
  }
}

await client.end()
process.exit(anyConflict ? 1 : 0)
