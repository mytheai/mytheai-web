-- session61-flags.sql
-- trending + featured flags for tools-batch-48 (AI UX Research tools)
-- Run AFTER tools-batch-48 confirmed in Supabase

-- Set trending for all 10 batch-48 tools
UPDATE tools SET trending = true WHERE slug IN (
  'dovetail',
  'maze',
  'sprig',
  'lyssna',
  'lookback',
  'optimal-workshop',
  'userlytics',
  'dscout',
  'respondent',
  'playbook-ux'
);

-- Set featured for top 5 batch-48 tools
UPDATE tools SET featured = true WHERE slug IN (
  'dovetail',
  'maze',
  'sprig',
  'lyssna',
  'lookback'
);
