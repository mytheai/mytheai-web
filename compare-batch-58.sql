-- compare-batch-58.sql
-- 5 AI Real Estate / Proptech comparison pairs
-- All tool slugs confirmed in DB from tools-batch-58.sql (compass, reonomy, cherre, leverton,
--   rex-real-estate, rentlytics, reggora, matterport, skyline-ai, immoviewer)
-- All pair slugs verified fresh - grepped all prior compare-batch-*.sql files, no collisions found

-- 1. compass-vs-rex-real-estate (AI-powered residential brokerage platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'compass-vs-rex-real-estate',
  'compass',
  'rex-real-estate',
  'Compass and REX Real Estate represent two fundamentally different approaches to AI in residential real estate. Compass is a technology-augmented traditional brokerage - agents join Compass and gain access to AI tools for lead generation, pricing, and marketing, while operating within the standard commission structure and MLS framework. REX is a direct-model disruptor that uses AI-targeted digital advertising to find buyers without a buyer agent, offering sellers a reduced commission by keeping both sides of the transaction in-house. Compass wins on agent tool depth, market coverage, brand recognition, and the breadth of properties available through MLS access. REX wins on potential commission savings for sellers willing to forgo MLS exposure and accept a non-traditional transaction model. For sellers in major metros who want maximum exposure and a technology-forward agent experience, Compass is the stronger choice in 2026. For sellers comfortable with a direct model and prioritising commission cost reduction, REX offers a credible alternative where it operates.',
  'compass',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'compass-vs-rex-real-estate');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'compass-vs-rex-real-estate', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Market Coverage',               5, 2, 'Compass available across major US metros; REX limited to specific active markets'),
  ('Agent AI Tool Depth',           5, 2, 'Compass provides comprehensive AI suite for agents; REX is a direct platform'),
  ('MLS Property Access',           5, 2, 'Compass uses full MLS; REX bypasses MLS which limits buyer pool in most markets'),
  ('Seller Commission Cost',        2, 5, 'REX reduced-commission model provides meaningful savings versus traditional dual-agent'),
  ('Buyer Search Experience',       4, 3, 'Compass Collections workspace is collaborative; REX search is functional but narrower'),
  ('AI Pricing Intelligence',       5, 3, 'Compass AI pricing recommendations with confidence intervals are a standout feature'),
  ('Brand Trust and Recognition',   5, 3, 'Compass is a well-established brokerage brand; REX is less known and has faced regulatory friction')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'compass-vs-rex-real-estate')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'compass-vs-rex-real-estate');

-- 2. reonomy-vs-cherre (CRE data platforms for institutional users)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'reonomy-vs-cherre',
  'reonomy',
  'cherre',
  'Reonomy and Cherre both serve the commercial real estate data market but target different users with different problems. Reonomy is fundamentally a prospecting and deal origination tool - it is built for CRE brokers, lenders, and investors who need to identify the right property and owner to approach at the right moment, using debt maturity signals, ownership graphs, and AI-filtered property searches. Cherre is fundamentally a data infrastructure and analytics platform - it is built for institutional investors and asset managers who need to unify fragmented data from multiple systems into a coherent foundation for portfolio analytics and reporting. Reonomy wins for brokers and lenders doing outbound deal origination who need a standalone subscription with fast time to value. Cherre wins for institutional investment managers running large portfolios who need a unified data layer with custom analytics and third-party data marketplace access. These tools address adjacent problems rather than competing head-to-head for the same buyer.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'reonomy-vs-cherre');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'reonomy-vs-cherre', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Deal Origination / Prospecting', 5, 2, 'Reonomy built for proactive CRE deal origination with debt maturity and ownership signals'),
  ('Portfolio Analytics Depth',      2, 5, 'Cherre provides institutional-grade portfolio performance monitoring across asset classes'),
  ('Ownership Graph Intelligence',   5, 2, 'Reonomy reveals beneficial owners behind LLC layers for direct outreach'),
  ('Data Unification Layer',         2, 5, 'Cherre ingests and normalises multiple PMS and vendor data sources into single property view'),
  ('Third-Party Data Marketplace',   2, 5, 'Cherre marketplace provides curated satellite, foot traffic, and demographic data access'),
  ('Time to Value for Individual User', 5, 2, 'Reonomy self-serve subscription delivers value immediately; Cherre requires implementation'),
  ('AVM and Automated Valuation',    3, 5, 'Cherre AVMs calibrated per asset class and market; Reonomy does not include AVM')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'reonomy-vs-cherre')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'reonomy-vs-cherre');

-- 3. matterport-vs-immoviewer (3D virtual tour platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'matterport-vs-immoviewer',
  'matterport',
  'immoviewer',
  'Matterport and iMMOVIEWER both create navigable virtual tours for real estate property marketing, but they serve different segments with meaningfully different quality, cost, and market positioning. Matterport is the premium standard - its 3D digital twins are photorealistic, spatially accurate, and accepted by major MLS systems globally. The AI data extraction layer (floor plan generation, room dimensions, material identification) and the Cortex AI engine are capabilities that iMMOVIEWER cannot match. The trade-off is cost: Pro camera hardware is $3,000-$6,500 and subscription pricing adds to the total. iMMOVIEWER uses consumer 360-degree cameras, keeping entry cost low, and has strong real estate portal integration in European and Latin American markets that makes it a practical choice for agents in those regions. For US residential agents marketing mid-to-upper-tier listings, Matterport is the industry standard. For agents in Europe and Latin America, or any market where hardware cost is a barrier, iMMOVIEWER provides a credible alternative at a fraction of the cost.',
  'matterport',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'matterport-vs-immoviewer');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'matterport-vs-immoviewer', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('3D Model Quality and Realism',   5, 3, 'Matterport Pro capture produces photorealistic digital twins; iMMOVIEWER is good but lower fidelity'),
  ('Hardware and Entry Cost',        2, 5, 'iMMOVIEWER uses consumer 360 cameras; Matterport Pro hardware is $3K-$6.5K'),
  ('AI Data Extraction Layer',       5, 2, 'Matterport Cortex AI extracts floor plans, dimensions, and material data; iMMOVIEWER is more limited'),
  ('European Portal Integration',    3, 5, 'iMMOVIEWER has stronger integrations with European real estate portals'),
  ('US MLS and Portal Integration',  5, 3, 'Matterport is widely accepted by US MLS systems and major real estate portals'),
  ('Enterprise and Multi-Industry',  5, 2, 'Matterport serves construction, insurance, and facility management beyond real estate'),
  ('Subscription Accessibility',     3, 5, 'iMMOVIEWER entry price is significantly lower; Matterport mid-tier requires more commitment')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'matterport-vs-immoviewer')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'matterport-vs-immoviewer');

-- 4. leverton-vs-cherre (lease abstraction vs. portfolio data unification)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'leverton-vs-cherre',
  'leverton',
  'cherre',
  'Leverton and Cherre both serve institutional commercial real estate teams but solve different data problems at different points in the asset management workflow. Leverton solves the lease data problem: extracting structured information from thousands of unstructured lease documents so that asset managers have accurate, queryable lease data for IFRS 16/ASC 842 compliance, obligation tracking, and portfolio analytics. Cherre solves the broader data fragmentation problem: unifying property data from public records, market data vendors, and internal PMS systems into a coherent analytical foundation. In practice, these tools are complementary rather than competing - a large CRE investment manager might use Leverton to structure lease data and Cherre to aggregate that output alongside market and operational data. Leverton wins for teams whose primary bottleneck is unstructured lease documents. Cherre wins for teams whose primary bottleneck is fragmented operational and market data across multiple systems. Budget permitting, sophisticated institutional investors benefit from both.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'leverton-vs-cherre');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'leverton-vs-cherre', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Lease Document Extraction',      5, 1, 'Leverton is purpose-built for commercial lease abstraction; Cherre does not extract from documents'),
  ('Portfolio Data Unification',     2, 5, 'Cherre unifies data from PMS, market vendors, and public records into one property view'),
  ('IFRS 16 / ASC 842 Compliance',   5, 2, 'Leverton structured output feeds directly into lease accounting systems for standard compliance'),
  ('Automated Valuation Models',     1, 5, 'Cherre AVMs calibrated per asset class provide independent asset valuation support'),
  ('Third-Party Data Marketplace',   1, 5, 'Cherre provides foot traffic, satellite, and demographic data layering; Leverton does not'),
  ('Obligation and Renewal Tracking', 5, 2, 'Leverton tracks lease obligations, expiry dates, and renewal options across the portfolio'),
  ('M&A Due Diligence Support',      5, 2, 'Leverton rapid bulk lease abstraction is specifically valuable for acquisition due diligence')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'leverton-vs-cherre')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'leverton-vs-cherre');

-- 5. rentlytics-vs-reonomy (multifamily analytics vs. CRE prospecting)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'rentlytics-vs-reonomy',
  'rentlytics',
  'reonomy',
  'Rentlytics and Reonomy both serve real estate professionals working with data, but their use cases are distinct enough that they rarely compete for the same budget. Rentlytics is an asset management and operations tool - it is used by multifamily operators and property managers who already own a portfolio and need real-time analytics on occupancy, rent performance, and NOI across their properties relative to the market. Reonomy is an origination and prospecting tool - it is used by brokers, lenders, and investors who are trying to find the right property and owner to approach for their next deal. Rentlytics users are managing existing assets; Reonomy users are sourcing new ones. There is some overlap for multifamily investors who both manage existing assets and actively acquire new ones, but even in that case the two tools address different steps in the investment lifecycle. The choice between them is driven by which problem is more acute: operational portfolio intelligence or deal origination intelligence.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rentlytics-vs-reonomy');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'rentlytics-vs-reonomy', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Multifamily Portfolio Analytics', 5, 1, 'Rentlytics purpose-built for multifamily operational performance monitoring'),
  ('Deal Origination / Prospecting',  1, 5, 'Reonomy built for CRE deal sourcing and motivated seller identification'),
  ('PMS Integration (Yardi/RealPage)', 5, 1, 'Rentlytics ingests Yardi, RealPage, and Entrata data directly; Reonomy does not'),
  ('Ownership Graph and Contact Data', 1, 5, 'Reonomy reveals beneficial owners and provides contact data for outreach'),
  ('Occupancy Forecasting',           5, 1, 'Rentlytics 30-60-90 day occupancy prediction drives proactive leasing strategy'),
  ('Debt Maturity Signals',           1, 5, 'Reonomy identifies properties with approaching debt maturity as acquisition signals'),
  ('NOI Variance Analysis',           5, 1, 'Rentlytics AI-generated variance explanations compare actual to underwriting at asset level')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rentlytics-vs-reonomy')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'rentlytics-vs-reonomy');
