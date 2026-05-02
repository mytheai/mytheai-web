-- compare-batch-62.sql
-- 5 insurance / InsurTech comparison pairs
-- All tool slugs confirmed from tools-batch-62.sql (in DB after S76)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. lemonade-vs-next-insurance (consumer / SMB digital insurance)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'lemonade-vs-next-insurance',
  'lemonade',
  'next-insurance',
  'Lemonade and Next Insurance are the two most prominent AI-native digital insurers in 2026, but they serve fundamentally different customer segments. Lemonade targets consumers - renters, homeowners, and pet owners - with a fast, app-first experience and a charitable giveback model. Next Insurance targets small businesses, offering instant digital quotes and binds across 1,300 professions without agents or paper. Both use AI to underwrite policies in seconds and process straightforward claims digitally. Lemonade wins on consumer product breadth and brand experience; Next Insurance wins on commercial coverage range and small business accessibility. The tools rarely compete for the same customer, making the comparison most useful for businesses evaluating which model applies to their own insurtech product strategy.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lemonade-vs-next-insurance');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'lemonade-vs-next-insurance', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Underwriting Speed',       5, 5, 'Both bind policies in under 90 seconds using AI - parity at the top'),
  ('Consumer Product Range',      5, 2, 'Lemonade covers renters, homeowners, pet, life; Next focuses on commercial'),
  ('Small Business Coverage',     1, 5, 'Next Insurance covers 1,300 professions; Lemonade has no commercial lines'),
  ('Claims Automation',           5, 4, 'Lemonade AI claims bot pays in minutes; Next is fast but less dramatic'),
  ('Pricing Transparency',        5, 4, 'Both publish indicative rates; Lemonade more transparent on consumer tiers'),
  ('Geographic Coverage',         3, 4, 'Next Insurance covers all 50 US states; Lemonade has narrower US + select EU/UK'),
  ('Certificate of Insurance',    1, 5, 'Next Insurance issues instant digital COIs; Lemonade does not offer commercial COIs')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lemonade-vs-next-insurance')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lemonade-vs-next-insurance');

-- 2. tractable-vs-shift-technology (claims AI - computer vision vs fraud detection)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'tractable-vs-shift-technology',
  'tractable',
  'shift-technology',
  'Tractable and Shift Technology are both AI platforms deployed inside traditional P&C insurers to automate the claims process, but they solve different problems. Tractable uses computer vision to assess physical damage from photos, automating the visual inspection and repair estimation step of auto and property claims. Shift Technology uses machine learning to score claims for fraud probability, flagging suspicious patterns across claim networks that human adjusters would miss. Many large carriers deploy both: Tractable accelerates legitimate claims and Shift Technology catches the fraudulent ones. Choosing between them depends on where the carrier''s greatest operational pain is - adjustment costs and cycle time (Tractable) or fraud leakage and investigation costs (Shift Technology).',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'tractable-vs-shift-technology');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'tractable-vs-shift-technology', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Sophistication',           5, 5, 'Both are best-in-class AI for their specific domain - visual AI vs fraud ML'),
  ('Claims Cycle Time Reduction', 5, 3, 'Tractable directly compresses assessment time; Shift speeds investigation workflow'),
  ('Fraud Detection',             2, 5, 'Shift Technology is purpose-built for fraud scoring; Tractable is not a fraud tool'),
  ('Physical Damage Assessment',  5, 1, 'Tractable is the market leader in AI damage assessment; Shift does not do this'),
  ('Implementation Speed',        3, 3, 'Both require 3-6 month integration with existing claims systems'),
  ('Carrier Integration Depth',   4, 5, 'Shift integrates into claims workflow broadly; Tractable is assessment-specific'),
  ('ROI Measurability',           5, 4, 'Both show clear ROI - Tractable on adjustment cost, Shift on fraud leakage recovery')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'tractable-vs-shift-technology')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'tractable-vs-shift-technology');

-- 3. planck-vs-cape-analytics (commercial underwriting data AI)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'planck-vs-cape-analytics',
  'planck',
  'cape-analytics',
  'Planck and Cape Analytics both use AI to automate the data gathering that commercial insurance underwriters have traditionally done manually, but from different data sources. Planck analyses text and web data - business websites, review platforms, industry databases, news sources - to infer what a business actually does, its risk profile, and key underwriting characteristics. Cape Analytics analyses aerial and satellite imagery to assess property characteristics - roof condition, structure type, presence of pools or trampolines, distance to wildfire zones - for property underwriting. Carriers deploying both get a comprehensive pre-fill capability: Planck fills in the business operations picture and Cape Analytics fills in the physical property picture. Neither replaces the other; they are complementary data sources addressing different parts of the underwriting workflow.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'planck-vs-cape-analytics');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'planck-vs-cape-analytics', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Sophistication',           5, 5, 'Both use best-in-class AI for their respective data domains'),
  ('Business Operations Data',    5, 1, 'Planck specialises in business classification and operations intelligence'),
  ('Property Imagery Analysis',   1, 5, 'Cape Analytics is the leader in aerial imagery-based property assessment'),
  ('Underwriting Automation',     5, 4, 'Planck directly reduces time-to-quote on SMB commercial; Cape reduces inspection costs'),
  ('Coverage Breadth',            4, 4, 'Planck covers most commercial lines; Cape strongest in property and cat-exposed lines'),
  ('Pricing Value',               4, 4, 'Both priced at enterprise tiers - ROI depends on commercial underwriting volume'),
  ('Best For',                    4, 4, 'Planck for commercial liability and workers comp; Cape for property and homeowners')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'planck-vs-cape-analytics')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'planck-vs-cape-analytics');

-- 4. zelros-vs-socotra (broker recommendation AI vs core platform modernisation)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'zelros-vs-socotra',
  'zelros',
  'socotra',
  'Zelros and Socotra both serve insurance carriers looking to modernise, but at different layers of the technology stack. Zelros is a front-office AI tool that helps brokers and agents give better personalised policy recommendations by analysing customer data and surfacing the right products at the right time. Socotra is a back-office core platform replacement - a modern cloud-native policy administration system that allows carriers to launch new products and manage policy lifecycle without legacy system constraints. The tools address entirely different problems: Zelros improves sales and distribution effectiveness; Socotra improves product launch speed and operational flexibility. Insurers building a full technology transformation typically need both.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zelros-vs-socotra');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'zelros-vs-socotra', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Sophistication',           5, 3, 'Zelros AI is the core value; Socotra is a platform where AI can be built on top'),
  ('Distribution and Sales Impact',5, 1, 'Zelros directly improves broker recommendation quality and conversion'),
  ('Product Launch Speed',        1, 5, 'Socotra is purpose-built to accelerate new insurance product launches'),
  ('Implementation Speed',        3, 2, 'Zelros deploys faster; Socotra is a core system migration - significant project'),
  ('Integrations',                4, 4, 'Both integrate with existing carrier systems - Zelros at the front end, Socotra at core'),
  ('Reporting and Analytics',     4, 3, 'Zelros provides broker performance analytics; Socotra focuses on policy operations data'),
  ('Best For',                    4, 4, 'Zelros for distribution optimisation; Socotra for carriers escaping legacy policy admin')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zelros-vs-socotra')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zelros-vs-socotra');

-- 5. coalition-vs-tractable (cyber insurance AI vs physical claims AI - different angles)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'coalition-vs-tractable',
  'coalition',
  'tractable',
  'Coalition and Tractable represent two distinct ways AI is transforming the insurance value chain in 2026. Coalition is redefining what an insurance product can be by bundling active AI risk monitoring with cyber coverage - the policy actively works to prevent claims, not just pay them. Tractable is redefining how physical claims are assessed by replacing human adjusters with computer vision AI that evaluates damage in seconds from photos. Coalition serves end customers buying cyber insurance; Tractable serves carriers processing physical damage claims. The comparison is valuable for insurance executives evaluating where AI delivers the most transformative impact - in underwriting and risk prevention, or in claims operations and adjustment costs.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'coalition-vs-tractable');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'coalition-vs-tractable', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Sophistication',           5, 5, 'Both are leaders in AI sophistication within their specific insurance applications'),
  ('Coverage Breadth',            3, 1, 'Coalition is a full insurer; Tractable is a claims technology vendor, not an insurer'),
  ('Pricing Value',               4, 4, 'Coalition SMB premiums are competitive; Tractable pricing depends on claim volume scale'),
  ('Implementation Speed',        5, 3, 'Coalition is a direct insurer - no implementation; Tractable requires carrier integration'),
  ('Integrations',                2, 4, 'Tractable integrates with carrier claims systems; Coalition is self-contained'),
  ('Reporting',                   4, 4, 'Coalition provides risk posture reports; Tractable gives claim assessment analytics'),
  ('Best For',                    5, 5, 'Coalition: SMBs buying cyber; Tractable: carriers reducing auto and property adjustment costs')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'coalition-vs-tractable')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'coalition-vs-tractable');
