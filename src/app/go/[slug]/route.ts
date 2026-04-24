import { redirect } from 'next/navigation'
import { supabase } from '@/lib/supabase'

export async function GET(req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params

  const { data: tool } = await supabase
    .from('tools')
    .select('affiliate_url')
    .eq('slug', slug)
    .single()

  if (!tool) {
    redirect('/tools')
  }

  // Track click — fire and forget, don't block redirect
  const referrer = req.headers.get('referer') ?? ''
  supabase.from('tool_clicks').insert({ tool_slug: slug, referrer }).then(() => {})

  redirect(tool.affiliate_url)
}
