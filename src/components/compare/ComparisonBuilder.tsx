'use client'

import { useState, useMemo, useRef, useEffect } from 'react'
import { useRouter } from 'next/navigation'

interface ToolOption {
  slug: string
  name: string
}

interface Props {
  toolOptions: ToolOption[]
}

function canonicalSlug(a: string, b: string): string {
  const [x, y] = a < b ? [a, b] : [b, a]
  return `${x}-vs-${y}`
}

interface PickerProps {
  value: ToolOption | null
  onChange: (t: ToolOption | null) => void
  options: ToolOption[]
  placeholder: string
  disabledSlug?: string | null
}

function Picker({ value, onChange, options, placeholder, disabledSlug }: PickerProps) {
  const [query, setQuery] = useState('')
  const [open, setOpen] = useState(false)
  const wrapRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    function onDocClick(e: MouseEvent) {
      if (!wrapRef.current?.contains(e.target as Node)) setOpen(false)
    }
    document.addEventListener('mousedown', onDocClick)
    return () => document.removeEventListener('mousedown', onDocClick)
  }, [])

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase()
    const base = q
      ? options.filter(o => o.name.toLowerCase().includes(q) || o.slug.toLowerCase().includes(q))
      : options
    return base.filter(o => o.slug !== disabledSlug).slice(0, 8)
  }, [options, query, disabledSlug])

  return (
    <div ref={wrapRef} className="relative flex-1 min-w-[160px]">
      <input
        type="text"
        value={value ? value.name : query}
        onChange={e => {
          setQuery(e.target.value)
          if (value) onChange(null)
          setOpen(true)
        }}
        onFocus={() => setOpen(true)}
        placeholder={placeholder}
        className="w-full h-10 px-3 rounded-lg border border-border bg-surface text-[14px] text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
      />
      {value && (
        <button
          type="button"
          onClick={() => { onChange(null); setQuery('') }}
          aria-label="Clear"
          className="absolute right-2 top-1/2 -translate-y-1/2 text-muted-foreground hover:text-red-500 text-[12px] w-6 h-6 flex items-center justify-center"
        >
          ✕
        </button>
      )}
      {open && filtered.length > 0 && (
        <ul className="absolute z-20 left-0 right-0 mt-1 max-h-60 overflow-auto rounded-lg border border-border bg-surface shadow-lg">
          {filtered.map(o => (
            <li key={o.slug}>
              <button
                type="button"
                onClick={() => { onChange(o); setQuery(''); setOpen(false) }}
                className="w-full text-left px-3 py-2 text-[13px] text-foreground hover:bg-blue-50 dark:hover:bg-blue-950/40 transition-colors"
              >
                {o.name}
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
  )
}

export default function ComparisonBuilder({ toolOptions }: Props) {
  const router = useRouter()
  const [a, setA] = useState<ToolOption | null>(null)
  const [b, setB] = useState<ToolOption | null>(null)

  const ready = !!(a && b && a.slug !== b.slug)

  function go() {
    if (!a || !b) return
    router.push(`/compare/${canonicalSlug(a.slug, b.slug)}`)
  }

  return (
    <div className="mb-6 p-4 rounded-xl border border-border bg-card">
      <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">
        Pick any 2 tools to compare
      </p>
      <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-2">
        <Picker
          value={a}
          onChange={setA}
          options={toolOptions}
          placeholder="First tool"
          disabledSlug={b?.slug ?? null}
        />
        <span className="text-[12px] font-bold text-blue-600 bg-[#EFF6FF] px-2 py-1 rounded-md text-center sm:self-stretch sm:flex sm:items-center">VS</span>
        <Picker
          value={b}
          onChange={setB}
          options={toolOptions}
          placeholder="Second tool"
          disabledSlug={a?.slug ?? null}
        />
        <button
          type="button"
          onClick={go}
          disabled={!ready}
          className="h-10 px-5 rounded-lg bg-blue-600 hover:bg-blue-700 disabled:bg-blue-300 disabled:cursor-not-allowed text-white text-[14px] font-semibold transition-colors"
        >
          Compare →
        </button>
      </div>
      <p className="text-[11px] text-muted-foreground mt-2">
        If we have not yet reviewed this pair editorially, you will see an auto-generated comparison built from each tool&apos;s data signals.
      </p>
    </div>
  )
}
