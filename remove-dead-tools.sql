-- Auto-generated 2026-04-30T12:49:40.173Z
-- 7 confirmed dead tools (cert errors + DNS failures + manual confirmation).
-- REJECTED unreliable 'all-probes-failed' verdicts (Cloudflare false positives).
-- Wrapped in BEGIN/COMMIT.

BEGIN;

DELETE FROM comparisons WHERE tool_a_slug IN (
  'detangle-ai',
  'hypercontext',
  'lacework',
  'lensa-ai',
  'scribe',
  'shorts-ai',
  'vulcan-cyber'
) OR tool_b_slug IN (
  'detangle-ai',
  'hypercontext',
  'lacework',
  'lensa-ai',
  'scribe',
  'shorts-ai',
  'vulcan-cyber'
);

DELETE FROM tool_clicks WHERE tool_slug IN (
  'detangle-ai',
  'hypercontext',
  'lacework',
  'lensa-ai',
  'scribe',
  'shorts-ai',
  'vulcan-cyber'
);

DELETE FROM tools WHERE slug IN (
  'detangle-ai',
  'hypercontext',
  'lacework',
  'lensa-ai',
  'scribe',
  'shorts-ai',
  'vulcan-cyber'
);

COMMIT;
