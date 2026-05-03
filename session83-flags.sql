-- session83-flags.sql
-- trending/featured flags for tools-batch-69 (AI Procurement / Spend Management)

-- Trending: coupa (market leader in BSM with strong enterprise momentum),
--           zip-procurement (fastest-growing intake-to-procure startup, Airbnb/Snowflake customers),
--           pactum (autonomous negotiation AI - unique category with Walmart validation and media coverage)
UPDATE tools SET trending = true  WHERE slug IN ('coupa', 'zip-procurement', 'pactum');
UPDATE tools SET trending = false WHERE slug IN ('jaggaer', 'ivalua', 'sievo', 'keelvar', 'spendesk', 'precoro', 'procurify');

-- Featured: coupa (category leader by market share and brand recognition),
--           zip-procurement (highest-growth modern procurement tool - strong for homepage discovery)
UPDATE tools SET featured = true  WHERE slug IN ('coupa', 'zip-procurement');
UPDATE tools SET featured = false WHERE slug IN ('jaggaer', 'ivalua', 'pactum', 'sievo', 'keelvar', 'spendesk', 'precoro', 'procurify');

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'coupa', 'jaggaer', 'ivalua', 'zip-procurement', 'pactum',
  'sievo', 'keelvar', 'spendesk', 'precoro', 'procurify'
)
ORDER BY slug;
