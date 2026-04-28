-- session45-flags.sql
-- Trending and featured flags for tools-batch-32 tools
-- Run AFTER tools-batch-32.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: project management tools gaining momentum in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'wrike',
  'smartsheet',
  'basecamp',
  'height-app',
  'plane-so',
  'huly',
  'teamwork',
  'nifty',
  'hive',
  'productive'
);

-- Featured: top-quality project management tools worth highlighting
UPDATE tools
SET featured = true
WHERE slug IN (
  'height-app',
  'plane-so',
  'huly',
  'wrike',
  'smartsheet'
);
