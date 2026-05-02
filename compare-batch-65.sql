-- compare-batch-65.sql
-- 5 Legal Tech comparison pairs
-- All tool slugs confirmed: paxton-ai, harvey-ai (batch-21), everlaw, relativity, kira-systems,
--   lexion, draftwise, definely, brightflag (batch-65)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. paxton-ai-vs-harvey-ai (legal research AI head-to-head)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'paxton-ai-vs-harvey-ai',
  'paxton-ai',
  'harvey-ai',
  'Paxton AI and Harvey AI are both purpose-built legal AI assistants, but they serve different segments and workflows. Paxton targets solo attorneys and small firms with accessible subscription pricing and a strong focus on verified legal research with cited sources across all 50 US states. Harvey targets Am Law 200 firms and enterprise legal departments with a more powerful generative AI layer built on top of GPT-4 for complex drafting, due diligence, and legal reasoning tasks. Paxton wins on accessibility and price transparency; Harvey wins on generative depth and enterprise integration capabilities. In 2026 both have expanded beyond research into drafting and analysis, making them increasingly competitive for mid-size firm use cases.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'paxton-ai-vs-harvey-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'paxton-ai-vs-harvey-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Research Quality',         4, 5, 'Harvey''s GPT-4 foundation produces more sophisticated multi-issue legal analysis'),
  ('Citation Reliability',        5, 4, 'Paxton ground truth citations are highly reliable; Harvey adds hallucination guardrails'),
  ('Pricing Accessibility',       5, 2, 'Paxton starts around $79/month; Harvey is enterprise-only with custom pricing'),
  ('Jurisdictional Coverage',     4, 4, 'Both cover all 50 US states; Harvey adds stronger international law coverage'),
  ('Contract Drafting AI',        3, 5, 'Harvey''s generative drafting handles complex transactional documents more fluently'),
  ('Implementation Speed',        5, 2, 'Paxton is self-serve in minutes; Harvey requires enterprise onboarding and IT integration'),
  ('Best For',                    4, 4, 'Paxton for solo/small firms; Harvey for Am Law 200 and large in-house departments')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'paxton-ai-vs-harvey-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'paxton-ai-vs-harvey-ai');

-- 2. everlaw-vs-relativity (e-discovery leaders head-to-head)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'everlaw-vs-relativity',
  'everlaw',
  'relativity',
  'Everlaw and Relativity are the two dominant e-discovery platforms for large-scale litigation in 2026, but they represent different architectural philosophies. Relativity is the established enterprise standard - deeply customizable, extensively integrated, and deployable both in the cloud (RelativityOne) and on-premise. Everlaw is the modern cloud-native challenger - faster to spin up, cleaner interface, and better AI review features out of the box for teams that do not need Relativity''s customization depth. Law firms and legal departments already standardized on Relativity will find migration costs high; newer teams choosing a first platform increasingly select Everlaw for its setup speed and collaborative tools. Both platforms support predictive coding and AI-assisted review, but Everlaw''s AI is more accessible without consultant support.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'everlaw-vs-relativity');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'everlaw-vs-relativity', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Review Accessibility',     5, 3, 'Everlaw predictive coding is accessible without consultant configuration; Relativity requires setup'),
  ('Setup Speed',                 5, 2, 'Everlaw matters can be live within hours; Relativity on-premise takes weeks to configure'),
  ('Customization Depth',         3, 5, 'Relativity''s scripting and custom field architecture is unmatched for complex workflows'),
  ('Cost at Scale',               4, 3, 'Everlaw per-GB pricing is competitive; Relativity costs scale with infrastructure and licensing'),
  ('Collaboration Features',      5, 3, 'Everlaw Storybuilder and tagging tools are more collaborative for distributed review teams'),
  ('Integration Ecosystem',       3, 5, 'Relativity has the broadest third-party integration ecosystem in e-discovery'),
  ('Best For',                    4, 4, 'Everlaw for teams wanting modern UX and fast setup; Relativity for enterprise custom workflows')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'everlaw-vs-relativity')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'everlaw-vs-relativity');

-- 3. kira-systems-vs-lexion (contract analysis vs contract management)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'kira-systems-vs-lexion',
  'kira-systems',
  'lexion',
  'Kira Systems and Lexion both apply AI to contracts, but at different stages of the contract lifecycle. Kira is a contract review tool built for the deal workflow - M&A due diligence, lease abstractions, and high-volume transactional review where attorneys need AI to extract provisions from thousands of documents fast. Lexion is a contract management platform designed for in-house legal and procurement teams that need a searchable repository of executed contracts with AI extraction of key terms and renewal dates. The tools are often complementary: Kira accelerates the review during a deal, Lexion manages the ongoing obligations once the deal closes. Teams choosing between them should decide whether their primary need is deal-time review speed or post-execution contract visibility.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'kira-systems-vs-lexion');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'kira-systems-vs-lexion', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Due Diligence Review Speed',  5, 2, 'Kira is purpose-built for high-speed M&A and transactional review workflows'),
  ('Contract Repository',         2, 5, 'Lexion''s contract management and search capabilities are significantly more mature'),
  ('Renewal Alert Automation',    2, 5, 'Lexion proactively alerts on upcoming renewals and obligations; Kira does not focus here'),
  ('Custom Provision Training',   5, 3, 'Kira''s point-and-click model training handles specialized provisions well'),
  ('Non-Legal User Accessibility',2, 5, 'Lexion is designed for procurement and ops users; Kira requires legal expertise to operate'),
  ('Integrations',                3, 4, 'Lexion integrates with Salesforce, Slack, and procurement tools; Kira focuses on legal workflow'),
  ('Compliance and Security',     5, 5, 'Both maintain SOC 2 Type II certification and enterprise-grade security controls')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'kira-systems-vs-lexion')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'kira-systems-vs-lexion');

-- 4. draftwise-vs-definely (contract drafting AI)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'draftwise-vs-definely',
  'draftwise',
  'definely',
  'Draftwise and Definely are both AI tools designed to make contract drafting faster and more accurate, but they approach the problem from different angles. Draftwise learns from a firm''s own precedent library to suggest preferred language and flag deviations from standard positions - its AI is trained on what the firm has actually negotiated and accepted, making suggestions highly firm-specific. Definely focuses on contract navigation and clause analysis within Word - surfacing defined term cross-references, flagging potentially unfavorable clauses, and helping attorneys quickly understand how a clause fits within the broader document. The tools address adjacent problems: Draftwise helps attorneys draft consistently with firm precedent, while Definely helps them review and navigate complex agreements efficiently. Many firms use both in sequence.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'draftwise-vs-definely');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'draftwise-vs-definely', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Precedent-Based Suggestions',  5, 2, 'Draftwise trains on firm library to suggest language matching actual negotiated positions'),
  ('Contract Navigation',          2, 5, 'Definely''s defined term mapping and cross-reference navigation is best in class'),
  ('Microsoft Word Integration',   3, 5, 'Definely is natively embedded in Word; Draftwise has a Word add-in but requires configuration'),
  ('Implementation Speed',         3, 5, 'Definely is installable and useful within a day; Draftwise requires precedent library upload'),
  ('Clause Risk Flagging',         4, 4, 'Both flag potentially unfavorable provisions; Draftwise does so against firm precedent'),
  ('Pricing Accessibility',        3, 4, 'Definely offers accessible entry pricing; Draftwise is primarily mid and large firm positioned'),
  ('Best For',                     4, 4, 'Draftwise for firms with strong precedent libraries; Definely for faster contract navigation')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'draftwise-vs-definely')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'draftwise-vs-definely');

-- 5. brightflag-vs-lexion (legal spend management vs contract AI)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'brightflag-vs-lexion',
  'brightflag',
  'lexion',
  'Brightflag and Lexion both serve in-house legal operations teams but address different cost centers. Brightflag is an AI legal spend management platform - it analyzes outside counsel invoices for billing guideline compliance, benchmarks rates against industry data, and gives GCs visibility into where the legal budget is going across law firm relationships. Lexion is an AI contract management platform focused on contract repository, obligation tracking, and business-side contract visibility. In-house teams with large outside counsel spend should prioritize Brightflag; teams with large contract portfolios to manage should prioritize Lexion. Larger legal departments typically deploy both as complementary tools covering spend intelligence and contract intelligence respectively.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'brightflag-vs-lexion');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'brightflag-vs-lexion', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Legal Spend Analytics',       5, 1, 'Brightflag is purpose-built for outside counsel spend management and invoice review'),
  ('Contract Management',         1, 5, 'Lexion is purpose-built for contract repository and obligation tracking'),
  ('Billing Guideline Compliance',5, 1, 'Brightflag automatically flags billing guideline violations in outside counsel invoices'),
  ('Renewal Tracking',            1, 5, 'Lexion proactively surfaces contract renewal and expiration dates across the portfolio'),
  ('Business User Accessibility', 3, 5, 'Lexion is designed for procurement and finance alongside legal; Brightflag is legal-team focused'),
  ('Implementation Speed',        4, 4, 'Both deploy in weeks with professional services; neither requires extensive IT involvement'),
  ('Compliance and Security',     5, 5, 'Both platforms maintain SOC 2 Type II and enterprise-grade data security for legal data')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'brightflag-vs-lexion')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'brightflag-vs-lexion');
