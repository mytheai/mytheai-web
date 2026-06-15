import { notFound } from 'next/navigation'
import Link from 'next/link'
import LogoImage from '@/components/ui/LogoImage'
import AuthorBio from '@/components/layout/AuthorBio'
import { getAuthorJsonLd } from '@/data/authors'
import { createStaticClient } from '@/lib/supabase'
import { metaDescription } from '@/lib/meta-description'
import type { Metadata } from 'next'

export const revalidate = 604800

interface Task {
  slug: string
  title: string
  h1_override: string | null
  emoji: string
  primary_tags: string[]
  picked_slugs: string[]
  fallback_min: number
  intro: string
  methodology: string | null
  faqs: { q: string; a: string }[]
  category: string | null
  difficulty: string
  monthly_search_volume: number | null
  related_top10_slugs: string[]
  related_use_case_slug: string | null
  related_blog_slugs: string[]
  updated_at: string
}

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

async function getTask(slug: string): Promise<Task | null> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tasks')
    .select('slug,title,h1_override,emoji,primary_tags,picked_slugs,fallback_min,intro,methodology,faqs,category,difficulty,monthly_search_volume,related_top10_slugs,related_use_case_slug,related_blog_slugs,updated_at')
    .eq('slug', slug)
    .eq('status', 'published')
    .maybeSingle()
  return data as Task | null
}

async function getToolsForTask(task: Task): Promise<ToolStub[]> {
  const supabase = createStaticClient()
  let toolSlugs = [...(task.picked_slugs ?? [])]

  if (toolSlugs.length < (task.fallback_min ?? 3) && task.primary_tags.length > 0) {
    const { data: augment } = await supabase
      .from('tools')
      .select('slug')
      .overlaps('tags', task.primary_tags)
      .gte('rating', 4.0)
      .order('rating', { ascending: false })
      .limit(10)
    const augmentSlugs = (augment ?? []).map((t: { slug: string }) => t.slug)
    toolSlugs = Array.from(new Set([...toolSlugs, ...augmentSlugs])).slice(0, 10)
  }

  if (toolSlugs.length === 0) return []

  const { data: tools } = await supabase
    .from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,trending,updated_at')
    .in('slug', toolSlugs)

  const ordered: ToolStub[] = []
  for (const s of toolSlugs) {
    const found = tools?.find((t: ToolStub) => t.slug === s)
    if (found) ordered.push(found)
  }
  return ordered
}

async function getRelatedTasks(task: Task, limit = 6): Promise<{ slug: string; title: string; emoji: string }[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tasks')
    .select('slug,title,emoji')
    .neq('slug', task.slug)
    .eq('status', 'published')
    .overlaps('primary_tags', task.primary_tags)
    .limit(limit)
  return (data ?? []) as { slug: string; title: string; emoji: string }[]
}

export async function generateStaticParams() {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tasks')
    .select('slug')
    .eq('status', 'published')
  return (data ?? []).map((t: { slug: string }) => ({ slug: t.slug }))
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const task = await getTask(slug)
  if (!task) return { title: 'Task not found | MytheAi' }
  const year = new Date().getFullYear()
  const pickCount = task.picked_slugs?.length ?? 0
  const title = `${task.title} (${year}) - ${pickCount} Top Picks Reviewed | MytheAi`
  const description = metaDescription(
    task.intro.split('.').slice(0, 2).join('.'),
    `${pickCount} hand-picked tools compared on price and features for ${year}`
  )
  return {
    title,
    description,
    alternates: { canonical: `https://mytheai.com/tasks/${slug}` },
    openGraph: {
      title: `${task.title} ${year} | MytheAi`,
      description,
      url: `https://mytheai.com/tasks/${slug}`,
    },
  }
}

export default async function TaskPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const task = await getTask(slug)
  if (!task) notFound()

  const [tools, relatedTasks] = await Promise.all([
    getToolsForTask(task),
    getRelatedTasks(task),
  ])

  const year = new Date().getFullYear()
  const todayIso = new Date().toISOString().slice(0, 10)
  const author = getAuthorJsonLd()
  const h1 = task.h1_override || `${task.title} (${year})`

  const collectionPageJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    name: `${task.title} ${year}`,
    description: task.intro.split('.').slice(0, 2).join('.') + '.',
    url: `https://mytheai.com/tasks/${slug}`,
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
      { '@type': 'ListItem', position: 2, name: 'Tasks', item: 'https://mytheai.com/tasks' },
      { '@type': 'ListItem', position: 3, name: task.title, item: `https://mytheai.com/tasks/${slug}` },
    ],
  }

  const faqJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: (task.faqs ?? []).map(f => ({
      '@type': 'Question',
      name: f.q,
      acceptedAnswer: { '@type': 'Answer', text: f.a },
    })),
  }

  const howToJsonLd = tools.length >= 3 ? {
    '@context': 'https://schema.org',
    '@type': 'HowTo',
    name: task.title,
    description: task.intro.split('.').slice(0, 2).join('.').slice(0, 300).trim() + '.',
    totalTime: 'PT15M',
    step: tools.slice(0, 10).map((t, i) => ({
      '@type': 'HowToStep',
      position: i + 1,
      name: `Try ${t.name}`,
      text: t.tagline,
      url: `https://mytheai.com/tools/${t.slug}`,
    })),
  } : null

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(collectionPageJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(faqJsonLd) }} />
      {howToJsonLd && <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(howToJsonLd) }} />}

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/tasks" className="hover:text-blue-600 transition-colors">Tasks</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{task.title}</span>
        </nav>

        <div className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">
            <span className="mr-1">{task.emoji}</span> Task
          </p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            {h1}
          </h1>
          <p className="text-[16px] text-muted-foreground leading-relaxed">
            {task.intro}
          </p>
          <div className="mt-4 flex flex-wrap gap-2 text-[12px] text-muted-foreground">
            <span className="px-2 py-0.5 rounded-full bg-gray-100 dark:bg-gray-800">Updated {new Date(task.updated_at).toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}</span>
            <span className="px-2 py-0.5 rounded-full bg-gray-100 dark:bg-gray-800">{tools.length} tools</span>
            <span className="px-2 py-0.5 rounded-full bg-gray-100 dark:bg-gray-800 capitalize">{task.difficulty}</span>
          </div>
        </div>

        {task.methodology && (
          <section className="mb-10 p-5 rounded-xl border border-border bg-card">
            <h2 className="text-[14px] font-bold text-foreground uppercase tracking-wider mb-2">How we picked</h2>
            <p className="text-[14px] text-muted-foreground leading-relaxed">{task.methodology}</p>
          </section>
        )}

        {tools.length > 0 ? (
          <section className="mb-10">
            <h2 className="text-[20px] font-bold text-foreground mb-4">
              Top {tools.length} picks
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
                          className="inline-flex items-center justify-center px-3 py-1.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[12px] transition-colors whitespace-nowrap plausible-event-name=Outbound plausible-event-tool=task"
                          data-tool={t.slug}
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
            <p className="text-[14px] text-muted-foreground">No tools currently match this task. Browse <Link href="/tools" className="text-blue-600 hover:underline">all tools</Link> instead.</p>
          </div>
        )}

        {task.faqs && task.faqs.length > 0 && (
          <section className="mb-10">
            <h2 className="text-[20px] font-bold text-foreground mb-4">Frequently asked</h2>
            <div className="space-y-3">
              {task.faqs.map((f, i) => (
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
        )}

        {relatedTasks.length > 0 && (
          <section className="mb-10">
            <h2 className="text-[20px] font-bold text-foreground mb-4">Related tasks</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              {relatedTasks.map(r => (
                <Link
                  key={r.slug}
                  href={`/tasks/${r.slug}`}
                  className="flex items-center gap-3 p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors"
                >
                  <span className="text-[18px]">{r.emoji}</span>
                  <span className="text-[14px] font-semibold text-foreground">{r.title}</span>
                </Link>
              ))}
            </div>
          </section>
        )}

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
