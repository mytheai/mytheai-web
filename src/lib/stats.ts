import { readdirSync } from 'fs'
import path from 'path'
import { createStaticClient } from './supabase'
import { TOP10_LISTS } from '@/data/top10'

export interface SiteStats {
  tools: number
  comparisons: number
  top10Lists: number
  blogArticles: number
}

export async function getSiteStats(): Promise<SiteStats> {
  const supabase = createStaticClient()
  const [tools, comparisons] = await Promise.all([
    supabase.from('tools').select('*', { count: 'exact', head: true }),
    supabase.from('comparisons').select('*', { count: 'exact', head: true }),
  ])

  const blogDir = path.join(process.cwd(), 'content', 'blog')
  const blogArticles = readdirSync(blogDir).filter(f => f.endsWith('.mdx')).length

  return {
    tools: tools.count ?? 0,
    comparisons: comparisons.count ?? 0,
    top10Lists: TOP10_LISTS.length,
    blogArticles,
  }
}
