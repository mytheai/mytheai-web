'use client'

import { useRouter, useSearchParams } from 'next/navigation'

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
