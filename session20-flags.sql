-- session20-flags.sql
-- Update featured / trending / editor_pick flags for new tools added in Sessions 18-19
-- Run AFTER tools-batch-7.sql has been run
-- Safe to re-run (UPDATE with explicit values)

-- editor_pick = true → appears in "Editor's Picks" section on homepage
UPDATE tools SET editor_pick = true WHERE slug IN (
  'notebooklm',   -- free, uniquely useful, Google quality
  'fathom',       -- best-in-class free meeting recorder
  'lovable',      -- breakout AI app builder
  'luma-ai',      -- top-tier video generation
  'windsurf'      -- strong Cursor alternative
);

-- trending = true → appears in "Trending This Week" on homepage
UPDATE tools SET trending = true WHERE slug IN (
  'lovable',      -- massive growth in 2025-2026
  'luma-ai',      -- Dream Machine widely adopted
  'grok',         -- xAI visibility surge
  'opus-clip',    -- viral creator tool
  'captions-ai',  -- growing fast among video creators
  'windsurf',     -- developer buzz
  'dify',         -- AI dev tools trending
  'beehiiv',      -- newsletter creator boom
  'tldv'          -- meeting AI popular segment
);

-- featured = true → boosts ranking in /tools directory default sort
UPDATE tools SET featured = true WHERE slug IN (
  'lovable',
  'luma-ai',
  'windsurf',
  'notebooklm',
  'fathom',
  'opus-clip',
  'dify'
);

-- Verify results
SELECT slug, featured, trending, editor_pick
FROM tools
WHERE featured = true OR trending = true OR editor_pick = true
ORDER BY slug;
