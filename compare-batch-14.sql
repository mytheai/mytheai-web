-- compare-batch-14.sql
-- 5 new comparison pairs using tools already confirmed in DB
-- Tools used: readwise (batch-14), notebooklm (batch-4), groq (batch-14),
--             perplexity (original), klap (batch-14), opus-clip (batch-5),
--             chatpdf (batch-14), remove-bg (batch-14), photoroom (batch-9)
-- Pattern: ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)
-- Run in Supabase SQL Editor after all referenced tools are in DB

-- 1. Readwise vs NotebookLM
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'readwise-vs-notebooklm', 'readwise', 'notebooklm',
  'Readwise and NotebookLM both help you retain and use what you read, but they take very different approaches. Readwise excels at spaced-repetition recall from highlights across books, articles, and podcasts. NotebookLM is stronger for deep research sessions where you need to query and synthesize multiple source documents. Choose Readwise for daily reading habits and long-term retention; choose NotebookLM for focused research on a specific topic.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'readwise-vs-notebooklm');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('readwise-vs-notebooklm', 'Document Ingestion', 4, 5, 'NotebookLM handles PDFs, Google Docs, and web URLs natively. Readwise pulls from Kindle, Pocket, RSS, and browser extensions - broader source coverage for reading workflows.', 1),
  ('readwise-vs-notebooklm', 'AI Summarization', 4, 5, 'NotebookLM generates detailed source-grounded summaries with citations. Readwise AI summarizes individual highlights and articles but is not designed for multi-document synthesis.', 2),
  ('readwise-vs-notebooklm', 'Spaced Repetition', 5, 1, 'Readwise''s daily review system for highlights is its core differentiator - proven retention methodology. NotebookLM has no spaced repetition feature.', 3),
  ('readwise-vs-notebooklm', 'Mobile Experience', 5, 3, 'Readwise Reader is a polished mobile reading app. NotebookLM mobile is functional but secondary to the desktop experience.', 4),
  ('readwise-vs-notebooklm', 'Source Coverage', 5, 3, 'Readwise integrates with Kindle, Pocket, Instapaper, RSS, Twitter/X, and podcasts. NotebookLM is limited to documents you upload manually.', 5),
  ('readwise-vs-notebooklm', 'Research Synthesis', 3, 5, 'NotebookLM can answer complex questions across all uploaded sources simultaneously. Readwise surfaces individual highlights but does not synthesize across sources.', 6),
  ('readwise-vs-notebooklm', 'Pricing', 3, 5, 'NotebookLM is completely free. Readwise Reader is $7.99/mo (full plan $14.99/mo). Significant difference for budget-conscious users.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'readwise-vs-notebooklm')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'readwise-vs-notebooklm');

-- 2. Groq vs Perplexity
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'groq-vs-perplexity', 'groq', 'perplexity',
  'Groq and Perplexity are both designed to give you faster answers, but they solve different problems. Groq provides ultra-fast inference for running AI models via API - built for developers who need low-latency responses. Perplexity is a consumer search and research tool that combines AI reasoning with real-time web search. If you need fast AI inference for an application, choose Groq. If you need an AI search tool for research and fact-finding, choose Perplexity.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'groq-vs-perplexity');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('groq-vs-perplexity', 'Response Speed', 5, 3, 'Groq delivers over 500 tokens per second on supported models - the fastest AI inference available. Perplexity is responsive for a consumer tool but not optimized for low-latency use cases.', 1),
  ('groq-vs-perplexity', 'Web Search Integration', 1, 5, 'Perplexity searches the web in real time and cites sources for every answer. Groq has no web access - it returns model knowledge only, with a training cutoff.', 2),
  ('groq-vs-perplexity', 'API Access', 5, 2, 'Groq''s API is the product - developer-first with OpenAI-compatible endpoints. Perplexity has an API but it is secondary to the consumer interface.', 3),
  ('groq-vs-perplexity', 'Model Selection', 5, 2, 'Groq supports Llama 3, Mixtral, Gemma, Whisper, and other open models. Perplexity uses its own optimized model selection for search.', 4),
  ('groq-vs-perplexity', 'Consumer Interface', 2, 5, 'Perplexity has a polished chat and search interface with follow-up questions and source viewing. Groq''s playground is minimal and developer-oriented.', 5),
  ('groq-vs-perplexity', 'Source Citations', 1, 5, 'Perplexity cites every source with links to original articles. Groq returns model output with no sourcing - suitable for generation tasks, not research.', 6),
  ('groq-vs-perplexity', 'Pricing', 4, 4, 'Groq offers a generous free tier for API use. Perplexity is free with a $20/mo Pro plan for advanced features. Both are competitive on cost.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'groq-vs-perplexity')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'groq-vs-perplexity');

-- 3. Klap vs Opus Clip
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'klap-vs-opus-clip', 'klap', 'opus-clip',
  'Klap and Opus Clip are both AI tools that automatically clip long-form videos into short-form content for social media. Opus Clip has a stronger virality prediction algorithm and broader platform support. Klap produces high-quality captions and is faster for smaller batches. Both tools are genuinely useful for repurposing long videos - the choice comes down to whether you prioritize caption quality and simplicity (Klap) or virality scoring and volume (Opus Clip).',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'klap-vs-opus-clip');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('klap-vs-opus-clip', 'Clip Quality', 4, 4, 'Both tools identify strong moments accurately. Opus Clip has a slight edge on longer, more complex content with multiple segments. Klap is more consistent for interview-style videos.', 1),
  ('klap-vs-opus-clip', 'Caption Quality', 5, 4, 'Klap produces highly accurate captions with strong styling options. Opus Clip captions are good but require more post-editing for accuracy on technical or accented speech.', 2),
  ('klap-vs-opus-clip', 'Virality Score', 3, 5, 'Opus Clip''s virality scoring algorithm is its standout feature - it predicts which clips are most likely to perform well before you post them. Klap has basic engagement indicators.', 3),
  ('klap-vs-opus-clip', 'Supported Platforms', 4, 5, 'Opus Clip exports optimized for TikTok, Reels, Shorts, LinkedIn, and Twitter/X with platform-specific formatting. Klap covers the major platforms with slightly fewer options.', 4),
  ('klap-vs-opus-clip', 'Batch Processing', 3, 5, 'Opus Clip handles high-volume processing better for creators publishing multiple clips daily. Klap is better suited for occasional or moderate volume use.', 5),
  ('klap-vs-opus-clip', 'Ease of Use', 5, 4, 'Klap has a simpler, faster interface for uploading and getting clips. Opus Clip has more options which increases power but also complexity.', 6),
  ('klap-vs-opus-clip', 'Pricing', 4, 3, 'Klap starts lower and includes more clips per month at entry-level pricing. Opus Clip''s most useful features (virality score, bulk export) require higher-tier plans.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'klap-vs-opus-clip')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'klap-vs-opus-clip');

-- 4. ChatPDF vs NotebookLM
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'chatpdf-vs-notebooklm', 'chatpdf', 'notebooklm',
  'ChatPDF and NotebookLM are both AI tools for querying documents, but NotebookLM handles more source types and produces more sophisticated synthesis. ChatPDF is faster to use for a single PDF and has a lower barrier to entry - paste a link and start asking questions in 30 seconds. NotebookLM supports multiple document types simultaneously and generates audio overviews in addition to text answers. For quick single-document queries, ChatPDF wins on speed. For serious multi-source research, NotebookLM is more capable.',
  'notebooklm'
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatpdf-vs-notebooklm');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('chatpdf-vs-notebooklm', 'Ease of Entry', 5, 4, 'ChatPDF accepts a PDF URL with no account required. NotebookLM requires a Google account and notebook setup - minimal friction but slightly more than ChatPDF.', 1),
  ('chatpdf-vs-notebooklm', 'Document Types', 2, 5, 'NotebookLM supports PDFs, Google Docs, Google Slides, web URLs, and YouTube videos. ChatPDF is limited to PDF files only.', 2),
  ('chatpdf-vs-notebooklm', 'Multi-source Synthesis', 1, 5, 'NotebookLM can query across all uploaded sources simultaneously and synthesize answers. ChatPDF works on one document at a time with no cross-document capability.', 3),
  ('chatpdf-vs-notebooklm', 'Answer Accuracy', 4, 5, 'NotebookLM''s answers are more thoroughly grounded in source material with precise citations. ChatPDF occasionally drifts outside the document content.', 4),
  ('chatpdf-vs-notebooklm', 'Audio Overview', 1, 5, 'NotebookLM''s AI podcast feature generates an audio conversation summarizing your research - a unique capability with no equivalent in ChatPDF.', 5),
  ('chatpdf-vs-notebooklm', 'Speed for Single PDF', 5, 3, 'ChatPDF is faster for a quick question on a single document - no setup, immediate answers. NotebookLM requires creating a notebook first.', 6),
  ('chatpdf-vs-notebooklm', 'Pricing', 3, 5, 'NotebookLM is completely free. ChatPDF offers a free plan with limits and a Plus plan at $5/mo. For the same capability, NotebookLM is the clear winner on cost.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatpdf-vs-notebooklm')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'chatpdf-vs-notebooklm');

-- 5. Remove.bg vs Photoroom
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'remove-bg-vs-photoroom', 'remove-bg', 'photoroom',
  'Remove.bg and Photoroom both remove image backgrounds instantly, but Photoroom is the more complete product photography tool. Remove.bg is the fastest and simplest solution for pure background removal - ideal for bulk processing via API. Photoroom adds background generation, lighting adjustment, and product photo staging that goes well beyond removal. For developers and high-volume pipelines, Remove.bg is the better fit. For e-commerce teams creating product photos, Photoroom delivers more value.',
  'photoroom'
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'remove-bg-vs-photoroom');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('remove-bg-vs-photoroom', 'Background Removal Quality', 5, 5, 'Both tools produce excellent background removal results on product photos and portraits. Remove.bg has a slight edge on complex backgrounds with fine detail like hair or fur.', 1),
  ('remove-bg-vs-photoroom', 'Speed', 5, 4, 'Remove.bg processes images in under 1 second. Photoroom is fast but slightly slower due to additional AI processing for staging and enhancement features.', 2),
  ('remove-bg-vs-photoroom', 'Background Replacement', 3, 5, 'Photoroom generates photorealistic AI backgrounds and includes dozens of e-commerce and lifestyle scene templates. Remove.bg provides basic color and image replacement.', 3),
  ('remove-bg-vs-photoroom', 'E-commerce Features', 2, 5, 'Photoroom is purpose-built for product photography with auto-retouch, shadow generation, and batch export in multiple aspect ratios for different marketplaces.', 4),
  ('remove-bg-vs-photoroom', 'API Access', 5, 3, 'Remove.bg''s API is its core strength - well-documented, reliable, and used by major e-commerce platforms. Photoroom has an API but it is less central to the product.', 5),
  ('remove-bg-vs-photoroom', 'Batch Processing', 5, 4, 'Both handle batch processing, but Remove.bg''s API makes it easier to integrate into automated production pipelines at high volume.', 6),
  ('remove-bg-vs-photoroom', 'Pricing', 4, 3, 'Remove.bg''s pay-per-image model is cost-effective for occasional use. Photoroom requires a subscription for batch features, which adds up for high-volume users.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'remove-bg-vs-photoroom')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'remove-bg-vs-photoroom');
