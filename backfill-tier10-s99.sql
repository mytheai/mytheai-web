-- S99 Mode D: integrations[] backfill for 30 tier 10 high-traffic tools.
-- Brings tools with integrations seeded from 252 to 282.
-- Picked from positions 1-80 of empty list (skipped tier 9 picks +
-- consumer-creative tools where SaaS integrations are minimal).
-- Categories: communication, education/LMS, social media, customer support,
--             finance/accounting, CRM, automation, translation, meeting AI,
--             cybersecurity, healthcare, scheduling, sales/proposals,
--             knowledge/docs, project management, conversational AI.
-- All 30 slugs verified in DB via scripts/find-tier10-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely.

BEGIN;

-- Communication / collab platform (1)
UPDATE tools SET integrations = ARRAY['github','jira','salesforce','hubspot','notion','asana','linear','calendar'] WHERE slug = 'slack';

-- Education / LMS (4)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'edpuzzle-ai';
UPDATE tools SET integrations = ARRAY['salesforce','microsoft-365','slack'] WHERE slug = 'cornerstone';
UPDATE tools SET integrations = ARRAY['slack','microsoft-365','salesforce'] WHERE slug = '360learning';
UPDATE tools SET integrations = ARRAY['microsoft-365','slack','google'] WHERE slug = 'mentimeter';

-- Social media management (4)
UPDATE tools SET integrations = ARRAY['slack','hubspot'] WHERE slug = 'brand24';
UPDATE tools SET integrations = ARRAY['slack','dropbox','notion'] WHERE slug = 'planable';
UPDATE tools SET integrations = ARRAY['slack'] WHERE slug = 'flick-social';
UPDATE tools SET integrations = ARRAY['slack','dropbox'] WHERE slug = 'pallyy';

-- Customer support (2)
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot'] WHERE slug = 'liveagent';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','segment'] WHERE slug = 'churnzero';

-- Finance / Accounting (3)
UPDATE tools SET integrations = ARRAY['gmail','stripe','shopify'] WHERE slug = 'bench';
UPDATE tools SET integrations = ARRAY['gmail','stripe','slack'] WHERE slug = 'pilot';
UPDATE tools SET integrations = ARRAY['salesforce','slack','microsoft-365','snowflake'] WHERE slug = 'tipalti';

-- CRM (1)
UPDATE tools SET integrations = ARRAY['gmail','calendar','slack','google'] WHERE slug = 'kommo';

-- Automation hub (1)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack','github','gmail'] WHERE slug = 'integrately';

-- Translation / Localization (1)
UPDATE tools SET integrations = ARRAY['github','slack','jira'] WHERE slug = 'transifex';

-- Meeting AI / Voice intelligence (3)
UPDATE tools SET integrations = ARRAY['slack','salesforce','hubspot','notion'] WHERE slug = 'tactiq';
UPDATE tools SET integrations = ARRAY['slack','salesforce','hubspot','calendar'] WHERE slug = 'read-ai';
UPDATE tools SET integrations = ARRAY['slack','notion','calendar','google'] WHERE slug = 'notta';

-- Cybersecurity (1)
UPDATE tools SET integrations = ARRAY['slack','github','jira'] WHERE slug = 'wiz';

-- Healthcare (2)
UPDATE tools SET integrations = ARRAY['google','calendar'] WHERE slug = 'doximity';
UPDATE tools SET integrations = ARRAY['google','calendar'] WHERE slug = 'viz-ai';

-- Scheduling / Productivity (1)
UPDATE tools SET integrations = ARRAY['google','calendar','slack','salesforce','asana'] WHERE slug = 'reclaim-ai';

-- Sales / Proposals (1)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','stripe','zapier'] WHERE slug = 'better-proposals';

-- Knowledge / Docs (2)
UPDATE tools SET integrations = ARRAY['slack','github','microsoft-365'] WHERE slug = 'document360';
UPDATE tools SET integrations = ARRAY['github','slack','jira'] WHERE slug = 'gitbook';

-- Customer success / Onboarding (1)
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','segment'] WHERE slug = 'userpilot';

-- Project management (1)
UPDATE tools SET integrations = ARRAY['slack','github','salesforce','dropbox'] WHERE slug = 'teamwork';

-- Conversational AI / Chatbot platform (1)
UPDATE tools SET integrations = ARRAY['slack','salesforce','intercom','hubspot'] WHERE slug = 'voiceflow';

COMMIT;
