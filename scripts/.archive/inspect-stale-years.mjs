import { createClient } from '@supabase/supabase-js'
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

const slugs = ['lemonade','watershed','grok','genspark','glif','luma-dream-machine','google-meet','webflow','pi','pinecone','sora','recraft-ai','schoolai']
const { data } = await supabase.from('tools').select('slug,description').in('slug', slugs)

data.forEach(t => {
  console.log(`\n=== ${t.slug} ===`)
  // Highlight 2024/2025 contexts
  const sentences = (t.description || '').split(/(?<=[.!?])\s+/)
  sentences.forEach(s => {
    if (s.includes('2024') || s.includes('2025')) {
      console.log(`  >>> ${s.slice(0, 200)}`)
    }
  })
})
