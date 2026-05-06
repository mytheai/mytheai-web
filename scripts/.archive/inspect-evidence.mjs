import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { data } = await supabase
  .from('tools')
  .select('slug,name,review_count,scores_evidence,rating')
  .order('review_count', { ascending: false, nullsFirst: false })
  .limit(2000)

const withEvidence = data.filter(t => t.scores_evidence)
const noEvidence = data.filter(t => !t.scores_evidence)

console.log(`Total: ${data.length}`)
console.log(`With scores_evidence: ${withEvidence.length}`)
console.log(`Without scores_evidence: ${noEvidence.length}`)
console.log('\nTop 50 highest-traffic without evidence (S106 candidates):')
noEvidence.slice(0, 50).forEach((t, i) => {
  console.log(`${(i+1).toString().padStart(3)}. ${t.slug.padEnd(28)}  ${(t.rating || 0)}★ ${(t.review_count || 0).toString().padStart(6)}`)
})
