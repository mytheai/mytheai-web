-- session55-flags.sql
-- Trending and featured flags for tools-batch-42 (AI fintech/finance ops tools)
-- Run AFTER tools-batch-42.sql is confirmed in DB

-- Set trending for all 10 batch-42 tools
UPDATE tools SET trending = true WHERE slug IN (
  'ramp',
  'brex',
  'pilot',
  'bench',
  'vic-ai',
  'stampli',
  'tipalti',
  'airbase',
  'zeni',
  'docyt'
);

-- Set featured for standout batch-42 tools
UPDATE tools SET featured = true WHERE slug IN (
  'ramp',
  'brex',
  'pilot',
  'tipalti',
  'stampli'
);
