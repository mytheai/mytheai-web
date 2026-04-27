-- session24-flags.sql - Refresh Editor's Picks + Trending for Session 24
-- Run in Supabase SQL Editor
-- Idempotent: uses WHERE guards

-- Step 1: Clear all existing editor_pick flags
UPDATE tools SET editor_pick = false WHERE editor_pick = true;

-- Step 2: Set 3 new Editor's Picks
-- Recommended: cursor (best code AI), notebooklm (best research), lovable (best app builder)
UPDATE tools SET editor_pick = true WHERE slug IN ('cursor', 'notebooklm', 'lovable');

-- Step 3: Add new trending tools from batches 12+13
-- Add tools that are gaining momentum in 2026
UPDATE tools
SET trending = true
WHERE slug IN (
  'taskade',
  'castmagic',
  'magicschool-ai',
  'sora',
  'instantly-ai',
  'recraft-ai',
  'hedra',
  'warp',
  'avoma'
)
AND trending = false;

-- Step 4: Add featured flags for new breakout tools
UPDATE tools
SET featured = true
WHERE slug IN (
  'taskade',
  'castmagic',
  'magicschool-ai',
  'sora',
  'recraft-ai',
  'warp',
  'reflect',
  'sudowrite'
)
AND featured = false;

-- Verify results
SELECT slug, editor_pick, trending, featured
FROM tools
WHERE editor_pick = true OR slug IN ('taskade', 'castmagic', 'magicschool-ai', 'sora', 'warp', 'reflect', 'cursor', 'notebooklm', 'lovable')
ORDER BY editor_pick DESC, slug;
