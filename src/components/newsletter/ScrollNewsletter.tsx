'use client'

import { useEffect, useState } from 'react'
import NewsletterForm from './NewsletterForm'

const STORAGE_KEY = 'mytheai-scroll-newsletter-dismissed'
const SHOW_AT_PCT = 0.5  // fire after user scrolls 50% of page
const SUPPRESS_DAYS = 14 // skip for 2 weeks after dismiss or signup

interface Props {
  // Optional override of when to fire (0..1 fraction of scrollable height)
  showAtPct?: number
}

export default function ScrollNewsletter({ showAtPct = SHOW_AT_PCT }: Props) {
  const [open, setOpen] = useState(false)
  const [armed, setArmed] = useState(false)

  // Check storage on mount; arm only if not recently dismissed
  useEffect(() => {
    try {
      const raw = localStorage.getItem(STORAGE_KEY)
      if (raw) {
        const ts = parseInt(raw, 10)
        if (!Number.isNaN(ts) && Date.now() - ts < SUPPRESS_DAYS * 86400 * 1000) return
      }
    } catch {
      // localStorage may be unavailable; arm anyway
    }
    setArmed(true)
  }, [])

  useEffect(() => {
    if (!armed) return
    let triggered = false
    function onScroll() {
      if (triggered) return
      const scrollable = document.documentElement.scrollHeight - window.innerHeight
      if (scrollable <= 0) return
      const pct = window.scrollY / scrollable
      if (pct >= showAtPct) {
        triggered = true
        setOpen(true)
        window.removeEventListener('scroll', onScroll)
      }
    }
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [armed, showAtPct])

  function dismiss() {
    setOpen(false)
    try {
      localStorage.setItem(STORAGE_KEY, String(Date.now()))
    } catch {
      // ignore
    }
  }

  if (!open) return null

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="scroll-news-title"
      className="fixed inset-x-3 bottom-3 md:inset-x-auto md:bottom-6 md:right-6 md:max-w-sm z-50 rounded-xl border border-blue-200 dark:border-blue-900/50 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/85 shadow-lg p-5"
    >
      <button
        type="button"
        onClick={dismiss}
        aria-label="Dismiss"
        className="absolute top-2.5 right-2.5 w-7 h-7 rounded-full text-muted-foreground hover:text-foreground hover:bg-gray-100 dark:hover:bg-gray-800 flex items-center justify-center text-[14px]"
      >
        ✕
      </button>
      <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-700 dark:text-blue-300 mb-1">
        Weekly Picks
      </p>
      <p id="scroll-news-title" className="text-[16px] font-bold text-foreground mb-1">
        5 best AI tools, every Tuesday
      </p>
      <p className="text-[13px] text-muted-foreground mb-3">
        Hand-picked by the editorial team. No spam, unsubscribe anytime.
      </p>
      <NewsletterForm />
    </div>
  )
}
