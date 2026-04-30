-- compare-batch-55.sql
-- 5 AI Customer Service tool comparison pairs
-- All tool slugs confirmed in DB from tools-batch-55.sql
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. intercom-fin-vs-ada-ai (per-resolution SaaS vs enterprise customization)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'intercom-fin-vs-ada-ai',
  'intercom-fin',
  'ada-ai',
  'Intercom Fin and Ada are both AI customer service platforms with autonomous resolution capabilities, but they target different segments. Fin is the AI agent inside the Intercom platform with $0.99 per-resolution pricing - the lowest friction option for SaaS companies and DTC brands already on Intercom. Ada targets enterprise brands needing deep customization, multi-channel coverage (chat, email, voice, social), and integrations with complex enterprise systems. Fin wins on simplicity and pricing transparency. Ada wins on enterprise breadth, regulated industry support, and customization depth. The decision usually comes down to whether you are already on Intercom (pick Fin) or running a complex enterprise support operation (pick Ada).',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'intercom-fin-vs-ada-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'intercom-fin-vs-ada-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Pricing Transparency',       5, 2, 'Fin is $0.99/resolution; Ada is custom enterprise only'),
  ('Enterprise Customization',   3, 5, 'Ada offers deeper conversation flow customization for regulated industries'),
  ('Implementation Time',        5, 2, 'Fin enables in days for Intercom users; Ada takes 8-16 weeks'),
  ('Multi-Channel Coverage',     3, 5, 'Ada handles chat, email, voice, social; Fin focused on chat'),
  ('Regulated Industry Fit',     3, 5, 'Ada has stronger compliance posture and deployment patterns'),
  ('Native Helpdesk Integration', 5, 4, 'Fin is native to Intercom; Ada integrates with Zendesk, Salesforce, others'),
  ('Best Fit Org Size',          4, 4, 'Fin: SaaS startups to mid-market on Intercom; Ada: enterprise 1000+ tickets/month')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'intercom-fin-vs-ada-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'intercom-fin-vs-ada-ai');

-- 2. decagon-ai-vs-forethought-ai (autonomous resolution vs full lifecycle)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'decagon-ai-vs-forethought-ai',
  'decagon-ai',
  'forethought-ai',
  'Decagon and Forethought both target customer service automation but with different philosophies. Decagon focuses on autonomous resolution - the AI reasons through queries using the company''s knowledge base and resolves end-to-end, with continuous learning to improve over time. Forethought offers a 3-module suite covering the full ticket lifecycle: Solve (deflection), Triage (routing), Assist (real-time agent help). Decagon goes deep on one job and does it exceptionally well. Forethought offers breadth across deflection, routing, and agent assist for support orgs that want a single platform. Pick Decagon for autonomous resolution-first deployments. Pick Forethought when you need deflection plus routing plus agent assist in one tool.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'decagon-ai-vs-forethought-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'decagon-ai-vs-forethought-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Autonomous Resolution Quality', 5, 4, 'Decagon focuses on this; reports 60-80% deflection after 90 days'),
  ('Ticket Triage and Routing',     2, 5, 'Forethought''s Triage module is purpose-built for this'),
  ('Real-time Agent Assist',        2, 5, 'Forethought''s Assist module sits in agent ticket view'),
  ('Continuous Learning Loop',      5, 3, 'Decagon surfaces knowledge gaps automatically for improvement'),
  ('Modular vs Monolithic',         3, 5, 'Forethought sells modules separately; Decagon is single platform'),
  ('Implementation Time',           4, 4, 'Both 4-8 weeks for full deployment'),
  ('Best Fit',                      5, 4, 'Decagon: high-growth scaleups; Forethought: support orgs wanting unified tooling')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'decagon-ai-vs-forethought-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'decagon-ai-vs-forethought-ai');

-- 3. moveworks-vs-espressive (enterprise vs mid-market employee AI)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'moveworks-vs-espressive',
  'moveworks',
  'espressive',
  'Moveworks and Espressive both build AI copilots for internal employee support (IT, HR, workplace), but they target different segments. Moveworks is the enterprise standard - deep customization, action-taking across 100+ enterprise systems, high six-figure annual minimums, and 3-6 month implementations designed for Fortune 1000 companies with 1,000+ employees. Espressive offers a more standardized mid-market deployment with pre-built knowledge packs covering the most common HR, IT, facilities, and procurement queries. Moveworks wins on customization depth and enterprise integration breadth. Espressive wins on time-to-value and pricing accessibility for mid-market companies (500-2,000 employees).',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'moveworks-vs-espressive');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'moveworks-vs-espressive', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Enterprise Customization',    5, 3, 'Moveworks offers deeper customization for very large enterprises'),
  ('Mid-Market Pricing Fit',      2, 5, 'Espressive accessible at mid-market scale; Moveworks high six-figure minimum'),
  ('Pre-Built Knowledge Packs',   3, 5, 'Espressive accelerates deployment with HR, IT, facilities, procurement packs'),
  ('System Integration Breadth',  5, 4, 'Moveworks integrates 100+ enterprise systems; Espressive 80+'),
  ('Implementation Time',         2, 4, 'Espressive 6-12 weeks; Moveworks 3-6 months'),
  ('Slack and Teams Native',      5, 5, 'Both work natively in Slack and Microsoft Teams'),
  ('Best Fit Company Size',       4, 5, 'Moveworks: Fortune 1000 with 1,000+ employees; Espressive: 500-5,000 employees')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'moveworks-vs-espressive')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'moveworks-vs-espressive');

-- 4. ultimate-ai-vs-yellow-ai (multilingual customer service platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'ultimate-ai-vs-yellow-ai',
  'ultimate-ai',
  'yellow-ai',
  'Ultimate and Yellow.ai both serve global enterprises with multilingual customer service automation, but with different strengths. Ultimate (now part of Zendesk) is the deepest Zendesk integration available and excels at ecommerce-native workflows like order management, returns, and account actions. Yellow.ai supports 35+ channels including voice, WhatsApp, and social with strong presence in Asia-Pacific markets. Ultimate covers 100+ languages; Yellow covers 135+ languages with stronger voice AI capabilities. Ultimate fits global ecommerce brands on Zendesk. Yellow fits Asia-Pacific enterprises and organizations needing voice-first customer service automation.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ultimate-ai-vs-yellow-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'ultimate-ai-vs-yellow-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Language Coverage',          4, 5, 'Ultimate: 100+ languages; Yellow: 135+ languages'),
  ('Voice AI Capability',        2, 5, 'Yellow has strong voice AI; Ultimate primarily text-based'),
  ('Zendesk Integration Depth',  5, 3, 'Ultimate is now part of Zendesk; deepest integration available'),
  ('Ecommerce Workflows',        5, 3, 'Ultimate has stronger ecommerce-specific actions and integrations'),
  ('Asia-Pacific Presence',      3, 5, 'Yellow has stronger presence in Asia-Pacific markets'),
  ('Channel Coverage',           4, 5, 'Yellow supports 35+ channels; Ultimate fewer but deeper'),
  ('Brand Recognition (NA/EU)',  4, 3, 'Ultimate more established in North America; Yellow stronger in APAC')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ultimate-ai-vs-yellow-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'ultimate-ai-vs-yellow-ai');

-- 5. lang-io-vs-forethought-ai (augment vs replace approaches)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'lang-io-vs-forethought-ai',
  'lang-io',
  'forethought-ai',
  'Lang.io and Forethought take fundamentally different approaches to customer service AI. Lang.io is an AI augmentation layer - it sits on top of existing helpdesks (Zendesk, Salesforce, Front) and improves how human agents and existing automation handle tickets through high-accuracy tagging, routing, and analytics. Forethought offers a full deflection and automation suite (Solve, Triage, Assist) that aims to replace or significantly reduce human agent involvement on tier-1 tickets. Lang augments humans without replacing them. Forethought reduces human workload through automation. Lang fits orgs that want analytics and routing improvements without changing their support model. Forethought fits orgs willing to invest in autonomous deflection and the knowledge base curation it requires.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lang-io-vs-forethought-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'lang-io-vs-forethought-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Ticket Deflection',          1, 5, 'Forethought''s Solve deflects tickets; Lang does not'),
  ('AI Tagging and Routing',     5, 4, 'Lang specializes in high-accuracy tagging; Forethought includes via Triage'),
  ('Agent Assist',               2, 5, 'Forethought Assist sits in agent view; Lang does not offer this'),
  ('Switching Cost',             5, 3, 'Lang augments existing helpdesk; Forethought requires more workflow change'),
  ('Pattern Detection Analytics', 5, 3, 'Lang surfaces ticket patterns for support leadership decisions'),
  ('Knowledge Base Required',    2, 5, 'Forethought needs strong KB for deflection; Lang works without one'),
  ('Best Fit Org',               4, 5, 'Lang: orgs wanting augmentation; Forethought: orgs ready for full automation')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lang-io-vs-forethought-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lang-io-vs-forethought-ai');
