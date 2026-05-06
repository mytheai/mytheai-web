// S107: find tools with uniform integer scores (truly auto-derived).
import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { data } = await supabase
  .from('tools')
  .select('slug,name,tags,rating,review_count,scores,pricing_type')
  .order('review_count', { ascending: false, nullsFirst: false })
  .limit(2000)

const isAutoDerived = (s) => {
  if (!s) return true
  const values = Object.values(s)
  if (values.length !== 7) return true
  const hasHalfPoint = values.some(v => typeof v === 'number' && (v * 2) % 2 !== 0)
  const minVal = Math.min(...values)
  const maxVal = Math.max(...values)
  return !hasHalfPoint && minVal > 3 && (maxVal - minVal) < 3
}

const autoOnly = data.filter(t => isAutoDerived(t.scores))
console.log(`Auto-derived (uniform): ${autoOnly.length}\n`)
autoOnly.forEach((t, i) => {
  const s = t.scores || {}
  console.log(`${(i+1).toString().padStart(3)}. ${t.slug.padEnd(28)}  ${(t.rating || 0)}★ ${(t.review_count || 0).toString().padStart(6)}  ${t.pricing_type || '-'}`)
  console.log(`     scores: ${JSON.stringify(s)}`)
  console.log(`     tags: ${(t.tags || []).slice(0,3).join(',')}`)
})
