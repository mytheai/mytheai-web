import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

// Heuristic: hand-curated scores have at least one half-point (X.5) value
// OR pricing_value <= 3 (auto-derived mostly gives 3.5+)
const candidates = ['zoom','hubspot','zendesk','slack','tableau','airtable','semrush','quillbot','ahrefs','intercom','monday','loom','copilot-microsoft','asana','adobe-firefly','pipedrive','clickup','todoist','salesforce-einstein','framer','miro','metabase','fireflies-ai','kahoot-ai','gusto','linear','looker','freshdesk','zoho-crm','surfer-seo','adobe-premiere-pro','quillbot']

const { data } = await supabase.from('tools').select('slug,scores,scores_evidence').in('slug', candidates)
data.forEach(t => {
  const s = t.scores || {}
  const values = Object.values(s)
  const hasHalfPoint = values.some(v => typeof v === 'number' && (v * 2) % 2 !== 0)
  const minVal = Math.min(...values)
  const maxVal = Math.max(...values)
  const looksHandCurated = hasHalfPoint || minVal <= 3
  console.log(`${t.slug.padEnd(22)} half=${hasHalfPoint} min=${minVal} max=${maxVal} curated=${looksHandCurated} evidence=${t.scores_evidence ? 'Y' : 'N'}`)
})
