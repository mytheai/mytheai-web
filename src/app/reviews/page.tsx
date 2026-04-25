import { createStaticClient } from '@/lib/supabase'
import Link from 'next/link'
import Image from 'next/image'
import type { Metadata } from 'next'

export const revalidate = 86400

export const metadata: Metadata = {
  title: 'AI Tool Reviews 2026 — Expert Analysis & Ratings | MytheAi',
  description: 'In-depth reviews of the best AI and SaaS tools. Honest ratings, verified pricing, pros & cons — updated regularly by our editorial team.',
  alternates: { canonical: 'https://mytheai.com/reviews' },
  openGraph: {
    title: 'AI Tool Reviews 2026 — Expert Analysis & Ratings | MytheAi',
    url: 'https://mytheai.com/reviews',
  },
}

interface ReviewRow {
  slug: string
  name: string
  tagline: string
  logo_url: string | null
  rating: number
  review_count: number
  pricing_type: string
  tags: string[]
  updated_at: string
}

async function getReviewedTools(): Promise<ReviewRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('slug, name, tagline, logo_url, rating, review_count, pricing_type, tags, updated_at')
    .order('rating', { ascending: false })
    .limit(30)

  return (data ?? []) as ReviewRow[]
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

export default async function ReviewsPage() {
  const tools = await getReviewedTools()

  return (
    <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-8">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">Expert Reviews</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          AI Tool Reviews
        </h1>
        <p className="text-[15px] text-muted-foreground">
          {tools.length} tools reviewed — ranked by editorial rating. Each review covers pricing, pros & cons, and real use cases.
        </p>
      </div>

      <div className="space-y-3">
        {tools.map((tool, index) => {
          const badge = pricingLabel(tool.pricing_type)
          const logoSrc = tool.logo_url || `https://www.google.com/s2/favicons?domain=${tool.slug}.com&sz=64`
          return (
            <div key={tool.slug} className="flex items-center gap-4 border border-border rounded-xl p-4 bg-card hover:border-[#93C5FD] transition-colors">
              {/* Rank */}
              <span className="text-[13px] font-bold text-muted-foreground w-6 text-right flex-shrink-0">
                {index + 1}
              </span>

              {/* Logo */}
              <div className="logo-sm flex-shrink-0" style={{ background: '#f0f0f0' }}>
                <Image
                  src={logoSrc}
                  alt={tool.name}
                  width={34}
                  height={34}
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

      <div className="mt-10 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
        <span className="font-semibold">Affiliate Disclosure:</span> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Our rankings are never influenced by affiliate relationships.{' '}
        <Link href="/about#affiliate" className="text-[#2563EB] hover:underline">Learn more</Link>.
      </div>
    </div>
  )
}
