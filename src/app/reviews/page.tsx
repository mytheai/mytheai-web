import { Suspense } from 'react'
import { createStaticClient } from '@/lib/supabase'
import Link from 'next/link'
import { getTranslations } from 'next-intl/server'
import LogoImage from '@/components/ui/LogoImage'
import SearchFilterBar from '@/components/tools/SearchFilterBar'
import type { Metadata } from 'next'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'AI Tool Reviews 2026: Expert Analysis & Ratings | MytheAi',
  description: 'In-depth reviews of the best AI and SaaS tools. Honest ratings, verified pricing, pros and cons, updated regularly by our editorial team.',
  alternates: { canonical: 'https://mytheai.com/reviews' },
  openGraph: {
    title: 'AI Tool Reviews 2026: Expert Analysis & Ratings | MytheAi',
    url: 'https://mytheai.com/reviews',
  },
}

interface ReviewRow {
  slug: string
  name: string
  tagline: string
  logo_url: string | null
  website_url: string | null
  rating: number
  review_count: number
  pricing_type: string
  tags: string[]
  updated_at: string
}

const PAGE_SIZE = 40
const HARD_CAP = 200
const DEFAULT_MIN_RATING = 4.0

async function getReviewedTools(
  q?: string,
  category?: string,
  min_rating?: string,
): Promise<{ rows: ReviewRow[]; total: number }> {
  const supabase = createStaticClient()
  const effectiveMin = min_rating ? parseFloat(min_rating) : DEFAULT_MIN_RATING

  let query = supabase
    .from('tools')
    .select('slug, name, tagline, logo_url, website_url, rating, review_count, pricing_type, tags, updated_at', { count: 'exact' })
    .gte('rating', effectiveMin)
    .order('rating', { ascending: false })
    .order('review_count', { ascending: false })

  if (q) query = query.or(`name.ilike.%${q}%,tagline.ilike.%${q}%`)
  if (category) query = query.contains('tags', [category])

  query = query.limit(HARD_CAP)

  const { data, count } = await query
  return { rows: (data ?? []) as ReviewRow[], total: count ?? 0 }
}

function pricingLabel(type: string) {
  if (type === 'free') return { label: 'Free', className: 'bf' }
  if (type === 'freemium') return { label: 'Freemium', className: 'bfm' }
  if (type === 'ltd') return { label: 'LTD', className: 'bltd' }
  return { label: 'Paid', className: 'bp' }
}

function StarRating({ rating }: { rating: number }) {
  return (
    <span className="flex items-center gap-1 text-[13px]">
      <span className="text-amber-400">★</span>
      <span className="font-semibold text-foreground">{rating.toFixed(1)}</span>
    </span>
  )
}

function formatDate(iso: string) {
  if (!iso) return ''
  return new Date(iso).toLocaleDateString('en-US', { month: 'short', year: 'numeric' })
}

export default async function ReviewsPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string; category?: string; min_rating?: string; page?: string }>
}) {
  const { q, category, min_rating, page } = await searchParams
  const [{ rows: allTools, total }, t] = await Promise.all([
    getReviewedTools(q, category, min_rating),
    getTranslations('HubPages'),
  ])

  const pageNum = Math.max(1, parseInt(page ?? '1', 10) || 1)
  const totalPages = Math.max(1, Math.ceil(allTools.length / PAGE_SIZE))
  const safePage = Math.min(pageNum, totalPages)
  const start = (safePage - 1) * PAGE_SIZE
  const tools = allTools.slice(start, start + PAGE_SIZE)

  const baseQuery = new URLSearchParams()
  if (q) baseQuery.set('q', q)
  if (category) baseQuery.set('category', category)
  if (min_rating) baseQuery.set('min_rating', min_rating)
  const baseQueryStr = baseQuery.toString()

  function pageHref(p: number) {
    const next = new URLSearchParams(baseQueryStr)
    if (p > 1) next.set('page', String(p))
    const qs = next.toString()
    return qs ? `/reviews?${qs}` : '/reviews'
  }

  const effectiveMin = min_rating ? parseFloat(min_rating) : DEFAULT_MIN_RATING

  return (
    <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-8">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">{t('reviewsEyebrow')}</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          {t('reviewsTitle')}
        </h1>
        <p className="text-[15px] text-muted-foreground">
          {t('reviewsIntro', { count: total.toLocaleString(), minRating: effectiveMin.toFixed(1) })}
        </p>
      </div>

      <Suspense fallback={<div className="h-16" />}>
        <SearchFilterBar
          basePath="/reviews"
          showCategory
          showMinRating
          searchPlaceholder="Search reviews..."
        />
      </Suspense>

      {tools.length > 0 ? (
        <div className="space-y-3">
          {tools.map((tool, index) => {
            const badge = pricingLabel(tool.pricing_type)
            const rank = start + index + 1
            return (
              <div key={tool.slug} className="flex items-center gap-4 border border-border rounded-xl p-4 bg-card hover:border-[#93C5FD] transition-colors">
                {/* Rank */}
                <span className="text-[13px] font-bold text-muted-foreground w-6 text-right flex-shrink-0">
                  {rank}
                </span>

                {/* Logo */}
                <div className="logo-sm flex-shrink-0 flex items-center justify-center" style={{ background: '#f0f0f0' }}>
                  <LogoImage
                    src={tool.logo_url}
                    websiteUrl={tool.website_url}
                    name={tool.name}
                    size={34}
                    className="rounded"
                  />
                </div>

                {/* Info */}
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 mb-0.5">
                    <span className="text-[14px] font-semibold text-foreground">{tool.name}</span>
                    <span className={badge.className}>{badge.label}</span>
                  </div>
                  <p className="text-[13px] text-muted-foreground truncate">{tool.tagline}</p>
                </div>

                {/* Rating */}
                <div className="hidden sm:flex flex-col items-end gap-1 flex-shrink-0">
                  <StarRating rating={tool.rating} />
                  {tool.updated_at && (
                    <span className="text-[11px] text-muted-foreground">Updated {formatDate(tool.updated_at)}</span>
                  )}
                </div>

                {/* CTA */}
                <Link
                  href={`/tools/${tool.slug}`}
                  className="flex-shrink-0 text-[13px] font-semibold text-[#2563EB] hover:text-[#1D4ED8] transition-colors whitespace-nowrap"
                >
                  Read Review →
                </Link>
              </div>
            )
          })}
        </div>
      ) : (
        <div className="py-16 text-center">
          <p className="text-muted-foreground text-[15px]">No reviews found for this filter.</p>
          <Link href="/reviews" className="mt-3 inline-block text-blue-600 text-[14px] hover:underline">Clear filters</Link>
        </div>
      )}

      {totalPages > 1 && (
        <nav className="mt-8 flex items-center justify-center gap-2" aria-label="Pagination">
          {safePage > 1 ? (
            <Link
              href={pageHref(safePage - 1)}
              className="h-9 px-3 inline-flex items-center rounded-lg border border-border bg-surface text-[13px] text-foreground hover:border-blue-400 transition-colors"
            >
              ← Prev
            </Link>
          ) : (
            <span className="h-9 px-3 inline-flex items-center rounded-lg border border-border bg-surface text-[13px] text-muted-foreground opacity-50">← Prev</span>
          )}

          <span className="text-[13px] text-muted-foreground px-3">
            Page {safePage} of {totalPages}
          </span>

          {safePage < totalPages ? (
            <Link
              href={pageHref(safePage + 1)}
              className="h-9 px-3 inline-flex items-center rounded-lg border border-border bg-surface text-[13px] text-foreground hover:border-blue-400 transition-colors"
            >
              Next →
            </Link>
          ) : (
            <span className="h-9 px-3 inline-flex items-center rounded-lg border border-border bg-surface text-[13px] text-muted-foreground opacity-50">Next →</span>
          )}
        </nav>
      )}

      <div className="mt-10 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
        <span className="font-semibold">Affiliate Disclosure:</span> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Our rankings are never influenced by affiliate relationships.{' '}
        <Link href="/about#affiliate" className="text-[#2563EB] hover:underline">Learn more</Link>.
      </div>
    </div>
  )
}
