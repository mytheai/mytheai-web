-- session37-flags.sql
-- Set trending and featured flags for tools-batch-24 (no-code / low-code platforms)
-- RUN AFTER tools-batch-24.sql is confirmed in DB
-- Safe to re-run: uses UPDATE WHERE pattern

-- Reset trending flags for batch-24 tools (clean state)
UPDATE tools SET trending = false
WHERE slug IN ('bubble', 'glide', 'retool', 'softr', 'adalo', 'appsmith', 'xano', 'noloco', 'windmill', 'weweb');

-- Reset featured flags for batch-24 tools
UPDATE tools SET featured = false
WHERE slug IN ('bubble', 'glide', 'retool', 'softr', 'adalo', 'appsmith', 'xano', 'noloco', 'windmill', 'weweb');

-- Set trending: all 10 batch-24 tools (no-code momentum in 2026)
UPDATE tools SET trending = true
WHERE slug IN ('bubble', 'glide', 'retool', 'softr', 'adalo', 'appsmith', 'xano', 'noloco', 'windmill', 'weweb');

-- Set featured: top 5 most notable for homepage sections
UPDATE tools SET featured = true
WHERE slug IN ('retool', 'bubble', 'appsmith', 'xano', 'windmill');

-- Editor's Picks: unchanged (cursor, notebooklm, lovable)
-- No changes to editor_pick flags
