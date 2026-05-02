-- session80-flags.sql
-- trending/featured flags for tools-batch-66 (AI Manufacturing / Industry 4.0)

-- Trending: landing-ai (Andrew Ng vision AI momentum), augury (predictive maintenance leader),
--           c3-ai (enterprise AI platform - public company with strong 2026 traction)
UPDATE tools SET trending = true  WHERE slug IN ('landing-ai', 'augury', 'c3-ai');
UPDATE tools SET trending = false WHERE slug IN ('tulip', 'uptake', 'sight-machine', 'instrumental', 'cognex', 'relimetrics', 'elementary');

-- Featured: landing-ai and augury (top 2 by market momentum and search demand)
UPDATE tools SET featured = true  WHERE slug IN ('landing-ai', 'augury');
UPDATE tools SET featured = false WHERE slug IN ('tulip', 'uptake', 'sight-machine', 'c3-ai', 'instrumental', 'cognex', 'relimetrics', 'elementary');

-- Editor's Picks: NO CHANGE (cursor, notebooklm, lovable unchanged since Session 25)

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'tulip', 'uptake', 'augury', 'sight-machine', 'c3-ai',
  'instrumental', 'cognex', 'landing-ai', 'relimetrics', 'elementary'
)
ORDER BY slug;
