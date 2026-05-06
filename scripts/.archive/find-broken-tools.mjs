import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { data } = await supabase.from('tools').select('slug,name,logo_url,website_url,pricing_verified_at,review_count,rating')

const noLogo = data.filter(t => !t.logo_url)
const noPV = data.filter(t => !t.pricing_verified_at)
const noReviewCount = data.filter(t => !t.review_count)

console.log(`No logo_url (${noLogo.length}):`)
noLogo.forEach(t => console.log(`  ${t.slug.padEnd(30)} website=${t.website_url}`))
console.log(`\nNo pricing_verified_at (${noPV.length}):`)
noPV.forEach(t => console.log(`  ${t.slug}`))
console.log(`\nNo review_count (${noReviewCount.length}):`)
noReviewCount.forEach(t => console.log(`  ${t.slug.padEnd(30)} rating=${t.rating}`))
