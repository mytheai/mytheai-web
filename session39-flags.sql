-- session39-flags.sql
-- Set trending and featured flags for tools-batch-26 (AI sales & CRM tools)
-- RUN AFTER tools-batch-26.sql is confirmed in DB
-- Safe to re-run: uses UPDATE WHERE pattern

-- Reset trending flags for batch-26 tools (clean state)
UPDATE tools SET trending = false
WHERE slug IN ('pipedrive', 'close-crm', 'attio', 'affinity', 'lemlist', 'reply-io', 'outreach', 'salesloft', 'gong-io', 'lavender');

-- Reset featured flags for batch-26 tools
UPDATE tools SET featured = false
WHERE slug IN ('pipedrive', 'close-crm', 'attio', 'affinity', 'lemlist', 'reply-io', 'outreach', 'salesloft', 'gong-io', 'lavender');

-- Set trending: all 10 batch-26 tools (AI sales automation is a key 2026 category)
UPDATE tools SET trending = true
WHERE slug IN ('pipedrive', 'close-crm', 'attio', 'affinity', 'lemlist', 'reply-io', 'outreach', 'salesloft', 'gong-io', 'lavender');

-- Set featured: top 5 most notable for homepage sections
UPDATE tools SET featured = true
WHERE slug IN ('gong-io', 'attio', 'outreach', 'lemlist', 'pipedrive');

-- Editor's Picks: unchanged (cursor, notebooklm, lovable)
-- No changes to editor_pick flags
