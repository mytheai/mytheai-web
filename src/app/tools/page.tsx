import { Suspense } from 'react'
import { unstable_cache } from 'next/cache'
import ToolCard from '@/components/tools/ToolCard'
import FilterBar from '@/components/tools/FilterBar'
import { supabase } from '@/lib/supabase'
import type { Tool } from '@/types'

export const revalidate = 3600

export const metadata = {
  title: 'All AI & SaaS Tools 2026 - Browse 500+ Tools | MytheAi',
  description: 'Browse and filter 500+ AI & SaaS tools by category, pricing, and rating. Find the right tool for your workflow.',
}

const getTools = unstable_cache(
  async (category?: string, pricing?: string): Promise<Tool[]> => {
  let query = supabase.from('tools').select('*').order('featured', { ascending: false }).order('rating', { ascending: false })

  if (category) {
    query = query.contains('tags', [category])
  }
  if (pricing) {
    query = query.eq('pricing_type', pricing)
  }

  const { data, error } = await query
  if (error || !data) return []

  return data.map(row => ({
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
    pros: [],
    cons: [],
    use_cases: [],
    integrations: [],
    alternatives: [],
  }))
  },
  ['tools-list'],
  { revalidate: 3600 }
)

export default async function ToolsPage({
  searchParams,
}: {
  searchParams: Promise<{ category?: string; pricing?: string }>
}) {
  const { category, pricing } = await searchParams
  const tools = await getTools(category, pricing)

  return (
    <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">

      {/* Page header */}
      <div className="mb-8">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Directory</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          All AI & SaaS Tools
        </h1>
        <p className="text-[15px] text-muted-foreground">
          500+ tools reviewed, compared, and ranked. Filter by category, pricing, or use case.
        </p>
      </div>

      {/* Filters — client component needs Suspense for useSearchParams */}
      <Suspense fallback={<div className="h-20" />}>
        <FilterBar />
      </Suspense>

      {/* Tool grid */}
      {tools.length > 0 ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {tools.map(tool => (
            <ToolCard key={tool.id} tool={tool} />
          ))}
        </div>
      ) : (
        <div className="py-20 text-center">
          <p className="text-muted-foreground text-[15px]">No tools found for this filter.</p>
          <a href="/tools" className="mt-3 inline-block text-blue-600 text-[14px] hover:underline">Clear filters</a>
        </div>
      )}

      {/* Tool count */}
      <p className="mt-8 text-[13px] text-muted-foreground">
        Showing {tools.length} tool{tools.length !== 1 ? 's' : ''}
        {category ? ` in ${category}` : ''}
        {pricing ? ` · ${pricing}` : ''}
      </p>

    </div>
  )
}
