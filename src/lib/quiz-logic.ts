// Quiz answer model + scoring rules.
// 5 questions, ~5 picks per result. Pure rules, no ML.
// Result encoded in a single URL param so result pages are share-able.

export type Role =
  | 'writing'
  | 'coding'
  | 'design'
  | 'marketing'
  | 'sales'
  | 'research'
  | 'other'

export type Skill = 'beginner' | 'intermediate' | 'power'

export type Budget = 'free' | 'low' | 'mid' | 'unlimited'

export type TeamSize = 'solo' | 'small' | 'large'

export interface QuizAnswers {
  role: Role
  useCase: string
  skill: Skill
  budget: Budget
  team: TeamSize
}

// Tag pool used to filter the Supabase tools table. Values match the
// `tags` text[] column on the tools rows.
export const ROLE_TAGS: Record<Role, string[]> = {
  writing: ['writing-ai', 'seo-marketing', 'productivity'],
  coding: ['code-ai', 'productivity', 'automation'],
  design: ['image-ai', 'video-ai'],
  marketing: ['seo-marketing', 'writing-ai', 'email-marketing', 'analytics'],
  sales: ['crm-sales', 'productivity', 'automation'],
  research: ['ai-assistants', 'productivity', 'analytics'],
  other: ['ai-assistants', 'productivity'],
}

// Per-role use cases shown for question 4. Each maps to extra tags or
// to the same role tags - kept loose so we don't over-narrow the pool.
export const USE_CASES: Record<Role, { value: string; label: string; extraTags?: string[] }[]> = {
  writing: [
    { value: 'long-form', label: 'Long-form blogs and articles', extraTags: ['seo-marketing'] },
    { value: 'marketing', label: 'Marketing and ad copy', extraTags: ['seo-marketing'] },
    { value: 'email', label: 'Email and outreach', extraTags: ['email-marketing'] },
    { value: 'editing', label: 'Editing and grammar polish' },
  ],
  coding: [
    { value: 'autocomplete', label: 'Daily autocomplete and editor AI' },
    { value: 'agent', label: 'Agent mode and multi-file edits' },
    { value: 'review', label: 'Code review and PR help' },
    { value: 'apps', label: 'Build full apps from prompts', extraTags: ['automation'] },
  ],
  design: [
    { value: 'images', label: 'Image generation and editing', extraTags: ['image-ai'] },
    { value: 'video', label: 'Video generation and editing', extraTags: ['video-ai'] },
    { value: 'avatars', label: 'AI avatars and talking heads', extraTags: ['video-ai'] },
    { value: 'brand', label: 'Branding and presentations' },
  ],
  marketing: [
    { value: 'seo', label: 'SEO and organic traffic', extraTags: ['seo-marketing'] },
    { value: 'social', label: 'Social media and content', extraTags: ['writing-ai'] },
    { value: 'email', label: 'Email campaigns', extraTags: ['email-marketing'] },
    { value: 'analytics', label: 'Analytics and reporting', extraTags: ['analytics'] },
  ],
  sales: [
    { value: 'outbound', label: 'Outbound and personalized email', extraTags: ['email-marketing'] },
    { value: 'crm', label: 'CRM and pipeline', extraTags: ['crm-sales'] },
    { value: 'leads', label: 'Lead enrichment and scoring' },
    { value: 'meetings', label: 'Meeting notes and call AI', extraTags: ['voice-audio'] },
  ],
  research: [
    { value: 'web', label: 'Search the web with sources' },
    { value: 'docs', label: 'Read and summarize documents' },
    { value: 'data', label: 'Data analysis and SQL', extraTags: ['analytics'] },
    { value: 'reasoning', label: 'Reasoning and decision support' },
  ],
  other: [
    { value: 'general', label: 'General AI assistant' },
    { value: 'productivity', label: 'Personal productivity', extraTags: ['productivity'] },
    { value: 'meetings', label: 'Meetings and notes', extraTags: ['voice-audio'] },
    { value: 'automation', label: 'Workflow automation', extraTags: ['automation'] },
  ],
}

export function getQuizTags(answers: QuizAnswers): string[] {
  const base = ROLE_TAGS[answers.role] ?? []
  const useCase = USE_CASES[answers.role]?.find(u => u.value === answers.useCase)
  const extra = useCase?.extraTags ?? []
  return Array.from(new Set([...base, ...extra]))
}

// Translate a budget bucket into a starting-price ceiling. Null means
// no upper bound. We treat free-tier tools as always eligible because
// the rating filter still applies.
export function getBudgetCeiling(budget: Budget): number | null {
  if (budget === 'free') return 0
  if (budget === 'low') return 25
  if (budget === 'mid') return 100
  return null
}

// Encode answers into a compact URL param. Order is fixed so old links
// never break: role|useCase|skill|budget|team
export function encodeAnswers(a: QuizAnswers): string {
  return [a.role, a.useCase, a.skill, a.budget, a.team].join('-')
}

export function decodeAnswers(s: string): QuizAnswers | null {
  const [role, useCase, skill, budget, team] = s.split('-')
  if (!role || !useCase || !skill || !budget || !team) return null
  return { role, useCase, skill, budget, team } as QuizAnswers
}

export const ROLE_LABELS: Record<Role, string> = {
  writing: 'Writer / Content Creator',
  coding: 'Engineer / Developer',
  design: 'Designer / Creative',
  marketing: 'Marketer',
  sales: 'Sales / GTM',
  research: 'Researcher / Analyst',
  other: 'Other / Mixed',
}

export const SKILL_LABELS: Record<Skill, string> = {
  beginner: 'Beginner (just starting with AI)',
  intermediate: 'Intermediate (use AI weekly)',
  power: 'Power user (use AI daily, multiple tools)',
}

export const BUDGET_LABELS: Record<Budget, string> = {
  free: 'Free only - no credit card',
  low: 'Up to $25 / month',
  mid: 'Up to $100 / month',
  unlimited: 'Whatever the right tool costs',
}

export const TEAM_LABELS: Record<TeamSize, string> = {
  solo: 'Solo or freelancer',
  small: 'Team of 2 to 10',
  large: 'Team of 10 or more',
}
