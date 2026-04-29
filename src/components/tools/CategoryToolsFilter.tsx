'use client'

import { useState } from 'react'
import ToolCard from './ToolCard'
import Link from 'next/link'
import type { Tool } from '@/types'

type PricingFilter = 'free' | 'freemium' | 'paid' | null

const FILTERS: { label: string; value: PricingFilter }[] = [
  { label: 'All', value: null },
  { label: 'Free', value: 'free' },
  { label: 'Freemium', value: 'freemium' },
  { label: 'Paid', value: 'paid' },
]

export default function CategoryToolsFilter({ tools }: { tools: Tool[] }) {
  const [active, setActive] = useState<PricingFilter>(null)

  const filtered = active === null ? tools : tools.filter(t => t.pricing_type === active)

  if (tools.length === 0) {
    return (
      <div className="text-center py-16 border border-border rounded-xl bg-card">
        <p className="text-[15px] text-muted-foreground mb-4">No tools yet in this category.</p>
        <Link href="/tools" className="text-blue-600 text-[14px] hover:underline">
          Browse all tools →
        </Link>
      </div>
    )
  }

  return (
    <div>
      <div className="flex flex-wrap items-center gap-2 mb-6">
        {FILTERS.map(f => {
          const count = f.value === null ? tools.length : tools.filter(t => t.pricing_type === f.value).length
          if (f.value !== null && count === 0) return null
          return (
            <button
              key={f.label}
              onClick={() => setActive(f.value)}
              className={`px-3 py-1.5 rounded-full text-[12px] font-medium transition-colors border ${
                active === f.value
                  ? 'bg-blue-600 text-white border-blue-600'
                  : 'bg-card text-muted-foreground border-border hover:border-blue-300 hover:text-blue-600'
              }`}
            >
              {f.label}
              {f.value !== null && (
                <span className="ml-1 opacity-60">({count})</span>
              )}
            </button>
          )
        })}
        <span className="ml-auto text-[12px] text-muted-foreground">{filtered.length} tools</span>
      </div>

      {filtered.length > 0 ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {filtered.map(tool => (
            <ToolCard key={tool.slug} tool={tool} />
          ))}
        </div>
      ) : (
        <div className="text-center py-12 border border-border rounded-xl bg-card">
          <p className="text-[14px] text-muted-foreground mb-3">
            No {active} tools in this category.
          </p>
          <button
            onClick={() => setActive(null)}
            className="text-[13px] text-blue-600 hover:underline"
          >
            Show all tools
          </button>
        </div>
      )}
    </div>
  )
}
