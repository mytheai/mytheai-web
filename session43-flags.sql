-- session43-flags.sql
-- Trending and featured flags for tools-batch-30 tools
-- Run AFTER tools-batch-30.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: tools getting significant attention in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'clipdrop',
  'getimg-ai',
  'nightcafe',
  'pixelcut',
  'lensa-ai',
  'playground-ai',
  'artbreeder',
  'fotor',
  'civitai',
  'tensor-art'
);

-- Featured: top-quality tools worth highlighting in UI
UPDATE tools
SET featured = true
WHERE slug IN (
  'clipdrop',
  'playground-ai',
  'getimg-ai',
  'pixelcut',
  'civitai'
);
