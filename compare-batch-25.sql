-- compare-batch-25.sql
-- 5 comparison pairs: customer support + no-code + app builder comparisons
-- All tools confirmed in Supabase DB before writing
-- Requires: tools-batch-25.sql confirmed in DB (zendesk, freshdesk, helpscout, gorgias, tidio already in DB)
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: zendesk-vs-freshdesk
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'zendesk-vs-freshdesk',
  'zendesk',
  'freshdesk',
  'Zendesk and Freshdesk are the two dominant cloud helpdesks, but they target different segments. Zendesk is the enterprise standard - a more powerful, more configurable platform with a larger app marketplace, deeper reporting, and a higher price tag that reflects all of that. Freshdesk is the challenger for SMBs and growing teams: faster to set up, cheaper to operate, and generous enough with its free plan that many small teams never need to upgrade. Both platforms have moved seriously into AI - Zendesk AI for triage and response suggestions, Freshdesk Freddy for self-service, agent copilot, and analytics. The AI capabilities are closer than the pricing suggests. The decision usually comes down to team size and budget: Freshdesk is the clear starting point for teams under 20 agents, while Zendesk becomes the right answer when you need enterprise controls, complex routing logic, or a specific integration from its marketplace.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'zendesk-vs-freshdesk', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Free Plan', 1, 5, 'Freshdesk offers a free plan for unlimited agents with basic features. Zendesk has no free plan - starts at $55/agent/month.'),
  ('AI Features', 4, 4, 'Zendesk AI handles triage, routing, and response suggestions. Freshdesk Freddy covers self-service bot, agent copilot, and analytics insights. Feature parity is close.'),
  ('Ease of Setup', 3, 5, 'Freshdesk is notably faster to set up with less configuration required. Zendesk''s full feature set requires more admin time to configure correctly.'),
  ('Reporting and Analytics', 5, 3, 'Zendesk has deeper out-of-the-box reporting and more customisable dashboards. Freshdesk reporting improves significantly on paid plans.'),
  ('Integration Marketplace', 5, 4, 'Zendesk has a larger marketplace with 1,000+ apps. Freshdesk integrates with major tools but has a smaller ecosystem.'),
  ('Enterprise Controls', 5, 3, 'Zendesk has more advanced role permissions, audit logs, and compliance features for enterprise requirements.'),
  ('Pricing Value for SMBs', 2, 5, 'Freshdesk''s free plan and $15/agent starting price make it far more accessible than Zendesk for smaller teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zendesk-vs-freshdesk')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zendesk-vs-freshdesk');

-- Pair 2: helpscout-vs-freshdesk
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'helpscout-vs-freshdesk',
  'helpscout',
  'freshdesk',
  'Help Scout and Freshdesk are both popular choices for small and mid-size teams, but they take very different approaches to customer support. Help Scout is built around the philosophy that support should feel personal - the shared inbox looks like email, customers never see ticket numbers, and the whole experience is designed to feel human rather than transactional. Freshdesk is a more traditional helpdesk: it has ticket IDs, SLA management, automation rules, and a full AI suite (Freddy) layered on top. Help Scout wins on simplicity, agent experience, and the quality of its customer-facing UX. Freshdesk wins on features, price, and free plan availability. The choice depends on what matters more to your team: Help Scout for teams who want support to feel like a product extension, Freshdesk for teams who need more ticketing power and are cost-conscious.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'helpscout-vs-freshdesk', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Free Plan', 1, 5, 'Freshdesk has a free plan for unlimited agents. Help Scout starts at $50/month with no free tier.'),
  ('Customer-Facing UX', 5, 3, 'Help Scout hides ticket numbers and feels like a personal email. Freshdesk has a more transactional ticketing feel that some customers notice.'),
  ('Agent Experience', 5, 3, 'Help Scout''s inbox is clean and intuitive - minimal training needed. Freshdesk has more features but a steeper interface learning curve.'),
  ('AI Features', 4, 5, 'Both offer AI response drafting and summaries. Freshdesk''s Freddy suite is more comprehensive with self-service bot and analytics layer.'),
  ('Ticketing Complexity', 2, 5, 'Freshdesk supports complex routing rules, SLA policies, and ticket workflows. Help Scout is intentionally simpler - fewer automation options.'),
  ('Knowledge Base', 4, 4, 'Help Scout Docs is clean and well-integrated with Beacon. Freshdesk''s knowledge base is comparably capable with article suggestions in tickets.'),
  ('Pricing Model', 3, 4, 'Help Scout is flat monthly pricing (not per agent on lower plans). Freshdesk is per-agent but starts free. Freshdesk is usually cheaper at small team sizes.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'helpscout-vs-freshdesk')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'helpscout-vs-freshdesk');

-- Pair 3: gorgias-vs-tidio
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'gorgias-vs-tidio',
  'gorgias',
  'tidio',
  'Gorgias and Tidio both target e-commerce customer support, but at different scales and with different strengths. Gorgias is built for established e-commerce brands with high ticket volumes - its deep Shopify integration pulls order data directly into tickets, agents can issue refunds and edit orders without switching tabs, and the automation engine resolves 30-40% of tickets automatically. Tidio is lighter, faster to set up, and more accessible for smaller stores - its live chat is excellent, its chatbot builder requires no coding, and its free plan is genuinely useful. For DTC brands processing hundreds of support tickets per day, Gorgias is the more powerful choice. For newer e-commerce stores or brands that want live chat plus basic automation at a low cost, Tidio is a better starting point. The platforms are complements as much as competitors - some teams start on Tidio and migrate to Gorgias as volume grows.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'gorgias-vs-tidio', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Shopify Integration Depth', 5, 3, 'Gorgias pulls full order history, shipment status, and allows order actions directly from tickets. Tidio has Shopify integration but less deep order context.'),
  ('Free Plan', 1, 5, 'Tidio has a free plan supporting 50 live chat conversations per month. Gorgias starts at $10/month (100 tickets) with no free tier.'),
  ('AI Automation Rate', 5, 3, 'Gorgias Automate resolves 30-40% of tickets without agent involvement. Tidio''s AI chatbot handles common queries but with less e-commerce context.'),
  ('Chatbot Builder', 3, 5, 'Tidio''s visual chatbot builder is one of the most accessible in the category. Gorgias automation uses rules and macros rather than a visual chatbot flow.'),
  ('Pricing Model', 3, 4, 'Gorgias prices by ticket volume (scales with business size). Tidio prices by conversations and operator seats. Tidio is more predictable for smaller stores.'),
  ('High-Volume Support', 5, 3, 'Gorgias is built for brands handling thousands of tickets per month. Tidio works well for lower volume but less optimised for enterprise scale.'),
  ('Revenue Tracking', 5, 2, 'Gorgias tracks direct revenue attributed to support conversations. Tidio does not have comparable revenue attribution reporting.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gorgias-vs-tidio')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'gorgias-vs-tidio');

-- Pair 4: lovable-vs-replit
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'lovable-vs-replit',
  'lovable',
  'replit',
  'Lovable and Replit are both AI app builders that let non-developers (and developers) go from idea to working application without traditional coding workflows - but they differ in philosophy and output. Lovable generates a complete React application with a database schema, Supabase backend, and deployable code from a natural language prompt. The code is yours to export, inspect, and extend. Replit is a cloud IDE that runs in the browser - you can start from a template, use Replit AI to generate code, and deploy from within the same environment. Lovable is optimised for speed to a polished MVP: it produces styled, structured applications faster than Replit for typical app patterns. Replit is better when you want to iterate with code, experiment with different languages and frameworks, or collaborate in real time. Lovable is the AI-first tool for people who want the app; Replit is the AI-assisted tool for people who want to build and learn.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'lovable-vs-replit', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Speed to Working App', 5, 3, 'Lovable generates a styled, functional app from a prompt in minutes with no setup. Replit requires more iteration to reach the same result.'),
  ('Code Ownership', 5, 4, 'Lovable generates exportable React code you fully own. Replit code runs in and can be exported from the browser IDE.'),
  ('Real-Time Collaboration', 2, 5, 'Replit has built-in multiplayer coding and project sharing. Lovable is single-user with sharing via the published app.'),
  ('Language and Framework Flexibility', 2, 5, 'Replit supports Python, Node.js, Go, Rust, and many others. Lovable generates React/TypeScript specifically.'),
  ('Non-Technical Accessibility', 5, 3, 'Lovable requires no coding knowledge - describe the app in natural language. Replit benefits from some coding ability to iterate effectively.'),
  ('Deployment', 5, 4, 'Lovable deploys to a live URL automatically. Replit also deploys with one click from the IDE.'),
  ('Database and Backend', 5, 3, 'Lovable integrates Supabase for database and auth automatically. Replit supports databases but requires more manual configuration.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lovable-vs-replit')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lovable-vs-replit');

-- Pair 5: retool-vs-noloco
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'retool-vs-noloco',
  'retool',
  'noloco',
  'Retool and Noloco are both internal tool builders - platforms designed to help teams build admin panels, dashboards, and operational tools on top of their existing data - but they occupy very different market positions. Retool is the most feature-rich internal tool platform available, with a large component library, complex query support, and an active marketplace of templates. It is the standard choice for engineering teams with the bandwidth to configure and maintain sophisticated internal tools. Noloco is built for operations teams and non-developers: it connects to Airtable, Google Sheets, HubSpot, Salesforce, and databases, then generates a custom internal portal automatically with minimal configuration. The tradeoff is depth versus accessibility. Retool can build almost anything an engineering team imagines; Noloco can be set up by an ops manager in an afternoon without involving engineering at all. For teams with developer resources who need powerful tooling, Retool wins. For non-technical operators who need a self-service portal quickly, Noloco is the right answer.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'retool-vs-noloco', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Non-Technical Setup', 2, 5, 'Noloco can be configured by a non-developer in hours. Retool requires developer knowledge to use effectively.'),
  ('Component Library', 5, 3, 'Retool has the largest component library of any internal tool builder. Noloco has good standard components but less customisation depth.'),
  ('Data Source Integrations', 4, 5, 'Noloco connects to Airtable, Google Sheets, HubSpot, Salesforce, and databases natively. Retool has more connectors but requires more setup.'),
  ('Custom Logic and Queries', 5, 2, 'Retool supports complex SQL queries, JavaScript logic, and API calls. Noloco automation is simpler - suited for straightforward workflows.'),
  ('Time to First Working Tool', 2, 5, 'Noloco generates a working portal from a connected data source in minutes. Retool requires significant configuration to reach the same result.'),
  ('Pricing', 2, 4, 'Retool pricing grows fast with more internal users. Noloco is priced per workspace and often cheaper for small ops teams.'),
  ('Enterprise Controls', 5, 3, 'Retool has advanced permissions, audit logs, and SSO for enterprise requirements. Noloco has basic role controls suited to smaller teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'retool-vs-noloco')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'retool-vs-noloco');
