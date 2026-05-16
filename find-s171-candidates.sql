-- S171 batch 23 candidate discovery
-- Top 18 OPEN tools by review_count (above my current 5 picks threshold)
SELECT
  slug,
  name,
  review_count,
  rating
FROM tools
WHERE hands_on_notes IS NULL
  AND review_count >= 500
ORDER BY review_count DESC NULLS LAST
LIMIT 18;
