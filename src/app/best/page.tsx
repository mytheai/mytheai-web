import Link from 'next/link'
import type { Metadata } from 'next'
import { createStaticClient } from '@/lib/supabase'

export const revalidate = 86400

const CATEGORIES = [
  { slug: 'writing', label: 'Writing', emoji: '✍️', tagline: 'Best AI tools for blog posts, marketing copy, and long-form content' },
  { slug: 'coding', label: 'Coding', emoji: '💻', tagline: 'Best AI coding assistants and IDEs for developers' },
  { slug: 'seo', label: 'SEO', emoji: '🔍', tagline: 'Best AI tools for keyword research, content optimization, and SERP rankings' },
  { slug: 'video', label: 'Video', emoji: '🎬', tagline: 'Best AI video generators for short-form, marketing, and narrative content' },
  { slug: 'image', label: 'Image', emoji: '🎨', tagline: 'Best AI image generators for art, marketing assets, and design concepts' },
  { slug: 'agents', label: 'AI Agents', emoji: '🤖', tagline: 'Best autonomous AI agents and assistants for workflow automation' },
  { slug: 'automation', label: 'Automation', emoji: '⚡', tagline: 'Best workflow automation platforms for SaaS connectivity and ops' },
  { slug: 'sales', label: 'Sales', emoji: '💼', tagline: 'Best AI tools for sales outreach, CRM intelligence, and pipeline ops' },
  { slug: 'customer-support', label: 'Customer Support', emoji: '🎧', tagline: 'Best AI tools for support inboxes, ticket deflection, and helpdesk ops' },
  { slug: 'legal', label: 'Legal', emoji: '⚖️', tagline: 'Best AI tools for contract review, legal research, and compliance workflows' },
  { slug: 'finance', label: 'Finance', emoji: '💰', tagline: 'Best AI tools for accounting, bookkeeping, expense tracking, and financial ops' },
  { slug: 'healthcare', label: 'Healthcare', emoji: '🏥', tagline: 'Best AI tools for clinical documentation, medical scribes, and healthcare ops' },
  { slug: 'marketing', label: 'Marketing', emoji: '📣', tagline: 'Best AI tools for marketing automation, campaigns, and content production' },
  { slug: 'design', label: 'Design', emoji: '🎨', tagline: 'Best AI tools for UI design, prototyping, and brand asset generation' },
  { slug: 'research', label: 'Research', emoji: '🔬', tagline: 'Best AI tools for academic research, literature review, and data synthesis' },
  { slug: 'productivity', label: 'Productivity', emoji: '⚙️', tagline: 'Best AI tools for note-taking, task management, and personal productivity' },
]

export const metadata: Metadata = {
  title: 'Best AI Tools 2026: Hand-Tested Picks Across 16 Categories | MytheAi',
  description: 'Editorial money pages with hand-tested picks across writing, coding, SEO, video, image, agents, automation, sales, customer support, legal, finance, healthcare, marketing, design, research, and productivity. Tested by John Pham, no pay-to-rank.',
  alternates: { canonical: 'https://mytheai.com/best' },
  openGraph: {
    title: 'Best AI Tools 2026: Hand-Tested Picks | MytheAi',
    description: 'Editorial money pages with hand-tested picks across 16 AI tool categories.',
    url: 'https://mytheai.com/best',
  },
}

async function getHandsOnCount(): Promise<number> {
  const supabase = createStaticClient()
  const { count } = await supabase.from('tools').select('*', { count: 'exact', head: true }).not('tested_by', 'is', null)
  return count ?? 0
}

export default async function BestHubPage() {
  const handsOnCount = await getHandsOnCount()
  const year = new Date().getFullYear()

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Best AI Tools', item: 'https://mytheai.com/best' },
    ],
  }

  return (
    <>
    <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />
    <div className="max-w-5xl mx-auto px-4 md:px-5 py-10 md:py-14">
      <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
        <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
        <span>/</span>
        <span className="text-foreground font-medium">Best AI Tools</span>
      </nav>

      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-emerald-700 mb-1">
          Hand-Tested Picks · {year}
        </p>
        <h1 className="text-[28px] md:text-[40px] font-extrabold tracking-tight text-foreground mb-3">
          Best AI Tools, Tested by John Pham
        </h1>
        <p className="text-[15px] md:text-[16px] text-muted-foreground leading-relaxed max-w-2xl mb-3">
          Editorial money pages with hand-tested picks across 16 AI tool categories. Each pick passes a real testing benchmark before it shows up in this directory. No pay-to-rank, no affiliate-influenced ordering.
        </p>
        {handsOnCount > 0 && (
          <p className="inline-flex items-center gap-1.5 text-[13px] font-medium text-emerald-700 dark:text-emerald-400">
            <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth="3" viewBox="0 0 24 24" aria-hidden="true">
              <polyline points="20 6 9 17 4 12" />
            </svg>
            {handsOnCount} tools with full hands-on reviews
          </p>
        )}
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {CATEGORIES.map(cat => (
          <Link
            key={cat.slug}
            href={`/best/${cat.slug}`}
            className="block p-5 rounded-xl border border-border bg-card hover:border-blue-300 hover:bg-blue-50/30 dark:hover:bg-blue-950/10 transition-all"
          >
            <div className="flex items-center gap-2.5 mb-2">
              <span className="text-[24px] leading-none flex-shrink-0">{cat.emoji}</span>
              <h2 className="text-[16px] font-bold text-foreground">Best AI {cat.label}</h2>
            </div>
            <p className="text-[13px] text-muted-foreground leading-relaxed line-clamp-3">{cat.tagline}</p>
            <p className="mt-3 text-[12px] font-medium text-blue-600">View picks →</p>
          </Link>
        ))}
      </div>

      <div className="mt-10 p-5 rounded-xl border border-border bg-card">
        <h2 className="text-[14px] font-bold text-foreground uppercase tracking-wider mb-2">Editorial standard</h2>
        <p className="text-[14px] text-muted-foreground leading-relaxed mb-2">
          Every tool in these lists is verified live, has a working free trial or transparent pricing, and either passed a hands-on test or earned its rank by a documented signal mix (G2 score, brand recognition, funding signal, search demand, category leadership).
        </p>
        <p className="text-[14px] text-muted-foreground leading-relaxed">
          Read more about the <Link href="/methodology" className="text-blue-600 hover:underline">scoring methodology</Link> and our <Link href="/about" className="text-blue-600 hover:underline">editorial standards</Link>.
        </p>
      </div>
    </div>
    </>
  )
}
