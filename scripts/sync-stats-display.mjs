#!/usr/bin/env node
// Prebuild hook: query live Supabase + rewrite src/lib/stats-display.ts so
// metadata descriptions stay fresh without manual bumping. Runs via
// "prebuild" script in package.json before each `next build`.
//
// Safe to fail: on error (network, missing env), leaves the file unchanged so
// stale constants ship rather than build failing. Local dev (`npm run dev`)
// never touches this file.
//
// Set up: 2026-10-08 Session 2 (Fix #4 dynamic meta descriptions).

import { createClient } from '@supabase/supabase-js'
import { readFileSync, writeFileSync } from 'fs'
import { readdirSync } from 'fs'
import path from 'path'

const url = process.env.NEXT_PUBLIC_SUPABASE_URL
const key = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY

if (!url || !key) {
  console.warn('[sync-stats-display] NEXT_PUBLIC_SUPABASE_URL or NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY missing - keeping existing constants.')
  process.exit(0)
}

function roundDown(n, step = 10) {
  return Math.floor(n / step) * step
}

try {
  const supabase = createClient(url, key)
  const [tools, comparisons, tasks] = await Promise.all([
    supabase.from('tools').select('*', { count: 'exact', head: true }),
    supabase.from('comparisons').select('*', { count: 'exact', head: true }),
    supabase.from('tasks').select('*', { count: 'exact', head: true }).eq('status', 'published'),
  ])

  const toolCount = tools.count ?? 0
  const comparisonCount = comparisons.count ?? 0
  const taskCount = tasks.count ?? 0

  if (toolCount < 1 || comparisonCount < 1 || taskCount < 1) {
    console.warn('[sync-stats-display] Zero rows returned - likely Supabase paused or RLS blocking. Keeping existing constants.')
    process.exit(0)
  }

  // Round down to nearest 10 to allow "+" suffix (e.g. 593 -> 590+)
  const toolDisplay = `${roundDown(toolCount)}+`
  const comparisonDisplay = `${roundDown(comparisonCount)}+`
  const taskDisplay = `${roundDown(taskCount)}+`

  const file = path.join(process.cwd(), 'src', 'lib', 'stats-display.ts')
  const next = `// Display constants for static metadata exports - safe to import from
// client components and edge runtimes (no Node fs/path dependencies).
//
// Auto-updated by scripts/sync-stats-display.mjs on prebuild. Do NOT edit manually -
// changes will be overwritten on next \`npm run build\`. See the sync script for logic.
// Real-time numbers come from getSiteStats() in lib/stats.ts (server-only).

export const STATIC_TOOL_COUNT_DISPLAY = '${toolDisplay}'
export const STATIC_COMPARISON_COUNT_DISPLAY = '${comparisonDisplay}'
export const STATIC_TASK_COUNT_DISPLAY = '${taskDisplay}'
`

  const current = readFileSync(file, 'utf8')
  if (current === next) {
    console.log(`[sync-stats-display] No change (tools ${toolDisplay}, comparisons ${comparisonDisplay}, tasks ${taskDisplay}).`)
  } else {
    writeFileSync(file, next)
    console.log(`[sync-stats-display] Updated: tools ${toolDisplay} (live ${toolCount}), comparisons ${comparisonDisplay} (live ${comparisonCount}), tasks ${taskDisplay} (live ${taskCount}).`)
  }
} catch (err) {
  console.warn(`[sync-stats-display] Error: ${err.message}. Keeping existing constants.`)
  process.exit(0)
}
