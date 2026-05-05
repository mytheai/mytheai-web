-- S96 Mode D: integrations[] backfill for 30 tier 6 vertical leaders.
-- Brings tools with integrations seeded from 132 to ~162.
-- 6 tools also receive hand-curated scores (anduril, coupa, greenly,
-- palantir, persefoni, watershed); brings curated scores 139 to ~145.
-- Categories: compliance/legal, HR, procurement, hospitality, climate,
--             real estate, insurance, defense, customer service, healthcare,
--             legal tech, education.
-- All 30 slugs verified in DB via scripts/check-tier6-candidates.mjs.
-- Tags drawn only from existing controlled vocabulary (21 tags).
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

-- Compliance / Privacy (2)
UPDATE tools SET
  integrations = ARRAY['github','slack','salesforce','jira','microsoft-365']
WHERE slug = 'vanta';

UPDATE tools SET
  integrations = ARRAY['salesforce','microsoft-365','slack','intercom']
WHERE slug = 'onetrust';

-- HR / People Ops (5)
UPDATE tools SET
  integrations = ARRAY['slack','google','calendar','github','microsoft-365']
WHERE slug = 'lattice';

UPDATE tools SET
  integrations = ARRAY['slack','calendar','google','microsoft-365']
WHERE slug = 'culture-amp';

UPDATE tools SET
  integrations = ARRAY['slack','google','calendar','asana']
WHERE slug = '15five';

UPDATE tools SET
  integrations = ARRAY['slack','google','gmail']
WHERE slug = 'gusto';

UPDATE tools SET
  integrations = ARRAY['slack','google','calendar','microsoft-365']
WHERE slug = 'hibob';

-- Procurement (1, includes scores)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":3,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['salesforce','slack','snowflake','microsoft-365']
WHERE slug = 'coupa';

-- Hospitality / Travel (4)
UPDATE tools SET
  integrations = ARRAY['stripe','slack','google']
WHERE slug = 'mews';

UPDATE tools SET
  integrations = ARRAY['stripe','google']
WHERE slug = 'cloudbeds';

UPDATE tools SET
  integrations = ARRAY['stripe','airtable','google']
WHERE slug = 'guesty';

UPDATE tools SET
  integrations = ARRAY['slack','salesforce','calendar']
WHERE slug = 'navan';

-- Climate / Sustainability (3, all include scores)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":2.5,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['slack','google','salesforce','snowflake']
WHERE slug = 'watershed';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":3,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['salesforce','microsoft-365','snowflake']
WHERE slug = 'persefoni';

UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4,"feature_depth":3.5,"integrations":3,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','google']
WHERE slug = 'greenly';

-- Real Estate / Proptech (2)
UPDATE tools SET
  integrations = ARRAY['salesforce','google']
WHERE slug = 'compass';

UPDATE tools SET
  integrations = ARRAY['salesforce','hubspot','dropbox']
WHERE slug = 'matterport';

-- Insurance (1)
UPDATE tools SET
  integrations = ARRAY['stripe']
WHERE slug = 'lemonade';

-- Defense / Aerospace (2, both include scores)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":2,"pricing_value":1.5,"feature_depth":5,"integrations":3.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github','snowflake']
WHERE slug = 'palantir';

UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":2,"pricing_value":2,"feature_depth":5,"integrations":3,"reliability":4,"trajectory":5}'::jsonb,
  integrations = ARRAY['github']
WHERE slug = 'anduril';

-- Customer Service / Support (5)
UPDATE tools SET
  integrations = ARRAY['salesforce','hubspot','slack','intercom']
WHERE slug = 'intercom-fin';

UPDATE tools SET
  integrations = ARRAY['salesforce','slack','intercom','hubspot']
WHERE slug = 'ada-ai';

UPDATE tools SET
  integrations = ARRAY['salesforce','slack','intercom']
WHERE slug = 'decagon-ai';

UPDATE tools SET
  integrations = ARRAY['slack','microsoft-365','jira','github']
WHERE slug = 'moveworks';

UPDATE tools SET
  integrations = ARRAY['salesforce','slack','intercom']
WHERE slug = 'yellow-ai';

-- Healthcare AI (3)
UPDATE tools SET
  integrations = ARRAY['google','calendar']
WHERE slug = 'heidi-health';

UPDATE tools SET
  integrations = ARRAY['google','calendar']
WHERE slug = 'freed-ai';

UPDATE tools SET
  integrations = ARRAY['google']
WHERE slug = 'ambience-healthcare';

-- Legal Tech (3)
UPDATE tools SET
  integrations = ARRAY['github','microsoft-365','dropbox']
WHERE slug = 'paxton-ai';

UPDATE tools SET
  integrations = ARRAY['microsoft-365','slack','dropbox']
WHERE slug = 'everlaw';

UPDATE tools SET
  integrations = ARRAY['microsoft-365','dropbox']
WHERE slug = 'kira-systems';

COMMIT;

-- Verification:
-- SELECT slug, integrations FROM tools
--   WHERE slug IN ('vanta','onetrust','lattice','culture-amp','15five','gusto','hibob',
--                  'coupa','mews','cloudbeds','guesty','navan','watershed','persefoni','greenly',
--                  'compass','matterport','lemonade','palantir','anduril','intercom-fin',
--                  'ada-ai','decagon-ai','moveworks','yellow-ai','heidi-health','freed-ai',
--                  'ambience-healthcare','paxton-ai','everlaw','kira-systems')
--   ORDER BY slug;
