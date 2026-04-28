-- session44-flags.sql
-- Trending and featured flags for tools-batch-31 tools
-- Run AFTER tools-batch-31.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: tools getting significant attention in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'clearscope',
  'marketmuse',
  'contentatscale',
  'neuronwriter',
  'dashword',
  'alli-ai',
  'originality-ai',
  'scalenut',
  'keyword-insights',
  'diib'
);

-- Featured: top-quality tools worth highlighting in UI
UPDATE tools
SET featured = true
WHERE slug IN (
  'clearscope',
  'marketmuse',
  'originality-ai',
  'keyword-insights',
  'alli-ai'
);
