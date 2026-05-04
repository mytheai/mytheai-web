-- session85-flags.sql
-- trending/featured flags for tools-batch-71 (AI Aerospace / Defense)

-- Trending: palantir (dominant defense AI platform with AIP LLM layer - sustained media momentum in 2026),
--           anduril (fastest-growing autonomous defense systems company, IVAS and border deployments),
--           shield-ai (Nova AI pilot combat-deployed, Heron AlphaDogfight win keeps media profile high)
UPDATE tools SET trending = true  WHERE slug IN ('palantir', 'anduril', 'shield-ai');
UPDATE tools SET trending = false WHERE slug IN ('maxar', 'slingshot-aerospace', 'hawkeye-360', 'planet-labs', 'helsing', 'rebellion-defense', 'scale-ai-defense');

-- Featured: palantir (category leader by contract value, deployment scale, and brand recognition),
--           anduril (highest-growth autonomous defense platform - strong for homepage discovery)
UPDATE tools SET featured = true  WHERE slug IN ('palantir', 'anduril');
UPDATE tools SET featured = false WHERE slug IN ('shield-ai', 'maxar', 'slingshot-aerospace', 'hawkeye-360', 'planet-labs', 'helsing', 'rebellion-defense', 'scale-ai-defense');

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'palantir', 'anduril', 'shield-ai', 'maxar', 'slingshot-aerospace',
  'hawkeye-360', 'planet-labs', 'helsing', 'rebellion-defense', 'scale-ai-defense'
)
ORDER BY slug;
