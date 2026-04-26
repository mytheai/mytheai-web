import { notFound } from 'next/navigation'
import Link from 'next/link'
import { createStaticClient } from '@/lib/supabase'
import { mockCategories } from '@/data/mock'
import ToolCard from '@/components/tools/ToolCard'
import type { Tool } from '@/types'
import type { Metadata } from 'next'

export const revalidate = 86400

export function generateStaticParams() {
  return mockCategories.map(c => ({ slug: c.slug }))
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const cat = mockCategories.find(c => c.slug === slug)
  if (!cat) return { title: 'Category not found | MytheAi' }
  const year = new Date().getFullYear()
  const title = `Best ${cat.name} Tools ${year}: Reviewed & Ranked | MytheAi`
  const description = `Discover the best ${cat.name.toLowerCase()} tools. Reviewed and ranked by editorial merit, not affiliate rates.`
  return {
    title,
    description,
    alternates: { canonical: `https://mytheai.com/categories/${slug}` },
    openGraph: { title, description, url: `https://mytheai.com/categories/${slug}` },
  }
}

async function getCategoryTools(tag: string): Promise<Tool[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('*')
    .contains('tags', [tag])
    .order('rating', { ascending: false })

  return (data ?? []).map(row => ({
    id: row.id,
    slug: row.slug,
    name: row.name,
    tagline: row.tagline,
    description: row.description ?? '',
    logo_url: row.logo_url ?? '',
    website_url: row.website_url ?? '',
    affiliate_url: row.affiliate_url ?? '',
    category: [],
    tags: row.tags ?? [],
    pricing_type: row.pricing_type,
    pricing_details: {
      free_tier: row.pricing_free_tier ?? false,
      starting_price: row.pricing_starting_price ?? undefined,
    },
    rating: row.rating ?? 0,
    review_count: row.review_count ?? 0,
    featured: row.featured ?? false,
    trending: row.trending ?? false,
    editor_pick: row.editor_pick ?? false,
    updated_at: row.updated_at ?? '',
    pros: row.pros ?? [],
    cons: row.cons ?? [],
    use_cases: row.use_cases ?? [],
    integrations: [],
    alternatives: [],
  }))
}

export default async function CategoryPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const cat = mockCategories.find(c => c.slug === slug)
  if (!cat) notFound()

  const tools = await getCategoryTools(slug)
  const year = new Date().getFullYear()

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'ItemList',
    name: `Best ${cat.name} Tools ${year}`,
    url: `https://mytheai.com/categories/${slug}`,
    numberOfItems: tools.length,
    itemListElement: tools.map((t, i) => ({
      '@type': 'ListItem',
      position: i + 1,
      name: t.name,
      url: `https://mytheai.com/tools/${t.slug}`,
    })),
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />

      <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">

        {/* Breadcrumb */}
        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/categories" className="hover:text-blue-600 transition-colors">Categories</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{cat.name}</span>
        </nav>

        <div className="mb-8">
          <div className="flex items-center gap-3 mb-3">
            <span className="text-4xl">{cat.emoji}</span>
            <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600">{cat.name}</p>
          </div>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
            Best {cat.name} Tools ({year})
          </h1>
          <p className="text-[15px] text-muted-foreground">
            {tools.length > 0
              ? `${tools.length} tools reviewed and ranked by editorial merit.`
              : 'Tools in this category coming soon.'}
          </p>
        </div>

        {tools.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
            {tools.map(tool => (
              <ToolCard key={tool.slug} tool={tool} />
            ))}
          </div>
        ) : (
          <div className="text-center py-16 border border-border rounded-xl bg-card">
            <p className="text-[15px] text-muted-foreground mb-4">No tools yet in this category.</p>
            <Link href="/tools" className="text-blue-600 text-[14px] hover:underline">
              Browse all tools →
            </Link>
          </div>
        )}

        <div className="mt-10 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          <strong>Editorial note:</strong> Rankings are based on rating, review count, and feature quality. Affiliate relationships never influence placement.
        </div>
      </div>
    </>
  )
}
