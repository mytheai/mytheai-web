-- fix-tags.sql
-- Normalise inconsistent tag values in the tools table
-- Uses PostgreSQL array_replace() - safe to run multiple times (idempotent)
-- Run in Supabase SQL Editor

-- 1. Normalise ai-assistant -> ai-assistants (matches FilterBar + categories page)
UPDATE tools
SET tags = array_replace(tags, 'ai-assistant', 'ai-assistants')
WHERE 'ai-assistant' = ANY(tags);

-- 2. Normalise voice-ai -> voice-audio (matches mockCategories Voice & Audio slug)
UPDATE tools
SET tags = array_replace(tags, 'voice-ai', 'voice-audio')
WHERE 'voice-ai' = ANY(tags);

-- 3. Normalise seo -> seo-marketing (matches FilterBar + mockCategories)
UPDATE tools
SET tags = array_replace(tags, 'seo', 'seo-marketing')
WHERE 'seo' = ANY(tags);

-- 4. Normalise design-ai -> design (consolidate design tag)
UPDATE tools
SET tags = array_replace(tags, 'design-ai', 'design')
WHERE 'design-ai' = ANY(tags);

-- 5. Normalise research-ai -> research (consolidate research tag)
UPDATE tools
SET tags = array_replace(tags, 'research-ai', 'research')
WHERE 'research-ai' = ANY(tags);

-- Verify - check distinct tags after normalisation
SELECT DISTINCT unnest(tags) AS tag FROM tools ORDER BY 1;
