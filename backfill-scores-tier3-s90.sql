-- S90 tier 3 backfill: scores + integrations for 30 more head-term tools.
-- Brings total tools with editorial_score from 49 to 79 (~14% catalog).
-- All slugs verified in DB. Idempotent: re-run safely.

BEGIN;

-- Productivity / PM
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','google','zapier','notion']
WHERE slug = 'airtable';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','google','zapier','github']
WHERE slug = 'asana';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4.5,"feature_depth":5,"integrations":4.5,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','google','zapier','github','hubspot']
WHERE slug = 'clickup';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','google','zapier','github','hubspot']
WHERE slug = 'monday';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":5,"feature_depth":4.5,"integrations":4,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['github','zapier']
WHERE slug = 'obsidian';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":4,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','zapier','google']
WHERE slug = 'mem-ai';

-- AI assistants tier 3
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":5,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['google']
WHERE slug = 'notebooklm';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":5,"feature_depth":3.5,"integrations":3,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY[]::text[]
WHERE slug = 'meta-ai';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY[]::text[]
WHERE slug = 'grok';

-- Meeting / transcription
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":5,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','google','zapier','hubspot','notion']
WHERE slug = 'fathom';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','google','zapier','hubspot','notion']
WHERE slug = 'fireflies-ai';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":4.5,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','google','notion','hubspot']
WHERE slug = 'tldv';

-- Writing tier 3
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','zapier','hubspot']
WHERE slug = 'copy-ai';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":4,"reliability":4,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['zapier','google']
WHERE slug = 'writesonic';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":4.5,"feature_depth":3.5,"integrations":3.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google']
WHERE slug = 'quillbot';

-- SEO tier 3
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','slack','zapier']
WHERE slug = 'clearscope';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":4,"reliability":4,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google','slack','zapier']
WHERE slug = 'marketmuse';

-- Sales / CRM tier 3
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['hubspot','slack','google','zapier']
WHERE slug = 'salesforce-einstein';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":5,"trajectory":4}'::jsonb,
  integrations = ARRAY['salesforce','hubspot','slack','google','zapier']
WHERE slug = 'gong';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['salesforce','hubspot','slack']
WHERE slug = 'clari';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['salesforce','hubspot','slack','google','zapier']
WHERE slug = 'apollo';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":4,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['hubspot','slack','zapier']
WHERE slug = 'instantly-ai';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":4,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['hubspot','slack','zapier']
WHERE slug = 'smartlead';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google','slack','zapier','hubspot']
WHERE slug = 'pipedrive';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4.5,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google','slack','zapier']
WHERE slug = 'zoho-crm';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google','slack','zapier','hubspot']
WHERE slug = 'freshsales';

-- Image / design tier 3
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":4.5,"feature_depth":4.5,"integrations":3,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY[]::text[]
WHERE slug = 'leonardo-ai';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY[]::text[]
WHERE slug = 'playground-ai';

-- Voice / audio tier 3
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":4,"feature_depth":4,"integrations":3.5,"reliability":4,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google']
WHERE slug = 'speechify';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":3,"reliability":4,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['zapier']
WHERE slug = 'murf';

COMMIT;

SELECT COUNT(*) AS updated_count FROM tools
WHERE scores IS NOT NULL
  AND slug IN (
    'airtable','asana','clickup','monday','obsidian','mem-ai',
    'notebooklm','meta-ai','grok',
    'fathom','fireflies-ai','tldv',
    'copy-ai','writesonic','quillbot',
    'clearscope','marketmuse',
    'salesforce-einstein','gong','clari','apollo','instantly-ai','smartlead','pipedrive','zoho-crm','freshsales',
    'leonardo-ai','playground-ai',
    'speechify','murf'
  );
