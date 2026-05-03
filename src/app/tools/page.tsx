import { Suspense } from 'react'
import Link from 'next/link'
import { getTranslations } from 'next-intl/server'
import ToolCard from '@/components/tools/ToolCard'
import SearchFilterBar from '@/components/tools/SearchFilterBar'
import { createClient } from '@/lib/supabase'
import type { Tool } from '@/types'

export const revalidate = 3600

export const metadata = {
  title: 'All AI & SaaS Tools 2026 - Browse 500+ Tools | MytheAi',
  description: 'Browse and filter 500+ AI & SaaS tools by category, pricing, and rating. Find the right tool for your workflow.',
}

const PAGE_SIZE = 24

function buildPageUrl(
  params: { category?: string; pricing?: string; q?: string; sort?: string },
  page: number
) {
  const url = new URLSearchParams()
  if (params.category) url.set('category', params.category)
  if (params.pricing) url.set('pricing', params.pricing)
  if (params.q) url.set('q', params.q)
  if (params.sort) url.set('sort', params.sort)
  if (page > 1) url.set('page', String(page))
  const str = url.toString()
  return `/tools${str ? `?${str}` : ''}`
}

async function getTools(
  category?: string, pricing?: string, q?: string, sort?: string, page = 1
): Promise<{ tools: Tool[]; total: number }> {
  const supabase = await createClient()
  let query = supabase.from('tools').select('*', { count: 'exact' })

  if (sort === 'newest') {
    query = query.order('updated_at', { ascending: false })
  } else if (sort === 'name') {
    query = query.order('name', { ascending: true })
  } else {
    query = query.order('featured', { ascending: false }).order('rating', { ascending: false })
  }

  if (category) query = query.contains('tags', [category])
  if (pricing) query = query.eq('pricing_type', pricing)
  if (q) query = query.or(`name.ilike.%${q}%,tagline.ilike.%${q}%`)

  const offset = (page - 1) * PAGE_SIZE
  const { data, error, count } = await query.range(offset, offset + PAGE_SIZE - 1)
  if (error || !data) return { tools: [], total: 0 }

  const tools = data.map(row => ({
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

  return { tools, total: count ?? 0 }
}

export default async function ToolsPage({
  searchParams,
}: {
  searchParams: Promise<{ category?: string; pricing?: string; q?: string; sort?: string; page?: string }>
}) {
  const { category, pricing, q, sort, page: pageParam } = await searchParams
  const page = Math.max(1, parseInt(pageParam ?? '1') || 1)
  const [{ tools, total }, t] = await Promise.all([
    getTools(category, pricing, q, sort, page),
    getTranslations('ToolsPage'),
  ])
  const totalPages = Math.ceil(total / PAGE_SIZE)
  const filterParams = { category, pricing, q, sort }
  const totalDisplay = total.toLocaleString()
  const from = total === 0 ? 0 : (page - 1) * PAGE_SIZE + 1
  const to = Math.min(page * PAGE_SIZE, total)

  return (
    <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-8">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">{t('eyebrow')}</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          {t('title')}
        </h1>
        <p className="text-[15px] text-muted-foreground">
          {t('intro', { count: totalDisplay })}
        </p>
      </div>

      <Suspense fallback={<div className="h-16" />}>
        <SearchFilterBar
          basePath="/tools"
          showCategory
          showPricing
          showSort
          searchPlaceholder={t('searchPlaceholder', { count: totalDisplay })}
        />
      </Suspense>

      {tools.length > 0 ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {tools.map(tool => (
            <ToolCard key={tool.id} tool={tool} />
          ))}
        </div>
      ) : (
        <div className="py-20 text-center">
          <p className="text-muted-foreground text-[15px]">{t('noResults')}</p>
          <a href="/tools" className="mt-3 inline-block text-blue-600 text-[14px] hover:underline">{t('clearFilters')}</a>
        </div>
      )}

      <div className="mt-8 flex flex-col sm:flex-row items-center justify-between gap-4">
        <p className="text-[13px] text-muted-foreground">
          {t('showing', { from, to, total: totalDisplay })}
          {q ? ` ${t('showingFor', { q })}` : ''}
          {category ? ` ${t('showingIn', { category })}` : ''}
        </p>

        {totalPages > 1 && (
          <div className="flex items-center gap-2">
            {page > 1 ? (
              <Link
                href={buildPageUrl(filterParams, page - 1)}
                className="px-3 py-1.5 rounded-lg border border-border text-[13px] font-medium text-muted-foreground hover:border-blue-300 hover:text-blue-600 transition-colors"
              >
                {t('previous')}
              </Link>
            ) : (
              <span className="px-3 py-1.5 rounded-lg border border-border text-[13px] font-medium text-muted-foreground opacity-40 cursor-not-allowed">{t('previous')}</span>
            )}
            <span className="text-[13px] text-muted-foreground px-2">
              {t('pageOfPages', { page, total: totalPages })}
            </span>
            {page < totalPages ? (
              <Link
                href={buildPageUrl(filterParams, page + 1)}
                className="px-3 py-1.5 rounded-lg border border-border text-[13px] font-medium text-muted-foreground hover:border-blue-300 hover:text-blue-600 transition-colors"
              >
                {t('next')}
              </Link>
            ) : (
              <span className="px-3 py-1.5 rounded-lg border border-border text-[13px] font-medium text-muted-foreground opacity-40 cursor-not-allowed">{t('next')}</span>
            )}
          </div>
        )}
      </div>

    </div>
  )
}
