// S97 Mode D: identify tier 7 backfill candidates (no integrations[] yet).
// Run: node --env-file=.env.local scripts/check-tier7-candidates.mjs
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

// Next-rung tools across categories not covered in tier 1-6.
const candidates = [
  // E-commerce / Shopify ecosystem (S68)
  'shopify-magic','octane-ai','rep-ai','recart','searchspring','nosto','lily-ai','syte','rebuy','stamped-io',
  // Translation / Localization (S64)
  'deepl','smartling','lokalise','phrase','weglot','crowdin',
  // Sales engagement (S39)
  'apollo','outreach','salesloft','clay','amplemarket','smartlead','clari','gong',
  // Email marketing (S40)
  'sendinblue','brevo','convertkit','beehiiv','substack','drip','getresponse','aweber',
  // Project management / collab (S45)
  'asana','monday','clickup','linear','jira','basecamp','wrike','smartsheet',
  // No-code (S37)
  'softr','glide','adalo','framer','noloco',
  // Customer support (S38)
  'drift','kustomer','helpscout',
  // SEO (S44)
  'semrush','ahrefs','clearscope','marketmuse','frase','surfer-seo','contentking',
  // Forms / Surveys
  'typeform','jotform','paperform','formstack','tally','surveymonkey',
  // Social media (S66)
  'hootsuite','buffer','sprout-social','later','planoly','meetedgar',
  // Productivity / Notes (S46)
  'notion','obsidian','craft','roam-research','logseq',
  // Video / podcast (S46-S47)
  'descript','riverside','squadcast','podcastle','wondercraft',
  // Design (S60)
  'figma','sketch','canva-ai','penpot','xd',
  // Meeting intelligence (S58)
  'fathom','fireflies-ai','tldv','otter-ai','grain-co',
  // CRM (S67)
  'salesforce-einstein','hubspot','pipedrive','zoho-crm','freshsales','copper','close',
  // Analytics (S91 already covered some)
  'tableau','looker','power-bi','metabase','sisense','holistics',
  // Dev tools / IDE (S86)
  'cursor','windsurf','copilot','aider','codeium','tabnine','cody',
  // Writing AI (S43)
  'jasper','copy-ai','writesonic','rytr','wordtune','quillbot',
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
console.log('\nNEED BACKFILL:')
needBackfill.forEach(t => console.log(`  ${t.slug.padEnd(28)}  scores=${t.scores ? 'yes' : 'no'}`))
