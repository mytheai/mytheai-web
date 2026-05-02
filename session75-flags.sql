-- session75-flags.sql
-- trending/featured flags for tools-batch-61 (AI HR / People Ops)

-- Trending: top 3 brands with strongest 2026 market momentum
UPDATE tools SET trending = true  WHERE slug IN ('lattice', 'culture-amp', '15five');
UPDATE tools SET trending = false WHERE slug IN ('leapsome', 'gusto', 'hibob', 'paradox-ai', 'betterup', 'pyn', 'peakon');

-- Featured: top 2 brands by market recognition and product depth
UPDATE tools SET featured = true  WHERE slug IN ('lattice', 'culture-amp');
UPDATE tools SET featured = false WHERE slug IN ('15five', 'leapsome', 'gusto', 'hibob', 'paradox-ai', 'betterup', 'pyn', 'peakon');

-- Editor's Picks: NO CHANGE - cursor, notebooklm, lovable unchanged

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'lattice', 'culture-amp', '15five', 'leapsome', 'gusto',
  'hibob', 'paradox-ai', 'betterup', 'pyn', 'peakon'
)
ORDER BY slug;
