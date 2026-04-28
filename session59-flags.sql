-- session59-flags.sql
-- trending + featured flags for tools-batch-46 (AI Design tools)
-- Run AFTER tools-batch-46 confirmed in Supabase

-- Set trending for all 10 batch-46 tools
UPDATE tools SET trending = true WHERE slug IN (
  'framer',
  'galileo-ai',
  'locofy',
  'uizard',
  'visily',
  'relume',
  'subframe',
  'penpot',
  'diagram',
  'magician'
);

-- Set featured for top 5 batch-46 tools
UPDATE tools SET featured = true WHERE slug IN (
  'framer',
  'galileo-ai',
  'relume',
  'penpot',
  'subframe'
);
