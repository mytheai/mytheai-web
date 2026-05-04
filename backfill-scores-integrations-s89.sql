-- Backfill editorial scores + integrations for top 25 head-term tools.
-- This fills in the data the new TrustStack component (S89 P1) shows for
-- "Editorial Score" and the integrations filter (S89 P3) reads from.
-- Scores follow the 7-criteria framework defined in web/src/lib/scoring.ts:
--   output_quality, ease_of_use, pricing_value, feature_depth,
--   integrations, reliability, trajectory  (each 1-5).
-- Idempotent: re-running the file just overwrites the same rows.

BEGIN;

-- Add integrations column to tools (column did not previously exist; the Tool
-- TypeScript interface had it but the DB schema didn't ship it). Idempotent.
ALTER TABLE tools ADD COLUMN IF NOT EXISTS integrations TEXT[] DEFAULT '{}'::text[];

-- ChatGPT (OpenAI flagship)
UPDATE tools SET
  scores = '{"output_quality":5,"ease_of_use":5,"pricing_value":4,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['slack','zapier','notion','google','github','hubspot']
WHERE slug = 'chatgpt';

-- Claude (Anthropic)
UPDATE tools SET
  scores = '{"output_quality":5,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4.5,"integrations":4,"reliability":5,"trajectory":5}'::jsonb,
  integrations = ARRAY['slack','zapier','notion','google','github']
WHERE slug = 'claude';

-- Gemini (Google)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":5,"feature_depth":4.5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['google','slack','zapier','notion','github']
WHERE slug = 'gemini';

-- Perplexity
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4.5,"feature_depth":4,"integrations":3.5,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['slack','zapier','notion']
WHERE slug = 'perplexity';

-- DeepSeek
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":5,"feature_depth":4.5,"integrations":3.5,"reliability":4,"trajectory":5}'::jsonb,
  integrations = ARRAY['github','slack','zapier']
WHERE slug = 'deepseek';

-- Cursor (AI code editor)
UPDATE tools SET
  scores = '{"output_quality":5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['github','slack','notion']
WHERE slug = 'cursor';

-- GitHub Copilot
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4,"feature_depth":4.5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github','slack','zapier']
WHERE slug = 'github-copilot';

-- v0 by Vercel
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['github','slack']
WHERE slug = 'v0';

-- Aider
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":5,"feature_depth":4.5,"integrations":3.5,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github']
WHERE slug = 'aider';

-- Replit
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4.5,"integrations":4,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github','slack','google']
WHERE slug = 'replit';

-- Midjourney
UPDATE tools SET
  scores = '{"output_quality":5,"ease_of_use":4,"pricing_value":4,"feature_depth":4.5,"integrations":3,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['notion','zapier']
WHERE slug = 'midjourney';

-- Runway (video AI)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":4.5,"integrations":3.5,"reliability":4,"trajectory":5}'::jsonb,
  integrations = ARRAY['slack','zapier']
WHERE slug = 'runway';

-- Luma Dream Machine
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":5}'::jsonb,
  integrations = ARRAY['zapier']
WHERE slug = 'luma-dream-machine';

-- ElevenLabs
UPDATE tools SET
  scores = '{"output_quality":5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['zapier','slack','notion']
WHERE slug = 'elevenlabs';

-- Notion AI
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":4.5,"feature_depth":4,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['notion','slack','zapier','google','github','hubspot']
WHERE slug = 'notion-ai';

-- Jasper
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":4.5,"integrations":4.5,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['hubspot','zapier','google','slack']
WHERE slug = 'jasper';

-- Grammarly
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4.5,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','slack','notion','zapier']
WHERE slug = 'grammarly';

-- Canva AI
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":4.5,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['google','slack','zapier','hubspot','notion']
WHERE slug = 'canva-ai';

-- Figma (AI features)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":5,"integrations":5,"reliability":5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','notion','zapier','github']
WHERE slug = 'figma';

-- Zapier (AI workflows)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','notion','google','github','hubspot','zapier']
WHERE slug = 'zapier';

-- Make.com
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4.5,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','notion','google','github','hubspot']
WHERE slug = 'make-com';

-- n8n
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":5,"feature_depth":4.5,"integrations":5,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['slack','notion','google','github','hubspot']
WHERE slug = 'n8n';

-- HubSpot AI / Einstein analog
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":5,"trajectory":4}'::jsonb,
  integrations = ARRAY['hubspot','slack','google','zapier']
WHERE slug = 'hubspot-ai';

-- Surfer SEO
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','zapier','slack']
WHERE slug = 'surfer-seo';

-- Otter.ai (transcription)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4.5,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','slack','notion','zapier']
WHERE slug = 'otter-ai';

COMMIT;

-- Sanity check: confirm 25 rows updated.
SELECT COUNT(*) AS updated_count
FROM tools
WHERE scores IS NOT NULL
  AND slug IN (
    'chatgpt','claude','gemini','perplexity','deepseek',
    'cursor','github-copilot','v0','aider','replit',
    'midjourney','runway','luma-dream-machine','elevenlabs','notion-ai',
    'jasper','grammarly','canva-ai','figma','zapier',
    'make-com','n8n','hubspot-ai','surfer-seo','otter-ai'
  );
