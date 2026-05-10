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

// Re-export display constants so existing server-side imports keep working.
// New imports from client components or edge runtimes should pull directly
// from './stats-display' to avoid bundling fs/path.
export {
  STATIC_TOOL_COUNT_DISPLAY,
  STATIC_COMPARISON_COUNT_DISPLAY,
  STATIC_TASK_COUNT_DISPLAY,
} from './stats-display'

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
