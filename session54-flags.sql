-- session54-flags.sql
-- Trending and featured flags for tools-batch-41 (AI cybersecurity tools)
-- Run AFTER tools-batch-41.sql is confirmed in DB

-- Set trending for all 10 batch-41 tools
UPDATE tools SET trending = true WHERE slug IN (
  'snyk',
  'wiz',
  'orca-security',
  'lacework',
  'tenable-io',
  'detectify',
  'aikido-security',
  'socket-dev',
  'vulcan-cyber',
  'cycode'
);

-- Set featured for standout batch-41 tools
UPDATE tools SET featured = true WHERE slug IN (
  'snyk',
  'wiz',
  'orca-security',
  'aikido-security',
  'socket-dev'
);
