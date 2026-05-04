-- S92 Mode D: integrations[] + curated scores backfill for 30 tier 5 tools.
-- Brings tools with integrations seeded from 102 to ~132.
-- Brings tools with hand-curated scores from 109 to ~139.
-- Categories: AI infra, generative AI, writing, PKM, productivity,
--             email/calendar, automation, AI search, design.
-- All 30 slugs verified in DB via scripts/check-tier5-slugs.mjs (NEED BACKFILL list).
-- Tags drawn only from existing controlled vocabulary (21 tags currently in use).
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

-- AI Infrastructure (6)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":3.5,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github','zapier','slack','snowflake']
WHERE slug = 'pinecone';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":4,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['github','slack','salesforce','hubspot','snowflake']
WHERE slug = 'cohere';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3,"pricing_value":4.5,"feature_depth":5,"integrations":4,"reliability":4,"trajectory":5}'::jsonb,
  integrations = ARRAY['github','slack']
WHERE slug = 'langchain';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3,"pricing_value":4.5,"feature_depth":4.5,"integrations":3.5,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github','slack']
WHERE slug = 'mistral';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":4.5,"feature_depth":4,"integrations":3.5,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['github','slack','zapier']
WHERE slug = 'groq';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":4,"feature_depth":4.5,"integrations":3.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github','slack','zapier']
WHERE slug = 'replicate';

-- Generative AI (5)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":5}'::jsonb,
  integrations = ARRAY['google','dropbox']
WHERE slug = 'kling';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['google','dropbox']
WHERE slug = 'pika';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":3,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','dropbox','zapier']
WHERE slug = 'leonardo-ai';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google','dropbox']
WHERE slug = 'playground-ai';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4,"feature_depth":4,"integrations":3.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['google','dropbox','zapier']
WHERE slug = 'submagic';

-- Writing (3)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":4.5,"integrations":3,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','dropbox']
WHERE slug = 'sudowrite';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','gmail','microsoft-365','slack','linkedin']
WHERE slug = 'wordtune';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":3.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google','microsoft-365','zapier']
WHERE slug = 'rytr';

-- PKM / Notes (3)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4.5,"feature_depth":4.5,"integrations":3,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['github','dropbox']
WHERE slug = 'anytype';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['google','calendar','slack','zapier','linear']
WHERE slug = 'tana';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','calendar','gmail','dropbox','zapier']
WHERE slug = 'reflect';

-- Productivity (4)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4.5,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','zapier','google','gmail','calendar','github','dropbox','microsoft-365']
WHERE slug = 'todoist';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','zapier','google','calendar','gmail','microsoft-365','notion']
WHERE slug = 'motion';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','google','calendar','gmail','asana','jira','linear','notion','github']
WHERE slug = 'sunsama';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google','calendar','slack','gmail','microsoft-365','asana','jira','notion']
WHERE slug = 'akiflow';

-- Email / Calendar (2)
UPDATE tools SET
  scores = '{"output_quality":5,"ease_of_use":4.5,"pricing_value":3,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['gmail','calendar','slack','salesforce','hubspot','linkedin']
WHERE slug = 'superhuman';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','calendar','gmail','slack','hubspot','salesforce','stripe']
WHERE slug = 'savvycal';

-- Automation (3)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4.5,"feature_depth":4.5,"integrations":5,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','github','google','hubspot','salesforce','stripe','segment','airtable','notion']
WHERE slug = 'activepieces';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":4.5,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','github','google','hubspot','salesforce','segment','snowflake','airtable','notion']
WHERE slug = 'pipedream';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4.5,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','google','salesforce','hubspot','linkedin','gmail','calendar','notion','airtable']
WHERE slug = 'bardeen';

-- AI Search / Research (3)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','google','jira','asana','github','salesforce','hubspot','segment','snowflake','notion']
WHERE slug = 'glean';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":3,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','zapier']
WHERE slug = 'consensus';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":4,"feature_depth":4,"integrations":3,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','zapier']
WHERE slug = 'elicit';

-- Design (1)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":4,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','google','github','notion','linear','airtable','jira']
WHERE slug = 'framer';

COMMIT;

-- Sanity check (run separately):
-- SELECT slug FROM tools WHERE slug = ANY(ARRAY['pinecone','cohere','langchain','mistral','groq','replicate','kling','pika','leonardo-ai','playground-ai','submagic','sudowrite','wordtune','rytr','anytype','tana','reflect','todoist','motion','sunsama','akiflow','superhuman','savvycal','activepieces','pipedream','bardeen','glean','consensus','elicit','framer']) AND array_length(integrations, 1) > 0;
-- Expected: 30 rows.
