// Phase 4b - dedupe + remove overlapping/redundant top10 lists.
// 1. Removes literal-duplicate slugs (keeps first occurrence)
// 2. Removes lists in EXCLUDE_SLUGS that are superseded by sister lists or
//    belong to verticals removed in Phase 2.

import { readFileSync, writeFileSync } from 'fs'
import { fileURLToPath } from 'url'
import { dirname, join } from 'path'

const __dirname = dirname(fileURLToPath(import.meta.url))
const TOP10_PATH = join(__dirname, '..', 'src', 'data', 'top10.ts')

// Slugs to remove (exact string match against list slug)
const EXCLUDE_SLUGS = new Set([
  // Sister-list overlap (kept the more general / better named)
  'best-seo-ai-tools',                  // kept best-ai-seo-tools
  'best-social-media-ai-tools',          // kept best-ai-social-media-tools
  'best-ai-tools-for-presentations',     // kept best-ai-presentation-tools
  'best-ai-tools-for-ecommerce',         // kept best-ai-ecommerce-tools
  'best-ai-tools-for-teachers',          // kept best-ai-tools-for-educators
  'best-ai-podcast-production-tools',    // kept best-ai-podcast-tools
  'best-ai-customer-support-tools',      // kept best-ai-customer-service-tools
  'best-ai-helpdesk-automation',         // overlaps with customer-service
  'best-ai-content-writing-tools',       // kept best-ai-writing-tools
  'best-ai-video-generators',            // kept best-ai-video-tools
  'best-ai-video-editing-tools',         // kept best-ai-video-tools
  'best-ai-voice-generators',            // kept best-ai-voice-tools
  'best-ai-research-assistants',         // kept best-ai-research-tools
  'best-ai-tools-for-hr',                // kept best-ai-hr-tools
  'best-ai-hris-tools',                  // B2B HR specific - covered by best-ai-hr-tools
  // Verticals pruned in Phase 2 (lingering single-theme lists)
  'best-ai-carbon-accounting',           // Climate vertical removed
  'best-ai-classroom-tools',             // overlapping with educators
  'best-ai-customer-success-tools',      // B2B niche
  'best-ai-elearning-authoring-tools',   // niche
  'best-ai-hotel-management-tools',      // Hospitality vertical pruned
  'best-ai-medical-scribes',             // Healthcare specific - covered
  'best-ai-performance-management',      // HR specific - covered
  'best-ai-recruiting-tools',            // HR specific - covered
  'best-ai-tools-for-doctors',           // Healthcare specific
])

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

const seenSlugs = new Set()
const toKeep = []
const removedDupes = []
const removedExcluded = []

for (const l of lists) {
  const slugMatch = l.text.match(/slug:\s*['"`]([a-z0-9-]+)['"`]/)
  const listSlug = slugMatch ? slugMatch[1] : '???'
  if (seenSlugs.has(listSlug)) {
    removedDupes.push(listSlug)
    continue
  }
  if (EXCLUDE_SLUGS.has(listSlug)) {
    removedExcluded.push(listSlug)
    continue
  }
  seenSlugs.add(listSlug)
  toKeep.push(l)
}

console.log(`Removed ${removedDupes.length} literal duplicates:`, removedDupes.join(', '))
console.log(`Removed ${removedExcluded.length} excluded sister-lists:`)
for (const s of removedExcluded) console.log('  ' + s)

let newBody = '\n'
for (const l of toKeep) {
  newBody += '  ' + arrayBody.slice(l.start, l.end).trim() + '\n'
}
const out = before + newBody + after
writeFileSync(TOP10_PATH, out)
console.log(`\nLists: ${lists.length} -> ${toKeep.length} (-${lists.length - toKeep.length})`)
