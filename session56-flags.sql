-- session56-flags.sql
-- Trending and featured flags for tools-batch-43 (AI corporate e-learning / LMS tools)
-- Run AFTER tools-batch-43.sql is confirmed in DB

-- Set trending for all 10 batch-43 tools
UPDATE tools SET trending = true WHERE slug IN (
  'articulate',
  'docebo',
  'learnupon',
  '360learning',
  'skilljar',
  'absorb-lms',
  'litmos',
  'ispring',
  'talentlms',
  'cornerstone'
);

-- Set featured for standout batch-43 tools
UPDATE tools SET featured = true WHERE slug IN (
  'articulate',
  'docebo',
  '360learning',
  'talentlms',
  'cornerstone'
);
