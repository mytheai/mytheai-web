import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)
const { count: totalSeeded } = await supabase
  .from('tools')
  .select('*', { count: 'exact', head: true })
  .not('integrations', 'is', null)
  .gt('integrations', '{}')
const { count: anyIntegrations } = await supabase
  .from('tools')
  .select('*', { count: 'exact', head: true })
  .not('integrations', 'is', null)
console.log('Tools with integrations IS NOT NULL:', anyIntegrations)
console.log('Tools with integrations[] non-empty:', totalSeeded)

const tier6 = ['vanta','onetrust','lattice','culture-amp','15five','gusto','hibob','coupa','mews','cloudbeds','guesty','navan','watershed','persefoni','greenly','compass','matterport','lemonade','palantir','anduril','intercom-fin','ada-ai','decagon-ai','moveworks','yellow-ai','heidi-health','freed-ai','ambience-healthcare','paxton-ai','everlaw','kira-systems']
const { data } = await supabase.from('tools').select('slug,integrations').in('slug', tier6).order('slug')
const empty = data.filter(t => !t.integrations || t.integrations.length === 0)
console.log(`\nTier 6 found: ${data.length}/${tier6.length}`)
console.log(`Tier 6 empty: ${empty.length}`)
if (empty.length) empty.forEach(t => console.log('  empty:', t.slug))
const missing = tier6.filter(s => !data.some(t => t.slug === s))
console.log('\nMissing from DB:', missing)
