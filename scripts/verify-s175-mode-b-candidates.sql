-- S175 Block A1: Verify which Mode B candidate slugs are MISSING vs ALREADY in catalog.
-- Run via: node --env-file=.env.local scripts/run-sql.mjs scripts/verify-s175-mode-b-candidates.sql
-- Expected: rows present = ALREADY_IN_CATALOG (skip); absent slugs from candidate list = MISSING (proceed to INSERT).

-- A1: All candidates + taxonomy variants in single SELECT so console.table prints them
SELECT slug, name
FROM tools
WHERE slug IN (
  -- Primary candidates per S173 backlog
  'calendly',
  'customer-io',
  'msteams',
  'roam-research',
  'scite',
  'cody-ai',
  'buffer',
  'chatgpt',
  -- Taxonomy variants to catch existing entries with different slug
  'microsoft-teams',
  'teams',
  'gpt-4',
  'openai-chatgpt',
  'cody',
  'sourcegraph-cody',
  'customerio',
  'roam',
  'roamresearch',
  'scite-ai',
  'sciteai',
  'buffer-app',
  -- Cohort peer-double targets (should be present)
  'cal-com',
  'mailchimp',
  'klaviyo',
  'slack',
  'anytype',
  'tana',
  'elicit',
  'consensus',
  'cursor',
  'codeium',
  'copilot-microsoft',
  'sprout-social',
  'hootsuite',
  'claude',
  'gemini'
)
ORDER BY slug;
