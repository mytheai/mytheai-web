-- compare-batch-42.sql
-- 5 AI fintech / finance ops comparison pairs for tools-batch-42
-- DEPENDENCY: tools-batch-42.sql must be run first
-- All pairs verified absent from compare-batch-1 through compare-batch-41

-- 1. ramp vs brex: cost-control expense management vs growth-first finance OS
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'ramp-vs-brex', 'ramp', 'brex',
  'Ramp and Brex are the two dominant modern corporate card platforms, and the choice between them comes down to your company stage and philosophy. Ramp is built around cost reduction: the AI engine actively surfaces savings opportunities, flags duplicate subscriptions, and recommends vendor alternatives. Brex is built around growth: higher credit limits based on funding rather than credit history, multi-currency global capabilities, and a broader finance OS covering cards, bill pay, travel, and equity management. For a cost-conscious Series A startup trying to extend runway, Ramp is the obvious choice. For a high-growth company expanding internationally that needs maximum capital access and a unified finance platform, Brex is the better fit. Both are free to start - the real cost difference shows up in which premium features each team needs.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ramp-vs-brex');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'ramp-vs-brex', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Cost Savings', 5, 2, 'Ramp actively identifies savings: duplicate subscriptions, unused licenses, and vendor alternatives with better pricing. Brex does not have an equivalent proactive cost reduction engine.'),
  ('Corporate Credit Limits', 3, 5, 'Brex sets limits based on company revenue, funding, and cash balance rather than personal credit - typically 10 to 20 times higher than traditional cards. Ramp credit limits are competitive but not Brex-level for funded startups.'),
  ('Global Payment Capabilities', 2, 5, 'Brex supports multi-currency spending in 50-plus countries with local payment methods. Ramp is primarily US-focused with limited international capabilities.'),
  ('Expense Management Automation', 5, 4, 'Ramp automated expense controls, policy enforcement at point of purchase, and receipt matching are the most automated in the category. Brex expense management is strong but less proactive.'),
  ('Finance Platform Breadth', 3, 5, 'Brex covers corporate cards, bill pay, travel, and equity management in one platform. Ramp covers cards and expenses with bill pay added; it is a narrower but more focused tool.'),
  ('ERP and Accounting Integration', 5, 4, 'Ramp integrates deeply with QuickBooks, NetSuite, Sage, and Xero for real-time sync. Brex accounting integrations are solid but Ramp has the edge on sync speed and depth.'),
  ('Startup Accessibility', 5, 4, 'Both have free tiers. Ramp is free for core spend management indefinitely. Brex free tier has more limitations and pushes toward paid plans for full AP and travel features.'))
AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ramp-vs-brex')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'ramp-vs-brex');

-- 2. pilot vs bench: venture-grade bookkeeping vs simple small business books
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'pilot-vs-bench', 'pilot', 'bench',
  'Pilot and Bench are both tech-enabled bookkeeping services that replace traditional accountants for small businesses and startups, but they serve fundamentally different customer profiles. Pilot uses dedicated in-house CPAs to deliver accrual-basis GAAP financial statements, investor-ready reports, and startup tax returns - it is the right choice for venture-backed companies preparing for board meetings and due diligence. Bench provides cash-basis bookkeeping with a clean interface and dedicated bookkeeping teams, optimized for simple, predictable financials for service businesses and solopreneurs. The price difference reflects the expertise difference: Pilot starts at $499/month, Bench at $299/month. For a startup with a VC board, Pilot is worth the premium. For a small consulting firm or retail business, Bench is more than sufficient.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pilot-vs-bench');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'pilot-vs-bench', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('GAAP Accrual Accounting', 5, 2, 'Pilot specializes in accrual-basis GAAP financial statements required by VC investors and auditors. Bench operates on cash-basis accounting only, which is not accepted for Series A due diligence.'),
  ('Investor-Ready Reporting', 5, 2, 'Pilot delivers board-ready financial packages with commentary, variance analysis, and revenue recognition. Bench delivers standard P&L and balance sheet reports without investor-grade narrative.'),
  ('CPA Expertise Access', 5, 3, 'Pilot uses in-house CPAs who specialize in startup accounting including R&D tax credits, revenue recognition, and fundraising preparation. Bench uses dedicated bookkeepers without CPA credentials.'),
  ('Pricing Accessibility', 2, 5, 'Bench starts at $299/month - significantly lower than Pilot starting at $499/month. For cash-basis small businesses, Bench delivers equivalent value at lower cost.'),
  ('Software Interface Quality', 4, 5, 'Bench has an award-winning clean interface that shows financial data in a way business owners understand without accounting knowledge. Pilot interface is functional but more accountant-oriented.'),
  ('Tax Preparation Services', 4, 4, 'Both offer year-end tax preparation as an add-on. Pilot CPAs specialize in startup tax returns including 83(b) elections and R&D credits. Bench handles standard small business tax prep.'),
  ('Catch-Up Bookkeeping', 4, 5, 'Bench has a well-regarded catch-up bookkeeping service for businesses behind on their books. Pilot offers catch-up but it is more complex and expensive due to accrual methodology.'))
AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pilot-vs-bench')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'pilot-vs-bench');

-- 3. stampli vs tipalti: AP workflow automation vs global supplier payments
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'stampli-vs-tipalti', 'stampli', 'tipalti',
  'Stampli and Tipalti solve different parts of the accounts payable problem. Stampli focuses on the invoice approval workflow: getting invoices coded, reviewed, and approved faster through AI-assisted communication capture and automated routing. Tipalti focuses on global payment execution and compliance: paying suppliers in 196 countries with tax form management, sanctions screening, and multi-currency payment rails built in. For AP teams whose primary pain is slow approvals and audit trail gaps, Stampli solves the problem without touching the ERP. For finance teams whose primary pain is global supplier payment complexity and compliance risk, Tipalti solves the problem Stampli does not address. Many organizations ultimately need both - Stampli for the workflow layer, Tipalti for the payment execution layer.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'stampli-vs-tipalti');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'stampli-vs-tipalti', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Invoice Approval Workflow', 5, 3, 'Stampli AI Billy the Bot automates invoice coding, captures approval communication on the invoice itself, and learns routing patterns. Tipalti has basic approval workflow but it is secondary to payment execution.'),
  ('Global Supplier Payments', 2, 5, 'Tipalti pays in 196 countries across 50-plus payment methods with local currency settlement. Stampli does not handle payment execution at all.'),
  ('Regulatory and Tax Compliance', 2, 5, 'Tipalti manages W-8 and W-9 collection, sanctions screening, OFAC compliance, and VAT handling for global payments. Stampli does not address cross-border payment compliance.'),
  ('ERP Integration Depth', 5, 4, 'Stampli integrates with 70-plus ERP systems without requiring workflow changes. Tipalti supports major ERPs but with less focus on approval-side workflow integration.'),
  ('AI Invoice Processing', 5, 3, 'Stampli AI learns coding patterns from historical data and flags anomalies. Tipalti uses AI for payment fraud detection and exception handling rather than invoice coding.'),
  ('Audit Trail Quality', 5, 4, 'Stampli captures all communication and approvals on the invoice itself, creating a complete workflow audit trail. Tipalti maintains detailed payment compliance records but workflow communication is less centralized.'),
  ('Pricing Accessibility', 4, 3, 'Stampli pricing scales with invoice volume and is accessible for mid-market AP teams. Tipalti starts at $149/month plus payment fees; full global capabilities require higher tiers.'))
AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'stampli-vs-tipalti')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'stampli-vs-tipalti');

-- 4. airbase vs ramp: unified spend management vs card-first cost reduction
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'airbase-vs-ramp', 'airbase', 'ramp',
  'Airbase and Ramp are both spend management platforms, but with different scope. Ramp is card-first: the strongest corporate card controls, the most aggressive AI cost-savings features, and deep accounting integrations. Airbase is broader: it combines corporate cards, employee expense reimbursements, and full AP automation (purchase orders, bill pay, and vendor management) in one platform. For a 50-person company that needs to control card spend and reduce costs, Ramp is the better tool. For a 200-person company with multiple departments, vendors, and complex approval chains across cards, reimbursements, and vendor invoices, Airbase provides the unified spend view and AP coverage that Ramp does not match. The choice often comes down to whether your spend problem is primarily card-and-expense, or card-plus-AP combined.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'airbase-vs-ramp');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'airbase-vs-ramp', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AP and Bill Pay Coverage', 5, 3, 'Airbase includes full AP automation with purchase orders, three-way matching, and vendor management. Ramp bill pay was added later and is less comprehensive than a purpose-built AP tool.'),
  ('AI Cost Savings Engine', 2, 5, 'Ramp actively identifies savings opportunities: duplicate subscriptions, unused licenses, and vendor alternatives. Airbase does not have an equivalent proactive cost reduction feature.'),
  ('Multi-entity Support', 5, 3, 'Airbase supports multiple legal entities with separate GL mapping, approval workflows, and reporting. Ramp multi-entity support is available but less flexible for complex corporate structures.'),
  ('Expense Reimbursement', 5, 4, 'Airbase unified expense workflow covers out-of-pocket reimbursements alongside card spend in one system. Ramp added reimbursements but Airbase reimbursement workflow is more mature.'),
  ('Real-time Spend Analytics', 4, 5, 'Ramp real-time spend dashboards and savings tracking are the most actionable reporting in the category. Airbase reporting is solid but less focused on surfacing cost insights.'),
  ('Corporate Card Controls', 4, 5, 'Ramp physical and virtual card controls with granular merchant category restrictions are the benchmark. Both are strong but Ramp card management is more detailed.'),
  ('Implementation Complexity', 3, 5, 'Ramp deploys quickly with minimal setup for card programs. Airbase AP module implementation is more complex and requires finance team configuration time.'))
AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'airbase-vs-ramp')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'airbase-vs-ramp');

-- 5. zeni vs pilot: AI-native daily bookkeeping vs human CPA expertise
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'zeni-vs-pilot', 'zeni', 'pilot',
  'Zeni and Pilot both sell AI-powered bookkeeping for startups, but they represent opposite ends of the human-AI spectrum. Zeni is AI-first: LLMs handle transaction categorization, reconciliation, and financial Q&A with human CFO oversight, delivering daily updated financials and natural language answers to financial questions. Pilot is human-first: dedicated in-house CPAs use software to deliver monthly GAAP financials with the depth and judgment that AI cannot replicate - revenue recognition, accruals, board-ready commentary, and startup tax returns. If you are a pre-seed founder who wants fast answers and daily visibility at a lower price, Zeni delivers. If you are a Series A company with investors who will read your financials and ask hard questions, Pilot CPAs deliver accuracy and credibility that AI-only services cannot match.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zeni-vs-pilot');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'zeni-vs-pilot', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Automation Level', 5, 3, 'Zeni uses LLMs to automate categorization, reconciliation, and financial Q&A with minimal human intervention. Pilot is human-CPA-first with software assistance; the automation is a tool for the accountant, not a replacement.'),
  ('GAAP Accounting Depth', 2, 5, 'Pilot CPAs handle complex accrual accounting, revenue recognition (ASC 606), deferred revenue, and GAAP statements investors require. Zeni covers standard bookkeeping and is not positioned for complex GAAP work.'),
  ('Financial Visibility Speed', 5, 3, 'Zeni updates financials daily and answers questions in real time. Pilot delivers monthly financial packages after the close, which is the standard but slower.'),
  ('Investor-Ready Reporting', 2, 5, 'Pilot provides board-deck-ready financials with variance analysis and management commentary. Zeni provides dashboards and metrics but not the narrative financial packages investors expect.'),
  ('Natural Language Finance Q&A', 5, 2, 'Zeni AI answers financial questions in plain English without scheduling a call. Pilot requires communication with a CPA team through email or scheduled meetings.'),
  ('Startup Tax Preparation', 3, 5, 'Pilot CPA tax preparation specializes in startup tax returns including 83(b) elections, R&D tax credits, and state nexus. Zeni partners with third-party tax providers rather than handling tax in-house.'),
  ('Pricing', 3, 3, 'Zeni starts at $549/month and Pilot at $499/month - comparable pricing for different levels of automation and expertise. Neither is a budget option for early-stage startups.'))
AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zeni-vs-pilot')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zeni-vs-pilot');
