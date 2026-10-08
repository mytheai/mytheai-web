import Link from 'next/link'
import type { Metadata } from 'next'
import { createStaticClient } from '@/lib/supabase'
import { TOP10_LISTS } from '@/data/top10'
import { ROLES } from '@/data/roles'
import LogoImage from '@/components/ui/LogoImage'

export const revalidate = 86400

export const metadata: Metadata = {
  title: 'Discover AI Tools 2026: Browse by Task, Category, Role & Rankings | MytheAi',
  description: 'One hub to find the right AI tool: 506 use-case guides, 16 hand-tested category picks, 8 role-based stacks, and 57 Top 10 rankings. Editorial scores, no pay-to-rank.',
  alternates: { canonical: 'https://mytheai.com/discover' },
  openGraph: {
    title: 'Discover AI Tools: Browse by Task, Category, Role & Rankings | MytheAi',
    description: 'One hub to find the right AI tool. 506 use-case guides + 16 hand-tested category picks + role-based stacks + Top 10 rankings.',
    url: 'https://mytheai.com/discover',
  },
}

// Reuse the same 16 categories from /best/page.tsx so Discover + Best stay in sync.
const BEST_CATEGORIES = [
  { slug: 'writing', label: 'Writing', emoji: '✍️' },
  { slug: 'coding', label: 'Coding', emoji: '💻' },
  { slug: 'seo', label: 'SEO', emoji: '🔍' },
  { slug: 'video', label: 'Video', emoji: '🎬' },
  { slug: 'image', label: 'Image', emoji: '🎨' },
  { slug: 'agents', label: 'AI Agents', emoji: '🤖' },
  { slug: 'automation', label: 'Automation', emoji: '⚡' },
  { slug: 'sales', label: 'Sales', emoji: '💼' },
  { slug: 'customer-support', label: 'Customer Support', emoji: '🎧' },
  { slug: 'legal', label: 'Legal', emoji: '⚖️' },
  { slug: 'finance', label: 'Finance', emoji: '💰' },
  { slug: 'healthcare', label: 'Healthcare', emoji: '🏥' },
  { slug: 'marketing', label: 'Marketing', emoji: '📣' },
  { slug: 'design', label: 'Design', emoji: '🎨' },
  { slug: 'research', label: 'Research', emoji: '🔬' },
  { slug: 'productivity', label: 'Productivity', emoji: '⚙️' },
]

const FEATURED_TOP10_SLUGS = [
  'best-code-ai-tools',
  'best-ai-image-generators',
  'best-ai-video-tools',
  'best-ai-writing-tools',
  'best-ai-voice-tools',
  'best-ai-seo-tools',
  'best-ai-research-tools',
  'best-ai-app-builders',
]

interface TaskPreview {
  slug: string
  title: string
  emoji: string
  monthly_search_volume: number | null
}

interface RoleToolMeta {
  slug: string
  name: string
  logo_url: string | null
  website_url: string | null
}

async function getTopTasks(): Promise<TaskPreview[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tasks')
    .select('slug,title,emoji,monthly_search_volume')
    .eq('status', 'published')
    .order('monthly_search_volume', { ascending: false, nullsFirst: false })
    .limit(12)
  return (data ?? []) as TaskPreview[]
}

async function getTaskCount(): Promise<number> {
  const supabase = createStaticClient()
  const { count } = await supabase
    .from('tasks')
    .select('*', { count: 'exact', head: true })
    .eq('status', 'published')
  return count ?? 0
}

async function getRolePreviewTools(): Promise<Record<string, RoleToolMeta>> {
  const supabase = createStaticClient()
  const previewSlugs = [...new Set(ROLES.flatMap(r => r.primaryToolSlugs.slice(0, 4)))]
  const { data } = await supabase
    .from('tools')
    .select('slug,name,logo_url,website_url')
    .in('slug', previewSlugs)
  const map: Record<string, RoleToolMeta> = {}
  for (const row of (data ?? []) as RoleToolMeta[]) map[row.slug] = row
  return map
}

async function getHandsOnCount(): Promise<number> {
  const supabase = createStaticClient()
  const { count } = await supabase
    .from('tools')
    .select('*', { count: 'exact', head: true })
    .not('tested_by', 'is', null)
  return count ?? 0
}

export default async function DiscoverPage() {
  const [topTasks, taskCount, roleToolMap, handsOnCount] = await Promise.all([
    getTopTasks(),
    getTaskCount(),
    getRolePreviewTools(),
    getHandsOnCount(),
  ])

  const featuredLists = FEATURED_TOP10_SLUGS
    .map(slug => TOP10_LISTS.find(l => l.slug === slug))
    .filter(Boolean) as typeof TOP10_LISTS

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Discover', item: 'https://mytheai.com/discover' },
    ],
  }

  const collectionJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    name: 'Discover AI Tools',
    description: 'One hub to find the right AI tool via tasks, categories, roles, or rankings.',
    url: 'https://mytheai.com/discover',
    publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(collectionJsonLd) }} />

      <div className="max-w-5xl mx-auto px-4 md:px-5 py-10 md:py-14">

        {/* Breadcrumb */}
        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-6">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <span className="text-foreground font-medium">Discover</span>
        </nav>

        {/* Hero */}
        <div className="mb-12 text-center">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">Discover</p>
          <h1 className="text-[32px] md:text-[44px] font-extrabold tracking-tight text-foreground mb-4">
            Find the right AI tool for you
          </h1>
          <p className="text-[16px] text-muted-foreground max-w-2xl mx-auto leading-relaxed">
            Four ways to browse: by what you want to do, by category, by your role, or by Top 10 rankings. All picks hand-reviewed - no pay-to-rank.
          </p>
          {handsOnCount > 0 && (
            <p className="mt-3 inline-flex items-center gap-1.5 text-[13px] font-medium text-emerald-700 dark:text-emerald-400">
              <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth="3" viewBox="0 0 24 24" aria-hidden="true">
                <polyline points="20 6 9 17 4 12" />
              </svg>
              {handsOnCount} tools with full hands-on reviews by John Pham
            </p>
          )}
        </div>

        {/* Section 1 - By task */}
        <section className="mb-14">
          <div className="flex items-baseline justify-between mb-5">
            <div>
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">By what you want to do</p>
              <h2 className="text-[22px] md:text-[26px] font-extrabold tracking-tight text-foreground">
                <span className="mr-2" aria-hidden="true">🎯</span>Browse {taskCount}+ use cases
              </h2>
            </div>
            <Link href="/tasks" className="hidden sm:inline-flex text-[13px] font-semibold text-blue-600 hover:underline whitespace-nowrap">
              See all {taskCount} tasks →
            </Link>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
            {topTasks.map(task => (
              <Link
                key={task.slug}
                href={`/tasks/${task.slug}`}
                className="flex items-start gap-3 p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors group"
              >
                <span className="text-[20px] flex-shrink-0" aria-hidden="true">{task.emoji}</span>
                <div className="min-w-0 flex-1">
                  <div className="text-[14px] font-bold text-foreground group-hover:text-blue-600 transition-colors">
                    {task.title}
                  </div>
                  {task.monthly_search_volume ? (
                    <div className="text-[12px] text-muted-foreground mt-0.5">
                      {task.monthly_search_volume.toLocaleString()} searches/mo
                    </div>
                  ) : null}
                </div>
              </Link>
            ))}
          </div>
          <Link
            href="/tasks"
            className="sm:hidden mt-4 inline-flex text-[13px] font-semibold text-blue-600 hover:underline"
          >
            See all {taskCount} tasks →
          </Link>
        </section>

        {/* Section 2 - Best in category */}
        <section className="mb-14">
          <div className="flex items-baseline justify-between mb-5">
            <div>
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-emerald-700 mb-1">Hand-tested picks</p>
              <h2 className="text-[22px] md:text-[26px] font-extrabold tracking-tight text-foreground">
                <span className="mr-2" aria-hidden="true">📊</span>Best in each category
              </h2>
            </div>
            <Link href="/best" className="hidden sm:inline-flex text-[13px] font-semibold text-blue-600 hover:underline whitespace-nowrap">
              Browse all 16 categories →
            </Link>
          </div>
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
            {BEST_CATEGORIES.map(cat => (
              <Link
                key={cat.slug}
                href={`/best/${cat.slug}`}
                className="flex items-center gap-2 p-3.5 rounded-xl border border-border bg-card hover:border-emerald-300 hover:bg-emerald-50/30 dark:hover:bg-emerald-950/10 transition-all"
              >
                <span className="text-[20px] flex-shrink-0" aria-hidden="true">{cat.emoji}</span>
                <span className="text-[13.5px] font-semibold text-foreground">{cat.label}</span>
              </Link>
            ))}
          </div>
          <Link
            href="/best"
            className="sm:hidden mt-4 inline-flex text-[13px] font-semibold text-blue-600 hover:underline"
          >
            Browse all 16 categories →
          </Link>
        </section>

        {/* Section 3 - By role */}
        <section className="mb-14">
          <div className="flex items-baseline justify-between mb-5">
            <div>
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-purple-600 mb-1">Curated stacks</p>
              <h2 className="text-[22px] md:text-[26px] font-extrabold tracking-tight text-foreground">
                <span className="mr-2" aria-hidden="true">👤</span>For your role
              </h2>
            </div>
            <Link href="/top-10#by-role" className="hidden sm:inline-flex text-[13px] font-semibold text-blue-600 hover:underline whitespace-nowrap">
              All 8 role guides →
            </Link>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            {ROLES.map(role => {
              const previewTools = role.primaryToolSlugs.slice(0, 4).map(s => roleToolMap[s]).filter(Boolean) as RoleToolMeta[]
              return (
                <Link
                  key={role.slug}
                  href={`/roles/${role.slug}`}
                  className="group block border border-border rounded-xl p-4 bg-card transition-all duration-150 hover:border-purple-300 hover:shadow-md"
                >
                  <div className="flex items-start gap-3 mb-2">
                    <span className="text-2xl flex-shrink-0" aria-hidden="true">{role.emoji}</span>
                    <div className="min-w-0 flex-1">
                      <h3 className="text-[15px] font-bold text-foreground group-hover:text-purple-600 transition-colors">{role.title}</h3>
                      <p className="text-[12px] text-muted-foreground">{role.desc}</p>
                    </div>
                  </div>
                  {previewTools.length > 0 && (
                    <div className="flex items-center gap-1.5 flex-wrap mt-2">
                      {previewTools.map(tool => (
                        <div key={tool.slug} className="flex items-center gap-1 text-[11.5px] text-foreground bg-background border border-border rounded-full pl-1 pr-2 py-0.5">
                          <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={16} />
                          <span className="font-medium">{tool.name}</span>
                        </div>
                      ))}
                    </div>
                  )}
                </Link>
              )
            })}
          </div>
          <Link
            href="/top-10#by-role"
            className="sm:hidden mt-4 inline-flex text-[13px] font-semibold text-blue-600 hover:underline"
          >
            All 8 role guides →
          </Link>
        </section>

        {/* Section 4 - Top 10 rankings */}
        <section className="mb-14">
          <div className="flex items-baseline justify-between mb-5">
            <div>
              <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-amber-600 mb-1">Editorial rankings</p>
              <h2 className="text-[22px] md:text-[26px] font-extrabold tracking-tight text-foreground">
                <span className="mr-2" aria-hidden="true">🏆</span>Top 10 lists
              </h2>
            </div>
            <Link href="/top-10" className="hidden sm:inline-flex text-[13px] font-semibold text-blue-600 hover:underline whitespace-nowrap">
              All rankings →
            </Link>
          </div>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {featuredLists.map(list => (
              <Link
                key={list.slug}
                href={`/top-10/${list.slug}`}
                className="block p-4 rounded-xl border border-border bg-card hover:border-amber-300 hover:shadow-md transition-all"
              >
                <span className="text-2xl block mb-2" aria-hidden="true">{list.emoji}</span>
                <p className="text-[14px] font-bold text-foreground leading-snug mb-1">{list.title}</p>
                <p className="text-[11px] text-amber-600 font-semibold">Top {list.slugs.length} →</p>
              </Link>
            ))}
          </div>
          <Link
            href="/top-10"
            className="sm:hidden mt-4 inline-flex text-[13px] font-semibold text-blue-600 hover:underline"
          >
            All rankings →
          </Link>
        </section>

        {/* Footer CTA */}
        <div className="mt-16 p-6 rounded-xl border border-border bg-card text-center">
          <h2 className="text-[16px] font-bold text-foreground mb-2">Not sure where to start?</h2>
          <p className="text-[14px] text-muted-foreground mb-4">
            Take the 90-second quiz to get a personalized shortlist based on your role, budget, and workflow.
          </p>
          <Link
            href="/quiz"
            className="inline-flex items-center gap-1.5 px-4 py-2 rounded-lg text-[14px] font-semibold text-white bg-blue-600 hover:bg-blue-700 transition-colors"
          >
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
              <path d="M12 2l2.5 8H22l-7 5 2.5 8.5L12 19l-6.5 4.5L8 15l-7-5h7.5z" />
            </svg>
            Take the quiz
          </Link>
        </div>

      </div>
    </>
  )
}
