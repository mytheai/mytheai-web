import { notFound } from 'next/navigation'
import Image from 'next/image'
import Link from 'next/link'
import { createStaticClient } from '@/lib/supabase'
import { TOP10_LISTS, getList } from '@/data/top10'
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

function getLogoSrc(tool: ToolRow): string | null {
  if (tool.logo_url) return tool.logo_url
  if (tool.website_url) {
    try {
      return `https://www.google.com/s2/favicons?domain=${new URL(tool.website_url).hostname}&sz=64`
    } catch {
      return null
    }
  }
  return null
}

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

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />

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

        {/* Ranked list */}
        <ol className="space-y-4">
          {tools.map((tool, i) => (
            <li key={tool.slug}>
              <Link
                href={`/tools/${tool.slug}`}
                className="flex items-start gap-4 p-5 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors"
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
                  {getLogoSrc(tool)
                    ? <Image src={getLogoSrc(tool)!} alt={tool.name} width={36} height={36} unoptimized />
                    : <span className="text-[14px] font-bold text-gray-400">{tool.name.charAt(0).toUpperCase()}</span>
                  }
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
            </li>
          ))}
        </ol>

        {/* Disclosure */}
        <div className="mt-10 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          <strong>Disclosure:</strong> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Rankings are based on editorial merit. Affiliate relationships never influence placement.
        </div>

        <Link href="/tools" className="inline-block mt-6 text-[13px] text-blue-600 hover:underline">
          ← Browse all tools
        </Link>
      </div>
    </>
  )
}
