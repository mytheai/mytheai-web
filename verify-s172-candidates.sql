-- S172 batch 24 candidate verification
-- Primary picks (5 NEW verticals strategy): navan, hopper, lemonade, matterport, elicit
-- Plus check for research-AI peers (consensus, scite) and travel/insurance peers
SELECT
  slug,
  name,
  review_count,
  rating,
  CASE WHEN hands_on_notes IS NULL THEN 'OPEN' ELSE 'TESTED' END AS status
FROM tools
WHERE slug IN ('navan', 'hopper', 'lemonade', 'matterport', 'elicit', 'consensus', 'scite', 'scispace', 'humata', 'guesty', 'sprout-social', 'picsart', 'tabnine', 'adobe-premiere-pro', 'hootsuite')
ORDER BY review_count DESC NULLS LAST;
