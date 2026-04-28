-- session47-flags.sql
-- Trending and featured flags for tools-batch-34 tools
-- Run AFTER tools-batch-34.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: AI video tools gaining momentum in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'kapwing',
  'colossyan',
  'elai-io',
  'captions-ai',
  'munch',
  'wisecut',
  'steve-ai',
  'vmaker',
  'topaz-video-ai',
  'filmora'
);

-- Featured: top-quality video tools worth highlighting
UPDATE tools
SET featured = true
WHERE slug IN (
  'colossyan',
  'elai-io',
  'captions-ai',
  'kapwing',
  'topaz-video-ai'
);
