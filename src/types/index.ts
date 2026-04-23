export interface Category {
  id: string
  slug: string
  name: string
  emoji: string
  tool_count: number
  description?: string
}

export interface Tool {
  id: string
  slug: string
  name: string
  tagline: string
  description: string
  logo_url: string
  website_url: string
  affiliate_url: string
  category: Category[]
  tags: string[]
  pricing_type: 'free' | 'freemium' | 'paid' | 'ltd'
  pricing_details: {
    free_tier: boolean
    starting_price?: number
    currency?: string
    billing?: 'monthly' | 'annual' | 'one-time'
  }
  rating: number
  review_count: number
  featured: boolean
  trending: boolean
  editor_pick: boolean
  launched_at?: string
  updated_at: string
  pros: string[]
  cons: string[]
  use_cases: string[]
  integrations: string[]
  alternatives: string[]
}

export interface Review {
  id: string
  tool_slug: string
  title: string
  body: string
  rating: number
  author: string
  published_at: string
  updated_at: string
  pros: string[]
  cons: string[]
  verdict: string
}

export interface ComparisonCriterion {
  name: string
  tool_a_score: number
  tool_b_score: number
  notes?: string
}

export interface Comparison {
  tool_a: string
  tool_b: string
  slug: string
  summary: string
  winner?: string
  criteria: ComparisonCriterion[]
  updated_at: string
}

export interface TrendingTool {
  rank: number
  tool: Tool
}
