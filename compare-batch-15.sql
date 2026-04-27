-- compare-batch-15.sql
-- 5 new comparison pairs using tools confirmed in DB
-- Tools used: chatpdf (batch-14), humata (batch-15), play-ht (batch-15),
--             elevenlabs (original), wellsaid (batch-15), murf (batch-4),
--             stability-ai (batch-15), midjourney (original),
--             kittl (batch-15), canva-ai (batch-2)
-- Pattern: ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)
-- Run in Supabase SQL Editor AFTER tools-batch-16.sql (or any time - no batch-16 deps)

-- 1. ChatPDF vs Humata
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'chatpdf-vs-humata', 'chatpdf', 'humata',
  'ChatPDF and Humata are both AI tools for chatting with PDF documents, but they serve different user needs. ChatPDF is faster to start - paste a PDF link and ask questions in under 30 seconds with no account required. Humata is more powerful for serious document work: it supports multi-document querying, provides more precise citations with page numbers, and handles longer and more complex documents more reliably. For a quick one-off question on a single PDF, ChatPDF wins on speed. For regular document-heavy workflows, Humata delivers more value.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatpdf-vs-humata');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('chatpdf-vs-humata', 'Ease of Entry', 5, 4, 'ChatPDF accepts a PDF URL with no account required - zero friction for a quick question. Humata requires account creation but setup is still under 2 minutes.', 1),
  ('chatpdf-vs-humata', 'Answer Accuracy', 3, 5, 'Humata provides more precise answers with exact page citations and is less likely to hallucinate outside document content. ChatPDF occasionally drifts beyond source material.', 2),
  ('chatpdf-vs-humata', 'Multi-Document Support', 1, 5, 'Humata can query across multiple uploaded documents simultaneously and synthesize answers from all sources. ChatPDF works on one document at a time only.', 3),
  ('chatpdf-vs-humata', 'Document Length Handling', 3, 5, 'Humata handles very long documents and technical papers more reliably. ChatPDF works well on shorter documents but can lose context in very long files.', 4),
  ('chatpdf-vs-humata', 'Citation Quality', 3, 5, 'Humata cites exact page numbers and quotes relevant passages in its answers. ChatPDF provides answers without always indicating which part of the document they came from.', 5),
  ('chatpdf-vs-humata', 'Speed for Single PDF', 5, 3, 'ChatPDF returns answers faster for a simple question on a single document with no setup required. Humata is slightly slower due to richer processing.', 6),
  ('chatpdf-vs-humata', 'Pricing', 3, 4, 'Both offer free tiers with limits. Humata''s paid plan at $9.99/mo covers more pages per month than ChatPDF''s Plus plan at $5/mo relative to power users'' needs.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatpdf-vs-humata')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'chatpdf-vs-humata');

-- 2. Play.ht vs ElevenLabs
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'play-ht-vs-elevenlabs', 'play-ht', 'elevenlabs',
  'Play.ht and ElevenLabs are the two leading AI text-to-speech platforms, and the right choice depends on your priorities. ElevenLabs produces slightly more natural-sounding voice output and has better emotional range, making it the preferred choice for content where quality is paramount. Play.ht offers a significantly larger voice library - over 900 voices vs ElevenLabs'' 300+ - and broader language coverage, which matters for multilingual projects. Both support voice cloning and API access. For maximum audio naturalness, choose ElevenLabs. For language diversity and voice variety, choose Play.ht.',
  'elevenlabs'
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'play-ht-vs-elevenlabs');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('play-ht-vs-elevenlabs', 'Voice Quality', 4, 5, 'ElevenLabs produces more natural-sounding output with better emotional expression and prosody. Play.ht quality is excellent but ElevenLabs has a slight edge in naturalness on most voice tests.', 1),
  ('play-ht-vs-elevenlabs', 'Voice Library Size', 5, 4, 'Play.ht offers 900+ voices across 142 languages. ElevenLabs has 300+ voices and 29 languages. Play.ht wins on breadth for multilingual and diverse accent requirements.', 2),
  ('play-ht-vs-elevenlabs', 'Voice Cloning', 4, 5, 'Both support voice cloning from audio samples. ElevenLabs requires only 1 minute of audio for a good clone and produces more stable results. Play.ht cloning is solid but requires slightly more source audio.', 3),
  ('play-ht-vs-elevenlabs', 'API Quality', 5, 5, 'Both offer well-documented, reliable APIs with low latency and streaming support. Comparable developer experience and reliability for production integration.', 4),
  ('play-ht-vs-elevenlabs', 'Language Coverage', 5, 4, 'Play.ht supports 142 languages including many less common ones. ElevenLabs covers 29 languages with strong quality across all supported. Play.ht wins on raw coverage.', 5),
  ('play-ht-vs-elevenlabs', 'Pricing', 3, 4, 'ElevenLabs starts at $5/mo (Creator plan), more accessible for light users. Play.ht starts at $31.20/mo which is a steeper entry point. ElevenLabs is better value at lower usage levels.', 6),
  ('play-ht-vs-elevenlabs', 'Ease of Use', 4, 5, 'Both have clean interfaces. ElevenLabs'' Speech Synthesis tool is slightly faster to use for quick text-to-speech generation without configuring advanced settings.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'play-ht-vs-elevenlabs')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'play-ht-vs-elevenlabs');

-- 3. WellSaid vs Murf
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'wellsaid-vs-murf', 'wellsaid', 'murf',
  'WellSaid Labs and Murf are both professional AI voice platforms, but they target different segments of the market. WellSaid is built for enterprise clients - L&D teams, corporate training producers, and brand content studios - with studio voices created in partnership with real voice actors and a collaborative team workflow. Murf is more accessible for individual creators and small teams, with a broader feature set including a built-in video editor at a lower starting price. For enterprise narration at scale, WellSaid is the stronger fit. For content creators and small teams, Murf offers more features per dollar.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'wellsaid-vs-murf');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('wellsaid-vs-murf', 'Voice Naturalness', 5, 4, 'WellSaid''s studio voices are created with real voice actors and optimized for professional narration - they sound more authoritative and consistent than Murf''s voices on long-form content.', 1),
  ('wellsaid-vs-murf', 'Voice Library Size', 3, 5, 'Murf offers 120+ voices across 20+ languages. WellSaid has a smaller but curated set of professional studio voices. Murf wins on variety.', 2),
  ('wellsaid-vs-murf', 'Built-in Video Editor', 1, 5, 'Murf includes a built-in video editor that syncs narration with visuals, images, and music - eliminating the need for a separate video tool. WellSaid focuses solely on voice generation.', 3),
  ('wellsaid-vs-murf', 'Team Collaboration', 5, 3, 'WellSaid is designed for collaborative team projects with shared scripts and multi-user workflows. Murf has collaboration features but they are less mature than WellSaid''s enterprise tooling.', 4),
  ('wellsaid-vs-murf', 'Enterprise Features', 5, 3, 'WellSaid offers SSO, custom voice creation, priority support, and SLAs suited to enterprise procurement. Murf''s enterprise offering is less developed.', 5),
  ('wellsaid-vs-murf', 'Ease of Entry', 2, 5, 'Murf has a clear free tier and starts at $19/mo - accessible for individual creators. WellSaid starts at $44/mo with no free tier, making it harder to evaluate before committing.', 6),
  ('wellsaid-vs-murf', 'Pricing', 2, 4, 'Murf is significantly more affordable at $19/mo vs WellSaid at $44/mo. For teams without enterprise budgets, Murf delivers strong value. WellSaid pricing reflects its enterprise positioning.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'wellsaid-vs-murf')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'wellsaid-vs-murf');

-- 4. Stability AI vs Midjourney
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'stability-ai-vs-midjourney', 'stability-ai', 'midjourney',
  'Stability AI and Midjourney represent two very different approaches to AI image generation. Midjourney is a closed, curated product optimized for artistic quality - it consistently produces beautiful images from simple prompts and has a strong community aesthetic. Stability AI is an open-weight model provider whose Stable Diffusion models power a large portion of the AI image ecosystem - including many third-party tools. For artists and designers who want the best out-of-the-box image quality with minimal setup, Midjourney is the clear choice. For developers building applications, researchers, or users who want full local control and customization, Stability AI is the more powerful option.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'stability-ai-vs-midjourney');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('stability-ai-vs-midjourney', 'Out-of-the-Box Image Quality', 3, 5, 'Midjourney produces consistently beautiful results from simple prompts with no technical knowledge. Stability AI models require more prompt engineering and configuration to reach comparable quality.', 1),
  ('stability-ai-vs-midjourney', 'Customizability', 5, 2, 'Stability AI open-weight models can be fine-tuned, merged, and deployed with full control. Midjourney is a closed system - you cannot fine-tune or modify the underlying model.', 2),
  ('stability-ai-vs-midjourney', 'Local Deployment', 5, 1, 'Stable Diffusion models can run entirely offline on consumer hardware. Midjourney requires an internet connection and runs on Midjourney servers only.', 3),
  ('stability-ai-vs-midjourney', 'API Access', 5, 2, 'Stability AI provides a well-documented API for production integration. Midjourney has limited API access and is primarily designed for Discord and web interface use.', 4),
  ('stability-ai-vs-midjourney', 'Community and Ecosystem', 4, 5, 'Midjourney has an exceptionally active Discord community with shared prompts and techniques. Stability AI has a large developer community but more fragmented around different model versions.', 5),
  ('stability-ai-vs-midjourney', 'Ease of Use', 2, 5, 'Midjourney''s simple prompts produce great results immediately. Stability AI requires technical setup for local use or understanding the API for cloud use - significantly higher barrier.', 6),
  ('stability-ai-vs-midjourney', 'Pricing', 4, 3, 'Stability AI API is usage-based with competitive per-image costs. Midjourney starts at $10/mo for basic and $30/mo for full features. Stability AI is more cost-effective at scale.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'stability-ai-vs-midjourney')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'stability-ai-vs-midjourney');

-- 5. Kittl vs Canva AI
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'kittl-vs-canva-ai', 'kittl', 'canva-ai',
  'Kittl and Canva AI are both accessible design tools for non-designers, but they serve different creative needs. Canva is the dominant all-in-one platform for social media graphics, presentations, and marketing content - its template library and AI tools are unmatched in breadth. Kittl specialises in typography-heavy and illustrative design for merchandise, apparel, and brand identity - areas where Canva''s templates are generic. For social media, presentations, and everyday marketing content, Canva is the better choice. For t-shirts, logos, merch, and print design with a handcrafted aesthetic, Kittl is more capable and appropriate.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'kittl-vs-canva-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('kittl-vs-canva-ai', 'Merch and Print Design', 5, 2, 'Kittl is purpose-built for t-shirt, apparel, and merchandise design with vector export and print-ready files. Canva has basic merch templates but is not optimized for this workflow.', 1),
  ('kittl-vs-canva-ai', 'Typography Design', 5, 3, 'Kittl''s AI text effects and typography tools are specifically designed for decorative lettering and brand mark creation. Canva has good font options but less control over stylized typography.', 2),
  ('kittl-vs-canva-ai', 'Social Media Content', 2, 5, 'Canva has thousands of social media templates optimized for every platform and format. Kittl is not designed for high-volume social media content production.', 3),
  ('kittl-vs-canva-ai', 'Template Breadth', 2, 5, 'Canva has one of the largest template libraries of any design tool - covering every content type. Kittl''s templates are excellent but focused on illustration and merch.', 4),
  ('kittl-vs-canva-ai', 'AI Image Generation', 3, 4, 'Canva''s Magic Media generates images for use in designs. Kittl''s AI focuses on design element generation rather than photorealistic image creation. Both are functional but different.', 5),
  ('kittl-vs-canva-ai', 'Vector Export', 5, 3, 'Kittl exports clean SVG and PDF files suitable for professional printing and cutting machines. Canva Pro exports PDF but SVG export is limited compared to Kittl.', 6),
  ('kittl-vs-canva-ai', 'Pricing', 4, 3, 'Kittl starts at $10/mo with commercial licensing. Canva Pro is $15/mo. Both have free tiers. Kittl is cheaper for commercial merch use; Canva is better value for general content teams.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'kittl-vs-canva-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'kittl-vs-canva-ai');
