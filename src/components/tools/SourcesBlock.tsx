import { isInternalRef, EVIDENCE_TYPE_LABELS, type ToolScoresEvidence, type ScoreEvidence } from '@/lib/scoring'

interface Props {
  evidence?: ToolScoresEvidence | null
  verifiedDate: string  // formatted, e.g. "April 2026"
}

interface FlatEvidence extends ScoreEvidence {
  hostname: string
}

function flatten(e: ToolScoresEvidence): FlatEvidence[] {
  const out: FlatEvidence[] = []
  const seen = new Set<string>()
  for (const list of Object.values(e)) {
    for (const item of list ?? []) {
      if (isInternalRef(item.url)) continue
      if (seen.has(item.url)) continue
      seen.add(item.url)
      let hostname = ''
      try {
        hostname = new URL(item.url).hostname.replace(/^www\./, '')
      } catch {
        hostname = ''
      }
      out.push({ ...item, hostname })
    }
  }
  return out
}

function hostLabel(hostname: string): string {
  if (hostname.includes('g2.com')) return 'G2'
  if (hostname.includes('capterra.com')) return 'Capterra'
  if (hostname.includes('producthunt.com')) return 'Product Hunt'
  if (hostname.includes('trustpilot.com')) return 'Trustpilot'
  if (hostname.includes('gartner.com')) return 'Gartner'
  if (hostname.includes('forrester.com')) return 'Forrester'
  if (hostname.includes('reddit.com')) return 'Reddit'
  if (hostname.includes('github.com')) return 'GitHub'
  if (hostname.includes('news.ycombinator.com')) return 'Hacker News'
  return hostname.split('.')[0].replace(/[-_]/g, ' ').replace(/\b\w/g, c => c.toUpperCase())
}

export default function SourcesBlock({ evidence, verifiedDate }: Props) {
  if (!evidence) return null
  const flat = flatten(evidence)
  if (flat.length === 0) return null

  // Group by hostname
  const byHost = new Map<string, FlatEvidence[]>()
  for (const e of flat) {
    const list = byHost.get(e.hostname) ?? []
    list.push(e)
    byHost.set(e.hostname, list)
  }
  const groups = Array.from(byHost.entries()).sort((a, b) => b[1].length - a[1].length)

  return (
    <section className="mt-12 pt-8 border-t border-border">
      <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Sources</p>
      <h2 className="text-[18px] font-bold text-foreground mb-4">
        External references ({flat.length} {flat.length === 1 ? 'source' : 'sources'})
      </h2>
      <ul className="space-y-3">
        {groups.map(([hostname, items]) => (
          <li key={hostname}>
            <p className="text-[13px] font-semibold text-foreground mb-1">
              {hostLabel(hostname)}
              <span className="text-[12px] text-muted-foreground font-normal ml-2">
                ({items.length} {items.length === 1 ? 'reference' : 'references'})
              </span>
            </p>
            <ul className="ml-4 space-y-1">
              {items.map((e, i) => (
                <li key={i} className="text-[13px] text-muted-foreground">
                  <span className="text-[10px] font-bold uppercase tracking-wider opacity-60 mr-1.5">[{EVIDENCE_TYPE_LABELS[e.type]}]</span>
                  <a href={e.url} target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">
                    {e.label}
                  </a>
                </li>
              ))}
            </ul>
          </li>
        ))}
      </ul>
      <p className="text-[12px] text-muted-foreground mt-4 italic">
        Sources last accessed {verifiedDate}. External claims are sampled, not exhaustive. We re-verify on a 90-day cadence.
      </p>
    </section>
  )
}
