import { notFound } from 'next/navigation'
import LogoImage from '@/components/ui/LogoImage'
import Link from 'next/link'
import { createStaticClient } from '@/lib/supabase'
import { TOP10_LISTS, getList } from '@/data/top10'
import AuthorBio from '@/components/layout/AuthorBio'
import type { Metadata } from 'next'

export const revalidate = 604800

// --- Types ---

interface ToolRow {
  slug: string
  name: string
  tagline: string
  logo_url: string | null
  website_url: string | null
  pricing_type: string
  pricing_free_tier: boolean
  pricing_starting_price: number | null
  rating: number
  review_count: number
  trending: boolean
}

// --- Data ---

async function getToolsForList(slugs: string[]): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase.from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,trending')
    .in('slug', slugs)
  if (!data) return []
  return slugs
    .map(s => data.find((t: ToolRow) => t.slug === s))
    .filter(Boolean) as ToolRow[]
}

export function generateStaticParams() {
  return TOP10_LISTS.map(l => ({ slug: l.slug }))
}

// --- Metadata ---

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const list = getList(slug)
  if (!list) return { title: 'Not found | MytheAi' }
  const year = new Date().getFullYear()
  const ogImage = `https://mytheai.com/api/og/blog?title=${encodeURIComponent(list.title + ' ' + year)}&category=${encodeURIComponent('Top 10')}`
  return {
    title: `${list.title} ${year}: Top ${list.slugs.length} Picks | MytheAi`,
    description: list.description,
    alternates: { canonical: `https://mytheai.com/top-10/${slug}` },
    openGraph: {
      title: `${list.title} ${year} | MytheAi`,
      description: list.description,
      url: `https://mytheai.com/top-10/${slug}`,
      images: [{ url: ogImage, width: 1200, height: 630, alt: list.title }],
    },
    twitter: {
      card: 'summary_large_image',
      title: `${list.title} ${year} | MytheAi`,
      description: list.description,
      images: [ogImage],
    },
  }
}

// --- Helpers ---

const PRICING_LABELS: Record<string, string> = {
  free: 'Free', freemium: 'Freemium', paid: 'Paid', ltd: 'Lifetime Deal',
}
const PRICING_COLORS: Record<string, string> = {
  free: 'bg-[#D1FAE5] text-[#065F46]',
  freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
  paid: 'bg-[#F3F4F6] text-[#374151]',
  ltd: 'bg-[#FEF3C7] text-[#92400E]',
}

const RANK_COLORS = ['#F59E0B', '#9CA3AF', '#92400E']


// --- Page ---

export default async function Top10Page({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const list = getList(slug)
  if (!list) notFound()

  const tools = await getToolsForList(list.slugs)
  const year = new Date().getFullYear()

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'ItemList',
    name: `${list.title} ${year}`,
    description: list.description,
    url: `https://mytheai.com/top-10/${slug}`,
    numberOfItems: tools.length,
    itemListElement: tools.map((t, i) => ({
      '@type': 'ListItem',
      position: i + 1,
      name: t.name,
      url: `https://mytheai.com/tools/${t.slug}`,
    })),
  }

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Top 10 Lists', item: 'https://mytheai.com/top-10' },
      { '@type': 'ListItem', position: 3, name: list.title, item: `https://mytheai.com/top-10/${slug}` },
    ],
  }

  const faqJsonLd = list.faqs && list.faqs.length > 0 ? {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: list.faqs.map(f => ({
      '@type': 'Question',
      name: f.q,
      acceptedAnswer: { '@type': 'Answer', text: f.a },
    })),
  } : null

  const pickFor = (toolSlug: string) => list.picks?.find(p => p.slug === toolSlug)

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />
      {faqJsonLd && (
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(faqJsonLd) }} />
      )}

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        {/* Breadcrumb */}
        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/tools" className="hover:text-blue-600 transition-colors">Tools</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{list.title}</span>
        </nav>

        {/* Header */}
        <div className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">
            Top {tools.length} · {list.category}
          </p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            {list.title} ({year})
          </h1>
          <p className="text-[15px] text-muted-foreground leading-relaxed mb-3">{list.description}</p>
          <p className="text-[12px] text-muted-foreground">
            Last updated: {new Date().toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}
          </p>
        </div>

        {/* Intro */}
        {list.intro && (
          <div className="mb-8">
            <p className="text-[15px] text-foreground leading-relaxed whitespace-pre-line">{list.intro}</p>
          </div>
        )}

        {/* Methodology */}
        {list.methodology && (
          <div className="mb-10 p-5 rounded-xl border border-border bg-card">
            <h2 className="text-[14px] font-bold text-foreground uppercase tracking-wider mb-2">How we picked</h2>
            <p className="text-[14px] text-muted-foreground leading-relaxed">{list.methodology}</p>
          </div>
        )}

        {/* Ranked list */}
        <ol className="space-y-6">
          {tools.map((tool, i) => {
            const pick = pickFor(tool.slug)
            return (
              <li key={tool.slug}>
                <div className="rounded-xl border border-border bg-card overflow-hidden">
                  <Link
                    href={`/tools/${tool.slug}`}
                    className="flex items-start gap-4 p-5 hover:bg-gray-50 dark:hover:bg-gray-900/40 transition-colors"
                  >
                    {/* Rank */}
                    <div
                      className="text-[22px] font-extrabold w-8 flex-shrink-0 leading-none pt-0.5"
                      style={{ color: RANK_COLORS[i] ?? '#D1D5DB' }}
                    >
                      {i + 1}
                    </div>

                    {/* Logo */}
                    <div className="w-11 h-11 rounded-xl border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                      <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={36} />
                    </div>

                    {/* Info */}
                    <div className="flex-1 min-w-0">
                      <div className="flex flex-wrap items-center gap-2 mb-1">
                        <span className="text-[15px] font-bold text-foreground">{tool.name}</span>
                        <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[tool.pricing_type]}`}>
                          {PRICING_LABELS[tool.pricing_type]}
                        </span>
                        {tool.trending && (
                          <span className="text-[11px] font-semibold text-[#F59E0B]">🔥 Trending</span>
                        )}
                      </div>
                      <p className="text-[13px] text-muted-foreground line-clamp-2 mb-2">{tool.tagline}</p>
                      <div className="flex items-center gap-3 text-[12px] text-muted-foreground">
                        <span className="text-[#F59E0B] font-semibold">★ {tool.rating.toFixed(1)}</span>
                        <span>{tool.review_count.toLocaleString()} reviews</span>
                        {tool.pricing_free_tier && <span className="text-[#10B981] font-medium">Free tier</span>}
                        {tool.pricing_starting_price && <span>From ${tool.pricing_starting_price}/mo</span>}
                      </div>
                    </div>

                    <span className="text-[13px] text-blue-600 font-medium flex-shrink-0 pt-0.5">Review →</span>
                  </Link>

                  {pick && (
                    <div className="border-t border-border px-5 py-4 space-y-3 text-[14px] leading-relaxed">
                      <p className="text-foreground">
                        <span className="font-semibold text-foreground">Why we picked it: </span>
                        <span className="text-muted-foreground">{pick.whyPicked}</span>
                      </p>
                      <p className="text-foreground">
                        <span className="font-semibold text-[#10B981]">Best for: </span>
                        <span className="text-muted-foreground">{pick.bestFor}</span>
                      </p>
                      <p className="text-foreground">
                        <span className="font-semibold text-[#F59E0B]">Limitation: </span>
                        <span className="text-muted-foreground">{pick.limitation}</span>
                      </p>
                    </div>
                  )}
                </div>
              </li>
            )
          })}
        </ol>

        {/* Bottom line */}
        {list.bottomLine && (
          <div className="mt-10 p-6 rounded-xl border-2 border-blue-100 dark:border-blue-900/40 bg-blue-50/50 dark:bg-blue-950/20">
            <h2 className="text-[14px] font-bold text-blue-700 dark:text-blue-300 uppercase tracking-wider mb-2">Bottom line</h2>
            <p className="text-[15px] text-foreground leading-relaxed">{list.bottomLine}</p>
          </div>
        )}

        {/* FAQs */}
        {list.faqs && list.faqs.length > 0 && (
          <div className="mt-10">
            <h2 className="text-[20px] md:text-[24px] font-extrabold tracking-tight text-foreground mb-5">
              Frequently asked questions
            </h2>
            <div className="space-y-3">
              {list.faqs.map((faq, idx) => (
                <details
                  key={idx}
                  className="group rounded-xl border border-border bg-card overflow-hidden"
                >
                  <summary className="flex items-center justify-between gap-4 px-5 py-4 cursor-pointer list-none hover:bg-gray-50 dark:hover:bg-gray-900/40 transition-colors">
                    <span className="text-[15px] font-semibold text-foreground">{faq.q}</span>
                    <svg className="w-4 h-4 text-muted-foreground transition-transform group-open:rotate-180 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24" aria-hidden="true">
                      <polyline points="6 9 12 15 18 9" />
                    </svg>
                  </summary>
                  <div className="px-5 pb-4 text-[14px] text-muted-foreground leading-relaxed">{faq.a}</div>
                </details>
              ))}
            </div>
          </div>
        )}

        {/* Author */}
        <div className="mt-10">
          <AuthorBio context="curated" />
        </div>

        {/* Disclosure */}
        <div className="mt-6 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          <strong>Disclosure:</strong> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Rankings are based on <Link href="/methodology" className="text-blue-600 hover:underline">editorial merit</Link>. Affiliate relationships never influence placement.
        </div>

        <Link href="/tools" className="inline-block mt-6 text-[13px] text-blue-600 hover:underline">
          ← Browse all tools
        </Link>
      </div>
    </>
  )
}
