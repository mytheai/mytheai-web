'use client'

import { useState } from 'react'
import Link from 'next/link'
import type { Top10List } from '@/data/top10'

interface Props {
  items: Top10List[]
}

export default function Top10Grid({ items }: Props) {
  const [category, setCategory] = useState('')

  const categories = [...new Set(items.map(i => i.category))].sort()
  const filtered = category ? items.filter(i => i.category === category) : items

  return (
    <>
      {/* Filter bar */}
      <div className="flex items-center gap-2 p-3 mb-8 rounded-xl border border-border bg-surface shadow-sm">
        <select
          value={category}
          onChange={e => setCategory(e.target.value)}
          className="flex-1 h-9 px-3 rounded-lg border border-border bg-surface text-[13px] text-foreground focus:outline-none focus:border-blue-400 cursor-pointer transition-colors"
        >
          <option value="">All Categories</option>
          {categories.map(c => (
            <option key={c} value={c}>{c}</option>
          ))}
        </select>

        {category && (
          <button
            onClick={() => setCategory('')}
            aria-label="Clear filter"
            className="flex items-center justify-center w-8 h-8 rounded-lg border border-border text-muted-foreground hover:border-red-300 hover:text-red-500 transition-colors"
          >
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
              <path d="M18 6 6 18M6 6l12 12" />
            </svg>
          </button>
        )}
      </div>

      {filtered.length > 0 ? (
        <div className="grid sm:grid-cols-2 gap-4">
          {filtered.map(list => (
            <Link
              key={list.slug}
              href={`/top-10/${list.slug}`}
              className="flex items-start gap-4 p-5 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors"
            >
              <span className="text-3xl flex-shrink-0">{list.emoji}</span>
              <div className="min-w-0">
                <p className="text-[15px] font-bold text-foreground mb-1">{list.title}</p>
                <p className="text-[13px] text-muted-foreground line-clamp-2 mb-2">{list.description}</p>
                <div className="flex items-center gap-3">
                  <span className="text-[11px] font-semibold px-2 py-0.5 rounded-full bg-[#EFF6FF] text-[#1E40AF]">
                    {list.category}
                  </span>
                  <span className="text-[12px] text-blue-600 font-medium">Top {list.slugs.length} →</span>
                </div>
              </div>
            </Link>
          ))}
        </div>
      ) : (
        <div className="py-16 text-center">
          <p className="text-muted-foreground text-[15px]">No lists found for &quot;{category}&quot;.</p>
          <button
            onClick={() => setCategory('')}
            className="mt-3 inline-block text-blue-600 text-[14px] hover:underline"
          >
            Clear filter
          </button>
        </div>
      )}
    </>
  )
}
