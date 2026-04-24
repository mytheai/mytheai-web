import Link from 'next/link'
import Image from 'next/image'
import { createStaticClient } from '@/lib/supabase'
import type { Metadata } from 'next'

export const dynamic = 'force-dynamic'

export const metadata: Metadata = {
  title: 'AI Tool Comparisons 2026 — Side-by-Side Reviews | MytheAi',
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
  rating: number
}

async function getComparisons(): Promise<CompareRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase.from('comparisons').select('slug,tool_a_slug,tool_b_slug,summary,winner').order('slug')
  return (data ?? []) as CompareRow[]
}

async function getToolsMeta(slugs: string[]): Promise<Record<string, ToolMeta>> {
  if (slugs.length === 0) return {}
  const supabase = createStaticClient()
  const { data } = await supabase.from('tools').select('slug,name,logo_url,rating').in('slug', slugs)
  const map: Record<string, ToolMeta> = {}
  for (const t of data ?? []) map[t.slug] = t as ToolMeta
  return map
}

export default async function ComparePage() {
  const comparisons = await getComparisons()
  const allSlugs = [...new Set(comparisons.flatMap(c => [c.tool_a_slug, c.tool_b_slug]))]
  const tools = await getToolsMeta(allSlugs)

  return (
    <div className="max-w-5xl mx-auto px-4 md:px-5 py-10 md:py-14">
      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Head-to-Head</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          AI Tool Comparisons
        </h1>
        <p className="text-[15px] text-muted-foreground">
          Honest side-by-side breakdowns — no affiliate bias.
        </p>
      </div>

      <div className="grid sm:grid-cols-2 gap-4">
        {comparisons.map(c => {
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
                {/* Tool A */}
                <div className="flex items-center gap-2 flex-1 min-w-0">
                  {a.logo_url && (
                    <div className="w-9 h-9 rounded-lg border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                      <Image src={a.logo_url} alt={a.name} width={28} height={28} unoptimized />
                    </div>
                  )}
                  <span className="text-[14px] font-semibold text-foreground truncate">{a.name}</span>
                </div>

                {/* VS badge */}
                <span className="text-[11px] font-bold px-2 py-0.5 rounded-full bg-[#EFF6FF] text-[#2563EB] flex-shrink-0">
                  VS
                </span>

                {/* Tool B */}
                <div className="flex items-center gap-2 flex-1 min-w-0 justify-end">
                  <span className="text-[14px] font-semibold text-foreground truncate text-right">{b.name}</span>
                  {b.logo_url && (
                    <div className="w-9 h-9 rounded-lg border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                      <Image src={b.logo_url} alt={b.name} width={28} height={28} unoptimized />
                    </div>
                  )}
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
    </div>
  )
}
