'use client'

import { useState } from 'react'
import Link from 'next/link'

const CATEGORIES = [
  { value: 'ai-assistants', label: 'AI Assistants' },
  { value: 'writing-ai', label: 'Writing AI' },
  { value: 'image-ai', label: 'Image AI' },
  { value: 'video-ai', label: 'Video AI' },
  { value: 'code-ai', label: 'Code AI' },
  { value: 'seo-marketing', label: 'SEO & Marketing' },
  { value: 'productivity', label: 'Productivity' },
  { value: 'automation', label: 'Automation' },
  { value: 'voice-audio', label: 'Voice & Audio' },
  { value: 'crm-sales', label: 'CRM & Sales' },
  { value: 'analytics', label: 'Analytics' },
  { value: 'other', label: 'Other' },
]

export default function SubmitPage() {
  const [form, setForm] = useState({
    name: '', website_url: '', category: '', pricing_type: '',
    free_tier: false, submitter_email: '', hp_field: '',
  })
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [errorMsg, setErrorMsg] = useState('')

  function update(key: string, value: string | boolean) {
    setForm(f => ({ ...f, [key]: value }))
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setStatus('loading')
    try {
      const res = await fetch('/api/submit', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(form),
      })
      const data = await res.json()
      if (data.success) {
        setStatus('success')
      } else {
        setErrorMsg(data.error ?? 'Something went wrong.')
        setStatus('error')
      }
    } catch {
      setErrorMsg('Network error. Please try again.')
      setStatus('error')
    }
  }

  if (status === 'success') {
    return (
      <div className="max-w-lg mx-auto px-4 py-20 text-center">
        <div className="text-5xl mb-4">✓</div>
        <h1 className="text-[24px] font-extrabold text-foreground mb-2">Tool submitted!</h1>
        <p className="text-[15px] text-muted-foreground mb-6">
          Thanks for the suggestion. Our team reviews new submissions weekly.
        </p>
        <Link href="/tools" className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg bg-blue-600 text-white font-semibold text-[14px] hover:bg-blue-700 transition-colors">
          Browse all tools →
        </Link>
      </div>
    )
  }

  return (
    <div className="max-w-xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-8">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Community</p>
        <h1 className="text-[26px] md:text-[32px] font-extrabold tracking-tight text-foreground mb-2">
          Submit a Tool
        </h1>
        <p className="text-[14px] text-muted-foreground">
          Know a great AI or SaaS tool we&apos;re missing? Let us know and we&apos;ll review it.
        </p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-5">

        {/* Honeypot - hidden from users, bots fill it in */}
        <input
          type="text"
          name="hp_field"
          value={form.hp_field}
          onChange={e => update('hp_field', e.target.value)}
          style={{ display: 'none' }}
          tabIndex={-1}
          autoComplete="off"
        />

        {/* Tool name */}
        <div>
          <label className="block text-[13px] font-semibold text-foreground mb-1.5">
            Tool name <span className="text-red-500">*</span>
          </label>
          <input
            type="text"
            required
            value={form.name}
            onChange={e => update('name', e.target.value)}
            placeholder="e.g. Notion AI"
            className="w-full px-3 py-2.5 rounded-lg border border-border bg-card text-[14px] text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
          />
        </div>

        {/* Website URL */}
        <div>
          <label className="block text-[13px] font-semibold text-foreground mb-1.5">
            Website URL <span className="text-red-500">*</span>
          </label>
          <input
            type="url"
            required
            value={form.website_url}
            onChange={e => update('website_url', e.target.value)}
            placeholder="https://notion.so"
            className="w-full px-3 py-2.5 rounded-lg border border-border bg-card text-[14px] text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
          />
        </div>

        {/* Category + Pricing in 2 cols */}
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-[13px] font-semibold text-foreground mb-1.5">Category</label>
            <select
              value={form.category}
              onChange={e => update('category', e.target.value)}
              className="w-full px-3 py-2.5 rounded-lg border border-border bg-card text-[14px] text-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
            >
              <option value="">Select…</option>
              {CATEGORIES.map(c => (
                <option key={c.value} value={c.value}>{c.label}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-[13px] font-semibold text-foreground mb-1.5">Pricing</label>
            <select
              value={form.pricing_type}
              onChange={e => update('pricing_type', e.target.value)}
              className="w-full px-3 py-2.5 rounded-lg border border-border bg-card text-[14px] text-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
            >
              <option value="">Select…</option>
              <option value="free">Free</option>
              <option value="freemium">Freemium</option>
              <option value="paid">Paid</option>
              <option value="ltd">Lifetime Deal</option>
            </select>
          </div>
        </div>

        {/* Free tier checkbox */}
        <label className="flex items-center gap-2.5 cursor-pointer">
          <input
            type="checkbox"
            checked={form.free_tier}
            onChange={e => update('free_tier', e.target.checked)}
            className="w-4 h-4 rounded border-border accent-blue-600"
          />
          <span className="text-[13px] text-foreground">Has a free tier</span>
        </label>

        {/* Email (optional) */}
        <div>
          <label className="block text-[13px] font-semibold text-foreground mb-1.5">
            Your email <span className="text-[12px] font-normal text-muted-foreground">(optional, we&apos;ll notify you when it&apos;s added)</span>
          </label>
          <input
            type="email"
            value={form.submitter_email}
            onChange={e => update('submitter_email', e.target.value)}
            placeholder="you@example.com"
            className="w-full px-3 py-2.5 rounded-lg border border-border bg-card text-[14px] text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
          />
        </div>

        {status === 'error' && (
          <p className="text-[13px] text-red-500">{errorMsg}</p>
        )}

        <button
          type="submit"
          disabled={status === 'loading'}
          className="w-full py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 disabled:opacity-60 text-white font-semibold text-[14px] transition-colors"
        >
          {status === 'loading' ? 'Submitting…' : 'Submit tool'}
        </button>

        <p className="text-[12px] text-muted-foreground text-center">
          We review all submissions manually. Not all tools will be added.
        </p>
      </form>
    </div>
  )
}
