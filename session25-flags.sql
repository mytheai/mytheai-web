-- session25-flags.sql
-- Editor's Picks, Trending, and Featured flags refresh for Session 25
-- Run in Supabase SQL Editor

-- Reset all editor picks
UPDATE tools SET editor_pick = false WHERE editor_pick = true;

-- Set new Editor's Picks: cursor (code ai), notebooklm (research), lovable (app builder)
UPDATE tools SET editor_pick = true WHERE slug IN ('cursor', 'notebooklm', 'lovable');

-- Reset trending flags
UPDATE tools SET trending = false WHERE trending = true;

-- Set trending: mix of established tools and new batch-12/13 arrivals
UPDATE tools SET trending = true WHERE slug IN (
  'warp',
  'recraft-ai',
  'taskade',
  'castmagic',
  'magicschool-ai',
  'cursor',
  'lovable',
  'sora',
  'avoma',
  'notebooklm'
);

-- Set featured flag for new batch-12 tools
UPDATE tools SET featured = true WHERE slug IN (
  'warp',
  'recraft-ai',
  'avoma',
  'instantly-ai',
  'tana',
  'sora'
);

-- Verify
SELECT slug, name, editor_pick, trending, featured
FROM tools
WHERE editor_pick = true OR slug IN ('warp', 'recraft-ai', 'taskade', 'castmagic', 'notebooklm', 'sora')
ORDER BY editor_pick DESC, trending DESC, slug;
