'use client'

import { useState } from 'react'

interface ReviewFormProps {
  toolSlug: string
  toolName: string
}

export default function ReviewForm({ toolSlug, toolName }: ReviewFormProps) {
  const [rating, setRating] = useState(0)
  const [hover, setHover] = useState(0)
  const [bestFor, setBestFor] = useState('')
  const [limitation, setLimitation] = useState('')
  const [authorName, setAuthorName] = useState('')
  const [authorRole, setAuthorRole] = useState('')
  const [hp, setHp] = useState('')
  const [mountedAt] = useState(() => Date.now())
  const [submitting, setSubmitting] = useState(false)
  const [success, setSuccess] = useState<'approved' | 'pending' | null>(null)
  const [error, setError] = useState<string | null>(null)

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setError(null)
    if (rating < 1) { setError('Please select a star rating'); return }
    if (bestFor.length < 5) { setError('"Best for" must be at least 5 characters'); return }
    if (limitation.length < 5) { setError('"Limitation" must be at least 5 characters'); return }
    setSubmitting(true)
    try {
      const r = await fetch('/api/reviews', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          slug: toolSlug,
          rating,
          bestFor,
          limitation,
          authorName,
          authorRole,
          _hp: hp,
          _t: Date.now() - mountedAt,
        }),
      })
      const data = await r.json()
      if (!r.ok) {
        setError(data.error ?? 'Submission failed')
        setSubmitting(false)
        return
      }
      setSuccess(data.status === 'approved' ? 'approved' : 'pending')
    } catch {
      setError('Network error - try again')
      setSubmitting(false)
    }
  }

  if (success) {
    return (
      <div className="p-5 rounded-xl border border-green-200 bg-green-50 dark:border-green-900/40 dark:bg-green-950/20">
        <p className="text-[14px] font-semibold text-green-800 dark:text-green-300 mb-1">Thanks for reviewing {toolName}</p>
        <p className="text-[13px] text-green-700 dark:text-green-400">
          {success === 'approved'
            ? 'Your review is live. Refresh the page to see it in the list below.'
            : 'Your review is queued for a quick quality check and will appear here shortly.'}
        </p>
      </div>
    )
  }

  return (
    <form onSubmit={handleSubmit} className="p-5 rounded-xl border border-border bg-card">
      {/* Honeypot - bots fill all inputs; real users + screen readers skip aria-hidden + tabIndex=-1 */}
      <div aria-hidden="true" style={{ position: 'absolute', left: '-9999px', top: '-9999px', height: 0, width: 0, overflow: 'hidden' }}>
        <label>
          Website (leave blank)
          <input
            type="text"
            name="website"
            tabIndex={-1}
            autoComplete="off"
            value={hp}
            onChange={e => setHp(e.target.value)}
          />
        </label>
      </div>
      <p className="text-[15px] font-bold text-foreground mb-1">Have you used {toolName}?</p>
      <p className="text-[13px] text-muted-foreground mb-4">Share a 30-second review. No account needed.</p>

      <label className="block mb-4">
        <span className="text-[13px] font-semibold text-foreground mb-1.5 block">Your rating</span>
        <div className="flex gap-1" role="radiogroup" aria-label="Rating">
          {[1, 2, 3, 4, 5].map(n => (
            <button
              key={n}
              type="button"
              onClick={() => setRating(n)}
              onMouseEnter={() => setHover(n)}
              onMouseLeave={() => setHover(0)}
              className="text-[28px] leading-none transition-transform hover:scale-110"
              aria-label={`${n} star${n > 1 ? 's' : ''}`}
              aria-pressed={rating === n}
            >
              <span className={(hover || rating) >= n ? 'text-[#F59E0B]' : 'text-gray-300 dark:text-gray-600'}>★</span>
            </button>
          ))}
        </div>
      </label>

      <label className="block mb-4">
        <span className="text-[13px] font-semibold text-foreground mb-1.5 block">Best for: <span className="text-muted-foreground font-normal">(5-280 chars)</span></span>
        <textarea
          value={bestFor}
          onChange={e => setBestFor(e.target.value)}
          maxLength={280}
          rows={2}
          placeholder="e.g. Solo founders building MVPs in TypeScript"
          className="w-full px-3 py-2 rounded-lg border border-border bg-background text-foreground text-[14px] focus:outline-none focus:ring-2 focus:ring-blue-500"
          required
        />
      </label>

      <label className="block mb-4">
        <span className="text-[13px] font-semibold text-foreground mb-1.5 block">Limitation: <span className="text-muted-foreground font-normal">(5-280 chars)</span></span>
        <textarea
          value={limitation}
          onChange={e => setLimitation(e.target.value)}
          maxLength={280}
          rows={2}
          placeholder="e.g. Pricing scales fast for teams larger than 5"
          className="w-full px-3 py-2 rounded-lg border border-border bg-background text-foreground text-[14px] focus:outline-none focus:ring-2 focus:ring-blue-500"
          required
        />
      </label>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-4">
        <label className="block">
          <span className="text-[12px] text-muted-foreground mb-1 block">Your name (optional)</span>
          <input
            type="text"
            value={authorName}
            onChange={e => setAuthorName(e.target.value)}
            maxLength={60}
            placeholder="Anonymous"
            className="w-full px-3 py-2 rounded-lg border border-border bg-background text-foreground text-[13px] focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </label>
        <label className="block">
          <span className="text-[12px] text-muted-foreground mb-1 block">Your role (optional)</span>
          <input
            type="text"
            value={authorRole}
            onChange={e => setAuthorRole(e.target.value)}
            maxLength={60}
            placeholder="e.g. Marketing Manager"
            className="w-full px-3 py-2 rounded-lg border border-border bg-background text-foreground text-[13px] focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </label>
      </div>

      {error && <p className="text-[13px] text-red-600 mb-3" role="alert">{error}</p>}

      <button
        type="submit"
        disabled={submitting}
        className="px-4 py-2 rounded-lg bg-blue-600 hover:bg-blue-700 disabled:opacity-50 text-white font-semibold text-[14px] transition-colors"
      >
        {submitting ? 'Submitting...' : 'Submit Review'}
      </button>
      <p className="text-[11px] text-muted-foreground mt-3">
        Reviews are moderated to keep quality high. No personal data is stored. By submitting you agree your review may be displayed publicly.
      </p>
    </form>
  )
}
