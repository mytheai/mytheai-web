-- S105 Mode D: integrations[] backfill for 30 tier 16 long-tail B2B-adjacent tools.
-- Brings tools with integrations seeded from 432 to 462 (84.2% coverage).
-- Picked from positions 1-117 of empty list (top 250 pool, all 117 visible).
-- Focus: tools with real integration angles even within long-tail consumer-creative
-- cluster - LLM platforms, dev IDE, presentation tools, SEO writing assistants,
-- UI design AI, code gen with deploy.
-- Categories: LLM platforms/APIs (3), writing/SEO (5), presentations (5),
--             code gen/dev tools (5), UI design AI (3), proposals (1),
--             video collab (2), education (1), analytics (1), browser AI (1),
--             remote work (1), Webflow assist (1), writing IDE (1).
-- All 30 slugs verified in DB via scripts/find-tier16-candidates.mjs.
-- Tags drawn only from existing 21-tag controlled vocabulary.
-- Idempotent: re-run safely.

BEGIN;

-- LLM platforms / APIs (3)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'dify';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'flowise';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'together-ai';

-- Writing / SEO content (5)
UPDATE tools SET integrations = ARRAY['shopify','salesforce','hubspot','slack'] WHERE slug = 'anyword';
UPDATE tools SET integrations = ARRAY['slack','hubspot'] WHERE slug = 'longshot-ai';
UPDATE tools SET integrations = ARRAY['slack','hubspot'] WHERE slug = 'cohesive-ai';
UPDATE tools SET integrations = ARRAY['slack','gmail','google'] WHERE slug = 'hyperwrite';
UPDATE tools SET integrations = ARRAY['slack','hubspot'] WHERE slug = 'dashword';

-- SEO writing / content optimization (1)
UPDATE tools SET integrations = ARRAY['slack','hubspot','shopify'] WHERE slug = 'reword';

-- Writing IDE (1)
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'lex';

-- Presentations (5)
UPDATE tools SET integrations = ARRAY['google','microsoft-365'] WHERE slug = 'genially';
UPDATE tools SET integrations = ARRAY['slack','google','dropbox'] WHERE slug = 'beautiful-ai';
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'slidebean';
UPDATE tools SET integrations = ARRAY['slack','hubspot','dropbox'] WHERE slug = 'visme';
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'decktopus';

-- Office / Presentation suite (1)
UPDATE tools SET integrations = ARRAY['google','microsoft-365','dropbox'] WHERE slug = 'zoho-show';

-- Interactive proposals / sales docs (1)
UPDATE tools SET integrations = ARRAY['salesforce','hubspot','slack'] WHERE slug = 'storydoc';

-- Code gen / Full-stack agents (3)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'lovable';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'bolt';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'trae';

-- Code completion / Dev productivity (2)
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'supermaven';
UPDATE tools SET integrations = ARRAY['github','slack'] WHERE slug = 'pieces-for-developers';

-- UI design AI (3)
UPDATE tools SET integrations = ARRAY['slack','github'] WHERE slug = 'uizard';
UPDATE tools SET integrations = ARRAY['slack','github'] WHERE slug = 'galileo-ai';
UPDATE tools SET integrations = ARRAY['slack','github'] WHERE slug = 'visily';

-- Webflow component AI (1)
UPDATE tools SET integrations = ARRAY['slack','dropbox'] WHERE slug = 'relume';

-- Video collab (1)
UPDATE tools SET integrations = ARRAY['google','dropbox','slack'] WHERE slug = 'kapwing';

-- Analytics chat / Data assistant (1)
UPDATE tools SET integrations = ARRAY['google','snowflake'] WHERE slug = 'hal9';

-- Browser AI assistant (1)
UPDATE tools SET integrations = ARRAY['slack','github'] WHERE slug = 'merlin';

-- Live presentations / Remote work (1)
UPDATE tools SET integrations = ARRAY['google','calendar','slack'] WHERE slug = 'mmhmm';

COMMIT;
