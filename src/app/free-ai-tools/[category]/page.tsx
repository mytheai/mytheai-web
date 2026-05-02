import { notFound } from 'next/navigation'
import Link from 'next/link'
import LogoImage from '@/components/ui/LogoImage'
import AuthorBio from '@/components/layout/AuthorBio'
import { createStaticClient } from '@/lib/supabase'
import type { Metadata } from 'next'

export const revalidate = 604800

interface FreeCategory {
  slug: string
  tag: string
  title: string
  emoji: string
  intro: string
  whatYouGet: string
  whenToUpgrade: string
}

const FREE_CATEGORIES: FreeCategory[] = [
  {
    slug: 'ai-assistants',
    tag: 'ai-assistants',
    title: 'Best Free AI Assistants',
    emoji: '🧠',
    intro: 'Free AI assistants in 2026 are powerful enough that most people never need to upgrade. The list below covers the chatbots and assistants with the most generous free tiers and the strongest output quality at zero cost. No credit card required for any tool here.',
    whatYouGet: 'Most free AI assistant tiers include unlimited use of a smaller model (Claude Haiku, GPT-4o-mini, Gemini Flash) plus a daily quota of the flagship model. Real-world this is enough for 30-50 typical chat sessions per day, which covers most professional use.',
    whenToUpgrade: 'Upgrade when you hit the daily flagship-model quota multiple times per week, when you need extended thinking modes for hard reasoning tasks, or when you need data-not-trained-on guarantees for confidential work.',
  },
  {
    slug: 'writing-ai',
    tag: 'writing-ai',
    title: 'Best Free AI Writing Tools',
    emoji: '✍️',
    intro: 'Free AI writing tools cover most writing jobs without paying. The selection below includes both ambient editors (Grammarly, Hemingway) and full generators (free tiers of Jasper, Writesonic) that let you draft blog posts, emails, and ad copy at zero cost.',
    whatYouGet: 'Free tiers typically include grammar and spell checking, basic AI rewrite, limited monthly word generation, and a small template library. You can ship 5-10 short pieces per month from the free tier alone.',
    whenToUpgrade: 'Upgrade when monthly word output exceeds the free quota, when you need brand voice training, when team collaboration matters, or when you need plagiarism detection.',
  },
  {
    slug: 'image-ai',
    tag: 'image-ai',
    title: 'Best Free AI Image Generators',
    emoji: '🎨',
    intro: 'Free AI image generators have closed most of the gap with paid tools in 2026. The list below covers free-tier image generation, AI photo editing, and creative tools that produce print-ready output without a subscription.',
    whatYouGet: 'Most free image tools include 5-25 generations per day with the smaller version of their flagship model. Some include limited editing, upscaling, and style controls. Output is usable for social media and personal projects.',
    whenToUpgrade: 'Upgrade for commercial licensing, higher-resolution output, faster queue priority, advanced controls (ControlNet, custom training), or unlimited generations for production work.',
  },
  {
    slug: 'video-ai',
    tag: 'video-ai',
    title: 'Best Free AI Video Tools',
    emoji: '🎬',
    intro: 'Free AI video tools are still rare in 2026 because rendering cost per minute is high. The list below covers the few that offer genuine free tiers with usable output - mostly editor-style tools and short-form generators.',
    whatYouGet: 'Free tiers typically include 1-3 minutes of generated video per month, watermarked output, basic transcription, and limited editing. Talking-head and avatar tools tend to give 1-3 free videos as a trial.',
    whenToUpgrade: 'Upgrade to remove watermarks, unlock longer video generation, get higher resolution output, or use AI tools for client work where commercial rights matter.',
  },
  {
    slug: 'code-ai',
    tag: 'code-ai',
    title: 'Best Free AI Coding Tools',
    emoji: '💻',
    intro: 'Free AI coding tools are increasingly viable for daily work. The list below covers the assistants with real free tiers (not 14-day trials) plus open-source self-hosted options for engineers who want full control.',
    whatYouGet: 'Free tiers typically include unlimited autocomplete on a smaller model, a daily quota of agent or chat with the flagship model, and full IDE plugin support. Codeium and Continue offer especially generous free use.',
    whenToUpgrade: 'Upgrade when you need consistent flagship-model performance, longer context windows for monorepo work, agent mode reliability, or enterprise data privacy guarantees.',
  },
  {
    slug: 'seo-marketing',
    tag: 'seo-marketing',
    title: 'Best Free AI SEO Tools',
    emoji: '📈',
    intro: 'Free AI SEO tools cover keyword research, content optimization, and basic competitor analysis without paying for a full Semrush or Ahrefs subscription. The list below ranks the free tiers that genuinely move the needle for organic traffic.',
    whatYouGet: 'Free tiers usually include limited daily keyword lookups, basic SERP analysis, a few content optimization scores per month, and access to one or two key features. Enough for solo bloggers and side-project SEO.',
    whenToUpgrade: 'Upgrade when keyword research volume exceeds the free quota, when you need backlink data, when team rank tracking matters, or when content calendar scale demands unlimited optimization scores.',
  },
  {
    slug: 'productivity',
    tag: 'productivity',
    title: 'Best Free AI Productivity Tools',
    emoji: '⚡',
    intro: 'Free AI productivity tools cover meeting transcription, note-taking, scheduling, and task management. The list below ranks the free tiers that save real hours per week without forcing an upgrade.',
    whatYouGet: 'Free tiers typically include 300-800 minutes of meeting transcription per month, AI summary, basic note-taking, and integration with Google Calendar or Outlook. Enough for most solo professionals.',
    whenToUpgrade: 'Upgrade when transcription minutes are exhausted, when team-wide search and sharing matter, when CRM integrations are needed, or when video recording joins the workflow.',
  },
  {
    slug: 'voice-audio',
    tag: 'voice-audio',
    title: 'Best Free AI Voice & Audio Tools',
    emoji: '🎙️',
    intro: 'Free AI voice and audio tools handle transcription, voice generation, and basic audio cleanup. The list below ranks the free tiers with usable output quality and meaningful monthly quotas.',
    whatYouGet: 'Free tiers typically include 10-30 minutes of voice generation per month, a few speaker voice clones, basic transcription, and limited audio editing. Quality has improved significantly in 2026.',
    whenToUpgrade: 'Upgrade when monthly voice quota runs out, when commercial licensing matters, when faster generation queues matter, or when professional studio-quality output is required.',
  },
  {
    slug: 'analytics',
    tag: 'analytics',
    title: 'Best Free AI Analytics Tools',
    emoji: '📊',
    intro: 'Free AI analytics tools include text-to-SQL, data visualization, and natural-language business intelligence. The list below covers the free tiers that handle real datasets without forcing immediate upgrade.',
    whatYouGet: 'Free tiers typically include up to 100MB-1GB of data ingestion, basic charts and dashboards, AI-generated insights, and connections to common databases. Enough for personal projects and small startups.',
    whenToUpgrade: 'Upgrade for larger datasets, team collaboration on dashboards, scheduled reports, advanced ML features, or enterprise-grade data warehouse connections.',
  },
  {
    slug: 'automation',
    tag: 'automation',
    title: 'Best Free AI Automation Tools',
    emoji: '🔗',
    intro: 'Free AI automation tools let you connect apps and run workflows without paying. The list below covers the free tiers of Zapier, Make, n8n, and other workflow tools that handle real automation at zero cost.',
    whatYouGet: 'Free tiers typically include 100-1,000 task runs per month, multi-step workflows, AI step support, and connection to 1,000+ apps. n8n self-hosted is essentially unlimited for technical users.',
    whenToUpgrade: 'Upgrade when monthly task volume exceeds the free quota, when team-wide automations need shared access, when premium app connections are required, or when you need enterprise security features.',
  },
]

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

const PRICING_LABELS: Record<string, string> = {
  free: 'Free', freemium: 'Freemium', paid: 'Paid', ltd: 'Lifetime Deal',
}
const PRICING_COLORS: Record<string, string> = {
  free: 'bg-[#D1FAE5] text-[#065F46]',
  freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
  paid: 'bg-[#F3F4F6] text-[#374151]',
  ltd: 'bg-[#FEF3C7] text-[#92400E]',
}

async function getFreeToolsForCategory(tag: string): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,trending,tags')
    .contains('tags', [tag])
    .or('pricing_type.eq.free,pricing_type.eq.freemium,pricing_free_tier.eq.true')
    .order('rating', { ascending: false })
    .limit(15)
  return (data ?? []) as ToolRow[]
}

export function generateStaticParams() {
  return FREE_CATEGORIES.map(c => ({ category: c.slug }))
}

export async function generateMetadata({ params }: { params: Promise<{ category: string }> }): Promise<Metadata> {
  const { category } = await params
  const cat = FREE_CATEGORIES.find(c => c.slug === category)
  if (!cat) return { title: 'Not found | MytheAi' }
  const year = new Date().getFullYear()
  return {
    title: `${cat.title} ${year}: 15 Free Picks (No Credit Card) | MytheAi`,
    description: `${cat.title.toLowerCase()} in ${year}. ${cat.intro.split('.')[0]}. Independent rankings, no pay-to-rank.`,
    alternates: { canonical: `https://mytheai.com/free-ai-tools/${category}` },
    openGraph: {
      title: `${cat.title} ${year} | MytheAi`,
      description: cat.intro,
      url: `https://mytheai.com/free-ai-tools/${category}`,
    },
  }
}

export default async function FreeAIToolsPage({ params }: { params: Promise<{ category: string }> }) {
  const { category } = await params
  const cat = FREE_CATEGORIES.find(c => c.slug === category)
  if (!cat) notFound()

  const tools = await getFreeToolsForCategory(cat.tag)
  const year = new Date().getFullYear()

  const itemListJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'ItemList',
    name: `${cat.title} ${year}`,
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
      { '@type': 'ListItem', position: 2, name: 'Free AI Tools', item: 'https://mytheai.com/free-ai-tools' },
      { '@type': 'ListItem', position: 3, name: cat.title, item: `https://mytheai.com/free-ai-tools/${category}` },
    ],
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(itemListJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/tools" className="hover:text-blue-600 transition-colors">Tools</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{cat.title}</span>
        </nav>

        <div className="mb-8">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-emerald-600 mb-1">Free Tier · {cat.emoji}</p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            {cat.title} ({year})
          </h1>
          <p className="text-[16px] text-muted-foreground leading-relaxed">{cat.intro}</p>
        </div>

        {tools.length > 0 ? (
          <ol className="space-y-3 mb-10">
            {tools.map((tool, i) => (
              <li key={tool.slug}>
                <Link
                  href={`/tools/${tool.slug}`}
                  className="flex items-start gap-4 p-4 rounded-xl border border-border bg-card hover:border-emerald-300 transition-colors"
                >
                  <span className="text-[16px] font-bold text-muted-foreground w-6 flex-shrink-0 leading-none pt-1">
                    {i + 1}
                  </span>
                  <div className="w-10 h-10 rounded-lg border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                    <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={32} />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex flex-wrap items-center gap-2 mb-0.5">
                      <span className="text-[14px] font-bold text-foreground">{tool.name}</span>
                      <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[tool.pricing_type]}`}>
                        {PRICING_LABELS[tool.pricing_type]}
                      </span>
                      {tool.pricing_free_tier && tool.pricing_type === 'paid' && (
                        <span className="text-[11px] font-semibold text-[#10B981]">Free tier</span>
                      )}
                    </div>
                    <p className="text-[12.5px] text-muted-foreground line-clamp-2">{tool.tagline}</p>
                    <p className="text-[11px] text-muted-foreground mt-1">
                      <span className="text-[#F59E0B] font-semibold">★ {tool.rating.toFixed(1)}</span>
                      <span className="mx-1.5">·</span>
                      {tool.review_count.toLocaleString()} reviews
                    </p>
                  </div>
                </Link>
              </li>
            ))}
          </ol>
        ) : (
          <div className="mb-10 p-6 rounded-xl border border-border bg-card text-center">
            <p className="text-[14px] text-muted-foreground">No free tools found in this category yet.</p>
          </div>
        )}

        <section className="mb-8 p-5 rounded-xl border border-border bg-card">
          <h2 className="text-[16px] font-bold text-foreground mb-2">What you get on the free tier</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed">{cat.whatYouGet}</p>
        </section>

        <section className="mb-10 p-5 rounded-xl border border-border bg-card">
          <h2 className="text-[16px] font-bold text-foreground mb-2">When it is worth upgrading</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed">{cat.whenToUpgrade}</p>
        </section>

        <div className="mb-8">
          <AuthorBio context="curated" />
        </div>

        <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          <strong>Disclosure:</strong> Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Pricing tiers are verified at the time of writing - free tiers can change. <Link href="/methodology" className="text-blue-600 hover:underline">See methodology</Link>.
        </div>

      </div>
    </>
  )
}
