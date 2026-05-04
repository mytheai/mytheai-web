import { createStaticClient } from './supabase'

export interface SiteStats {
  tools: number
  comparisons: number
}

export async function getSiteStats(): Promise<SiteStats> {
  const supabase = createStaticClient()
  const [tools, comparisons] = await Promise.all([
    supabase.from('tools').select('*', { count: 'exact', head: true }),
    supabase.from('comparisons').select('*', { count: 'exact', head: true }),
  ])
  return {
    tools: tools.count ?? 0,
    comparisons: comparisons.count ?? 0,
  }
}
