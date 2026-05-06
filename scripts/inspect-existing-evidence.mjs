import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { data } = await supabase
  .from('tools')
  .select('slug,name,scores_evidence')
  .not('scores_evidence', 'is', null)
  .order('slug')

console.log(`Tools with scores_evidence: ${data.length}\n`)
data.slice(0, 5).forEach(t => {
  console.log(`=== ${t.slug} ===`)
  console.log(JSON.stringify(t.scores_evidence, null, 2).slice(0, 800))
  console.log()
})
