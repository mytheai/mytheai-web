// Find top10 lists that are bare (no picks/intro/etc).
import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')

// Naive parse: split on `  {` blocks
const ts = await fs.readFile(path.join(WEB_ROOT, 'src/data/top10.ts'), 'utf-8')

// Match each top-level list block
const blocks = []
let depth = 0
let start = -1
let inListsArray = false
const lines = ts.split('\n')
for (let i = 0; i < lines.length; i++) {
  const line = lines[i]
  if (line.includes('TOP10_LISTS: Top10List[] = [')) {
    inListsArray = true
    continue
  }
  if (!inListsArray) continue
  if (line.trimStart().startsWith('{') && depth === 0) {
    start = i
    depth = 1
    continue
  }
  if (depth > 0) {
    for (const ch of line) {
      if (ch === '{') depth++
      else if (ch === '}') depth--
      if (depth === 0) {
        blocks.push({ start, end: i, text: lines.slice(start, i+1).join('\n') })
        start = -1
        break
      }
    }
  }
}

console.log(`Total top10 list blocks: ${blocks.length}\n`)
const bare = []
const enriched = []
for (const b of blocks) {
  const slugMatch = b.text.match(/slug:\s*'([^']+)'/)
  const slug = slugMatch ? slugMatch[1] : '<?>'
  const hasIntro = /\bintro:/.test(b.text)
  const hasMethodology = /\bmethodology:/.test(b.text)
  const hasPicks = /\bpicks:\s*\[/.test(b.text)
  const hasBottomLine = /\bbottomLine:/.test(b.text)
  const hasFaqs = /\bfaqs:\s*\[/.test(b.text)
  const isFullyEnriched = hasIntro && hasMethodology && hasPicks && hasBottomLine && hasFaqs
  if (isFullyEnriched) {
    enriched.push(slug)
  } else {
    bare.push({ slug, hasIntro, hasMethodology, hasPicks, hasBottomLine, hasFaqs })
  }
}

console.log(`Fully enriched: ${enriched.length}`)
console.log(`Bare or partially enriched: ${bare.length}\n`)
console.log('BARE LISTS:')
for (const b of bare) {
  const flags = [
    b.hasIntro ? 'i' : '-',
    b.hasMethodology ? 'm' : '-',
    b.hasPicks ? 'p' : '-',
    b.hasBottomLine ? 'b' : '-',
    b.hasFaqs ? 'f' : '-',
  ].join('')
  console.log(`  [${flags}]  ${b.slug}`)
}
