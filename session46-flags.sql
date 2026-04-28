-- session46-flags.sql
-- Trending and featured flags for tools-batch-33 tools
-- Run AFTER tools-batch-33.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: customer support tools gaining momentum in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'chatwoot',
  'kustomer',
  're-amaze',
  'dixa',
  'freshchat',
  'sprinklr',
  'forethought',
  'capacity',
  'plain',
  'groove'
);

-- Featured: top-quality customer support tools worth highlighting
UPDATE tools
SET featured = true
WHERE slug IN (
  'chatwoot',
  'kustomer',
  'forethought',
  'plain',
  'dixa'
);
