-- session40-flags.sql
-- Set trending and featured flags for tools-batch-27 (AI marketing tools)
-- RUN AFTER tools-batch-27.sql is confirmed in DB
-- Safe to re-run: uses UPDATE WHERE pattern

-- Reset trending flags for batch-27 tools (clean state)
UPDATE tools SET trending = false
WHERE slug IN ('sprout-social', 'brand24', 'agorapulse', 'later', 'loomly', 'predis-ai', 'metricool', 'omnisend', 'mailerlite', 'planable');

-- Reset featured flags for batch-27 tools
UPDATE tools SET featured = false
WHERE slug IN ('sprout-social', 'brand24', 'agorapulse', 'later', 'loomly', 'predis-ai', 'metricool', 'omnisend', 'mailerlite', 'planable');

-- Set trending: all 10 batch-27 tools (AI marketing tools is a high-activity 2026 category)
UPDATE tools SET trending = true
WHERE slug IN ('sprout-social', 'brand24', 'agorapulse', 'later', 'loomly', 'predis-ai', 'metricool', 'omnisend', 'mailerlite', 'planable');

-- Set featured: top 5 most notable for homepage sections
UPDATE tools SET featured = true
WHERE slug IN ('sprout-social', 'omnisend', 'brand24', 'predis-ai', 'mailerlite');

-- Editor's Picks: unchanged (cursor, notebooklm, lovable)
-- No changes to editor_pick flags
