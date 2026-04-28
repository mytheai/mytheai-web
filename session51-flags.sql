-- session51-flags.sql
-- Trending and featured flags for tools-batch-38 tools (AI Data Analysis / BI Tools)
-- Run AFTER tools-batch-38.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: AI data analysis tools gaining momentum in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'formula-bot',
  'polymer',
  'akkio',
  'rows',
  'obviously-ai',
  'gigasheet',
  'hal9',
  'seek-ai',
  'outerbase',
  'deepnote'
);

-- Featured: highest-impact AI data tools for discovery
UPDATE tools
SET featured = true
WHERE slug IN (
  'deepnote',
  'rows',
  'outerbase',
  'formula-bot',
  'akkio'
);
