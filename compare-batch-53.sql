-- compare-batch-53.sql
-- 5 AI CRM and Sales tool comparison pairs
-- All tool slugs confirmed in DB from tools-batch-53.sql
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. salesforce-einstein-vs-zoho-crm (enterprise CRM giants)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'salesforce-einstein-vs-zoho-crm',
  'salesforce-einstein',
  'zoho-crm',
  'Salesforce Einstein and Zoho CRM are the two leading full-featured CRM platforms with mature AI capabilities, but they target different ends of the market. Salesforce Einstein offers deeper AI features, broader ecosystem integrations, and stronger enterprise governance - at significantly higher per-user costs. Zoho CRM with Zia AI delivers most of the core AI capabilities (lead scoring, deal predictions, anomaly detection, generative email drafts) at roughly one-fifth the cost, with a faster implementation timeline. For mid-market and SMB teams, Zoho is often the smarter spend. For enterprise organizations with complex sales processes, regulated industries, or existing Salesforce investments, Einstein remains the safer choice.',
  'salesforce-einstein',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'salesforce-einstein-vs-zoho-crm');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'salesforce-einstein-vs-zoho-crm', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Capability Depth',       5, 4, 'Einstein Copilot more powerful for natural-language CRM queries'),
  ('Pricing per User',          1, 5, 'Einstein costs roughly 5x more per seat than Zoho'),
  ('Ecosystem Integrations',    5, 4, 'Salesforce AppExchange has 8000+ apps; Zoho has fewer but its own broad suite'),
  ('Implementation Time',       2, 4, 'Salesforce takes 3-6 months typical; Zoho 4-8 weeks'),
  ('Enterprise Governance',     5, 3, 'Einstein has stronger compliance, audit, and security features for regulated industries'),
  ('SMB Friendliness',          2, 4, 'Zoho free tier and lower entry pricing fit SMB much better'),
  ('Predictive Forecasting',    5, 3, 'Einstein forecasting accuracy meaningfully ahead of Zoho''s')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'salesforce-einstein-vs-zoho-crm')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'salesforce-einstein-vs-zoho-crm');

-- 2. freshsales-vs-zoho-crm (mid-market AI CRMs)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'freshsales-vs-zoho-crm',
  'freshsales',
  'zoho-crm',
  'Freshsales and Zoho CRM are direct competitors in the AI-powered mid-market CRM category. Both offer AI lead scoring, deal health predictions, generative email drafts, and integrated calling - at similar price points. Freshsales (with Freddy AI) has a more polished, modern interface and stronger built-in communication tools (calling, email, WhatsApp natively). Zoho CRM (with Zia AI) has broader feature breadth, deeper customization options, and tighter integration with the rest of the Zoho suite (Zoho Books, Zoho Desk, Zoho Campaigns). For teams that value UX and out-of-the-box readiness, Freshsales wins. For teams that need extensive customization or are already in the Zoho ecosystem, Zoho wins.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'freshsales-vs-zoho-crm');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'freshsales-vs-zoho-crm', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Lead Scoring Quality',    4, 4, 'Both Freddy and Zia score leads competently with sufficient data'),
  ('UI and UX Polish',           5, 3, 'Freshsales interface is noticeably cleaner and more modern'),
  ('Built-in Communication',     5, 3, 'Freshsales has stronger native calling, email, and WhatsApp tools'),
  ('Customization Depth',        3, 5, 'Zoho allows more workflow customization without developer help'),
  ('Pricing per User',           4, 4, 'Comparable pricing at most tiers'),
  ('Suite Integration',          3, 5, 'Zoho''s integration with Books, Desk, Campaigns is tighter'),
  ('Free Plan',                  4, 4, 'Both offer free tiers covering small teams')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'freshsales-vs-zoho-crm')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'freshsales-vs-zoho-crm');

-- 3. close-vs-folk (modern startup CRMs)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'close-vs-folk',
  'close',
  'folk',
  'Close and Folk both target modern, smaller sales teams looking for an alternative to Salesforce, but they optimize for very different sales motions. Close is built for inside sales teams running outbound or high-velocity inbound: the dialer is the centerpiece, AI handles call summaries and email drafts, and the workflow is optimized for reps making 50+ touches per day. Folk is built for relationship-driven sales: founders, consultants, and small teams running consultative sales cycles where each contact matters individually. Folk''s AI builds the CRM from your inbox and calendar automatically, eliminating manual data entry. Choose Close if your reps spend the day on calls. Choose Folk if your sales motion is built around relationships and warm introductions.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'close-vs-folk');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'close-vs-folk', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Built-in Dialer',            5, 1, 'Close''s dialer is best-in-class; Folk does not have one'),
  ('Auto-CRM-Building from Inbox', 2, 5, 'Folk pulls relationship data from email and calendar automatically'),
  ('AI Email Drafting',          4, 4, 'Both generate competent personalized email drafts'),
  ('Pricing for Small Teams',    3, 4, 'Folk''s $20/user is cheaper than Close''s $49/user entry'),
  ('Sales Sequences',            5, 3, 'Close''s sequence engine more mature for outbound campaigns'),
  ('Suited to Consultative Sales', 2, 5, 'Folk fits founders and relationship-driven sales much better'),
  ('Suited to High-Volume Outbound', 5, 2, 'Close is purpose-built for high-volume call-and-email motions')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'close-vs-folk')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'close-vs-folk');

-- 4. smartlead-vs-amplemarket (AI outbound platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'smartlead-vs-amplemarket',
  'smartlead',
  'amplemarket',
  'Smartlead and Amplemarket both serve the AI cold outbound category, but at different ends of the market. Smartlead is infrastructure: unlimited mailboxes, deliverability tooling, AI personalization at scale, and an API-first approach designed for high-volume cold email senders, agencies, and sales ops teams running multiple campaigns simultaneously. Amplemarket is a full sales engagement platform: prospecting database, multichannel sequences (email + LinkedIn + phone), buying intent signals, and AI copilot features designed for enterprise SDR teams running coordinated outbound. Smartlead wins on cost-efficiency for high-volume operators. Amplemarket wins on completeness for enterprise outbound programs that need built-in prospecting data.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'smartlead-vs-amplemarket');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'smartlead-vs-amplemarket', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Email Deliverability Tools', 5, 4, 'Smartlead specializes in deliverability infrastructure'),
  ('Unlimited Mailbox Pricing',  5, 1, 'Smartlead allows unlimited mailboxes per plan; Amplemarket charges per seat'),
  ('Built-in Prospecting Data',  1, 5, 'Amplemarket has its own B2B contact database; Smartlead does not'),
  ('Multichannel (LinkedIn, Phone)', 2, 5, 'Amplemarket coordinates sequences across email, LinkedIn, and phone'),
  ('AI Personalization Quality', 4, 5, 'Both have strong AI; Amplemarket integrates buying signals more tightly'),
  ('Pricing for SMB',            5, 2, 'Smartlead entry is much friendlier for small senders'),
  ('Pricing for Enterprise SDR', 3, 5, 'Amplemarket''s integrated platform reduces tooling sprawl at scale')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'smartlead-vs-amplemarket')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'smartlead-vs-amplemarket');

-- 5. clari-vs-folk (revenue platform vs lightweight CRM - intentionally contrasting)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'clari-vs-folk',
  'clari',
  'folk',
  'Clari and Folk are not direct competitors - they sit at opposite ends of the sales tooling spectrum - but they are often considered together by founders deciding what their team actually needs. Clari is the revenue platform for established sales orgs (50+ AEs) layering AI forecasting and deal inspection on top of an existing Salesforce or HubSpot deployment. Folk is the lightweight, AI-first CRM for small teams (1-15 people) that have not yet invested in a full revenue stack. Clari adds intelligence on top of mature CRM data. Folk replaces a spreadsheet and starts capturing CRM data in the first place. The right answer is purely about company stage: Folk for early stage, Clari for growth-stage and beyond.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'clari-vs-folk');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clari-vs-folk', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Forecasting Accuracy',        5, 1, 'Clari is purpose-built for predictive forecasting; Folk has none'),
  ('Suited to 1-15 Person Team',  1, 5, 'Folk fits early-stage; Clari requires 50+ AEs to justify cost'),
  ('Pricing Transparency',        2, 5, 'Folk has published pricing; Clari is custom-only'),
  ('Replaces Spreadsheet CRM',    1, 5, 'Folk replaces ad-hoc CRM tracking; Clari requires existing CRM'),
  ('Sits on Top of CRM',          5, 1, 'Clari layers on Salesforce or HubSpot; Folk is the CRM itself'),
  ('AI Auto-CRM-Building',        2, 5, 'Folk pulls relationships from inbox automatically'),
  ('Total Cost of Ownership',     1, 5, 'Folk: $20-40/user; Clari: $1000+/user/year typical')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'clari-vs-folk')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clari-vs-folk');
