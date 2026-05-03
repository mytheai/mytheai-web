-- session81-flags.sql
-- trending/featured flags for tools-batch-67 (AI Climate / Sustainability)

-- Trending: watershed (category leader with strong enterprise momentum),
--           persefoni (financial-grade carbon accounting gaining traction with listed companies),
--           greenly (fastest-growing SMB carbon platform - viral via enterprise supply chain pressure)
UPDATE tools SET trending = true  WHERE slug IN ('watershed', 'persefoni', 'greenly');
UPDATE tools SET trending = false WHERE slug IN ('sweep', 'normative', 'plan-a', 'climatiq', 'ibm-envizi', 'emitwise', 'cogo');

-- Featured: watershed and persefoni (top 2 by enterprise market presence and search demand)
UPDATE tools SET featured = true  WHERE slug IN ('watershed', 'persefoni');
UPDATE tools SET featured = false WHERE slug IN ('sweep', 'normative', 'plan-a', 'climatiq', 'ibm-envizi', 'emitwise', 'greenly', 'cogo');

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'watershed', 'persefoni', 'sweep', 'normative', 'plan-a',
  'climatiq', 'ibm-envizi', 'emitwise', 'greenly', 'cogo'
)
ORDER BY slug;
