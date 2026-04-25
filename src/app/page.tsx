import Link from 'next/link'
import Image from 'next/image'
import { createStaticClient } from '@/lib/supabase'
import { mockCategories } from '@/data/mock'
import { TOP10_LISTS } from '@/data/top10'
import type { Tool } from '@/types'

export const revalidate = 21600

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

async function getFreeTools(): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('id,slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,rating,review_count,tags,editor_pick,trending')
    .eq('pricing_free_tier', true)
    .order('rating', { ascending: false })
    .limit(4)
  return data ?? []
}

interface CompareRow { slug: string; tool_a_slug: string; tool_b_slug: string; summary: string | null }
interface CompareToolMeta { slug: string; name: string; logo_url: string | null }
interface CompareCard { cmp: CompareRow; toolA: CompareToolMeta; toolB: CompareToolMeta }

async function getComparisons(): Promise<CompareCard[]> {
  const supabase = createStaticClient()
  const { data: cmps } = await supabase
    .from('comparisons')
    .select('slug,tool_a_slug,tool_b_slug,summary')
    .limit(6)
  if (!cmps || cmps.length === 0) return []
  const allSlugs = [...new Set(cmps.flatMap((c: CompareRow) => [c.tool_a_slug, c.tool_b_slug]))]
  const { data: tools } = await supabase.from('tools').select('slug,name,logo_url').in('slug', allSlugs)
  const toolMap: Record<string, CompareToolMeta> = {}
  for (const t of tools ?? []) toolMap[t.slug] = t
  return cmps
    .filter((c: CompareRow) => toolMap[c.tool_a_slug] && toolMap[c.tool_b_slug])
    .map((c: CompareRow) => ({ cmp: c, toolA: toolMap[c.tool_a_slug], toolB: toolMap[c.tool_b_slug] }))
}

interface Top10ToolMeta { slug: string; name: string; logo_url: string | null; pricing_type: string }

async function getTop10Data() {
  const supabase = createStaticClient()
  const listsToShow = TOP10_LISTS.slice(0, 3)
  const allSlugs = [...new Set(listsToShow.flatMap(l => l.slugs))]
  const { data } = await supabase.from('tools').select('slug,name,logo_url,pricing_type').in('slug', allSlugs)
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

function ToolLogo({ url, name, size = 40 }: { url: string | null; name: string; size?: number }) {
  if (!url) return (
    <div
      className="rounded-[10px] flex items-center justify-center bg-gray-100 flex-shrink-0 text-[13px] font-bold text-gray-400"
      style={{ width: size, height: size }}
    >
      {name[0]}
    </div>
  )
  return (
    <div
      className="rounded-[10px] flex items-center justify-center bg-gray-50 flex-shrink-0 overflow-hidden"
      style={{ width: size, height: size }}
    >
      <Image src={url} alt={name} width={size} height={size} className="object-contain p-1" unoptimized />
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
  const [editorPicks, trending, freeTools, comparisons, top10Data] = await Promise.all([
    getEditorPicks(),
    getTrending(),
    getFreeTools(),
    getComparisons(),
    getTop10Data(),
  ])

  const rankColors = ['#F59E0B', '#9CA3AF', '#92400E']

  return (
    <>
      {/* ── HERO ─────────────────────────────────────────────────────────── */}
      <section className="hero-bg py-12 md:py-24">
        <div className="max-w-3xl mx-auto px-4 md:px-5 text-center">
          <div
            className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-medium mb-7 border"
            style={{ background: '#EFF6FF', borderColor: '#BFDBFE', color: '#1D4ED8' }}
          >
            <span className="w-1.5 h-1.5 rounded-full animate-pulse bg-blue-600" />
            500+ tools reviewed · Updated weekly
          </div>
          <h1
            className="text-[34px] sm:text-[42px] md:text-[58px] font-extrabold leading-[1.08] mb-5 text-foreground"
            style={{ letterSpacing: '-0.03em' }}
          >
            The AI Tools You<br /><span className="text-blue-600">Actually Need</span>
          </h1>
          <p className="text-[16px] md:text-[17px] leading-relaxed mb-8 text-muted-foreground max-w-2xl mx-auto">
            Honest reviews, real comparisons, curated picks. No fluff, no pay-to-rank.
          </p>

          {/* Search */}
          <div className="flex items-center gap-2 p-1.5 mb-5 max-w-lg mx-auto shadow-sm rounded-xl border border-border bg-card">
            <span className="pl-2 text-muted-foreground">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <circle cx="11" cy="11" r="8" /><path d="m21 21-4.35-4.35" />
              </svg>
            </span>
            <input
              className="flex-1 py-2 px-1 text-sm bg-transparent outline-none text-foreground placeholder:text-muted-foreground"
              type="text"
              placeholder="Search 500+ AI & SaaS tools…"
            />
            <button className="px-4 py-2 rounded-lg text-white text-sm font-semibold bg-blue-600 hover:bg-blue-700 transition-colors">
              Search
            </button>
          </div>

          {/* Quick links */}
          <div className="flex flex-wrap justify-center items-center gap-x-2 gap-y-2 text-[12.5px] text-muted-foreground">
            <span className="font-medium">Popular:</span>
            {['ChatGPT alternatives', 'AI image generators', 'Free coding tools', 'Best SEO tools'].map(t => (
              <Link
                key={t}
                href={`/tools?q=${encodeURIComponent(t)}`}
                className="px-3 py-1 rounded-full border border-border bg-card hover:border-blue-300 hover:text-blue-600 transition-colors"
              >
                {t}
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* ── TRUST BAR ────────────────────────────────────────────────────── */}
      <div className="bg-card border-y border-border overflow-x-auto">
        <div
          className="max-w-7xl mx-auto px-5 py-3 flex items-center justify-start md:justify-between gap-6 text-xs font-medium text-muted-foreground"
          style={{ minWidth: 'max-content', marginLeft: 'auto', marginRight: 'auto' }}
        >
          {['500+ tools reviewed', 'Updated weekly', 'Affiliate-disclosed', 'No pay-to-rank', '185+ comparisons'].map(t => (
            <span key={t} className="flex items-center gap-1.5 whitespace-nowrap">
              <span style={{ color: '#10B981' }}>✓</span> {t}
            </span>
          ))}
        </div>
      </div>

      {/* ── MAIN CONTENT ─────────────────────────────────────────────────── */}
      <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14 space-y-12 md:space-y-16">

        {/* EDITOR'S PICKS */}
        {editorPicks.length > 0 && (
          <section>
            <SectionHeader eyebrow="Curated" title="Editor's Picks" viewAll="View all →" viewAllHref="/tools?filter=editor-picks" />
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              {editorPicks.map(tool => (
                <Link
                  key={tool.id}
                  href={`/tools/${tool.slug}`}
                  className="bg-card border border-border rounded-xl p-5 block transition-all duration-150 hover:-translate-y-0.5 hover:shadow-xl hover:border-blue-300"
                >
                  <div className="flex items-start justify-between mb-4">
                    <div className="flex items-center gap-3">
                      <ToolLogo url={tool.logo_url} name={tool.name} />
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
                    <span className="text-[12px] font-semibold text-blue-600">Visit →</span>
                  </div>
                </Link>
              ))}
            </div>
          </section>
        )}

        {/* BROWSE BY CATEGORY */}
        <section>
          <SectionHeader eyebrow="Explore" title="Browse by Category" viewAll="All categories →" viewAllHref="/categories" />
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
            {mockCategories.map(cat => (
              <Link
                key={cat.id}
                href={`/tools?category=${cat.slug}`}
                className="bg-card border border-border rounded-xl flex items-center gap-3 px-4 py-3 transition-all duration-150 hover:border-blue-300 hover:bg-[#EFF6FF] dark:hover:bg-[#1E3A5F] hover:-translate-y-px"
              >
                <span className="text-2xl flex-shrink-0">{cat.emoji}</span>
                <div className="min-w-0">
                  <div className="text-[13px] font-semibold text-foreground truncate">{cat.name}</div>
                  <div className="text-[12px] text-muted-foreground">{cat.tool_count} tools</div>
                </div>
              </Link>
            ))}
          </div>
        </section>

        {/* TOP 10 LISTS */}
        <section>
          <SectionHeader eyebrow="Ranked Lists" title="Top 10 AI Tools" viewAll="All Top 10 lists →" viewAllHref="/top-10" />
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            {top10Data.map(({ list, tools }) => (
              <div key={list.slug} className="bg-card border border-border rounded-xl p-5">
                <div className="flex items-center gap-2 mb-4">
                  <span className="text-xl">{list.emoji}</span>
                  <h3 className="text-[15px] font-bold text-foreground">{list.title}</h3>
                </div>
                <ol className="space-y-2.5">
                  {tools.map((item, i) => (
                    <li key={item.slug} className="flex items-center gap-3">
                      <span
                        className="text-[12px] font-bold w-4 text-center"
                        style={{ color: i < 3 ? rankColors[i] : '#D1D5DB' }}
                      >
                        {i + 1}
                      </span>
                      <ToolLogo url={item.logo_url} name={item.name} size={20} />
                      <span className="text-[13px] text-foreground flex-1">{item.name}</span>
                      <PricingBadge type={item.pricing_type as Tool['pricing_type']} />
                    </li>
                  ))}
                </ol>
                <Link
                  href={`/top-10/${list.slug}`}
                  className="mt-4 block text-center text-[12px] font-semibold py-2 rounded-lg border border-border hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors text-muted-foreground"
                >
                  See full list →
                </Link>
              </div>
            ))}
          </div>
        </section>

        {/* TOP COMPARISONS */}
        {comparisons.length > 0 && (
          <section>
            <SectionHeader eyebrow="Head-to-Head" title="Top Comparisons" viewAll="All comparisons →" viewAllHref="/compare" />
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
              {comparisons.map(({ cmp, toolA, toolB }) => (
                <Link
                  key={cmp.slug}
                  href={`/compare/${cmp.slug}`}
                  className="bg-card border border-border rounded-xl p-4 flex flex-col gap-3 transition-all duration-150 hover:border-blue-600 hover:shadow-md"
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <ToolLogo url={toolA.logo_url} name={toolA.name} size={34} />
                      <span className="text-[13px] font-semibold text-foreground">{toolA.name}</span>
                    </div>
                    <span className="text-[11px] font-bold px-2 py-0.5 rounded-full bg-[#EFF6FF] text-blue-600">VS</span>
                    <div className="flex items-center gap-2">
                      <span className="text-[13px] font-semibold text-foreground">{toolB.name}</span>
                      <ToolLogo url={toolB.logo_url} name={toolB.name} size={34} />
                    </div>
                  </div>
                  <p className="text-[12px] text-muted-foreground">{cmp.summary}</p>
                  <span className="text-[12px] font-semibold px-3 py-1.5 rounded-lg text-center block bg-[#F3F4F6] text-[#374151]">
                    Compare features & pricing →
                  </span>
                </Link>
              ))}
            </div>
          </section>
        )}

        {/* TRENDING */}
        {trending.length > 0 && (
          <section>
            <SectionHeader eyebrow="This Week" eyebrowColor="#F59E0B" title="Trending Tools" viewAll="View all →" viewAllHref="/tools?sort=trending" />
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-3">
              {trending.map((tool, i) => (
                <div
                  key={tool.id}
                  className="bg-card border border-border rounded-xl flex items-center gap-4 p-4 transition-all duration-150 hover:border-blue-300 hover:shadow-sm"
                >
                  <span
                    className="text-base font-bold w-5 text-center flex-shrink-0"
                    style={{ color: i === 0 ? '#F59E0B' : i === 1 ? '#9CA3AF' : i === 2 ? '#92400E' : '#D1D5DB' }}
                  >
                    {i + 1}
                  </span>
                  <ToolLogo url={tool.logo_url} name={tool.name} size={34} />
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 mb-0.5">
                      <span className="text-[13.5px] font-semibold text-foreground">{tool.name}</span>
                      <PricingBadge type={tool.pricing_type} />
                    </div>
                    <div className="text-[12px] text-muted-foreground">
                      {tool.tags?.[0] ?? ''} · {tool.rating.toFixed(1)} stars · {(tool.review_count / 1000).toFixed(1)}k reviews
                    </div>
                  </div>
                  <Link
                    href={`/go/${tool.slug}`}
                    target="_blank"
                    rel="noopener noreferrer sponsored"
                    className="text-[12px] font-semibold text-blue-600 hover:text-blue-700 flex-shrink-0"
                  >
                    Visit →
                  </Link>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* FREE TOOLS */}
        {freeTools.length > 0 && (
          <section>
            <SectionHeader eyebrow="No Credit Card" eyebrowColor="#10B981" title="Free & Freemium Tools" viewAll="View all free →" viewAllHref="/tools?pricing=free" />
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
              {freeTools.map(tool => (
                <div
                  key={tool.id}
                  className="bg-card border border-border rounded-xl p-5 transition-all duration-150 hover:-translate-y-0.5 hover:shadow-xl hover:border-blue-300"
                >
                  <div className="flex items-center gap-3 mb-3">
                    <ToolLogo url={tool.logo_url} name={tool.name} />
                    <div>
                      <div className="text-[14px] font-semibold text-foreground">{tool.name}</div>
                      <PricingBadge type={tool.pricing_type} />
                    </div>
                  </div>
                  <p className="text-[13px] text-muted-foreground leading-relaxed mb-3 line-clamp-2">{tool.tagline}</p>
                  <Link
                    href={`/go/${tool.slug}`}
                    target="_blank"
                    rel="noopener noreferrer sponsored"
                    className="text-[12px] font-semibold text-blue-600 hover:text-blue-700"
                  >
                    Try free →
                  </Link>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* NEWSLETTER */}
        <section>
          <div className="bg-[#EFF6FF] border border-[#BFDBFE] rounded-2xl p-8 md:p-12 text-center">
            <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">Stay Sharp</p>
            <h2 className="text-[22px] md:text-[28px] font-extrabold tracking-tight text-foreground mb-3">
              The Best AI Tools, Every Week
            </h2>
            <p className="text-[15px] text-muted-foreground mb-6 max-w-md mx-auto">
              New tools, honest reviews. Every Tuesday.
            </p>
            <div className="flex flex-col sm:flex-row gap-2 max-w-md mx-auto">
              <input
                type="email"
                placeholder="you@example.com"
                className="flex-1 px-4 py-2.5 rounded-lg border border-[#BFDBFE] bg-white text-[14px] outline-none focus:border-blue-500"
              />
              <button className="px-5 py-2.5 rounded-lg text-white font-semibold text-[14px] bg-blue-600 hover:bg-blue-700 transition-colors whitespace-nowrap">
                Subscribe
              </button>
            </div>
            <p className="text-[11px] text-muted-foreground mt-3">No spam. Unsubscribe anytime.</p>
          </div>
        </section>

      </div>

      {/* AFFILIATE DISCLOSURE */}
      <div className="py-4 px-4 flex justify-center">
        <div className="max-w-[90%] md:max-w-[50%] bg-[#FFFBEB] border border-amber-200 rounded-xl px-5 py-3 text-center">
          <p className="text-[11.5px] text-amber-800 leading-relaxed">
            <span className="font-semibold">Affiliate disclosure:</span> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Our rankings are never influenced by affiliate relationships.
          </p>
        </div>
      </div>
    </>
  )
}
