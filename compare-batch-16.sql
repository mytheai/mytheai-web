-- compare-batch-16.sql
-- 5 new comparison pairs using tools already in DB
-- ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)

-- 1. windsurf-vs-bolt: AI code editors head-to-head
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'windsurf-vs-bolt', 'windsurf', 'bolt',
  'Windsurf and Bolt both use agentic AI to write and run code, but they serve different workflows. Windsurf is a full IDE replacement for professional developers who want AI embedded into their existing codebase. Bolt is a browser-based app builder for non-engineers who want to go from idea to deployed web app in minutes without touching a terminal. The right choice depends on whether you already have a codebase and technical skills.',
  'windsurf', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'windsurf-vs-bolt');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('windsurf-vs-bolt', 'Ease of Use', 3, 5, 'Bolt is a browser app with no setup. Windsurf requires installing the IDE and configuring AI models.', 1),
  ('windsurf-vs-bolt', 'AI Code Quality', 5, 4, 'Windsurf uses Cascade for multi-file agentic edits with strong code quality. Bolt is optimized for speed over depth.', 2),
  ('windsurf-vs-bolt', 'Full-Stack Capability', 5, 3, 'Windsurf handles any project type including complex backends. Bolt excels at full-stack web apps but is limited in scope.', 3),
  ('windsurf-vs-bolt', 'Deployment Speed', 3, 5, 'Bolt deploys to Netlify in one click. Windsurf requires a separate deployment step.', 4),
  ('windsurf-vs-bolt', 'Existing Codebase Support', 5, 1, 'Windsurf reads your full repo and maintains context across files. Bolt starts from scratch each time.', 5),
  ('windsurf-vs-bolt', 'Price', 4, 3, 'Windsurf has a free tier with paid plans from $15/mo. Bolt free tier is limited; paid from $20/mo.', 6),
  ('windsurf-vs-bolt', 'Target User', 4, 5, 'Windsurf targets developers. Bolt targets founders and non-coders who want to ship fast without a developer.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'windsurf-vs-bolt')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'windsurf-vs-bolt');

-- 2. hailuo-vs-kling: AI video generation models
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'hailuo-vs-kling', 'hailuo', 'kling',
  'Hailuo (by MiniMax) and Kling (by Kuaishou) are the two strongest Chinese-developed video generation models competing with Runway and Pika. Both produce high-quality short clips from text or image prompts. Hailuo is known for realistic human motion and facial expressions. Kling has a longer track record and a more established API ecosystem. For video creators outside the US market, both represent genuine quality alternatives to Western tools.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hailuo-vs-kling');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('hailuo-vs-kling', 'Video Quality', 5, 5, 'Both produce high-quality output comparable to Runway Gen-3. Visual quality is the standout feature of both models.', 1),
  ('hailuo-vs-kling', 'Human Motion Realism', 5, 4, 'Hailuo is specifically strong at realistic human movement and facial expressions - a known weakness for most video models.', 2),
  ('hailuo-vs-kling', 'Prompt Adherence', 4, 5, 'Kling has slightly better consistency between prompt intent and visual output across diverse subjects.', 3),
  ('hailuo-vs-kling', 'Clip Duration', 4, 5, 'Kling supports up to 10 second clips. Hailuo generates 6 second clips in standard mode.', 4),
  ('hailuo-vs-kling', 'API & Integrations', 3, 5, 'Kling has a more established API with wider third-party platform integration. Hailuo access is more limited.', 5),
  ('hailuo-vs-kling', 'Pricing', 4, 4, 'Both use credit-based pricing at similar cost per clip. Neither has a generous free tier.', 6),
  ('hailuo-vs-kling', 'Availability', 3, 4, 'Kling has broader geographic access. Hailuo availability depends on the platform used to access MiniMax.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hailuo-vs-kling')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'hailuo-vs-kling');

-- 3. play-ht-vs-murf: TTS tools for creators and teams
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'play-ht-vs-murf', 'play-ht', 'murf',
  'Play.ht and Murf are both strong text-to-speech tools for creators and teams, but they serve different use cases. Play.ht focuses on API access, voice cloning, and high-volume generation with a massive voice library. Murf is an all-in-one studio with a visual editor, music tracks, and video sync - built for teams who want to produce complete voiceover videos without leaving the platform. Choose Play.ht for integrations and scale; choose Murf for a polished end-to-end editing workflow.',
  'murf', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'play-ht-vs-murf');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('play-ht-vs-murf', 'Voice Quality', 5, 4, 'Play.ht''s voice cloning and neural TTS edges out Murf on naturalness in head-to-head listening tests.', 1),
  ('play-ht-vs-murf', 'Voice Library Size', 5, 4, 'Play.ht has 900+ voices across 142 languages. Murf offers 120+ voices across 20+ languages.', 2),
  ('play-ht-vs-murf', 'Editor Experience', 3, 5, 'Murf''s Studio editor with video sync, music, and emphasis markers is far more polished than Play.ht''s basic editor.', 3),
  ('play-ht-vs-murf', 'API & Developer Access', 5, 2, 'Play.ht has a comprehensive REST API. Murf has limited API access, primarily designed for in-platform use.', 4),
  ('play-ht-vs-murf', 'Pricing', 3, 4, 'Murf starts at $19/mo with generous limits. Play.ht starts at $31/mo. Both have free tiers.', 5),
  ('play-ht-vs-murf', 'Team Collaboration', 3, 5, 'Murf has built-in team workspaces and project sharing. Play.ht is primarily single-user in its UX.', 6),
  ('play-ht-vs-murf', 'Voice Cloning', 5, 3, 'Play.ht''s voice cloning from 30 seconds of audio is fast and high quality. Murf''s clone quality is decent but requires more audio.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'play-ht-vs-murf')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'play-ht-vs-murf');

-- 4. stability-ai-vs-leonardo-ai: image generation platforms
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'stability-ai-vs-leonardo-ai', 'stability-ai', 'leonardo-ai',
  'Stability AI and Leonardo AI both offer Stable Diffusion-based image generation, but at different layers of the stack. Stability AI is primarily a research organization that releases model weights (SDXL, SD3) for others to run. Leonardo AI is a consumer and professional platform built on top of those models with additional fine-tuned models, training tools, and a polished UI. Most designers will prefer Leonardo''s workflow. Developers who want to run models locally or build custom tools will work with Stability AI''s model releases directly.',
  'leonardo-ai', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'stability-ai-vs-leonardo-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('stability-ai-vs-leonardo-ai', 'Ease of Use', 2, 5, 'Leonardo has a full-featured consumer UI. Stability AI requires technical setup to run models directly.', 1),
  ('stability-ai-vs-leonardo-ai', 'Image Quality', 5, 4, 'SD3 from Stability AI produces state-of-the-art quality. Leonardo''s fine-tuned models are excellent but vary by model selection.', 2),
  ('stability-ai-vs-leonardo-ai', 'Fine-Tuning and Custom Models', 4, 5, 'Leonardo has a built-in model training interface. Stability AI requires running training scripts externally.', 3),
  ('stability-ai-vs-leonardo-ai', 'Free Tier', 2, 5, 'Leonardo has a generous free tier with daily credits. Stability AI API requires payment from the start.', 4),
  ('stability-ai-vs-leonardo-ai', 'Commercial Use', 4, 4, 'Both allow commercial use of generated images. Specific terms vary by model and plan.', 5),
  ('stability-ai-vs-leonardo-ai', 'Developer API', 5, 4, 'Stability AI''s API gives direct model access. Leonardo''s API is available but less flexible for custom workflows.', 6),
  ('stability-ai-vs-leonardo-ai', 'Community and Templates', 2, 5, 'Leonardo has a large community sharing prompts and models. Stability AI is developer-oriented with less community tooling.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'stability-ai-vs-leonardo-ai')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'stability-ai-vs-leonardo-ai');

-- 5. voiceflow-vs-dify: AI agent builders
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'voiceflow-vs-dify', 'voiceflow', 'dify',
  'Voiceflow and Dify are both platforms for building AI agents without writing extensive code, but they target different builders. Voiceflow is designed for CX and product teams who want to build customer-facing chatbots and voice interfaces with a visual conversation designer. Dify is aimed at developers who want to orchestrate LLM workflows, build RAG applications, and deploy AI agents with full control over the underlying pipeline. Voiceflow wins on UX and CX features. Dify wins on technical flexibility and open-source deployment.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'voiceflow-vs-dify');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('voiceflow-vs-dify', 'No-Code Friendliness', 5, 3, 'Voiceflow''s visual canvas is designed for non-technical users. Dify requires understanding of AI concepts to configure well.', 1),
  ('voiceflow-vs-dify', 'Technical Flexibility', 3, 5, 'Dify supports custom model providers, RAG pipelines, and self-hosting. Voiceflow is more opinionated in its architecture.', 2),
  ('voiceflow-vs-dify', 'Conversation Design', 5, 2, 'Voiceflow has advanced conversation flow tools, branching, and response conditions built for CX. Dify focuses on workflow not conversation UX.', 3),
  ('voiceflow-vs-dify', 'Self-Hosting Option', 1, 5, 'Dify is open source and can be self-hosted. Voiceflow is cloud-only.', 4),
  ('voiceflow-vs-dify', 'Analytics and Monitoring', 5, 3, 'Voiceflow has strong conversation analytics, user session tracking, and A/B testing. Dify monitoring is more developer-focused.', 5),
  ('voiceflow-vs-dify', 'Pricing', 3, 5, 'Dify is open source with a free self-hosted option. Voiceflow free tier is limited; teams need paid plans from $50/mo.', 6),
  ('voiceflow-vs-dify', 'Multi-Channel Deployment', 5, 3, 'Voiceflow deploys to web chat, WhatsApp, Slack, and voice. Dify primarily outputs API endpoints that require separate integration.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'voiceflow-vs-dify')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'voiceflow-vs-dify');
