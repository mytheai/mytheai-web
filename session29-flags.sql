-- session29-flags.sql
-- Trending + featured refresh for tools-batch-15 highlights
-- Editor's Picks unchanged (cursor, notebooklm, lovable)
-- Run in Supabase SQL Editor

-- Set trending = true for batch-15 highlights (only where currently false)
UPDATE tools SET trending = true
WHERE slug IN ('lmstudio', 'play-ht', 'stability-ai', 'kittl', 'humata')
  AND trending = false;

-- Set featured = true for batch-15 highlights (only where currently false)
UPDATE tools SET featured = true
WHERE slug IN ('humata', 'play-ht', 'lmstudio', 'wellsaid', 'kittl')
  AND featured = false;

-- Set trending for notable batch-16 tools if they exist in DB
UPDATE tools SET trending = true
WHERE slug IN ('cline', 'firecrawl', 'hailuo', 'flux', 'trae', 'wordware')
  AND trending = false;

UPDATE tools SET featured = true
WHERE slug IN ('cline', 'firecrawl', 'flux', 'hailuo')
  AND featured = false;

-- Verify Editor's Picks are still set correctly
UPDATE tools SET editor_pick = true
WHERE slug IN ('cursor', 'notebooklm', 'lovable')
  AND editor_pick = false;
