-- session86-flags.sql
-- trending/featured flags for tools-batch-72 (AI AgriTech / Food Tech)

-- Trending: climate-corp (dominant digital ag platform by acreage, Bayer backing drives adoption),
--           john-deere-ai (See & Spray is the most commercially visible precision ag AI product in 2026),
--           farmers-business-network (50,000+ member farms, strong momentum in input cost transparency and carbon programs)
UPDATE tools SET trending = true  WHERE slug IN ('climate-corp', 'john-deere-ai', 'farmers-business-network');
UPDATE tools SET trending = false WHERE slug IN ('indigo-agriculture', 'granular', 'taranis', 'awhere', 'prospera', 'blue-river-technology', 'agworld');

-- Featured: climate-corp (category leader by deployed acreage and brand recognition in digital ag),
--           john-deere-ai (highest consumer recognition of any agritech AI - See & Spray is widely covered)
UPDATE tools SET featured = true  WHERE slug IN ('climate-corp', 'john-deere-ai');
UPDATE tools SET featured = false WHERE slug IN ('indigo-agriculture', 'granular', 'taranis', 'awhere', 'prospera', 'farmers-business-network', 'blue-river-technology', 'agworld');

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'climate-corp', 'john-deere-ai', 'indigo-agriculture', 'granular', 'taranis',
  'awhere', 'prospera', 'farmers-business-network', 'blue-river-technology', 'agworld'
)
ORDER BY slug;
