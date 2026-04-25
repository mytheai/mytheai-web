'use client'

import { useRouter, useSearchParams } from 'next/navigation'
import { useEffect, useState } from 'react'
import Link from 'next/link'

const CATEGORIES = [
  { slug: 'ai-assistants', emoji: '🧠', name: 'AI Assistants' },
  { slug: 'writing-ai', emoji: '✍️', name: 'Writing AI' },
  { slug: 'image-ai', emoji: '🎨', name: 'Image AI' },
  { slug: 'video-ai', emoji: '🎬', name: 'Video AI' },
  { slug: 'code-ai', emoji: '💻', name: 'Code AI' },
  { slug: 'seo-marketing', emoji: '📈', name: 'SEO & Marketing' },
  { slug: 'productivity', emoji: '⚡', name: 'Productivity' },
  { slug: 'analytics', emoji: '📊', name: 'Analytics' },
]

const PRICING = [
  { value: '', label: 'All pricing' },
  { value: 'free', label: 'Free' },
  { value: 'freemium', label: 'Freemium' },
  { value: 'paid', label: 'Paid' },
  { value: 'ltd', label: 'LTD' },
]

export default function FilterBar() {
  const router = useRouter()
  const params = useSearchParams()
  const activeCategory = params.get('category') ?? ''
  const activePricing = params.get('pricing') ?? ''
  const [search, setSearch] = useState(params.get('q') ?? '')

  useEffect(() => {
    const timer = setTimeout(() => {
      const next = new URLSearchParams(params.toString())
      if (search) {
        next.set('q', search)
      } else {
        next.delete('q')
      }
      router.push(`/tools?${next.toString()}`)
    }, 400)
    return () => clearTimeout(timer)
  }, [search]) // eslint-disable-line react-hooks/exhaustive-deps

  function setFilter(key: string, value: string) {
    const next = new URLSearchParams(params.toString())
    if (value) {
      next.set(key, value)
    } else {
      next.delete(key)
    }
    router.push(`/tools?${next.toString()}`)
  }

  return (
    <div className="space-y-3 mb-8">
      {/* Search input */}
      <input
        type="search"
        value={search}
        onChange={e => setSearch(e.target.value)}
        placeholder="Search tools..."
        className="w-full max-w-sm px-4 py-2 rounded-lg border border-border bg-card text-[14px] text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
      />
      {/* Category filter */}
      <div className="flex flex-wrap gap-2">
        <button
          onClick={() => setFilter('category', '')}
          className={`px-3 py-1.5 rounded-lg text-[13px] font-semibold transition-colors ${
            !activeCategory
              ? 'bg-blue-600 text-white'
              : 'border border-border bg-card text-muted-foreground hover:border-blue-300 hover:text-blue-600'
          }`}
        >
          All
        </button>
        {CATEGORIES.map(cat => (
          <button
            key={cat.slug}
            onClick={() => setFilter('category', cat.slug)}
            className={`px-3 py-1.5 rounded-lg text-[13px] font-medium transition-colors ${
              activeCategory === cat.slug
                ? 'bg-blue-600 text-white border-transparent'
                : 'border border-border bg-card text-muted-foreground hover:border-blue-300 hover:text-blue-600'
            }`}
          >
            {cat.emoji} {cat.name}
          </button>
        ))}
        <Link
          href="/categories"
          className="px-3 py-1.5 rounded-lg text-[13px] font-medium text-muted-foreground hover:text-blue-600 transition-colors"
        >
          Browse all →
        </Link>
      </div>

      {/* Pricing filter */}
      <div className="flex flex-wrap gap-2">
        {PRICING.map(p => (
          <button
            key={p.value}
            onClick={() => setFilter('pricing', p.value)}
            className={`px-3 py-1 rounded-full text-[12px] font-medium border transition-colors ${
              activePricing === p.value
                ? 'border-blue-300 text-blue-600 bg-[#EFF6FF] dark:bg-blue-950'
                : 'border-border bg-card text-muted-foreground hover:border-blue-300 hover:text-blue-600'
            }`}
          >
            {p.label}
          </button>
        ))}
      </div>
    </div>
  )
}
