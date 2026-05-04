-- Fix two slugs that were wrong in backfill-scores-integrations-s89.sql:
-- github-copilot -> copilot-microsoft, hubspot-ai -> hubspot.

BEGIN;

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4,"feature_depth":4.5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github','slack','zapier']
WHERE slug = 'copilot-microsoft';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":5,"trajectory":4}'::jsonb,
  integrations = ARRAY['hubspot','slack','google','zapier']
WHERE slug = 'hubspot';

COMMIT;

SELECT slug, scores IS NOT NULL AS has_scores, array_length(integrations, 1) AS int_count
FROM tools WHERE slug IN ('copilot-microsoft','hubspot')
ORDER BY slug;
