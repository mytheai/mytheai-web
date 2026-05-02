-- remove-dead-tools-may-2026.sql
-- Bulk removal of 18 tools requested by user (May 2, 2026)
-- FK CASCADE will auto-delete: 17 comparisons + ~119 comparison_criteria rows
-- Reason: low importance and/or no longer operational at user-perceived quality bar

BEGIN;

DELETE FROM tools WHERE slug IN (
  'aider',
  'clockwise',
  'evisort',
  'github-copilot',
  'gitpod',
  'immoviewer',
  'jamie',
  'lexis-ai',
  'looka',
  'magician',
  'microsoft-365-copilot',
  'nosto',
  'pabbly-connect',
  'phind',
  'rentlytics',
  'rex-real-estate',
  'seekout',
  'ticktick'
);

-- Verify
SELECT 'tools_remaining' AS metric, COUNT(*) FROM tools
UNION ALL
SELECT 'comparisons_remaining', COUNT(*) FROM comparisons
UNION ALL
SELECT 'criteria_remaining', COUNT(*) FROM comparison_criteria;

COMMIT;
