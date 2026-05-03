import { notFound } from 'next/navigation'
import Link from 'next/link'
import LogoImage from '@/components/ui/LogoImage'
import AuthorBio from '@/components/layout/AuthorBio'
import { getAuthorJsonLd } from '@/data/authors'
import { USE_CASES, getUseCase } from '@/data/useCases'
import { createStaticClient } from '@/lib/supabase'
import type { Metadata } from 'next'

export const revalidate = 604800

interface ToolStub {
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
  updated_at: string
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

async function getToolsForUseCase(primaryTag: string, secondaryTags: string[] = []): Promise<ToolStub[]> {
  const supabase = createStaticClient()
  const { data: primary } = await supabase
    .from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,trending,updated_at')
    .contains('tags', [primaryTag])
    .gte('rating', 4.0)
    .order('rating', { ascending: false })
    .limit(10)
  const list = (primary ?? []) as ToolStub[]
  if (list.length >= 5 || secondaryTags.length === 0) return list
  // Top up from secondary tags if primary returns too few
  for (const tag of secondaryTags) {
    if (list.length >= 10) break
    const { data: extra } = await supabase
      .from('tools')
      .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,trending,updated_at')
      .contains('tags', [tag])
      .gte('rating', 4.0)
      .order('rating', { ascending: false })
      .limit(10 - list.length)
    for (const t of (extra ?? []) as ToolStub[]) {
      if (!list.find(l => l.slug === t.slug)) list.push(t)
    }
  }
  return list
}

export function generateStaticParams() {
  return USE_CASES.map(u => ({ slug: u.slug }))
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const u = getUseCase(slug)
  if (!u) return { title: 'Use case not found | MytheAi' }
  const year = new Date().getFullYear()
  const title = `${u.title} (${year}): Top Picks Tested | MytheAi`
  const description = `${u.title} tested in real workflows. Independent rankings, free-tier signals, pricing transparency. Updated ${year}.`
  return {
    title,
    description,
    alternates: { canonical: `https://mytheai.com/use-case/${slug}` },
    openGraph: {
      title: `${u.title} ${year} | MytheAi`,
      description,
      url: `https://mytheai.com/use-case/${slug}`,
    },
  }
}

export default async function UseCasePage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const useCase = getUseCase(slug)
  if (!useCase) notFound()

  const tools = await getToolsForUseCase(useCase.primaryTag, useCase.secondaryTags)
  const year = new Date().getFullYear()
  const todayIso = new Date().toISOString().slice(0, 10)
  const author = getAuthorJsonLd()

  const collectionPageJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    name: `${useCase.title} ${year}`,
    description: useCase.intro.split('.').slice(0, 2).join('.') + '.',
    url: `https://mytheai.com/use-case/${slug}`,
    inLanguage: 'en',
    isPartOf: { '@type': 'WebSite', name: 'MytheAi', url: 'https://mytheai.com' },
    author,
    publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
    dateModified: todayIso,
    mainEntity: {
      '@type': 'ItemList',
      numberOfItems: tools.length,
      itemListElement: tools.map((t, i) => ({
        '@type': 'ListItem',
        position: i + 1,
        name: t.name,
        url: `https://mytheai.com/tools/${t.slug}`,
      })),
    },
  }

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Use Cases', item: 'https://mytheai.com/use-case' },
      { '@type': 'ListItem', position: 3, name: useCase.title, item: `https://mytheai.com/use-case/${slug}` },
    ],
  }

  const faqJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: useCase.faqs.map(f => ({
      '@type': 'Question',
      name: f.q,
      acceptedAnswer: { '@type': 'Answer', text: f.a },
    })),
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(collectionPageJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(faqJsonLd) }} />

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/tools" className="hover:text-blue-600 transition-colors">Tools</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{useCase.title}</span>
        </nav>

        <div className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">
            <span className="mr-1">{useCase.emoji}</span> Use case
          </p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            {useCase.title} ({year})
          </h1>
          <p className="text-[16px] text-muted-foreground leading-relaxed">
            {useCase.intro}
          </p>
        </div>

        <section className="mb-10 p-5 rounded-xl border border-border bg-card">
          <h2 className="text-[14px] font-bold text-foreground uppercase tracking-wider mb-2">What to look for</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed">{useCase.whatToLookFor}</p>
        </section>

        {tools.length > 0 ? (
          <section className="mb-10">
            <h2 className="text-[20px] font-bold text-foreground mb-4">
              Top {tools.length} tools to {useCase.shortAction}
            </h2>
            <ol className="space-y-4">
              {tools.map((t, i) => (
                <li key={t.slug}>
                  <div className="rounded-xl border border-border bg-card overflow-hidden">
                    <div className="flex items-start gap-4 p-5">
                      <div className="text-[22px] font-extrabold w-8 flex-shrink-0 leading-none pt-0.5 text-muted-foreground">{i + 1}</div>
                      <Link href={`/tools/${t.slug}`} className="w-11 h-11 rounded-xl border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden hover:border-blue-300 transition-colors">
                        <LogoImage src={t.logo_url} websiteUrl={t.website_url} name={t.name} size={36} />
                      </Link>
                      <div className="flex-1 min-w-0">
                        <div className="flex flex-wrap items-center gap-2 mb-1">
                          <Link href={`/tools/${t.slug}`} className="text-[15px] font-bold text-foreground hover:text-blue-600 transition-colors">{t.name}</Link>
                          <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[t.pricing_type]}`}>
                            {PRICING_LABELS[t.pricing_type]}
                          </span>
                          {t.trending && <span className="text-[11px] font-semibold text-[#F59E0B]">🔥 Trending</span>}
                        </div>
                        <p className="text-[13px] text-muted-foreground line-clamp-2 mb-2">{t.tagline}</p>
                        <div className="flex items-center gap-3 text-[12px] text-muted-foreground flex-wrap">
                          <span className="text-[#F59E0B] font-semibold">★ {t.rating.toFixed(1)}</span>
                          <span>{t.review_count.toLocaleString()} reviews</span>
                          {t.pricing_free_tier && <span className="text-[#10B981] font-medium">Free tier</span>}
                          {t.pricing_starting_price && <span>From ${t.pricing_starting_price}/mo</span>}
                        </div>
                      </div>
                      <div className="flex flex-col gap-2 flex-shrink-0">
                        <a
                          href={`/go/${t.slug}`}
                          target="_blank"
                          rel="noopener noreferrer sponsored"
                          className="inline-flex items-center justify-center px-3 py-1.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[12px] transition-colors whitespace-nowrap"
                        >
                          Try {t.name} →
                        </a>
                        <Link
                          href={`/tools/${t.slug}`}
                          className="inline-flex items-center justify-center px-3 py-1.5 rounded-lg border border-border hover:border-blue-300 text-foreground font-medium text-[12px] transition-colors whitespace-nowrap"
                        >
                          Review →
                        </Link>
                      </div>
                    </div>
                  </div>
                </li>
              ))}
            </ol>
          </section>
        ) : (
          <div className="mb-10 p-6 rounded-xl border border-border bg-card text-center">
            <p className="text-[14px] text-muted-foreground">No tools currently match this use case. Browse <Link href="/tools" className="text-blue-600 hover:underline">all tools</Link> instead.</p>
          </div>
        )}

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">Frequently asked</h2>
          <div className="space-y-3">
            {useCase.faqs.map((f, i) => (
              <details key={i} className="group rounded-xl border border-border bg-card overflow-hidden">
                <summary className="flex items-center justify-between gap-4 px-5 py-4 cursor-pointer list-none hover:bg-gray-50 dark:hover:bg-gray-900/40 transition-colors">
                  <span className="text-[15px] font-semibold text-foreground">{f.q}</span>
                  <svg className="w-4 h-4 text-muted-foreground transition-transform group-open:rotate-180 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24" aria-hidden="true">
                    <polyline points="6 9 12 15 18 9" />
                  </svg>
                </summary>
                <div className="px-5 pb-4 text-[14px] text-muted-foreground leading-relaxed">{f.a}</div>
              </details>
            ))}
          </div>
        </section>

        <div className="mb-8">
          <AuthorBio context="written" />
        </div>

        <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          <strong>Disclosure:</strong> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Rankings are based on <Link href="/methodology" className="text-blue-600 hover:underline">editorial merit</Link>. Affiliate relationships never influence placement.
        </div>

      </div>
    </>
  )
}
