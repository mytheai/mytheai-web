-- session30-flags.sql
-- Visibility flags for tools from batches 16 and 17
-- Run AFTER tools-batch-16.sql AND tools-batch-17.sql are confirmed in DB
-- Guards: only updates where flag is currently false (idempotent)

-- Trending: new and noteworthy tools from batch-16 and batch-17
UPDATE tools SET trending = true
WHERE slug IN ('wordware', 'cline', 'veo', 'hailuo', 'flux', 'trae', 'firecrawl', 'voiceflow', 'scispace', 'bland-ai')
AND trending = false;

-- Featured: high-quality tools that deserve homepage visibility
UPDATE tools SET featured = true
WHERE slug IN ('wordware', 'cline', 'veo', 'hailuo', 'voiceflow', 'scispace')
AND featured = false;

-- Editor's Pick: keep cursor, notebooklm, lovable - no change needed
-- Uncomment below only if rotating picks:
-- UPDATE tools SET editor_pick = false WHERE slug IN ('cursor', 'notebooklm', 'lovable');
-- UPDATE tools SET editor_pick = true WHERE slug IN ('veo', 'cline', 'wordware');

-- Verify: show current counts
SELECT
  COUNT(*) FILTER (WHERE editor_pick = true) AS editor_picks,
  COUNT(*) FILTER (WHERE trending = true) AS trending_count,
  COUNT(*) FILTER (WHERE featured = true) AS featured_count,
  COUNT(*) AS total_tools
FROM tools;
