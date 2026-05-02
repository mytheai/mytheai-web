-- session77-flags.sql
-- trending/featured flags for tools-batch-63 (AI Hospitality / Travel Tech)

-- Trending: top 3 hospitality platform leaders gaining strong traction in 2026
UPDATE tools SET trending = true  WHERE slug IN ('mews', 'cloudbeds', 'guesty');
UPDATE tools SET trending = false WHERE slug IN ('duetto', 'revinate', 'navan', 'canary-technologies', 'siteminder', 'atomize', 'hopper');

-- Featured: mews (modern hotel PMS leader) and navan (business travel platform)
UPDATE tools SET featured = true  WHERE slug IN ('mews', 'navan');
UPDATE tools SET featured = false WHERE slug IN ('cloudbeds', 'guesty', 'duetto', 'revinate', 'canary-technologies', 'siteminder', 'atomize', 'hopper');

-- Editor's Picks: NO CHANGE (cursor, notebooklm, lovable unchanged)

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'mews', 'cloudbeds', 'guesty', 'duetto', 'revinate',
  'navan', 'canary-technologies', 'siteminder', 'atomize', 'hopper'
)
ORDER BY slug;
