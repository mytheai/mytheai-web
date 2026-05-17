-- S178 Block A: verify 5 batch-28 candidates still OPEN for hands-on UPDATE
SELECT slug, name, rating, review_count, hands_on_notes IS NOT NULL AS has_hands_on
FROM tools
WHERE slug IN ('lattice', 'culture-amp', 'outreach', 'adobe-photoshop', 'everlaw')
ORDER BY slug;
