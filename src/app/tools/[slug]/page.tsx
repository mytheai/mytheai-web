import { notFound } from 'next/navigation'
import Image from 'next/image'
import Link from 'next/link'
import { createClient, createStaticClient } from '@/lib/supabase'
import type { Metadata } from 'next'

export const revalidate = 86400

// --- Types ---

interface ToolRow {
  id: string
  slug: string
  name: string
  tagline: string
  description: string | null
  logo_url: string | null
  website_url: string | null
  affiliate_url: string | null
  pricing_type: 'free' | 'freemium' | 'paid' | 'ltd'
  pricing_free_tier: boolean
  pricing_starting_price: number | null
  rating: number
  review_count: number
  featured: boolean
  trending: boolean
  editor_pick: boolean
  tags: string[] | null
  pros: string[] | null
  cons: string[] | null
  use_cases: string[] | null
  updated_at: string
}

// --- Data fetching ---

async function getTool(slug: string): Promise<ToolRow | null> {
  const supabase = await createClient()
  const { data, error } = await supabase
    .from('tools')
    .select('*')
    .eq('slug', slug)
    .single()
  if (error || !data) return null
  return data as ToolRow
}

interface AltTool {
  id: string
  slug: string
  name: string
  tagline: string
  logo_url: string | null
  website_url: string | null
  pricing_type: string
  rating: number
}

function getAltLogoSrc(alt: AltTool): string | null {
  if (alt.logo_url) return alt.logo_url
  if (alt.website_url) {
    try {
      return `https://www.google.com/s2/favicons?domain=${new URL(alt.website_url).hostname}&sz=64`
    } catch {
      return null
    }
  }
  return null
}

async function getAlternatives(currentSlug: string, tags: string[]): Promise<AltTool[]> {
  if (!tags || tags.length === 0) return []
  const supabase = await createClient()
  const { data } = await supabase
    .from('tools')
    .select('id, slug, name, tagline, logo_url, website_url, pricing_type, rating')
    .contains('tags', [tags[0]])
    .neq('slug', currentSlug)
    .order('rating', { ascending: false })
    .limit(3)
  return (data ?? []) as AltTool[]
}

export async function generateStaticParams() {
  const supabase = createStaticClient()
  const { data } = await supabase.from('tools').select('slug')
  return (data ?? []).map((t: { slug: string }) => ({ slug: t.slug }))
}

// --- Dynamic metadata ---

export async function generateMetadata(
  { params }: { params: Promise<{ slug: string }> }
): Promise<Metadata> {
  const { slug } = await params
  const tool = await getTool(slug)
  if (!tool) return { title: 'Tool not found | MytheAi' }

  const year = new Date().getFullYear()
  const ogImageUrl = `https://mytheai.com/api/og?name=${encodeURIComponent(tool.name)}&tagline=${encodeURIComponent(tool.tagline)}&rating=${tool.rating}${tool.logo_url ? `&logo=${encodeURIComponent(tool.logo_url)}` : ''}`
  return {
    title: `${tool.name} Review ${year}: Pricing, Features & Alternatives | MytheAi`,
    description: tool.tagline,
    openGraph: {
      title: `${tool.name} Review ${year} | MytheAi`,
      description: tool.tagline,
      url: `https://mytheai.com/tools/${slug}`,
      images: [{ url: ogImageUrl, width: 1200, height: 630 }],
    },
    twitter: {
      card: 'summary_large_image',
      images: [ogImageUrl],
    },
    alternates: { canonical: `https://mytheai.com/tools/${slug}` },
  }
}

// --- Helpers ---

const PRICING_LABELS: Record<string, string> = {
  free: 'Free',
  freemium: 'Freemium',
  paid: 'Paid',
  ltd: 'Lifetime Deal',
}

const PRICING_COLORS: Record<string, string> = {
  free: 'bg-[#D1FAE5] text-[#065F46]',
  freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
  paid: 'bg-[#F3F4F6] text-[#374151]',
  ltd: 'bg-[#FEF3C7] text-[#92400E]',
}

function Stars({ rating }: { rating: number }) {
  return (
    <span className="flex items-center gap-1">
      <span className="text-[#F59E0B] text-[15px]">{'★'.repeat(Math.floor(rating))}{'☆'.repeat(5 - Math.floor(rating))}</span>
      <span className="font-semibold text-foreground text-[15px]">{rating.toFixed(1)}</span>
    </span>
  )
}

// --- Page ---

export default async function ToolPage({
  params,
}: {
  params: Promise<{ slug: string }>
}) {
  const { slug } = await params
  const tool = await getTool(slug)
  if (!tool) notFound()

  const alternatives = await getAlternatives(slug, tool.tags ?? [])
  const year = new Date().getFullYear()
  const updatedDate = new Date(tool.updated_at).toLocaleDateString('en-US', {
    month: 'long', year: 'numeric',
  })

  // JSON-LD structured data
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'SoftwareApplication',
    name: tool.name,
    description: tool.tagline,
    applicationCategory: 'WebApplication',
    operatingSystem: 'Web',
    url: tool.website_url ?? '',
    offers: {
      '@type': 'Offer',
      price: tool.pricing_starting_price ?? 0,
      priceCurrency: 'USD',
    },
    aggregateRating: tool.review_count > 0 ? {
      '@type': 'AggregateRating',
      ratingValue: tool.rating,
      reviewCount: tool.review_count,
    } : undefined,
  }

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      <div className="max-w-4xl mx-auto px-4 md:px-5 py-10 md:py-14">

        {/* Breadcrumb */}
        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/tools" className="hover:text-blue-600 transition-colors">Tools</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{tool.name}</span>
        </nav>

        {/* Hero */}
        <div className="flex flex-col sm:flex-row sm:items-start gap-5 mb-8">
          {(() => {
            const src = tool.logo_url || (tool.website_url ? (() => { try { return `https://www.google.com/s2/favicons?domain=${new URL(tool.website_url!).hostname}&sz=64` } catch { return null } })() : null)
            return (
              <div className="w-16 h-16 rounded-xl border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                {src ? (
                  <Image src={src} alt={tool.name} width={48} height={48} unoptimized />
                ) : (
                  <span className="text-[22px] font-bold text-gray-400">{tool.name[0]}</span>
                )}
              </div>
            )
          })()}
          <div className="flex-1 min-w-0">
            <div className="flex flex-wrap items-center gap-2 mb-1">
              <h1 className="text-[26px] md:text-[32px] font-extrabold tracking-tight text-foreground">
                {tool.name}
              </h1>
              <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[tool.pricing_type]}`}>
                {PRICING_LABELS[tool.pricing_type]}
              </span>
              {tool.editor_pick && (
                <span className="text-[11px] font-semibold px-2 py-0.5 rounded-full bg-[#EFF6FF] text-[#1E40AF]">
                  Editor's Pick
                </span>
              )}
            </div>
            <p className="text-[16px] text-muted-foreground mb-3">{tool.tagline}</p>
            <div className="flex flex-wrap items-center gap-4">
              <Stars rating={tool.rating} />
              <span className="text-[13px] text-muted-foreground">
                {tool.review_count.toLocaleString()} reviews
              </span>
              {tool.trending && (
                <span className="text-[12px] font-semibold text-[#F59E0B]">🔥 Trending</span>
              )}
            </div>
            <p className="text-[12px] text-muted-foreground mt-2">
              Last verified: {updatedDate}
            </p>
          </div>
        </div>

        {/* CTA */}
        <div className="flex flex-wrap gap-3 mb-10">
          <a
            href={`/go/${tool.slug}`}
            target="_blank"
            rel="noopener noreferrer sponsored"
            className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[14px] transition-colors"
          >
            Visit {tool.name} →
          </a>
          {tool.website_url && (
            <a
              href={tool.website_url}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg border border-border bg-card hover:border-blue-300 text-foreground font-medium text-[14px] transition-colors"
            >
              Official site ↗
            </a>
          )}
        </div>

        <div className="grid md:grid-cols-3 gap-8">

          {/* Main content */}
          <div className="md:col-span-2 space-y-8">

            {/* Description */}
            <section>
              <h2 className="text-[18px] font-bold text-foreground mb-3">
                About {tool.name}
              </h2>
              {tool.description
                ? (tool.description || '').split('\n\n').filter(Boolean).map((para, i) => (
                    <p key={i} className="text-[15px] text-muted-foreground leading-relaxed mb-3 last:mb-0">
                      {para}
                    </p>
                  ))
                : (
                  <p className="text-[15px] text-muted-foreground leading-relaxed">
                    {tool.tagline} Visit the official site to learn more about features, pricing, and integrations.
                  </p>
                )
              }
            </section>

            {/* Pros & Cons */}
            {((tool.pros && tool.pros.length > 0) || (tool.cons && tool.cons.length > 0)) && (
              <section>
                <h2 className="text-[18px] font-bold text-foreground mb-4">Pros & Cons</h2>
                <div className="grid sm:grid-cols-2 gap-4">
                  {tool.pros && tool.pros.length > 0 && (
                    <div className="border border-border rounded-xl p-4 bg-card">
                      <p className="text-[12px] font-bold uppercase tracking-wide text-[#10B981] mb-3">Pros</p>
                      <ul className="space-y-2">
                        {tool.pros.map((pro, i) => (
                          <li key={i} className="flex items-start gap-2 text-[13px] text-foreground">
                            <span className="text-[#10B981] mt-0.5 flex-shrink-0">✓</span>
                            {pro}
                          </li>
                        ))}
                      </ul>
                    </div>
                  )}
                  {tool.cons && tool.cons.length > 0 && (
                    <div className="border border-border rounded-xl p-4 bg-card">
                      <p className="text-[12px] font-bold uppercase tracking-wide text-[#EF4444] mb-3">Cons</p>
                      <ul className="space-y-2">
                        {tool.cons.map((con, i) => (
                          <li key={i} className="flex items-start gap-2 text-[13px] text-foreground">
                            <span className="text-[#EF4444] mt-0.5 flex-shrink-0">✗</span>
                            {con}
                          </li>
                        ))}
                      </ul>
                    </div>
                  )}
                </div>
              </section>
            )}

            {/* Use Cases */}
            {tool.use_cases && tool.use_cases.length > 0 && (
              <section>
                <h2 className="text-[18px] font-bold text-foreground mb-3">Best Use Cases</h2>
                <ul className="space-y-2">
                  {tool.use_cases.map((uc, i) => (
                    <li key={i} className="flex items-start gap-2 text-[14px] text-muted-foreground">
                      <span className="text-blue-600 mt-0.5 flex-shrink-0">→</span>
                      {uc}
                    </li>
                  ))}
                </ul>
              </section>
            )}

            {/* Tags */}
            {tool.tags && tool.tags.length > 0 && (
              <section>
                <h2 className="text-[18px] font-bold text-foreground mb-3">Categories</h2>
                <div className="flex flex-wrap gap-2">
                  {tool.tags.map(tag => (
                    <Link
                      key={tag}
                      href={`/tools?category=${tag}`}
                      className="px-3 py-1 rounded-full text-[12px] font-medium border border-border bg-card text-muted-foreground hover:border-blue-300 hover:text-blue-600 transition-colors"
                    >
                      {tag}
                    </Link>
                  ))}
                </div>
              </section>
            )}

            {/* Affiliate disclosure */}
            <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
              <strong>Disclosure:</strong> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Our rankings are never influenced by affiliate relationships.
            </div>
          </div>

          {/* Sidebar */}
          <div className="space-y-5">

            {/* Pricing card */}
            <div className="border border-border rounded-xl p-5 bg-card">
              <h3 className="text-[14px] font-bold text-foreground mb-3">Pricing</h3>
              <div className="space-y-2.5">
                <div className="flex items-center justify-between text-[13px]">
                  <span className="text-muted-foreground">Plan type</span>
                  <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[tool.pricing_type]}`}>
                    {PRICING_LABELS[tool.pricing_type]}
                  </span>
                </div>
                <div className="flex items-center justify-between text-[13px]">
                  <span className="text-muted-foreground">Free tier</span>
                  <span className="font-medium text-foreground">
                    {tool.pricing_free_tier ? '✓ Available' : '✗ No'}
                  </span>
                </div>
                {tool.pricing_starting_price != null && (
                  <div className="flex items-center justify-between text-[13px]">
                    <span className="text-muted-foreground">Starting at</span>
                    <span className="font-semibold text-foreground">
                      ${tool.pricing_starting_price}/mo
                    </span>
                  </div>
                )}
                <p className="text-[11px] text-muted-foreground pt-1">
                  As of {updatedDate}. Verify on official site.
                </p>
              </div>
              <a
                href={`/go/${tool.slug}`}
                target="_blank"
                rel="noopener noreferrer sponsored"
                className="mt-4 w-full inline-flex items-center justify-center gap-2 px-4 py-2 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[13px] transition-colors"
              >
                Get {tool.name} →
              </a>
            </div>

            {/* Rating card */}
            <div className="border border-border rounded-xl p-5 bg-card">
              <h3 className="text-[14px] font-bold text-foreground mb-3">MytheAi Rating</h3>
              <div className="flex items-center gap-3 mb-2">
                <span className="text-[36px] font-extrabold text-foreground leading-none">
                  {tool.rating.toFixed(1)}
                </span>
                <div>
                  <Stars rating={tool.rating} />
                  <p className="text-[12px] text-muted-foreground mt-0.5">
                    {tool.review_count.toLocaleString()} reviews
                  </p>
                </div>
              </div>
            </div>

            {/* Last verified */}
            <p className="text-[12px] text-muted-foreground px-1">
              Last verified: {updatedDate}
            </p>
          </div>
        </div>

        {/* Alternatives */}
        {alternatives.length > 0 && (
          <div className="mt-12 pt-8 border-t border-border">
            <h2 className="text-[18px] font-bold text-foreground mb-4">
              Alternatives to {tool.name}
            </h2>
            <div className="grid sm:grid-cols-3 gap-3">
              {alternatives.map(alt => {
                const altLogo = getAltLogoSrc(alt)
                return (
                <Link
                  key={alt.slug}
                  href={`/tools/${alt.slug}`}
                  className="flex items-start gap-3 p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors"
                >
                  <div className="w-9 h-9 rounded-lg border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                    {altLogo ? (
                      <Image src={altLogo} alt={alt.name} width={28} height={28} unoptimized />
                    ) : (
                      <span className="text-[13px] font-bold text-gray-400">{alt.name[0]}</span>
                    )}
                  </div>
                  <div className="min-w-0">
                    <p className="text-[13px] font-semibold text-foreground truncate">{alt.name}</p>
                    <p className="text-[12px] text-muted-foreground line-clamp-2">{alt.tagline}</p>
                    <p className="text-[11px] text-[#F59E0B] mt-1">★ {alt.rating.toFixed(1)}</p>
                  </div>
                </Link>
                )
              })}
            </div>
          </div>
        )}

        {/* Review title for SEO */}
        <div className="mt-12 pt-8 border-t border-border">
          <h2 className="text-[20px] font-bold text-foreground mb-2">
            {tool.name} Review ({year}): Is It Worth It?
          </h2>
          <p className="text-[15px] text-muted-foreground">
            {tool.name} is a <strong>{PRICING_LABELS[tool.pricing_type].toLowerCase()}</strong> tool
            {tool.pricing_free_tier ? ' with a free tier available' : ''}.
            It holds a rating of <strong>{tool.rating.toFixed(1)}/5</strong> based on {tool.review_count.toLocaleString()} reviews.
            {tool.trending ? ' Currently trending among users.' : ''}
          </p>
          <Link
            href="/tools"
            className="inline-block mt-4 text-[13px] text-blue-600 hover:underline"
          >
            ← Browse all tools
          </Link>
        </div>

      </div>
    </>
  )
}
