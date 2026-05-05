import { notFound } from 'next/navigation'
import LogoImage from '@/components/ui/LogoImage'
import Link from 'next/link'
import { createClient, createStaticClient } from '@/lib/supabase'
import { getCompareEnrichment } from '@/data/compareEnrichment'
import { getAuthorJsonLd } from '@/data/authors'
import { linkGlossary } from '@/lib/glossary-linker'
import {
  generateAutoComparison,
  buildWhenToPick,
  parsePairSlug,
  type AutoTool,
} from '@/lib/auto-compare'
import type { Metadata } from 'next'

export const revalidate = 86400

// --- Types ---

interface Comparison {
  slug: string
  tool_a_slug: string
  tool_b_slug: string
  summary: string | null
  winner: string | null
  updated_at: string
}

interface Criterion {
  name: string
  tool_a_score: number
  tool_b_score: number
  notes: string | null
  sort_order: number
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
  pros?: string[] | null
  cons?: string[] | null
  use_cases?: string[] | null
  integrations?: string[] | null
  tags?: string[] | null
}

// --- Data fetching ---

async function getComparison(slug: string) {
  const supabase = await createClient()
  const [{ data: cmp }, { data: criteria }] = await Promise.all([
    supabase.from('comparisons').select('*').eq('slug', slug).single(),
    supabase.from('comparison_criteria').select('*').eq('comparison_slug', slug).order('sort_order'),
  ])
  if (!cmp) return null
  return { cmp: cmp as Comparison, criteria: (criteria ?? []) as Criterion[] }
}

async function getTool(slug: string): Promise<ToolRow | null> {
  const supabase = await createClient()
  const { data } = await supabase.from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,pros,cons,use_cases,integrations,tags')
    .eq('slug', slug).single()
  return data as ToolRow | null
}

export async function generateStaticParams() {
  const supabase = createStaticClient()
  const { data } = await supabase.from('comparisons').select('slug')
  return (data ?? []).map((c: { slug: string }) => ({ slug: c.slug }))
}

// --- Metadata ---

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const result = await getComparison(slug)
  let aSlug: string | null = null
  let bSlug: string | null = null
  if (result) {
    aSlug = result.cmp.tool_a_slug
    bSlug = result.cmp.tool_b_slug
  } else {
    const parsed = parsePairSlug(slug)
    if (!parsed) return { title: 'Comparison not found | MytheAi' }
    aSlug = parsed.a
    bSlug = parsed.b
  }
  const [a, b] = await Promise.all([getTool(aSlug), getTool(bSlug)])
  if (!a || !b) return { title: 'Comparison not found | MytheAi' }
  const year = new Date().getFullYear()
  const title = `${a.name} vs ${b.name} (${year}): Full Comparison | MytheAi`
  const description = result?.cmp.summary?.slice(0, 155) ?? `${a.name} vs ${b.name}: side-by-side feature and pricing comparison.`

  const ogUrl = new URL('https://mytheai.com/api/og/compare')
  ogUrl.searchParams.set('nameA', a.name)
  ogUrl.searchParams.set('nameB', b.name)
  if (a.logo_url) ogUrl.searchParams.set('logoA', a.logo_url)
  if (b.logo_url) ogUrl.searchParams.set('logoB', b.logo_url)

  return {
    title,
    description,
    alternates: { canonical: `https://mytheai.com/compare/${slug}` },
    openGraph: { title, description, url: `https://mytheai.com/compare/${slug}`, images: [{ url: ogUrl.toString(), width: 1200, height: 630 }] },
    twitter: { card: 'summary_large_image', title, description, images: [ogUrl.toString()] },
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

function ScoreBar({ score }: { score: number }) {
  const pct = (score / 5) * 100
  return (
    <div className="flex items-center gap-2">
      <div className="flex-1 h-1.5 rounded-full bg-border overflow-hidden">
        <div
          className="h-full rounded-full bg-blue-500"
          style={{ width: `${pct}%` }}
        />
      </div>
      <span className="text-[13px] font-semibold text-foreground w-4 text-right">{score}</span>
    </div>
  )
}

// --- Page ---

export default async function ComparePage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const result = await getComparison(slug)

  // Fallback path: pair has no row in `comparisons` table. Parse slug as `a-vs-b`,
  // fetch both tools, generate auto-comparison from data signals.
  let cmp: Comparison
  let criteria: Criterion[]
  let isAutoGenerated = false
  let toolA: ToolRow | null
  let toolB: ToolRow | null
  let autoWhenToPick: { whenA: string; whenB: string } | null = null

  if (result) {
    cmp = result.cmp
    criteria = result.criteria
    ;[toolA, toolB] = await Promise.all([getTool(cmp.tool_a_slug), getTool(cmp.tool_b_slug)])
  } else {
    const parsed = parsePairSlug(slug)
    if (!parsed) notFound()
    ;[toolA, toolB] = await Promise.all([getTool(parsed.a), getTool(parsed.b)])
    if (!toolA || !toolB) notFound()
    const auto = generateAutoComparison(toolA as AutoTool, toolB as AutoTool)
    cmp = {
      slug: auto.slug,
      tool_a_slug: auto.tool_a_slug,
      tool_b_slug: auto.tool_b_slug,
      summary: auto.summary,
      winner: auto.winner,
      updated_at: new Date().toISOString(),
    }
    criteria = auto.criteria
    isAutoGenerated = true
    autoWhenToPick = buildWhenToPick(toolA as AutoTool, toolB as AutoTool)
  }

  if (!toolA || !toolB) notFound()

  const year = new Date().getFullYear()
  const updatedDate = new Date(cmp.updated_at).toLocaleDateString('en-US', { month: 'long', year: 'numeric' })

  const scoreA = criteria.reduce((sum, c) => sum + (c.tool_a_score ?? 0), 0)
  const scoreB = criteria.reduce((sum, c) => sum + (c.tool_b_score ?? 0), 0)

  const enrichment = isAutoGenerated ? null : getCompareEnrichment(slug)

  const ogImageUrl = (() => {
    const u = new URL('https://mytheai.com/api/og/compare')
    u.searchParams.set('nameA', toolA.name)
    u.searchParams.set('nameB', toolB.name)
    if (toolA.logo_url) u.searchParams.set('logoA', toolA.logo_url)
    if (toolB.logo_url) u.searchParams.set('logoB', toolB.logo_url)
    return u.toString()
  })()

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Article',
    headline: `${toolA.name} vs ${toolB.name} (${year}): Full Comparison`,
    description: cmp.summary,
    url: `https://mytheai.com/compare/${slug}`,
    image: ogImageUrl,
    datePublished: cmp.updated_at,
    dateModified: cmp.updated_at,
    author: getAuthorJsonLd(),
    publisher: {
      '@type': 'Organization',
      name: 'MytheAi',
      url: 'https://mytheai.com',
      logo: { '@type': 'ImageObject', url: 'https://mytheai.com/icon-512.png', width: 512, height: 512 },
    },
    mainEntityOfPage: { '@type': 'WebPage', '@id': `https://mytheai.com/compare/${slug}` },
    about: [
      {
        '@type': 'SoftwareApplication',
        name: toolA.name,
        applicationCategory: 'WebApplication',
        operatingSystem: 'Web',
        url: `https://mytheai.com/tools/${toolA.slug}`,
        offers: {
          '@type': 'Offer',
          price: toolA.pricing_starting_price ?? 0,
          priceCurrency: 'USD',
        },
        aggregateRating: toolA.review_count > 0 ? {
          '@type': 'AggregateRating',
          ratingValue: toolA.rating,
          reviewCount: toolA.review_count,
        } : undefined,
      },
      {
        '@type': 'SoftwareApplication',
        name: toolB.name,
        applicationCategory: 'WebApplication',
        operatingSystem: 'Web',
        url: `https://mytheai.com/tools/${toolB.slug}`,
        offers: {
          '@type': 'Offer',
          price: toolB.pricing_starting_price ?? 0,
          priceCurrency: 'USD',
        },
        aggregateRating: toolB.review_count > 0 ? {
          '@type': 'AggregateRating',
          ratingValue: toolB.rating,
          reviewCount: toolB.review_count,
        } : undefined,
      },
    ],
  }

  const faqJsonLd = enrichment ? {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: enrichment.faqs.map(f => ({
      '@type': 'Question',
      name: f.q,
      acceptedAnswer: { '@type': 'Answer', text: f.a },
    })),
  } : null

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Compare', item: 'https://mytheai.com/compare' },
      { '@type': 'ListItem', position: 3, name: `${toolA.name} vs ${toolB.name}`, item: `https://mytheai.com/compare/${slug}` },
    ],
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />
      {faqJsonLd && <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(faqJsonLd) }} />}

      <div className="max-w-4xl mx-auto px-4 md:px-5 py-10 md:py-14">

        {/* Breadcrumb */}
        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/compare" className="hover:text-blue-600 transition-colors">Compare</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{toolA.name} vs {toolB.name}</span>
        </nav>

        {/* AI-assisted comparison banner */}
        {isAutoGenerated && (
          <div className="mb-6 p-4 rounded-xl border border-blue-200 dark:border-blue-900/40 bg-blue-50/60 dark:bg-blue-950/20 flex items-start gap-3">
            <span className="text-[18px] flex-shrink-0" aria-hidden="true">⚡</span>
            <div>
              <p className="text-[13px] font-bold text-blue-900 dark:text-blue-200 mb-1">
                AI-assisted summary
              </p>
              <p className="text-[12px] text-blue-900/80 dark:text-blue-200/80 leading-relaxed">
                This side-by-side is generated from verified tool data (rating, pricing, free tier, integrations, adoption signals) using our editorial scoring framework. <Link href="/methodology" className="underline font-semibold">How we rank</Link>.
              </p>
            </div>
          </div>
        )}

        {/* Hero */}
        <div className="flex flex-col items-center text-center mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">Head-to-Head</p>
          <h1 className="text-[26px] md:text-[34px] font-extrabold tracking-tight text-foreground mb-6">
            {toolA.name} vs {toolB.name} ({year})
          </h1>

          {/* Tool cards side by side */}
          <div className="flex items-center gap-4 w-full max-w-lg">
            {/* Tool A */}
            <div className="flex-1 flex flex-col items-center gap-2 p-4 rounded-xl border border-border bg-card">
              <div className="w-12 h-12 rounded-xl border border-border bg-white flex items-center justify-center overflow-hidden">
                <LogoImage src={toolA.logo_url} websiteUrl={toolA.website_url} name={toolA.name} size={40} letterClassName="text-[15px] font-bold text-gray-400" />
              </div>
              <p className="text-[14px] font-bold text-foreground">{toolA.name}</p>
              <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[toolA.pricing_type]}`}>
                {PRICING_LABELS[toolA.pricing_type]}
              </span>
              <p className="text-[13px] text-[#F59E0B]">★ {toolA.rating.toFixed(1)}</p>
            </div>

            {/* VS badge */}
            <div className="flex-shrink-0 text-[18px] font-extrabold text-[#2563EB] bg-[#EFF6FF] px-3 py-1.5 rounded-lg">VS</div>

            {/* Tool B */}
            <div className="flex-1 flex flex-col items-center gap-2 p-4 rounded-xl border border-border bg-card">
              <div className="w-12 h-12 rounded-xl border border-border bg-white flex items-center justify-center overflow-hidden">
                <LogoImage src={toolB.logo_url} websiteUrl={toolB.website_url} name={toolB.name} size={40} letterClassName="text-[15px] font-bold text-gray-400" />
              </div>
              <p className="text-[14px] font-bold text-foreground">{toolB.name}</p>
              <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[toolB.pricing_type]}`}>
                {PRICING_LABELS[toolB.pricing_type]}
              </span>
              <p className="text-[13px] text-[#F59E0B]">★ {toolB.rating.toFixed(1)}</p>
            </div>
          </div>
        </div>

        {/* Summary */}
        {cmp.summary && (
          <section className="mb-10">
            <p className="text-[15px] text-muted-foreground leading-relaxed">
              {linkGlossary(cmp.summary).map((seg, i) =>
                seg.type === 'link' ? (
                  <Link key={i} href={seg.href} className="text-blue-600/80 hover:text-blue-600 hover:underline border-b border-dotted border-blue-200 dark:border-blue-900">{seg.value}</Link>
                ) : (
                  <span key={i}>{seg.value}</span>
                )
              )}
            </p>
          </section>
        )}

        {/* Criteria table */}
        {criteria.length > 0 && (
          <section className="mb-10">
            <h2 className="text-[18px] font-bold text-foreground mb-4">Feature Comparison</h2>
            <div className="border border-border rounded-xl overflow-hidden">
              {/* Header */}
              <div className="grid grid-cols-[1fr_160px_160px] gap-0 bg-card border-b border-border">
                <div className="px-4 py-3 text-[12px] font-bold uppercase tracking-wide text-muted-foreground">Criterion</div>
                <div className="px-4 py-3 text-[12px] font-bold uppercase tracking-wide text-muted-foreground text-center border-l border-border">{toolA.name}</div>
                <div className="px-4 py-3 text-[12px] font-bold uppercase tracking-wide text-muted-foreground text-center border-l border-border">{toolB.name}</div>
              </div>
              {criteria.map((c, i) => (
                <div key={i} className={`grid grid-cols-[1fr_160px_160px] gap-0 ${i % 2 === 0 ? 'bg-background' : 'bg-card'}`}>
                  <div className="px-4 py-3 border-b border-border">
                    <p className="text-[13px] font-semibold text-foreground">{c.name}</p>
                    {c.notes && <p className="text-[12px] text-muted-foreground mt-0.5">{c.notes}</p>}
                  </div>
                  <div className="px-4 py-3 border-b border-l border-border">
                    <ScoreBar score={c.tool_a_score} />
                  </div>
                  <div className="px-4 py-3 border-b border-l border-border">
                    <ScoreBar score={c.tool_b_score} />
                  </div>
                </div>
              ))}
              {/* Total row */}
              <div className="grid grid-cols-[1fr_160px_160px] gap-0 bg-card">
                <div className="px-4 py-3 text-[13px] font-bold text-foreground">Total Score</div>
                <div className={`px-4 py-3 border-l border-border text-center text-[15px] font-extrabold ${scoreA >= scoreB ? 'text-blue-600' : 'text-muted-foreground'}`}>
                  {scoreA}
                </div>
                <div className={`px-4 py-3 border-l border-border text-center text-[15px] font-extrabold ${scoreB > scoreA ? 'text-blue-600' : 'text-muted-foreground'}`}>
                  {scoreB}
                </div>
              </div>
            </div>
          </section>
        )}

        {/* Winner / Verdict */}
        <section className="mb-10 p-5 rounded-xl border border-border bg-card">
          <h2 className="text-[16px] font-bold text-foreground mb-2">Verdict</h2>
          {cmp.winner ? (
            <>
              <p className="text-[14px] text-muted-foreground mb-4">
                <strong className="text-foreground">{cmp.winner === cmp.tool_a_slug ? toolA.name : toolB.name}</strong> wins this comparison with a total score of {cmp.winner === cmp.tool_a_slug ? scoreA : scoreB}/{criteria.length * 5}.
              </p>
              <a
                href={`/go/${cmp.winner}`}
                target="_blank"
                rel="noopener noreferrer sponsored"
                className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[14px] transition-colors"
              >
                Try {cmp.winner === cmp.tool_a_slug ? toolA.name : toolB.name} - editor's pick →
              </a>
            </>
          ) : (
            <p className="text-[14px] text-muted-foreground">
              This comparison is <strong className="text-foreground">context-dependent</strong>. {toolA.name} scores {scoreA}/{criteria.length * 5} and {toolB.name} scores {scoreB}/{criteria.length * 5}. Choose based on your specific workflow needs.
            </p>
          )}
        </section>

        {/* Bottom Line (enriched) */}
        {enrichment && (
          <section className="mb-10 p-6 rounded-xl border-2 border-blue-100 dark:border-blue-900/40 bg-blue-50/50 dark:bg-blue-950/20">
            <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-700 dark:text-blue-300 mb-2">Bottom Line</p>
            <p className="text-[15px] text-foreground leading-relaxed">{enrichment.bottomLine}</p>
          </section>
        )}

        {/* When to pick A/B (enriched, or auto when-to-pick) */}
        {enrichment ? (
          <section className="mb-10 grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="p-5 rounded-xl border border-border bg-card">
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">Pick {toolA.name}</p>
              <p className="text-[14px] text-muted-foreground leading-relaxed">{enrichment.whenToPickA}</p>
            </div>
            <div className="p-5 rounded-xl border border-border bg-card">
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">Pick {toolB.name}</p>
              <p className="text-[14px] text-muted-foreground leading-relaxed">{enrichment.whenToPickB}</p>
            </div>
          </section>
        ) : autoWhenToPick && (
          <section className="mb-10 grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="p-5 rounded-xl border border-border bg-card">
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">Pick {toolA.name}</p>
              <p className="text-[14px] text-muted-foreground leading-relaxed">{autoWhenToPick.whenA}</p>
            </div>
            <div className="p-5 rounded-xl border border-border bg-card">
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">Pick {toolB.name}</p>
              <p className="text-[14px] text-muted-foreground leading-relaxed">{autoWhenToPick.whenB}</p>
            </div>
          </section>
        )}

        {/* CTAs */}
        <div className="flex flex-wrap gap-3 mb-10">
          <a href={`/go/${toolA.slug}`} target="_blank" rel="noopener noreferrer sponsored"
            className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[14px] transition-colors">
            Try {toolA.name} →
          </a>
          <a href={`/go/${toolB.slug}`} target="_blank" rel="noopener noreferrer sponsored"
            className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg border border-border bg-card hover:border-blue-300 text-foreground font-medium text-[14px] transition-colors">
            Try {toolB.name} →
          </a>
        </div>

        {/* Full review links */}
        <div className="flex gap-4 text-[13px]">
          <Link href={`/tools/${toolA.slug}`} className="text-blue-600 hover:underline">
            Full {toolA.name} review →
          </Link>
          <Link href={`/tools/${toolB.slug}`} className="text-blue-600 hover:underline">
            Full {toolB.name} review →
          </Link>
        </div>

        {/* FAQ (enriched) */}
        {enrichment && enrichment.faqs.length > 0 && (
          <section className="mt-10">
            <h2 className="text-[20px] font-bold text-foreground mb-5">Frequently asked</h2>
            <div className="space-y-4">
              {enrichment.faqs.map((faq, i) => (
                <div key={i} className="p-5 rounded-xl border border-border bg-card">
                  <p className="text-[15px] font-bold text-foreground mb-2">{faq.q}</p>
                  <p className="text-[14px] text-muted-foreground leading-relaxed">{faq.a}</p>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* Disclosure */}
        <div className="mt-10 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          <strong>Disclosure:</strong> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Our rankings are never influenced by affiliate relationships.
          <span className="block mt-1">Last verified: {updatedDate}</span>
        </div>

      </div>
    </>
  )
}
