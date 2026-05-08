import Link from 'next/link'
import { createStaticClient } from '@/lib/supabase'
import { getSiteStats } from '@/lib/stats'
import type { Metadata } from 'next'
import TasksHubSearch from '@/components/tasks/TasksHubSearch'

export const dynamic = 'force-dynamic'

interface TaskRow {
  slug: string
  title: string
  emoji: string
  category: string | null
  monthly_search_volume: number | null
  picked_slugs: string[]
  intro: string
}

const CATEGORY_META: Record<string, { label: string; emoji: string }> = {
  writing:           { label: 'Writing',           emoji: '✍️' },
  sales:             { label: 'Sales',             emoji: '💼' },
  dev:               { label: 'Development',       emoji: '💻' },
  design:            { label: 'Design',            emoji: '🎨' },
  research:          { label: 'Research',          emoji: '🔬' },
  ops:               { label: 'Operations',        emoji: '⚙️' },
  support:           { label: 'Customer Support',  emoji: '🎧' },
  marketing:         { label: 'Marketing',         emoji: '📣' },
  finance:           { label: 'Finance',           emoji: '💰' },
  'data-analytics':  { label: 'Data & Analytics',  emoji: '📊' },
  'hr-recruiting':   { label: 'HR & Recruiting',   emoji: '👥' },
  'customer-success':{ label: 'Customer Success',  emoji: '🎯' },
  productivity:      { label: 'Productivity',      emoji: '⚡' },
}

export const metadata: Metadata = {
  title: 'AI Tasks - Find the Right AI Tool for Any Job | MytheAi',
  description: 'Browse curated AI tools by specific task. Cold emails, meeting summaries, blog outlines, invoice OCR, customer support and more. Editor-picked, transparently ranked.',
  alternates: { canonical: 'https://mytheai.com/tasks' },
}

async function getAllTasks(): Promise<TaskRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tasks')
    .select('slug,title,emoji,category,monthly_search_volume,picked_slugs,intro')
    .eq('status', 'published')
    .order('monthly_search_volume', { ascending: false, nullsFirst: false })
  return (data ?? []) as TaskRow[]
}

export default async function TasksHub() {
  const [tasks, stats] = await Promise.all([getAllTasks(), getSiteStats()])

  const grouped = new Map<string, TaskRow[]>()
  for (const t of tasks) {
    const key = t.category || 'other'
    if (!grouped.has(key)) grouped.set(key, [])
    grouped.get(key)!.push(t)
  }

  const orderedCategories = [
    'writing', 'sales', 'support', 'marketing', 'productivity',
    'dev', 'design', 'research', 'ops', 'finance',
    'data-analytics', 'hr-recruiting', 'customer-success', 'other',
  ].filter(c => grouped.has(c))

  return (
    <div className="max-w-5xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-10 text-center">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">🎯 Browse by task</p>
        <h1 className="text-[32px] md:text-[44px] font-extrabold tracking-tight text-foreground mb-4">
          Find AI for any task
        </h1>
        <p className="text-[16px] text-muted-foreground max-w-2xl mx-auto leading-relaxed">
          Specific job to do? We curate the best AI tools for {tasks.length} discrete tasks. Editor-picked, transparently ranked, updated weekly.
        </p>
      </div>

      <TasksHubSearch tasks={tasks.map(t => ({ slug: t.slug, title: t.title, emoji: t.emoji }))} />

      {orderedCategories.length === 0 ? (
        <div className="mt-12 p-8 rounded-xl border border-border bg-card text-center">
          <p className="text-[14px] text-muted-foreground">No tasks published yet.</p>
        </div>
      ) : (
        <div className="mt-12 space-y-12">
          {orderedCategories.map(catKey => {
            const meta = CATEGORY_META[catKey] || { label: catKey, emoji: '🔹' }
            const items = grouped.get(catKey)!
            return (
              <section key={catKey}>
                <div className="flex items-baseline justify-between mb-5">
                  <h2 className="text-[22px] font-extrabold tracking-tight text-foreground">
                    <span className="mr-2">{meta.emoji}</span>{meta.label}
                  </h2>
                  <span className="text-[13px] text-muted-foreground">{items.length} task{items.length === 1 ? '' : 's'}</span>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  {items.map(t => (
                    <Link
                      key={t.slug}
                      href={`/tasks/${t.slug}`}
                      className="flex items-start gap-3 p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors group"
                    >
                      <span className="text-[20px] flex-shrink-0">{t.emoji}</span>
                      <div className="flex-1 min-w-0">
                        <div className="text-[14px] font-bold text-foreground group-hover:text-blue-600 transition-colors">{t.title}</div>
                        <div className="text-[12px] text-muted-foreground mt-0.5">
                          {t.picked_slugs?.length ?? 0} top picks
                          {t.monthly_search_volume ? ` · ${t.monthly_search_volume.toLocaleString()} searches/mo` : ''}
                        </div>
                      </div>
                    </Link>
                  ))}
                </div>
              </section>
            )
          })}
        </div>
      )}

      <div className="mt-16 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
        Don&apos;t see your task? <Link href="/tools" className="text-blue-600 hover:underline">Browse all {stats.tools} tools</Link> or <Link href="/quiz" className="text-blue-600 hover:underline">take the 90-second quiz</Link>.
      </div>

    </div>
  )
}
