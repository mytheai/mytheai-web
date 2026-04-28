-- session50-flags.sql
-- Trending and featured flags for tools-batch-37 tools (AI Healthcare / Medical Tools)
-- Run AFTER tools-batch-37.sql has been confirmed in DB
-- Safe to re-run: UPDATE only, no inserts

-- Trending: AI healthcare tools gaining momentum in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'nabla',
  'abridge',
  'suki-ai',
  'corti',
  'regard',
  'glass-health',
  'nuance-dax',
  'aidoc',
  'doximity',
  'anterior'
);

-- Featured: highest-impact healthcare AI tools for discovery
UPDATE tools
SET featured = true
WHERE slug IN (
  'nabla',
  'abridge',
  'glass-health',
  'aidoc',
  'nuance-dax'
);
