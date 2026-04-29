-- session63-flags.sql
-- trending + featured flags for tools-batch-49 (AI Customer Success tools)
-- Run AFTER tools-batch-49 confirmed in Supabase

-- Set trending for all 10 batch-49 tools
UPDATE tools SET trending = true WHERE slug IN (
  'gainsight',
  'totango',
  'churnzero',
  'planhat',
  'vitally',
  'catalyst',
  'client-success',
  'userpilot',
  'custify',
  'akita'
);

-- Set featured for top 5 batch-49 tools (most established CS platforms)
UPDATE tools SET featured = true WHERE slug IN (
  'gainsight',
  'churnzero',
  'planhat',
  'vitally',
  'userpilot'
);
