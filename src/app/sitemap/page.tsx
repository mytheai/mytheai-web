import type { Metadata } from 'next'
import Link from 'next/link'
import { createStaticClient } from '@/lib/supabase'
import { TOP10_LISTS } from '@/data/top10'
import { ROLES } from '@/data/roles'
import { mockCategories } from '@/data/mock'

export const revalidate = 86400

export const metadata: Metadata = {
  title: 'Site Map - All Pages on MytheAi',
  description: 'Full index of MytheAi pages: tool reviews, comparisons, top 10 lists, hand-tested money pages, role guides, tasks, blog articles. Find anything in one place.',
  alternates: { canonical: 'https://mytheai.com/sitemap' },
  openGraph: {
    title: 'Site Map - All Pages on MytheAi',
    url: 'https://mytheai.com/sitemap',
  },
}

const REDIRECTED_TOP10_SLUGS = new Set([
  'best-ai-writing-tools', 'best-code-ai-tools', 'best-ai-seo-tools',
  'best-ai-video-tools', 'best-ai-image-generators', 'best-ai-agent-tools',
  'best-workflow-automation-tools', 'best-ai-sales-tools', 'best-ai-customer-service-tools',
  'best-ai-legal-tools', 'best-ai-tools-for-finance', 'best-ai-healthcare-tools',
  'best-ai-marketing-tools', 'best-ai-design-tools', 'best-ai-research-tools',
  'best-ai-productivity-tools',
])

const BEST_CATEGORIES: Array<{ slug: string; label: string }> = [
  { slug: 'writing', label: 'Writing' },
  { slug: 'coding', label: 'Coding' },
  { slug: 'seo', label: 'SEO' },
  { slug: 'video', label: 'Video' },
  { slug: 'image', label: 'Image generation' },
  { slug: 'agents', label: 'AI agents' },
  { slug: 'automation', label: 'Automation' },
  { slug: 'sales', label: 'Sales' },
  { slug: 'customer-support', label: 'Customer support' },
  { slug: 'legal', label: 'Legal' },
  { slug: 'finance', label: 'Finance' },
  { slug: 'healthcare', label: 'Healthcare' },
  { slug: 'marketing', label: 'Marketing' },
  { slug: 'design', label: 'Design' },
  { slug: 'research', label: 'Research' },
  { slug: 'productivity', label: 'Productivity' },
]

const FREE_CATEGORIES: Array<{ slug: string; label: string }> = [
  { slug: 'ai-assistants', label: 'AI assistants' },
  { slug: 'writing-ai', label: 'AI writing' },
  { slug: 'image-ai', label: 'AI image' },
  { slug: 'video-ai', label: 'AI video' },
  { slug: 'code-ai', label: 'AI coding' },
  { slug: 'seo-marketing', label: 'AI SEO & marketing' },
  { slug: 'productivity', label: 'AI productivity' },
  { slug: 'voice-audio', label: 'AI voice & audio' },
  { slug: 'analytics', label: 'AI analytics' },
  { slug: 'automation', label: 'AI automation' },
]

interface TopToolRow {
  slug: string
  name: string
}

interface TopTaskRow {
  slug: string
  title: string
  emoji: string | null
}

interface RecentBlogRow {
  slug: string
  title: string
}

interface RecentCompareRow {
  slug: string
  tool_a_slug: string
  tool_b_slug: string
}

// Surface the catalog highlights without dumping all 1683 URLs. Yandex IKS
// values categorized HTML sitemaps higher than flat lists - it parses section
// headings as topical signals. Each section also links to its hub for full
// coverage; the XML sitemap at /sitemap.xml still ships the complete URL list
// for crawlers that prefer that.
async function getHighlights() {
  const supabase = createStaticClient()
  const [toolsRes, tasksRes, blogsRes, comparesRes, handTestedRes] = await Promise.all([
    supabase
      .from('tools')
      .select('slug,name')
      .order('review_count', { ascending: false })
      .limit(50),
    supabase
      .from('tasks')
      .select('slug,title,emoji')
      .eq('status', 'published')
      .order('monthly_search_volume', { ascending: false, nullsFirst: false })
      .limit(40),
    supabase
      .from('tools')
      .select('slug,name')
      .not('hands_on_notes', 'is', null)
      .order('last_tested_at', { ascending: false })
      .limit(30),
    supabase
      .from('comparisons')
      .select('slug,tool_a_slug,tool_b_slug')
      .order('updated_at', { ascending: false })
      .limit(30),
    supabase
      .from('tools')
      .select('slug,name,review_count')
      .not('hands_on_notes', 'is', null)
      .order('review_count', { ascending: false })
      .limit(30),
  ])
  return {
    topTools: (toolsRes.data ?? []) as TopToolRow[],
    topTasks: (tasksRes.data ?? []) as TopTaskRow[],
    recentBlogs: [] as RecentBlogRow[],
    recentCompares: (comparesRes.data ?? []) as RecentCompareRow[],
    handTested: (handTestedRes.data ?? []) as TopToolRow[],
  }
}

function compareName(slug: string) {
  return slug.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ')
}

export default async function SiteMapPage() {
  const { topTools, topTasks, recentCompares, handTested } = await getHighlights()
  const visibleTop10 = TOP10_LISTS.filter(l => !REDIRECTED_TOP10_SLUGS.has(l.slug))

  // ProfilePage-like CollectionPage schema declares this as the site map index
  // page. Helps Yandex IKS classify the page intent (navigation, not content).
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    name: 'MytheAi Site Map',
    url: 'https://mytheai.com/sitemap',
    description: 'Full index of pages on MytheAi - hubs, money pages, top 10 lists, role guides, hand-tested reviews, tasks, comparisons, blog.',
    breadcrumb: {
      '@type': 'BreadcrumbList',
      itemListElement: [
        { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
        { '@type': 'ListItem', position: 2, name: 'Site Map', item: 'https://mytheai.com/sitemap' },
      ],
    },
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />

      <div className="max-w-5xl mx-auto px-4 md:px-5 py-10 md:py-14">

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <span className="text-foreground font-medium">Site Map</span>
        </nav>

        <header className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">Navigation</p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            Site map
          </h1>
          <p className="text-[15px] text-muted-foreground leading-relaxed max-w-3xl">
            Every major page on MytheAi grouped by section. The XML feed at{' '}
            <a href="/sitemap.xml" className="text-blue-600 hover:underline">/sitemap.xml</a>{' '}
            ships the full URL list for search engines. This page is the human-friendly index.
          </p>
        </header>

        <div className="grid md:grid-cols-2 gap-10">

          {/* Main hubs */}
          <section>
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">Main hubs</h2>
            <ul className="space-y-2 text-[14px]">
              <li><Link href="/" className="text-blue-600 hover:underline">Home</Link></li>
              <li><Link href="/tools" className="text-blue-600 hover:underline">Tools directory</Link> <span className="text-muted-foreground text-[12px]">(585 reviewed tools)</span></li>
              <li><Link href="/compare" className="text-blue-600 hover:underline">Comparisons hub</Link> <span className="text-muted-foreground text-[12px]">(252 head-to-head pairs)</span></li>
              <li><Link href="/top-10" className="text-blue-600 hover:underline">Top 10 lists</Link> <span className="text-muted-foreground text-[12px]">({visibleTop10.length} curated lists)</span></li>
              <li><Link href="/best" className="text-blue-600 hover:underline">Hand-tested top picks</Link> <span className="text-muted-foreground text-[12px]">({BEST_CATEGORIES.length} money pages)</span></li>
              <li><Link href="/tasks" className="text-blue-600 hover:underline">Tasks index</Link> <span className="text-muted-foreground text-[12px]">(506 task pages by intent)</span></li>
              <li><Link href="/blog" className="text-blue-600 hover:underline">Blog</Link> <span className="text-muted-foreground text-[12px]">(101 long-form articles)</span></li>
              <li><Link href="/categories" className="text-blue-600 hover:underline">Categories</Link></li>
              <li><Link href="/quiz" className="text-blue-600 hover:underline">Find your stack quiz</Link></li>
              <li><Link href="/wishlist" className="text-blue-600 hover:underline">Your wishlist</Link></li>
              <li><Link href="/glossary" className="text-blue-600 hover:underline">AI glossary</Link></li>
              <li><Link href="/deals" className="text-blue-600 hover:underline">Deals</Link></li>
            </ul>
          </section>

          {/* Hand-tested money pages */}
          <section>
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">Hand-tested top picks by category</h2>
            <ul className="grid grid-cols-2 gap-x-4 gap-y-2 text-[14px]">
              {BEST_CATEGORIES.map(c => (
                <li key={c.slug}>
                  <Link href={`/best/${c.slug}`} className="text-emerald-700 dark:text-emerald-400 hover:underline">{c.label}</Link>
                </li>
              ))}
            </ul>
          </section>

          {/* By role */}
          <section>
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">By role</h2>
            <ul className="grid grid-cols-2 gap-x-4 gap-y-2 text-[14px]">
              {ROLES.map(r => (
                <li key={r.slug}>
                  <Link href={`/roles/${r.slug}`} className="text-blue-600 hover:underline">
                    <span className="mr-1.5" aria-hidden="true">{r.emoji}</span>{r.title}
                  </Link>
                </li>
              ))}
            </ul>
          </section>

          {/* Free AI tools */}
          <section>
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">Free AI tools by category</h2>
            <ul className="grid grid-cols-2 gap-x-4 gap-y-2 text-[14px]">
              {FREE_CATEGORIES.map(c => (
                <li key={c.slug}>
                  <Link href={`/free-ai-tools/${c.slug}`} className="text-emerald-700 dark:text-emerald-400 hover:underline">{c.label}</Link>
                </li>
              ))}
            </ul>
          </section>

          {/* Top 10 lists */}
          <section className="md:col-span-2">
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">Top 10 lists ({visibleTop10.length})</h2>
            <ul className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-x-4 gap-y-2 text-[14px]">
              {visibleTop10.map(l => (
                <li key={l.slug}>
                  <Link href={`/top-10/${l.slug}`} className="text-blue-600 hover:underline">
                    <span className="mr-1.5" aria-hidden="true">{l.emoji}</span>{l.title}
                  </Link>
                </li>
              ))}
            </ul>
          </section>

          {/* Hand-tested reviews */}
          <section className="md:col-span-2">
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">
              Hand-tested reviews ({handTested.length} most-reviewed)
            </h2>
            <p className="text-[12px] text-muted-foreground mb-3">Each review tested live by John Pham. Full set of 145 hand-tested tools at{' '}
              <Link href="/tools?testedBy=john-pham" className="text-blue-600 hover:underline">Tools directory filtered</Link>.
            </p>
            <ul className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-x-4 gap-y-1.5 text-[13px]">
              {handTested.map(t => (
                <li key={t.slug}>
                  <Link href={`/tools/${t.slug}`} className="text-foreground hover:text-blue-600 hover:underline">{t.name}</Link>
                </li>
              ))}
            </ul>
          </section>

          {/* Top tools */}
          <section className="md:col-span-2">
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">
              Most-reviewed tools (top 50)
            </h2>
            <p className="text-[12px] text-muted-foreground mb-3">
              Browse all 585 reviewed tools at the{' '}
              <Link href="/tools" className="text-blue-600 hover:underline">Tools directory</Link>.
            </p>
            <ul className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-x-4 gap-y-1.5 text-[13px]">
              {topTools.map(t => (
                <li key={t.slug}>
                  <Link href={`/tools/${t.slug}`} className="text-foreground hover:text-blue-600 hover:underline">{t.name}</Link>
                </li>
              ))}
            </ul>
          </section>

          {/* Tasks */}
          <section className="md:col-span-2">
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">
              Tasks by intent (top {topTasks.length})
            </h2>
            <p className="text-[12px] text-muted-foreground mb-3">
              Browse all 506 task pages at the{' '}
              <Link href="/tasks" className="text-blue-600 hover:underline">Tasks index</Link>.
            </p>
            <ul className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-x-4 gap-y-1.5 text-[13px]">
              {topTasks.map(t => (
                <li key={t.slug}>
                  <Link href={`/tasks/${t.slug}`} className="text-foreground hover:text-blue-600 hover:underline">
                    {t.emoji && <span className="mr-1.5" aria-hidden="true">{t.emoji}</span>}{t.title}
                  </Link>
                </li>
              ))}
            </ul>
          </section>

          {/* Recent comparisons */}
          <section className="md:col-span-2">
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">
              Recent comparisons ({recentCompares.length})
            </h2>
            <p className="text-[12px] text-muted-foreground mb-3">
              Browse all 252 head-to-head comparisons at the{' '}
              <Link href="/compare" className="text-blue-600 hover:underline">Comparisons hub</Link>.
            </p>
            <ul className="grid grid-cols-1 md:grid-cols-2 gap-x-4 gap-y-1.5 text-[13px]">
              {recentCompares.map(c => {
                const a = compareName(c.tool_a_slug)
                const b = compareName(c.tool_b_slug)
                return (
                  <li key={c.slug}>
                    <Link href={`/compare/${c.slug}`} className="text-foreground hover:text-blue-600 hover:underline">
                      {a} vs {b}
                    </Link>
                  </li>
                )
              })}
            </ul>
          </section>

          {/* Categories */}
          <section>
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">Categories</h2>
            <ul className="grid grid-cols-2 gap-x-4 gap-y-2 text-[14px]">
              {mockCategories.map(cat => (
                <li key={cat.slug}>
                  <Link href={`/categories/${cat.slug}`} className="text-blue-600 hover:underline">
                    <span className="mr-1.5" aria-hidden="true">{cat.emoji}</span>{cat.name}
                  </Link>
                </li>
              ))}
            </ul>
          </section>

          {/* Trust & info */}
          <section>
            <h2 className="text-[18px] font-bold text-foreground mb-3 pb-2 border-b border-border">Trust & info</h2>
            <ul className="space-y-2 text-[14px]">
              <li><Link href="/about" className="text-blue-600 hover:underline">About MytheAi</Link></li>
              <li><Link href="/methodology" className="text-blue-600 hover:underline">Editorial methodology</Link></li>
              <li><Link href="/transparency" className="text-blue-600 hover:underline">Transparency report</Link></li>
              <li><Link href="/press" className="text-blue-600 hover:underline">Press & media kit</Link></li>
              <li><Link href="/authors/john-ethan" className="text-blue-600 hover:underline">John Pham (Founder)</Link></li>
              <li><Link href="/submit" className="text-blue-600 hover:underline">Submit a tool</Link></li>
              <li><Link href="/contact" className="text-blue-600 hover:underline">Contact</Link></li>
              <li><Link href="/privacy" className="text-blue-600 hover:underline">Privacy policy</Link></li>
              <li><Link href="/about#affiliate" className="text-blue-600 hover:underline">Affiliate disclosure</Link></li>
            </ul>
          </section>

        </div>

        <p className="mt-12 pt-8 border-t border-border text-[12px] text-muted-foreground">
          Crawlers prefer the XML feed: <a href="/sitemap.xml" className="text-blue-600 hover:underline">sitemap.xml</a> (1,683+ URLs auto-generated).
          IndexNow API pings Bing, Yandex, Naver, and Seznam after every deploy.
        </p>

      </div>
    </>
  )
}
