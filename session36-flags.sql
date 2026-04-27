-- session36-flags.sql
-- Set trending and featured flags for tools-batch-23 (AI developer infrastructure tools)
-- RUN AFTER tools-batch-23.sql is confirmed in DB
-- Safe to re-run: uses UPDATE WHERE pattern

-- Reset trending flags for batch-23 tools (clean state)
UPDATE tools SET trending = false
WHERE slug IN ('vercel-v0', 'devin-ai', 'e2b', 'gitpod', 'langsmith', 'agentops', 'dify', 'flowise', 'n8n', 'val-town');

-- Reset featured flags for batch-23 tools
UPDATE tools SET featured = false
WHERE slug IN ('vercel-v0', 'devin-ai', 'e2b', 'gitpod', 'langsmith', 'agentops', 'dify', 'flowise', 'n8n', 'val-town');

-- Set trending: all 10 batch-23 tools (AI dev infrastructure momentum in 2026)
UPDATE tools SET trending = true
WHERE slug IN ('vercel-v0', 'devin-ai', 'e2b', 'gitpod', 'langsmith', 'agentops', 'dify', 'flowise', 'n8n', 'val-town');

-- Set featured: top 5 most notable for homepage sections
UPDATE tools SET featured = true
WHERE slug IN ('vercel-v0', 'devin-ai', 'dify', 'langsmith', 'n8n');

-- Editor's Picks: unchanged (cursor, notebooklm, lovable)
-- No changes to editor_pick flags
