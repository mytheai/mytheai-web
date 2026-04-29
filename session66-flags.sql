-- session66-flags.sql
-- Trending and featured flags for tools-batch-52 (AI Social Media tools)
-- Run AFTER tools-batch-52 confirmed in Supabase

UPDATE tools SET trending = true  WHERE slug IN ('predis-ai', 'vista-social', 'taplio');
UPDATE tools SET featured = true  WHERE slug IN ('publer', 'contentstudio');
UPDATE tools SET trending = false WHERE slug IN ('publer', 'contentstudio', 'supergrow', 'postwise', 'hypefury', 'flick-social', 'pallyy');
