-- session70-flags.sql
-- trending/featured flags for tools-batch-56 (AI Healthcare Operations)

-- Trending: AI healthcare tools with breakout adoption in 2026
UPDATE tools SET trending = true  WHERE slug IN ('regard-clinical', 'viz-ai', 'heidi-health', 'freed-ai', 'hippocratic-ai', 'ambience-healthcare');
UPDATE tools SET trending = false WHERE slug IN ('paige-ai', 'atropos-health', 'deepscribe', 'tempus-ai');

-- Featured: none from this batch - Editor's Picks unchanged
UPDATE tools SET featured = false WHERE slug IN (
  'regard-clinical', 'viz-ai', 'paige-ai', 'atropos-health', 'heidi-health',
  'freed-ai', 'hippocratic-ai', 'deepscribe', 'ambience-healthcare', 'tempus-ai'
);

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'regard-clinical', 'viz-ai', 'paige-ai', 'atropos-health', 'heidi-health',
  'freed-ai', 'hippocratic-ai', 'deepscribe', 'ambience-healthcare', 'tempus-ai'
)
ORDER BY slug;
