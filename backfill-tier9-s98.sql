-- S98 Mode D: integrations[] backfill for 30 tier 9 high-traffic tools.
-- Brings tools with integrations seeded from 222 to 252.
-- Picked by review_count rank from the 327-empty list (next tier after S97 tier 8).
-- Categories: education/LMS, finance/expense, dev/infra, customer support,
--             social media, productivity/docs, marketing automation, sales,
--             UX research, cybersecurity, HR/recruiting, knowledge mgmt,
--             translation, voice.
-- All 30 slugs verified in DB via scripts/find-tier9-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

-- Education / LMS (5)
UPDATE tools SET integrations = ARRAY['google','microsoft-365','slack'] WHERE slug = 'kahoot-ai';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'gradescope-ai';
UPDATE tools SET integrations = ARRAY['slack','salesforce','shopify','zapier'] WHERE slug = 'talentlms';
UPDATE tools SET integrations = ARRAY['salesforce','slack','microsoft-365','hubspot'] WHERE slug = 'docebo';
UPDATE tools SET integrations = ARRAY['microsoft-365','slack'] WHERE slug = 'ispring';

-- Finance / Expense management (2)
UPDATE tools SET integrations = ARRAY['slack','salesforce','gmail','microsoft-365'] WHERE slug = 'ramp';
UPDATE tools SET integrations = ARRAY['slack','gmail','salesforce','microsoft-365'] WHERE slug = 'brex';

-- Dev / Infra (4)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'railway';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'zed';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'hugging-face';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'continue-dev';

-- Customer support (3)
UPDATE tools SET integrations = ARRAY['shopify','slack','salesforce','hubspot','gmail'] WHERE slug = 'gorgias';
UPDATE tools SET integrations = ARRAY['slack','hubspot','intercom','gmail'] WHERE slug = 'crisp';
UPDATE tools SET integrations = ARRAY['salesforce','slack','segment','hubspot'] WHERE slug = 'totango';

-- Social media management (3)
UPDATE tools SET integrations = ARRAY['slack','hubspot','salesforce','dropbox'] WHERE slug = 'agorapulse';
UPDATE tools SET integrations = ARRAY['slack','dropbox','microsoft-365'] WHERE slug = 'loomly';
UPDATE tools SET integrations = ARRAY['slack','dropbox','shopify'] WHERE slug = 'contentstudio';

-- Productivity / Docs (2)
UPDATE tools SET integrations = ARRAY['slack','github','notion','jira','salesforce'] WHERE slug = 'coda';
UPDATE tools SET integrations = ARRAY['slack','google','notion'] WHERE slug = 'pitch';

-- Marketing automation (1)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack','shopify','zapier'] WHERE slug = 'activecampaign';

-- Sales (2)
UPDATE tools SET integrations = ARRAY['gmail','salesforce','hubspot','linkedin'] WHERE slug = 'lavender';
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','stripe'] WHERE slug = 'proposify';

-- UX Research (2)
UPDATE tools SET integrations = ARRAY['slack','notion','jira'] WHERE slug = 'maze';
UPDATE tools SET integrations = ARRAY['slack','notion','github','gmail'] WHERE slug = 'dovetail';

-- Cybersecurity (2)
UPDATE tools SET integrations = ARRAY['slack','salesforce','jira','github'] WHERE slug = 'tenable-io';
UPDATE tools SET integrations = ARRAY['github','slack','jira','microsoft-365'] WHERE slug = 'snyk';

-- HR / Recruiting (1)
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365','gmail'] WHERE slug = 'lever';

-- Knowledge management (1)
UPDATE tools SET integrations = ARRAY['slack','microsoft-365','github'] WHERE slug = 'guru';

-- Translation (1)
UPDATE tools SET integrations = ARRAY['microsoft-365','github'] WHERE slug = 'trados';

-- Voice / Audio (1)
UPDATE tools SET integrations = ARRAY['slack','calendar'] WHERE slug = 'krisp';

COMMIT;

-- Verification:
-- SELECT slug, integrations FROM tools
--   WHERE slug IN ('kahoot-ai','gradescope-ai','talentlms','docebo','ispring',
--                  'ramp','brex','railway','zed','hugging-face','continue-dev',
--                  'gorgias','crisp','totango','agorapulse','loomly','contentstudio',
--                  'coda','pitch','activecampaign','lavender','proposify','maze',
--                  'dovetail','tenable-io','snyk','lever','guru','trados','krisp')
--   ORDER BY slug;
