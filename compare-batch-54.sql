-- compare-batch-54.sql
-- 5 AI E-commerce tool comparison pairs
-- All tool slugs confirmed in DB from tools-batch-54.sql
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. shopify-magic-vs-octane-ai (Shopify-native AI vs zero-party data)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'shopify-magic-vs-octane-ai',
  'shopify-magic',
  'octane-ai',
  'Shopify Magic and Octane AI both add AI capabilities to Shopify stores but solve different problems. Shopify Magic is the platform-native AI for content generation - product descriptions, blog drafts, email subject lines, and conversational analytics via Sidekick. It is free for all Shopify merchants. Octane AI is a personalization platform built around quizzes that capture zero-party data (customer preferences, goals, lifestyle attributes) and use it to recommend products and personalize email flows. Magic is content-side AI; Octane is conversion-side AI. They are complements, not direct competitors. Magic wins on pricing and integration depth. Octane wins for DTC brands serious about personalization and email-driven revenue.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'shopify-magic-vs-octane-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'shopify-magic-vs-octane-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Pricing',                    5, 2, 'Magic is free for all Shopify merchants; Octane starts at $50/mo'),
  ('Content Generation',         5, 2, 'Magic generates descriptions, blogs, emails; Octane focuses on quiz logic'),
  ('Personalization Depth',      2, 5, 'Octane builds zero-party data; Magic does not personalize'),
  ('Quiz Builder',               1, 5, 'Octane is best-in-class quiz builder; Magic has no quizzes'),
  ('Email Integration',          3, 5, 'Octane integrates with Klaviyo, Yotpo, Postscript natively'),
  ('Setup Time',                 5, 3, 'Magic is on by default; Octane requires quiz design and tuning'),
  ('Ideal Store Size',           4, 4, 'Magic fits any Shopify store; Octane fits $1M+ DTC brands')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'shopify-magic-vs-octane-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'shopify-magic-vs-octane-ai');

-- 2. rep-ai-vs-octane-ai (on-site AI assistant vs quiz-driven personalization)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'rep-ai-vs-octane-ai',
  'rep-ai',
  'octane-ai',
  'Rep AI and Octane AI both improve conversion on Shopify stores via AI but use different mechanics. Rep AI is a real-time shopping assistant - an LLM-powered chat widget that intervenes when customers hesitate, asks contextual questions, and recommends products from the store catalog. Octane AI captures zero-party data via quizzes upfront, then uses it to drive personalized email flows and product recommendations. Rep optimizes the in-session conversion. Octane optimizes the long-term customer relationship. For brands with strong email programs and high LTV products, Octane''s data layer is more valuable. For brands where each session decision matters most, Rep''s real-time assistance is the better lever.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rep-ai-vs-octane-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'rep-ai-vs-octane-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Real-time Conversion Lift',  5, 3, 'Rep intervenes during browsing; Octane impact comes after quiz completion'),
  ('Zero-party Data Collection', 2, 5, 'Octane is built around quiz data; Rep gathers some via conversations'),
  ('Email Marketing Synergy',    3, 5, 'Octane natively feeds Klaviyo flows; Rep less integrated with email'),
  ('Conversational AI Quality',  5, 2, 'Rep uses LLM-grade conversation; Octane chat is rule-based'),
  ('Catalog Awareness',          5, 3, 'Rep recommendations come from actual store catalog'),
  ('Setup Effort',               3, 3, 'Both require some configuration; Octane needs quiz design'),
  ('Ideal Use Case',             4, 4, 'Rep for gift-finder; Octane for beauty, supplements, lifestyle')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rep-ai-vs-octane-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'rep-ai-vs-octane-ai');

-- 3. searchspring-vs-nosto (search/merchandising vs full personalization platform)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'searchspring-vs-nosto',
  'searchspring',
  'nosto',
  'Searchspring and Nosto are both enterprise ecommerce AI platforms but target different parts of the customer experience. Searchspring is a specialist in site search and merchandising - the AI handles query understanding, product ranking, visual search, and merchandiser-friendly tools to control product visibility. Nosto is a Commerce Experience Platform spanning search, product recommendations, email personalization, ad audiences, and content personalization across the full customer journey. Searchspring goes deeper on search; Nosto goes wider across personalization touchpoints. Mid-market retailers needing primarily better search performance pick Searchspring. Mid-market retailers needing unified personalization pick Nosto.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'searchspring-vs-nosto');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'searchspring-vs-nosto', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Site Search Quality',        5, 4, 'Searchspring''s search algorithms are deeper than Nosto''s'),
  ('Product Recommendations',    3, 5, 'Nosto handles recommendations across channels; Searchspring focuses on search'),
  ('Merchandising Tools',        5, 4, 'Searchspring''s visual merchandiser interface is best-in-class'),
  ('Email Personalization',      1, 5, 'Nosto includes email send-time and content personalization'),
  ('Ad Audience Building',       1, 5, 'Nosto exports lookalike audiences to Facebook, Google'),
  ('Pricing',                    3, 2, 'Searchspring lower entry price; Nosto more comprehensive but expensive'),
  ('Implementation Time',        4, 3, 'Searchspring faster to deploy; Nosto requires more integration time')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'searchspring-vs-nosto')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'searchspring-vs-nosto');

-- 4. rebuy-vs-nosto (Shopify-native vs cross-platform enterprise)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'rebuy-vs-nosto',
  'rebuy',
  'nosto',
  'Rebuy and Nosto are both AI personalization platforms but built for different store sizes. Rebuy is Shopify-native, designed for the Shopify Plus brand sweet spot of $5M-$50M GMV. The pricing scales reasonably and the no-code merchandiser interface lets marketing teams configure recommendations without engineering involvement. Nosto is a cross-platform enterprise CXP that supports Shopify Plus, BigCommerce, Magento, and Salesforce Commerce Cloud, with deeper personalization features but enterprise-tier pricing and longer implementation. For Shopify Plus brands not yet hitting $50M GMV, Rebuy delivers most of the value at a fraction of the cost. For multi-platform retailers above $50M GMV, Nosto''s breadth and unified data layer justify the investment.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rebuy-vs-nosto');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'rebuy-vs-nosto', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Pricing for Mid-Market',     5, 2, 'Rebuy at $99-$600/mo accessible; Nosto enterprise pricing only'),
  ('Platform Coverage',          1, 5, 'Rebuy is Shopify-only; Nosto covers Shopify Plus, BigCommerce, Magento, SFCC'),
  ('Shopify Plus Cart Drawer',   5, 3, 'Rebuy''s cart drawer is the killer Shopify Plus feature'),
  ('Email Personalization',      3, 5, 'Nosto includes email send-time and content personalization'),
  ('Ad Audience Building',       1, 5, 'Nosto exports lookalike audiences; Rebuy does not'),
  ('Setup Time',                 5, 3, 'Rebuy goes live in days; Nosto takes weeks'),
  ('Best Fit Store Size',        5, 3, 'Rebuy excels at $5M-$50M Shopify Plus; Nosto at $50M+ multi-platform')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rebuy-vs-nosto')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'rebuy-vs-nosto');

-- 5. lily-ai-vs-syte (catalog enrichment vs visual search)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'lily-ai-vs-syte',
  'lily-ai',
  'syte',
  'Lily AI and Syte are both visual and product-attribute AI platforms for ecommerce, but they solve different problems. Lily AI enriches product catalogs with consumer-language attributes - tags like "boho", "weekend", "petite-friendly" that customers actually use to search and shop, but that retail merchandisers rarely have time to add manually. The enriched data flows into search, recommendations, and ad targeting, lifting relevance across systems. Syte specializes in visual AI: image search where customers upload a photo and find similar products, "shop the look" features, and visual merchandising that groups items by aesthetic similarity. Lily improves text-side relevance via attribute enrichment. Syte improves image-side discovery. Large fashion retailers often use both - they are complementary, not competitive.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lily-ai-vs-syte');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'lily-ai-vs-syte', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Catalog Attribute Enrichment', 5, 1, 'Lily''s entire purpose; Syte does not enrich attributes'),
  ('Visual Search',                1, 5, 'Syte is best-in-class visual search; Lily does not offer it'),
  ('Shop-the-Look Features',       1, 5, 'Syte''s editorial integration is purpose-built'),
  ('Search Relevance Lift',        5, 3, 'Lily''s attribute data improves all search systems'),
  ('Ad Targeting Lift',            5, 2, 'Lily''s consumer-language attributes feed ad audience targeting'),
  ('Best Fit Categories',          4, 5, 'Lily fits most categories; Syte best for fashion, jewelry, home decor'),
  ('Pricing',                      2, 2, 'Both enterprise-tier; Lily slightly higher for large catalogs')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lily-ai-vs-syte')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lily-ai-vs-syte');
