-- compare-batch-8.sql
-- 5 new comparison pairs using tools from batches 7-9
-- Safe to re-run (ON CONFLICT DO NOTHING + NOT EXISTS guard)

-- 1. udio-vs-suno
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'udio-vs-suno', 'udio', 'suno',
  'Udio and Suno are the two leading AI music generators in 2026. Both produce full songs from text prompts in seconds. Suno leads on vocal coherence and lyrical creativity; Udio leads on instrumental arrangement quality and genre accuracy.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'udio-vs-suno')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('udio-vs-suno', 'Vocal Quality',           4, 5, 'Suno vocals are generally more coherent and expressive', 1),
  ('udio-vs-suno', 'Instrumental Quality',    5, 4, 'Udio produces richer, more musical arrangements', 2),
  ('udio-vs-suno', 'Genre Accuracy',          5, 4, 'Udio is more precise at capturing specific genre characteristics', 3),
  ('udio-vs-suno', 'Lyric Generation',        4, 5, 'Suno writes more natural, creative lyrics', 4),
  ('udio-vs-suno', 'Free Plan',               4, 4, 'Both offer limited free generations per month', 5),
  ('udio-vs-suno', 'Commercial License',      4, 4, 'Both offer commercial licensing on paid plans', 6),
  ('udio-vs-suno', 'Audio Length',            4, 4, 'Both generate 2-4 minute tracks; extensions available', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'udio-vs-suno'
);

-- 2. you-com-vs-perplexity
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'you-com-vs-perplexity', 'you-com', 'perplexity',
  'You.com and Perplexity are both AI-powered alternatives to Google Search. Perplexity focuses on research accuracy with cited sources; You.com offers more personalisation and built-in creative tools alongside search.',
  'perplexity', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'you-com-vs-perplexity')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('you-com-vs-perplexity', 'Research Accuracy',     3, 5, 'Perplexity''s cited sources and accuracy on factual queries is consistently better', 1),
  ('you-com-vs-perplexity', 'Source Citations',      3, 5, 'Perplexity cites every claim; You.com citations are less rigorous', 2),
  ('you-com-vs-perplexity', 'Personalisation',       5, 2, 'You.com lets you customise sources and preferences; Perplexity does not', 3),
  ('you-com-vs-perplexity', 'Image Generation',      4, 1, 'You.com has built-in image generation; Perplexity does not', 4),
  ('you-com-vs-perplexity', 'Writing Tools',         4, 1, 'You.com includes AI writing; Perplexity is search-only', 5),
  ('you-com-vs-perplexity', 'Free Plan',             5, 4, 'You.com has no query limits; Perplexity Pro limits daily searches', 6),
  ('you-com-vs-perplexity', 'Deep Research',         3, 5, 'Perplexity Deep Research is best-in-class for multi-source synthesis', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'you-com-vs-perplexity'
);

-- 3. langchain-vs-dify
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'langchain-vs-dify', 'langchain', 'dify',
  'LangChain is the code-first LLM framework for developers who want full programmatic control; Dify is the visual LLM platform for teams who want to build AI workflows without writing framework code. LangChain wins on flexibility; Dify wins on speed and accessibility.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'langchain-vs-dify')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('langchain-vs-dify', 'Ease of Use',            2, 5, 'Dify''s visual builder requires no framework knowledge; LangChain has steep curve', 1),
  ('langchain-vs-dify', 'Customisation',          5, 3, 'LangChain allows any custom logic in Python; Dify is limited to visual primitives', 2),
  ('langchain-vs-dify', 'RAG Pipeline',           4, 5, 'Dify''s built-in RAG is faster to configure; LangChain requires more setup', 3),
  ('langchain-vs-dify', 'Non-developer Access',   1, 5, 'Dify can be used by non-engineers; LangChain requires Python knowledge', 4),
  ('langchain-vs-dify', 'Observability',          5, 4, 'LangSmith is the best LLM observability tool; Dify has built-in logging', 5),
  ('langchain-vs-dify', 'Self-hosting',           3, 5, 'Dify has a clean Docker self-host; LangChain is a library, not a server', 6),
  ('langchain-vs-dify', 'Ecosystem',              5, 3, 'LangChain integrations cover more tools and model providers', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'langchain-vs-dify'
);

-- 4. microsoft-365-copilot-vs-notion-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'microsoft-365-copilot-vs-notion-ai', 'microsoft-365-copilot', 'notion-ai',
  'Microsoft 365 Copilot brings AI to Word, Excel, Outlook, and Teams; Notion AI brings it to notes, docs, and wikis. Copilot wins for enterprise Microsoft users; Notion AI wins for teams already building their knowledge base in Notion.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'microsoft-365-copilot-vs-notion-ai')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('microsoft-365-copilot-vs-notion-ai', 'Email Integration',       5, 1, 'Copilot works in Outlook; Notion AI has no email integration', 1),
  ('microsoft-365-copilot-vs-notion-ai', 'Spreadsheet AI',          5, 2, 'Copilot in Excel is a full data analyst; Notion databases are limited', 2),
  ('microsoft-365-copilot-vs-notion-ai', 'Meeting Summarisation',   5, 2, 'Copilot in Teams summarises live meetings; Notion AI does not', 3),
  ('microsoft-365-copilot-vs-notion-ai', 'Knowledge Base AI',       2, 5, 'Notion AI searches and queries your entire workspace knowledge base', 4),
  ('microsoft-365-copilot-vs-notion-ai', 'Pricing',                 2, 4, 'Copilot is $30/user/month add-on; Notion AI is $10/user/month', 5),
  ('microsoft-365-copilot-vs-notion-ai', 'Ease of Use',             3, 5, 'Notion AI is more intuitive within the Notion interface', 6),
  ('microsoft-365-copilot-vs-notion-ai', 'Enterprise Compliance',   5, 3, 'Microsoft''s enterprise security and compliance is more mature', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'microsoft-365-copilot-vs-notion-ai'
);

-- 5. krea-ai-vs-midjourney
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'krea-ai-vs-midjourney', 'krea-ai', 'midjourney',
  'Midjourney produces the highest-quality artistic images of any AI tool; Krea AI offers real-time generation and AI enhancement for a more iterative creative workflow. Midjourney wins on image quality; Krea wins on creative control and enhancement.',
  'midjourney', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'krea-ai-vs-midjourney')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('krea-ai-vs-midjourney', 'Image Quality',          3, 5, 'Midjourney v7 produces the highest quality AI images available', 1),
  ('krea-ai-vs-midjourney', 'Real-time Generation',   5, 1, 'Krea shows results updating live; Midjourney is prompt-and-wait', 2),
  ('krea-ai-vs-midjourney', 'Creative Control',       5, 3, 'Krea offers sketch-to-image, real-time canvas, and reference controls', 3),
  ('krea-ai-vs-midjourney', 'Image Enhancement',      5, 1, 'Krea''s AI Enhancer upscales and adds detail; Midjourney does not', 4),
  ('krea-ai-vs-midjourney', 'Custom Model Training',  5, 2, 'Krea supports custom LoRA training; Midjourney has no custom model support', 5),
  ('krea-ai-vs-midjourney', 'Community & Presets',    2, 5, 'Midjourney has the largest community and style library', 6),
  ('krea-ai-vs-midjourney', 'Ease of Use',            3, 4, 'Midjourney Discord is unusual but familiar; Krea''s interface is more visual', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'krea-ai-vs-midjourney'
);
