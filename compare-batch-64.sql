-- compare-batch-64.sql
-- 5 Supply Chain / Logistics comparison pairs
-- All tool slugs confirmed from tools-batch-64.sql (S78, confirmed in DB)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. project44-vs-flexport (real-time visibility vs freight forwarding)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'project44-vs-flexport',
  'project44',
  'flexport',
  'project44 and Flexport address adjacent but distinct supply chain challenges in 2026. project44 is a pure visibility and analytics layer - it connects to 200,000+ carriers and provides real-time tracking, predictive ETAs, and exception management on top of a shipper''s existing logistics infrastructure. Flexport is a full-service freight forwarder that also provides visibility software, meaning it handles execution (booking, customs, carrier management) alongside tracking. project44 wins for shippers who already have freight forwarders and need carrier-agnostic visibility across all modes. Flexport wins for shippers who want a single partner handling both execution and visibility, particularly for international ocean and air freight. The tools are more complementary than competitive for large shippers with complex multi-modal networks.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'project44-vs-flexport');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'project44-vs-flexport', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Sophistication',      5, 4, 'project44 predictive ETAs and exception AI are deeper; Flexport AI is strong on disruption alerting and market analytics'),
  ('Coverage Breadth',       5, 3, 'project44 connects to 200,000+ carriers globally across all modes; Flexport coverage reflects its own forwarder network'),
  ('Implementation Speed',   3, 4, 'Flexport onboards faster for single forwarder relationship; project44 integration with multiple carriers and TMS is a longer project'),
  ('Pricing Value',          3, 4, 'Flexport pricing is bundled with freight services; project44 is enterprise SaaS pricing on top of existing logistics costs'),
  ('Integrations',           5, 3, 'project44 integrates with SAP, Oracle, and all major TMS/ERP; Flexport integrations are more limited to its own portal'),
  ('Scalability',            5, 4, 'project44 scales to any freight volume and mode mix; Flexport scales well within its forwarder network capacity'),
  ('Best For',               4, 4, 'project44 best for multi-forwarder visibility; Flexport best for consolidating execution and visibility with one partner')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'project44-vs-flexport')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'project44-vs-flexport');

-- 2. kinaxis-vs-blue-yonder (supply chain planning leaders)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'kinaxis-vs-blue-yonder',
  'kinaxis',
  'blue-yonder',
  'Kinaxis and Blue Yonder are the two most prominent enterprise supply chain planning platforms in 2026, each with distinct strengths. Kinaxis RapidResponse is the stronger choice for organizations where concurrent multi-tier supply planning is the primary challenge - its ability to model the ripple effects of supply disruptions and demand spikes simultaneously across complex global networks is best-in-class. Blue Yonder Luminate leads on AI demand sensing and multi-echelon inventory optimization, making it the preferred platform for retail, grocery, and CPG companies where SKU-level forecasting accuracy and replenishment optimization drive margin. Both require significant implementation investment and are designed for large enterprise deployments. The choice typically comes down to whether planning complexity (Kinaxis) or demand forecasting accuracy and inventory optimization (Blue Yonder) is the primary pain point.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'kinaxis-vs-blue-yonder');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'kinaxis-vs-blue-yonder', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Sophistication',      5, 5, 'Both have deep AI - Kinaxis leads on concurrent planning simulation; Blue Yonder leads on demand sensing with external signals'),
  ('Coverage Breadth',       5, 4, 'Kinaxis covers full S&OP and IBP across supply, demand, capacity; Blue Yonder is stronger in retail-specific demand and workforce modules'),
  ('Implementation Speed',   3, 3, 'Both require multi-month, high-investment implementations - no meaningful difference for enterprise deployments'),
  ('Pricing Value',          3, 3, 'Both are premium enterprise platforms with comparable pricing ranges in the high six to seven figures annually'),
  ('Integrations',           4, 4, 'Both integrate with major ERP platforms; Blue Yonder has stronger retail POS integration; Kinaxis has broader manufacturing ERP coverage'),
  ('Scalability',            5, 5, 'Both scale to global enterprise complexity - top-tier platforms for the largest supply chain operations'),
  ('Best For',               5, 4, 'Kinaxis best for complex multi-tier manufacturing and high-tech; Blue Yonder best for retail, grocery, and CPG inventory optimization')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'kinaxis-vs-blue-yonder')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'kinaxis-vs-blue-yonder');

-- 3. shippo-vs-easypost (multi-carrier shipping APIs)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'shippo-vs-easypost',
  'shippo',
  'easypost',
  'Shippo and EasyPost are the two dominant multi-carrier shipping API platforms for e-commerce businesses in 2026. Shippo is the more business-friendly option - it offers a dashboard alongside its API, pre-negotiated carrier rates, and a no-code interface for smaller merchants who do not need developer-only tooling. EasyPost is the developer-first platform with a cleaner REST API, more granular control, and a broader carrier integration count of 100+ that appeals to engineering teams building custom shipping workflows or high-volume fulfillment platforms. Shippo wins for small to mid-size merchants who want quick setup and discounted rates without significant engineering resources. EasyPost wins for technical teams building shipping infrastructure that needs precise API control and the broadest possible carrier coverage.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'shippo-vs-easypost');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'shippo-vs-easypost', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Sophistication',      3, 3, 'Both offer rate optimization and address verification; neither has deep AI differentiation - core value is carrier connectivity'),
  ('Coverage Breadth',       4, 5, 'EasyPost has 100+ carrier integrations; Shippo covers 85+ - both are comprehensive, EasyPost has the edge on breadth'),
  ('Implementation Speed',   5, 4, 'Shippo is faster for non-developers with its dashboard UI; EasyPost requires API integration but documentation is excellent'),
  ('Pricing Value',          5, 4, 'Shippo pre-negotiated rates provide immediate savings for small merchants; EasyPost pricing is usage-based and scales efficiently at volume'),
  ('Integrations',           4, 4, 'Both integrate with major e-commerce platforms; Shippo has more pre-built e-commerce integrations; EasyPost has stronger developer tools'),
  ('Scalability',            4, 5, 'EasyPost is the preferred choice for high-volume platforms and fulfillment companies; Shippo scales well for mid-size merchants'),
  ('Best For',               4, 5, 'Shippo best for SMB merchants needing discounted rates quickly; EasyPost best for technical teams building shipping infrastructure')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'shippo-vs-easypost')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'shippo-vs-easypost');

-- 4. o9-solutions-vs-kinaxis (planning platforms head-to-head)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'o9-solutions-vs-kinaxis',
  'o9-solutions',
  'kinaxis',
  'o9 Solutions and Kinaxis are direct competitors in the enterprise supply chain and integrated business planning market in 2026. o9 Solutions differentiates on its knowledge graph architecture - a connected data model that links commercial planning, supply chain planning, and financial planning in a single platform, making it the preferred choice for organizations implementing true integrated business planning across functions. Kinaxis RapidResponse differentiates on concurrent planning speed and supply network simulation depth, making it the stronger choice for manufacturing-intensive organizations where supply-side complexity and scenario modeling are the primary drivers. Both are tier-1 enterprise platforms with significant implementation requirements. o9 tends to win IBP-driven evaluations where cross-functional planning unification is the goal; Kinaxis tends to win supply-chain-first evaluations where speed-to-respond and simulation depth are paramount.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'o9-solutions-vs-kinaxis');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'o9-solutions-vs-kinaxis', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Sophistication',      4, 5, 'Kinaxis leads on real-time concurrent planning and simulation speed; o9 leads on cross-functional data integration intelligence'),
  ('Coverage Breadth',       5, 4, 'o9 covers commercial, supply, and financial planning in a unified model; Kinaxis is strongest in supply chain planning specifically'),
  ('Implementation Speed',   3, 3, 'Both require 9-18 month implementations for enterprise deployments - no significant difference'),
  ('Pricing Value',          3, 3, 'Both command premium enterprise pricing; o9 may have slightly more aggressive commercial terms for new logos'),
  ('Integrations',           4, 4, 'Both integrate with SAP and Oracle; o9 has broader commercial system connections; Kinaxis has stronger manufacturing execution links'),
  ('Scalability',            5, 5, 'Both are built for global enterprise scale - this is not a differentiating factor between the two platforms'),
  ('Best For',               5, 4, 'o9 best for IBP-led transformations; Kinaxis best for supply-chain-first organizations in high-tech and industrial manufacturing')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'o9-solutions-vs-kinaxis')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'o9-solutions-vs-kinaxis');

-- 5. stord-vs-flexport (cloud supply chain vs freight forwarding)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'stord-vs-flexport',
  'stord',
  'flexport',
  'Stord and Flexport represent two different approaches to solving the mid-market supply chain problem in 2026. Stord is a cloud supply chain platform that combines its own fulfillment network with software that connects inventory across third-party warehouses and carriers - making it the right choice for direct-to-consumer brands that need both fulfillment execution and software orchestration in one place. Flexport is a freight forwarder with a software portal, focused on international freight - ocean, air, and customs - rather than domestic fulfillment. Stord wins for US-based DTC brands that need domestic warehousing and fulfillment with visibility software. Flexport wins for brands with significant international sourcing that need a modern freight forwarding partner for cross-border logistics.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'stord-vs-flexport');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'stord-vs-flexport', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Sophistication',      3, 4, 'Flexport AI is stronger on disruption alerting and trade lane analytics; Stord AI focuses on inventory optimization across its network'),
  ('Coverage Breadth',       3, 5, 'Flexport handles global multi-modal freight; Stord is primarily US domestic fulfillment and warehousing'),
  ('Implementation Speed',   4, 4, 'Both onboard mid-market brands in weeks; Stord requires physical warehouse integration; Flexport requires trade lane setup'),
  ('Pricing Value',          4, 4, 'Both offer transparent pricing for mid-market brands; Stord warehousing fees and Flexport freight fees are comparable in market positioning'),
  ('Integrations',           4, 3, 'Stord integrates with Shopify, WooCommerce, and major e-commerce platforms; Flexport integrations are centered on freight and customs workflows'),
  ('Scalability',            3, 5, 'Flexport scales to enterprise freight volume; Stord scales within its warehouse network footprint'),
  ('Best For',               4, 4, 'Stord best for US DTC brands needing domestic fulfillment plus software; Flexport best for brands with heavy international sourcing needs')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'stord-vs-flexport')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'stord-vs-flexport');
