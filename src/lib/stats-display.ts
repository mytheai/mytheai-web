// Display constants for static metadata exports - safe to import from
// client components and edge runtimes (no Node fs/path dependencies).
// Update once per quarter to match real catalog. Reads stale until next build.
// Real-time numbers come from getSiteStats() in lib/stats.ts (server-only).

export const STATIC_TOOL_COUNT_DISPLAY = '584+'
export const STATIC_COMPARISON_COUNT_DISPLAY = '250+'
export const STATIC_TASK_COUNT_DISPLAY = '500+'
