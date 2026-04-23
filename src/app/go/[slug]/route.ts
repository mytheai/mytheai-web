import { redirect } from 'next/navigation'
import { mockTools } from '@/data/mock'

export async function GET(_req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const tool = mockTools.find(t => t.slug === slug)

  if (!tool) {
    redirect('/tools')
  }

  // TODO: log click to Supabase tool_clicks table when DB is set up

  redirect(tool.affiliate_url)
}
