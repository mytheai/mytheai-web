-- S104 Mode D: integrations[] backfill for 30 tier 15 long-tail B2B tools.
-- Brings tools with integrations seeded from 402 to 432 (78.7% coverage).
-- Picked from positions 1-200 of empty list. Quality dropping into 4.0-4.3
-- rating + 200-600 review_count range; long-tail by design.
-- Categories: customer service, healthcare AI, project management,
--             analytics/BI, UX research, dev tools/agents, writing/SEO,
--             education, voice/podcasting, productivity, content ops.
-- All 30 slugs verified in DB via scripts/find-tier15-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely.

BEGIN;

-- Customer Service / Support (4)
UPDATE tools SET integrations = ARRAY['salesforce','slack','segment'] WHERE slug = 'client-success';
UPDATE tools SET integrations = ARRAY['salesforce','slack','segment'] WHERE slug = 'akita';
UPDATE tools SET integrations = ARRAY['salesforce','slack','hubspot'] WHERE slug = 'capacity';
UPDATE tools SET integrations = ARRAY['github','slack','intercom','linear'] WHERE slug = 'plain';

-- Healthcare AI (4)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'abridge';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'corti';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'regard';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'anterior';

-- Project management (1)
UPDATE tools SET integrations = ARRAY['slack','github'] WHERE slug = 'huly';

-- Analytics / BI / Data ML (3)
UPDATE tools SET integrations = ARRAY['slack','snowflake','salesforce'] WHERE slug = 'gigasheet';
UPDATE tools SET integrations = ARRAY['google','snowflake','slack'] WHERE slug = 'obviously-ai';
UPDATE tools SET integrations = ARRAY['snowflake','slack','google'] WHERE slug = 'seek-ai';

-- UX research / Site analytics (2)
UPDATE tools SET integrations = ARRAY['slack','salesforce'] WHERE slug = 'playbook-ux';
UPDATE tools SET integrations = ARRAY['google','slack'] WHERE slug = 'diib';

-- Dev tools / Coding agents (3)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'devin-ai';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'cline';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'wordware';

-- Writing / SEO content (3)
UPDATE tools SET integrations = ARRAY['slack','hubspot'] WHERE slug = 'neuronwriter';
UPDATE tools SET integrations = ARRAY['slack','hubspot'] WHERE slug = 'keyword-insights';
UPDATE tools SET integrations = ARRAY['shopify','slack','hubspot'] WHERE slug = 'contentatscale';

-- Education (2)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'conker';
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'curipod';

-- Voice / Podcasting (1)
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'podcastle';

-- Productivity / PDF chat (1)
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'chatpdf';

-- Writing IDE (1)
UPDATE tools SET integrations = ARRAY['slack','hubspot'] WHERE slug = 'writerly-ai';

-- UI design (1)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'subframe';

-- Podcast SEO / repurposing (3)
UPDATE tools SET integrations = ARRAY['slack','salesforce'] WHERE slug = 'swell-ai';
UPDATE tools SET integrations = ARRAY['slack','dropbox'] WHERE slug = 'repurpose-io';
UPDATE tools SET integrations = ARRAY['slack','hubspot'] WHERE slug = 'narrato';

-- Social / LinkedIn writing (1)
UPDATE tools SET integrations = ARRAY['linkedin','slack'] WHERE slug = 'typefully';

COMMIT;
