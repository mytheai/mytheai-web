-- compare-batch-6.sql
-- 5 new comparison pairs using tools already in DB
-- Pattern: ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)
-- Run in Supabase SQL Editor

-- 1. Gamma vs Beautiful.ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'gamma-vs-beautiful-ai', 'gamma', 'beautiful-ai',
  'Gamma and Beautiful.ai are both AI presentation tools that automate slide design, but they approach it differently. Gamma generates a complete web-based presentation from a text prompt — content, layout, and visuals included — optimised for sharing as a link. Beautiful.ai uses Smart Slide technology that auto-formats slides as you type, giving more manual control over content while automating the design decisions. Gamma is faster for creating from scratch; Beautiful.ai is better for teams with existing content that needs polished formatting.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gamma-vs-beautiful-ai')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('gamma-vs-beautiful-ai', 'Speed from Zero',         5, 3, 'Gamma generates a complete presentation from a text brief in under a minute. Beautiful.ai requires adding content slide by slide.', 1),
  ('gamma-vs-beautiful-ai', 'Design Quality',          4, 5, 'Beautiful.ai''s Smart Slide system produces more consistently polished results when content is well-structured. Gamma quality varies by prompt.', 2),
  ('gamma-vs-beautiful-ai', 'Manual Control',          3, 5, 'Beautiful.ai offers more granular control over individual slides and layouts. Gamma is more opinionated about structure.', 3),
  ('gamma-vs-beautiful-ai', 'Brand Kit',               2, 5, 'Beautiful.ai has a robust team brand kit with shared fonts, colours, and templates. Gamma''s branding tools are more basic.', 4),
  ('gamma-vs-beautiful-ai', 'Output Format',           4, 3, 'Gamma produces interactive web presentations with live links. Beautiful.ai exports standard slide files compatible with PowerPoint.', 5),
  ('gamma-vs-beautiful-ai', 'Collaboration',           4, 4, 'Both support real-time collaboration. Gamma''s viewer analytics show engagement per slide; Beautiful.ai''s team features are more workflow-oriented.', 6),
  ('gamma-vs-beautiful-ai', 'Pricing',                 5, 3, 'Gamma free plan includes unlimited AI generation. Beautiful.ai has no free plan — paid from $12/mo.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gamma-vs-beautiful-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'gamma-vs-beautiful-ai');

-- 2. ChatGPT vs Perplexity
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'chatgpt-vs-perplexity', 'chatgpt', 'perplexity',
  'ChatGPT and Perplexity serve different primary use cases despite both being AI assistants. Perplexity is built around real-time web search — every answer cites sources, making it the better tool for research, current events, and fact-checking. ChatGPT is built around general-purpose reasoning and generation — it is stronger for writing, coding, analysis, and creative tasks. The choice depends on whether you need sourced current information or broad general-purpose AI assistance.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatgpt-vs-perplexity')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('chatgpt-vs-perplexity', 'Real-Time Web Search',    3, 5, 'Perplexity''s entire architecture is built around live web search with citations. ChatGPT''s web search is functional but secondary to generation.', 1),
  ('chatgpt-vs-perplexity', 'Source Citations',        3, 5, 'Perplexity cites every source with links. ChatGPT does not provide citations by default, making fact verification harder.', 2),
  ('chatgpt-vs-perplexity', 'Writing & Generation',    5, 3, 'ChatGPT is significantly stronger for long-form writing, creative tasks, and nuanced generation. Perplexity optimises for answers, not prose.', 3),
  ('chatgpt-vs-perplexity', 'Coding',                  5, 2, 'ChatGPT with code interpreter is a strong coding assistant. Perplexity is primarily for information retrieval, not code generation.', 4),
  ('chatgpt-vs-perplexity', 'Research Accuracy',       3, 5, 'Perplexity''s grounded-in-search approach reduces hallucination risk for factual questions. ChatGPT''s training data can be outdated or incorrect.', 5),
  ('chatgpt-vs-perplexity', 'Multimodal',              5, 3, 'ChatGPT supports image upload, DALL-E image generation, and voice. Perplexity''s multimodal support is more limited.', 6),
  ('chatgpt-vs-perplexity', 'Pricing',                 4, 4, 'ChatGPT Plus: $20/mo. Perplexity Pro: $20/mo. Equal at the individual tier, though Perplexity''s free plan is more useful for research.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatgpt-vs-perplexity')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'chatgpt-vs-perplexity');

-- 3. HeyGen vs Synthesia
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'heygen-vs-synthesia', 'heygen', 'synthesia',
  'HeyGen and Synthesia are the two leading AI avatar video platforms, both allowing users to create professional video content with realistic AI presenters without cameras or studios. Synthesia is more enterprise-focused with stronger brand controls, an LMS integration, and a larger avatar library. HeyGen has built a stronger reputation for avatar realism and a more accessible pricing structure for smaller teams. Both are strong — the choice often comes down to budget and whether enterprise integrations or video quality is the priority.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'heygen-vs-synthesia')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('heygen-vs-synthesia', 'Avatar Realism',         5, 4, 'HeyGen''s avatars are widely considered more natural in facial expression and lip-sync accuracy. Synthesia has improved significantly but still slightly behind.', 1),
  ('heygen-vs-synthesia', 'Avatar Library',         4, 5, 'Synthesia has 230+ diverse stock avatars. HeyGen''s library is smaller but includes strong custom avatar creation from a video sample.', 2),
  ('heygen-vs-synthesia', 'Custom Avatars',         5, 4, 'HeyGen''s custom avatar creation is faster and produces highly realistic results. Both support custom avatars on paid plans.', 3),
  ('heygen-vs-synthesia', 'Enterprise Features',   3, 5, 'Synthesia includes LMS integration, SSO, team permissions, and compliance features suited to large enterprises. HeyGen is less enterprise-ready.', 4),
  ('heygen-vs-synthesia', 'Language Support',       4, 5, 'Synthesia supports 140+ languages with strong quality. HeyGen supports 40+ languages — excellent coverage but narrower.', 5),
  ('heygen-vs-synthesia', 'Ease of Use',            5, 4, 'Both have simple interfaces. HeyGen''s workflow for quick video production is slightly more intuitive for new users.', 6),
  ('heygen-vs-synthesia', 'Pricing',                5, 3, 'HeyGen Creator at $29/mo vs Synthesia Starter at $22/mo. HeyGen offers more video minutes per dollar at comparable tiers.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'heygen-vs-synthesia')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'heygen-vs-synthesia');

-- 4. Fathom vs tl;dv
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'fathom-vs-tldv', 'fathom', 'tldv',
  'Fathom and tl;dv are both AI meeting recorders with generous free plans, but they target different use cases. Fathom''s primary strength is CRM integration — automatically logging call summaries to Salesforce and HubSpot, making it the preferred tool for sales teams. tl;dv''s primary strength is cross-meeting intelligence — surfacing patterns and insights across multiple calls, making it more useful for managers and revenue operations teams who need signals across a portfolio of conversations.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'fathom-vs-tldv')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('fathom-vs-tldv', 'CRM Integration',           5, 4, 'Fathom''s direct Salesforce and HubSpot integration is more seamless and automated. tl;dv integrates with both but requires more configuration.', 1),
  ('fathom-vs-tldv', 'Cross-Meeting Insights',    3, 5, 'tl;dv''s multi-meeting reports surface trends and patterns across calls. Fathom focuses on individual meeting summaries and CRM logging.', 2),
  ('fathom-vs-tldv', 'Transcript Quality',        4, 4, 'Both produce accurate transcripts. Quality is comparable — minor differences vary by accent and audio quality.', 3),
  ('fathom-vs-tldv', 'Clip Sharing',              4, 5, 'tl;dv''s clip creation and sharing from timestamp is more refined. Fathom supports sharing but with fewer editing options.', 4),
  ('fathom-vs-tldv', 'Free Plan Generosity',      5, 5, 'Both offer very generous free plans with unlimited recordings. Fathom''s free plan is slightly more full-featured for individual use.', 5),
  ('fathom-vs-tldv', 'Meeting Platform Support',  5, 4, 'Both support Zoom, Google Meet, and Teams. Fathom''s integrations feel more stable and reliable across all three.', 6),
  ('fathom-vs-tldv', 'Pricing',                   4, 4, 'Fathom Team at $19/user/mo vs tl;dv Pro at $18/user/mo. Essentially equal — feature differences drive the choice, not price.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'fathom-vs-tldv')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'fathom-vs-tldv');

-- 5. Lovable vs Bolt
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'lovable-vs-bolt', 'lovable', 'bolt',
  'Lovable and Bolt are both AI app builders that generate full-stack web applications from a text description, targeting the same core use case but with different strengths. Lovable integrates tightly with Supabase for database and auth, making it stronger for data-driven applications. Bolt uses StackBlitz''s browser-based execution for a faster initial preview experience and simpler one-click Netlify deployment. Both produce real, editable code — Lovable with GitHub integration, Bolt with in-browser editing.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lovable-vs-bolt')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('lovable-vs-bolt', 'Database & Auth',           5, 3, 'Lovable''s native Supabase integration handles database schema and authentication automatically. Bolt''s database support requires more manual configuration.', 1),
  ('lovable-vs-bolt', 'Preview Speed',             3, 5, 'Bolt runs in the browser via StackBlitz — preview is near-instant. Lovable requires a build step before the live preview updates.', 2),
  ('lovable-vs-bolt', 'Code Quality',              4, 4, 'Both produce clean React/TypeScript code. Lovable''s output is slightly more structured for complex apps; Bolt is cleaner for simpler projects.', 3),
  ('lovable-vs-bolt', 'GitHub Integration',        5, 3, 'Lovable has direct GitHub sync for version control and team collaboration. Bolt''s code can be exported but GitHub integration is less native.', 4),
  ('lovable-vs-bolt', 'Deployment',                4, 5, 'Bolt''s one-click Netlify deployment is the simplest path to production. Lovable deploys to its own hosting or GitHub Pages.', 5),
  ('lovable-vs-bolt', 'Free Tier',                 4, 4, 'Both offer free tiers with token limits. Bolt''s daily token reset is useful for light users; Lovable''s monthly model suits consistent builders.', 6),
  ('lovable-vs-bolt', 'Complex App Support',       5, 4, 'Lovable handles more complex multi-model applications better. Bolt excels at simpler projects and prototypes that need to go live fast.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lovable-vs-bolt')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lovable-vs-bolt');
