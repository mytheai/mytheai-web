import type { Metadata } from 'next'
import Link from 'next/link'
import { getTranslations } from 'next-intl/server'
import LogoImage from '@/components/ui/LogoImage'
import { createStaticClient } from '@/lib/supabase'
import { TOP10_LISTS } from '@/data/top10'
import { ROLES as RICH_ROLES } from '@/data/roles'

export const revalidate = 86400

export const metadata: Metadata = {
  title: 'AI Tools by Role 2026: Picks for Devs, Marketers, Designers & More | MytheAi',
  description: 'Curated AI tool stacks for 8 professional roles: developer, marketer, designer, founder, content creator, student, sales, support. Top 10 picks per role.',
  alternates: { canonical: 'https://mytheai.com/roles' },
  openGraph: {
    title: 'AI Tools by Role 2026 | MytheAi',
    url: 'https://mytheai.com/roles',
  },
}

interface RoleConfig {
  slug: string
  emoji: string
  title: string
  desc: string
  intro: string
  topListSlug: string
}

const ROLES: RoleConfig[] = [
  {
    slug: 'developer',
    emoji: '💻',
    title: 'Developer',
    desc: 'Coding copilots, AI agents, code review',
    intro: 'AI tools that help engineers ship faster: in-IDE pair programming, autonomous agents, and code review automation.',
    topListSlug: 'best-code-ai-tools',
  },
  {
    slug: 'marketer',
    emoji: '📣',
    title: 'Marketer',
    desc: 'Content, campaigns, SEO, ads',
    intro: 'Tools for content production, SEO research, social campaigns, and email automation. Built for performance teams.',
    topListSlug: 'best-ai-tools-for-marketers',
  },
  {
    slug: 'creator',
    emoji: '✍️',
    title: 'Content Creator',
    desc: 'Video, audio, writing, thumbnails',
    intro: 'Tools for creators who ship to YouTube, TikTok, podcasts, and newsletters. Video editing, voice cloning, thumbnail generators.',
    topListSlug: 'best-ai-tools-for-content-creators',
  },
  {
    slug: 'designer',
    emoji: '🎨',
    title: 'Designer',
    desc: 'UI, branding, image generation',
    intro: 'AI tools for product designers and visual creators: image generation, Figma plugins, brand systems, AI mockups.',
    topListSlug: 'best-ai-design-tools',
  },
  {
    slug: 'founder',
    emoji: '🚀',
    title: 'Founder',
    desc: 'Build, ship, grow faster',
    intro: 'The AI stack for early-stage founders: no-code builders, customer research, growth automation, lean ops.',
    topListSlug: 'best-ai-tools-for-startups',
  },
  {
    slug: 'student',
    emoji: '🎓',
    title: 'Student',
    desc: 'Research, study, writing',
    intro: 'Free and freemium AI tools for students: study assistants, research summarizers, math solvers, citation helpers.',
    topListSlug: 'best-ai-tools-for-students',
  },
  {
    slug: 'sales',
    emoji: '💼',
    title: 'Sales',
    desc: 'Outreach, CRM, deal intelligence',
    intro: 'AI for revenue teams: prospecting automation, conversation intelligence, deal scoring, CRM enrichment.',
    topListSlug: 'best-ai-sales-tools',
  },
  {
    slug: 'support',
    emoji: '🎧',
    title: 'Customer Support',
    desc: 'Tickets, chat, knowledge bases',
    intro: 'AI agents and copilots that deflect tickets, summarize conversations, and surface knowledge for support teams.',
    topListSlug: 'best-ai-customer-support-tools',
  },
]

interface ToolMeta {
  slug: string
  name: string
  logo_url: string | null
  website_url: string | null
}

export default async function RolesHubPage() {
  const supabase = createStaticClient()
  const allTopListSlugs = ROLES.map(r => r.topListSlug)
  const matchedLists = TOP10_LISTS.filter(l => allTopListSlugs.includes(l.slug))
  const allToolSlugs = [...new Set(matchedLists.flatMap(l => l.slugs.slice(0, 5)))]

  const { data: toolRows } = await supabase
    .from('tools')
    .select('slug,name,logo_url,website_url')
    .in('slug', allToolSlugs)

  const toolMap: Record<string, ToolMeta> = {}
  for (const tool of (toolRows ?? []) as ToolMeta[]) toolMap[tool.slug] = tool
  const tPage = await getTranslations('MiscPages')
  const tRoles = await getTranslations('Roles')

  return (
    <div className="max-w-6xl mx-auto px-4 md:px-5 py-10 md:py-14">
      <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">{tPage('rolesEyebrow')}</p>
      <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
        {tPage('rolesTitle')}
      </h1>
      <p className="text-[15px] text-muted-foreground mb-6 max-w-3xl">
        Curated stacks for 8 professional roles. Each role gets a top list scored on the same seven editorial criteria. Pick the role that matches your work, then drill into the ranked picks.
      </p>

      <div className="mb-10 flex items-center gap-2 p-4 rounded-xl border border-blue-200 bg-blue-50/50 dark:bg-blue-900/10 dark:border-blue-800/40 max-w-3xl">
        <span className="text-xl flex-shrink-0" aria-hidden="true">🔍</span>
        <p className="text-[13.5px] text-foreground">
          Searching by use case (coding, image gen, video, SEO)?{' '}
          <Link href="/top-10" className="text-blue-600 font-semibold hover:underline">Browse Top 10 by use case →</Link>
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
        {ROLES.map(role => {
          const list = matchedLists.find(l => l.slug === role.topListSlug)
          const previewSlugs = list ? list.slugs.slice(0, 5) : []
          const previewTools = previewSlugs.map(s => toolMap[s]).filter(Boolean) as ToolMeta[]

          const hasRichPage = RICH_ROLES.some(r => r.slug === role.slug)
          return (
            <Link
              key={role.slug}
              href={hasRichPage ? `/roles/${role.slug}` : `/top-10/${role.topListSlug}`}
              className="group block border border-border rounded-xl p-5 bg-card transition-all duration-150 hover:border-blue-300 hover:shadow-lg hover:-translate-y-0.5"
            >
              <div className="flex items-start gap-4 mb-3">
                <span className="text-3xl flex-shrink-0" aria-hidden="true">{role.emoji}</span>
                <div className="min-w-0 flex-1">
                  <h2 className="text-[17px] font-bold text-foreground group-hover:text-blue-600 transition-colors">{tRoles(role.slug)}</h2>
                  <p className="text-[13px] text-muted-foreground">{tRoles(`${role.slug}Desc`)}</p>
                </div>
              </div>

              <p className="text-[13.5px] text-muted-foreground leading-relaxed mb-4">
                {role.intro}
              </p>

              {previewTools.length > 0 && (
                <div className="border-t border-border pt-3">
                  <p className="text-[11px] font-bold uppercase tracking-[0.06em] text-muted-foreground mb-2">Top 5 picks</p>
                  <div className="flex items-center gap-2 flex-wrap">
                    {previewTools.map(tool => (
                      <div key={tool.slug} className="flex items-center gap-1.5 text-[12px] text-foreground bg-background border border-border rounded-full pl-1 pr-2.5 py-0.5">
                        <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={18} />
                        <span className="font-medium">{tool.name}</span>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              <p className="mt-4 text-[12px] font-semibold text-blue-600 group-hover:underline">
                {hasRichPage ? 'See full role guide →' : 'See full Top 10 →'}
              </p>
            </Link>
          )
        })}
      </div>

      <div className="mt-12 border-t border-border pt-6">
        <p className="text-[13px] text-muted-foreground">
          Don&apos;t see your role?{' '}
          <Link href="/quiz" className="text-blue-600 hover:underline">Take the Find Your Stack quiz</Link>{' '}for a personalized recommendation, or browse{' '}
          <Link href="/categories" className="text-blue-600 hover:underline">all categories</Link>.
        </p>
      </div>
    </div>
  )
}
