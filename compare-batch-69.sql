-- compare-batch-69.sql
-- 5 procurement / spend management comparison pairs
-- All tool slugs confirmed from tools-batch-69.sql (batch-69 procurement tools)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. coupa-vs-jaggaer (enterprise BSM vs autonomous procurement)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'coupa-vs-jaggaer',
  'coupa',
  'jaggaer',
  'Coupa and JAGGAER are the two most comprehensive enterprise source-to-pay platforms in the market, competing for large organizations that need end-to-end spend management across complex global operations. Coupa leads on community intelligence - its anonymized spend benchmarking across thousands of customers gives procurement teams insight that JAGGAER cannot match from a single-customer data set. JAGGAER is stronger in regulated industry verticals like manufacturing, higher education, and healthcare, where procurement involves technical specifications, regulatory compliance, and direct material sourcing workflows that Coupa handles less natively. For pure indirect spend management at a large enterprise, Coupa has the edge; for complex direct and regulated procurement programs, JAGGAER competes strongly. Both require significant implementation investment and multi-year enterprise contracts.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'coupa-vs-jaggaer');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'coupa-vs-jaggaer', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Spend Benchmarking Intelligence', 5, 2, 'Coupa community intelligence benchmarks spend against anonymized peer data at scale'),
  ('Direct Material Procurement',     2, 5, 'JAGGAER is designed for direct sourcing with multi-tier supplier and spec management'),
  ('Supplier Risk Monitoring',        5, 3, 'Coupa continuous supplier risk scoring covers financial health, ESG, and geopolitical signals'),
  ('Autonomous PO Execution',         3, 5, 'JAGGAER autonomous procurement handles routine reorder transactions without human approval'),
  ('User Experience and Adoption',    4, 3, 'Coupa UI is more modern and drives better employee adoption for guided buying'),
  ('ERP Integration Depth',           4, 5, 'JAGGAER has deeper SAP and Oracle ERP integration for procure-to-pay automation'),
  ('Implementation Time',             3, 3, 'Both require 6-12 month deployments with significant change management investment')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'coupa-vs-jaggaer')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'coupa-vs-jaggaer');

-- 2. ivalua-vs-coupa (configurability vs community intelligence)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'ivalua-vs-coupa',
  'ivalua',
  'coupa',
  'Ivalua and Coupa compete for mid-market to enterprise procurement programs but differentiate on their core strengths. Ivalua wins on configurability - the platform can be adapted to highly unusual procurement processes without custom development, making it the preferred choice for organizations in manufacturing, pharma, and other sectors with non-standard sourcing workflows. Coupa wins on community intelligence and out-of-the-box spend visibility, with benchmarking data from thousands of peer companies providing insights that Ivalua cannot replicate. For procurement programs that follow standard indirect spend management patterns, Coupa provides faster time-to-value with less customization effort. For organizations with complex, industry-specific requirements, Ivalua''s flexibility delivers more relevant functionality without the workarounds Coupa sometimes requires.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ivalua-vs-coupa');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'ivalua-vs-coupa', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Platform Configurability',        5, 3, 'Ivalua adapts to non-standard procurement processes without custom development'),
  ('Community Spend Benchmarking',    2, 5, 'Coupa anonymized peer benchmarking is a unique capability Ivalua cannot match'),
  ('Supplier Collaboration Portal',   5, 4, 'Ivalua supplier portal is rated higher for complex multi-tier supplier management'),
  ('Spend Analytics AI',              4, 4, 'Both categorize unstructured spend data with AI; Coupa has broader data set'),
  ('Time to Value',                   3, 4, 'Coupa is faster to deploy for standard indirect spend; Ivalua requires more configuration'),
  ('Contract Management Depth',       4, 3, 'Ivalua contract lifecycle management is more configurable for complex agreement types'),
  ('Pricing Competitiveness',         4, 3, 'Ivalua is typically priced more competitively than Coupa at mid-market scale')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ivalua-vs-coupa')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'ivalua-vs-coupa');

-- 3. zip-procurement-vs-coupa (modern intake layer vs enterprise BSM)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'zip-procurement-vs-coupa',
  'zip-procurement',
  'coupa',
  'Zip and Coupa are not true head-to-head competitors - they solve different problems in the procurement stack and many enterprises run both. Zip is built for the intake experience: the employee-facing guided buying workflow that drives compliant purchasing behavior before a request reaches procurement. Coupa is built for the back-end: sourcing, supplier management, invoicing, and spend analytics at enterprise scale. Zip wins on user adoption because it is intuitive enough for general employees to use; Coupa wins on depth because it covers the full source-to-pay lifecycle. For organizations that have Coupa but struggle with employee compliance and maverick spending, Zip deployed as the intake layer in front of Coupa is a proven combination. For organizations choosing a first procurement platform, Zip is faster to deploy; Coupa provides more complete long-term functionality.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zip-procurement-vs-coupa');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'zip-procurement-vs-coupa', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Employee User Experience',        5, 3, 'Zip is purpose-built for general employees; Coupa is designed for procurement professionals'),
  ('Source-to-Pay Completeness',      2, 5, 'Coupa covers sourcing, invoicing, supplier management - Zip focuses on intake only'),
  ('Implementation Speed',            5, 2, 'Zip deploys in weeks; Coupa typically requires 6-12 months for full deployment'),
  ('Spend Benchmarking',              1, 5, 'Coupa community intelligence has no equivalent in Zip'),
  ('Maverick Spend Prevention',       5, 4, 'Zip guided buying workflow is more effective at catching off-channel purchases at intake'),
  ('Approval Workflow Flexibility',   4, 4, 'Both offer configurable approval chains; Zip is faster to configure for most companies'),
  ('ERP and P2P Integration',         3, 5, 'Coupa has deeper native ERP integrations; Zip integrates with existing P2P systems')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zip-procurement-vs-coupa')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zip-procurement-vs-coupa');

-- 4. pactum-vs-jaggaer (autonomous negotiation vs end-to-end sourcing)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'pactum-vs-jaggaer',
  'pactum',
  'jaggaer',
  'Pactum and JAGGAER address different layers of the procurement stack and are often deployed together rather than as alternatives. JAGGAER provides end-to-end source-to-pay infrastructure for strategic sourcing programs - managing RFx events, contracts, purchase orders, and supplier performance for the top tier of supplier relationships. Pactum addresses the long tail: the thousands of lower-value suppliers that procurement teams never have bandwidth to negotiate with strategically. Pactum''s AI conducts autonomous commercial negotiations with tail-spend suppliers at scale, capturing payment term improvements and pricing concessions that JAGGAER''s workflow tools cannot generate without human procurement capacity. For large enterprises that already have JAGGAER or a similar platform for strategic sourcing, Pactum is the complementary tool that extracts value from the rest of the supplier base that strategic teams cannot touch.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pactum-vs-jaggaer');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'pactum-vs-jaggaer', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Autonomous Negotiation',          5, 1, 'Pactum is the only platform that conducts supplier negotiations without human involvement'),
  ('Strategic Sourcing Workflows',    1, 5, 'JAGGAER covers RFx, e-auctions, and complex multi-round sourcing events; Pactum does not'),
  ('Tail Spend Coverage',             5, 2, 'Pactum handles thousands of low-value supplier negotiations simultaneously'),
  ('Contract Lifecycle Management',   1, 5, 'JAGGAER has full contract creation, compliance, and renewal management; Pactum is limited'),
  ('Speed to Commercial Value',       5, 3, 'Pactum delivers measurable savings from first negotiation batch within weeks of deployment'),
  ('Supplier Portal and Onboarding',  2, 5, 'JAGGAER supplier portal handles PO acknowledgment, invoicing, and performance tracking'),
  ('Implementation Complexity',       3, 4, 'JAGGAER requires deeper ERP integration; Pactum deploys more quickly for negotiation use cases')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pactum-vs-jaggaer')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'pactum-vs-jaggaer');

-- 5. spendesk-vs-precoro (team spend control vs procurement automation)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'spendesk-vs-precoro',
  'spendesk',
  'precoro',
  'Spendesk and Precoro both serve growing companies that need procurement and spend control without enterprise platform complexity, but they approach the problem from different angles. Spendesk is built around team spend control: virtual cards, automated expense reimbursements, and real-time budget visibility give finance teams operational control over company spending as it happens. Precoro is built around procurement workflow automation: purchase requisitions, approval routing, PO management, and three-way matching for invoice reconciliation. For companies whose primary problem is employees spending without authorization or finance losing track of committed spend, Spendesk is the better fit. For companies whose problem is procurement chaos - no formal PO process, manual approvals by email, and reconciliation nightmares at month-end - Precoro addresses those workflows more directly.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'spendesk-vs-precoro');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'spendesk-vs-precoro', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Virtual Card and Expense Control', 5, 1, 'Spendesk virtual cards with per-vendor limits are a core feature; Precoro lacks card management'),
  ('Purchase Order Workflow',          2, 5, 'Precoro PO management with multi-level approval routing is stronger than Spendesk'),
  ('Invoice Three-Way Matching',       2, 5, 'Precoro automated PO-receipt-invoice matching reduces accounting errors; Spendesk is basic'),
  ('Real-Time Budget Visibility',      5, 3, 'Spendesk real-time budget tracking by department is more granular than Precoro'),
  ('Subscription Management',          5, 2, 'Spendesk per-vendor virtual cards make SaaS subscription tracking and cancellation simple'),
  ('ERP and Accounting Integration',   4, 4, 'Both integrate with Xero, QuickBooks, and NetSuite for transaction sync'),
  ('Pricing for SMB Entry',            4, 4, 'Both offer accessible pricing for 20-200 person companies without enterprise minimums')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'spendesk-vs-precoro')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'spendesk-vs-precoro');
