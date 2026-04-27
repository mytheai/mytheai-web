-- session41-flags.sql
-- Set trending and featured flags for tools-batch-28 (AI productivity tools)
-- RUN AFTER tools-batch-28.sql is confirmed in DB
-- Safe to re-run: uses UPDATE WHERE pattern

-- Reset trending flags for batch-28 tools (clean state)
UPDATE tools SET trending = false
WHERE slug IN ('sunsama', 'akiflow', 'clockwise', 'todoist', 'ticktick', 'superhuman', 'shortwave', 'spark-mail', 'savvycal', 'cal-com');

-- Reset featured flags for batch-28 tools
UPDATE tools SET featured = false
WHERE slug IN ('sunsama', 'akiflow', 'clockwise', 'todoist', 'ticktick', 'superhuman', 'shortwave', 'spark-mail', 'savvycal', 'cal-com');

-- Set trending: all 10 batch-28 tools (AI productivity and scheduling is a high-activity 2026 category)
UPDATE tools SET trending = true
WHERE slug IN ('sunsama', 'akiflow', 'clockwise', 'todoist', 'ticktick', 'superhuman', 'shortwave', 'spark-mail', 'savvycal', 'cal-com');

-- Set featured: top 5 most notable for homepage sections
UPDATE tools SET featured = true
WHERE slug IN ('superhuman', 'clockwise', 'todoist', 'cal-com', 'sunsama');

-- Editor's Picks: unchanged (cursor, notebooklm, lovable)
-- No changes to editor_pick flags
