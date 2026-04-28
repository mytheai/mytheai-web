import { Suspense } from 'react'
import Link from 'next/link'
import Image from 'next/image'
import { createStaticClient } from '@/lib/supabase'
import SearchFilterBar from '@/components/tools/SearchFilterBar'
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

function getLogoSrc(tool: ToolMeta): string | null {
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

function getCategory(tool: ToolMeta): string {
  const primary = tool.tags?.[0] ?? ''
  return TAG_LABELS[primary] ?? 'Other'
}

export default async function ComparePage({
  searchParams,
}: {
  searchParams: Promise<{ category?: string; q?: string }>
}) {
  const { category, q } = await searchParams
  const comparisons = await getComparisons()
  const allSlugs = [...new Set(comparisons.flatMap(c => [c.tool_a_slug, c.tool_b_slug]))]
  const tools = await getToolsMeta(allSlugs)

  // Derive categories from tool_a's primary tag
  const categoryCounts: Record<string, number> = {}
  for (const c of comparisons) {
    const a = tools[c.tool_a_slug]
    if (!a) continue
    const cat = getCategory(a)
    categoryCounts[cat] = (categoryCounts[cat] ?? 0) + 1
  }

  // Apply search filter (match tool names via compare slug)
  const qLower = (q ?? '').toLowerCase().trim()
  const filtered = comparisons.filter(c => {
    const a = tools[c.tool_a_slug]
    const b = tools[c.tool_b_slug]
    if (!a || !b) return false
    if (category && getCategory(a) !== category) return false
    if (qLower && !c.slug.includes(qLower) && !a.name.toLowerCase().includes(qLower) && !b.name.toLowerCase().includes(qLower)) return false
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
      <div className="max-w-5xl mx-auto px-4 md:px-5 py-10 md:py-14">
        <div className="mb-8">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Head-to-Head</p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
            AI Tool Comparisons
          </h1>
          <p className="text-[15px] text-muted-foreground">
            Honest side-by-side breakdowns. No affiliate bias.
          </p>
        </div>

        <Suspense fallback={<div className="h-16" />}>
          <SearchFilterBar
            basePath="/compare"
            showCategory
            searchPlaceholder="Search comparisons... (e.g. claude, notion)"
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
                      {getLogoSrc(a) ? (
                        <Image src={getLogoSrc(a)!} alt={a.name} width={28} height={28} unoptimized />
                      ) : (
                        <span className="text-[13px] font-bold text-gray-400">{a.name[0]}</span>
                      )}
                    </div>
                    <span className="text-[14px] font-semibold text-foreground truncate">{a.name}</span>
                  </div>
                  <span className="text-[11px] font-bold px-2 py-0.5 rounded-full bg-[#EFF6FF] text-[#2563EB] flex-shrink-0">VS</span>
                  <div className="flex items-center gap-2 flex-1 min-w-0 justify-end">
                    <span className="text-[14px] font-semibold text-foreground truncate text-right">{b.name}</span>
                    <div className="w-9 h-9 rounded-lg border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                      {getLogoSrc(b) ? (
                        <Image src={getLogoSrc(b)!} alt={b.name} width={28} height={28} unoptimized />
                      ) : (
                        <span className="text-[13px] font-bold text-gray-400">{b.name[0]}</span>
                      )}
                    </div>
                  </div>
                </div>
                {c.summary && (
                  <p className="text-[13px] text-muted-foreground line-clamp-2">{c.summary}</p>
                )}
                <span className="text-[13px] text-blue-600 font-medium">Compare features & pricing →</span>
              </Link>
            )
          })}
        </div>

        {filtered.length === 0 && (
          <div className="py-16 text-center">
            <p className="text-muted-foreground text-[15px]">No comparisons found for this filter.</p>
            <Link href="/compare" className="mt-3 inline-block text-blue-600 text-[14px] hover:underline">View all comparisons</Link>
          </div>
        )}
      </div>
    </>
  )
}
