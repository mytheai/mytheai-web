-- session82-flags.sql
-- trending/featured flags for tools-batch-68 (AI Government / Public Sector)

-- Trending: granicus (largest govtech platform, strong enterprise momentum),
--           opengov (fastest-growing cloud ERP for state/local government),
--           axon-ai (headline AI with Draft One police report generation - strong media coverage in 2026)
UPDATE tools SET trending = true  WHERE slug IN ('granicus', 'opengov', 'axon-ai');
UPDATE tools SET trending = false WHERE slug IN ('tyler-technologies', 'accela', 'zencity', 'polco', 'mark43', 'civicplus', 'balancing-act');

-- Featured: granicus and opengov (top 2 by market presence and search demand in govtech)
UPDATE tools SET featured = true  WHERE slug IN ('granicus', 'opengov');
UPDATE tools SET featured = false WHERE slug IN ('tyler-technologies', 'accela', 'zencity', 'polco', 'mark43', 'axon-ai', 'civicplus', 'balancing-act');

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'granicus', 'opengov', 'tyler-technologies', 'accela', 'zencity',
  'polco', 'mark43', 'axon-ai', 'civicplus', 'balancing-act'
)
ORDER BY slug;
