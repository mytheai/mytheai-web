// Display constants for static metadata exports - safe to import from
// client components and edge runtimes (no Node fs/path dependencies).
//
// Auto-updated by scripts/sync-stats-display.mjs on prebuild. Do NOT edit manually -
// changes will be overwritten on next `npm run build`. See the sync script for logic.
// Real-time numbers come from getSiteStats() in lib/stats.ts (server-only).

export const STATIC_TOOL_COUNT_DISPLAY = '590+'
export const STATIC_COMPARISON_COUNT_DISPLAY = '250+'
export const STATIC_TASK_COUNT_DISPLAY = '500+'
