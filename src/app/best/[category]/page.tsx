import { notFound } from 'next/navigation'
import LogoImage from '@/components/ui/LogoImage'
import Link from 'next/link'
import { createStaticClient } from '@/lib/supabase'
import { getList } from '@/data/top10'
import AuthorBio from '@/components/layout/AuthorBio'
import { getAuthorJsonLd } from '@/data/authors'
import ScrollNewsletter from '@/components/newsletter/ScrollNewsletter'
import type { Metadata } from 'next'

export const revalidate = 604800

const CATEGORY_TO_TOP10_SLUG: Record<string, string> = {
  writing: 'best-ai-writing-tools',
  coding: 'best-code-ai-tools',
  seo: 'best-ai-seo-tools',
  video: 'best-ai-video-tools',
  image: 'best-ai-image-generators',
  agents: 'best-ai-agent-tools',
  automation: 'best-workflow-automation-tools',
  sales: 'best-ai-sales-tools',
  'customer-support': 'best-ai-customer-service-tools',
  legal: 'best-ai-legal-tools',
  finance: 'best-ai-tools-for-finance',
  healthcare: 'best-ai-healthcare-tools',
  marketing: 'best-ai-marketing-tools',
  design: 'best-ai-design-tools',
  research: 'best-ai-research-tools',
  productivity: 'best-ai-productivity-tools',
}

const CATEGORY_LABELS: Record<string, string> = {
  writing: 'Writing',
  coding: 'Coding',
  seo: 'SEO',
  video: 'Video',
  image: 'Image',
  agents: 'AI Agents',
  automation: 'Automation',
  sales: 'Sales',
  'customer-support': 'Customer Support',
  legal: 'Legal',
  finance: 'Finance',
  healthcare: 'Healthcare',
  marketing: 'Marketing',
  design: 'Design',
  research: 'Research',
  productivity: 'Productivity',
}

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
  tested_by: string | null
  last_tested_at: string | null
  hands_on_notes: string | null
}

async function getToolsForList(slugs: string[]): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase.from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,trending,tested_by,last_tested_at,hands_on_notes')
    .in('slug', slugs)
  if (!data) return []
  return slugs
    .map(s => data.find((t: ToolRow) => t.slug === s))
    .filter(Boolean) as ToolRow[]
}

export function generateStaticParams() {
  return Object.keys(CATEGORY_TO_TOP10_SLUG).map(category => ({ category }))
}

export async function generateMetadata({ params }: { params: Promise<{ category: string }> }): Promise<Metadata> {
  const { category } = await params
  const top10Slug = CATEGORY_TO_TOP10_SLUG[category]
  if (!top10Slug) return { title: 'Not found | MytheAi' }
  const list = getList(top10Slug)
  if (!list) return { title: 'Not found | MytheAi' }
  const year = new Date().getFullYear()
  const label = CATEGORY_LABELS[category]
  const title = `Best AI ${label} Tools ${year}: Hand-Tested Top ${list.slugs.length} Picks | MytheAi`
  const ogImage = `https://mytheai.com/api/og/blog?title=${encodeURIComponent(`Best AI ${label} Tools ${year}`)}&category=${encodeURIComponent('Money Page')}`
  return {
    title,
    description: list.description,
    alternates: { canonical: `https://mytheai.com/best/${category}` },
    openGraph: {
      title,
      description: list.description,
      url: `https://mytheai.com/best/${category}`,
      images: [{ url: ogImage, width: 1200, height: 630, alt: `Best AI ${label} Tools ${year}` }],
    },
    twitter: {
      card: 'summary_large_image',
      title,
      description: list.description,
      images: [ogImage],
    },
  }
}

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

function handsOnExcerpt(notes: string, maxLen: number = 280): string {
  const firstPara = notes.split('\n\n')[0] ?? notes
  if (firstPara.length <= maxLen) return firstPara
  const truncated = firstPara.slice(0, maxLen)
  const lastSpace = truncated.lastIndexOf(' ')
  return (lastSpace > 0 ? truncated.slice(0, lastSpace) : truncated) + '...'
}

export default async function BestCategoryPage({ params }: { params: Promise<{ category: string }> }) {
  const { category } = await params
  const top10Slug = CATEGORY_TO_TOP10_SLUG[category]
  if (!top10Slug) notFound()
  const list = getList(top10Slug)
  if (!list) notFound()

  const tools = await getToolsForList(list.slugs)
  const year = new Date().getFullYear()
  const label = CATEGORY_LABELS[category]

  const authorJsonLd = getAuthorJsonLd()
  const todayIso = new Date().toISOString().slice(0, 10)
  const handsOnCount = tools.filter(t => t.tested_by && t.hands_on_notes).length

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'ItemList',
    name: `Best AI ${label} Tools ${year}`,
    description: list.description,
    url: `https://mytheai.com/best/${category}`,
    numberOfItems: tools.length,
    itemListElement: tools.map((t, i) => ({
      '@type': 'ListItem',
      position: i + 1,
      name: t.name,
      url: `https://mytheai.com/tools/${t.slug}`,
      item: {
        '@type': 'Review',
        itemReviewed: {
          '@type': 'SoftwareApplication',
          name: t.name,
          applicationCategory: 'WebApplication',
          operatingSystem: 'Web',
          url: `https://mytheai.com/tools/${t.slug}`,
        },
        reviewRating: {
          '@type': 'Rating',
          ratingValue: t.rating,
          bestRating: 5,
          worstRating: 1,
        },
        author: authorJsonLd,
        publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
        position: i + 1,
        datePublished: todayIso,
      },
    })),
  }

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Best AI Tools', item: 'https://mytheai.com/best' },
      { '@type': 'ListItem', position: 3, name: `Best AI ${label} Tools`, item: `https://mytheai.com/best/${category}` },
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

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/tools" className="hover:text-blue-600 transition-colors">Tools</Link>
          <span>/</span>
          <span className="text-foreground font-medium">Best AI {label} Tools</span>
        </nav>

        <div className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-emerald-700 mb-1">
            Hand-Tested · Top {tools.length} {label}
          </p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            Best AI {label} Tools ({year})
          </h1>
          <p className="text-[15px] text-muted-foreground leading-relaxed mb-3">{list.description}</p>
          <div className="flex flex-wrap items-center gap-3 text-[12px] text-muted-foreground">
            <span>Last updated: {new Date().toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}</span>
            {handsOnCount > 0 && (
              <>
                <span>·</span>
                <span className="inline-flex items-center gap-1 text-emerald-700 dark:text-emerald-400 font-medium">
                  <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" strokeWidth="3" viewBox="0 0 24 24" aria-hidden="true">
                    <polyline points="20 6 9 17 4 12" />
                  </svg>
                  {handsOnCount} hand-tested by John Pham
                </span>
              </>
            )}
          </div>
        </div>

        {list.intro && (
          <div className="mb-8">
            <p className="text-[15px] text-foreground leading-relaxed whitespace-pre-line">{list.intro}</p>
          </div>
        )}

        {list.methodology && (
          <div className="mb-10 p-5 rounded-xl border border-border bg-card">
            <h2 className="text-[14px] font-bold text-foreground uppercase tracking-wider mb-2">How we picked</h2>
            <p className="text-[14px] text-muted-foreground leading-relaxed">{list.methodology}</p>
          </div>
        )}

        <ol className="space-y-6">
          {tools.map((tool, i) => {
            const pick = pickFor(tool.slug)
            const hasHandsOn = tool.tested_by && tool.hands_on_notes
            return (
              <li key={tool.slug}>
                <div className="rounded-xl border border-border bg-card overflow-hidden">
                  <div className="flex items-start gap-4 p-5">
                    <div
                      className="text-[22px] font-extrabold w-8 flex-shrink-0 leading-none pt-0.5"
                      style={{ color: RANK_COLORS[i] ?? '#D1D5DB' }}
                    >
                      {i + 1}
                    </div>

                    <Link
                      href={`/tools/${tool.slug}`}
                      className="w-11 h-11 rounded-xl border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden hover:border-blue-300 transition-colors"
                    >
                      <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={36} />
                    </Link>

                    <div className="flex-1 min-w-0">
                      <div className="flex flex-wrap items-center gap-2 mb-1">
                        <Link href={`/tools/${tool.slug}`} className="text-[15px] font-bold text-foreground hover:text-blue-600 transition-colors">
                          {tool.name}
                        </Link>
                        <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[tool.pricing_type]}`}>
                          {PRICING_LABELS[tool.pricing_type]}
                        </span>
                        {hasHandsOn && (
                          <span className="inline-flex items-center gap-1 text-[10px] font-bold uppercase tracking-wider px-2 py-0.5 rounded-full bg-emerald-100 dark:bg-emerald-900/40 text-emerald-800 dark:text-emerald-300">
                            <svg className="w-3 h-3" fill="none" stroke="currentColor" strokeWidth="3" viewBox="0 0 24 24" aria-hidden="true">
                              <polyline points="20 6 9 17 4 12" />
                            </svg>
                            Hand-tested
                          </span>
                        )}
                        {tool.trending && !hasHandsOn && (
                          <span className="text-[11px] font-semibold text-[#F59E0B]">🔥 Trending</span>
                        )}
                      </div>
                      <p className="text-[13px] text-muted-foreground line-clamp-2 mb-2">{tool.tagline}</p>
                      <div className="flex items-center gap-3 text-[12px] text-muted-foreground flex-wrap">
                        <span className="text-[#F59E0B] font-semibold">★ {tool.rating.toFixed(1)}</span>
                        <span>{tool.review_count.toLocaleString()} reviews</span>
                        {tool.pricing_free_tier && <span className="text-[#10B981] font-medium">Free tier</span>}
                        {tool.pricing_starting_price && <span>From ${tool.pricing_starting_price}/mo</span>}
                      </div>
                    </div>

                    <div className="flex flex-col gap-2 flex-shrink-0">
                      <a
                        href={`/go/${tool.slug}`}
                        target="_blank"
                        rel="noopener noreferrer sponsored"
                        className="inline-flex items-center justify-center px-3 py-1.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[12px] transition-colors whitespace-nowrap plausible-event-name=Outbound plausible-event-tool=best"
                        data-tool={tool.slug}
                      >
                        Try {tool.name} →
                      </a>
                      <Link
                        href={`/tools/${tool.slug}`}
                        className="inline-flex items-center justify-center px-3 py-1.5 rounded-lg border border-border hover:border-blue-300 text-foreground font-medium text-[12px] transition-colors whitespace-nowrap"
                      >
                        Review →
                      </Link>
                    </div>
                  </div>

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

                  {hasHandsOn && tool.hands_on_notes && (
                    <div className="border-t border-emerald-200/60 dark:border-emerald-900/40 bg-emerald-50/40 dark:bg-emerald-950/10 px-5 py-4 text-[14px] leading-relaxed">
                      <div className="flex flex-wrap items-center gap-2 mb-2">
                        <span className="text-[10px] font-bold uppercase tracking-[0.1em] text-emerald-800 dark:text-emerald-300">
                          Hands-on excerpt
                        </span>
                        {tool.last_tested_at && (
                          <span className="text-[11px] text-muted-foreground">
                            · Tested {new Date(tool.last_tested_at).toLocaleDateString('en-US', { month: 'short', year: 'numeric' })}
                          </span>
                        )}
                      </div>
                      <p className="text-muted-foreground mb-2">{handsOnExcerpt(tool.hands_on_notes)}</p>
                      <Link
                        href={`/tools/${tool.slug}#hands-on`}
                        className="inline-flex items-center text-[13px] font-medium text-emerald-700 dark:text-emerald-400 hover:underline"
                      >
                        Read full hands-on review →
                      </Link>
                    </div>
                  )}
                </div>
              </li>
            )
          })}
        </ol>

        {list.bottomLine && (
          <div className="mt-10 p-6 rounded-xl border-2 border-blue-100 dark:border-blue-900/40 bg-blue-50/50 dark:bg-blue-950/20">
            <h2 className="text-[14px] font-bold text-blue-700 dark:text-blue-300 uppercase tracking-wider mb-2">Bottom line</h2>
            <p className="text-[15px] text-foreground leading-relaxed">{list.bottomLine}</p>
          </div>
        )}

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

        <div className="mt-10">
          <AuthorBio context="curated" />
        </div>

        <div className="mt-6 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          <strong>Disclosure:</strong> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Rankings are based on <Link href="/methodology" className="text-blue-600 hover:underline">editorial merit</Link>. Affiliate relationships never influence placement.
        </div>

        <Link href="/tools" className="inline-block mt-6 text-[13px] text-blue-600 hover:underline">
          ← Browse all tools
        </Link>
      </div>
      <ScrollNewsletter />
    </>
  )
}
