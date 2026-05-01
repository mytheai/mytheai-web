-- session72-flags.sql
-- trending/featured flags for tools-batch-58 (AI Real Estate / Proptech)

UPDATE tools SET trending = true  WHERE slug IN ('compass', 'reonomy', 'matterport');
UPDATE tools SET trending = false WHERE slug IN ('cherre', 'leverton', 'rex-real-estate', 'rentlytics', 'reggora', 'skyline-ai', 'immoviewer');

UPDATE tools SET featured = true  WHERE slug IN ('compass', 'reonomy');
UPDATE tools SET featured = false WHERE slug IN (
  'cherre', 'leverton', 'rex-real-estate', 'rentlytics', 'reggora', 'skyline-ai', 'immoviewer', 'matterport'
);

SELECT slug, name, trending, featured FROM tools WHERE slug IN (
  'compass', 'reonomy', 'cherre', 'leverton', 'rex-real-estate',
  'rentlytics', 'reggora', 'matterport', 'skyline-ai', 'immoviewer'
) ORDER BY slug;
