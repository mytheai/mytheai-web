// S96 Mode D: identify tier 6 backfill candidates (no integrations[] yet).
// Run: node --env-file=.env.local scripts/check-tier6-candidates.mjs
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

// Vertical leaders from S69-S86 batches with strongest integration ecosystems.
const candidates = [
  // Compliance/Legal-ops (S71, S79)
  'vanta','drata','secureframe','sprinto','onetrust','bigid','everlaw','relativity','kira-systems','lexion',
  // HR / People Ops (S75)
  'lattice','culture-amp','15five','leapsome','gusto','hibob','betterup',
  // Procurement (S83)
  'coupa','zip-procurement','spendesk','jaggaer','pactum','sievo',
  // Hospitality (S77)
  'mews','cloudbeds','guesty','duetto','revinate','navan','siteminder',
  // Supply chain / Logistics (S78)
  'project44','flexport','easypost','blue-yonder','o9-solutions','kinaxis','shippo','manhattan-associates',
  // Manufacturing (S80)
  'tulip','c3-ai','cognex','landing-ai','sight-machine','uptake','augury','instrumental',
  // Climate (S81)
  'watershed','persefoni','greenly','plan-a','climatiq','sweep','normative',
  // Government (S82)
  'granicus','opengov','tyler-technologies','accela','axon-ai','civicplus',
  // Customer Service (S69)
  'intercom-fin','ada-ai','decagon-ai','forethought-ai','moveworks','ultimate-ai','yellow-ai',
  // Healthcare (S70)
  'heidi-health','freed-ai','ambience-healthcare','viz-ai','tempus-ai','regard-clinical','deepscribe',
  // Real Estate (S72)
  'compass','reonomy','matterport','cherre','rex-real-estate',
  // Insurance (S76)
  'lemonade','tractable','shift-technology','planck','coalition','next-insurance',
  // Construction (S73)
  'autodesk-forma','openspace','buildots','testfit','archistar',
  // Education (S74)
  'photomath','coursera-coach','gradescope-ai','quizlet-q-chat','nearpod-ai',
  // Biotech (S84)
  'insilico-medicine','recursion','benevolentai','schrodinger','atomwise',
  // Aerospace/Defense (S85)
  'palantir','anduril','shield-ai','planet-labs','helsing',
  // Legal Tech (S79)
  'paxton-ai','draftwise','definely','smokeball','filevine','brightflag','linksquares','evisort',
]
const uniq = [...new Set(candidates)]
const { data, error } = await supabase
  .from('tools')
  .select('slug,name,integrations,scores')
  .in('slug', uniq)
  .order('slug')

if (error) { console.error(error); process.exit(1) }

const needBackfill = data.filter(t => !t.integrations || t.integrations.length === 0)
const alreadySeeded = data.filter(t => t.integrations && t.integrations.length > 0)
const missing = uniq.filter(s => !data.some(t => t.slug === s))

console.log(`Found in DB: ${data.length}/${uniq.length}`)
console.log(`Need backfill: ${needBackfill.length}`)
console.log(`Already seeded: ${alreadySeeded.length}`)
console.log(`Missing from DB: ${missing.length}`)
if (missing.length) {
  console.log('\nMISSING:')
  missing.forEach(s => console.log('  ' + s))
}
console.log('\nNEED BACKFILL:')
needBackfill.forEach(t => console.log(`  ${t.slug.padEnd(28)}  scores=${t.scores ? 'yes' : 'no'}`))
