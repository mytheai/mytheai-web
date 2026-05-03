import Link from 'next/link'
import {
  SCORING_CRITERIA,
  computeWeightedScore,
  isInternalRef,
  EVIDENCE_TYPE_LABELS,
  type ToolScores,
  type ToolScoresEvidence,
  type ScoreEvidence,
} from '@/lib/scoring'

interface Props {
  scores: ToolScores
  toolName: string
  evidence?: ToolScoresEvidence | null
}

function EvidenceRow({ items }: { items: ScoreEvidence[] }) {
  if (!items || items.length === 0) return null
  return (
    <div className="mt-2 flex flex-wrap items-center gap-x-2 gap-y-1 text-[11px]">
      <span className="font-bold uppercase tracking-[0.06em] text-muted-foreground">Evidence:</span>
      {items.map((e, idx) => {
        const isInternal = isInternalRef(e.url)
        const typeLabel = EVIDENCE_TYPE_LABELS[e.type]
        const content = (
          <>
            <span className="font-semibold opacity-70 mr-1">[{typeLabel}]</span>
            {e.label}
          </>
        )
        return (
          <span key={idx} className="inline-flex items-center">
            {idx > 0 && <span className="text-muted-foreground mr-2">·</span>}
            {isInternal ? (
              <span className="text-muted-foreground italic" title={e.url}>{content}</span>
            ) : (
              <a
                href={e.url}
                target="_blank"
                rel="noopener noreferrer"
                className="text-blue-600 hover:underline"
              >
                {content}
              </a>
            )}
          </span>
        )
      })}
    </div>
  )
}

function ScoreBar({ score }: { score: number }) {
  const pct = (score / 5) * 100
  return (
    <div className="flex items-center gap-2">
      <div className="flex-1 h-1.5 rounded-full bg-border overflow-hidden">
        <div className="h-full rounded-full bg-blue-500" style={{ width: `${pct}%` }} />
      </div>
      <span className="text-[13px] font-semibold text-foreground w-4 text-right">{score}</span>
    </div>
  )
}

export default function ScoringTable({ scores, toolName, evidence }: Props) {
  const overall = computeWeightedScore(scores)
  const totalEvidence = evidence
    ? Object.values(evidence).reduce((sum, list) => sum + (list?.length ?? 0), 0)
    : 0

  // Evidence breakdown by type for the prominence banner
  const typeCounts: Partial<Record<keyof typeof EVIDENCE_TYPE_LABELS, number>> = {}
  if (evidence) {
    for (const list of Object.values(evidence)) {
      for (const e of list ?? []) {
        typeCounts[e.type] = (typeCounts[e.type] ?? 0) + 1
      }
    }
  }
  const typeSummary = Object.entries(typeCounts)
    .sort((a, b) => (b[1] as number) - (a[1] as number))
    .map(([type, count]) => `${count} ${EVIDENCE_TYPE_LABELS[type as keyof typeof EVIDENCE_TYPE_LABELS].toLowerCase()}${(count as number) > 1 ? 's' : ''}`)

  return (
    <section className="mt-12 pt-8 border-t border-border">
      <div className="flex items-end justify-between mb-4">
        <div>
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Editorial Scoring</p>
          <h2 className="text-[18px] font-bold text-foreground">How {toolName} scores on our 7-criteria framework</h2>
        </div>
        <Link href="/methodology" className="text-[13px] text-blue-600 font-medium hover:underline whitespace-nowrap">
          See methodology →
        </Link>
      </div>

      {totalEvidence > 0 && (
        <div className="mb-4 flex flex-wrap items-center gap-2 px-4 py-3 rounded-xl border border-blue-100 dark:border-blue-900/40 bg-blue-50/60 dark:bg-blue-950/20">
          <span className="text-[13px] font-bold text-blue-700 dark:text-blue-300">
            ✓ Backed by {totalEvidence} external source{totalEvidence > 1 ? 's' : ''}
          </span>
          {typeSummary.length > 0 && (
            <span className="text-[12px] text-muted-foreground">
              ({typeSummary.join(' · ')})
            </span>
          )}
        </div>
      )}

      <div className="border border-border rounded-xl overflow-hidden">
        <div className="grid grid-cols-[1fr_60px_160px] gap-0 bg-card border-b border-border">
          <div className="px-4 py-3 text-[11px] font-bold uppercase tracking-wide text-muted-foreground">Criterion</div>
          <div className="px-4 py-3 text-[11px] font-bold uppercase tracking-wide text-muted-foreground text-center border-l border-border">Weight</div>
          <div className="px-4 py-3 text-[11px] font-bold uppercase tracking-wide text-muted-foreground text-center border-l border-border">Score</div>
        </div>
        {SCORING_CRITERIA.map((c, i) => {
          const items = evidence?.[c.key] ?? []
          return (
            <div key={c.key} className={`grid grid-cols-[1fr_60px_160px] gap-0 ${i % 2 === 0 ? 'bg-background' : 'bg-card'}`}>
              <div className="px-4 py-3 border-b border-border">
                <p className="text-[13px] font-semibold text-foreground">{c.label}</p>
                <p className="text-[12px] text-muted-foreground mt-0.5 leading-snug">{c.description}</p>
                <EvidenceRow items={items} />
              </div>
              <div className="px-4 py-3 border-b border-l border-border text-center text-[13px] font-semibold text-foreground self-center">
                {c.weight}%
              </div>
              <div className="px-4 py-3 border-b border-l border-border self-center">
                <ScoreBar score={scores[c.key]} />
              </div>
            </div>
          )
        })}
        <div className="grid grid-cols-[1fr_60px_160px] gap-0 bg-card">
          <div className="px-4 py-3 text-[14px] font-extrabold text-foreground">Overall editorial score</div>
          <div className="px-4 py-3 text-[12px] text-muted-foreground text-center border-l border-border self-center">100%</div>
          <div className="px-4 py-3 border-l border-border text-center text-[18px] font-extrabold text-blue-600 self-center">
            {overall.toFixed(2)}/5
          </div>
        </div>
      </div>

      <p className="text-[11px] text-muted-foreground mt-3">
        Scores are editorial assessments based on hands-on testing and verified user data. They do not reflect affiliate relationships.
        {totalEvidence > 0 && <> {totalEvidence} sources cited above.</>}
        {' '}<Link href="/methodology" className="underline hover:text-blue-600">How we score</Link>.
      </p>
    </section>
  )
}
