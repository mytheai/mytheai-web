interface Props {
  slug: string
  name: string
  pricingType: 'free' | 'freemium' | 'paid' | 'ltd'
  pricingFreeTier: boolean
  startingPrice: number | null
}

const PRICING_LABELS: Record<string, string> = {
  free: 'Free',
  freemium: 'Freemium',
  paid: 'Paid',
  ltd: 'Lifetime Deal',
}

const PRICING_COLORS: Record<string, string> = {
  free: 'bg-[#D1FAE5] text-[#065F46]',
  freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
  paid: 'bg-[#F3F4F6] text-[#374151]',
  ltd: 'bg-[#FEF3C7] text-[#92400E]',
}

export default function StickyMobileCTA({ slug, name, pricingType, pricingFreeTier, startingPrice }: Props) {
  const priceLabel = pricingType === 'free'
    ? 'Free forever'
    : pricingFreeTier
    ? 'Free tier available'
    : startingPrice != null
    ? `From $${startingPrice}/mo`
    : PRICING_LABELS[pricingType]

  return (
    <div className="md:hidden fixed bottom-0 left-0 right-0 z-40 border-t border-border bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/80 px-4 py-3 flex items-center gap-3">
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2 mb-0.5">
          <span className="text-[13px] font-bold text-foreground truncate">{name}</span>
          <span className={`text-[10px] font-semibold px-1.5 py-0.5 rounded-full ${PRICING_COLORS[pricingType]}`}>
            {PRICING_LABELS[pricingType]}
          </span>
        </div>
        <p className="text-[11px] text-muted-foreground truncate">{priceLabel}</p>
      </div>
      <a
        href={`/go/${slug}`}
        target="_blank"
        rel="noopener noreferrer sponsored"
        className="inline-flex items-center justify-center px-4 py-2 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[13px] transition-colors flex-shrink-0 whitespace-nowrap"
      >
        Visit →
      </a>
    </div>
  )
}
