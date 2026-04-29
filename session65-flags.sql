-- session65-flags.sql
-- trending + featured flags for tools-batch-51 (AI Workflow Automation tools)
-- Run AFTER tools-batch-51 confirmed in Supabase

-- Set trending for all 10 batch-51 tools
UPDATE tools SET trending = true WHERE slug IN (
  'zapier',
  'make-com',
  'activepieces',
  'pipedream',
  'bardeen',
  'integrately',
  'albato',
  'workato',
  'tray-io',
  'pabbly-connect'
);

-- Set featured for top 5 batch-51 tools (most established automation platforms)
UPDATE tools SET featured = true WHERE slug IN (
  'zapier',
  'make-com',
  'workato',
  'pipedream',
  'activepieces'
);
