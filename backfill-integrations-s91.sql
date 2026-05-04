-- S91 Mode D: integrations[] + curated scores backfill for 30 tier 4 head-term tools.
-- Brings total tools with integrations seeded from 72 to ~102.
-- Brings total tools with hand-curated scores from 79 to ~109.
-- Categories: marketing/email, analytics, customer-support, sales-engagement,
--             modern-CRM, collaboration, video, no-code, internal-tools, forms.
-- All 30 slugs verified in DB via scripts/check-tier4-slugs.mjs.
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

-- Marketing / Email
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['shopify','zapier','slack','google','hubspot','salesforce','stripe','calendar','intercom','segment']
WHERE slug = 'mailchimp';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['shopify','zapier','slack','segment','stripe','intercom','google']
WHERE slug = 'klaviyo';

-- Product / Web Analytics
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['segment','slack','zapier','salesforce','hubspot','snowflake','google','stripe']
WHERE slug = 'mixpanel';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['segment','slack','zapier','salesforce','hubspot','snowflake','google','intercom']
WHERE slug = 'amplitude';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','slack','zapier','hubspot','segment','shopify','intercom']
WHERE slug = 'hotjar';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":5,"feature_depth":5,"integrations":4.5,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','zapier','segment','snowflake','google','github','intercom','hubspot']
WHERE slug = 'posthog';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":3,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['slack','zapier','salesforce','hubspot','segment','google','intercom']
WHERE slug = 'pendo';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":3.5,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['segment','slack','zapier','hubspot','salesforce','snowflake','google']
WHERE slug = 'heap';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['slack','zapier','salesforce','hubspot','segment','jira','google','intercom']
WHERE slug = 'fullstory';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','zapier','salesforce','hubspot','snowflake','google','intercom','stripe','shopify']
WHERE slug = 'segment';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":4.5,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','zapier','snowflake','google','hubspot','salesforce','stripe','shopify']
WHERE slug = 'rudderstack';

-- Customer Support / Helpdesk
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['slack','zapier','salesforce','hubspot','jira','shopify','segment','intercom','google']
WHERE slug = 'zendesk';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','zapier','salesforce','hubspot','segment','shopify','stripe','google']
WHERE slug = 'intercom';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['slack','zapier','google','hubspot','salesforce','jira','shopify']
WHERE slug = 'freshdesk';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','zapier','hubspot','salesforce','jira','google','shopify']
WHERE slug = 'helpscout';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['shopify','zapier','google','hubspot','slack','stripe']
WHERE slug = 'tidio';

-- Sales Engagement
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['salesforce','hubspot','slack','zapier','linkedin','google','calendar','gmail']
WHERE slug = 'outreach';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['salesforce','hubspot','slack','zapier','linkedin','google','calendar','gmail']
WHERE slug = 'salesloft';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['salesforce','hubspot','slack','zapier','linkedin','gmail','calendar']
WHERE slug = 'reply-io';

UPDATE tools SET
  scores = '{"output_quality":5,"ease_of_use":4,"pricing_value":3,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['salesforce','hubspot','slack','zapier','linkedin','google','snowflake']
WHERE slug = 'clay';

-- Modern CRM
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4.5,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','zapier','google','linkedin','gmail','calendar','intercom']
WHERE slug = 'attio';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','zapier','google','intercom','calendar','gmail','hubspot']
WHERE slug = 'close';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4.5,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','zapier','google','linkedin','gmail','calendar','notion']
WHERE slug = 'folk';

-- Collaboration / Whiteboard
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','google','zapier','jira','asana','linear','notion','microsoft-365','github']
WHERE slug = 'miro';

-- Video / Screen Recording
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','google','zapier','notion','jira','linear','asana','intercom','github']
WHERE slug = 'loom';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['google','zapier','slack','dropbox']
WHERE slug = 'opus-clip';

-- No-code / App Builders
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":4,"feature_depth":5,"integrations":5,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['stripe','zapier','slack','google','airtable','hubspot','intercom','segment']
WHERE slug = 'bubble';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":4,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['zapier','google','hubspot','intercom','segment','airtable','stripe']
WHERE slug = 'webflow';

-- Internal Tools
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":4,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','zapier','google','github','snowflake','salesforce','hubspot','airtable','stripe','segment']
WHERE slug = 'retool';

-- Forms
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['slack','zapier','google','hubspot','salesforce','airtable','notion','segment','intercom']
WHERE slug = 'typeform';

COMMIT;

-- Sanity check (run separately if needed):
-- SELECT slug FROM tools WHERE slug = ANY(ARRAY['mailchimp','klaviyo','mixpanel','amplitude','hotjar','posthog','pendo','heap','fullstory','segment','rudderstack','zendesk','intercom','freshdesk','helpscout','tidio','outreach','salesloft','reply-io','clay','attio','close','folk','miro','loom','opus-clip','bubble','webflow','retool','typeform']) AND array_length(integrations, 1) > 0;
-- Expected: 30 rows.
