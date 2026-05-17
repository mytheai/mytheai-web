-- S181 Block A re-verify: 5 batch-31 candidates still OPEN for hands-on UPDATE
SELECT slug, name, rating, review_count, hands_on_notes IS NOT NULL AS has_hands_on
FROM tools
WHERE slug IN ('microsoft-teams', 'mistral', 'hotjar', 'substack', 'close')
ORDER BY slug;
