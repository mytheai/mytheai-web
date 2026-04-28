-- compare-batch-30.sql
-- 5 comparison pairs: AI image generation tools (theme matches batch-30)
-- All pairs use tools confirmed in DB
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: midjourney-vs-ideogram
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'midjourney-vs-ideogram',
  'midjourney',
  'ideogram',
  'Midjourney vs Ideogram is the clearest case of specialist vs generalist in AI image generation. Midjourney is the benchmark for pure aesthetic quality - the most visually impressive AI generator available for complex, artistic, and photorealistic images. Ideogram owns a use case that Midjourney handles poorly: text within images. Where Midjourney garbles words, Ideogram produces clean, styled typography as part of the image. For most creative work without text, choose Midjourney. For social graphics, posters, and any image with readable copy, choose Ideogram.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'midjourney-vs-ideogram', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Overall image quality', 5, 4, 'Midjourney V7 produces the highest aesthetic output available - better compositional intelligence, lighting, and detail than any competitor. Ideogram V2 is strong but does not match Midjourney at the quality ceiling.'),
  ('Text rendering in images', 1, 5, 'Ideogram''s defining capability: coherent, styled text within generated images. Midjourney consistently garbles text in generated images. This single criterion makes Ideogram the only viable choice for text-containing creatives.'),
  ('Style control and presets', 4, 5, 'Both offer strong style controls. Ideogram''s presets (Photo, Illustration, Anime, 3D Render) are well-calibrated and beginner-accessible. Midjourney''s --style and style reference parameters offer more depth for experienced users.'),
  ('Commercial IP safety', 2, 3, 'Neither offers clear commercial IP provenance. Midjourney has faced IP litigation. Ideogram has not published detailed training data disclosures. Neither matches Adobe Firefly for commercial IP clarity.'),
  ('Free tier availability', 1, 5, 'Ideogram has a functional free plan for evaluation. Midjourney has no free tier - it requires a $10/month subscription for access.'),
  ('Community and model updates', 5, 4, 'Midjourney releases frequent model updates with high community engagement. Ideogram V2 was a major quality leap; update cadence is slower than Midjourney.'),
  ('API access for developers', 3, 4, 'Ideogram has a cleaner public API for developer integration. Midjourney''s API is limited and not publicly available to all developers.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'midjourney-vs-ideogram')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'midjourney-vs-ideogram');

-- Pair 2: civitai-vs-getimg-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'civitai-vs-getimg-ai',
  'civitai',
  'getimg-ai',
  'Civitai vs GetImg.ai compares two platforms that both give you access to a wide range of Stable Diffusion community models - but with different focus areas. Civitai is primarily a model hub and community: the best place to discover, download, and use specialty fine-tuned models in the browser. GetImg.ai is primarily a generation platform: an all-in-one tool for generating images using multiple models (including FLUX and SDXL) with advanced controls like ControlNet and DreamBooth training. Choose Civitai when you need access to a specific community model or style fine-tune. Choose GetImg.ai when you need a more complete generation workflow with multi-model support and API access.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'civitai-vs-getimg-ai', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Community model library', 5, 3, 'Civitai hosts thousands of community-contributed fine-tuned models, LoRAs, and VAEs - the largest such library available. GetImg.ai offers 60+ models which is substantial but does not approach Civitai''s community depth.'),
  ('Generation workflow completeness', 2, 5, 'GetImg.ai provides a complete generation workflow including text-to-image, image-to-image, inpainting, outpainting, and video generation. Civitai''s generation interface is functional but secondary to its model hosting purpose.'),
  ('Advanced controls (ControlNet, DreamBooth)', 2, 5, 'GetImg.ai supports ControlNet for composition control and DreamBooth for custom model training. Civitai offers basic generation controls without these advanced features.'),
  ('API access for production workflows', 1, 5, 'GetImg.ai provides a clean API for embedding generation into production systems. Civitai does not offer a developer API for programmatic generation at scale.'),
  ('Model discovery and community ratings', 5, 2, 'Civitai''s community ratings, sample images, and trigger word documentation make model selection far easier. GetImg.ai lists models but without equivalent community curation.'),
  ('FLUX model support', 2, 5, 'GetImg.ai integrates FLUX.1 Pro and Dev models alongside SDXL. Civitai hosts FLUX LoRAs but the in-browser generation for FLUX is less developed.'),
  ('Content moderation', 2, 4, 'Civitai has faced persistent content moderation challenges given the open community model. GetImg.ai applies stricter content policies on its platform.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'civitai-vs-getimg-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'civitai-vs-getimg-ai');

-- Pair 3: clipdrop-vs-remove-bg
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'clipdrop-vs-remove-bg',
  'clipdrop',
  'remove-bg',
  'Clipdrop vs Remove.bg is the head-to-head comparison for AI-powered background removal tools - but the comparison extends beyond a single feature. Remove.bg is the specialist: it does one thing (background removal) with extreme reliability and a well-established API. Clipdrop is the suite: background removal is one of several AI image editing tools including upscaling, background replacement, and Stable Diffusion generation. If you only need background removal and want the most reliable, API-connected option, Remove.bg wins. If you want a broader image editing toolkit with background removal as one capability among many, Clipdrop is the better value.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clipdrop-vs-remove-bg', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Background removal accuracy', 4, 5, 'Remove.bg is the gold standard for background removal accuracy, particularly on complex edges like hair and translucent materials. Clipdrop''s background removal is strong but slightly behind Remove.bg on the hardest edge cases.'),
  ('Breadth of image editing tools', 5, 1, 'Clipdrop includes upscaling, background replacement, uncropping, sketch-to-image, and Stable Diffusion generation alongside background removal. Remove.bg does background removal only.'),
  ('API reliability and documentation', 3, 5, 'Remove.bg''s API is among the most used and best-documented image processing APIs available - extremely reliable for production use. Clipdrop''s API is functional but less established.'),
  ('Figma integration', 5, 3, 'Clipdrop''s Figma plugin enables background removal without leaving the design tool. Remove.bg also has a Figma plugin but Clipdrop''s broader editing integration is more useful.'),
  ('Batch processing', 4, 5, 'Remove.bg''s bulk processing is well-optimised for high-volume e-commerce workflows. Clipdrop''s batch processing is available but less mature for large-scale operations.'),
  ('Free tier usage limits', 3, 4, 'Both have free tiers. Remove.bg offers 50 free previews/month at reduced resolution. Clipdrop''s free tier covers multiple tools but limits daily usage on each.'),
  ('Image generation capabilities', 5, 1, 'Clipdrop includes Stable Diffusion-powered image generation and background replacement with AI-generated scenes. Remove.bg has no image generation features.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'clipdrop-vs-remove-bg')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clipdrop-vs-remove-bg');

-- Pair 4: playground-ai-vs-nightcafe
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'playground-ai-vs-nightcafe',
  'playground-ai',
  'nightcafe',
  'Playground AI vs NightCafe compares two accessible AI image generation platforms with different approaches to the creative workflow. Playground AI is canvas-based and creation-focused: it integrates generation with a design canvas for hybrid compositions, offers 500 free images per day, and targets creators who want AI generation within a design workflow. NightCafe is community-based and exploration-focused: it offers multiple generation algorithms, an active social gallery, and daily free credits that make it accessible for casual exploration and AI art participation. Both serve artists and creators, but Playground suits those who want to build and compose while NightCafe suits those who want to explore and share.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'playground-ai-vs-nightcafe', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Free generation allowance', 5, 4, 'Playground AI offers 500 free images per day - among the most generous free tiers in AI image generation. NightCafe provides daily free credits that reset, but the total free generation volume is lower.'),
  ('Canvas-based design workflow', 5, 1, 'Playground AI''s canvas interface lets you generate, edit, and compose in the same environment. NightCafe is purely a generation tool without a canvas or design layer.'),
  ('Model variety and algorithm choice', 3, 5, 'NightCafe supports DALL-E, Stable Diffusion, and proprietary CLIP-guided models. Playground AI focuses primarily on Stable Diffusion variants.'),
  ('Community and social features', 2, 5, 'NightCafe has one of the most active AI art communities with challenges, galleries, and collaborative features. Playground AI has a community gallery but the social dimension is secondary.'),
  ('Outpainting and image expansion', 5, 2, 'Playground AI''s canvas enables outpainting and image expansion natively. NightCafe does not have equivalent canvas-based editing capabilities.'),
  ('Hybrid image editing (AI + upload)', 5, 1, 'Playground AI allows mixing uploaded images with AI-generated elements on the same canvas. NightCafe is generation-only without hybrid composition features.'),
  ('Prompt learning and discovery', 3, 5, 'NightCafe''s community gallery and prompt sharing accelerate prompt learning. Playground AI''s community is smaller and less focused on prompt education.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'playground-ai-vs-nightcafe')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'playground-ai-vs-nightcafe');

-- Pair 5: fotor-vs-canva-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'fotor-vs-canva-ai',
  'fotor',
  'canva-ai',
  'Fotor vs Canva AI compares two platforms that cover the photo editing and graphic design overlap but come from opposite starting points. Fotor started as a photo editor and added design and AI features. Canva started as a graphic design tool and added photo editing and AI features. Today both do both - but Fotor is stronger at photo editing and retouching while Canva is stronger at graphic design, templates, and collaboration. For individual creators primarily editing photos, Fotor is better value. For teams creating marketing materials, presentations, and social graphics, Canva is the clear choice.',
  'canva-ai',
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'fotor-vs-canva-ai', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Photo editing and retouching', 5, 3, 'Fotor''s photo editing tools are more mature - better HDR, colour grading, portrait retouching, and raw file processing. Canva''s photo editing covers the basics but does not match Fotor for photographic quality control.'),
  ('Graphic design templates', 3, 5, 'Canva has an unmatched template library across every format and use case, with better design quality and more variety. Fotor has templates but Canva is the benchmark in this dimension.'),
  ('Team collaboration features', 2, 5, 'Canva is built for team collaboration - real-time co-editing, brand kits, team libraries, and approval workflows. Fotor is primarily an individual tool with no meaningful team collaboration features.'),
  ('AI image generation quality', 3, 4, 'Canva''s Magic Media AI generation is competitive and tightly integrated into the design workflow. Fotor''s AI art generator is functional but less polished in output quality.'),
  ('Brand kit and consistency tools', 2, 5, 'Canva''s Brand Kit stores fonts, colours, and logos for consistent output across the team. Fotor has no equivalent brand consistency features.'),
  ('Pricing value for individuals', 4, 3, 'Fotor Pro is priced lower than Canva Pro for comparable individual use. Canva''s free tier is more generous, but Fotor offers better value on the paid tier for photo-focused individual use.'),
  ('Mobile app experience', 3, 5, 'Canva''s mobile app is among the best design tools available on mobile - full-featured and responsive. Fotor''s mobile app is solid but less comprehensive than the Canva mobile experience.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'fotor-vs-canva-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'fotor-vs-canva-ai');
