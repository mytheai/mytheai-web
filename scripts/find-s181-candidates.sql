-- S181 Block A: fresh DB query for batch 31 candidates
-- S177 pool exhausted (all 20 top-20 OPEN hand-tested via S177-S180)
-- Pull next tier of strongest OPEN candidates by review_count
SELECT slug, name, rating, review_count, tags
FROM tools
WHERE hands_on_notes IS NULL
  AND review_count >= 500
ORDER BY review_count DESC
LIMIT 20;
