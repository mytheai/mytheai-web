import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)
const { data } = await supabase.from('tools').select('slug,scores,scores_evidence')

const isHandCurated = (s) => {
  if (!s) return false
  const values = Object.values(s)
  if (values.length !== 7) return false
  const hasHalfPoint = values.some(v => typeof v === 'number' && (v * 2) % 2 !== 0)
  const minVal = Math.min(...values)
  const maxVal = Math.max(...values)
  // Hand-curated indicator: half-points OR pricing<=3 OR variance>2
  return hasHalfPoint || minVal <= 3 || (maxVal - minVal) >= 3
}

const handCurated = data.filter(t => isHandCurated(t.scores)).length
const withEvidence = data.filter(t => t.scores_evidence).length
console.log(`Total: ${data.length}`)
console.log(`Hand-curated scores (heuristic): ${handCurated}`)
console.log(`Auto-derived only (uniform): ${data.length - handCurated}`)
console.log(`With scores_evidence: ${withEvidence}`)
