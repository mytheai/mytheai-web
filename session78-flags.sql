-- session78-flags.sql
-- trending/featured flags for tools-batch-64 (AI Supply Chain / Logistics)

-- Trending: top 3 supply chain leaders with strong 2026 market momentum
UPDATE tools SET trending = true  WHERE slug IN ('project44', 'flexport', 'blue-yonder');
UPDATE tools SET trending = false WHERE slug IN ('transfix', 'stord', 'shippo', 'easypost', 'o9-solutions', 'kinaxis', 'manhattan-associates');

-- Featured: project44 (real-time visibility leader) and flexport (digital freight forwarder)
UPDATE tools SET featured = true  WHERE slug IN ('project44', 'flexport');
UPDATE tools SET featured = false WHERE slug IN ('transfix', 'stord', 'shippo', 'easypost', 'o9-solutions', 'kinaxis', 'blue-yonder', 'manhattan-associates');

-- Editor's Picks: NO CHANGE (cursor, notebooklm, lovable unchanged)

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'project44', 'flexport', 'transfix', 'stord', 'shippo',
  'easypost', 'o9-solutions', 'kinaxis', 'blue-yonder', 'manhattan-associates'
)
ORDER BY slug;
