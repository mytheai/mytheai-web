-- session60-flags.sql
-- trending + featured flags for tools-batch-47 (AI Proposal & Contract tools)
-- Run AFTER tools-batch-47 confirmed in Supabase

-- Set trending for all 10 batch-47 tools
UPDATE tools SET trending = true WHERE slug IN (
  'pandadoc',
  'proposify',
  'qwilr',
  'dealhub',
  'oneflow',
  'contractbook',
  'juro',
  'ironclad',
  'better-proposals',
  'loopio'
);

-- Set featured for top 5 batch-47 tools
UPDATE tools SET featured = true WHERE slug IN (
  'pandadoc',
  'proposify',
  'qwilr',
  'oneflow',
  'better-proposals'
);
