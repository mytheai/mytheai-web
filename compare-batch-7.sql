-- compare-batch-7.sql
-- 5 new comparison pairs using tools from batches 7 & 8
-- Safe to re-run (ON CONFLICT DO NOTHING + NOT EXISTS guard)

-- 1. mailchimp-vs-beehiiv
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'mailchimp-vs-beehiiv', 'mailchimp', 'beehiiv',
  'Mailchimp is the established email marketing giant; Beehiiv is the modern newsletter platform built for creators and audience monetisation. Beehiiv wins for newsletter-first publishers; Mailchimp wins for businesses with complex automation needs.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mailchimp-vs-beehiiv')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('mailchimp-vs-beehiiv', 'Free Plan',           4, 5, 'Beehiiv''s free plan supports up to 2,500 subscribers; Mailchimp limits to 500', 1),
  ('mailchimp-vs-beehiiv', 'Ease of Use',         4, 5, 'Beehiiv is cleaner and faster to set up for newsletters specifically', 2),
  ('mailchimp-vs-beehiiv', 'Automation',          5, 3, 'Mailchimp has significantly more complex automation capabilities', 3),
  ('mailchimp-vs-beehiiv', 'Monetisation',        2, 5, 'Beehiiv has native paid subscriptions, boosts, and referral programs built in', 4),
  ('mailchimp-vs-beehiiv', 'Analytics',           4, 4, 'Both offer solid open/click analytics; Beehiiv adds subscriber growth tracking', 5),
  ('mailchimp-vs-beehiiv', 'Integrations',        5, 3, 'Mailchimp connects to 300+ tools; Beehiiv ecosystem is more limited', 6),
  ('mailchimp-vs-beehiiv', 'Pricing at Scale',    3, 4, 'Beehiiv stays cheaper as list grows; Mailchimp pricing escalates quickly', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'mailchimp-vs-beehiiv'
);

-- 2. wordtune-vs-grammarly
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'wordtune-vs-grammarly', 'wordtune', 'grammarly',
  'Grammarly leads on grammar and correctness checking; Wordtune leads on rewriting and improving existing prose. They solve different problems — Grammarly catches errors, Wordtune improves style.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'wordtune-vs-grammarly')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('wordtune-vs-grammarly', 'Grammar Checking',     2, 5, 'Grammarly is the industry standard for grammar, spelling, and punctuation', 1),
  ('wordtune-vs-grammarly', 'Rewriting & Rewording', 5, 3, 'Wordtune''s core strength — multiple rewrite options per sentence', 2),
  ('wordtune-vs-grammarly', 'Tone Adjustment',       4, 4, 'Both adjust formality; Wordtune offers more stylistic options', 3),
  ('wordtune-vs-grammarly', 'Summarisation',         4, 2, 'Wordtune Read summarises long documents; Grammarly doesn''t', 4),
  ('wordtune-vs-grammarly', 'Browser Extension',     4, 5, 'Grammarly works in more apps and has better native integration', 5),
  ('wordtune-vs-grammarly', 'Free Plan',             3, 4, 'Grammarly''s free plan has broader grammar coverage', 6),
  ('wordtune-vs-grammarly', 'Plagiarism Detection',  1, 5, 'Grammarly Premium has plagiarism detection; Wordtune does not', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'wordtune-vs-grammarly'
);

-- 3. hootsuite-vs-buffer
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'hootsuite-vs-buffer', 'hootsuite', 'buffer',
  'Hootsuite is the enterprise-grade social media platform for teams with complex workflows; Buffer is the simpler, more affordable option for small teams and creators. Buffer wins on price and simplicity; Hootsuite wins on team features and analytics.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hootsuite-vs-buffer')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('hootsuite-vs-buffer', 'Ease of Use',       3, 5, 'Buffer is significantly simpler to set up and use day-to-day', 1),
  ('hootsuite-vs-buffer', 'Pricing',           2, 5, 'Buffer starts at $6/mo; Hootsuite starts at $99/mo', 2),
  ('hootsuite-vs-buffer', 'Team Workflows',    5, 3, 'Hootsuite has approval workflows, permissions, and team collaboration', 3),
  ('hootsuite-vs-buffer', 'Analytics',         5, 3, 'Hootsuite analytics are more comprehensive with exportable reports', 4),
  ('hootsuite-vs-buffer', 'Social Listening',  5, 1, 'Hootsuite monitors brand mentions; Buffer has no listening features', 5),
  ('hootsuite-vs-buffer', 'AI Content Tools',  4, 4, 'Both offer AI caption generation; Hootsuite''s OwlyWriter is more featured', 6),
  ('hootsuite-vs-buffer', 'Platform Support',  5, 4, 'Both support major platforms; Hootsuite adds TikTok and Pinterest natively', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'hootsuite-vs-buffer'
);

-- 4. replicate-vs-together-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'replicate-vs-together-ai', 'replicate', 'together-ai',
  'Replicate hosts the broadest model library including image and audio models; Together AI specialises in fast, cheap text model inference. Replicate wins for model variety; Together AI wins for LLM cost and speed.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'replicate-vs-together-ai')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('replicate-vs-together-ai', 'Model Variety',       5, 3, 'Replicate hosts image, audio, video, and text models; Together AI focuses on LLMs', 1),
  ('replicate-vs-together-ai', 'LLM Inference Cost',  3, 5, 'Together AI is significantly cheaper per token for text generation', 2),
  ('replicate-vs-together-ai', 'Latency',             3, 5, 'Together AI has lower latency for text; Replicate can have cold starts', 3),
  ('replicate-vs-together-ai', 'Fine-tuning',         3, 5, 'Together AI has more robust fine-tuning pipeline for LLMs', 4),
  ('replicate-vs-together-ai', 'Image Generation',    5, 1, 'Replicate hosts Stable Diffusion, Flux, SDXL; Together AI does not', 5),
  ('replicate-vs-together-ai', 'Ease of Integration', 4, 4, 'Both have clean REST APIs; Replicate has more community tutorials', 6),
  ('replicate-vs-together-ai', 'Free Credits',        4, 4, 'Both offer free credits on sign-up for testing', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'replicate-vs-together-ai'
);

-- 5. meta-ai-vs-grok
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'meta-ai-vs-grok', 'meta-ai', 'grok',
  'Meta AI is free and integrated into WhatsApp and Instagram; Grok is integrated with X (Twitter) and has real-time web access. Both are free alternatives to ChatGPT — Meta AI wins on reach, Grok wins on real-time information.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'meta-ai-vs-grok')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('meta-ai-vs-grok', 'Availability',          5, 4, 'Meta AI in WhatsApp and Instagram; Grok requires X account', 1),
  ('meta-ai-vs-grok', 'Real-Time Information', 3, 5, 'Grok has live X/web access; Meta AI has web access but less current', 2),
  ('meta-ai-vs-grok', 'Image Generation',      5, 4, 'Meta AI image gen built into chats; Grok Aurora available on X Premium', 3),
  ('meta-ai-vs-grok', 'Reasoning Quality',     4, 4, 'Llama 4 and Grok 3 are comparable on benchmarks', 4),
  ('meta-ai-vs-grok', 'Privacy',               3, 3, 'Both raise data concerns — Meta and X both use data for training', 5),
  ('meta-ai-vs-grok', 'Cost',                  5, 4, 'Meta AI is fully free; Grok SuperGrok requires X Premium+', 6),
  ('meta-ai-vs-grok', 'Social Integration',    5, 5, 'Meta AI in Meta platforms; Grok native to X — both win in their ecosystem', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'meta-ai-vs-grok'
);
