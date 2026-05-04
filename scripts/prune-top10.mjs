// Phase 4 - prune top10 lists with <5 slugs (after Phase 2 tool deletion broke many lists).
// Usage: node scripts/prune-top10.mjs [--dry] [--min N]
//   --dry  : show what would be removed without writing
//   --min N: minimum slugs to keep a list (default 5)

import { readFileSync, writeFileSync } from 'fs'
import { fileURLToPath } from 'url'
import { dirname, join } from 'path'

const __dirname = dirname(fileURLToPath(import.meta.url))
const TOP10_PATH = join(__dirname, '..', 'src', 'data', 'top10.ts')

const args = process.argv.slice(2)
const isDry = args.includes('--dry')
const minIdx = args.indexOf('--min')
const MIN_SLUGS = minIdx >= 0 ? parseInt(args[minIdx + 1], 10) : 5

const src = readFileSync(TOP10_PATH, 'utf-8')
const m = src.match(/export const TOP10_LISTS[^=]*=\s*\[/)
if (!m) { console.error('Could not find TOP10_LISTS array'); process.exit(1) }
const arrStart = m.index + m[0].length - 1
let depth = 1
let i = arrStart + 1
while (i < src.length && depth > 0) {
  if (src[i] === '[') depth++
  else if (src[i] === ']') depth--
  if (depth === 0) break
  i++
}
const arrEnd = i
const before = src.slice(0, arrStart + 1)
const arrayBody = src.slice(arrStart + 1, arrEnd)
const after = src.slice(arrEnd)

const lists = []
let braceDepth = 0
let listStart = -1
let inString = false
let strChar = ''
const BS = String.fromCharCode(92)
for (let j = 0; j < arrayBody.length; j++) {
  const c = arrayBody[j]
  const prev = j > 0 ? arrayBody[j - 1] : ''
  if (inString) {
    if (c === strChar && prev !== BS) inString = false
    continue
  }
  if (c === "'" || c === '"' || c === '`') { inString = true; strChar = c; continue }
  if (c === '{') { if (braceDepth === 0) listStart = j; braceDepth++ }
  else if (c === '}') {
    braceDepth--
    if (braceDepth === 0 && listStart >= 0) {
      let endPos = j + 1
      while (endPos < arrayBody.length && /[,\s]/.test(arrayBody[endPos])) endPos++
      lists.push({ start: listStart, end: endPos, text: arrayBody.slice(listStart, j + 1) })
      listStart = -1
    }
  }
}

console.log('Total lists:', lists.length)

const audit = lists.map(l => {
  const slugMatch = l.text.match(/slug:\s*['"`]([a-z0-9-]+)['"`]/)
  const listSlug = slugMatch ? slugMatch[1] : '???'
  const slugsArrMatch = l.text.match(/slugs:\s*\[([^\]]*)\]/)
  const slugCount = slugsArrMatch ? (slugsArrMatch[1].match(/['"`][a-z0-9-]+['"`]/g) || []).length : 0
  return { ...l, listSlug, slugCount }
})

const toDelete = audit.filter(a => a.slugCount < MIN_SLUGS)
const toKeep = audit.filter(a => a.slugCount >= MIN_SLUGS)

console.log(`\nWith <${MIN_SLUGS} slugs (DELETE): ${toDelete.length}`)
console.log(`With >=${MIN_SLUGS} slugs (KEEP):   ${toKeep.length}`)

console.log('\n=== Lists being deleted ===')
for (const a of toDelete) console.log(`  [${a.slugCount}] ${a.listSlug}`)

if (isDry) { console.log('\n[dry-run, not writing]'); process.exit(0) }

// Rebuild arrayBody: keep only the lists in toKeep, in original order
toKeep.sort((a, b) => a.start - b.start)
let newBody = '\n'
for (const a of toKeep) {
  newBody += '  ' + arrayBody.slice(a.start, a.end).trim() + '\n'
}
const out = before + newBody + after
writeFileSync(TOP10_PATH, out)
console.log(`\nWrote ${TOP10_PATH}`)
console.log(`Lists: ${lists.length} -> ${toKeep.length} (-${toDelete.length})`)
