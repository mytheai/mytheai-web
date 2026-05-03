-- compare-batch-67.sql
-- 5 Climate / Sustainability tool comparison pairs
-- All tool slugs confirmed from tools-batch-67.sql (S81)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. watershed-vs-persefoni (enterprise carbon accounting head-to-head)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'watershed-vs-persefoni',
  'watershed',
  'persefoni',
  'Watershed and Persefoni are the two leading enterprise carbon accounting platforms in 2026, both targeting large corporates and financial institutions needing audit-ready Scope 1, 2, and 3 emissions data. Watershed differentiates on Scope 3 supplier engagement depth and its integrated reduction program with SBTi-aligned target management. Persefoni differentiates on financial accounting rigor - its GAEAP methodology and dedicated PCAF financed emissions module make it the preferred platform for banks, asset managers, and insurance companies calculating financed emissions under their loan and investment portfolios. For operating companies focused on supply chain decarbonization, Watershed has the edge. For financial institutions needing PCAF compliance, Persefoni is the stronger choice. Both platforms require enterprise engagement and produce audit-ready outputs for CSRD and SEC climate disclosures.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'watershed-vs-persefoni');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'watershed-vs-persefoni', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Scope 3 Supplier Engagement',  5, 3, 'Watershed supplier data collection tools are the deepest in the market; Persefoni covers Scope 3 but less specialized'),
  ('Financial Institution Module', 2, 5, 'Persefoni PCAF financed emissions module is purpose-built for banks and asset managers; Watershed does not cover this'),
  ('Audit Readiness',              5, 5, 'Both produce audit-ready outputs; Persefoni GAEAP framing mirrors financial audit standards more explicitly'),
  ('CSRD and SEC Alignment',       5, 5, 'Both platforms produce structured outputs for CSRD and SEC climate disclosure requirements'),
  ('Reduction Program Management', 5, 3, 'Watershed reduction roadmap and SBTi target management is more mature; Persefoni focuses on accounting and disclosure'),
  ('Implementation Speed',         3, 3, 'Both require structured onboarding engagements - neither is self-serve at enterprise scale'),
  ('SMB Accessibility',            1, 1, 'Both are enterprise-only - not accessible to companies below 200 employees or without dedicated sustainability staff')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'watershed-vs-persefoni')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'watershed-vs-persefoni');

-- 2. sweep-vs-normative (carbon platform vs automated spend-based engine)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'sweep-vs-normative',
  'sweep',
  'normative',
  'Sweep and Normative take different approaches to the core carbon accounting challenge in 2026. Normative is built around speed to first inventory: its spend-based calculation engine converts financial data from accounting systems into a complete Scope 1, 2, and 3 emissions estimate within days of connection, using one of the largest proprietary emission factor databases covering 163 countries. Sweep prioritizes strategic depth alongside measurement - its supply chain engagement module for primary Scope 3 data collection and its net-zero strategy roadmap tools go further than Normative into the decarbonization program management that companies need after their first inventory. Companies that need a first baseline quickly should consider Normative. Companies that are ready to move from measurement into supplier engagement and reduction planning will find Sweep more complete.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sweep-vs-normative');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sweep-vs-normative', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Speed to First Inventory',    3, 5, 'Normative produces a complete inventory in days from accounting data; Sweep onboarding takes longer'),
  ('Emission Factor Coverage',    4, 5, 'Normative has 20M+ factors across 163 countries; Sweep uses standard GHG Protocol factors'),
  ('Supply Chain Engagement',     5, 2, 'Sweep supplier onboarding for primary Scope 3 data is a core feature; Normative is spend-based'),
  ('Net-Zero Strategy Tools',     5, 3, 'Sweep reduction roadmap and initiative tracking are more mature than Normative strategy features'),
  ('CSRD Reporting Outputs',      5, 4, 'Both produce CSRD-aligned outputs; Sweep has strong CSRD expertise from Paris headquarters'),
  ('SMB Pricing Accessibility',   3, 4, 'Normative has tiers for companies from 50 employees; Sweep pricing scales up similarly but has mid-market options'),
  ('Carbon Expert Advisory',      4, 4, 'Both offer carbon accounting expert guidance; Sweep leans more into advisory alongside the platform')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sweep-vs-normative')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sweep-vs-normative');

-- 3. greenly-vs-plan-a (SMB-accessible vs full-ESG European platform)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'greenly-vs-plan-a',
  'greenly',
  'plan-a',
  'Greenly and Plan A are both Paris and Berlin-based sustainability platforms serving European companies, but they differ significantly in scope and target customer. Greenly is purpose-built for SMBs - its accounting software integration produces a first carbon inventory in a working day at pricing starting around $500 per year, making it accessible to companies with limited sustainability budgets. Plan A targets mid-market and enterprise companies that need full ESG coverage across environmental, social, and governance metrics alongside carbon, with decarbonization scenario modeling and multi-framework reporting for CSRD, GRI, and SASB. For SMBs responding to a customer carbon request, Greenly is faster and cheaper. For companies with CSRD obligations covering the full ESG spectrum, Plan A is more comprehensive.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'greenly-vs-plan-a');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'greenly-vs-plan-a', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('SMB Pricing Accessibility',   5, 2, 'Greenly starts at ~$500/year; Plan A requires enterprise engagement and is priced accordingly'),
  ('Speed to First Inventory',    5, 3, 'Greenly connects to accounting software and produces results in a day; Plan A takes longer to configure'),
  ('ESG Breadth Beyond Carbon',   2, 5, 'Plan A covers social and governance metrics; Greenly is focused on carbon footprint measurement'),
  ('CSRD Full Compliance',        3, 5, 'Plan A covers all CSRD pillars including governance and social; Greenly covers the environmental section'),
  ('Decarbonization Roadmap',     2, 5, 'Plan A scenario modeling and SBTi alignment is more mature; Greenly has basic target tracking'),
  ('Employee Engagement Module',  4, 3, 'Greenly employee engagement and culture tools are more developed than Plan A internal engagement'),
  ('ERP Integration Depth',       2, 4, 'Plan A integrates with SAP and Microsoft Dynamics; Greenly focuses on accounting software like Xero and QuickBooks')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'greenly-vs-plan-a')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'greenly-vs-plan-a');

-- 4. climatiq-vs-emitwise (API carbon data vs manufacturing-focused platform)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'climatiq-vs-emitwise',
  'climatiq',
  'emitwise',
  'Climatiq and Emitwise both involve AI and carbon calculation, but they serve fundamentally different customers in 2026. Climatiq is an emission factor API for developers building sustainability features into software products - its value is in the quality and breadth of the emission factor database and the ease of API integration, not in providing a sustainability management interface. Emitwise is a carbon management platform for manufacturing companies, using AI document extraction to automate the data ingestion from invoices, energy bills, and production records that makes Scope 1 and upstream Scope 3 accounting painful for manufacturers without sustainability staff. A software company building a carbon footprint feature into their product should use Climatiq. A European manufacturer that needs to measure and report its carbon footprint should use Emitwise.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'climatiq-vs-emitwise');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'climatiq-vs-emitwise', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Developer API Access',        5, 1, 'Climatiq is an API-first product; Emitwise is a platform with no public API for third-party integration'),
  ('Emission Factor Coverage',    5, 3, 'Climatiq has 50,000+ factors across 150+ countries; Emitwise focuses on manufacturing-relevant factors'),
  ('Manufacturing Scope 1',       1, 5, 'Emitwise is designed for manufacturing Scope 1 process emissions; Climatiq does not address this use case'),
  ('AI Document Extraction',      1, 5, 'Emitwise AI ingests invoices and energy bills automatically; Climatiq handles structured API inputs only'),
  ('Non-Technical User Access',   3, 4, 'Climatiq has a no-code interface; Emitwise is designed for sustainability managers at manufacturers'),
  ('Supplier Engagement',         2, 4, 'Emitwise supplier module for Scope 3 data collection; Climatiq has no supplier engagement features'),
  ('Pricing Accessibility',       5, 3, 'Climatiq free tier and $99/month paid plan; Emitwise subscription requires enterprise engagement')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'climatiq-vs-emitwise')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'climatiq-vs-emitwise');

-- 5. ibm-envizi-vs-watershed (enterprise ESG data management vs carbon platform)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'ibm-envizi-vs-watershed',
  'ibm-envizi',
  'watershed',
  'IBM Envizi and Watershed serve enterprise sustainability programs from different angles in 2026. Envizi is an ESG data management platform - its strength is consolidating energy, emissions, water, waste, and social data from hundreds or thousands of sites across a complex real estate or manufacturing footprint, normalizing it, and producing disclosure outputs for CDP, GRI, TCFD, and regulatory frameworks. Watershed is a carbon-focused platform with deeper Scope 3 supplier engagement capability, SBTi-aligned reduction program management, and a more modern product experience. For organizations with a large multi-site property portfolio - retailers, banks with branch networks, hospitality groups - Envizi''s scale data management is the core value. For companies where Scope 3 supplier engagement and a structured decarbonization program are the priority, Watershed is the stronger choice.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ibm-envizi-vs-watershed');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'ibm-envizi-vs-watershed', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Multi-Site Data Management',  5, 3, 'Envizi handles hundreds or thousands of sites with automated EDI utility feeds; Watershed is less specialized here'),
  ('Scope 3 Supplier Engagement', 2, 5, 'Watershed supplier data collection is a core differentiator; Envizi covers Scope 3 estimates but less depth'),
  ('ESG Breadth',                 5, 3, 'Envizi covers energy, water, waste, and social data; Watershed focuses on carbon and GHG emissions'),
  ('Reduction Program Tools',     2, 5, 'Watershed SBTi target management and initiative tracking is more mature than Envizi reduction features'),
  ('Product Modernity',           3, 5, 'Watershed is a newer product with a more modern UX; Envizi reflects its enterprise software heritage'),
  ('IBM Ecosystem Integration',   5, 2, 'Envizi integrates deeply with IBM systems; Watershed integrates with standard financial and ERP systems'),
  ('Implementation Timeline',     2, 3, 'Both require enterprise implementations; Envizi large multi-site deployments are the most complex')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ibm-envizi-vs-watershed')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'ibm-envizi-vs-watershed');
