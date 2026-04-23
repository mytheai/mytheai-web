import Link from 'next/link'
import Image from 'next/image'
import {
  mockEditorPicks,
  mockCategories,
  mockComparisons,
  mockTrending,
  mockFreeTools,
  mockTools,
} from '@/data/mock'
import type { Tool } from '@/types'

// ── Pricing badge ─────────────────────────────────────────────────────────────
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

// ── Tool logo ─────────────────────────────────────────────────────────────────
function ToolLogo({ url, name, size = 40 }: { url: string; name: string; size?: number }) {
  return (
    <div
      className="rounded-[10px] flex items-center justify-center bg-gray-50 flex-shrink-0 overflow-hidden"
      style={{ width: size, height: size }}
    >
      <Image src={url} alt={name} width={size} height={size} className="object-contain p-1" unoptimized />
    </div>
  )
}

// ── Star rating ───────────────────────────────────────────────────────────────
function Stars({ rating }: { rating: number }) {
  return (
    <span className="text-[#F59E0B] text-sm tracking-[-1px]">
      {'★'.repeat(Math.floor(rating))}{'☆'.repeat(5 - Math.floor(rating))}
    </span>
  )
}

// ── Section header ────────────────────────────────────────────────────────────
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

// ─────────────────────────────────────────────────────────────────────────────
export default function HomePage() {
  const rankColors = ['#F59E0B', '#9CA3AF', '#92400E']

  const top10Lists = [
    {
      emoji: '🧠', title: 'AI Assistants', count: 105,
      items: mockTools.filter(t => t.category.some(c => c.slug === 'ai-assistants')).slice(0, 5),
    },
    {
      emoji: '🎨', title: 'Image AI', count: 90,
      items: [
        { name: 'Midjourney', slug: 'midjourney', logo_url: 'https://www.google.com/s2/favicons?domain=midjourney.com&sz=32', pricing_type: 'paid' as const },
        { name: 'DALL·E 3', slug: 'dalle-3', logo_url: 'https://www.google.com/s2/favicons?domain=openai.com&sz=32', pricing_type: 'freemium' as const },
        { name: 'Leonardo AI', slug: 'leonardo-ai', logo_url: 'https://www.google.com/s2/favicons?domain=leonardo.ai&sz=32', pricing_type: 'freemium' as const },
        { name: 'Adobe Firefly', slug: 'adobe-firefly', logo_url: 'https://www.google.com/s2/favicons?domain=adobe.com&sz=32', pricing_type: 'freemium' as const },
        { name: 'Stable Diffusion', slug: 'stable-diffusion', logo_url: 'https://www.google.com/s2/favicons?domain=stability.ai&sz=32', pricing_type: 'free' as const },
      ],
    },
    {
      emoji: '💻', title: 'Code AI', count: 64,
      items: [
        { name: 'GitHub Copilot', slug: 'github-copilot', logo_url: 'https://www.google.com/s2/favicons?domain=github.com&sz=32', pricing_type: 'freemium' as const },
        { name: 'Cursor', slug: 'cursor', logo_url: 'https://www.google.com/s2/favicons?domain=cursor.com&sz=32', pricing_type: 'freemium' as const },
        { name: 'Vercel v0', slug: 'vercel-v0', logo_url: 'https://www.google.com/s2/favicons?domain=v0.dev&sz=32', pricing_type: 'freemium' as const },
        { name: 'Tabnine', slug: 'tabnine', logo_url: 'https://www.google.com/s2/favicons?domain=tabnine.com&sz=32', pricing_type: 'freemium' as const },
        { name: 'Replit AI', slug: 'replit', logo_url: 'https://www.google.com/s2/favicons?domain=replit.com&sz=32', pricing_type: 'freemium' as const },
      ],
    },
  ]

  return (
    <>
      {/* ── HERO ─────────────────────────────────────────────────────────── */}
      <section className="py-12 md:py-24" style={{ background: 'linear-gradient(140deg, #F8FAFF 0%, #EEF4FF 50%, #F0FFFE 100%)' }}>
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
        <section>
          <SectionHeader eyebrow="Curated" title="Editor's Picks" viewAll="View all →" viewAllHref="/tools?filter=editor-picks" />
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {mockEditorPicks.map(tool => (
              <div
                key={tool.id}
                className="bg-card border border-border rounded-xl p-5 cursor-pointer transition-all duration-150 hover:-translate-y-0.5 hover:shadow-xl hover:border-blue-300"
              >
                <div className="flex items-start justify-between mb-4">
                  <div className="flex items-center gap-3">
                    <ToolLogo url={tool.logo_url} name={tool.name} />
                    <div>
                      <div className="text-[14px] font-semibold text-foreground">{tool.name}</div>
                      <div className="text-[12px] text-muted-foreground">{tool.category[0]?.name}</div>
                    </div>
                  </div>
                  <PricingBadge type={tool.pricing_type} />
                </div>
                <p className="text-[13px] text-muted-foreground leading-relaxed mb-4 line-clamp-2">{tool.tagline}</p>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-1.5">
                    <Stars rating={tool.rating} />
                    <span className="text-[13px] font-semibold text-foreground">{tool.rating}</span>
                    <span className="text-[12px] text-muted-foreground">({(tool.review_count / 1000).toFixed(1)}k)</span>
                  </div>
                  <Link
                    href={`/go/${tool.slug}`}
                    target="_blank"
                    rel="noopener noreferrer sponsored"
                    className="text-[12px] font-semibold text-blue-600 hover:text-blue-700"
                  >
                    Visit →
                  </Link>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* BROWSE BY CATEGORY */}
        <section>
          <SectionHeader eyebrow="Explore" title="Browse by Category" viewAll="All categories →" viewAllHref="/categories" />
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
            {mockCategories.map(cat => (
              <Link
                key={cat.id}
                href={`/categories/${cat.slug}`}
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
            {top10Lists.map(list => (
              <div key={list.title} className="bg-card border border-border rounded-xl p-5">
                <div className="flex items-center gap-2 mb-4">
                  <span className="text-xl">{list.emoji}</span>
                  <h3 className="text-[15px] font-bold text-foreground">{list.title}</h3>
                  <span className="ml-auto text-[11px] text-muted-foreground">{list.count} tools</span>
                </div>
                <ol className="space-y-2.5">
                  {list.items.map((item, i) => (
                    <li key={item.slug} className="flex items-center gap-3">
                      <span
                        className="text-[12px] font-bold w-4 text-center"
                        style={{ color: i < 3 ? rankColors[i] : '#D1D5DB' }}
                      >
                        {i + 1}
                      </span>
                      <Image src={item.logo_url} alt={item.name} width={20} height={20} className="w-5 h-5 rounded" unoptimized />
                      <span className="text-[13px] text-foreground flex-1">{item.name}</span>
                      <PricingBadge type={item.pricing_type} />
                    </li>
                  ))}
                </ol>
                <Link
                  href={`/top-10/${list.title.toLowerCase().replace(/ /g, '-')}`}
                  className="mt-4 block text-center text-[12px] font-semibold py-2 rounded-lg border border-border hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors text-muted-foreground"
                >
                  See all {list.count} →
                </Link>
              </div>
            ))}
          </div>
        </section>

        {/* TOP COMPARISONS */}
        <section>
          <SectionHeader eyebrow="Head-to-Head" title="Top Comparisons" viewAll="All 185+ →" viewAllHref="/compare" />
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            {mockComparisons.map(cmp => {
              const toolA = mockTools.find(t => t.slug === cmp.tool_a)
              const toolB = mockTools.find(t => t.slug === cmp.tool_b)
              const nameA = toolA?.name ?? cmp.tool_a
              const nameB = toolB?.name ?? cmp.tool_b
              const logoA = toolA?.logo_url ?? `https://www.google.com/s2/favicons?domain=${cmp.tool_a}.com&sz=64`
              const logoB = toolB?.logo_url ?? `https://www.google.com/s2/favicons?domain=${cmp.tool_b}.com&sz=64`
              return (
                <Link
                  key={cmp.slug}
                  href={`/compare/${cmp.slug}`}
                  className="bg-card border border-border rounded-xl p-4 flex flex-col gap-3 transition-all duration-150 hover:border-blue-600 hover:shadow-md"
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <ToolLogo url={logoA} name={nameA} size={34} />
                      <span className="text-[13px] font-semibold text-foreground">{nameA}</span>
                    </div>
                    <span className="text-[11px] font-bold px-2 py-0.5 rounded-full bg-[#EFF6FF] text-blue-600">VS</span>
                    <div className="flex items-center gap-2">
                      <span className="text-[13px] font-semibold text-foreground">{nameB}</span>
                      <ToolLogo url={logoB} name={nameB} size={34} />
                    </div>
                  </div>
                  <p className="text-[12px] text-muted-foreground">{cmp.summary}</p>
                  <span className="text-[12px] font-semibold px-3 py-1.5 rounded-lg text-center block bg-[#F3F4F6] text-[#374151]">
                    Compare features & pricing →
                  </span>
                </Link>
              )
            })}
          </div>
        </section>

        {/* TRENDING */}
        <section>
          <SectionHeader eyebrow="This Week" eyebrowColor="#F59E0B" title="Trending Tools" viewAll="View all →" viewAllHref="/tools?sort=trending" />
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-3">
            {mockTrending.map(({ rank, tool }) => (
              <div
                key={tool.id}
                className="bg-card border border-border rounded-xl flex items-center gap-4 p-4 transition-all duration-150 hover:border-blue-300 hover:shadow-sm"
              >
                <span
                  className="text-base font-bold w-5 text-center flex-shrink-0"
                  style={{ color: rank === 1 ? '#F59E0B' : rank === 2 ? '#9CA3AF' : rank === 3 ? '#92400E' : '#D1D5DB' }}
                >
                  {rank}
                </span>
                <ToolLogo url={tool.logo_url} name={tool.name} size={34} />
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 mb-0.5">
                    <span className="text-[13.5px] font-semibold text-foreground">{tool.name}</span>
                    <PricingBadge type={tool.pricing_type} />
                  </div>
                  <div className="text-[12px] text-muted-foreground">
                    {tool.category[0]?.name} · {tool.rating} stars · {(tool.review_count / 1000).toFixed(1)}k reviews
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

        {/* FREE TOOLS */}
        <section>
          <SectionHeader eyebrow="No Credit Card" eyebrowColor="#10B981" title="Free & Freemium Tools" viewAll="View all free →" viewAllHref="/tools?filter=free" />
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            {mockFreeTools.map(tool => (
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
