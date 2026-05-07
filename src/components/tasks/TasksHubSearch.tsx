'use client'

import { useState, useMemo } from 'react'
import Link from 'next/link'

interface TaskStub {
  slug: string
  title: string
  emoji: string
}

export default function TasksHubSearch({ tasks }: { tasks: TaskStub[] }) {
  const [q, setQ] = useState('')

  const matches = useMemo(() => {
    const term = q.trim().toLowerCase()
    if (!term) return [] as TaskStub[]
    return tasks
      .filter(t =>
        t.title.toLowerCase().includes(term) ||
        t.slug.toLowerCase().includes(term)
      )
      .slice(0, 8)
  }, [q, tasks])

  return (
    <div className="max-w-2xl mx-auto relative">
      <label htmlFor="task-search" className="sr-only">Search tasks</label>
      <div className="relative">
        <svg
          className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground"
          fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24" aria-hidden="true"
        >
          <circle cx="11" cy="11" r="8" /><path d="m21 21-4.35-4.35" />
        </svg>
        <input
          id="task-search"
          type="search"
          value={q}
          onChange={e => setQ(e.target.value)}
          placeholder="Try: cold emails, meeting summaries, invoice OCR..."
          className="w-full h-14 pl-12 pr-4 rounded-2xl border border-border bg-card text-[15px] placeholder:text-muted-foreground focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-500/20 transition"
        />
      </div>

      {q.trim() && (
        <div className="absolute left-0 right-0 mt-2 rounded-xl border border-border bg-card shadow-lg overflow-hidden z-20">
          {matches.length === 0 ? (
            <div className="p-4 text-[13px] text-muted-foreground">
              No task matches yet. <Link href="/tools" className="text-blue-600 hover:underline">Browse tools</Link> or <Link href="/quiz" className="text-blue-600 hover:underline">take the quiz</Link>.
            </div>
          ) : (
            <ul>
              {matches.map(m => (
                <li key={m.slug}>
                  <Link
                    href={`/tasks/${m.slug}`}
                    className="flex items-center gap-3 px-4 py-3 hover:bg-gray-50 dark:hover:bg-gray-900/40 transition-colors"
                  >
                    <span className="text-[18px]">{m.emoji}</span>
                    <span className="text-[14px] font-semibold text-foreground">{m.title}</span>
                  </Link>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  )
}
