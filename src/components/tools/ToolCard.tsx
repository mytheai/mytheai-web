import Link from 'next/link'
import { useTranslations } from 'next-intl'
import LogoImage from '@/components/ui/LogoImage'
import type { Tool } from '@/types'

function PricingBadge({ type }: { type: Tool['pricing_type'] }) {
  const t = useTranslations('PricingBadge')
  const map = {
    free:     'bg-[#D1FAE5] text-[#065F46]',
    freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
    paid:     'bg-[#F3F4F6] text-[#374151]',
    ltd:      'bg-[#FEF3C7] text-[#92400E]',
  }
  return (
    <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${map[type]}`}>
      {t(type)}
    </span>
  )
}

function isRecentlyVerified(updatedAt: string | undefined): boolean {
  if (!updatedAt) return false
  const updated = new Date(updatedAt).getTime()
  if (Number.isNaN(updated)) return false
  const ageDays = (Date.now() - updated) / (1000 * 60 * 60 * 24)
  return ageDays <= 30
}

export default function ToolCard({ tool }: { tool: Tool }) {
  const t = useTranslations('Common')
  const recentlyVerified = isRecentlyVerified(tool.updated_at)
  return (
    <div className="relative bg-card border border-border rounded-xl p-5 transition-all duration-150 hover:-translate-y-0.5 hover:shadow-xl hover:border-blue-300">
      {/* Header row */}
      <div className="flex items-start justify-between mb-4">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-[10px] bg-gray-50 flex items-center justify-center flex-shrink-0 overflow-hidden">
            <LogoImage
              src={tool.logo_url}
              websiteUrl={tool.website_url}
              name={tool.name}
              size={40}
              className="object-contain p-1"
            />
          </div>
          <div>
            <div className="flex items-center gap-1.5 flex-wrap">
              <span className="text-[14px] font-semibold text-foreground">{tool.name}</span>
              {recentlyVerified && (
                <span
                  title="Re-verified by editorial within the last 30 days"
                  className="inline-flex items-center gap-0.5 text-[9px] font-bold uppercase tracking-wide px-1.5 py-0.5 rounded-full bg-emerald-50 dark:bg-emerald-950/40 text-emerald-700 dark:text-emerald-400 border border-emerald-200 dark:border-emerald-900"
                >
                  ✓ Verified
                </span>
              )}
            </div>
            <div className="text-[12px] text-muted-foreground">{tool.category[0]?.name}</div>
          </div>
        </div>
        <PricingBadge type={tool.pricing_type} />
      </div>

      {/* Description */}
      <p className="text-[13px] text-muted-foreground leading-relaxed mb-4 line-clamp-2">
        {tool.tagline}
      </p>

      {/* Clickable overlay → tool detail page */}
      <Link href={`/tools/${tool.slug}`} className="absolute inset-0 rounded-xl" aria-label={`View ${tool.name} details`} />

      {/* Footer row */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-1.5">
          <span className="text-[#F59E0B] text-sm">{'★'.repeat(Math.floor(tool.rating))}{'☆'.repeat(5 - Math.floor(tool.rating))}</span>
          <span className="text-[13px] font-semibold text-foreground">{tool.rating}</span>
          <span className="text-[12px] text-muted-foreground">({(tool.review_count / 1000).toFixed(1)}k)</span>
        </div>
        <a
          href={`/go/${tool.slug}`}
          target="_blank"
          rel="noopener noreferrer sponsored"
          className="relative z-10 text-[12px] font-semibold text-blue-600 hover:text-blue-700"
        >
          {t('visit')} →
        </a>
      </div>
    </div>
  )
}
