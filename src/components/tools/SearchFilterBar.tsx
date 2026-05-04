'use client'

import { useRouter, useSearchParams } from 'next/navigation'
import { useEffect, useState } from 'react'
import { useTranslations } from 'next-intl'

const CATEGORIES = [
  { slug: 'ai-assistants',        name: 'AI Assistants' },
  { slug: 'writing-ai',           name: 'Writing' },
  { slug: 'image-ai',             name: 'Image AI' },
  { slug: 'image-generation',     name: 'Image Gen' },
  { slug: 'video-ai',             name: 'Video AI' },
  { slug: 'video-generation',     name: 'Video Gen' },
  { slug: 'code-ai',              name: 'Code AI' },
  { slug: 'design',               name: 'Design' },
  { slug: 'voice-audio',          name: 'Voice & Audio' },
  { slug: 'audio-ai',             name: 'Audio AI' },
  { slug: 'ai-agent',             name: 'AI Agents' },
  { slug: 'machine-learning',     name: 'Machine Learning' },
  { slug: 'seo-marketing',        name: 'SEO & Marketing' },
  { slug: 'marketing',            name: 'Marketing' },
  { slug: 'content',              name: 'Content' },
  { slug: 'email-marketing',      name: 'Email Marketing' },
  { slug: 'social-media',         name: 'Social Media' },
  { slug: 'sales',                name: 'Sales' },
  { slug: 'crm',                  name: 'CRM' },
  { slug: 'productivity',         name: 'Productivity' },
  { slug: 'automation',           name: 'Automation' },
  { slug: 'project-management',   name: 'Project Mgmt' },
  { slug: 'scheduling',           name: 'Scheduling' },
  { slug: 'team-collaboration',   name: 'Collaboration' },
  { slug: 'analytics',            name: 'Analytics' },
  { slug: 'data-analysis',        name: 'Data Analysis' },
  { slug: 'business-intelligence',name: 'Business Intel' },
  { slug: 'developer-tools',      name: 'Dev Tools' },
  { slug: 'no-code',              name: 'No-Code' },
  { slug: 'databases',            name: 'Databases' },
  { slug: 'spreadsheets',         name: 'Spreadsheets' },
  { slug: 'open-source',          name: 'Open Source' },
  { slug: 'security',             name: 'Security' },
  { slug: 'customer-support',     name: 'Customer Support' },
  { slug: 'operations',           name: 'Operations' },
  { slug: 'research',             name: 'Research' },
  { slug: 'podcasting',           name: 'Podcasting' },
  { slug: 'education',            name: 'Education' },
  { slug: 'healthcare',           name: 'Healthcare' },
  { slug: 'legal-ai',             name: 'Legal AI' },
]

const PRICING_VALUES = ['', 'free', 'freemium', 'paid', 'ltd'] as const
const SORT_VALUES = ['', 'newest', 'name'] as const
const MIN_RATING_VALUES = ['', '4', '4.5'] as const

const BUDGET_OPTIONS: { value: string; label: string }[] = [
  { value: '',         label: 'Any budget' },
  { value: 'free',     label: 'Free / $0' },
  { value: 'lt25',     label: 'Under $25 / mo' },
  { value: 'lt100',    label: 'Under $100 / mo' },
  { value: 'lt500',    label: 'Under $500 / mo' },
]

const INTEGRATION_CHOICES = [
  { value: 'slack',          label: 'Slack' },
  { value: 'zapier',         label: 'Zapier' },
  { value: 'notion',         label: 'Notion' },
  { value: 'google',         label: 'Google Workspace' },
  { value: 'github',         label: 'GitHub' },
  { value: 'hubspot',        label: 'HubSpot' },
]

const SELECT_CLS =
  'h-9 px-3 rounded-lg border border-border bg-surface text-[13px] text-foreground focus:outline-none focus:border-blue-400 cursor-pointer transition-colors'

interface SearchFilterBarProps {
  basePath: string
  showCategory?: boolean
  showPricing?: boolean
  showSort?: boolean
  showMinRating?: boolean
  showBudget?: boolean
  showFreeTier?: boolean
  showIntegrations?: boolean
  searchPlaceholder?: string
}

export default function SearchFilterBar({
  basePath,
  showCategory,
  showPricing,
  showSort,
  showMinRating,
  showBudget,
  showFreeTier,
  showIntegrations,
  searchPlaceholder,
}: SearchFilterBarProps) {
  const router = useRouter()
  const params = useSearchParams()
  const t = useTranslations('SearchFilter')
  const tBadge = useTranslations('PricingBadge')

  const PRICING_OPTIONS = PRICING_VALUES.map(v => ({
    value: v,
    label: v === '' ? t('allPricing') : tBadge(v),
  }))
  const SORT_OPTIONS: { value: string; label: string }[] = [
    { value: '', label: t('topRated') },
    { value: 'newest', label: t('newest') },
    { value: 'name', label: t('nameAZ') },
  ]
  const MIN_RATING_OPTIONS: { value: string; label: string }[] = [
    { value: '', label: t('allRatings') },
    { value: '4', label: t('rating4plus') },
    { value: '4.5', label: t('rating45plus') },
  ]
  // Keep deps reference but mark unused intentionally
  void SORT_VALUES; void MIN_RATING_VALUES

  const activeCategory  = params.get('category')   ?? ''
  const activePricing   = params.get('pricing')    ?? ''
  const activeSort      = params.get('sort')       ?? ''
  const activeMinRating = params.get('min_rating') ?? ''
  const activeBudget    = params.get('budget')     ?? ''
  const activeFreeTier  = params.get('free_tier')  === '1'
  const activeIntegration = params.get('integration') ?? ''
  const [search, setSearch] = useState(params.get('q') ?? '')

  const hasFilters = !!(
    search || activeCategory || activePricing || activeSort || activeMinRating
    || activeBudget || activeFreeTier || activeIntegration
  )

  useEffect(() => {
    const timer = setTimeout(() => {
      const next = new URLSearchParams(params.toString())
      if (search) next.set('q', search)
      else next.delete('q')
      next.delete('page')
      router.push(`${basePath}?${next.toString()}`)
    }, 400)
    return () => clearTimeout(timer)
  }, [search]) // eslint-disable-line react-hooks/exhaustive-deps

  function setFilter(key: string, value: string) {
    const next = new URLSearchParams(params.toString())
    if (value) next.set(key, value)
    else next.delete(key)
    next.delete('page')
    router.push(`${basePath}?${next.toString()}`)
  }

  function clearAll() {
    setSearch('')
    router.push(basePath)
  }

  return (
    <div className="flex flex-wrap items-center gap-2 p-3 mb-8 rounded-xl border border-border bg-surface shadow-sm">
      {/* Search */}
      <div className="relative flex-1 min-w-[160px]">
        <svg
          className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground"
          width="14" height="14" viewBox="0 0 24 24" fill="none"
          stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"
        >
          <circle cx="11" cy="11" r="8" /><path d="m21 21-4.35-4.35" />
        </svg>
        <input
          type="search"
          value={search}
          onChange={e => setSearch(e.target.value)}
          placeholder={searchPlaceholder ?? t('search')}
          className="w-full h-9 pl-8 pr-3 rounded-lg border border-border bg-transparent text-[13px] text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-blue-400 focus:ring-1 focus:ring-blue-400 transition-colors"
        />
      </div>

      {/* Divider */}
      {(showCategory || showPricing || showSort || showMinRating || showBudget || showFreeTier || showIntegrations) && (
        <div className="hidden sm:block w-px h-6 bg-border" />
      )}

      {/* Category */}
      {showCategory && (
        <select
          value={activeCategory}
          onChange={e => setFilter('category', e.target.value)}
          className={SELECT_CLS}
        >
          <option value="">{t('allCategories')}</option>
          {CATEGORIES.map(c => (
            <option key={c.slug} value={c.slug}>{c.name}</option>
          ))}
        </select>
      )}

      {/* Pricing */}
      {showPricing && (
        <select
          value={activePricing}
          onChange={e => setFilter('pricing', e.target.value)}
          className={SELECT_CLS}
        >
          {PRICING_OPTIONS.map(p => (
            <option key={p.value} value={p.value}>{p.label}</option>
          ))}
        </select>
      )}

      {/* Sort */}
      {showSort && (
        <select
          value={activeSort}
          onChange={e => setFilter('sort', e.target.value)}
          className={SELECT_CLS}
        >
          {SORT_OPTIONS.map(o => (
            <option key={o.value} value={o.value}>{o.label}</option>
          ))}
        </select>
      )}

      {/* Min Rating */}
      {showMinRating && (
        <select
          value={activeMinRating}
          onChange={e => setFilter('min_rating', e.target.value)}
          className={SELECT_CLS}
        >
          {MIN_RATING_OPTIONS.map(o => (
            <option key={o.value} value={o.value}>{o.label}</option>
          ))}
        </select>
      )}

      {/* Budget */}
      {showBudget && (
        <select
          value={activeBudget}
          onChange={e => setFilter('budget', e.target.value)}
          className={SELECT_CLS}
          aria-label="Budget"
        >
          {BUDGET_OPTIONS.map(o => (
            <option key={o.value} value={o.value}>{o.label}</option>
          ))}
        </select>
      )}

      {/* Integrations */}
      {showIntegrations && (
        <select
          value={activeIntegration}
          onChange={e => setFilter('integration', e.target.value)}
          className={SELECT_CLS}
          aria-label="Works with"
        >
          <option value="">Any integration</option>
          {INTEGRATION_CHOICES.map(o => (
            <option key={o.value} value={o.value}>Works with {o.label}</option>
          ))}
        </select>
      )}

      {/* Free tier toggle */}
      {showFreeTier && (
        <button
          type="button"
          onClick={() => setFilter('free_tier', activeFreeTier ? '' : '1')}
          aria-pressed={activeFreeTier}
          className={`h-9 px-3 rounded-lg border text-[13px] font-medium transition-colors ${
            activeFreeTier
              ? 'border-emerald-300 bg-emerald-50 text-emerald-700 dark:bg-emerald-950/30 dark:text-emerald-300'
              : 'border-border bg-surface text-muted-foreground hover:border-emerald-300 hover:text-emerald-600'
          }`}
        >
          {activeFreeTier ? '✓ Free tier only' : 'Free tier only'}
        </button>
      )}

      {/* Clear */}
      {hasFilters && (
        <button
          onClick={clearAll}
          aria-label={t('clearFilters')}
          className="flex items-center justify-center w-8 h-8 rounded-lg border border-border text-muted-foreground hover:border-red-300 hover:text-red-500 transition-colors"
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
