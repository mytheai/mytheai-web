// S108 Mode D: tier 17 final close - all 87 remaining empty integrations[] tools.
// These are mostly consumer-creative; honest minimal seeds (1-3 tags) where applicable.
import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { data, error } = await supabase
  .from('tools')
  .select('slug,name,tags,rating,review_count,integrations,website_url,pricing_type')
  .order('review_count', { ascending: false, nullsFirst: false })
  .limit(2000)
if (error) { console.error(error); process.exit(1) }

const empty = data.filter(t => !t.integrations || t.integrations.length === 0)
console.log(`Tools without integrations[]: ${empty.length}\n`)
empty.forEach((t, i) => {
  console.log(`${(i+1).toString().padStart(3)}. ${t.slug.padEnd(30)}  ${(t.rating || 0)}★ ${(t.review_count || 0).toString().padStart(6)}  ${t.pricing_type || '-'}  tags=${(t.tags || []).slice(0,3).join(',')}`)
})
