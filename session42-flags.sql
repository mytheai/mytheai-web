-- session42-flags.sql
-- Trending and featured flags for tools-batch-29 tools
-- Run AFTER tools-batch-29.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: tools getting significant attention in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'fullstory',
  'heap',
  'june-so',
  'rudderstack',
  'plausible',
  'chartmogul',
  'baremetrics',
  'pendo',
  'hotjar',
  'segment'
);

-- Featured: top-quality tools worth highlighting in UI
UPDATE tools
SET featured = true
WHERE slug IN (
  'segment',
  'heap',
  'chartmogul',
  'june-so',
  'plausible'
);
