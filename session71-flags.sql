-- session71-flags.sql
-- trending/featured flags for tools-batch-57 (AI Compliance / Legal Ops)

-- Trending: compliance automation is hot in 2026 - SOC 2 automation, contract intelligence, ESG
UPDATE tools SET trending = true  WHERE slug IN ('vanta', 'drata', 'evisort');
UPDATE tools SET trending = false WHERE slug IN ('secureframe', 'onetrust', 'bigid', 'securiti', 'linksquares', 'auditboard', 'sprinto');

-- Featured: vanta and onetrust are the most recognisable brands in their categories
UPDATE tools SET featured = true  WHERE slug IN ('vanta', 'onetrust');
UPDATE tools SET featured = false WHERE slug IN (
  'drata', 'secureframe', 'bigid', 'securiti', 'evisort', 'linksquares', 'auditboard', 'sprinto'
);

-- Verify
SELECT slug, name, trending, featured FROM tools WHERE slug IN (
  'vanta', 'drata', 'secureframe', 'onetrust', 'bigid', 'securiti',
  'evisort', 'linksquares', 'auditboard', 'sprinto'
) ORDER BY slug;
