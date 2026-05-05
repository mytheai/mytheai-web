import Link from 'next/link'
import { computeWeightedScore, type ToolScores, type ToolScoresEvidence } from '@/lib/scoring'

interface Props {
  externalRating: number
  externalReviewCount: number
  scores: ToolScores | null
  evidence: ToolScoresEvidence | null
  userReviewCount: number
  pricingVerifiedDate: string
  toolSlug: string
}

function formatExternalCount(n: number): string {
  if (n >= 10000) return `${(n / 1000).toFixed(0)}k`
  if (n >= 1000) return `${(n / 1000).toFixed(1)}k`
  return n.toLocaleString()
}

function MiniBar({ value, max = 5 }: { value: number; max?: number }) {
  const pct = Math.max(0, Math.min(100, (value / max) * 100))
  return (
    <div className="flex-1 h-1 rounded-full bg-border overflow-hidden">
      <div className="h-full rounded-full bg-blue-500" style={{ width: `${pct}%` }} />
    </div>
  )
}

export default function TrustStack({
  externalRating,
  externalReviewCount,
  scores,
  evidence,
  userReviewCount,
  pricingVerifiedDate,
  toolSlug,
}: Props) {
  const editorialScore = scores ? computeWeightedScore(scores) : 0
  const totalEvidence = evidence
    ? Object.values(evidence).reduce((sum, list) => sum + (list?.length ?? 0), 0)
    : 0

  return (
    <div className="border border-border rounded-xl p-5 bg-card">
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-[14px] font-bold text-foreground">Trust Stack</h3>
        <Link href="/methodology" className="text-[11px] text-blue-600 hover:underline font-medium whitespace-nowrap">
          How we rank →
        </Link>
      </div>

      <div className="space-y-4">
        {/* Editorial Score */}
        <div>
          <div className="flex items-baseline justify-between mb-1">
            <p className="text-[10px] font-bold uppercase tracking-[0.08em] text-muted-foreground">Editorial Score</p>
            <span className="text-[15px] font-extrabold text-foreground">
              {editorialScore > 0 ? editorialScore.toFixed(1) : '-'}
              <span className="text-[11px] font-normal text-muted-foreground ml-0.5">/5</span>
            </span>
          </div>
          {editorialScore > 0 ? <MiniBar value={editorialScore} /> : <div className="h-1 rounded-full bg-border" />}
          <p className="text-[11px] text-muted-foreground mt-1.5 leading-relaxed">
            {editorialScore > 0
              ? <>Hands-on testing across 7 criteria{totalEvidence > 0 && <> · {totalEvidence} evidence link{totalEvidence > 1 ? 's' : ''}</>}</>
              : <>Editorial review pending</>
            }
          </p>
        </div>

        {/* External Aggregate */}
        <div>
          <div className="flex items-baseline justify-between mb-1">
            <p className="text-[10px] font-bold uppercase tracking-[0.08em] text-muted-foreground">External Aggregate</p>
            <span className="text-[15px] font-extrabold text-foreground">
              {externalRating > 0 ? externalRating.toFixed(1) : '-'}
              <span className="text-[11px] font-normal text-muted-foreground ml-0.5">/5</span>
            </span>
          </div>
          {externalRating > 0 ? <MiniBar value={externalRating} /> : <div className="h-1 rounded-full bg-border" />}
          <p className="text-[11px] text-muted-foreground mt-1.5 leading-relaxed">
            {externalReviewCount > 0
              ? <>{externalReviewCount.toLocaleString()} aggregate ratings from G2, Capterra, Product Hunt</>
              : <>No aggregate signal yet</>
            }
          </p>
        </div>

        {/* User Reviews on MytheAi */}
        <div>
          <div className="flex items-baseline justify-between mb-1">
            <p className="text-[10px] font-bold uppercase tracking-[0.08em] text-muted-foreground">User Reviews on MytheAi</p>
            <span className="text-[15px] font-extrabold text-foreground">
              {userReviewCount}
            </span>
          </div>
          <div className="h-1 rounded-full bg-border" />
          <p className="text-[11px] text-muted-foreground mt-1.5 leading-relaxed">
            {userReviewCount === 0
              ? externalReviewCount > 0
                ? <>While reviews build here, see <Link href="/methodology" className="text-blue-600 hover:underline">{formatExternalCount(externalReviewCount)} aggregate ratings</Link> from G2, Capterra, Product Hunt above. <a href="#review-form" className="text-blue-600 hover:underline">Add yours →</a></>
                : <a href="#review-form" className="text-blue-600 hover:underline">Share your experience - reviews appear instantly →</a>
              : <>From verified MytheAi readers</>
            }
          </p>
        </div>

        {/* Pricing Verified */}
        <div>
          <div className="flex items-baseline justify-between mb-1">
            <p className="text-[10px] font-bold uppercase tracking-[0.08em] text-muted-foreground">Pricing Verified</p>
            <span className="text-[13px] font-bold text-foreground whitespace-nowrap">
              {pricingVerifiedDate}
            </span>
          </div>
          <div className="h-1 rounded-full bg-emerald-500/30">
            <div className="h-full rounded-full bg-emerald-500" style={{ width: '100%' }} />
          </div>
          <p className="text-[11px] text-muted-foreground mt-1.5 leading-relaxed">
            Re-verified against the official site every 90 days
          </p>
        </div>
      </div>

      <div className="mt-4 pt-4 border-t border-border">
        <p className="text-[10px] text-muted-foreground leading-relaxed">
          Editorial score is independent of External Aggregate. User reviews appear separately below.
        </p>
      </div>
    </div>
  )
}
