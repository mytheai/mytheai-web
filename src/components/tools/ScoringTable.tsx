import Link from 'next/link'
import { SCORING_CRITERIA, computeWeightedScore, type ToolScores } from '@/lib/scoring'

interface Props {
  scores: ToolScores
  toolName: string
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

export default function ScoringTable({ scores, toolName }: Props) {
  const overall = computeWeightedScore(scores)

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

      <div className="border border-border rounded-xl overflow-hidden">
        <div className="grid grid-cols-[1fr_60px_160px] gap-0 bg-card border-b border-border">
          <div className="px-4 py-3 text-[11px] font-bold uppercase tracking-wide text-muted-foreground">Criterion</div>
          <div className="px-4 py-3 text-[11px] font-bold uppercase tracking-wide text-muted-foreground text-center border-l border-border">Weight</div>
          <div className="px-4 py-3 text-[11px] font-bold uppercase tracking-wide text-muted-foreground text-center border-l border-border">Score</div>
        </div>
        {SCORING_CRITERIA.map((c, i) => (
          <div key={c.key} className={`grid grid-cols-[1fr_60px_160px] gap-0 ${i % 2 === 0 ? 'bg-background' : 'bg-card'}`}>
            <div className="px-4 py-3 border-b border-border">
              <p className="text-[13px] font-semibold text-foreground">{c.label}</p>
              <p className="text-[12px] text-muted-foreground mt-0.5 leading-snug">{c.description}</p>
            </div>
            <div className="px-4 py-3 border-b border-l border-border text-center text-[13px] font-semibold text-foreground self-center">
              {c.weight}%
            </div>
            <div className="px-4 py-3 border-b border-l border-border self-center">
              <ScoreBar score={scores[c.key]} />
            </div>
          </div>
        ))}
        <div className="grid grid-cols-[1fr_60px_160px] gap-0 bg-card">
          <div className="px-4 py-3 text-[14px] font-extrabold text-foreground">Overall editorial score</div>
          <div className="px-4 py-3 text-[12px] text-muted-foreground text-center border-l border-border self-center">100%</div>
          <div className="px-4 py-3 border-l border-border text-center text-[18px] font-extrabold text-blue-600 self-center">
            {overall.toFixed(2)}/5
          </div>
        </div>
      </div>

      <p className="text-[11px] text-muted-foreground mt-3">
        Scores are editorial assessments based on hands-on testing and verified user data. They do not reflect affiliate relationships. <Link href="/methodology" className="underline hover:text-blue-600">How we score</Link>.
      </p>
    </section>
  )
}
