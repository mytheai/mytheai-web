-- session33-flags.sql
-- Visibility flags for tools from batch-20
-- Run AFTER tools-batch-20.sql is confirmed in DB
-- Guards: only updates where flag is currently false (idempotent)

-- Trending: new and noteworthy tools from batch-20
UPDATE tools SET trending = true
WHERE slug IN ('castmagic', 'humanize-ai', 'descript', 'riverside', 'podcastle', 'frase', 'writesonic', 'rytr', 'beautiful-ai', 'soundraw')
AND trending = false;

-- Featured: high-quality tools that deserve homepage visibility
UPDATE tools SET featured = true
WHERE slug IN ('descript', 'riverside', 'castmagic', 'frase', 'writesonic')
AND featured = false;

-- Editor's Pick: keep cursor, notebooklm, lovable - no change needed
-- Uncomment below only if rotating picks:
-- UPDATE tools SET editor_pick = false WHERE slug IN ('cursor', 'notebooklm', 'lovable');
-- UPDATE tools SET editor_pick = true WHERE slug IN ('descript', 'riverside', 'frase');

-- Verify: show current counts
SELECT
  COUNT(*) FILTER (WHERE editor_pick = true) AS editor_picks,
  COUNT(*) FILTER (WHERE trending = true) AS trending_count,
  COUNT(*) FILTER (WHERE featured = true) AS featured_count,
  COUNT(*) AS total_tools
FROM tools;
