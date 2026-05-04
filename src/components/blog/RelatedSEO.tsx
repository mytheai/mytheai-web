import Link from 'next/link'
import { FREE_CATEGORY_LABELS, type RelatedSEOTarget } from '@/lib/related-seo'

interface Props {
  target: RelatedSEOTarget | null
}

export default function RelatedSEO({ target }: Props) {
  if (!target) return null

  const freeLabel = FREE_CATEGORY_LABELS[target.freeCategory] ?? 'Free AI tools'

  return (
    <div className="mt-10 grid gap-4 sm:grid-cols-2">
      <Link
        href={`/alternatives/${target.topTool}`}
        className="group block p-5 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors"
      >
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">
          Looking for alternatives?
        </p>
        <p className="text-[15px] font-bold text-foreground mb-1 leading-snug">
          {target.topToolLabel} alternatives compared
        </p>
        <p className="text-[12px] text-muted-foreground mb-2">
          See 8 hand-picked alternatives with rating, pricing, and free-tier comparison.
        </p>
        <p className="text-[12px] font-semibold text-blue-600 group-hover:underline">
          See alternatives →
        </p>
      </Link>

      <Link
        href={`/free-ai-tools/${target.freeCategory}`}
        className="group block p-5 rounded-xl border border-border bg-card hover:border-emerald-300 transition-colors"
      >
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-emerald-600 mb-1">
          Want free options?
        </p>
        <p className="text-[15px] font-bold text-foreground mb-1 leading-snug">
          Best free {freeLabel} tools in 2026
        </p>
        <p className="text-[12px] text-muted-foreground mb-2">
          Curated free tiers with no credit card required, ranked by output quality.
        </p>
        <p className="text-[12px] font-semibold text-emerald-600 group-hover:underline">
          Browse free tools →
        </p>
      </Link>
    </div>
  )
}
