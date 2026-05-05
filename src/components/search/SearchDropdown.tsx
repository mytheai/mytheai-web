'use client'

import { useEffect, useState, useRef, useCallback } from 'react'
import Link from 'next/link'
import { useRouter } from 'next/navigation'
import LogoImage from '@/components/ui/LogoImage'

// Compact shape returned by /api/search-index
interface CompactTool {
  s: string  // slug
  n: string  // name
  t: string  // tagline
  l: string | null  // logo_url
  w: string | null  // website_url
  p: 'free' | 'freemium' | 'paid' | 'ltd'  // pricing
  g: string[]  // tags
  r: number  // rating
}

// Module-level cache: index loads once per browser session
let cachedIndex: CompactTool[] | null = null
let loadingPromise: Promise<CompactTool[]> | null = null

async function loadIndex(): Promise<CompactTool[]> {
  if (cachedIndex) return cachedIndex
  if (loadingPromise) return loadingPromise
  loadingPromise = fetch('/api/search-index')
    .then(r => r.json())
    .then((data: CompactTool[]) => {
      cachedIndex = data
      return data
    })
    .catch(() => {
      loadingPromise = null
      return []
    })
  return loadingPromise
}

// ── Scoring ────────────────────────────────────────────────────────────────
// Higher score = better match. Returns 0 for no match.
// Substring + word-boundary + Levenshtein fuzzy fallback for typos.
function scoreMatch(tool: CompactTool, q: string): number {
  const ql = q.toLowerCase()
  const nl = tool.n.toLowerCase()
  const tl = tool.t.toLowerCase()

  // Exact name match
  if (nl === ql) return 1000

  // Name starts with query
  if (nl.startsWith(ql)) return 900 - Math.min(50, nl.length - ql.length)

  // Word boundary in name (e.g. "ai" matches "Notion AI")
  const nameWords = nl.split(/[\s\-_/]+/)
  if (nameWords.some(w => w === ql)) return 850
  if (nameWords.some(w => w.startsWith(ql))) return 800

  // Substring anywhere in name
  if (nl.includes(ql)) return 700

  // Tag exact match (e.g. "writing" in tags)
  if (tool.g.some(g => g.toLowerCase() === ql)) return 650
  if (tool.g.some(g => g.toLowerCase().includes(ql))) return 500

  // Substring in tagline, weighted slightly by rating
  if (tl.includes(ql)) return 400 + Math.min(50, Math.round(tool.r * 10))

  // Multi-word: check if all terms appear somewhere
  const terms = ql.split(/\s+/).filter(t => t.length >= 2)
  if (terms.length > 1) {
    const haystack = nl + ' ' + tl + ' ' + tool.g.join(' ').toLowerCase()
    const matched = terms.filter(t => haystack.includes(t))
    if (matched.length === terms.length) return 300
    if (matched.length >= terms.length - 1) return 150
  }

  // Fuzzy fallback: Levenshtein on tool name when query is 4-15 chars.
  // Only triggers when nothing else matched - keeps perf cheap.
  if (ql.length >= 4 && ql.length <= 15) {
    const dist = levenshtein(ql, nl.slice(0, Math.min(nl.length, ql.length + 3)))
    const maxAllowed = ql.length <= 6 ? 1 : 2
    if (dist <= maxAllowed) return 200 - dist * 30
  }

  return 0
}

// Levenshtein distance with 2-row DP. Returns small integer.
function levenshtein(a: string, b: string): number {
  if (a === b) return 0
  if (a.length === 0) return b.length
  if (b.length === 0) return a.length
  let prev = new Array(b.length + 1)
  let curr = new Array(b.length + 1)
  for (let j = 0; j <= b.length; j++) prev[j] = j
  for (let i = 1; i <= a.length; i++) {
    curr[0] = i
    for (let j = 1; j <= b.length; j++) {
      const cost = a[i - 1] === b[j - 1] ? 0 : 1
      curr[j] = Math.min(curr[j - 1] + 1, prev[j] + 1, prev[j - 1] + cost)
    }
    ;[prev, curr] = [curr, prev]
  }
  return prev[b.length]
}

const POPULAR_QUERIES = ['ChatGPT alternatives', 'Free AI tools', 'AI for coding', 'Best SEO tools']

// ── Subcomponents ──────────────────────────────────────────────────────────

function PricingBadge({ p }: { p: CompactTool['p'] }) {
  const map = {
    free: 'bg-[#D1FAE5] text-[#065F46]',
    freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
    paid: 'bg-[#F3F4F6] text-[#374151]',
    ltd: 'bg-[#FEF3C7] text-[#92400E]',
  }
  const labels = { free: 'Free', freemium: 'Freemium', paid: 'Paid', ltd: 'LTD' }
  return (
    <span className={`text-[10px] font-semibold px-1.5 py-0.5 rounded-full flex-shrink-0 ${map[p]}`}>
      {labels[p]}
    </span>
  )
}

function SearchIcon({ size = 18 }: { size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <circle cx="11" cy="11" r="8" />
      <path d="m21 21-4.35-4.35" />
    </svg>
  )
}

// ── Main component ────────────────────────────────────────────────────────

interface Props {
  variant: 'hero' | 'header'
  popular?: string[]
}

export default function SearchDropdown({ variant, popular = POPULAR_QUERIES }: Props) {
  const router = useRouter()
  const containerRef = useRef<HTMLDivElement>(null)
  const inputRef = useRef<HTMLInputElement>(null)

  const [query, setQuery] = useState('')
  const [results, setResults] = useState<CompactTool[]>([])
  const [comparePair, setComparePair] = useState<{ a: CompactTool; b: CompactTool } | null>(null)
  const [isOpen, setIsOpen] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const [activeIdx, setActiveIdx] = useState(-1)
  const [indexLoaded, setIndexLoaded] = useState(typeof window !== 'undefined' && !!cachedIndex)

  // Load index on first focus
  const ensureIndex = useCallback(async () => {
    if (cachedIndex) {
      if (!indexLoaded) setIndexLoaded(true)
      return
    }
    setIsLoading(true)
    await loadIndex()
    setIndexLoaded(true)
    setIsLoading(false)
  }, [indexLoaded])

  // Compute results whenever query or index changes
  useEffect(() => {
    if (!cachedIndex || !query.trim()) {
      setResults([])
      setComparePair(null)
      setActiveIdx(-1)
      return
    }
    const q = query.trim().toLowerCase()

    // "X vs Y" detection - if both tokens resolve to known tools, surface compare CTA
    const vsMatch = q.match(/^(.+?)\s+vs\.?\s+(.+)$/)
    if (vsMatch && cachedIndex) {
      const aQuery = vsMatch[1].trim()
      const bQuery = vsMatch[2].trim()
      const findBest = (qq: string) => cachedIndex!
        .map(t => ({ t, s: scoreMatch(t, qq) }))
        .filter(x => x.s >= 700)
        .sort((a, b) => b.s - a.s)[0]?.t
      const a = findBest(aQuery)
      const b = findBest(bQuery)
      if (a && b && a.s !== b.s) {
        setComparePair({ a, b })
      } else {
        setComparePair(null)
      }
    } else {
      setComparePair(null)
    }

    const scored = cachedIndex
      .map(tool => ({ tool, score: scoreMatch(tool, q) }))
      .filter(x => x.score > 0)
      .sort((a, b) => b.score - a.score || b.tool.r - a.tool.r)
      .slice(0, 8)
      .map(x => x.tool)
    setResults(scored)
    setActiveIdx(-1)
  }, [query, indexLoaded])

  // Click outside closes dropdown
  useEffect(() => {
    function onMouseDown(e: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setIsOpen(false)
      }
    }
    document.addEventListener('mousedown', onMouseDown)
    return () => document.removeEventListener('mousedown', onMouseDown)
  }, [])

  // Cmd+K / Ctrl+K hotkey for header variant
  useEffect(() => {
    if (variant !== 'header') return
    function onKey(e: KeyboardEvent) {
      if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
        e.preventDefault()
        inputRef.current?.focus()
        inputRef.current?.select()
      }
    }
    document.addEventListener('keydown', onKey)
    return () => document.removeEventListener('keydown', onKey)
  }, [variant])

  function handleKey(e: React.KeyboardEvent<HTMLInputElement>) {
    if (e.key === 'ArrowDown') {
      e.preventDefault()
      setActiveIdx(i => Math.min(i + 1, results.length - 1))
    } else if (e.key === 'ArrowUp') {
      e.preventDefault()
      setActiveIdx(i => Math.max(i - 1, -1))
    } else if (e.key === 'Enter') {
      if (activeIdx >= 0 && results[activeIdx]) {
        e.preventDefault()
        router.push(`/tools/${results[activeIdx].s}`)
        closeAndBlur()
      } else if (comparePair) {
        e.preventDefault()
        router.push(`/compare/${comparePair.a.s}-vs-${comparePair.b.s}`)
        closeAndBlur()
      } else if (query.trim()) {
        e.preventDefault()
        router.push(`/tools?q=${encodeURIComponent(query.trim())}`)
        closeAndBlur()
      }
    } else if (e.key === 'Escape') {
      e.preventDefault()
      closeAndBlur()
    }
  }

  function closeAndBlur() {
    setIsOpen(false)
    inputRef.current?.blur()
  }

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (query.trim()) {
      router.push(`/tools?q=${encodeURIComponent(query.trim())}`)
      closeAndBlur()
    }
  }

  // Decide when to render the dropdown
  const dropdownVisible = isOpen && (variant === 'hero' || query.trim().length > 0)

  // ── Hero variant ─────────────────────────────────────────────────────────
  if (variant === 'hero') {
    return (
      <div ref={containerRef} className="relative">
        <form
          onSubmit={handleSubmit}
          className="flex items-center gap-2 p-1.5 shadow-md rounded-xl border border-border bg-card"
          role="search"
        >
          <span className="pl-3 text-muted-foreground flex-shrink-0">
            <SearchIcon />
          </span>
          <input
            ref={inputRef}
            type="search"
            value={query}
            onChange={e => setQuery(e.target.value)}
            onFocus={() => { setIsOpen(true); ensureIndex() }}
            onKeyDown={handleKey}
            placeholder="Try: AI for writing emails, free video tools..."
            autoComplete="off"
            aria-label="Search AI tools"
            aria-expanded={dropdownVisible}
            aria-autocomplete="list"
            aria-controls="search-results"
            role="combobox"
            className="flex-1 py-3.5 px-1 text-[15px] bg-transparent outline-none text-foreground placeholder:text-muted-foreground min-w-0"
          />
          <button
            type="submit"
            className="px-5 py-2.5 rounded-lg text-white text-[14px] font-semibold bg-blue-600 hover:bg-blue-700 active:bg-blue-800 transition-colors flex-shrink-0"
          >
            Search
          </button>
        </form>

        {dropdownVisible && (
          <div
            id="search-results"
            className="absolute top-full left-0 right-0 mt-2 bg-card border border-border rounded-xl shadow-2xl overflow-hidden z-50"
            role="listbox"
          >
            {!query.trim() ? (
              <div className="p-4 text-left">
                <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-muted-foreground mb-2.5">
                  Popular searches
                </p>
                <div className="flex flex-wrap gap-2">
                  {popular.map(p => (
                    <button
                      key={p}
                      type="button"
                      onMouseDown={(e) => { e.preventDefault(); setQuery(p); ensureIndex() }}
                      className="px-3 py-1.5 rounded-full text-[12px] border border-border bg-card hover:border-blue-300 hover:text-blue-600 transition-colors"
                    >
                      {p}
                    </button>
                  ))}
                </div>
                <div className="mt-3 pt-3 border-t border-border flex items-center gap-3 text-[11px] text-muted-foreground">
                  <span className="flex items-center gap-1">
                    <kbd className="px-1.5 py-0.5 rounded border border-border bg-card text-[10px] font-medium">↑↓</kbd>
                    Navigate
                  </span>
                  <span className="flex items-center gap-1">
                    <kbd className="px-1.5 py-0.5 rounded border border-border bg-card text-[10px] font-medium">Enter</kbd>
                    Open
                  </span>
                  <span className="flex items-center gap-1">
                    <kbd className="px-1.5 py-0.5 rounded border border-border bg-card text-[10px] font-medium">Esc</kbd>
                    Close
                  </span>
                </div>
              </div>
            ) : isLoading ? (
              <div className="p-6 text-center text-[13px] text-muted-foreground">
                Loading 500+ tools...
              </div>
            ) : results.length === 0 ? (
              <div className="p-6 text-center">
                <p className="text-[14px] font-medium text-foreground mb-1">No tools match &ldquo;{query}&rdquo;</p>
                <p className="text-[12px] text-muted-foreground mb-3">Try a different keyword or browse all tools</p>
                <Link
                  href={`/tools?q=${encodeURIComponent(query)}`}
                  onClick={closeAndBlur}
                  className="inline-block text-[12px] font-semibold text-blue-600 hover:underline"
                >
                  Browse all tools →
                </Link>
              </div>
            ) : (
              <div>
                {comparePair && (
                  <Link
                    href={`/compare/${comparePair.a.s}-vs-${comparePair.b.s}`}
                    onClick={closeAndBlur}
                    className="flex items-center gap-3 px-4 py-2.5 border-b border-border bg-blue-50/50 dark:bg-blue-950/20 hover:bg-blue-100/50 dark:hover:bg-blue-950/40 transition-colors"
                  >
                    <span className="text-[11px] font-bold text-[#2563EB] bg-[#EFF6FF] px-2 py-0.5 rounded">VS</span>
                    <span className="flex-1 text-[13px] text-foreground">
                      Compare <strong>{comparePair.a.n}</strong> vs <strong>{comparePair.b.n}</strong>
                    </span>
                    <span className="text-[12px] text-blue-600 font-medium">→</span>
                  </Link>
                )}
                <ul className="max-h-[420px] overflow-y-auto" role="presentation">
                  {results.map((tool, i) => (
                    <li key={tool.s} role="presentation">
                      <Link
                        href={`/tools/${tool.s}`}
                        onClick={closeAndBlur}
                        onMouseEnter={() => setActiveIdx(i)}
                        className={`flex items-center gap-3 px-4 py-2.5 transition-colors text-left ${
                          i === activeIdx ? 'bg-[#EFF6FF] dark:bg-[#1E3A5F]' : 'hover:bg-gray-50 dark:hover:bg-gray-800'
                        }`}
                        role="option"
                        aria-selected={i === activeIdx}
                      >
                        <div className="w-9 h-9 rounded-lg bg-gray-50 flex items-center justify-center flex-shrink-0 overflow-hidden border border-border">
                          <LogoImage
                            src={tool.l}
                            websiteUrl={tool.w}
                            name={tool.n}
                            size={32}
                            className="object-contain p-0.5"
                            letterClassName="text-[12px] font-bold text-gray-400"
                          />
                        </div>
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2 mb-0.5">
                            <span className="text-[13.5px] font-semibold text-foreground truncate">{tool.n}</span>
                            <PricingBadge p={tool.p} />
                          </div>
                          <div className="text-[12px] text-muted-foreground truncate">{tool.t}</div>
                        </div>
                        <span className="text-[#F59E0B] text-[12px] font-semibold flex-shrink-0 ml-2">
                          ★ {tool.r.toFixed(1)}
                        </span>
                      </Link>
                    </li>
                  ))}
                </ul>
                <Link
                  href={`/tools?q=${encodeURIComponent(query)}`}
                  onClick={closeAndBlur}
                  className="block px-4 py-3 border-t border-border text-[13px] font-medium text-blue-600 hover:bg-[#EFF6FF] dark:hover:bg-[#1E3A5F] transition-colors text-center"
                >
                  See all results for &ldquo;{query}&rdquo; →
                </Link>
              </div>
            )}
          </div>
        )}
      </div>
    )
  }

  // ── Header variant ───────────────────────────────────────────────────────
  return (
    <div ref={containerRef} className="relative w-full">
      <form onSubmit={handleSubmit} className="relative" role="search">
        <span className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground pointer-events-none">
          <SearchIcon size={14} />
        </span>
        <input
          ref={inputRef}
          type="search"
          value={query}
          onChange={e => setQuery(e.target.value)}
          onFocus={() => { setIsOpen(true); ensureIndex() }}
          onKeyDown={handleKey}
          placeholder="Search 500+ tools..."
          autoComplete="off"
          aria-label="Search AI tools"
          aria-expanded={dropdownVisible}
          aria-autocomplete="list"
          aria-controls="header-search-results"
          role="combobox"
          className="w-full h-9 pl-9 pr-12 text-[13px] rounded-lg border border-border bg-background hover:border-blue-300 focus:bg-card focus:outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-400/20 transition-colors text-foreground placeholder:text-muted-foreground"
        />
        <kbd className="absolute right-2 top-1/2 -translate-y-1/2 hidden lg:flex items-center gap-0.5 px-1.5 h-5 rounded text-[10px] font-medium text-muted-foreground border border-border bg-card pointer-events-none">
          ⌘K
        </kbd>
      </form>

      {dropdownVisible && query.trim() && (
        <div
          id="header-search-results"
          className="absolute top-full left-0 mt-2 bg-card border border-border rounded-xl shadow-2xl overflow-hidden z-50"
          role="listbox"
          style={{ width: 'max(100%, 360px)' }}
        >
          {isLoading ? (
            <div className="p-4 text-center text-[12px] text-muted-foreground">Loading...</div>
          ) : results.length === 0 ? (
            <div className="p-4 text-center">
              <p className="text-[12px] text-muted-foreground mb-2">No tools match &ldquo;{query}&rdquo;</p>
              <Link
                href={`/tools?q=${encodeURIComponent(query)}`}
                onClick={closeAndBlur}
                className="text-[12px] text-blue-600 font-medium hover:underline"
              >
                Browse all tools →
              </Link>
            </div>
          ) : (
            <div>
              {comparePair && (
                <Link
                  href={`/compare/${comparePair.a.s}-vs-${comparePair.b.s}`}
                  onClick={closeAndBlur}
                  className="flex items-center gap-2 px-3 py-2 border-b border-border bg-blue-50/50 dark:bg-blue-950/20 hover:bg-blue-100/50 dark:hover:bg-blue-950/40 transition-colors"
                >
                  <span className="text-[10px] font-bold text-[#2563EB] bg-[#EFF6FF] px-1.5 py-0.5 rounded">VS</span>
                  <span className="flex-1 text-[12px] text-foreground truncate">
                    Compare <strong>{comparePair.a.n}</strong> vs <strong>{comparePair.b.n}</strong>
                  </span>
                  <span className="text-[11px] text-blue-600">→</span>
                </Link>
              )}
              <ul className="max-h-[360px] overflow-y-auto" role="presentation">
                {results.map((tool, i) => (
                  <li key={tool.s} role="presentation">
                    <Link
                      href={`/tools/${tool.s}`}
                      onClick={closeAndBlur}
                      onMouseEnter={() => setActiveIdx(i)}
                      className={`flex items-center gap-3 px-3 py-2 transition-colors ${
                        i === activeIdx ? 'bg-[#EFF6FF] dark:bg-[#1E3A5F]' : 'hover:bg-gray-50 dark:hover:bg-gray-800'
                      }`}
                      role="option"
                      aria-selected={i === activeIdx}
                    >
                      <div className="w-7 h-7 rounded-md bg-gray-50 flex items-center justify-center flex-shrink-0 overflow-hidden border border-border">
                        <LogoImage
                          src={tool.l}
                          websiteUrl={tool.w}
                          name={tool.n}
                          size={24}
                          className="object-contain p-0.5"
                          letterClassName="text-[10px] font-bold text-gray-400"
                        />
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-1.5">
                          <span className="text-[12.5px] font-semibold text-foreground truncate">{tool.n}</span>
                          <PricingBadge p={tool.p} />
                        </div>
                        <div className="text-[11px] text-muted-foreground truncate">{tool.t}</div>
                      </div>
                    </Link>
                  </li>
                ))}
              </ul>
              <Link
                href={`/tools?q=${encodeURIComponent(query)}`}
                onClick={closeAndBlur}
                className="block px-3 py-2 border-t border-border text-[12px] font-medium text-blue-600 hover:bg-[#EFF6FF] dark:hover:bg-[#1E3A5F] transition-colors text-center"
              >
                See all results for &ldquo;{query}&rdquo; →
              </Link>
            </div>
          )}
        </div>
      )}
    </div>
  )
}
