import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { count: totalTools } = await supabase.from('tools').select('*', { count: 'exact', head: true })
const { count: withInt } = await supabase.from('tools').select('*', { count: 'exact', head: true }).gt('integrations', '{}')
const { data: holes } = await supabase.from('tools').select('slug,pros,cons,use_cases,description,scores,pricing_verified_at,logo_url,website_url,rating,review_count')

const noScores = holes.filter(t => !t.scores).length
const noPV = holes.filter(t => !t.pricing_verified_at).length
const noLogo = holes.filter(t => !t.logo_url).length
const noWebsite = holes.filter(t => !t.website_url).length
const noPros = holes.filter(t => !t.pros || t.pros.length < 3).length
const noCons = holes.filter(t => !t.cons || t.cons.length < 3).length
const noUseCases = holes.filter(t => !t.use_cases || t.use_cases.length < 3).length
const shortDesc = holes.filter(t => !t.description || t.description.length < 200).length
const noRating = holes.filter(t => !t.rating).length
const noReviewCount = holes.filter(t => !t.review_count).length

console.log('=== Catalog audit (S97) ===')
console.log(`Total tools: ${totalTools}`)
console.log(`With integrations[]: ${withInt}, missing: ${totalTools - withInt}`)
console.log(`No scores: ${noScores}`)
console.log(`No pricing_verified_at: ${noPV}`)
console.log(`No logo_url: ${noLogo}`)
console.log(`No website_url: ${noWebsite}`)
console.log(`<3 pros: ${noPros}`)
console.log(`<3 cons: ${noCons}`)
console.log(`<3 use_cases: ${noUseCases}`)
console.log(`Description <200 chars: ${shortDesc}`)
console.log(`No rating: ${noRating}`)
console.log(`No review_count: ${noReviewCount}`)
