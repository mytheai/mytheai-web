'use client'

import { useState } from 'react'
import Link from 'next/link'
import { useTranslations } from 'next-intl'

export interface PostMeta {
  slug: string
  title: string
  excerpt: string
  category: string
  date: string
  readTime: string
}

const CATEGORY_COLORS: Record<string, string> = {
  Roundup:    '#DBEAFE',
  Comparison: '#FEF3C7',
  Guide:      '#D1FAE5',
  Business:   '#F3E8FF',
  Design:     '#FCE7F3',
  Productivity: '#ECFDF5',
}
const CATEGORY_TEXT: Record<string, string> = {
  Roundup:    '#1E40AF',
  Comparison: '#92400E',
  Guide:      '#065F46',
  Business:   '#6B21A8',
  Design:     '#9D174D',
  Productivity: '#047857',
}

function normalize(cat: string): string {
  return cat === 'Guides' ? 'Guide' : cat
}

const SELECT_CLS =
  'h-9 px-3 rounded-lg border border-border bg-surface text-[13px] text-foreground focus:outline-none focus:border-blue-400 cursor-pointer transition-colors'

export default function BlogGrid({ posts }: { posts: PostMeta[] }) {
  const t = useTranslations('BlogPage')
  const tFilter = useTranslations('SearchFilter')
  const [category, setCategory] = useState('')
  const [search, setSearch]     = useState('')

  const categories = [...new Set(posts.map(p => normalize(p.category)))].sort()

  const filtered = posts.filter(p => {
    const cat = normalize(p.category)
    if (category && cat !== category) return false
    if (search) {
      const q = search.toLowerCase()
      return p.title.toLowerCase().includes(q) || p.excerpt.toLowerCase().includes(q)
    }
    return true
  })

  const hasFilters = !!(category || search)

  function clearAll() {
    setCategory('')
    setSearch('')
  }

  return (
    <>
      {/* Filter bar */}
      <div className="flex flex-wrap items-center gap-2 p-3 mb-8 rounded-xl border border-border bg-surface shadow-sm">
        {/* Search */}
        <div className="relative flex-1 min-w-[160px]">
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
            placeholder={t('searchPlaceholder')}
            className="w-full h-9 pl-8 pr-3 rounded-lg border border-border bg-transparent text-[13px] text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
          />
        </div>

        <div className="hidden sm:block w-px h-6 bg-border" />

        {/* Category */}
        <select
          value={category}
          onChange={e => setCategory(e.target.value)}
          className={SELECT_CLS}
        >
          <option value="">{t('allCategories')}</option>
          {categories.map(c => (
            <option key={c} value={c}>{c}</option>
          ))}
        </select>

        {/* Clear */}
        {hasFilters && (
          <button
            onClick={clearAll}
            aria-label={tFilter('clearFilters')}
            className="flex items-center justify-center w-8 h-8 rounded-lg border border-border text-muted-foreground hover:border-red-300 hover:text-red-500 transition-colors"
          >
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
              <path d="M18 6 6 18M6 6l12 12" />
            </svg>
          </button>
        )}
      </div>

      {/* Post list */}
      {filtered.length > 0 ? (
        <div className="space-y-6">
          {filtered.map(post => {
            const cat = normalize(post.category)
            return (
              <article
                key={post.slug}
                className="border border-border rounded-xl p-6 bg-card hover:border-[#93C5FD] transition-colors"
              >
                <div className="flex items-center gap-3 mb-3">
                  <span
                    className="text-[11px] font-semibold px-2 py-0.5 rounded-full"
                    style={{
                      background: CATEGORY_COLORS[cat] ?? '#F3F4F6',
                      color:      CATEGORY_TEXT[cat]   ?? '#374151',
                    }}
                  >
                    {cat}
                  </span>
                  <span className="text-[12px] text-muted-foreground">{post.date}</span>
                  <span className="text-[12px] text-muted-foreground">·</span>
                  <span className="text-[12px] text-muted-foreground">{post.readTime}</span>
                </div>
                <h2 className="text-[18px] font-bold text-foreground mb-2 leading-snug">
                  {post.title}
                </h2>
                <p className="text-[14px] text-muted-foreground leading-relaxed mb-4">
                  {post.excerpt}
                </p>
                <Link
                  href={`/blog/${post.slug}`}
                  className="text-[13px] font-semibold text-blue-600 hover:underline"
                >
                  {t('readArticle')} →
                </Link>
              </article>
            )
          })}
        </div>
      ) : (
        <div className="py-16 text-center">
          <p className="text-muted-foreground text-[15px]">{t('noResults')}</p>
          <button
            onClick={clearAll}
            className="mt-3 inline-block text-blue-600 text-[14px] hover:underline"
          >
            {tFilter('clearFilters')}
          </button>
        </div>
      )}
    </>
  )
}
