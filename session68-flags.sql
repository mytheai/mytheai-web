-- session68-flags.sql
-- trending/featured flags for tools-batch-54 (AI E-commerce Tools)

-- Trending: AI ecommerce tools with strong DTC momentum in 2026
UPDATE tools SET trending = true  WHERE slug IN ('shopify-magic', 'rep-ai', 'rebuy');
UPDATE tools SET trending = false WHERE slug IN ('octane-ai', 'recart', 'searchspring', 'nosto', 'lily-ai', 'syte', 'stamped-io');

-- Featured: none from this batch - Editor's Picks unchanged
UPDATE tools SET featured = false WHERE slug IN (
  'shopify-magic', 'octane-ai', 'rep-ai', 'recart', 'searchspring',
  'nosto', 'lily-ai', 'syte', 'rebuy', 'stamped-io'
);

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'shopify-magic', 'octane-ai', 'rep-ai', 'recart', 'searchspring',
  'nosto', 'lily-ai', 'syte', 'rebuy', 'stamped-io'
)
ORDER BY slug;
