'use client'

import { useRouter, useSearchParams } from 'next/navigation'

const SELECT_CLS =
  'h-9 px-3 rounded-lg border border-border bg-surface text-[13px] text-foreground focus:outline-none focus:border-blue-400 cursor-pointer transition-colors'

interface Props {
  toolOptions: { slug: string; name: string }[]
  categoryOptions: string[]
}

export default function CompareFilterBar({ toolOptions, categoryOptions }: Props) {
  const router = useRouter()
  const params = useSearchParams()

  const toolA = params.get('tool_a') ?? ''
  const toolB = params.get('tool_b') ?? ''
  const category = params.get('category') ?? ''

  function update(key: string, value: string) {
    const p = new URLSearchParams(params.toString())
    if (value) p.set(key, value)
    else p.delete(key)
    router.push(`/compare?${p.toString()}`)
  }

  const hasFilters = toolA || toolB || category

  return (
    <div className="flex flex-wrap items-center gap-2 p-3 mb-8 rounded-xl border border-border bg-surface shadow-sm">
      <select
        value={toolA}
        onChange={e => update('tool_a', e.target.value)}
        className={`${SELECT_CLS} flex-1 min-w-[140px]`}
        aria-label="Tool A"
      >
        <option value="">Tool A</option>
        {toolOptions.map(t => (
          <option key={t.slug} value={t.slug}>{t.name}</option>
        ))}
      </select>

      <span className="text-[11px] font-bold px-2.5 py-1 rounded-full bg-[#EFF6FF] text-[#2563EB] flex-shrink-0 select-none">
        VS
      </span>

      <select
        value={toolB}
        onChange={e => update('tool_b', e.target.value)}
        className={`${SELECT_CLS} flex-1 min-w-[140px]`}
        aria-label="Tool B"
      >
        <option value="">Tool B</option>
        {toolOptions.map(t => (
          <option key={t.slug} value={t.slug}>{t.name}</option>
        ))}
      </select>

      {categoryOptions.length > 0 && (
        <select
          value={category}
          onChange={e => update('category', e.target.value)}
          className={SELECT_CLS}
          aria-label="Category"
        >
          <option value="">All categories</option>
          {categoryOptions.map(c => (
            <option key={c} value={c}>{c}</option>
          ))}
        </select>
      )}

      {hasFilters && (
        <button
          onClick={() => router.push('/compare')}
          aria-label="Clear filters"
          className="flex items-center justify-center w-8 h-8 rounded-lg border border-border text-muted-foreground hover:border-red-300 hover:text-red-500 transition-colors flex-shrink-0"
        >
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
            stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
            <path d="M18 6 6 18M6 6l12 12" />
          </svg>
        </button>
      )}
    </div>
  )
}
