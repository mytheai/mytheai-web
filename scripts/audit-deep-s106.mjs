// S106 deep audit: find quality gaps not surfaced by audit-state-s97.mjs.
import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { data: tools } = await supabase
  .from('tools')
  .select('slug,name,description,tagline,pricing_verified_at,review_count,rating,scores,scores_evidence,featured,trending,editor_pick')
  .order('review_count', { ascending: false, nullsFirst: false })
  .limit(2000)

const now = new Date()

// 1. Stale pricing_verified_at (>90 days old per CLAUDE.md)
const stalePricing = tools.filter(t => {
  if (!t.pricing_verified_at) return false
  const age = (now - new Date(t.pricing_verified_at)) / (1000 * 60 * 60 * 24)
  return age > 90
})

// 2. Description with stale year refs
const has2025 = tools.filter(t => t.description?.includes('2025') && !t.description?.includes('2026'))
const has2024 = tools.filter(t => t.description?.includes('2024') && !t.description?.includes('2026'))

// 3. Em-dash leak in description/tagline
const emDashDesc = tools.filter(t => t.description?.includes('—') || t.tagline?.includes('—'))

// 4. Empty description (CLAUDE.md says 0 but verify)
const emptyDesc = tools.filter(t => !t.description || t.description.length < 50)

// 5. Tools with featured=true but rating<4
const sketchyFeatured = tools.filter(t => t.featured && (t.rating || 0) < 4)

// 6. Tools missing scores_evidence among top 30 high-traffic head-term
const top30NoEvidence = tools.slice(0, 30).filter(t => !t.scores_evidence)

console.log('=== S106 Deep Audit ===')
console.log(`\nStale pricing_verified_at (>90d): ${stalePricing.length}`)
if (stalePricing.length) stalePricing.slice(0, 10).forEach(t => console.log(`  ${t.slug}: ${t.pricing_verified_at}`))

console.log(`\nDescriptions with "2025" but no "2026": ${has2025.length}`)
if (has2025.length) has2025.slice(0, 10).forEach(t => console.log(`  ${t.slug}`))

console.log(`\nDescriptions with "2024" but no "2026": ${has2024.length}`)
if (has2024.length) has2024.slice(0, 10).forEach(t => console.log(`  ${t.slug}`))

console.log(`\nEm-dash in description/tagline: ${emDashDesc.length}`)
if (emDashDesc.length) emDashDesc.slice(0, 10).forEach(t => console.log(`  ${t.slug}`))

console.log(`\nEmpty/short descriptions: ${emptyDesc.length}`)
if (emptyDesc.length) emptyDesc.forEach(t => console.log(`  ${t.slug} len=${t.description?.length || 0}`))

console.log(`\nSketchy featured (rating<4): ${sketchyFeatured.length}`)
if (sketchyFeatured.length) sketchyFeatured.forEach(t => console.log(`  ${t.slug} rating=${t.rating}`))

console.log(`\nTop 30 head-term without scores_evidence: ${top30NoEvidence.length}`)
top30NoEvidence.slice(0, 30).forEach(t => console.log(`  ${t.slug.padEnd(22)} reviews=${t.review_count}`))
