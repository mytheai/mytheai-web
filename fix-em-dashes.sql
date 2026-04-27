-- fix-em-dashes.sql - Replace all em dashes in Supabase data
-- Run once in Supabase SQL Editor
-- Replaces: — with: -

-- 1. Fix tools.description (scalar text)
UPDATE tools
SET description = REPLACE(description, '—', ' - ')
WHERE description LIKE '%—%';

-- 2. Fix tools.tagline (scalar text)
UPDATE tools
SET tagline = REPLACE(tagline, '—', ' - ')
WHERE tagline LIKE '%—%';

-- 3. Fix tools.pros (text array)
UPDATE tools
SET pros = (
  SELECT ARRAY_AGG(REPLACE(item, '—', ' - '))
  FROM UNNEST(pros) AS item
)
WHERE pros::text LIKE '%—%';

-- 4. Fix tools.cons (text array)
UPDATE tools
SET cons = (
  SELECT ARRAY_AGG(REPLACE(item, '—', ' - '))
  FROM UNNEST(cons) AS item
)
WHERE cons::text LIKE '%—%';

-- 5. Fix tools.use_cases (text array)
UPDATE tools
SET use_cases = (
  SELECT ARRAY_AGG(REPLACE(item, '—', ' - '))
  FROM UNNEST(use_cases) AS item
)
WHERE use_cases::text LIKE '%—%';

-- 6. Fix comparisons.summary
UPDATE comparisons
SET summary = REPLACE(summary, '—', ' - ')
WHERE summary LIKE '%—%';

-- 7. Fix comparison_criteria.notes
UPDATE comparison_criteria
SET notes = REPLACE(notes, '—', ' - ')
WHERE notes LIKE '%—%';

-- Verify: these should all return 0 rows after running
SELECT COUNT(*) AS tools_description_em_dashes FROM tools WHERE description LIKE '%—%';
SELECT COUNT(*) AS tools_tagline_em_dashes FROM tools WHERE tagline LIKE '%—%';
SELECT COUNT(*) AS tools_pros_em_dashes FROM tools WHERE pros::text LIKE '%—%';
SELECT COUNT(*) AS tools_cons_em_dashes FROM tools WHERE cons::text LIKE '%—%';
SELECT COUNT(*) AS tools_use_cases_em_dashes FROM tools WHERE use_cases::text LIKE '%—%';
SELECT COUNT(*) AS comparisons_summary_em_dashes FROM comparisons WHERE summary LIKE '%—%';
SELECT COUNT(*) AS criteria_notes_em_dashes FROM comparison_criteria WHERE notes LIKE '%—%';
