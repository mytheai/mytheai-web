-- session57-flags.sql
-- trending + featured flags for tools-batch-44 (Knowledge Management tools)
-- Run AFTER tools-batch-44 confirmed in Supabase

-- Set trending for all 10 batch-44 tools
UPDATE tools SET trending = true WHERE slug IN (
  'guru',
  'tettra',
  'slab',
  'slite',
  'helpjuice',
  'document360',
  'bloomfire',
  'nuclino',
  'gitbook',
  'obsidian'
);

-- Set featured for top 5 batch-44 tools
UPDATE tools SET featured = true WHERE slug IN (
  'guru',
  'slab',
  'gitbook',
  'document360',
  'tettra'
);
