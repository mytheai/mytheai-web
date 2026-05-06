// S106: find tools without hand-curated scores (auto-derived only).
// Hand-curated scores have all 7 dims including 'reliability'.
// Pick top 50 by review_count for review.
import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { data, error } = await supabase
  .from('tools')
  .select('slug,name,tags,rating,review_count,scores,pricing_type')
  .order('review_count', { ascending: false, nullsFirst: false })
  .limit(2000)
if (error) { console.error(error); process.exit(1) }

const isHandCurated = (s) => s && typeof s === 'object' && 'reliability' in s
const autoOnly = data.filter(t => !isHandCurated(t.scores))
const handCurated = data.filter(t => isHandCurated(t.scores))

console.log(`Total tools: ${data.length}`)
console.log(`Hand-curated scores: ${handCurated.length}`)
console.log(`Auto-derived only: ${autoOnly.length}`)
console.log('\nTop 60 auto-only by review_count (S106 candidates):')
autoOnly.slice(0, 60).forEach((t, i) => {
  console.log(`${(i+1).toString().padStart(3)}. ${t.slug.padEnd(28)}  ${(t.rating || 0)}★ ${(t.review_count || 0).toString().padStart(6)}  pricing=${t.pricing_type}  tags=${(t.tags || []).slice(0,2).join(',')}`)
})
