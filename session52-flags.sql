-- session52-flags.sql
-- trending and featured flags for tools-batch-39 (recruitment/HR tech tools)
-- Run AFTER tools-batch-39.sql is confirmed in DB

UPDATE tools SET trending = true WHERE slug IN (
  'greenhouse',
  'lever',
  'ashby',
  'rippling',
  'bamboohr',
  'goodtime',
  'beamery',
  'eightfold',
  'seekout',
  'metaview'
);

UPDATE tools SET featured = true WHERE slug IN (
  'ashby',
  'rippling',
  'goodtime',
  'eightfold',
  'metaview'
);

-- Editor's Picks unchanged: cursor, notebooklm, lovable
