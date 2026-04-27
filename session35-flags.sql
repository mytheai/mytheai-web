-- session35-flags.sql
-- Set trending and featured flags for tools-batch-22 (AI coding tools)
-- RUN AFTER tools-batch-22.sql is confirmed in DB
-- Safe to re-run: uses ON CONFLICT DO NOTHING pattern via UPDATE WHERE

-- Reset trending flags for batch-22 tools (set to false first for clean state)
UPDATE tools SET trending = false
WHERE slug IN ('tabnine', 'phind', 'blackbox-ai', 'continue-dev', 'cody', 'zed', 'supermaven', 'aider', 'codegpt', 'pieces-for-developers');

-- Reset featured flags for batch-22 tools
UPDATE tools SET featured = false
WHERE slug IN ('tabnine', 'phind', 'blackbox-ai', 'continue-dev', 'cody', 'zed', 'supermaven', 'aider', 'codegpt', 'pieces-for-developers');

-- Set trending: highest momentum coding tools in 2026
UPDATE tools SET trending = true
WHERE slug IN ('zed', 'aider', 'phind', 'continue-dev', 'supermaven', 'tabnine', 'cody', 'blackbox-ai', 'codegpt', 'pieces-for-developers');

-- Set featured: top 5 most notable for homepage sections
UPDATE tools SET featured = true
WHERE slug IN ('zed', 'aider', 'phind', 'continue-dev', 'tabnine');

-- Editor's Picks: unchanged (cursor, notebooklm, lovable)
-- No changes to editor_pick flags
