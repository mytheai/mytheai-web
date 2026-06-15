/**
 * Produce a meta description tuned for Bing/Google preview (~150-160 chars).
 * - Normalizes whitespace and strips trailing periods before composing
 * - If under 150 chars and a padSuffix is provided, appends suffix to push into range
 * - If over 160 chars, truncates at last word boundary <= 158
 * - Always ends with a single period
 */
export function metaDescription(text: string, padSuffix?: string): string {
  const clean = (text ?? '').trim().replace(/\s+/g, ' ').replace(/[.\s]+$/, '')

  if (clean.length > 160) {
    const cut = clean.slice(0, 158)
    const lastSpace = cut.lastIndexOf(' ')
    const safe = lastSpace > 120 ? cut.slice(0, lastSpace) : cut
    return safe.replace(/[,;:.\s]+$/, '') + '.'
  }

  if (clean.length < 150 && padSuffix) {
    const trimmedSuffix = padSuffix.replace(/^[.\s]+|[.\s]+$/g, '')
    const joined = clean + '. ' + trimmedSuffix
    if (joined.length > 160) {
      const cut = joined.slice(0, 158)
      const lastSpace = cut.lastIndexOf(' ')
      const safe = lastSpace > 120 ? cut.slice(0, lastSpace) : cut
      return safe.replace(/[,;:.\s]+$/, '') + '.'
    }
    return joined + '.'
  }

  return clean + '.'
}
