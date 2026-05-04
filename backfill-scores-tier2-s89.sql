-- S89 tier 2 backfill: scores + integrations for next 25 head-term tools
-- (after the first 25 in backfill-scores-integrations-s89.sql).
-- All slugs verified in DB before running.
-- Idempotent: re-run safely.

BEGIN;

-- Qwen (Alibaba flagship LLM)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":5,"feature_depth":4,"integrations":3.5,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github']
WHERE slug = 'qwen';

-- Manus (autonomous agent)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4,"feature_depth":4.5,"integrations":3.5,"reliability":3.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['slack','github']
WHERE slug = 'manus';

-- Genspark (search agent)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['google']
WHERE slug = 'genspark';

-- Glif (workflow / AI building blocks)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4.5,"feature_depth":4,"integrations":4,"reliability":4,"trajectory":4}'::jsonb,
  integrations = ARRAY['zapier']
WHERE slug = 'glif';

-- CrewAI (multi-agent framework)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":5,"feature_depth":4.5,"integrations":4,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github','slack']
WHERE slug = 'crewai';

-- Langflow (LangChain visual builder)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":5,"feature_depth":4.5,"integrations":4.5,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github','slack']
WHERE slug = 'langflow';

-- Windsurf (Codeium IDE)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":5}'::jsonb,
  integrations = ARRAY['github','slack']
WHERE slug = 'windsurf';

-- Codeium (autocomplete)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":5,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['github','slack']
WHERE slug = 'codeium';

-- Tabnine (privacy-focused autocomplete)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['github']
WHERE slug = 'tabnine';

-- DALL-E (OpenAI image)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['zapier']
WHERE slug = 'dall-e';

-- Stable Diffusion (open-source image)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":3,"pricing_value":5,"feature_depth":5,"integrations":4,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['github']
WHERE slug = 'stable-diffusion';

-- Flux (Black Forest Labs)
UPDATE tools SET
  scores = '{"output_quality":5,"ease_of_use":4,"pricing_value":4.5,"feature_depth":4,"integrations":3.5,"reliability":4,"trajectory":5}'::jsonb,
  integrations = ARRAY['github']
WHERE slug = 'flux';

-- Ideogram
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['zapier']
WHERE slug = 'ideogram';

-- Adobe Firefly
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":4.5,"integrations":5,"reliability":5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','slack']
WHERE slug = 'adobe-firefly';

-- Krea AI
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY[]::text[]
WHERE slug = 'krea-ai';

-- Pika (video gen)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":3,"reliability":3.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY[]::text[]
WHERE slug = 'pika';

-- Sora (OpenAI video)
UPDATE tools SET
  scores = '{"output_quality":5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":3.5,"reliability":4,"trajectory":5}'::jsonb,
  integrations = ARRAY['zapier']
WHERE slug = 'sora';

-- HeyGen (avatar video)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['zapier','slack']
WHERE slug = 'heygen';

-- Synthesia (avatar video)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb,
  integrations = ARRAY['zapier','slack','google']
WHERE slug = 'synthesia';

-- Descript (audio + video editor)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4.5,"integrations":4,"reliability":4,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','zapier']
WHERE slug = 'descript';

-- Suno (music gen)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4,"feature_depth":4,"integrations":3,"reliability":4,"trajectory":5}'::jsonb,
  integrations = ARRAY[]::text[]
WHERE slug = 'suno';

-- Semrush (SEO platform)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3,"feature_depth":5,"integrations":5,"reliability":5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','slack','hubspot','zapier']
WHERE slug = 'semrush';

-- Ahrefs (SEO platform)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3,"feature_depth":5,"integrations":4.5,"reliability":5,"trajectory":4}'::jsonb,
  integrations = ARRAY['google','slack','zapier']
WHERE slug = 'ahrefs';

-- Frase (SEO content)
UPDATE tools SET
  scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":4,"reliability":4,"trajectory":3.5}'::jsonb,
  integrations = ARRAY['google','zapier']
WHERE slug = 'frase';

-- Linear (project mgmt with AI)
UPDATE tools SET
  scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4.5,"feature_depth":4.5,"integrations":5,"reliability":5,"trajectory":4.5}'::jsonb,
  integrations = ARRAY['slack','github','zapier','notion']
WHERE slug = 'linear';

COMMIT;

SELECT COUNT(*) AS updated_count FROM tools
WHERE scores IS NOT NULL
  AND slug IN (
    'qwen','manus','genspark','glif','crewai','langflow',
    'windsurf','codeium','tabnine','dall-e','stable-diffusion',
    'flux','ideogram','adobe-firefly','krea-ai','pika','sora',
    'heygen','synthesia','descript','suno','semrush','ahrefs',
    'frase','linear'
  );
