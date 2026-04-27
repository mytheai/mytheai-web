-- session38-flags.sql
-- Set trending and featured flags for tools-batch-25 (customer support / helpdesk tools)
-- RUN AFTER tools-batch-25.sql is confirmed in DB
-- Safe to re-run: uses UPDATE WHERE pattern

-- Reset trending flags for batch-25 tools (clean state)
UPDATE tools SET trending = false
WHERE slug IN ('zendesk', 'freshdesk', 'helpscout', 'gorgias', 'drift', 'front-app', 'crisp', 'zoho-desk', 'liveagent', 'gladly');

-- Reset featured flags for batch-25 tools
UPDATE tools SET featured = false
WHERE slug IN ('zendesk', 'freshdesk', 'helpscout', 'gorgias', 'drift', 'front-app', 'crisp', 'zoho-desk', 'liveagent', 'gladly');

-- Set trending: all 10 batch-25 tools (AI customer support is a key 2026 category)
UPDATE tools SET trending = true
WHERE slug IN ('zendesk', 'freshdesk', 'helpscout', 'gorgias', 'drift', 'front-app', 'crisp', 'zoho-desk', 'liveagent', 'gladly');

-- Set featured: top 5 most notable for homepage sections
UPDATE tools SET featured = true
WHERE slug IN ('zendesk', 'freshdesk', 'gorgias', 'helpscout', 'front-app');

-- Editor's Picks: unchanged (cursor, notebooklm, lovable)
-- No changes to editor_pick flags
