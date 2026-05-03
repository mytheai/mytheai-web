import { notFound } from 'next/navigation'
import Link from 'next/link'
import LogoImage from '@/components/ui/LogoImage'
import AuthorBio from '@/components/layout/AuthorBio'
import { getAuthorJsonLd } from '@/data/authors'
import { createStaticClient } from '@/lib/supabase'
import type { Metadata } from 'next'

export const revalidate = 604800

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
  tags: string[]
  trending: boolean
  featured: boolean
}

const PRICING_LABELS: Record<string, string> = {
  free: 'Free', freemium: 'Freemium', paid: 'Paid', ltd: 'Lifetime Deal',
}

// Generate a per-alternative reasoning sentence from data signals.
// Compares rating, pricing, free-tier, and trending against the subject tool.
function altBlurb(alt: ToolRow, tool: ToolRow, primaryTag: string): string {
  const points: string[] = []
  if (alt.pricing_free_tier && !tool.pricing_free_tier) {
    points.push(`unlike ${tool.name}, ${alt.name} ships a free tier`)
  } else if (!alt.pricing_free_tier && tool.pricing_free_tier && alt.pricing_type !== 'free') {
    points.push(`paid only (${tool.name} has a free tier)`)
  }
  if (tool.pricing_starting_price && alt.pricing_starting_price) {
    if (alt.pricing_starting_price <= tool.pricing_starting_price * 0.7) {
      points.push(`starts at $${alt.pricing_starting_price}/mo, materially cheaper than ${tool.name} at $${tool.pricing_starting_price}/mo`)
    } else if (alt.pricing_starting_price >= tool.pricing_starting_price * 1.5) {
      points.push(`positioned higher in price ($${alt.pricing_starting_price}/mo vs ${tool.name} at $${tool.pricing_starting_price}/mo)`)
    }
  }
  if (alt.rating >= tool.rating + 0.2) {
    points.push(`rated ${alt.rating.toFixed(1)}/5 across ${alt.review_count.toLocaleString()} users, ahead of ${tool.name} at ${tool.rating.toFixed(1)}`)
  } else if (alt.rating <= tool.rating - 0.2) {
    points.push(`rated lower than ${tool.name} (${alt.rating.toFixed(1)} vs ${tool.rating.toFixed(1)})`)
  }
  if (alt.trending && !tool.trending) {
    points.push('currently trending in the category')
  }
  if (points.length === 0) {
    return `A direct competitor to ${tool.name} in the ${primaryTag} space, rated ${alt.rating.toFixed(1)}/5 by ${alt.review_count.toLocaleString()} users.`
  }
  const sentence = `${alt.name} is a strong ${primaryTag} alternative: ` + points.join('; ') + '.'
  return sentence
}

// Build a decision matrix mapping common decision criteria to specific alts.
function buildDecisionMatrix(alts: ToolRow[]): { criterion: string; pick: ToolRow; reason: string }[] {
  if (alts.length === 0) return []
  const out: { criterion: string; pick: ToolRow; reason: string }[] = []
  const seen = new Set<string>()
  // Highest rated
  const topRated = [...alts].sort((a, b) => b.rating - a.rating)[0]
  if (topRated) {
    out.push({ criterion: 'You want the highest-rated alternative', pick: topRated, reason: `Rated ${topRated.rating.toFixed(1)}/5 by ${topRated.review_count.toLocaleString()} users.` })
    seen.add(topRated.slug)
  }
  // Cheapest with starting price
  const priced = alts.filter(a => a.pricing_starting_price != null && !seen.has(a.slug))
  if (priced.length > 0) {
    const cheapest = priced.sort((a, b) => (a.pricing_starting_price ?? 0) - (b.pricing_starting_price ?? 0))[0]
    out.push({ criterion: 'Budget is the main constraint', pick: cheapest, reason: `Starts at $${cheapest.pricing_starting_price}/mo on the entry tier.` })
    seen.add(cheapest.slug)
  }
  // Best free tier
  const freeOption = alts.find(a => (a.pricing_type === 'free' || a.pricing_free_tier) && !seen.has(a.slug))
  if (freeOption) {
    out.push({ criterion: 'You want a free option to test first', pick: freeOption, reason: freeOption.pricing_type === 'free' ? 'Completely free, no paid tier.' : 'Includes a usable free tier with no credit card required.' })
    seen.add(freeOption.slug)
  }
  // Trending
  const trending = alts.find(a => a.trending && !seen.has(a.slug))
  if (trending) {
    out.push({ criterion: 'You want the fastest-growing tool', pick: trending, reason: `${trending.name} is currently trending in this category - rapid adoption signal.` })
    seen.add(trending.slug)
  }
  return out
}
const PRICING_COLORS: Record<string, string> = {
  free: 'bg-[#D1FAE5] text-[#065F46]',
  freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
  paid: 'bg-[#F3F4F6] text-[#374151]',
  ltd: 'bg-[#FEF3C7] text-[#92400E]',
}

async function getTool(slug: string): Promise<ToolRow | null> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,tags,trending,featured')
    .eq('slug', slug)
    .maybeSingle()
  return (data ?? null) as ToolRow | null
}

async function getAlternatives(tool: ToolRow): Promise<ToolRow[]> {
  if (!tool.tags || tool.tags.length === 0) return []
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,tags,trending,featured')
    .overlaps('tags', tool.tags)
    .neq('slug', tool.slug)
    .order('rating', { ascending: false })
    .limit(8)
  return (data ?? []) as ToolRow[]
}

export async function generateStaticParams() {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('slug')
    .or('trending.eq.true,featured.eq.true,editor_pick.eq.true')
    .limit(150)
  return (data ?? []).map(t => ({ slug: t.slug }))
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const tool = await getTool(slug)
  if (!tool) return { title: 'Not found | MytheAi' }
  const year = new Date().getFullYear()
  const title = `${tool.name} Alternatives ${year}: 8 Best Competitors Compared | MytheAi`
  const description = `Looking for ${tool.name} alternatives? Compare 8 top competitors side by side: features, pricing, ratings, and which to pick. Independent rankings, no pay-to-rank.`
  return {
    title,
    description,
    alternates: { canonical: `https://mytheai.com/alternatives/${slug}` },
    openGraph: {
      title,
      description,
      url: `https://mytheai.com/alternatives/${slug}`,
    },
  }
}

export default async function AlternativesPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const tool = await getTool(slug)
  if (!tool) notFound()

  const alternatives = await getAlternatives(tool)
  const year = new Date().getFullYear()
  const primaryTag = tool.tags?.[0] ?? 'AI'

  const collectionPageJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    name: `${tool.name} Alternatives ${year}`,
    description: `${alternatives.length} top competitors to ${tool.name} in ${year}, ranked by rating and adoption.`,
    url: `https://mytheai.com/alternatives/${tool.slug}`,
    inLanguage: 'en',
    isPartOf: { '@type': 'WebSite', name: 'MytheAi', url: 'https://mytheai.com' },
    author: getAuthorJsonLd(),
    publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
    dateModified: new Date().toISOString().slice(0, 10),
    mainEntity: {
      '@type': 'ItemList',
      name: `${tool.name} Alternatives ${year}`,
      numberOfItems: alternatives.length,
      itemListElement: alternatives.map((a, i) => ({
        '@type': 'ListItem',
        position: i + 1,
        name: a.name,
        url: `https://mytheai.com/tools/${a.slug}`,
      })),
    },
  }

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Tools', item: 'https://mytheai.com/tools' },
      { '@type': 'ListItem', position: 3, name: tool.name, item: `https://mytheai.com/tools/${tool.slug}` },
      { '@type': 'ListItem', position: 4, name: 'Alternatives', item: `https://mytheai.com/alternatives/${slug}` },
    ],
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(collectionPageJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        {/* Breadcrumb */}
        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/tools" className="hover:text-blue-600 transition-colors">Tools</Link>
          <span>/</span>
          <Link href={`/tools/${tool.slug}`} className="hover:text-blue-600 transition-colors">{tool.name}</Link>
          <span>/</span>
          <span className="text-foreground font-medium">Alternatives</span>
        </nav>

        {/* Header */}
        <div className="mb-8">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Alternatives · {primaryTag}</p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            {tool.name} Alternatives ({year})
          </h1>
          <p className="text-[16px] text-muted-foreground leading-relaxed">
            {alternatives.length} top competitors to {tool.name} in 2026, ranked by rating and real-world adoption. {tool.name} is a strong product, but it is not the only option, and pricing or workflow constraints often push users to look elsewhere. The list below covers the alternatives most teams actually consider.
          </p>
        </div>

        {/* Subject card */}
        <div className="mb-10 p-5 rounded-xl border border-border bg-card flex items-center gap-4">
          <div className="w-12 h-12 rounded-xl border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
            <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={40} />
          </div>
          <div className="flex-1 min-w-0">
            <p className="text-[13px] text-muted-foreground mb-0.5">Original tool</p>
            <p className="text-[15px] font-bold text-foreground truncate">{tool.name}</p>
            <p className="text-[12px] text-muted-foreground truncate">{tool.tagline}</p>
          </div>
          <Link
            href={`/tools/${tool.slug}`}
            className="text-[13px] text-blue-600 font-medium hover:underline flex-shrink-0"
          >
            View {tool.name} →
          </Link>
        </div>

        {/* Alternatives list */}
        {alternatives.length > 0 ? (
          <ol className="space-y-4 mb-10">
            {alternatives.map((alt, i) => {
              const comparePairSlug = `${tool.slug}-vs-${alt.slug}`
              return (
                <li key={alt.slug}>
                  <div className="rounded-xl border border-border bg-card overflow-hidden">
                    <Link
                      href={`/tools/${alt.slug}`}
                      className="flex items-start gap-4 p-5 hover:bg-gray-50 dark:hover:bg-gray-900/40 transition-colors"
                    >
                      <div className="text-[20px] font-extrabold text-muted-foreground w-7 flex-shrink-0 leading-none pt-0.5">
                        {i + 1}
                      </div>
                      <div className="w-11 h-11 rounded-xl border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                        <LogoImage src={alt.logo_url} websiteUrl={alt.website_url} name={alt.name} size={36} />
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="flex flex-wrap items-center gap-2 mb-1">
                          <span className="text-[15px] font-bold text-foreground">{alt.name}</span>
                          <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[alt.pricing_type]}`}>
                            {PRICING_LABELS[alt.pricing_type]}
                          </span>
                          {alt.trending && (
                            <span className="text-[11px] font-semibold text-[#F59E0B]">🔥 Trending</span>
                          )}
                        </div>
                        <p className="text-[13px] text-muted-foreground line-clamp-2 mb-2">{alt.tagline}</p>
                        <div className="flex items-center gap-3 text-[12px] text-muted-foreground">
                          <span className="text-[#F59E0B] font-semibold">★ {alt.rating.toFixed(1)}</span>
                          <span>{alt.review_count.toLocaleString()} reviews</span>
                          {alt.pricing_free_tier && <span className="text-[#10B981] font-medium">Free tier</span>}
                          {alt.pricing_starting_price && <span>From ${alt.pricing_starting_price}/mo</span>}
                        </div>
                      </div>
                    </Link>
                    <div className="border-t border-border px-5 py-4">
                      <p className="text-[13.5px] text-muted-foreground leading-relaxed mb-3">
                        {altBlurb(alt, tool, primaryTag)}
                      </p>
                      <div className="flex flex-wrap gap-3 text-[13px]">
                        <a
                          href={`/go/${alt.slug}`}
                          target="_blank"
                          rel="noopener noreferrer sponsored"
                          className="inline-flex items-center px-3 py-1.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[12px] transition-colors"
                        >
                          Try {alt.name} →
                        </a>
                        <Link
                          href={`/compare/${comparePairSlug}`}
                          className="text-blue-600 font-medium hover:underline self-center"
                        >
                          Compare {tool.name} vs {alt.name} →
                        </Link>
                        <Link
                          href={`/alternatives/${alt.slug}`}
                          className="text-muted-foreground hover:text-blue-600 transition-colors self-center"
                        >
                          {alt.name} alternatives
                        </Link>
                      </div>
                    </div>
                  </div>
                </li>
              )
            })}
          </ol>
        ) : (
          <div className="mb-10 p-6 rounded-xl border border-border bg-card text-center">
            <p className="text-[14px] text-muted-foreground">No alternatives found in the same category yet. Browse <Link href="/tools" className="text-blue-600 hover:underline">all tools</Link> instead.</p>
          </div>
        )}

        {/* Decision matrix */}
        {(() => {
          const matrix = buildDecisionMatrix(alternatives)
          if (matrix.length === 0) return null
          return (
            <section className="mb-10">
              <h2 className="text-[20px] font-bold text-foreground mb-3">Quick decision matrix</h2>
              <p className="text-[14px] text-muted-foreground leading-relaxed mb-4">
                Most users land on this page with one decision criterion top of mind. Here is the alternative we recommend for each common scenario.
              </p>
              <ol className="space-y-3">
                {matrix.map((m, i) => (
                  <li key={i} className="p-4 rounded-xl border border-border bg-card">
                    <p className="text-[14px] text-foreground mb-1">
                      <span className="font-bold">{m.criterion}: </span>
                      <Link href={`/tools/${m.pick.slug}`} className="text-blue-600 font-bold hover:underline">{m.pick.name}</Link>
                    </p>
                    <p className="text-[13px] text-muted-foreground leading-relaxed">{m.reason}</p>
                  </li>
                ))}
              </ol>
            </section>
          )
        })()}

        {/* Why look for alternatives */}
        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-3">Why people look for {tool.name} alternatives</h2>
          <p className="text-[15px] text-muted-foreground leading-relaxed mb-3">
            Most users who search for an alternative are not unhappy with {tool.name} - they are checking whether a different tool fits their specific workflow better. Common reasons include pricing that does not match the budget, a missing integration with the rest of the stack, a different team size or use case, or a free tier that opens up experimentation without commitment.
          </p>
          <p className="text-[15px] text-muted-foreground leading-relaxed">
            All {alternatives.length} tools above operate in the same {primaryTag} space and have been independently scored on our seven-criteria framework. <Link href="/methodology" className="text-blue-600 hover:underline">See methodology</Link>.
          </p>
        </section>

        {/* Author */}
        <div className="mb-8">
          <AuthorBio context="curated" />
        </div>

        {/* Disclosure */}
        <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          <strong>Disclosure:</strong> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Rankings are based on <Link href="/methodology" className="text-blue-600 hover:underline">editorial merit</Link>. Affiliate relationships never influence placement.
        </div>

      </div>
    </>
  )
}
