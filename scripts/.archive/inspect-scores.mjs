import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

// Sample tools known to be hand-curated (S89-S96) vs unknown
const samples = ['chatgpt','claude','vanta','watershed','blackbox-ai','codegpt','suno','character-ai','gamma','typefully']
const { data } = await supabase.from('tools').select('slug,scores,scores_evidence').in('slug', samples)
data.forEach(t => {
  const keys = t.scores ? Object.keys(t.scores) : []
  console.log(`${t.slug.padEnd(20)} keys=[${keys.join(',')}] evidence=${t.scores_evidence ? 'yes' : 'no'}`)
  if (t.scores) console.log(`   ${JSON.stringify(t.scores)}`)
})
