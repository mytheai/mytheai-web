import { createStaticClient } from '@/lib/supabase'
import ToolCard from '@/components/tools/ToolCard'
import type { Tool } from '@/types'
import type { Metadata } from 'next'

export const revalidate = 86400

export const metadata: Metadata = {
  title: 'Best Free & Freemium AI Tools 2026 | MytheAi',
  description: 'The best AI tools with a free tier. No credit card required to get started. Ranked by rating.',
  alternates: { canonical: 'https://mytheai.com/deals' },
  openGraph: {
    title: 'Best Free & Freemium AI Tools 2026 | MytheAi',
    url: 'https://mytheai.com/deals',
  },
}

async function getFreeTools(): Promise<Tool[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('*')
    .eq('pricing_free_tier', true)
    .order('rating', { ascending: false })

  return (data ?? []).map(row => ({
    id: row.id,
    slug: row.slug,
    name: row.name,
    tagline: row.tagline,
    description: row.description ?? '',
    logo_url: row.logo_url ?? '',
    website_url: row.website_url ?? '',
    affiliate_url: row.affiliate_url ?? '',
    category: [],
    tags: row.tags ?? [],
    pricing_type: row.pricing_type,
    pricing_details: {
      free_tier: row.pricing_free_tier ?? false,
      starting_price: row.pricing_starting_price ?? undefined,
    },
    rating: row.rating ?? 0,
    review_count: row.review_count ?? 0,
    featured: row.featured ?? false,
    trending: row.trending ?? false,
    editor_pick: row.editor_pick ?? false,
    updated_at: row.updated_at ?? '',
    pros: row.pros ?? [],
    cons: row.cons ?? [],
    use_cases: row.use_cases ?? [],
    integrations: [],
    alternatives: [],
  }))
}

export default async function DealsPage() {
  const tools = await getFreeTools()

  return (
    <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-8">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#10B981] mb-1">Free & Freemium</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          Best AI Tools With a Free Tier
        </h1>
        <p className="text-[15px] text-muted-foreground">
          {tools.length} tools you can start using today. No credit card required.
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
        {tools.map(tool => (
          <ToolCard key={tool.slug} tool={tool} />
        ))}
      </div>

      <div className="mt-10 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
        <strong>Note:</strong> Free tiers may have usage limits. Always verify current pricing on the tool&apos;s website before committing.
      </div>
    </div>
  )
}
