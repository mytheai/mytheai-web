import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase'

export async function GET(req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const supabase = await createClient()

  const { data: tool } = await supabase
    .from('tools')
    .select('affiliate_url')
    .eq('slug', slug)
    .single()

  if (!tool) {
    redirect('/tools')
  }

  const referrer = req.headers.get('referer') ?? ''
  void supabase.from('tool_clicks').insert({ tool_slug: slug, referrer })

  let dest = tool.affiliate_url
  try {
    const url = new URL(tool.affiliate_url)
    url.searchParams.set('utm_source', 'mytheai')
    url.searchParams.set('utm_medium', 'affiliate')
    url.searchParams.set('utm_campaign', slug)
    dest = url.toString()
  } catch {
    // affiliate_url is not a valid absolute URL - redirect as-is
  }

  redirect(dest)
}
