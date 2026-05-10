'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import LogoImage from '@/components/ui/LogoImage'
import WishlistButton from '@/components/tools/WishlistButton'
import { useWishlist } from '@/hooks/useWishlist'

interface CompactTool {
  s: string
  n: string
  t: string
  l: string | null
  w: string | null
  p: 'free' | 'freemium' | 'paid' | 'ltd'
  g: string[]
  r: number
}

const PRICING_BADGE_COLORS = {
  free: 'bg-[#D1FAE5] text-[#065F46]',
  freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
  paid: 'bg-[#F3F4F6] text-[#374151]',
  ltd: 'bg-[#FEF3C7] text-[#92400E]',
}

const PRICING_LABEL = {
  free: 'Free',
  freemium: 'Freemium',
  paid: 'Paid',
  ltd: 'LTD',
}

export default function WishlistClient() {
  const { slugs, hydrated, clear } = useWishlist()
  const [allTools, setAllTools] = useState<CompactTool[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetch('/api/search-index')
      .then(r => r.json())
      .then((data: CompactTool[]) => {
        setAllTools(Array.isArray(data) ? data : [])
        setLoading(false)
      })
      .catch(() => setLoading(false))
  }, [])

  const tools = allTools.filter(t => slugs.includes(t.s))

  if (!hydrated || loading) {
    return (
      <div className="max-w-7xl mx-auto px-4 md:px-5 py-12">
        <h1 className="text-3xl font-extrabold tracking-tight">Saved Tools</h1>
        <p className="text-muted-foreground mt-2">Loading...</p>
      </div>
    )
  }

  if (tools.length === 0) {
    return (
      <div className="max-w-7xl mx-auto px-4 md:px-5 py-12">
        <h1 className="text-3xl md:text-4xl font-extrabold tracking-tight mb-3">Saved Tools</h1>
        <p className="text-muted-foreground text-[15px] mb-8 max-w-2xl">
          Tools you save show up here for quick access. Saved tools are stored in your browser, no account needed.
        </p>
        <div className="border border-dashed border-border rounded-xl p-10 text-center bg-card">
          <div className="text-5xl mb-3" aria-hidden="true">♡</div>
          <p className="text-foreground font-semibold mb-1">No saved tools yet</p>
          <p className="text-muted-foreground text-sm mb-5">
            Tap the Save button on any tool page to add it here.
          </p>
          <Link
            href="/tools"
            className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[14px] transition-colors"
          >
            Browse all tools →
          </Link>
        </div>
      </div>
    )
  }

  return (
    <div className="max-w-7xl mx-auto px-4 md:px-5 py-12">
      <div className="flex items-end justify-between mb-3 gap-4 flex-wrap">
        <h1 className="text-3xl md:text-4xl font-extrabold tracking-tight">Saved Tools</h1>
        <button
          type="button"
          onClick={() => {
            if (window.confirm('Remove all saved tools?')) clear()
          }}
          className="text-[13px] font-medium text-muted-foreground hover:text-rose-600 transition-colors"
        >
          Clear all
        </button>
      </div>
      <p className="text-muted-foreground text-[14px] mb-8">
        {tools.length} tool{tools.length === 1 ? '' : 's'} saved. Saved locally in your browser - no login needed.
      </p>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {tools.map(tool => (
          <div
            key={tool.s}
            className="relative bg-card border border-border rounded-xl p-5 transition-all duration-150 hover:-translate-y-0.5 hover:shadow-xl hover:border-blue-300"
          >
            {/* Header */}
            <div className="flex items-start justify-between mb-4">
              <div className="flex items-center gap-3 min-w-0">
                <div className="w-10 h-10 rounded-[10px] bg-gray-50 flex items-center justify-center flex-shrink-0 overflow-hidden">
                  <LogoImage src={tool.l} websiteUrl={tool.w} name={tool.n} size={40} className="object-contain p-1" />
                </div>
                <div className="min-w-0">
                  <span className="text-[14px] font-semibold text-foreground truncate block">{tool.n}</span>
                  {tool.g[0] && (
                    <div className="text-[12px] text-muted-foreground capitalize">{tool.g[0].replace(/-/g, ' ')}</div>
                  )}
                </div>
              </div>
              <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_BADGE_COLORS[tool.p]}`}>
                {PRICING_LABEL[tool.p]}
              </span>
            </div>

            {tool.t && (
              <p className="text-[13px] text-muted-foreground leading-relaxed mb-4 line-clamp-2">{tool.t}</p>
            )}

            <Link href={`/tools/${tool.s}`} className="absolute inset-0 rounded-xl" aria-label={`View ${tool.n} details`} />

            <div className="flex items-center justify-between">
              <div className="flex items-center gap-1.5">
                <span className="text-[#F59E0B] text-sm">
                  {'★'.repeat(Math.floor(tool.r))}
                  {'☆'.repeat(5 - Math.floor(tool.r))}
                </span>
                <span className="text-[13px] font-semibold text-foreground">{tool.r}</span>
              </div>
              <div className="relative z-10 flex items-center gap-1">
                <WishlistButton slug={tool.s} name={tool.n} variant="icon" />
                <a
                  href={`/go/${tool.s}`}
                  target="_blank"
                  rel="noopener noreferrer sponsored"
                  className="text-[12px] font-semibold text-blue-600 hover:text-blue-700 plausible-event-name=Outbound plausible-event-tool=wishlist"
                  data-tool={tool.s}
                >
                  Visit →
                </a>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
