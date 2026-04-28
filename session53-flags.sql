-- session53-flags.sql
-- Trending and featured flags for tools-batch-40 (specialized AI writing tools)
-- Run AFTER tools-batch-40.sql is confirmed in DB

-- Set trending for all 10 batch-40 tools
UPDATE tools SET trending = true WHERE slug IN (
  'sudowrite',
  'hypotenuse-ai',
  'wordtune',
  'simplified',
  'narrato',
  'longshot-ai',
  'reword',
  'cohesive-ai',
  'writerly-ai',
  'rapidely'
);

-- Set featured for standout batch-40 tools
UPDATE tools SET featured = true WHERE slug IN (
  'sudowrite',
  'hypotenuse-ai',
  'wordtune',
  'reword',
  'narrato'
);
