-- compare-batch-61.sql
-- 5 HR / People Ops comparison pairs
-- All tool slugs confirmed from tools-batch-61.sql (lattice, culture-amp, 15five, leapsome, gusto, hibob)
--   and tools-batch-39.sql (rippling, bamboohr)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. lattice-vs-15five (performance management platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'lattice-vs-15five',
  'lattice',
  '15five',
  'Lattice and 15Five are the two leading continuous performance management platforms in 2026, but they emphasise different parts of the performance cycle. Lattice is the stronger enterprise choice, with deeper analytics, more configurable review frameworks, and AI-powered flight risk detection that surfaces retention risks proactively. 15Five is built around the weekly check-in habit and the Manager Effectiveness Indicator, making it the better pick for organisations that believe manager quality is the primary lever for engagement and retention. Both generate AI-assisted review summaries from accumulated data. Lattice wins on analytics depth and configurability; 15Five wins on manager development focus and adoption simplicity for first-time performance management deployments.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lattice-vs-15five');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'lattice-vs-15five', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Performance Review Depth',     5, 4, 'Lattice offers more configurable review frameworks and multi-rater options'),
  ('Manager Effectiveness Tools',  3, 5, '15Five Manager Effectiveness Indicator is best in class for coaching visibility'),
  ('AI Review Assistance',         4, 4, 'Both generate AI-drafted review summaries from accumulated feedback and goals'),
  ('OKR and Goal Tracking',        4, 3, 'Lattice OKR module is more mature; 15Five goals are functional but simpler'),
  ('Engagement Surveys',           4, 3, 'Lattice engagement has solid benchmark data; 15Five pulses are lighter'),
  ('Pricing Value',                3, 4, '15Five starts at $4/user/month vs Lattice at $11/user/month for base tier'),
  ('Ease of Adoption',             3, 5, '15Five weekly check-in format is easier to build organisational habits around')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lattice-vs-15five')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lattice-vs-15five');

-- 2. culture-amp-vs-15five (employee engagement platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'culture-amp-vs-15five',
  'culture-amp',
  '15five',
  'Culture Amp and 15Five approach employee engagement from different primary angles. Culture Amp is the engagement survey specialist with the most statistically credible benchmarking dataset in the category - drawing from 6,000 plus organisations for industry and size comparisons. 15Five embeds engagement through the continuous check-in habit, with pulse surveys tied to the manager effectiveness workflow. Culture Amp wins decisively on survey science, comment analysis depth, and enterprise reporting quality. 15Five wins on integration with the performance management workflow and ease of manager adoption. Organisations that treat engagement data as a board-level metric will find Culture Amp more credible; organisations that want engagement tied directly to manager accountability will find 15Five more actionable.',
  'culture-amp',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'culture-amp-vs-15five');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'culture-amp-vs-15five', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Benchmarking Data Quality',    5, 3, 'Culture Amp benchmarks from 6,000+ orgs; 15Five dataset is smaller'),
  ('Survey Comment Analysis',      5, 3, 'Culture Amp NLP theme extraction is best in class for open-text analysis'),
  ('Manager Effectiveness Focus',  2, 5, '15Five Manager Effectiveness Indicator is purpose-built for this use case'),
  ('Continuous Check-in Habit',    2, 5, '15Five weekly check-ins are a core product feature; Culture Amp is survey-centric'),
  ('Enterprise Reporting',         5, 3, 'Culture Amp analytics and executive dashboards are more mature and configurable'),
  ('Bias Detection in Reviews',    5, 2, 'Culture Amp flags biased language in performance feedback; 15Five does not'),
  ('Pricing Accessibility',        3, 4, '15Five starts lower; Culture Amp is positioned as a premium enterprise product')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'culture-amp-vs-15five')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'culture-amp-vs-15five');

-- 3. gusto-vs-rippling (payroll and HRIS platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'gusto-vs-rippling',
  'gusto',
  'rippling',
  'Gusto and Rippling are the two leading modern HR and payroll platforms for US businesses, but they target different stages of company growth and different operational complexity levels. Gusto is purpose-built for small businesses and offers the most approachable payroll, benefits, and compliance experience in the category - ideal for companies with 1 to 200 employees that want to get payroll right without an HR professional or dedicated IT team. Rippling is a full workforce management platform that unifies HR, IT, and Finance operations including device management, app provisioning, and expense management alongside payroll and HRIS. For growing mid-market companies that need HR and IT unified, Rippling is significantly more capable. For small businesses that need payroll done reliably and simply, Gusto is faster to implement, easier to manage, and more cost-effective at low headcount.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gusto-vs-rippling');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'gusto-vs-rippling', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Payroll Simplicity',           5, 4, 'Gusto is designed for non-HR operators; Rippling is more configuration-heavy'),
  ('IT and Device Management',     1, 5, 'Rippling manages devices and app provisioning; Gusto does not'),
  ('Benefits Administration',      4, 4, 'Both offer solid benefits administration; Gusto has broader broker network'),
  ('Implementation Speed',         5, 3, 'Gusto can be live in days; Rippling implementation takes weeks at minimum'),
  ('International Payroll',        2, 5, 'Rippling supports international payroll in 50+ countries; Gusto is US-only'),
  ('Pricing Transparency',         5, 3, 'Gusto has clear published pricing; Rippling requires custom quote for full stack'),
  ('Mid-market Scalability',       2, 5, 'Rippling scales to 1,000+ employees across complex entity structures')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gusto-vs-rippling')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'gusto-vs-rippling');

-- 4. leapsome-vs-lattice (performance management with European focus)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'leapsome-vs-lattice',
  'leapsome',
  'lattice',
  'Leapsome and Lattice are both enterprise-grade performance management platforms with strong AI features, but they diverge on a few meaningful dimensions. Leapsome was built in Europe with GDPR compliance as a foundational design requirement and differentiates by integrating compensation planning directly into the performance data workflow. Lattice was built in the US and has significantly deeper market penetration, more third-party integrations, and a more mature AI capability for flight risk detection and engagement analytics. European organisations with data sovereignty requirements will find Leapsome''s architecture more straightforward to deploy compliantly. US-headquartered companies will find Lattice''s integration ecosystem and customer support more complete. Both offer AI-assisted review writing and engagement survey tools; Lattice''s AI capabilities are more mature in 2026.',
  'lattice',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'leapsome-vs-lattice');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'leapsome-vs-lattice', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('GDPR Compliance Architecture', 5, 3, 'Leapsome is purpose-built for European data sovereignty requirements'),
  ('Compensation Planning',        5, 2, 'Leapsome integrates pay decisions into performance workflow natively'),
  ('AI Flight Risk Detection',     2, 5, 'Lattice AI identifies at-risk employees from engagement and performance patterns'),
  ('Integration Ecosystem',        3, 5, 'Lattice has broader HRIS, communication, and business tool integrations'),
  ('Learning Recommendations',     4, 3, 'Leapsome connects learning content to performance gap data intelligently'),
  ('AI Review Writing Assistance', 4, 4, 'Both generate structured draft reviews from feedback and goal data'),
  ('Market Presence and Support',  3, 5, 'Lattice has more customers, documentation, and implementation resources')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'leapsome-vs-lattice')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'leapsome-vs-lattice');

-- 5. hibob-vs-bamboohr (modern HRIS platforms for mid-market)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'hibob-vs-bamboohr',
  'hibob',
  'bamboohr',
  'HiBob and BambooHR are both mid-market HRIS platforms positioned as modern alternatives to legacy HR systems, but HiBob has pulled ahead meaningfully in the 2026 market on product depth and employee experience design. BambooHR has been the default mid-market HRIS for a decade and remains a solid, reliable system with strong onboarding and offboarding workflows. HiBob has invested more aggressively in engagement features, people analytics, and compensation tools - making it the stronger choice for HR teams that want a strategic analytics layer alongside core HRIS. BambooHR is often preferred for its simpler implementation and larger base of HR professional familiarity. HiBob is often preferred by people operations teams that want deeper analytics and a more contemporary employee-facing experience.',
  'hibob',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hibob-vs-bamboohr');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'hibob-vs-bamboohr', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('People Analytics Depth',       5, 3, 'HiBob provides richer workforce analytics and compensation equity reporting'),
  ('Employee Experience Design',   5, 3, 'HiBob interface and employee-facing features are more modern and engaging'),
  ('Onboarding and Offboarding',   4, 5, 'BambooHR onboarding workflows are mature and widely validated across HR teams'),
  ('Compensation Planning',        4, 3, 'HiBob includes pay equity and compensation review tools; BambooHR is more basic'),
  ('Implementation Simplicity',    3, 5, 'BambooHR is faster to implement and has broader HR professional familiarity'),
  ('Built-in Engagement Features', 5, 2, 'HiBob includes recognition, social, and pulse tools; BambooHR does not'),
  ('Pricing Transparency',         3, 4, 'BambooHR has more predictable pricing; HiBob requires custom quote for full features')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hibob-vs-bamboohr')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'hibob-vs-bamboohr');
