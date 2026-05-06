-- S103 Mode D: integrations[] backfill for 30 tier 14 long-tail B2B tools.
-- Brings tools with integrations seeded from 372 to 402 (73.2% coverage).
-- Picked from positions 1-160 of empty list. Empty list now dominated by
-- consumer-creative cluster (image/video/voice gen) - filtering aggressive.
-- Categories: cybersecurity, HR/recruiting, customer service, healthcare,
--             UX research, project management, no-code/automation,
--             analytics, writing/SEO/content ops, dev tools, education.
-- All 30 slugs verified in DB via scripts/find-tier14-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely.

BEGIN;

-- Cybersecurity (3)
UPDATE tools SET integrations = ARRAY['slack','github','jira'] WHERE slug = 'aikido-security';
UPDATE tools SET integrations = ARRAY['slack','github','jira'] WHERE slug = 'socket-dev';
UPDATE tools SET integrations = ARRAY['slack','github','jira'] WHERE slug = 'cycode';

-- HR / Recruiting (3)
UPDATE tools SET integrations = ARRAY['salesforce','slack','microsoft-365','calendar'] WHERE slug = 'goodtime';
UPDATE tools SET integrations = ARRAY['salesforce','slack','microsoft-365','linkedin'] WHERE slug = 'beamery';
UPDATE tools SET integrations = ARRAY['slack','salesforce','microsoft-365'] WHERE slug = 'metaview';

-- Customer Service / Support (3)
UPDATE tools SET integrations = ARRAY['slack','hubspot','shopify'] WHERE slug = 're-amaze';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot'] WHERE slug = 'forethought';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot','intercom'] WHERE slug = 'dixa';

-- Healthcare AI (4)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'deepscribe';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'glass-health';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'aidoc';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'hippocratic-ai';

-- UX research / Product analytics (2)
UPDATE tools SET integrations = ARRAY['slack','salesforce'] WHERE slug = 'dscout';
UPDATE tools SET integrations = ARRAY['slack','segment','salesforce'] WHERE slug = 'june-so';

-- Project management (2)
UPDATE tools SET integrations = ARRAY['slack','github','salesforce'] WHERE slug = 'nifty';
UPDATE tools SET integrations = ARRAY['slack','google','calendar'] WHERE slug = 'taskade';

-- No-code / Automation / Agent ops (3)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'weweb';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'windmill';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'agentops';

-- Analytics / BI (2)
UPDATE tools SET integrations = ARRAY['google','snowflake','slack'] WHERE slug = 'polymer';
UPDATE tools SET integrations = ARRAY['github','slack','snowflake'] WHERE slug = 'outerbase';

-- Writing / Content ops (3)
UPDATE tools SET integrations = ARRAY['slack','dropbox','gmail'] WHERE slug = 'castmagic';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot'] WHERE slug = 'creatoriq';
UPDATE tools SET integrations = ARRAY['slack','hubspot'] WHERE slug = 'scalenut';

-- Dev tools / Web scraping (1)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'firecrawl';

-- Education (2)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'almanack-ai';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'diffit';

-- Healthcare extra (1)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'nabla';

-- SEO automation (1)
UPDATE tools SET integrations = ARRAY['shopify','slack'] WHERE slug = 'alli-ai';

COMMIT;
