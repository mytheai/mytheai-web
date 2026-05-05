-- S97 Mode D: integrations[] backfill for 30 tier 7 cross-category tools.
-- Brings tools with integrations seeded from 162 to ~192.
-- Categories: e-commerce, translation/localization, sales engagement,
--             email marketing, social media, customer support, analytics,
--             collab/PM, no-code, devtools.
-- All 30 slugs verified in DB via scripts/check-tier7-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

-- E-commerce / Shopify ecosystem (5)
UPDATE tools SET integrations = ARRAY['shopify','stripe','google'] WHERE slug = 'shopify-magic';
UPDATE tools SET integrations = ARRAY['shopify','zapier','slack'] WHERE slug = 'octane-ai';
UPDATE tools SET integrations = ARRAY['shopify','zapier'] WHERE slug = 'recart';
UPDATE tools SET integrations = ARRAY['shopify','google'] WHERE slug = 'weglot';
UPDATE tools SET integrations = ARRAY['shopify','salesforce'] WHERE slug = 'syte';

-- Translation / Localization (5)
UPDATE tools SET integrations = ARRAY['google','microsoft-365','slack','gmail'] WHERE slug = 'deepl';
UPDATE tools SET integrations = ARRAY['salesforce','microsoft-365','slack','github'] WHERE slug = 'smartling';
UPDATE tools SET integrations = ARRAY['github','slack','jira'] WHERE slug = 'lokalise';
UPDATE tools SET integrations = ARRAY['github','jira','slack'] WHERE slug = 'phrase';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'crowdin';

-- Sales engagement (1)
UPDATE tools SET integrations = ARRAY['salesforce','gmail','slack','linkedin'] WHERE slug = 'amplemarket';

-- Email marketing / Newsletter (2)
UPDATE tools SET integrations = ARRAY['stripe','zapier'] WHERE slug = 'beehiiv';
UPDATE tools SET integrations = ARRAY['stripe'] WHERE slug = 'substack';

-- Social media (4)
UPDATE tools SET integrations = ARRAY['slack','zapier','dropbox'] WHERE slug = 'buffer';
UPDATE tools SET integrations = ARRAY['slack','zapier','salesforce','dropbox'] WHERE slug = 'hootsuite';
UPDATE tools SET integrations = ARRAY['slack','zapier','dropbox'] WHERE slug = 'later';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot'] WHERE slug = 'sprout-social';

-- Customer support / Conversational (2)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack','intercom'] WHERE slug = 'drift';
UPDATE tools SET integrations = ARRAY['salesforce','slack','intercom'] WHERE slug = 'kustomer';

-- Analytics / BI (3)
UPDATE tools SET integrations = ARRAY['snowflake','salesforce','slack','google'] WHERE slug = 'tableau';
UPDATE tools SET integrations = ARRAY['snowflake','slack','google'] WHERE slug = 'looker';
UPDATE tools SET integrations = ARRAY['github','slack','snowflake'] WHERE slug = 'metabase';

-- Project management / Collab (3)
UPDATE tools SET integrations = ARRAY['slack','salesforce','github','microsoft-365'] WHERE slug = 'wrike';
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365','jira'] WHERE slug = 'smartsheet';
UPDATE tools SET integrations = ARRAY['slack','github','gmail'] WHERE slug = 'basecamp';

-- Dev tools (1)
UPDATE tools SET integrations = ARRAY['github','slack','jira'] WHERE slug = 'cody';

-- No-code (4)
UPDATE tools SET integrations = ARRAY['airtable','stripe','google'] WHERE slug = 'softr';
UPDATE tools SET integrations = ARRAY['airtable','slack','zapier'] WHERE slug = 'glide';
UPDATE tools SET integrations = ARRAY['stripe','airtable'] WHERE slug = 'adalo';
UPDATE tools SET integrations = ARRAY['airtable','stripe','slack'] WHERE slug = 'noloco';

COMMIT;

-- Verification:
-- SELECT slug, integrations FROM tools
--   WHERE slug IN ('shopify-magic','octane-ai','recart','weglot','syte','deepl','smartling','lokalise',
--                  'phrase','crowdin','amplemarket','beehiiv','substack','buffer','hootsuite','later',
--                  'sprout-social','drift','kustomer','tableau','looker','metabase','wrike','smartsheet',
--                  'basecamp','cody','softr','glide','adalo','noloco')
--   ORDER BY slug;
