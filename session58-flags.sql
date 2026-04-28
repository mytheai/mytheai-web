-- session58-flags.sql
-- trending + featured flags for tools-batch-45 (Meeting Intelligence tools)
-- Run AFTER tools-batch-45 confirmed in Supabase

-- Set trending for all 10 batch-45 tools
UPDATE tools SET trending = true WHERE slug IN (
  'grain',
  'read-ai',
  'jamie',
  'sembly-ai',
  'meetgeek',
  'notta',
  'tactiq',
  'chorus',
  'modjo',
  'airgram'
);

-- Set featured for top 5 batch-45 tools
UPDATE tools SET featured = true WHERE slug IN (
  'grain',
  'read-ai',
  'chorus',
  'modjo',
  'notta'
);
