import { readdirSync } from 'fs'
import path from 'path'
import { createStaticClient } from './supabase'
import { TOP10_LISTS } from '@/data/top10'

export interface SiteStats {
  tools: number
  comparisons: number
  top10Lists: number
  blogArticles: number
  tasks: number
}

// Display constants for static metadata exports (cannot resolve async data at build time).
// Update once per quarter to match real catalog. Reads stale until next build.
// Real-time numbers come from getSiteStats() in any server component that can await.
export const STATIC_TOOL_COUNT_DISPLAY = '585+'
export const STATIC_COMPARISON_COUNT_DISPLAY = '250+'
export const STATIC_TASK_COUNT_DISPLAY = '500+'

export async function getSiteStats(): Promise<SiteStats> {
  const supabase = createStaticClient()
  const [tools, comparisons, tasks] = await Promise.all([
    supabase.from('tools').select('*', { count: 'exact', head: true }),
    supabase.from('comparisons').select('*', { count: 'exact', head: true }),
    supabase.from('tasks').select('*', { count: 'exact', head: true }).eq('status', 'published'),
  ])

  const blogDir = path.join(process.cwd(), 'content', 'blog')
  const blogArticles = readdirSync(blogDir).filter(f => f.endsWith('.mdx')).length

  return {
    tools: tools.count ?? 0,
    comparisons: comparisons.count ?? 0,
    top10Lists: TOP10_LISTS.length,
    blogArticles,
    tasks: tasks.count ?? 0,
  }
}
