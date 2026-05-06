-- S102 Mode D: integrations[] backfill for 30 tier 13 high-traffic tools.
-- Brings tools with integrations seeded from 342 to 372.
-- Picked from positions 1-130 of empty list (skipped consumer-creative
-- cluster: image/video/voice gen + Adobe consumer + design apps).
-- Categories: customer support/success, education, legal/contracts,
--             healthcare scribes, finance/accounting, cybersecurity,
--             UX research, HR, translation, analytics, writing/SEO,
--             project management, reading, sales/local, voice AI,
--             dev sandbox.
-- All 30 slugs verified in DB via scripts/find-tier13-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely.

BEGIN;

-- Customer Support / Success (4)
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','intercom'] WHERE slug = 'freshchat';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','gmail'] WHERE slug = 'groove';
UPDATE tools SET integrations = ARRAY['slack','salesforce','hubspot','intercom'] WHERE slug = 'helpjuice';
UPDATE tools SET integrations = ARRAY['salesforce','slack','segment','hubspot'] WHERE slug = 'custify';

-- Education (4)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'khanmigo';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'brisk-teaching';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'schoolai';
UPDATE tools SET integrations = ARRAY['microsoft-365','google'] WHERE slug = 'classpoint';

-- Legal / Contracts (2)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack','dropbox'] WHERE slug = 'juro';
UPDATE tools SET integrations = ARRAY['microsoft-365','dropbox'] WHERE slug = 'zuva';

-- Healthcare scribes (2)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'nuance-dax';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'suki-ai';

-- Finance / Accounting (3)
UPDATE tools SET integrations = ARRAY['slack','salesforce','snowflake'] WHERE slug = 'docyt';
UPDATE tools SET integrations = ARRAY['slack','stripe'] WHERE slug = 'zeni';
UPDATE tools SET integrations = ARRAY['stripe','slack','snowflake'] WHERE slug = 'baremetrics';

-- Cybersecurity (1)
UPDATE tools SET integrations = ARRAY['slack','github','jira'] WHERE slug = 'detectify';

-- UX Research (3)
UPDATE tools SET integrations = ARRAY['slack','jira'] WHERE slug = 'lookback';
UPDATE tools SET integrations = ARRAY['slack','salesforce'] WHERE slug = 'respondent';
UPDATE tools SET integrations = ARRAY['slack','salesforce','dropbox'] WHERE slug = 'userlytics';

-- HR / Talent intelligence (1)
UPDATE tools SET integrations = ARRAY['salesforce','slack','microsoft-365','linkedin'] WHERE slug = 'eightfold';

-- Translation (1)
UPDATE tools SET integrations = ARRAY['salesforce','slack','intercom'] WHERE slug = 'unbabel';

-- Analytics / Predictive (1)
UPDATE tools SET integrations = ARRAY['google','snowflake','slack','salesforce'] WHERE slug = 'akkio';

-- Writing / SEO / AI detection (2)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'originality-ai';
UPDATE tools SET integrations = ARRAY['shopify','slack','hubspot'] WHERE slug = 'hypotenuse-ai';

-- Project management (2)
UPDATE tools SET integrations = ARRAY['slack','github','salesforce'] WHERE slug = 'productive';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'plane-so';

-- Reading / Knowledge (1)
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'readwise';

-- Sales / Local business (1)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot'] WHERE slug = 'podium';

-- Voice API platform (1)
UPDATE tools SET integrations = ARRAY['slack','github'] WHERE slug = 'vapi';

-- Dev / Code execution sandbox (1)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'e2b';

COMMIT;
