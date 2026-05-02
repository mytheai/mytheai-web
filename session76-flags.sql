-- session76-flags.sql
-- trending/featured flags for tools-batch-62 (AI Insurance / InsurTech)

-- Trending: top 3 batch-62 brands with highest consumer and B2B momentum in 2026
UPDATE tools SET trending = true  WHERE slug IN ('lemonade', 'tractable', 'coalition');
UPDATE tools SET trending = false WHERE slug IN ('shift-technology', 'planck', 'cape-analytics', 'zelros', 'snapsheet', 'socotra', 'next-insurance');

-- Featured: top 2 with strongest brand recognition and search volume
UPDATE tools SET featured = true  WHERE slug IN ('lemonade', 'tractable');
UPDATE tools SET featured = false WHERE slug IN (
  'shift-technology', 'planck', 'cape-analytics', 'zelros',
  'snapsheet', 'socotra', 'coalition', 'next-insurance'
);

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'lemonade', 'tractable', 'shift-technology', 'planck', 'cape-analytics',
  'zelros', 'snapsheet', 'socotra', 'coalition', 'next-insurance'
)
ORDER BY slug;
