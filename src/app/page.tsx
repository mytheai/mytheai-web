import Link from 'next/link'
import Image from 'next/image'
import type { Metadata } from 'next'
import { createStaticClient } from '@/lib/supabase'
import { mockCategories } from '@/data/mock'
import { TOP10_LISTS } from '@/data/top10'
import type { Tool } from '@/types'
import NewsletterForm from '@/components/newsletter/NewsletterForm'

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

const ROLES = [
  { emoji: '💻', title: 'Developer', desc: 'Coding & AI agents', href: '/top-10/best-code-ai-tools' },
  { emoji: '📣', title: 'Marketer', desc: 'Content & campaigns', href: '/top-10/best-ai-tools-for-marketers' },
  { emoji: '✍️', title: 'Creator', desc: 'Video, audio & writing', href: '/top-10/best-ai-tools-for-content-creators' },
  { emoji: '🎓', title: 'Student', desc: 'Research & learning', href: '/top-10/best-ai-tools-for-students' },
  { emoji: '🚀', title: 'Founder', desc: 'Build & grow faster', href: '/top-10/best-ai-tools-for-startups' },
  { emoji: '🎨', title: 'Designer', desc: 'Generate & design', href: '/top-10/best-ai-design-tools' },
]

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
}

async function getEditorPicks(): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('id,slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,rating,review_count,tags,editor_pick,trending')
    .eq('editor_pick', true)
    .order('rating', { ascending: false })
    .limit(3)
  return data ?? []
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

function getLogoSrc(logoUrl: string | null, websiteUrl?: string | null): string | null {
  if (logoUrl) return logoUrl
  if (websiteUrl) {
    try {
      const hostname = new URL(websiteUrl).hostname
      return `https://www.google.com/s2/favicons?domain=${hostname}&sz=64`
    } catch {
      return null
    }
  }
  return null
}

function ToolLogo({ url, websiteUrl, name, size = 40 }: { url: string | null; websiteUrl?: string | null; name: string; size?: number }) {
  const src = getLogoSrc(url, websiteUrl)
  if (!src) return (
    <div
      className="rounded-[10px] flex items-center justify-center bg-gray-100 dark:bg-gray-800 flex-shrink-0 text-[13px] font-bold text-gray-400"
      style={{ width: size, height: size }}
    >
      {name[0]}
    </div>
  )
  return (
    <div
      className="rounded-[10px] flex items-center justify-center bg-gray-50 dark:bg-gray-800 flex-shrink-0 overflow-hidden"
      style={{ width: size, height: size }}
    >
      <Image src={src} alt={name} width={size} height={size} className="object-contain p-1" unoptimized />
    </div>
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
  const [editorPicks, trending, top10Data] = await Promise.all([
    getEditorPicks(),
    getTrending(),
    getTop10Data(),
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
        <div className="max-w-2xl mx-auto px-4 text-center">

          <h1
            className="text-[34px] sm:text-[44px] md:text-[56px] font-extrabold leading-[1.08] mb-6 text-foreground"
            style={{ letterSpacing: '-0.03em' }}
          >
            Find the AI Tool<br />
            <span className="text-blue-600">You Actually Need</span>
          </h1>

          {/* Search bar - primary CTA */}
          <form
            action="/tools"
            method="GET"
            className="flex items-center gap-2 p-1.5 mb-4 shadow-md rounded-xl border border-border bg-card"
            role="search"
          >
            <span className="pl-3 text-muted-foreground flex-shrink-0">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
                <circle cx="11" cy="11" r="8" /><path d="m21 21-4.35-4.35" />
              </svg>
            </span>
            <input
              className="flex-1 py-3.5 px-1 text-[15px] bg-transparent outline-none text-foreground placeholder:text-muted-foreground min-w-0"
              type="search"
              name="q"
              placeholder="Try: AI for writing emails, free video tools..."
              autoComplete="off"
              aria-label="Search AI tools"
            />
            <button
              type="submit"
              className="px-5 py-2.5 rounded-lg text-white text-[14px] font-semibold bg-blue-600 hover:bg-blue-700 active:bg-blue-800 transition-colors flex-shrink-0"
            >
              Search
            </button>
          </form>

          <p className="text-[14px] text-muted-foreground mb-5">
            Honest reviews. Real comparisons. No pay-to-rank.
          </p>

          {/* Quick search pills */}
          <div className="flex flex-wrap justify-center items-center gap-2 text-[12px] text-muted-foreground">
            <span className="font-medium">Popular:</span>
            {['ChatGPT alternatives', 'Free AI tools', 'AI for coding', 'Best SEO tools'].map(q => (
              <Link
                key={q}
                href={`/tools?q=${encodeURIComponent(q)}`}
                className="px-3 py-1 rounded-full border border-border bg-card hover:border-blue-300 hover:text-blue-600 transition-colors"
              >
                {q}
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* ── TRUST BAR - 3 signals ─────────────────────────────────────────── */}
      <div className="bg-card border-y border-border">
        <div className="max-w-7xl mx-auto px-5 py-3 flex items-center justify-center gap-6 md:gap-12 text-xs font-medium text-muted-foreground flex-wrap">
          {['500+ tools reviewed', 'No pay-to-rank', 'Updated weekly'].map(t => (
            <span key={t} className="flex items-center gap-1.5 whitespace-nowrap">
              <span style={{ color: '#10B981' }}>✓</span> {t}
            </span>
          ))}
        </div>
      </div>

      {/* ── MAIN CONTENT ─────────────────────────────────────────────────── */}
      <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14 space-y-12 md:space-y-16">

        {/* BROWSE BY CATEGORY - primary navigation after search */}
        <section aria-label="Browse by category">
          <SectionHeader eyebrow="Explore" title="Browse by Category" viewAll="All categories →" viewAllHref="/categories" />
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
                  <div className="text-[12px] text-muted-foreground">{cat.tool_count} tools</div>
                </div>
              </Link>
            ))}
          </div>
        </section>

        {/* EDITOR'S PICKS */}
        {editorPicks.length > 0 && (
          <section aria-label="Editor's picks">
            <SectionHeader eyebrow="Curated" title="Editor's Picks" viewAll="View all tools →" viewAllHref="/tools" />
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              {editorPicks.map(tool => (
                <Link
                  key={tool.id}
                  href={`/tools/${tool.slug}`}
                  className="bg-card border border-border rounded-xl p-5 block transition-all duration-150 hover:-translate-y-0.5 hover:shadow-xl hover:border-blue-300"
                >
                  <div className="flex items-start justify-between mb-4">
                    <div className="flex items-center gap-3">
                      <ToolLogo url={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} />
                      <div>
                        <div className="text-[14px] font-semibold text-foreground">{tool.name}</div>
                        <div className="text-[12px] text-muted-foreground">{tool.tags?.[0] ?? ''}</div>
                      </div>
                    </div>
                    <PricingBadge type={tool.pricing_type} />
                  </div>
                  <p className="text-[13px] text-muted-foreground leading-relaxed mb-4 line-clamp-2">{tool.tagline}</p>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-1.5">
                      <Stars rating={tool.rating} />
                      <span className="text-[13px] font-semibold text-foreground">{tool.rating.toFixed(1)}</span>
                      <span className="text-[12px] text-muted-foreground">({(tool.review_count / 1000).toFixed(1)}k)</span>
                    </div>
                    <span className="text-[12px] font-semibold text-blue-600">View →</span>
                  </div>
                </Link>
              ))}
            </div>
          </section>
        )}

        {/* FIND TOOLS FOR YOUR ROLE */}
        <section aria-label="Find tools by role">
          <SectionHeader eyebrow="Your Workflow" title="Find Tools For Your Role" />
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3">
            {ROLES.map(role => (
              <Link
                key={role.title}
                href={role.href}
                className="flex flex-col items-center text-center p-4 md:p-5 rounded-xl border border-border bg-card hover:border-blue-300 hover:bg-[#EFF6FF] dark:hover:bg-[#1E3A5F] transition-all duration-150 hover:-translate-y-0.5 hover:shadow-md"
              >
                <span className="text-3xl mb-2" aria-hidden="true">{role.emoji}</span>
                <span className="text-[13px] font-semibold text-foreground">{role.title}</span>
                <span className="text-[11px] text-muted-foreground mt-0.5 leading-tight">{role.desc}</span>
              </Link>
            ))}
          </div>
        </section>

        {/* TRENDING NOW */}
        {trending.length > 0 && (
          <section aria-label="Trending AI tools">
            <SectionHeader eyebrow="This Week" eyebrowColor="#F59E0B" title="Trending Now" viewAll="View all →" viewAllHref="/tools" />
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
                  <ToolLogo url={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={36} />
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
                    View →
                  </Link>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* TOP 10 LISTS - SEO anchor pages */}
        <section aria-label="Top 10 AI tool lists">
          <SectionHeader eyebrow="Ranked Lists" title="Top 10 AI Tools" viewAll="All Top 10 lists →" viewAllHref="/top-10" />
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
                      <ToolLogo url={item.logo_url} websiteUrl={item.website_url} name={item.name} size={20} />
                      <span className="text-[13px] text-foreground flex-1 truncate">{item.name}</span>
                      <PricingBadge type={item.pricing_type as Tool['pricing_type']} />
                    </li>
                  ))}
                </ol>
                <Link
                  href={`/top-10/${list.slug}`}
                  className="mt-4 block text-center text-[12px] font-semibold py-2.5 rounded-lg border border-border hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors text-muted-foreground"
                >
                  See full list →
                </Link>
              </div>
            ))}
          </div>
        </section>

        {/* NEWSLETTER - compact horizontal layout */}
        <section aria-label="Newsletter signup">
          <div className="bg-[#EFF6FF] dark:bg-[#1e3a8a]/20 border border-[#BFDBFE] dark:border-[#1e3a8a] rounded-2xl px-6 py-7 md:px-10 md:py-8 flex flex-col md:flex-row items-center justify-between gap-5">
            <div className="text-center md:text-left">
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Stay Sharp</p>
              <h2 className="text-[18px] md:text-[20px] font-extrabold tracking-tight text-foreground">
                Weekly AI Tool Picks
              </h2>
              <p className="text-[13px] text-muted-foreground mt-1">New tools, honest reviews. Every Tuesday. No spam.</p>
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
