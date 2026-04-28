'use client'

import { useState, useRef, useEffect } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'

const CATEGORIES = [
  { slug: 'ai-assistants',         name: 'AI Assistants' },
  { slug: 'writing-ai',            name: 'Writing' },
  { slug: 'image-ai',              name: 'Image AI' },
  { slug: 'image-generation',      name: 'Image Gen' },
  { slug: 'video-ai',              name: 'Video AI' },
  { slug: 'video-generation',      name: 'Video Gen' },
  { slug: 'code-ai',               name: 'Code AI' },
  { slug: 'design',                name: 'Design' },
  { slug: 'voice-audio',           name: 'Voice & Audio' },
  { slug: 'audio-ai',              name: 'Audio AI' },
  { slug: 'ai-agent',              name: 'AI Agents' },
  { slug: 'machine-learning',      name: 'Machine Learning' },
  { slug: 'seo-marketing',         name: 'SEO & Marketing' },
  { slug: 'marketing',             name: 'Marketing' },
  { slug: 'content',               name: 'Content' },
  { slug: 'email-marketing',       name: 'Email Marketing' },
  { slug: 'social-media',          name: 'Social Media' },
  { slug: 'sales',                 name: 'Sales' },
  { slug: 'crm',                   name: 'CRM' },
  { slug: 'productivity',          name: 'Productivity' },
  { slug: 'automation',            name: 'Automation' },
  { slug: 'project-management',    name: 'Project Mgmt' },
  { slug: 'scheduling',            name: 'Scheduling' },
  { slug: 'team-collaboration',    name: 'Collaboration' },
  { slug: 'analytics',             name: 'Analytics' },
  { slug: 'data-analysis',         name: 'Data Analysis' },
  { slug: 'business-intelligence', name: 'Business Intel' },
  { slug: 'developer-tools',       name: 'Dev Tools' },
  { slug: 'no-code',               name: 'No-Code' },
  { slug: 'databases',             name: 'Databases' },
  { slug: 'spreadsheets',          name: 'Spreadsheets' },
  { slug: 'open-source',           name: 'Open Source' },
  { slug: 'security',              name: 'Security' },
  { slug: 'customer-support',      name: 'Customer Support' },
  { slug: 'operations',            name: 'Operations' },
  { slug: 'research',              name: 'Research' },
  { slug: 'podcasting',            name: 'Podcasting' },
  { slug: 'education',             name: 'Education' },
  { slug: 'healthcare',            name: 'Healthcare' },
  { slug: 'legal-ai',              name: 'Legal AI' },
]

const DISCOUNT_OPTIONS = [
  { value: '',            label: 'All Discounts' },
  { value: '50-off',      label: '50%+ Off' },
  { value: 'lifetime',    label: 'Lifetime' },
  { value: 'free-trial',  label: 'Free Trial Extended' },
]

const PRICE_OPTIONS = [
  { value: '',          label: 'All Pricing' },
  { value: 'under-20',  label: 'Under $20' },
  { value: 'under-50',  label: 'Under $50' },
  { value: 'under-100', label: 'Under $100' },
]

const SELECT_CLS =
  'h-9 px-3 rounded-lg border border-border bg-surface text-[13px] text-foreground focus:outline-none focus:border-blue-400 cursor-pointer transition-colors'

interface ToolOption {
  slug: string
  name: string
}

function ToolCombobox({
  value,
  onChange,
  options,
  placeholder,
}: {
  value: string
  onChange: (slug: string) => void
  options: ToolOption[]
  placeholder: string
}) {
  const [query, setQuery] = useState('')
  const [open, setOpen] = useState(false)
  const containerRef = useRef<HTMLDivElement>(null)

  const selectedName = options.find(o => o.slug === value)?.name ?? ''

  useEffect(() => {
    function handleOutside(e: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setOpen(false)
        setQuery('')
      }
    }
    document.addEventListener('mousedown', handleOutside)
    return () => document.removeEventListener('mousedown', handleOutside)
  }, [])

  const filtered = query.trim()
    ? options.filter(o => o.name.toLowerCase().includes(query.toLowerCase()))
    : options

  return (
    <div ref={containerRef} className="relative flex-1 min-w-[160px]">
      <div className="flex items-center h-9 rounded-lg border border-border bg-surface px-3 gap-2 focus-within:border-blue-400 transition-colors">
        {value && !open ? (
          <>
            <span
              className="flex-1 text-[13px] text-foreground truncate cursor-pointer"
              onClick={() => setOpen(true)}
            >
              {selectedName}
            </span>
            <button
              onClick={() => onChange('')}
              aria-label="Clear selection"
              className="text-muted-foreground hover:text-red-500 transition-colors flex-shrink-0"
            >
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round">
                <path d="M18 6 6 18M6 6l12 12" />
              </svg>
            </button>
          </>
        ) : (
          <input
            type="text"
            value={query}
            placeholder={placeholder}
            className="flex-1 bg-transparent text-[13px] text-foreground placeholder:text-muted-foreground focus:outline-none min-w-0"
            onFocus={() => setOpen(true)}
            onChange={e => { setQuery(e.target.value); setOpen(true) }}
          />
        )}
      </div>

      {open && (
        <div className="absolute z-50 top-full left-0 mt-1 w-full max-h-56 overflow-y-auto rounded-lg border border-border bg-surface shadow-lg">
          {filtered.length > 0 ? (
            filtered.map(o => (
              <button
                key={o.slug}
                className="w-full text-left px-3 py-2 text-[13px] text-foreground hover:bg-[#EFF6FF] hover:text-[#2563EB] transition-colors"
                onMouseDown={e => {
                  e.preventDefault()
                  onChange(o.slug)
                  setOpen(false)
                  setQuery('')
                }}
              >
                {o.name}
              </button>
            ))
          ) : (
            <p className="px-3 py-3 text-[13px] text-muted-foreground text-center">No tools found</p>
          )}
        </div>
      )}
    </div>
  )
}

interface Props {
  toolOptions: ToolOption[]
}

export default function DealsFilterBar({ toolOptions }: Props) {
  const router = useRouter()
  const params = useSearchParams()

  const tool      = params.get('tool')      ?? ''
  const discount  = params.get('discount')  ?? ''
  const max_price = params.get('max_price') ?? ''
  const category  = params.get('category')  ?? ''

  function update(key: string, value: string) {
    const p = new URLSearchParams(params.toString())
    if (value) p.set(key, value)
    else p.delete(key)
    router.push(`/deals?${p.toString()}`)
  }

  const hasFilters = !!(tool || discount || max_price || category)

  return (
    <div className="flex flex-wrap items-center gap-2 p-3 mb-8 rounded-xl border border-border bg-surface shadow-sm">
      <ToolCombobox
        value={tool}
        onChange={v => update('tool', v)}
        options={toolOptions}
        placeholder="Search tools..."
      />

      <div className="hidden sm:block w-px h-6 bg-border" />

      <select
        value={discount}
        onChange={e => update('discount', e.target.value)}
        className={SELECT_CLS}
      >
        {DISCOUNT_OPTIONS.map(o => (
          <option key={o.value} value={o.value}>{o.label}</option>
        ))}
      </select>

      <select
        value={max_price}
        onChange={e => update('max_price', e.target.value)}
        className={SELECT_CLS}
      >
        {PRICE_OPTIONS.map(o => (
          <option key={o.value} value={o.value}>{o.label}</option>
        ))}
      </select>

      <select
        value={category}
        onChange={e => update('category', e.target.value)}
        className={SELECT_CLS}
      >
        <option value="">All Categories</option>
        {CATEGORIES.map(c => (
          <option key={c.slug} value={c.slug}>{c.name}</option>
        ))}
      </select>

      {hasFilters && (
        <button
          onClick={() => router.push('/deals')}
          aria-label="Clear all filters"
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
