#!/usr/bin/env node
// Removes dead tool slugs (from dead-tools-report.json) from src/data/top10.ts.
// Run AFTER check-dead-tools.mjs. Run: node scripts/clean-top10.mjs

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')

const reportPath = path.join(WEB_ROOT, 'dead-tools-report.json')
const top10Path = path.join(WEB_ROOT, 'src/data/top10.ts')

const report = JSON.parse(await fs.readFile(reportPath, 'utf-8'))
const deadSlugs = new Set([
  ...report.dead.map(r => r.slug),
  ...(report.manual_dead_slugs ?? []),
])
if (deadSlugs.size === 0) {
  console.log('No dead slugs in report - nothing to clean.')
  process.exit(0)
}

const original = await fs.readFile(top10Path, 'utf-8')

// top10.ts arrays look like: slugs: ['a', 'b', 'c'],
// Match each array literal, parse it, drop dead slugs, rewrite.
let removed = 0
const updated = original.replace(/slugs:\s*\[([^\]]*)\]/g, (full, inner) => {
  const items = inner
    .split(',')
    .map(s => s.trim().replace(/^['"]|['"]$/g, ''))
    .filter(Boolean)
  const kept = items.filter(s => {
    if (deadSlugs.has(s)) {
      removed++
      return false
    }
    return true
  })
  if (kept.length === items.length) return full
  return `slugs: [${kept.map(s => `'${s}'`).join(', ')}]`
})

if (removed === 0) {
  console.log('No dead slugs found in top10.ts - already clean.')
  process.exit(0)
}

await fs.writeFile(top10Path, updated)
console.log(`Removed ${removed} dead slug references from top10.ts`)
console.log(`(${deadSlugs.size} unique dead slugs in report)`)
