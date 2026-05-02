// Editorial scoring system - weights match web/src/app/methodology/page.tsx
// Tools get auto-derived baseline scores via migration; editorial team can override per row.

export interface ToolScores {
  output_quality: number
  ease_of_use: number
  pricing_value: number
  feature_depth: number
  integrations: number
  reliability: number
  trajectory: number
}

export interface ScoringCriterion {
  key: keyof ToolScores
  label: string
  weight: number
  description: string
}

export const SCORING_CRITERIA: ScoringCriterion[] = [
  { key: 'output_quality', label: 'Output Quality', weight: 25, description: 'Accuracy, polish, and usefulness of what the tool produces.' },
  { key: 'ease_of_use', label: 'Ease of Use', weight: 15, description: 'Onboarding friction, UI clarity, time to first useful result.' },
  { key: 'pricing_value', label: 'Pricing Value', weight: 15, description: 'Output per dollar at the realistic monthly cost for a typical user.' },
  { key: 'feature_depth', label: 'Feature Depth', weight: 15, description: 'Breadth and maturity of capabilities relative to category leaders.' },
  { key: 'integrations', label: 'Integrations', weight: 10, description: 'Native integrations, API quality, and ecosystem coverage.' },
  { key: 'reliability', label: 'Reliability', weight: 10, description: 'Uptime, output consistency, and battle-test through scale.' },
  { key: 'trajectory', label: 'Trajectory', weight: 10, description: 'Recent product velocity and momentum vs the category.' },
]

export function computeWeightedScore(scores: ToolScores | null | undefined): number {
  if (!scores) return 0
  let sum = 0
  let totalWeight = 0
  for (const c of SCORING_CRITERIA) {
    const v = scores[c.key]
    if (typeof v === 'number') {
      sum += v * c.weight
      totalWeight += c.weight
    }
  }
  return totalWeight > 0 ? Number((sum / totalWeight).toFixed(2)) : 0
}

export function isValidScores(scores: unknown): scores is ToolScores {
  if (!scores || typeof scores !== 'object') return false
  const s = scores as Record<string, unknown>
  return SCORING_CRITERIA.every(c => typeof s[c.key] === 'number' && (s[c.key] as number) >= 1 && (s[c.key] as number) <= 5)
}
