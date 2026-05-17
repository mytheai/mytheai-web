-- S176 Block A: verify the 4 S175 slugs are OPEN for hands_on_notes UPDATE
SELECT slug, name, rating, review_count, hands_on_notes IS NOT NULL AS has_hands_on, tested_by
FROM tools
WHERE slug IN ('calendly', 'customer-io', 'roam-research', 'scite')
ORDER BY slug;
