import { Suspense } from 'react'
import Link from 'next/link'
import { getTranslations } from 'next-intl/server'
import LogoImage from '@/components/ui/LogoImage'
import { createStaticClient } from '@/lib/supabase'
import CompareFilterBar from '@/components/tools/CompareFilterBar'
import type { Metadata } from 'next'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'AI Tool Comparisons 2026: Side-by-Side Reviews | MytheAi',
  description: 'Compare the top AI tools head-to-head. Honest side-by-side breakdowns of pricing, features, and use cases.',
  alternates: { canonical: 'https://mytheai.com/compare' },
}

interface CompareRow {
  slug: string
  tool_a_slug: string
  tool_b_slug: string
  summary: string | null
  winner: string | null
}

interface ToolMeta {
  slug: string
  name: string
  logo_url: string | null
  website_url: string | null
  rating: number
  tags: string[]
}

const TAG_LABELS: Record<string, string> = {
  'ai-assistants':  'AI Assistants',
  'writing-ai':     'Writing',
  'image-ai':       'Image',
  'video-ai':       'Video',
  'code-ai':        'Code',
  'voice-audio':    'Voice',
  'productivity':   'Productivity',
  'analytics':      'Analytics',
  'seo-marketing':  'SEO',
  'content':        'Content',
  'research':       'Research',
}

async function getComparisons(): Promise<CompareRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase.from('comparisons').select('slug,tool_a_slug,tool_b_slug,summary,winner').order('slug')
  return (data ?? []) as CompareRow[]
}

async function getToolsMeta(slugs: string[]): Promise<Record<string, ToolMeta>> {
  if (slugs.length === 0) return {}
  const supabase = createStaticClient()
  const { data } = await supabase.from('tools').select('slug,name,logo_url,website_url,rating,tags').in('slug', slugs)
  const map: Record<string, ToolMeta> = {}
  for (const t of data ?? []) map[t.slug] = t as ToolMeta
  return map
}

function getCategory(tool: ToolMeta): string {
  const primary = tool.tags?.[0] ?? ''
  return TAG_LABELS[primary] ?? 'Other'
}

export default async function ComparePage({
  searchParams,
}: {
  searchParams: Promise<{ category?: string; tool_a?: string }>
}) {
  const { category, tool_a } = await searchParams
  const [comparisons, t] = await Promise.all([
    getComparisons(),
    getTranslations('HubPages'),
  ])
  const allSlugs = [...new Set(comparisons.flatMap(c => [c.tool_a_slug, c.tool_b_slug]))]
  const tools = await getToolsMeta(allSlugs)

  // Unique tool options sorted alphabetically for dropdowns
  const toolOptions = allSlugs
    .filter(s => tools[s])
    .map(s => ({ slug: s, name: tools[s].name }))
    .sort((a, b) => a.name.localeCompare(b.name))

  // Derive unique categories
  const categorySet = new Set<string>()
  for (const c of comparisons) {
    const a = tools[c.tool_a_slug]
    if (a) categorySet.add(getCategory(a))
  }
  const categoryOptions = [...categorySet].sort()

  // Filter: tool_a = any comparison involving that tool
  //         tool_b = further narrow to comparisons involving both tools
  const filtered = comparisons.filter(c => {
    const a = tools[c.tool_a_slug]
    const b = tools[c.tool_b_slug]
    if (!a || !b) return false
    if (category && getCategory(a) !== category) return false
    if (tool_a) {
      const involvesA = c.tool_a_slug === tool_a || c.tool_b_slug === tool_a
      if (!involvesA) return false
    }
    return true
  })

  const collectionSchema = {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    name: 'AI Tool Comparisons 2026: Side-by-Side Reviews',
    description: 'Compare the top AI tools head-to-head. Honest side-by-side breakdowns of pricing, features, and use cases.',
    url: 'https://mytheai.com/compare',
    publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(collectionSchema) }} />
      <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">
        <div className="mb-8">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">{t('compareEyebrow')}</p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
            {t('compareTitle')}
          </h1>
          <p className="text-[15px] text-muted-foreground">
            {t('compareIntro')}
          </p>
        </div>

        <Suspense fallback={<div className="h-16" />}>
          <CompareFilterBar
            toolOptions={toolOptions}
            categoryOptions={categoryOptions}
          />
        </Suspense>

        <div className="grid sm:grid-cols-2 gap-4">
          {filtered.map(c => {
            const a = tools[c.tool_a_slug]
            const b = tools[c.tool_b_slug]
            if (!a || !b) return null
            return (
              <Link
                key={c.slug}
                href={`/compare/${c.slug}`}
                className="flex flex-col gap-4 p-5 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <div className="flex items-center gap-2 flex-1 min-w-0">
                    <div className="w-9 h-9 rounded-lg border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                      <LogoImage src={a.logo_url} websiteUrl={a.website_url} name={a.name} size={28} />
                    </div>
                    <span className="text-[14px] font-semibold text-foreground truncate">{a.name}</span>
                  </div>
                  <span className="text-[11px] font-bold px-2 py-0.5 rounded-full bg-[#EFF6FF] text-[#2563EB] flex-shrink-0">VS</span>
                  <div className="flex items-center gap-2 flex-1 min-w-0 justify-end">
                    <span className="text-[14px] font-semibold text-foreground truncate text-right">{b.name}</span>
                    <div className="w-9 h-9 rounded-lg border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                      <LogoImage src={b.logo_url} websiteUrl={b.website_url} name={b.name} size={28} />
                    </div>
                  </div>
                </div>
                {c.summary && (
                  <p className="text-[13px] text-muted-foreground line-clamp-2">{c.summary}</p>
                )}
                <span className="text-[13px] text-blue-600 font-medium">{t('compareCardCta')} →</span>
              </Link>
            )
          })}
        </div>

        {filtered.length === 0 && (
          <div className="py-16 text-center">
            <p className="text-muted-foreground text-[15px]">{t('compareNoResults')}</p>
            <Link href="/compare" className="mt-3 inline-block text-blue-600 text-[14px] hover:underline">{t('compareViewAll')}</Link>
          </div>
        )}
      </div>
    </>
  )
}
