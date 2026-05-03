import Link from 'next/link'
import type { Metadata } from 'next'
import { getTranslations } from 'next-intl/server'
import LogoImage from '@/components/ui/LogoImage'
import { createStaticClient } from '@/lib/supabase'
import { mockCategories } from '@/data/mock'
import { TOP10_LISTS } from '@/data/top10'
import type { Tool } from '@/types'
import NewsletterForm from '@/components/newsletter/NewsletterForm'
import SearchDropdown from '@/components/search/SearchDropdown'
import { computeWeightedScore, isValidScores, type ToolScores } from '@/lib/scoring'

export const revalidate = 21600

export const metadata: Metadata = {
  title: 'MytheAi - Find the Best AI Tools 2026 | Honest Reviews & Comparisons',
  description: 'Discover and compare 500+ AI & SaaS tools. Honest expert reviews, side-by-side comparisons, verified pricing. No pay-to-rank. Find the right AI tool in seconds.',
  alternates: { canonical: 'https://mytheai.com/' },
  openGraph: {
    title: 'MytheAi - Find the Best AI Tools 2026',
    description: 'Discover and compare 500+ AI & SaaS tools. Honest reviews, side-by-side comparisons, verified pricing. No pay-to-rank.',
    url: 'https://mytheai.com/',
    type: 'website',
    images: [{ url: '/api/og/site', width: 1200, height: 630, alt: 'MytheAi - AI & SaaS Tools Directory' }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'MytheAi - Find the Best AI Tools 2026',
    description: 'Discover and compare 500+ AI & SaaS tools. Honest reviews, verified pricing. No pay-to-rank.',
    images: ['/api/og/site'],
  },
}

// ── JSON-LD Structured Data ───────────────────────────────────────────────────

const jsonLd = {
  '@context': 'https://schema.org',
  '@graph': [
    {
      '@type': 'WebSite',
      '@id': 'https://mytheai.com/#website',
      name: 'MytheAi',
      url: 'https://mytheai.com',
      description: 'Discover and compare 500+ AI & SaaS tools with honest reviews and side-by-side comparisons.',
      potentialAction: {
        '@type': 'SearchAction',
        target: {
          '@type': 'EntryPoint',
          urlTemplate: 'https://mytheai.com/tools?q={search_term_string}',
        },
        'query-input': 'required name=search_term_string',
      },
    },
    {
      '@type': 'Organization',
      '@id': 'https://mytheai.com/#organization',
      name: 'MytheAi',
      url: 'https://mytheai.com',
      logo: {
        '@type': 'ImageObject',
        url: 'https://mytheai.com/api/logo',
        width: 512,
        height: 512,
      },
    },
  ],
}

// ── Role cards (static, no DB needed) ────────────────────────────────────────

const ROLE_KEYS = [
  { emoji: '💻', key: 'developer', href: '/top-10/best-code-ai-tools' },
  { emoji: '📣', key: 'marketer', href: '/top-10/best-ai-tools-for-marketers' },
  { emoji: '✍️', key: 'creator', href: '/top-10/best-ai-tools-for-content-creators' },
  { emoji: '🎓', key: 'student', href: '/top-10/best-ai-tools-for-students' },
  { emoji: '🚀', key: 'founder', href: '/top-10/best-ai-tools-for-startups' },
  { emoji: '🎨', key: 'designer', href: '/top-10/best-ai-design-tools' },
] as const

// ── Data fetching ─────────────────────────────────────────────────────────────

interface ToolRow {
  id: string
  slug: string
  name: string
  tagline: string
  logo_url: string | null
  website_url: string | null
  pricing_type: 'free' | 'freemium' | 'paid' | 'ltd'
  pricing_free_tier: boolean
  rating: number
  review_count: number
  tags: string[] | null
  editor_pick: boolean
  trending: boolean
  scores?: ToolScores | null
}

async function getEditorPicks(): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const COLUMNS = 'id,slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,rating,review_count,tags,editor_pick,trending,scores'

  const { data: picks } = await supabase
    .from('tools')
    .select(COLUMNS)
    .eq('editor_pick', true)
    .order('rating', { ascending: false })

  const seen = new Set((picks ?? []).map(p => p.slug))
  const need = 6 - (picks?.length ?? 0)
  let topRated: ToolRow[] = []
  if (need > 0) {
    const { data } = await supabase
      .from('tools')
      .select(COLUMNS)
      .gte('rating', 4.7)
      .order('rating', { ascending: false })
      .order('review_count', { ascending: false })
      .limit(need + 5)
    topRated = (data ?? []).filter(t => !seen.has(t.slug)).slice(0, need)
  }
  return [...(picks ?? []), ...topRated]
}

async function getRecentlyAdded(): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('id,slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,rating,review_count,tags,editor_pick,trending')
    .order('created_at', { ascending: false })
    .limit(6)
  return data ?? []
}

async function getDirectoryStats() {
  const supabase = createStaticClient()
  const [toolsRes, comparesRes] = await Promise.all([
    supabase.from('tools').select('*', { count: 'exact', head: true }),
    supabase.from('comparisons').select('*', { count: 'exact', head: true }),
  ])
  return {
    tools: toolsRes.count ?? 0,
    comparisons: comparesRes.count ?? 0,
  }
}

async function getTrending(): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('id,slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,rating,review_count,tags,editor_pick,trending')
    .eq('trending', true)
    .order('rating', { ascending: false })
    .limit(6)
  return data ?? []
}

interface Top10ToolMeta { slug: string; name: string; logo_url: string | null; pricing_type: string; website_url: string | null }

async function getTop10Data() {
  const supabase = createStaticClient()
  const listsToShow = TOP10_LISTS.slice(0, 3)
  const allSlugs = [...new Set(listsToShow.flatMap(l => l.slugs))]
  const { data } = await supabase.from('tools').select('slug,name,logo_url,pricing_type,website_url').in('slug', allSlugs)
  const toolMap: Record<string, Top10ToolMeta> = {}
  for (const t of data ?? []) toolMap[t.slug] = t
  return listsToShow.map(list => ({
    list,
    tools: list.slugs.map(s => toolMap[s]).filter(Boolean) as Top10ToolMeta[],
  }))
}

// ── Helpers ───────────────────────────────────────────────────────────────────

function PricingBadge({ type }: { type: Tool['pricing_type'] }) {
  const map = {
    free:     'bg-[#D1FAE5] text-[#065F46]',
    freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
    paid:     'bg-[#F3F4F6] text-[#374151]',
    ltd:      'bg-[#FEF3C7] text-[#92400E]',
  }
  const labels = { free: 'Free', freemium: 'Freemium', paid: 'Paid', ltd: 'LTD' }
  return (
    <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${map[type]}`}>
      {labels[type]}
    </span>
  )
}

function Stars({ rating }: { rating: number }) {
  return (
    <span className="text-[#F59E0B] text-sm tracking-[-1px]">
      {'★'.repeat(Math.floor(rating))}{'☆'.repeat(5 - Math.floor(rating))}
    </span>
  )
}

function SectionHeader({ eyebrow, eyebrowColor = '#2563EB', title, viewAll, viewAllHref }: {
  eyebrow: string; eyebrowColor?: string; title: string; viewAll?: string; viewAllHref?: string
}) {
  return (
    <div className="flex items-end justify-between mb-7">
      <div>
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] mb-1" style={{ color: eyebrowColor }}>{eyebrow}</p>
        <h2 className="text-[22px] md:text-[24px] font-extrabold tracking-tight text-foreground">{title}</h2>
      </div>
      {viewAll && viewAllHref && (
        <Link href={viewAllHref} className="text-sm font-medium text-muted-foreground hover:text-blue-600 transition-colors">
          {viewAll}
        </Link>
      )}
    </div>
  )
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default async function HomePage() {
  const [editorPicks, trending, top10Data, stats, recentlyAdded, tHero, tTrust, tSection, tRoles] = await Promise.all([
    getEditorPicks(),
    getTrending(),
    getTop10Data(),
    getDirectoryStats(),
    getRecentlyAdded(),
    getTranslations('Hero'),
    getTranslations('TrustBar'),
    getTranslations('HomeSections'),
    getTranslations('Roles'),
  ])

  const rankColors = ['#F59E0B', '#9CA3AF', '#92400E']

  return (
    <>
      {/* JSON-LD */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />

      {/* ── HERO: Search First ────────────────────────────────────────────── */}
      <section className="hero-bg py-10 md:py-20">
        <div className="max-w-3xl mx-auto px-4 md:px-5 text-center">

          <h1
            className="text-[34px] sm:text-[44px] md:text-[56px] font-extrabold leading-[1.08] mb-6 text-foreground"
            style={{ letterSpacing: '-0.03em' }}
          >
            {tHero('h1Line1')}<br />
            <span className="text-blue-600">{tHero('h1Line2')}</span>
          </h1>

          {/* Search bar - primary CTA. Instant search dropdown (Session 67). */}
          <div className="mb-4 text-left">
            <SearchDropdown variant="hero" />
          </div>

          <p className="text-[14px] text-muted-foreground mb-5">
            {tHero('tagline')}
          </p>

          {/* Quick search pills - kept visible for SEO and direct links */}
          <div className="flex flex-wrap justify-center items-center gap-2 text-[12px] text-muted-foreground">
            <span className="font-medium">{tHero('popular')}</span>
            {[
              { en: 'ChatGPT alternatives', label: tHero('popularChip1') },
              { en: 'Free AI tools', label: tHero('popularChip2') },
              { en: 'AI for coding', label: tHero('popularChip3') },
              { en: 'Best SEO tools', label: tHero('popularChip4') },
            ].map(q => (
              <Link
                key={q.en}
                href={`/tools?q=${encodeURIComponent(q.en)}`}
                className="px-3 py-1 rounded-full border border-border bg-card hover:border-blue-300 hover:text-blue-600 transition-colors"
              >
                {q.label}
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* ── TRUST BAR - live directory stats ───────────────────────────── */}
      <div className="bg-card border-y border-border">
        <div className="max-w-7xl mx-auto px-5 py-3 flex items-center justify-center gap-6 md:gap-12 text-xs font-medium text-muted-foreground flex-wrap">
          <span className="flex items-center gap-1.5 whitespace-nowrap">
            <span style={{ color: '#10B981' }}>✓</span>
            {tTrust('toolsReviewed', { count: stats.tools.toLocaleString() })}
          </span>
          <span className="flex items-center gap-1.5 whitespace-nowrap">
            <span style={{ color: '#10B981' }}>✓</span>
            {tTrust('comparisons', { count: stats.comparisons.toLocaleString() })}
          </span>
          <Link href="/transparency" className="flex items-center gap-1.5 whitespace-nowrap hover:text-blue-600 transition-colors">
            <span style={{ color: '#10B981' }}>✓</span>
            <span className="underline-offset-4 hover:underline">{tTrust('noPayToRank')}</span>
          </Link>
          <span className="flex items-center gap-1.5 whitespace-nowrap">
            <span style={{ color: '#10B981' }}>✓</span> {tTrust('updatedWeekly')}
          </span>
        </div>
      </div>

      {/* ── MAIN CONTENT ─────────────────────────────────────────────────── */}
      <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14 space-y-12 md:space-y-16">

        {/* BROWSE BY CATEGORY - primary navigation after search */}
        <section aria-label="Browse by category">
          <SectionHeader eyebrow={tSection('browseEyebrow')} title={tSection('browseTitle')} viewAll={`${tSection('browseViewAll')} →`} viewAllHref="/categories" />
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
            {mockCategories.map(cat => (
              <Link
                key={cat.id}
                href={`/tools?category=${cat.slug}`}
                className="bg-card border border-border rounded-xl flex items-center gap-3 px-4 py-3 transition-all duration-150 hover:border-blue-300 hover:bg-[#EFF6FF] dark:hover:bg-[#1E3A5F] hover:-translate-y-px"
              >
                <span className="text-2xl flex-shrink-0" aria-hidden="true">{cat.emoji}</span>
                <div className="min-w-0">
                  <div className="text-[13px] font-semibold text-foreground truncate">{cat.name}</div>
                  <div className="text-[12px] text-muted-foreground">{tSection('toolCount', { count: cat.tool_count })}</div>
                </div>
              </Link>
            ))}
          </div>
        </section>

        {/* EDITOR'S PICKS */}
        {editorPicks.length > 0 && (
          <section aria-label="Editor's picks">
            <SectionHeader eyebrow={tSection('editorEyebrow')} title={tSection('editorTitle')} viewAll={`${tSection('editorViewAll')} →`} viewAllHref="/tools" />
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              {editorPicks.map(tool => (
                <Link
                  key={tool.id}
                  href={`/tools/${tool.slug}`}
                  className="bg-card border border-border rounded-xl p-5 block transition-all duration-150 hover:-translate-y-0.5 hover:shadow-xl hover:border-blue-300 flex flex-col"
                >
                  <div className="flex items-start justify-between mb-4">
                    <div className="flex items-center gap-3 min-w-0">
                      <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} />
                      <div className="min-w-0">
                        <div className="flex items-center gap-1">
                          <span className="text-[14px] font-semibold text-foreground truncate">{tool.name}</span>
                          <svg
                            width="13"
                            height="13"
                            viewBox="0 0 24 24"
                            fill="#2563EB"
                            className="flex-shrink-0"
                            aria-label="Editorially verified"
                          >
                            <path d="M12 2 L14.5 4 L17.5 3.2 L19 6 L22 7 L21 10 L22 13 L19 14 L17.5 16.8 L14.5 16 L12 18 L9.5 16 L6.5 16.8 L5 14 L2 13 L3 10 L2 7 L5 6 L6.5 3.2 L9.5 4 Z" />
                            <path d="M8 11 L11 14 L16 9" stroke="white" strokeWidth="2.2" fill="none" strokeLinecap="round" strokeLinejoin="round" />
                          </svg>
                        </div>
                        <div className="text-[12px] text-muted-foreground truncate">{tool.tags?.[0] ?? ''}</div>
                      </div>
                    </div>
                    <PricingBadge type={tool.pricing_type} />
                  </div>
                  <p className="text-[13px] text-muted-foreground leading-relaxed mb-4 line-clamp-2 flex-1">{tool.tagline}</p>
                  <div className="flex items-center gap-1.5 mb-2">
                    <Stars rating={tool.rating} />
                    <span className="text-[13px] font-semibold text-foreground">{tool.rating.toFixed(1)}</span>
                    <span className="text-[12px] text-muted-foreground">{tSection('reviews', { count: (tool.review_count / 1000).toFixed(1) })}</span>
                  </div>
                  {isValidScores(tool.scores) && (
                    <div className="flex items-center gap-1.5 mb-3 text-[11px]">
                      <span className="font-bold uppercase tracking-[0.06em] text-blue-600">{tSection('editorialScore')}</span>
                      <span className="font-semibold text-foreground">{computeWeightedScore(tool.scores).toFixed(2)}/5</span>
                      <span className="text-muted-foreground">{tSection('editorialScoreSuffix')}</span>
                    </div>
                  )}
                  <span className="block w-full text-center text-[13px] font-semibold text-white bg-blue-600 hover:bg-blue-700 transition-colors py-2.5 rounded-lg">
                    {tSection('viewTool', { name: tool.name })} →
                  </span>
                </Link>
              ))}
            </div>
          </section>
        )}

        {/* RECENTLY ADDED */}
        {recentlyAdded.length > 0 && (
          <section aria-label="Recently added AI tools">
            <SectionHeader eyebrow={tSection('recentEyebrow')} eyebrowColor="#10B981" title={tSection('recentTitle')} viewAll={`${tSection('recentViewAll')} →`} viewAllHref="/tools" />
            <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3">
              {recentlyAdded.map(tool => (
                <Link
                  key={tool.id}
                  href={`/tools/${tool.slug}`}
                  className="bg-card border border-border rounded-xl p-3 flex flex-col items-center text-center transition-all duration-150 hover:border-emerald-300 hover:-translate-y-0.5 hover:shadow-sm"
                >
                  <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={36} />
                  <span className="mt-2 text-[12.5px] font-semibold text-foreground truncate w-full">{tool.name}</span>
                  <span className="text-[11px] text-muted-foreground truncate w-full">{tool.tags?.[0] ?? 'New'}</span>
                  <PricingBadge type={tool.pricing_type} />
                </Link>
              ))}
            </div>
          </section>
        )}

        {/* FIND TOOLS FOR YOUR ROLE */}
        <section aria-label="Find tools by role">
          <SectionHeader eyebrow={tSection('rolesEyebrow')} title={tSection('rolesTitle')} viewAll={`${tSection('rolesViewAll')} →`} viewAllHref="/roles" />
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3">
            {ROLE_KEYS.map(role => (
              <Link
                key={role.key}
                href={role.href}
                className="flex flex-col items-center text-center p-4 md:p-5 rounded-xl border border-border bg-card hover:border-blue-300 hover:bg-[#EFF6FF] dark:hover:bg-[#1E3A5F] transition-all duration-150 hover:-translate-y-0.5 hover:shadow-md"
              >
                <span className="text-3xl mb-2" aria-hidden="true">{role.emoji}</span>
                <span className="text-[13px] font-semibold text-foreground">{tRoles(role.key)}</span>
                <span className="text-[11px] text-muted-foreground mt-0.5 leading-tight">{tRoles(`${role.key}Desc`)}</span>
              </Link>
            ))}
          </div>
        </section>

        {/* TRENDING NOW */}
        {trending.length > 0 && (
          <section aria-label="Trending AI tools">
            <SectionHeader eyebrow={tSection('trendingEyebrow')} eyebrowColor="#F59E0B" title={tSection('trendingTitle')} viewAll={`${tSection('trendingViewAll')} →`} viewAllHref="/tools" />
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-3">
              {trending.map((tool, i) => (
                <div
                  key={tool.id}
                  className="bg-card border border-border rounded-xl flex items-center gap-4 p-4 transition-all duration-150 hover:border-blue-300 hover:shadow-sm"
                >
                  <span
                    className="text-base font-bold w-5 text-center flex-shrink-0"
                    style={{ color: i === 0 ? '#F59E0B' : i === 1 ? '#9CA3AF' : i === 2 ? '#92400E' : '#D1D5DB' }}
                    aria-label={`Rank ${i + 1}`}
                  >
                    {i + 1}
                  </span>
                  <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={36} />
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 mb-0.5 flex-wrap">
                      <span className="text-[13.5px] font-semibold text-foreground">{tool.name}</span>
                      <PricingBadge type={tool.pricing_type} />
                    </div>
                    <div className="text-[12px] text-muted-foreground truncate">
                      {tool.tags?.[0] ?? ''} · {tool.rating.toFixed(1)} stars · {(tool.review_count / 1000).toFixed(1)}k reviews
                    </div>
                  </div>
                  <Link
                    href={`/tools/${tool.slug}`}
                    className="text-[12px] font-semibold text-blue-600 hover:text-blue-700 flex-shrink-0 min-h-[44px] flex items-center"
                  >
                    {tSection('view')} →
                  </Link>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* TOP 10 LISTS - SEO anchor pages */}
        <section aria-label="Top 10 AI tool lists">
          <SectionHeader eyebrow={tSection('top10Eyebrow')} title={tSection('top10Title')} viewAll={`${tSection('top10ViewAll')} →`} viewAllHref="/top-10" />
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            {top10Data.map(({ list, tools }) => (
              <div key={list.slug} className="bg-card border border-border rounded-xl p-5">
                <div className="flex items-center gap-2 mb-4">
                  <span className="text-xl" aria-hidden="true">{list.emoji}</span>
                  <h3 className="text-[15px] font-bold text-foreground">{list.title}</h3>
                </div>
                <ol className="space-y-2.5">
                  {tools.map((item, i) => (
                    <li key={item.slug} className="flex items-center gap-3">
                      <span
                        className="text-[12px] font-bold w-4 text-center flex-shrink-0"
                        style={{ color: i < 3 ? rankColors[i] : '#D1D5DB' }}
                      >
                        {i + 1}
                      </span>
                      <LogoImage src={item.logo_url} websiteUrl={item.website_url} name={item.name} size={20} />
                      <span className="text-[13px] text-foreground flex-1 truncate">{item.name}</span>
                      <PricingBadge type={item.pricing_type as Tool['pricing_type']} />
                    </li>
                  ))}
                </ol>
                <Link
                  href={`/top-10/${list.slug}`}
                  className="mt-4 block text-center text-[12px] font-semibold py-2.5 rounded-lg border border-border hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors text-muted-foreground"
                >
                  {tSection('seeFullList')} →
                </Link>
              </div>
            ))}
          </div>
        </section>

        {/* NEWSLETTER - compact horizontal layout */}
        <section aria-label="Newsletter signup">
          <div className="bg-[#EFF6FF] dark:bg-[#1e3a8a]/20 border border-[#BFDBFE] dark:border-[#1e3a8a] rounded-2xl px-6 py-7 md:px-10 md:py-8 flex flex-col md:flex-row items-center justify-between gap-5">
            <div className="text-center md:text-left">
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">{tSection('newsletterEyebrow')}</p>
              <h2 className="text-[18px] md:text-[20px] font-extrabold tracking-tight text-foreground">
                {tSection('newsletterTitle')}
              </h2>
              <p className="text-[13px] text-muted-foreground mt-1">{tSection('newsletterCopy')}</p>
            </div>
            <div className="w-full md:w-auto md:min-w-[320px] flex-shrink-0">
              <NewsletterForm />
            </div>
          </div>
        </section>

      </div>
    </>
  )
}
