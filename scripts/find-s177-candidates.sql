-- S177 Block A2: fresh DB query for top OPEN tools by review_count (hands_on_notes NULL)
SELECT slug, name, rating, review_count, tags
FROM tools
WHERE hands_on_notes IS NULL
  AND review_count >= 500
ORDER BY review_count DESC
LIMIT 20;
