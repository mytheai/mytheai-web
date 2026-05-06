// S98 Mode D: tier 9 candidates - top 50 by review_count from the
// remaining 327 empty-integrations tools (those not picked by S97 tier 8).
import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { data, error } = await supabase
  .from('tools')
  .select('slug,name,tags,rating,review_count,integrations,website_url')
  .order('review_count', { ascending: false, nullsFirst: false })
  .limit(2000)
if (error) { console.error(error); process.exit(1) }

const empty = data.filter(t => !t.integrations || t.integrations.length === 0)
console.log(`Tools without integrations[]: ${empty.length}`)
console.log('\nTop 60 by review_count (next tier after S97 tier 8):')
empty.slice(0, 60).forEach((t, i) => {
  console.log(`${(i+1).toString().padStart(3)}. ${t.slug.padEnd(28)}  ${(t.rating || 0)}★ ${(t.review_count || 0).toString().padStart(6)}  tags=${(t.tags || []).slice(0,3).join(',')}`)
})
