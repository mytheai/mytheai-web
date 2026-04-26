-- Session 22 visibility flags: tools from batches 10 and 11
-- Run in Supabase SQL Editor

-- Editor picks: standout tools from recent batches
UPDATE tools SET editor_pick = true
WHERE slug IN ('supernormal', 'apollo', 'codeium', 'windsurf')
  AND editor_pick = false;

-- Trending: high-growth tools from batches 10 and 11
UPDATE tools SET trending = true
WHERE slug IN ('capcut', 'substack', 'coda', 'taplio', 'apollo', 'supernormal', 'codeium', 'clay')
  AND trending = false;

-- Featured: surface in homepage and curated sections
UPDATE tools SET featured = true
WHERE slug IN ('supernormal', 'apollo', 'codeium', 'capcut', 'substack', 'coda', 'windsurf')
  AND featured = false;

-- Verify
SELECT slug, editor_pick, trending, featured
FROM tools
WHERE slug IN ('supernormal', 'apollo', 'codeium', 'capcut', 'substack', 'coda', 'taplio', 'clay', 'windsurf')
ORDER BY slug;
