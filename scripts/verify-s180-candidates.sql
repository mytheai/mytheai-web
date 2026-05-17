-- S180 Block A: verify 5 batch-30 candidates still OPEN for hands-on UPDATE
SELECT slug, name, rating, review_count, hands_on_notes IS NOT NULL AS has_hands_on
FROM tools
WHERE slug IN ('character-ai', 'edpuzzle-ai', 'onetrust', 'coupa', 'pika')
ORDER BY slug;
