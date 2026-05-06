-- S100 Mode D: integrations[] backfill for 30 tier 11 high-traffic tools.
-- Brings tools with integrations seeded from 282 to 312.
-- Picked from positions 1-100 of empty list (skipped consumer-creative
-- tools where SaaS integrations are minimal).
-- Categories: education/LMS, customer success/support, meeting AI,
--             productivity/docs/email, sales/CRM ops, legal/contracts,
--             cybersecurity, finance/AP, translation, HR/recruiting,
--             analytics, UX research, dev/LLM ops, no-code, automation.
-- All 30 slugs verified in DB via scripts/find-tier11-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely.

BEGIN;

-- Education / LMS (5)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'coursera-coach';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'nearpod';
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365'] WHERE slug = 'learnupon';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'magicschool-ai';
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365'] WHERE slug = 'absorb-lms';

-- Customer success / Support (3)
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','segment'] WHERE slug = 'planhat';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot'] WHERE slug = 'sprinklr';
UPDATE tools SET integrations = ARRAY['salesforce','slack','shopify','hubspot'] WHERE slug = 'gladly';

-- Meeting AI / Voice intelligence (3)
UPDATE tools SET integrations = ARRAY['slack','salesforce','hubspot','notion'] WHERE slug = 'grain';
UPDATE tools SET integrations = ARRAY['slack','salesforce','hubspot','calendar','notion'] WHERE slug = 'meetgeek';
UPDATE tools SET integrations = ARRAY['slack','salesforce','hubspot','notion'] WHERE slug = 'supernormal';

-- Productivity / Docs / Email (3)
UPDATE tools SET integrations = ARRAY['slack','github','microsoft-365'] WHERE slug = 'slab';
UPDATE tools SET integrations = ARRAY['gmail','calendar','google'] WHERE slug = 'shortwave';
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365'] WHERE slug = 'bloomfire';

-- Sales / CRM ops (2)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','stripe','slack'] WHERE slug = 'qwilr';
UPDATE tools SET integrations = ARRAY['salesforce','slack','gmail'] WHERE slug = 'affinity';

-- Legal / Contracts (3)
UPDATE tools SET integrations = ARRAY['salesforce','slack','microsoft-365','dropbox'] WHERE slug = 'ironclad';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','dropbox'] WHERE slug = 'contractbook';
UPDATE tools SET integrations = ARRAY['github','microsoft-365','dropbox'] WHERE slug = 'draftwise';

-- Cybersecurity (1)
UPDATE tools SET integrations = ARRAY['slack','github','jira','salesforce'] WHERE slug = 'orca-security';

-- Finance / AP automation (1)
UPDATE tools SET integrations = ARRAY['salesforce','slack','snowflake','microsoft-365'] WHERE slug = 'stampli';

-- Translation (1)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'poeditor';

-- HR / Recruiting (1)
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365','gmail','linkedin'] WHERE slug = 'ashby';

-- Analytics (2)
UPDATE tools SET integrations = ARRAY['slack'] WHERE slug = 'plausible';
UPDATE tools SET integrations = ARRAY['google','slack','microsoft-365'] WHERE slug = 'formula-bot';

-- UX research (1)
UPDATE tools SET integrations = ARRAY['slack','segment','salesforce'] WHERE slug = 'sprig';

-- Dev / LLM ops (3)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'langsmith';
UPDATE tools SET integrations = ARRAY['github','slack','jira'] WHERE slug = 'appsmith';
UPDATE tools SET integrations = ARRAY['google','slack','microsoft-365'] WHERE slug = 'julius-ai';

-- Automation hub (1)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack','shopify'] WHERE slug = 'albato';

COMMIT;
