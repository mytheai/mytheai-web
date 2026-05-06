-- S101 Mode D: integrations[] backfill for 30 tier 12 high-traffic tools.
-- Brings tools with integrations seeded from 312 to 342.
-- Picked from positions 1-120 of empty list (skipped consumer-creative
-- tools where SaaS integrations are minimal).
-- Categories: education/LMS, analytics/data, customer success,
--             productivity/docs/knowledge, legal/contracts, meeting AI,
--             finance/accounting, sales/RFP, UX research, no-code,
--             project management, translation, conversational voice AI,
--             research.
-- All 30 slugs verified in DB via scripts/find-tier12-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely.

BEGIN;

-- Education / LMS (3)
UPDATE tools SET integrations = ARRAY['salesforce','slack','microsoft-365'] WHERE slug = 'litmos';
UPDATE tools SET integrations = ARRAY['salesforce','slack','microsoft-365','shopify'] WHERE slug = 'skilljar';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'synthesis-tutor';

-- Analytics / Data (3)
UPDATE tools SET integrations = ARRAY['stripe','slack','hubspot','salesforce'] WHERE slug = 'chartmogul';
UPDATE tools SET integrations = ARRAY['github','slack','snowflake','google'] WHERE slug = 'deepnote';
UPDATE tools SET integrations = ARRAY['google','slack','github','snowflake'] WHERE slug = 'rows';

-- Customer Success / Support (3)
UPDATE tools SET integrations = ARRAY['slack','hubspot','shopify','intercom'] WHERE slug = 'chatwoot';
UPDATE tools SET integrations = ARRAY['salesforce','slack','segment','hubspot'] WHERE slug = 'vitally';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','segment'] WHERE slug = 'catalyst';

-- Productivity / Knowledge / Docs (3)
UPDATE tools SET integrations = ARRAY['slack','github','notion'] WHERE slug = 'slite';
UPDATE tools SET integrations = ARRAY['slack','github','google'] WHERE slug = 'nuclino';
UPDATE tools SET integrations = ARRAY['slack','github','google'] WHERE slug = 'tettra';

-- Legal / Contracts (3)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack','dropbox'] WHERE slug = 'oneflow';
UPDATE tools SET integrations = ARRAY['microsoft-365','slack','salesforce'] WHERE slug = 'spellbook-ai';
UPDATE tools SET integrations = ARRAY['microsoft-365','slack','salesforce'] WHERE slug = 'harvey-ai';

-- Meeting AI / Sales intelligence (3)
UPDATE tools SET integrations = ARRAY['slack','salesforce','hubspot','calendar'] WHERE slug = 'sembly-ai';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot'] WHERE slug = 'modjo';
UPDATE tools SET integrations = ARRAY['slack','salesforce','hubspot','calendar'] WHERE slug = 'avoma';

-- Sales / RFP / CPQ (3)
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','gmail'] WHERE slug = 'laxis';
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack'] WHERE slug = 'dealhub';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot'] WHERE slug = 'loopio';

-- Finance / Accounting (2)
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365','snowflake'] WHERE slug = 'airbase';
UPDATE tools SET integrations = ARRAY['salesforce','slack','snowflake'] WHERE slug = 'vic-ai';

-- UX Research (1)
UPDATE tools SET integrations = ARRAY['slack','dropbox'] WHERE slug = 'optimal-workshop';

-- No-code / Automation (2)
UPDATE tools SET integrations = ARRAY['github','slack','stripe'] WHERE slug = 'xano';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'val-town';

-- Project management (1)
UPDATE tools SET integrations = ARRAY['slack','github','salesforce','dropbox'] WHERE slug = 'hive';

-- Translation (1)
UPDATE tools SET integrations = ARRAY['slack','github','salesforce'] WHERE slug = 'lilt';

-- Conversational voice AI (1)
UPDATE tools SET integrations = ARRAY['salesforce','slack'] WHERE slug = 'bland-ai';

-- Research (1)
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'humata';

COMMIT;
