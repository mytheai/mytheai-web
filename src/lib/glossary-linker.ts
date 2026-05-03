// Auto-link glossary terms inside body text. Returns a list of segments where
// each segment is either a string (raw text) or a {href, text} link spec, ready
// to be rendered safely as JSX (no dangerouslySetInnerHTML, no XSS risk).
//
// Constraints:
//  - First occurrence per term per body only (avoid spam links).
//  - Case-insensitive match but preserve original case in output.
//  - Match on word boundaries so "RAG" does not link inside "garage".
//  - Skip terms whose alias is too short (1-2 chars) or generic to avoid noise.

import { GLOSSARY } from '@/data/glossary'

export interface PlainSegment { type: 'text'; value: string }
export interface LinkSegment { type: 'link'; href: string; value: string }
export type LinkedSegment = PlainSegment | LinkSegment

interface AliasIndex {
  alias: string
  slug: string
  pattern: RegExp
}

// Build the alias index once. Sort by alias length descending so multi-word
// aliases ("Large Language Model") match before single-word ones ("LLM").
const ALIAS_INDEX: AliasIndex[] = (() => {
  const out: AliasIndex[] = []
  for (const g of GLOSSARY) {
    const aliases = g.aliases ?? [g.term]
    for (const a of aliases) {
      // Skip very short aliases that would over-match
      if (a.replace(/[^a-zA-Z]/g, '').length < 3) continue
      const escaped = a.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
      const pattern = new RegExp(`\\b${escaped}\\b`, 'i')
      out.push({ alias: a, slug: g.slug, pattern })
    }
  }
  return out.sort((a, b) => b.alias.length - a.alias.length)
})()

export function linkGlossary(body: string): LinkedSegment[] {
  if (!body) return [{ type: 'text', value: '' }]
  const usedSlugs = new Set<string>()
  let segments: LinkedSegment[] = [{ type: 'text', value: body }]

  for (const { slug, pattern } of ALIAS_INDEX) {
    if (usedSlugs.has(slug)) continue
    const next: LinkedSegment[] = []
    let matched = false
    for (const seg of segments) {
      if (matched || seg.type !== 'text') {
        next.push(seg)
        continue
      }
      const m = pattern.exec(seg.value)
      if (!m) {
        next.push(seg)
        continue
      }
      const before = seg.value.slice(0, m.index)
      const matchedText = seg.value.slice(m.index, m.index + m[0].length)
      const after = seg.value.slice(m.index + m[0].length)
      if (before) next.push({ type: 'text', value: before })
      next.push({ type: 'link', href: `/glossary/${slug}`, value: matchedText })
      if (after) next.push({ type: 'text', value: after })
      matched = true
      usedSlugs.add(slug)
    }
    segments = next
  }
  return segments
}
