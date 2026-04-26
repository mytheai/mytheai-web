-- Fix stale "2025" year references in comparison data
-- Run in Supabase SQL Editor

-- Update comparison summaries
UPDATE comparisons
SET summary = REPLACE(summary, '2025', '2026')
WHERE summary LIKE '%2025%';

-- Update comparison criteria notes
UPDATE comparison_criteria
SET notes = REPLACE(notes, '2025', '2026')
WHERE notes LIKE '%2025%';

-- Verify results
SELECT slug, summary FROM comparisons WHERE summary LIKE '%2025%';
SELECT cc.notes FROM comparison_criteria cc WHERE cc.notes LIKE '%2025%';
