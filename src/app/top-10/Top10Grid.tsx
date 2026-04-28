'use client'

import { useState } from 'react'
import Link from 'next/link'
import type { Top10List } from '@/data/top10'

interface Props {
  items: Top10List[]
}

export default function Top10Grid({ items }: Props) {
  const [search, setSearch] = useState('')

  const q = search.toLowerCase().trim()
  const filtered = q
    ? items.filter(
        list =>
          list.title.toLowerCase().includes(q) ||
          list.category.toLowerCase().includes(q) ||
          list.description.toLowerCase().includes(q)
      )
    : items

  return (
    <>
      {/* Search bar */}
      <div className="flex items-center gap-2 p-3 mb-8 rounded-xl border border-border bg-surface shadow-sm">
        <div className="relative flex-1">
          <svg
            className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground"
            width="14" height="14" viewBox="0 0 24 24" fill="none"
            stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"
          >
            <circle cx="11" cy="11" r="8" /><path d="m21 21-4.35-4.35" />
          </svg>
          <input
            type="search"
            value={search}
            onChange={e => setSearch(e.target.value)}
            placeholder="Search top 10 lists..."
            className="w-full h-9 pl-8 pr-3 rounded-lg border border-border bg-transparent text-[13px] text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
          />
        </div>
        {search && (
          <button
            onClick={() => setSearch('')}
            aria-label="Clear search"
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
          <p className="text-muted-foreground text-[15px]">No lists found for &quot;{search}&quot;.</p>
          <button
            onClick={() => setSearch('')}
            className="mt-3 inline-block text-blue-600 text-[14px] hover:underline"
          >
            Clear search
          </button>
        </div>
      )}
    </>
  )
}
