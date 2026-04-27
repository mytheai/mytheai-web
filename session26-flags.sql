-- session26-flags.sql
-- Editor's Picks, Trending, and Featured flags refresh for Session 26
-- Run AFTER tools-batch-14.sql
-- Run in Supabase SQL Editor

-- Set featured flag for new batch-14 tools
UPDATE tools SET featured = true WHERE slug IN (
  'superhuman',
  'klap',
  'readwise',
  'groq'
);

-- Add trending tools from batch-14
UPDATE tools SET trending = true WHERE slug IN (
  'klap',
  'groq',
  'readwise',
  'remove-bg'
);

-- Keep existing Editor's Picks (cursor, notebooklm, lovable) - no change needed
-- Verify current state:
SELECT slug, name, editor_pick, trending, featured
FROM tools
WHERE editor_pick = true
   OR slug IN ('klap', 'groq', 'readwise', 'remove-bg', 'superhuman', 'cursor', 'notebooklm', 'lovable')
ORDER BY editor_pick DESC, trending DESC, slug;
