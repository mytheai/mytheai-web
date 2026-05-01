'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'

const STORAGE_KEY = 'mytheai-newsletter-dismissed'
const DISMISS_DAYS = 7

export default function StickyMobileBar() {
  const [hidden, setHidden] = useState(true)

  useEffect(() => {
    try {
      const raw = localStorage.getItem(STORAGE_KEY)
      if (raw) {
        const ts = parseInt(raw, 10)
        if (!Number.isNaN(ts) && Date.now() - ts < DISMISS_DAYS * 86_400_000) {
          return
        }
      }
    } catch {
      // localStorage unavailable - just show
    }
    const t = window.setTimeout(() => setHidden(false), 4000)
    return () => window.clearTimeout(t)
  }, [])

  function dismiss() {
    setHidden(true)
    try {
      localStorage.setItem(STORAGE_KEY, String(Date.now()))
    } catch {
      // ignore
    }
  }

  if (hidden) return null

  return (
    <div
      className="md:hidden fixed bottom-0 inset-x-0 z-40 px-3 pb-3 pt-2 bg-card border-t border-border shadow-[0_-4px_16px_rgba(0,0,0,0.08)]"
      role="region"
      aria-label="Newsletter signup"
    >
      <div className="flex items-center gap-3">
        <div className="flex-1 min-w-0">
          <p className="text-[13px] font-semibold text-foreground leading-tight">
            Weekly AI tool picks
          </p>
          <p className="text-[11px] text-muted-foreground leading-tight mt-0.5">
            5 tools every Tuesday. No spam.
          </p>
        </div>
        <Link
          href="/?subscribe=1#newsletter"
          className="px-3 py-2 rounded-lg bg-blue-600 text-white text-[12px] font-semibold whitespace-nowrap hover:bg-blue-700 transition-colors"
          onClick={dismiss}
        >
          Subscribe
        </Link>
        <button
          onClick={dismiss}
          className="p-1.5 rounded-md text-muted-foreground hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
          aria-label="Dismiss"
        >
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
            <line x1="18" y1="6" x2="6" y2="18" />
            <line x1="6" y1="6" x2="18" y2="18" />
          </svg>
        </button>
      </div>
    </div>
  )
}
