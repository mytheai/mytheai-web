-- session84-flags.sql
-- trending/featured flags for tools-batch-70 (AI Biotech / Life Sciences)

-- Trending: insilico-medicine (Phase II clinical proof-of-concept - highest-profile AI drug discovery milestone),
--           recursion (petabyte-scale biology dataset + NVIDIA/Roche/Bayer partnerships - strong media momentum),
--           benevolentai (COVID-19 baricitinib discovery validated commercially - strong brand recognition in AI pharma)
UPDATE tools SET trending = true  WHERE slug IN ('insilico-medicine', 'recursion', 'benevolentai');
UPDATE tools SET trending = false WHERE slug IN ('schrodinger', 'atomwise', 'deep-genomics', 'exscientia', 'isomorphic-labs', 'valence-labs', 'generate-biomedicines');

-- Featured: insilico-medicine (category leader by clinical proof-of-concept milestone),
--           recursion (fastest-growing AI biology platform by data scale and partnership volume)
UPDATE tools SET featured = true  WHERE slug IN ('insilico-medicine', 'recursion');
UPDATE tools SET featured = false WHERE slug IN ('benevolentai', 'schrodinger', 'atomwise', 'deep-genomics', 'exscientia', 'isomorphic-labs', 'valence-labs', 'generate-biomedicines');

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'insilico-medicine', 'benevolentai', 'recursion', 'schrodinger', 'atomwise',
  'deep-genomics', 'exscientia', 'isomorphic-labs', 'valence-labs', 'generate-biomedicines'
)
ORDER BY slug;
