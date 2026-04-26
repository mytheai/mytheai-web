import Link from 'next/link'
import Image from 'next/image'
import type { Tool } from '@/types'

function PricingBadge({ type }: { type: Tool['pricing_type'] }) {
  const map = {
    free:     'bg-[#D1FAE5] text-[#065F46]',
    freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
    paid:     'bg-[#F3F4F6] text-[#374151]',
    ltd:      'bg-[#FEF3C7] text-[#92400E]',
  }
  const labels = { free: 'Free', freemium: 'Freemium', paid: 'Paid', ltd: 'LTD' }
  return (
    <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${map[type]}`}>
      {labels[type]}
    </span>
  )
}

function getLogoSrc(tool: Tool): string | null {
  if (tool.logo_url) return tool.logo_url
  if (tool.website_url) {
    try {
      const hostname = new URL(tool.website_url).hostname
      return `https://www.google.com/s2/favicons?domain=${hostname}&sz=64`
    } catch {
      return null
    }
  }
  return null
}

export default function ToolCard({ tool }: { tool: Tool }) {
  const logoSrc = getLogoSrc(tool)
  return (
    <div className="relative bg-card border border-border rounded-xl p-5 transition-all duration-150 hover:-translate-y-0.5 hover:shadow-xl hover:border-blue-300">
      {/* Header row */}
      <div className="flex items-start justify-between mb-4">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-[10px] bg-gray-50 flex items-center justify-center flex-shrink-0 overflow-hidden">
            {logoSrc ? (
              <Image
                src={logoSrc}
                alt={tool.name}
                width={40}
                height={40}
                className="object-contain p-1"
                unoptimized
              />
            ) : (
              <span className="text-[14px] font-bold text-gray-400">{tool.name.charAt(0).toUpperCase()}</span>
            )}
          </div>
          <div>
            <div className="text-[14px] font-semibold text-foreground">{tool.name}</div>
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
        <Link
          href={`/go/${tool.slug}`}
          target="_blank"
          rel="noopener noreferrer sponsored"
          className="relative z-10 text-[12px] font-semibold text-blue-600 hover:text-blue-700"
        >
          Visit →
        </Link>
      </div>
    </div>
  )
}
