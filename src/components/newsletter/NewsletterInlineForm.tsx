'use client'

import { useState } from 'react'

interface Props {
  // Plausible context tag for A/B testing where this form converts best.
  context?: string
  // Compact variant for sidebar/narrow slots. Default = full-width content block.
  compact?: boolean
}

export default function NewsletterInlineForm({ context = 'inline', compact = false }: Props) {
  const [email, setEmail] = useState('')
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [message, setMessage] = useState('')

  async function submit(e: React.FormEvent) {
    e.preventDefault()
    if (status === 'loading' || status === 'success') return
    setStatus('loading')
    setMessage('')
    try {
      const res = await fetch('/api/newsletter', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email }),
      })
      const data = await res.json().catch(() => ({}))
      if (res.ok) {
        setStatus('success')
        setMessage('Subscribed. First Wednesday email arrives soon.')
        setEmail('')
        if (typeof window !== 'undefined' && typeof (window as unknown as { plausible?: (name: string, opts?: unknown) => void }).plausible === 'function') {
          (window as unknown as { plausible: (name: string, opts: { props: Record<string, string> }) => void }).plausible('NewsletterSignup', { props: { context } })
        }
      } else {
        setStatus('error')
        setMessage((data as { error?: string }).error || 'Something went wrong. Try again.')
      }
    } catch {
      setStatus('error')
      setMessage('Network error. Try again.')
    }
  }

  const containerClasses = compact
    ? 'p-4 rounded-xl border border-amber-200 dark:border-amber-900/40 bg-amber-50/50 dark:bg-amber-950/20'
    : 'mt-10 p-6 rounded-xl border-2 border-amber-200 dark:border-amber-900/40 bg-amber-50/50 dark:bg-amber-950/20'

  return (
    <div className={containerClasses} data-newsletter-context={context}>
      <div className="flex items-start gap-3 mb-3">
        <span className="text-[22px] flex-shrink-0" aria-hidden="true">📬</span>
        <div className="min-w-0 flex-1">
          <p className="text-[14.5px] font-bold text-foreground mb-0.5">
            The Wednesday 3-Pick email
          </p>
          <p className="text-[13px] text-muted-foreground">
            3 hand-tested AI tools weekly: 1 winner, 1 overhyped avoid, 1 underrated gem. 1-click unsubscribe.
          </p>
        </div>
      </div>
      <form onSubmit={submit} className="flex flex-col sm:flex-row gap-2">
        <input
          type="email"
          required
          autoComplete="email"
          value={email}
          onChange={e => setEmail(e.target.value)}
          placeholder="your@email.com"
          disabled={status === 'loading' || status === 'success'}
          className="flex-1 min-w-0 px-4 py-2.5 rounded-lg border border-border bg-card text-foreground text-[14px] focus:outline-none focus:border-amber-400 disabled:opacity-50"
          aria-label="Email address"
        />
        <button
          type="submit"
          disabled={status === 'loading' || status === 'success' || !email}
          className="px-5 py-2.5 rounded-lg bg-amber-600 hover:bg-amber-700 text-white font-semibold text-[14px] transition-colors disabled:opacity-50 whitespace-nowrap flex-shrink-0"
        >
          {status === 'loading' ? 'Subscribing...' : status === 'success' ? '✓ Subscribed' : 'Subscribe free'}
        </button>
      </form>
      {message && (
        <p className={`mt-2 text-[12px] ${status === 'error' ? 'text-red-600 dark:text-red-400' : 'text-emerald-700 dark:text-emerald-400'}`}>
          {message}
        </p>
      )}
    </div>
  )
}
