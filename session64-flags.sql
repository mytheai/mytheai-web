-- session64-flags.sql
-- trending + featured flags for tools-batch-50 (AI Translation & Localization tools)
-- Run AFTER tools-batch-50 confirmed in Supabase

-- Set trending for all 10 batch-50 tools
UPDATE tools SET trending = true WHERE slug IN (
  'phrase',
  'lokalise',
  'smartling',
  'crowdin',
  'transifex',
  'weglot',
  'lilt',
  'unbabel',
  'trados',
  'poeditor'
);

-- Set featured for top 5 batch-50 tools (most established localization platforms)
UPDATE tools SET featured = true WHERE slug IN (
  'phrase',
  'lokalise',
  'crowdin',
  'weglot',
  'transifex'
);
