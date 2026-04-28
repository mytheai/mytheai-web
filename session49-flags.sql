-- session49-flags.sql
-- Trending and featured flags for tools-batch-36 tools (AI Presentation Tools)
-- Run AFTER tools-batch-36.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: AI presentation tools gaining momentum in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'slidebean',
  'prezi',
  'visme',
  'genially',
  'storydoc',
  'mmhmm',
  'mentimeter',
  'zoho-show',
  'ludus',
  'slides-ai'
);

-- Featured: highest-impact presentation tools for discovery
UPDATE tools
SET featured = true
WHERE slug IN (
  'slidebean',
  'storydoc',
  'visme',
  'genially',
  'mentimeter'
);
