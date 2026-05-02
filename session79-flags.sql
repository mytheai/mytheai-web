-- session79-flags.sql
-- trending/featured flags for tools-batch-65 (AI Legal Tech)

-- Trending: top 3 legal tech tools gaining strong traction in 2026
-- paxton-ai (AI legal research for all firm sizes), everlaw (e-discovery AI), draftwise (drafting from precedents)
UPDATE tools SET trending = true  WHERE slug IN ('paxton-ai', 'everlaw', 'draftwise');
UPDATE tools SET trending = false WHERE slug IN ('relativity', 'kira-systems', 'lexion', 'brightflag', 'definely', 'smokeball', 'filevine');

-- Featured: paxton-ai (mid-market AI research leader) and everlaw (e-discovery innovation)
UPDATE tools SET featured = true  WHERE slug IN ('paxton-ai', 'everlaw');
UPDATE tools SET featured = false WHERE slug IN ('relativity', 'kira-systems', 'lexion', 'brightflag', 'draftwise', 'definely', 'smokeball', 'filevine');

-- Editor's Picks: NO CHANGE (cursor, notebooklm, lovable unchanged)

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'paxton-ai', 'everlaw', 'relativity', 'kira-systems', 'lexion',
  'brightflag', 'draftwise', 'definely', 'smokeball', 'filevine'
)
ORDER BY slug;
