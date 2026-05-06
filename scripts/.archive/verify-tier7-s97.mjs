import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)
const { count } = await supabase
  .from('tools')
  .select('*', { count: 'exact', head: true })
  .not('integrations', 'is', null)
  .gt('integrations', '{}')
console.log('Tools with integrations[] non-empty:', count)

const tier7 = ['shopify-magic','octane-ai','recart','weglot','syte','deepl','smartling','lokalise','phrase','crowdin','amplemarket','beehiiv','substack','buffer','hootsuite','later','sprout-social','drift','kustomer','tableau','looker','metabase','wrike','smartsheet','basecamp','cody','softr','glide','adalo','noloco']
const { data } = await supabase.from('tools').select('slug,integrations').in('slug', tier7).order('slug')
const empty = data.filter(t => !t.integrations || t.integrations.length === 0)
console.log(`Tier 7 found: ${data.length}/${tier7.length}, empty: ${empty.length}`)
