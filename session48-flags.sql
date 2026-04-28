-- session48-flags.sql
-- Trending and featured flags for tools-batch-35 tools (AI EdTech)
-- Run AFTER tools-batch-35.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: AI educator tools gaining momentum in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'khanmigo',
  'schoolai',
  'curipod',
  'diffit',
  'brisk-teaching',
  'classpoint',
  'conker',
  'almanack-ai',
  'synthesis-tutor',
  'nearpod'
);

-- Featured: highest-impact EdTech tools for discovery
UPDATE tools
SET featured = true
WHERE slug IN (
  'khanmigo',
  'synthesis-tutor',
  'curipod',
  'brisk-teaching',
  'schoolai'
);
