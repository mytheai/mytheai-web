-- fix-make-duplicate.sql
-- Removes the duplicate 'make' tool and its comparison page.
-- 'make-com' (tools-batch-51, full data) is the canonical entry.
-- 'make' (bulk-tools-insert, minimal data) is the old duplicate.
-- Run in Supabase SQL Editor.

-- Step 1: Remove criteria for zapier-vs-make
DELETE FROM comparison_criteria
WHERE comparison_slug = 'zapier-vs-make';

-- Step 2: Remove the zapier-vs-make comparison
-- zapier-vs-make-com already exists as the correct replacement
DELETE FROM comparisons
WHERE slug = 'zapier-vs-make';

-- Step 3: Remove the old 'make' tool record
DELETE FROM tools
WHERE slug = 'make';

-- Verify (should return 0 rows each)
SELECT slug FROM tools WHERE slug = 'make';
SELECT slug FROM comparisons WHERE slug = 'zapier-vs-make';
