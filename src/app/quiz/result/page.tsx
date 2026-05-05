import { redirect } from 'next/navigation'
import Link from 'next/link'
import LogoImage from '@/components/ui/LogoImage'
import NewsletterForm from '@/components/newsletter/NewsletterForm'
import { createStaticClient } from '@/lib/supabase'
import { getSiteStats } from '@/lib/stats'
import {
  decodeAnswers,
  getQuizTags,
  getBudgetCeiling,
  ROLE_LABELS,
  type QuizAnswers,
} from '@/lib/quiz-logic'
import type { Metadata } from 'next'

export const dynamic = 'force-dynamic'

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
  tags: string[]
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

async function pickTools(answers: QuizAnswers): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const tags = getQuizTags(answers)
  const ceiling = getBudgetCeiling(answers.budget)

  let q = supabase
    .from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating,review_count,trending,tags')
    .overlaps('tags', tags)
    .order('rating', { ascending: false })
    .order('review_count', { ascending: false })
    .limit(40)

  const { data } = await q
  let pool = (data ?? []) as ToolRow[]

  if (answers.budget === 'free') {
    pool = pool.filter(t => t.pricing_type === 'free' || t.pricing_free_tier)
  } else if (ceiling !== null) {
    pool = pool.filter(t => {
      if (t.pricing_free_tier) return true
      if (t.pricing_type === 'free') return true
      if (t.pricing_starting_price == null) return true
      return t.pricing_starting_price <= ceiling
    })
  }

  return pool.slice(0, 5)
}

export async function generateMetadata({ searchParams }: { searchParams: Promise<{ stack?: string }> }): Promise<Metadata> {
  const { stack } = await searchParams
  const answers = stack ? decodeAnswers(stack) : null
  const role = answers ? ROLE_LABELS[answers.role] : 'Your AI Stack'
  return {
    title: `Your AI Stack: 5 Picks for ${role} | MytheAi`,
    description: `Personalized 5-tool AI stack based on your role, budget, and use case. No signup needed - take the 60-second quiz on MytheAi.`,
    alternates: { canonical: stack ? `https://mytheai.com/quiz/result?stack=${stack}` : 'https://mytheai.com/quiz' },
    openGraph: {
      title: `Your AI Stack: 5 Picks for ${role}`,
      description: 'Personalized 5-tool AI stack from MytheAi.',
      url: stack ? `https://mytheai.com/quiz/result?stack=${stack}` : 'https://mytheai.com/quiz',
    },
  }
}

export default async function QuizResultPage({ searchParams }: { searchParams: Promise<{ stack?: string }> }) {
  const { stack } = await searchParams
  const answers = stack ? decodeAnswers(stack) : null
  if (!answers) redirect('/quiz')

  const [tools, stats] = await Promise.all([pickTools(answers), getSiteStats()])
  const role = ROLE_LABELS[answers.role]
  const shareUrl = `https://mytheai.com/quiz/result?stack=${stack}`
  const tweetText = encodeURIComponent(`I just got my personalized AI stack on MytheAi - 5 tools picked for my workflow. Take the 60s quiz: `)
  const twitterShare = `https://twitter.com/intent/tweet?text=${tweetText}&url=${encodeURIComponent(shareUrl)}`

  return (
    <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
        <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
        <span>/</span>
        <Link href="/quiz" className="hover:text-blue-600 transition-colors">Find Your Stack</Link>
        <span>/</span>
        <span className="text-foreground font-medium">Your stack</span>
      </nav>

      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Your AI Stack</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
          Five picks for {role}
        </h1>
        <p className="text-[15px] text-muted-foreground leading-relaxed">
          Based on your role, budget, and use case. Each pick links to the full review with pros, cons, pricing, and alternatives.
        </p>
      </div>

      {tools.length > 0 ? (
        <ol className="space-y-4 mb-10">
          {tools.map((tool, i) => (
            <li key={tool.slug}>
              <Link
                href={`/tools/${tool.slug}`}
                className="flex items-start gap-4 p-5 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors"
              >
                <div className="text-[20px] font-extrabold text-muted-foreground w-7 flex-shrink-0 leading-none pt-0.5">
                  {i + 1}
                </div>
                <div className="w-11 h-11 rounded-xl border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                  <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={36} />
                </div>
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
                  </div>
                </div>
                <span className="text-[13px] text-blue-600 font-medium flex-shrink-0 pt-0.5">Review →</span>
              </Link>
            </li>
          ))}
        </ol>
      ) : (
        <div className="mb-10 p-6 rounded-xl border border-border bg-card text-center">
          <p className="text-[14px] text-muted-foreground mb-3">No matches found for this exact filter combination.</p>
          <Link href="/quiz" className="text-blue-600 hover:underline font-medium">Retake the quiz</Link>
          <span className="mx-2 text-muted-foreground">·</span>
          <Link href="/tools" className="text-blue-600 hover:underline font-medium">Browse all tools</Link>
        </div>
      )}

      <div className="mb-10 p-6 rounded-xl border-2 border-blue-100 dark:border-blue-900/40 bg-blue-50/50 dark:bg-blue-950/20">
        <h2 className="text-[18px] font-bold text-foreground mb-2">Save this stack to your inbox</h2>
        <p className="text-[14px] text-muted-foreground mb-4">
          Want this list in your inbox plus weekly picks for {role.toLowerCase()}? No spam, unsubscribe anytime.
        </p>
        <NewsletterForm />
      </div>

      <div className="mb-10 flex flex-wrap items-center gap-3">
        <a
          href={twitterShare}
          target="_blank"
          rel="noopener noreferrer"
          className="inline-flex items-center gap-2 px-4 py-2.5 rounded-lg bg-foreground text-background text-[13px] font-semibold hover:opacity-90 transition-opacity"
        >
          <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
            <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
          </svg>
          Share on X
        </a>
        <Link
          href="/quiz"
          className="inline-flex items-center px-4 py-2.5 rounded-lg border border-border bg-card text-[13px] font-medium text-foreground hover:border-blue-300 transition-colors"
        >
          Retake quiz
        </Link>
        <Link
          href="/tools"
          className="text-[13px] text-blue-600 hover:underline font-medium"
        >
          Browse all {stats.tools} tools →
        </Link>
      </div>

      <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
        <strong>How we picked:</strong> We filtered our {stats.tools}-tool directory by tags matching {role.toLowerCase()} workflows, applied your budget ceiling, then sorted by editorial rating and review volume. <Link href="/methodology" className="text-blue-600 hover:underline">Full methodology</Link>.
      </div>

    </div>
  )
}
