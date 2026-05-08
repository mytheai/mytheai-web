import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const { data, error } = await supabase
  .from('tasks')
  .select('category')
  .eq('status', 'published')

if (error) { console.error(error); process.exit(1) }

const counts = {}
for (const row of data) {
  counts[row.category] = (counts[row.category] || 0) + 1
}

const sorted = Object.entries(counts).sort((a, b) => b[1] - a[1])
console.log('Published tasks per category:')
for (const [cat, n] of sorted) {
  console.log(`  ${cat.padEnd(20)} ${n}`)
}
console.log(`\nTotal: ${data.length}`)
const min = Math.min(...Object.values(counts))
const max = Math.max(...Object.values(counts))
console.log(`Spread: ${min}-${max} (span ${max - min})`)
