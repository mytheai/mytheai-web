import { notFound } from 'next/navigation'
import LogoImage from '@/components/ui/LogoImage'
import ToolScreenshot from '@/components/ui/ToolScreenshot'
import Link from 'next/link'
import { getTranslations } from 'next-intl/server'
import { createClient, createStaticClient } from '@/lib/supabase'
import ReviewForm from '@/components/reviews/ReviewForm'
import ReviewList, { getApprovedReviews } from '@/components/reviews/ReviewList'
import ScoringTable from '@/components/tools/ScoringTable'
import StickyMobileCTA from '@/components/tools/StickyMobileCTA'
import SourcesBlock from '@/components/tools/SourcesBlock'
import VerifyExternalBlock from '@/components/tools/VerifyExternalBlock'
import AuthorBio from '@/components/layout/AuthorBio'
import { getAuthorJsonLd } from '@/data/authors'
import { isValidScores, isValidEvidence, type ToolScores, type ToolScoresEvidence } from '@/lib/scoring'
import { linkGlossary } from '@/lib/glossary-linker'
import { TOP10_LISTS } from '@/data/top10'
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
  pricing_verified_at: string | null
  rating: number
  review_count: number
  featured: boolean
  trending: boolean
  editor_pick: boolean
  tags: string[] | null
  pros: string[] | null
  cons: string[] | null
  use_cases: string[] | null
  scores: ToolScores | null
  scores_evidence: ToolScoresEvidence | null
  updated_at: string
}

interface RelatedCompare {
  slug: string
  tool_a_slug: string
  tool_b_slug: string
  winner: string | null
  summary: string | null
}

interface RelatedTop10 {
  slug: string
  title: string
  emoji: string
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

async function getRelatedCompares(slug: string): Promise<RelatedCompare[]> {
  const supabase = await createClient()
  const { data } = await supabase
    .from('comparisons')
    .select('slug, tool_a_slug, tool_b_slug, winner, summary')
    .or(`tool_a_slug.eq.${slug},tool_b_slug.eq.${slug}`)
    .limit(8)
  return (data ?? []) as RelatedCompare[]
}

function getRelatedTop10(slug: string): RelatedTop10[] {
  return TOP10_LISTS
    .filter(l => l.slugs.includes(slug))
    .slice(0, 6)
    .map(l => ({ slug: l.slug, title: l.title, emoji: l.emoji }))
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
  const baseDesc = tool.tagline ?? ''
  const description = baseDesc.length < 80
    ? `${baseDesc}. Read our ${year} review: pricing, features, pros, cons, and best alternatives.`
    : baseDesc
  const ogImageUrl = `https://mytheai.com/api/og?name=${encodeURIComponent(tool.name)}&tagline=${encodeURIComponent(tool.tagline)}&rating=${tool.rating}${tool.logo_url ? `&logo=${encodeURIComponent(tool.logo_url)}` : ''}`
  return {
    title: `${tool.name} Review ${year}: Pricing, Features & Alternatives | MytheAi`,
    description,
    openGraph: {
      title: `${tool.name} Review ${year} | MytheAi`,
      description,
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

// Build an editor's verdict paragraph from data signals.
// Used in the prominent verdict block above About.
function buildEditorVerdict(tool: ToolRow): string {
  const lines: string[] = []
  const pricingDescriptor = PRICING_LABELS_HELPER[tool.pricing_type] ?? tool.pricing_type
  if (tool.rating >= 4.5) {
    lines.push(`${tool.name} is one of the strongest ${pricingDescriptor.toLowerCase()} tools in its category, rated ${tool.rating.toFixed(1)}/5 by ${tool.review_count.toLocaleString()} users.`)
  } else if (tool.rating >= 4.0) {
    lines.push(`${tool.name} is a solid ${pricingDescriptor.toLowerCase()} pick, rated ${tool.rating.toFixed(1)}/5 by ${tool.review_count.toLocaleString()} users.`)
  } else {
    lines.push(`${tool.name} is a ${pricingDescriptor.toLowerCase()} tool with a ${tool.rating.toFixed(1)}/5 user rating across ${tool.review_count.toLocaleString()} reviews.`)
  }
  if (tool.use_cases && tool.use_cases.length > 0) {
    const top = tool.use_cases.slice(0, 2).map(u => u.toLowerCase().replace(/\.$/, ''))
    lines.push(`Best for ${top.join(' and ')}.`)
  }
  if (tool.pros && tool.pros.length > 0) {
    const standout = tool.pros[0].trim().replace(/\.$/, '')
    lines.push(`Standout: ${standout.charAt(0).toLowerCase() + standout.slice(1)}.`)
  }
  if (tool.cons && tool.cons.length > 0) {
    const caveat = tool.cons[0].trim().replace(/\.$/, '')
    lines.push(`Watch out: ${caveat.charAt(0).toLowerCase() + caveat.slice(1)}.`)
  }
  if (tool.pricing_type === 'free') {
    lines.push('Fully free with no paid tier.')
  } else if (tool.pricing_free_tier && tool.pricing_starting_price) {
    lines.push(`Has a free tier; paid plans start at $${tool.pricing_starting_price}/mo.`)
  } else if (tool.pricing_starting_price) {
    lines.push(`Starts at $${tool.pricing_starting_price}/mo with no free tier.`)
  }
  return lines.join(' ')
}

const PRICING_LABELS_HELPER: Record<string, string> = {
  free: 'Free',
  freemium: 'Freemium',
  paid: 'Paid',
  ltd: 'Lifetime Deal',
}

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

  const [alternatives, userReviews, relatedCompares] = await Promise.all([
    getAlternatives(slug, tool.tags ?? []),
    getApprovedReviews(slug),
    getRelatedCompares(slug),
  ])
  const relatedTop10 = getRelatedTop10(slug)
  const year = new Date().getFullYear()
  const updatedDate = new Date(tool.updated_at).toLocaleDateString('en-US', {
    month: 'long', year: 'numeric',
  })
  const pricingVerifiedDate = new Date(tool.pricing_verified_at ?? tool.updated_at).toLocaleDateString('en-US', {
    month: 'long', year: 'numeric',
  })
  const scoresValid = isValidScores(tool.scores)
  const scores = scoresValid ? (tool.scores as ToolScores) : null
  const evidence = isValidEvidence(tool.scores_evidence) ? tool.scores_evidence : null
  const t = await getTranslations('ToolDetail')

  // Combined aggregate: editorial baseline (tool.rating, tool.review_count)
  // plus approved user reviews. User-weighted rating ranks higher with more user input.
  const userReviewCount = userReviews.length
  const userRatingSum = userReviews.reduce((s, r) => s + r.rating, 0)
  const totalReviewCount = tool.review_count + userReviewCount
  const totalRating = totalReviewCount > 0
    ? (tool.rating * tool.review_count + userRatingSum) / totalReviewCount
    : tool.rating

  // FAQ data
  const faqs = [
    {
      q: `Is ${tool.name} free?`,
      a: tool.pricing_type === 'free'
        ? `Yes, ${tool.name} is completely free to use with no paid tiers.`
        : tool.pricing_free_tier
        ? `${tool.name} offers a free tier with limited features. Paid plans start from $${tool.pricing_starting_price ?? 'varies'}/month.`
        : `${tool.name} does not have a free plan. Paid plans start from $${tool.pricing_starting_price ?? 'varies'}/month - check the official site for current pricing.`,
    },
    {
      q: `What is ${tool.name} best for?`,
      a: tool.use_cases && tool.use_cases.length > 0
        ? `${tool.name} is best suited for: ${tool.use_cases.slice(0, 3).join(', ')}.`
        : `${tool.name} is a ${PRICING_LABELS[tool.pricing_type].toLowerCase()} tool rated ${tool.rating.toFixed(1)}/5 by ${tool.review_count.toLocaleString()} users.`,
    },
    {
      q: `How does ${tool.name} compare to alternatives?`,
      a: `${tool.name} holds a rating of ${tool.rating.toFixed(1)}/5 from ${tool.review_count.toLocaleString()} reviews. Browse our comparison pages to see detailed side-by-side breakdowns against similar tools.`,
    },
    ...(tool.pricing_starting_price
      ? [{
          q: `What does ${tool.name} cost?`,
          a: `${tool.name} starts at $${tool.pricing_starting_price}/month${tool.pricing_free_tier ? ' and includes a free tier' : ''}. Pricing may vary by plan and region - always verify on the official site.`,
        }]
      : []),
  ]

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
    aggregateRating: totalReviewCount > 0 ? {
      '@type': 'AggregateRating',
      ratingValue: Number(totalRating.toFixed(2)),
      reviewCount: totalReviewCount,
    } : undefined,
  }

  // Editorial review JSON-LD with Person author for E-E-A-T
  const editorialReviewJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Review',
    itemReviewed: {
      '@type': 'SoftwareApplication',
      name: tool.name,
      applicationCategory: 'WebApplication',
      url: `https://mytheai.com/tools/${slug}`,
    },
    reviewRating: {
      '@type': 'Rating',
      ratingValue: tool.rating,
      bestRating: 5,
      worstRating: 1,
    },
    name: `${tool.name} editorial review`,
    reviewBody: tool.tagline,
    author: getAuthorJsonLd(),
    publisher: {
      '@type': 'Organization',
      name: 'MytheAi',
      url: 'https://mytheai.com',
    },
    datePublished: tool.updated_at,
    dateModified: tool.updated_at,
  }

  const faqJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: faqs.map(faq => ({
      '@type': 'Question',
      name: faq.q,
      acceptedAnswer: { '@type': 'Answer', text: faq.a },
    })),
  }

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Tools', item: 'https://mytheai.com/tools' },
      { '@type': 'ListItem', position: 3, name: tool.name, item: `https://mytheai.com/tools/${slug}` },
    ],
  }

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(editorialReviewJsonLd) }}
      />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(faqJsonLd) }}
      />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }}
      />

      <div className="max-w-4xl mx-auto px-4 md:px-5 py-10 md:py-14 pb-24 md:pb-14">

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
          <div className="w-16 h-16 rounded-xl border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
            <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={48} letterClassName="text-[22px] font-bold text-gray-400" />
          </div>
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
                  {(await getTranslations('HomeSections'))('editorTitle')}
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
                <span className="text-[12px] font-semibold text-[#F59E0B]">{t('trending')}</span>
              )}
            </div>
            <p className="text-[12px] text-muted-foreground mt-2 flex flex-wrap items-center gap-1.5">
              <span className="inline-flex items-center gap-1 text-emerald-700 dark:text-emerald-400 font-semibold">
                <svg className="w-3.5 h-3.5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                  <path fillRule="evenodd" d="M16.7 5.3a1 1 0 010 1.4l-7 7a1 1 0 01-1.4 0l-3-3a1 1 0 111.4-1.4L9 11.6l6.3-6.3a1 1 0 011.4 0z" clipRule="evenodd" />
                </svg>
                Verified by editorial
              </span>
              <span className="text-muted-foreground/60">·</span>
              <span>{t('lastUpdated')}: {updatedDate}</span>
              <span className="text-muted-foreground/60">·</span>
              <Link href="/methodology" className="text-blue-600 hover:underline">How we rank</Link>
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
            {t('visit', { name: tool.name })} →
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

        {/* Editor's verdict (auto-generated from data signals) */}
        <div className="mb-10 p-5 rounded-xl border-2 border-blue-100 dark:border-blue-900/40 bg-blue-50/50 dark:bg-blue-950/20">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-700 dark:text-blue-300 mb-2">Editor&apos;s verdict</p>
          <p className="text-[15px] text-foreground leading-relaxed">
            {buildEditorVerdict(tool)}
          </p>
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
                      {linkGlossary(para).map((seg, j) =>
                        seg.type === 'link' ? (
                          <Link key={j} href={seg.href} className="text-blue-600 hover:underline">{seg.value}</Link>
                        ) : (
                          <span key={j}>{seg.value}</span>
                        )
                      )}
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
                <h2 className="text-[18px] font-bold text-foreground mb-4">{t('prosAndCons')}</h2>
                <div className="grid sm:grid-cols-2 gap-4">
                  {tool.pros && tool.pros.length > 0 && (
                    <div className="border border-border rounded-xl p-4 bg-card">
                      <p className="text-[12px] font-bold uppercase tracking-wide text-[#10B981] mb-3">{t('pros')}</p>
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
                      <p className="text-[12px] font-bold uppercase tracking-wide text-[#EF4444] mb-3">{t('cons')}</p>
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
                <h2 className="text-[18px] font-bold text-foreground mb-3">{t('bestUseCases')}</h2>
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
                <h2 className="text-[18px] font-bold text-foreground mb-3">{t('categories')}</h2>
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

            {/* Screenshot */}
            <section>
              <h2 className="text-[18px] font-bold text-foreground mb-3">{t('preview', { name: tool.name })}</h2>
              <ToolScreenshot websiteUrl={tool.website_url} name={tool.name} />
              <p className="text-[12px] text-muted-foreground mt-2">
                Live screenshot of {tool.name} homepage. {tool.website_url && (
                  <a
                    href={tool.website_url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-blue-600 hover:underline"
                  >
                    Visit the site ↗
                  </a>
                )}
              </p>
            </section>

            {/* Affiliate disclosure */}
            <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
              <strong>Disclosure:</strong> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Our rankings are never influenced by affiliate relationships.
            </div>
          </div>

          {/* Sidebar */}
          <div className="space-y-5">

            {/* Pricing card */}
            <div className="border border-border rounded-xl p-5 bg-card">
              <h3 className="text-[14px] font-bold text-foreground mb-4">Pricing</h3>
              <div className="space-y-2 mb-4">
                {tool.pricing_type === 'free' && (
                  <div className="flex items-center justify-between px-3 py-2 rounded-lg bg-[#D1FAE5]/40">
                    <span className="text-[12px] font-semibold text-[#065F46]">Free</span>
                    <span className="text-[12px] font-bold text-[#065F46]">$0 / forever</span>
                  </div>
                )}
                {tool.pricing_type === 'ltd' && tool.pricing_starting_price != null && (
                  <div className="flex items-center justify-between px-3 py-2 rounded-lg bg-[#FEF3C7]/60">
                    <span className="text-[12px] font-semibold text-[#92400E]">Lifetime Deal</span>
                    <span className="text-[12px] font-bold text-[#92400E]">From ${tool.pricing_starting_price}</span>
                  </div>
                )}
                {(tool.pricing_type === 'freemium' || tool.pricing_type === 'paid') && (
                  <>
                    {tool.pricing_free_tier && (
                      <div className="flex items-center justify-between px-3 py-2 rounded-lg bg-[#D1FAE5]/40">
                        <span className="text-[12px] font-semibold text-[#065F46]">Free</span>
                        <span className="text-[12px] font-bold text-[#065F46]">$0 / mo</span>
                      </div>
                    )}
                    {tool.pricing_starting_price != null && (
                      <div className="flex items-center justify-between px-3 py-2 rounded-lg bg-[#EFF6FF]">
                        <span className="text-[12px] font-semibold text-[#1E40AF]">Pro</span>
                        <span className="text-[12px] font-bold text-[#1E40AF]">From ${tool.pricing_starting_price} / mo</span>
                      </div>
                    )}
                    <div className="flex items-center justify-between px-3 py-2 rounded-lg bg-[#F3F4F6]">
                      <span className="text-[12px] font-semibold text-[#374151]">Enterprise</span>
                      <span className="text-[12px] text-[#374151]">Custom</span>
                    </div>
                  </>
                )}
              </div>
              <p className="text-[11px] text-muted-foreground mb-4">
                Pricing verified {pricingVerifiedDate}. Verify current pricing on the official site before purchase.
              </p>
              <a
                href={`/go/${tool.slug}`}
                target="_blank"
                rel="noopener noreferrer sponsored"
                className="w-full inline-flex items-center justify-center gap-2 px-4 py-2 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[13px] transition-colors"
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

        {/* Editorial scoring breakdown */}
        {scores && <ScoringTable scores={scores} toolName={tool.name} evidence={evidence} />}

        {/* External sources bibliography (when seeded) */}
        <SourcesBlock evidence={evidence} verifiedDate={updatedDate} />

        {/* Programmatic third-party verification links (every tool) */}
        <VerifyExternalBlock name={tool.name} slug={tool.slug} websiteUrl={tool.website_url} />

        {/* Related comparisons + Top 10 lists - internal linking */}
        {(relatedCompares.length > 0 || relatedTop10.length > 0) && (
          <section className="mt-12 pt-8 border-t border-border">
            <h2 className="text-[18px] font-bold text-foreground mb-4">
              {tool.name} on MytheAi
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {relatedCompares.length > 0 && (
                <div className="p-5 rounded-xl border border-border bg-card">
                  <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-3">
                    {t('comparedWith', { name: tool.name })} ({relatedCompares.length})
                  </p>
                  <ul className="space-y-3">
                    {relatedCompares.map(c => {
                      const otherSlug = c.tool_a_slug === tool.slug ? c.tool_b_slug : c.tool_a_slug
                      const otherName = otherSlug.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ')
                      const winsHere = c.winner === tool.slug
                      const losesHere = c.winner && c.winner !== tool.slug
                      return (
                        <li key={c.slug} className="leading-snug">
                          <Link href={`/compare/${c.slug}`} className="text-[13px] font-semibold text-foreground hover:text-blue-600 hover:underline">
                            {tool.name} vs {otherName} →
                          </Link>
                          {winsHere && (
                            <span className="ml-2 text-[10px] font-bold uppercase tracking-wide text-emerald-700 dark:text-emerald-400">{tool.name} wins</span>
                          )}
                          {losesHere && (
                            <span className="ml-2 text-[10px] font-bold uppercase tracking-wide text-amber-700 dark:text-amber-400">{otherName} wins</span>
                          )}
                          {!c.winner && (
                            <span className="ml-2 text-[10px] font-bold uppercase tracking-wide text-muted-foreground">tie</span>
                          )}
                          {c.summary && (
                            <p className="text-[12px] text-muted-foreground mt-1 line-clamp-2">{c.summary}</p>
                          )}
                        </li>
                      )
                    })}
                  </ul>
                </div>
              )}
              {relatedTop10.length > 0 && (
                <div className="p-5 rounded-xl border border-border bg-card">
                  <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-3">
                    {t('rankedIn')} ({relatedTop10.length})
                  </p>
                  <ul className="space-y-2">
                    {relatedTop10.map(l => (
                      <li key={l.slug}>
                        <Link href={`/top-10/${l.slug}`} className="text-[13px] text-foreground hover:text-blue-600 hover:underline">
                          <span className="mr-1.5">{l.emoji}</span>{l.title} →
                        </Link>
                      </li>
                    ))}
                  </ul>
                </div>
              )}
            </div>
          </section>
        )}

        {/* User reviews */}
        <div className="mt-12 pt-8 border-t border-border">
          <div className="flex items-end justify-between mb-4">
            <h2 className="text-[18px] font-bold text-foreground">
              User reviews
              {userReviewCount > 0 && <span className="text-[13px] text-muted-foreground font-normal ml-2">({userReviewCount})</span>}
            </h2>
          </div>
          <div className="mb-5">
            <ReviewForm toolSlug={tool.slug} toolName={tool.name} />
          </div>
          <ReviewList toolSlug={tool.slug} />
        </div>

        {/* Alternatives */}
        {alternatives.length > 0 && (
          <div className="mt-12 pt-8 border-t border-border">
            <div className="flex items-end justify-between mb-4">
              <h2 className="text-[18px] font-bold text-foreground">
                Alternatives to {tool.name}
              </h2>
              <Link
                href={`/alternatives/${tool.slug}`}
                className="text-[13px] text-blue-600 font-medium hover:underline"
              >
                See all 8 →
              </Link>
            </div>
            <div className="grid sm:grid-cols-3 gap-3">
              {alternatives.map(alt => (
                <Link
                  key={alt.slug}
                  href={`/tools/${alt.slug}`}
                  className="flex items-start gap-3 p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors"
                >
                  <div className="w-9 h-9 rounded-lg border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                    <LogoImage src={alt.logo_url} websiteUrl={alt.website_url} name={alt.name} size={28} letterClassName="text-[13px] font-bold text-gray-400" />
                  </div>
                  <div className="min-w-0">
                    <p className="text-[13px] font-semibold text-foreground truncate">{alt.name}</p>
                    <p className="text-[12px] text-muted-foreground line-clamp-2">{alt.tagline}</p>
                    <p className="text-[11px] text-[#F59E0B] mt-1">★ {alt.rating.toFixed(1)}</p>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        )}

        {/* FAQ */}
        <div className="mt-12 pt-8 border-t border-border">
          <h2 className="text-[20px] font-bold text-foreground mb-5">
            Frequently Asked Questions
          </h2>
          <div className="space-y-3">
            {faqs.map((faq, i) => (
              <details key={i} className="border border-border rounded-xl bg-card group">
                <summary className="flex items-center justify-between p-4 cursor-pointer text-[14px] font-semibold text-foreground list-none hover:text-blue-600 transition-colors">
                  {faq.q}
                  <span className="text-muted-foreground text-[10px] ml-3 flex-shrink-0 group-open:rotate-180 transition-transform">▼</span>
                </summary>
                <p className="px-4 pb-4 text-[14px] text-muted-foreground leading-relaxed">{faq.a}</p>
              </details>
            ))}
          </div>
        </div>

        {/* Author */}
        <div className="mt-12 pt-8 border-t border-border">
          <AuthorBio context="reviewed" />
        </div>

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

      <StickyMobileCTA
        slug={tool.slug}
        name={tool.name}
        pricingType={tool.pricing_type}
        pricingFreeTier={tool.pricing_free_tier}
        startingPrice={tool.pricing_starting_price}
      />
    </>
  )
}
