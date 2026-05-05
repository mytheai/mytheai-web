-- S97 Mode D: integrations[] backfill for 30 tier 8 high-traffic tools.
-- Picked by review_count (popularity proxy) + clear integration ecosystem.
-- Brings tools with integrations seeded from 192 to ~222.
-- Categories: meetings, automation, sales, email marketing, scheduling,
--             docs/contracts, social, HRIS, CRM, presentations, support.
-- All 30 slugs verified in DB via scripts/find-tier8-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely.

BEGIN;

-- Meetings / Communication (3)
UPDATE tools SET integrations = ARRAY['slack','google','salesforce','calendar','microsoft-365'] WHERE slug = 'zoom';
UPDATE tools SET integrations = ARRAY['github','microsoft-365','jira','salesforce','asana'] WHERE slug = 'microsoft-teams';
UPDATE tools SET integrations = ARRAY['google','calendar','slack'] WHERE slug = 'google-meet';

-- Automation hubs (2)
UPDATE tools SET integrations = ARRAY['salesforce','slack','snowflake','hubspot','github','jira'] WHERE slug = 'workato';
UPDATE tools SET integrations = ARRAY['salesforce','slack','snowflake','hubspot'] WHERE slug = 'tray-io';

-- Sales engagement / Revenue (2)
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','gmail'] WHERE slug = 'gong-io';
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack','gmail','zapier'] WHERE slug = 'lemlist';

-- Email marketing / Newsletter (2)
UPDATE tools SET integrations = ARRAY['shopify','stripe','zapier','salesforce'] WHERE slug = 'mailerlite';
UPDATE tools SET integrations = ARRAY['shopify','stripe','salesforce'] WHERE slug = 'omnisend';

-- E-signatures / Contracts (3)
UPDATE tools SET integrations = ARRAY['salesforce','microsoft-365','slack','hubspot','dropbox'] WHERE slug = 'docusign-ai';
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','stripe','zapier','dropbox'] WHERE slug = 'pandadoc';
UPDATE tools SET integrations = ARRAY['salesforce','microsoft-365','dropbox'] WHERE slug = 'adobe-sign';

-- Social media (3)
UPDATE tools SET integrations = ARRAY['slack','dropbox','shopify'] WHERE slug = 'publer';
UPDATE tools SET integrations = ARRAY['slack','dropbox'] WHERE slug = 'vista-social';
UPDATE tools SET integrations = ARRAY['slack'] WHERE slug = 'hypefury';

-- Customer success / Support (3)
UPDATE tools SET integrations = ARRAY['salesforce','slack','snowflake','hubspot'] WHERE slug = 'gainsight';
UPDATE tools SET integrations = ARRAY['salesforce','slack'] WHERE slug = 'zoho-desk';
UPDATE tools SET integrations = ARRAY['salesforce','slack','gmail','intercom'] WHERE slug = 'front-app';

-- HRIS / Recruiting (3)
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365','google'] WHERE slug = 'rippling';
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365','gmail'] WHERE slug = 'greenhouse';
UPDATE tools SET integrations = ARRAY['slack','microsoft-365','calendar'] WHERE slug = 'bamboohr';

-- CRM (2)
UPDATE tools SET integrations = ARRAY['gmail','calendar','google','zapier'] WHERE slug = 'streak';
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack','gmail','zapier'] WHERE slug = 'close-crm';

-- Scheduling / Calendar (1)
UPDATE tools SET integrations = ARRAY['google','calendar','slack','salesforce','hubspot'] WHERE slug = 'cal-com';

-- Email client (1)
UPDATE tools SET integrations = ARRAY['gmail','calendar','google'] WHERE slug = 'spark-mail';

-- Presentations / Docs (1)
UPDATE tools SET integrations = ARRAY['slack','notion','google'] WHERE slug = 'gamma-app';

-- Video / Editing (1)
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'veed-io';

-- Legal practice (1)
UPDATE tools SET integrations = ARRAY['salesforce','microsoft-365','dropbox','calendar'] WHERE slug = 'clio';

-- Education / LMS (1)
UPDATE tools SET integrations = ARRAY['google','microsoft-365','slack'] WHERE slug = 'articulate';

-- Marketing analytics (1)
UPDATE tools SET integrations = ARRAY['shopify','salesforce','slack'] WHERE slug = 'metricool';

COMMIT;
