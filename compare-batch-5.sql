-- compare-batch-5.sql
-- 5 new comparison pairs using tools already in DB
-- Pattern: ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)
-- Run in Supabase SQL Editor

-- 1. Jasper vs Rytr
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'jasper-vs-rytr', 'jasper', 'rytr',
  'Jasper and Rytr are both AI writing assistants, but they serve fundamentally different users. Jasper is a professional-grade platform for marketing teams, brand managers, and agencies who need brand voice training, long-form document creation, and enterprise workflows. Rytr is the budget-friendly choice for freelancers, small businesses, and solo creators who need solid short-form copy without the expense of an enterprise tool. The choice is usually straightforward: if price is a constraint, Rytr wins. If brand consistency and output quality are the priority, Jasper wins.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'jasper-vs-rytr')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('jasper-vs-rytr', 'Output Quality',           5, 3, 'Jasper produces consistently higher quality copy, especially for long-form content and brand-specific messaging.', 1),
  ('jasper-vs-rytr', 'Brand Voice Training',     5, 1, 'Jasper''s Brand Voice feature trains the AI on your existing content. Rytr has no brand voice or memory capability.', 2),
  ('jasper-vs-rytr', 'Long-Form Writing',        5, 2, 'Jasper has a dedicated document editor for full blog posts and articles. Rytr is optimised for short-form output only.', 3),
  ('jasper-vs-rytr', 'Template Library',         5, 4, 'Both offer broad template libraries. Jasper''s are more refined; Rytr covers 40+ use cases at comparable breadth.', 4),
  ('jasper-vs-rytr', 'Ease of Use',              3, 5, 'Rytr is simpler and faster to start using. Jasper''s additional features create more initial setup and learning time.', 5),
  ('jasper-vs-rytr', 'Team Collaboration',       5, 2, 'Jasper is built for teams with shared workspaces and permissions. Rytr is primarily a single-user tool.', 6),
  ('jasper-vs-rytr', 'Pricing',                  2, 5, 'Rytr Unlimited at $9/mo is significantly cheaper than Jasper Creator at $39/mo. Price gap is decisive for budget-conscious users.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'jasper-vs-rytr')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'jasper-vs-rytr');

-- 2. Frase vs Surfer SEO
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'frase-vs-surfer-seo', 'frase', 'surfer-seo',
  'Frase and Surfer SEO are both AI-powered SEO content tools, but they approach the problem differently. Frase focuses on the full content workflow from research and brief to draft, with a stronger emphasis on AI-assisted writing. Surfer SEO focuses on in-editor optimisation scoring and SERP data analysis, with a stronger emphasis on keyword density and competitor benchmarking. Many serious content teams use both together — Frase for briefing and drafting, Surfer for scoring and refinement.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'frase-vs-surfer-seo')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('frase-vs-surfer-seo', 'Content Briefing',         5, 4, 'Frase''s briefs compile competitor topics, questions, and outlines automatically. Surfer''s briefs are SERP-focused with keyword data emphasis.', 1),
  ('frase-vs-surfer-seo', 'AI Writing Assistant',     5, 3, 'Frase has a more developed AI writer integrated into the brief and document workflow. Surfer''s AI writing is a newer addition and less integrated.', 2),
  ('frase-vs-surfer-seo', 'On-Page Optimisation Score',3, 5, 'Surfer''s content score and keyword density tracking are more granular and the benchmark for SEO scoring. Frase''s scoring is simpler.', 3),
  ('frase-vs-surfer-seo', 'SERP Analysis',            4, 5, 'Surfer provides deeper SERP analysis including NLP terms, page structure data, and word count benchmarks. Frase covers key SERP data but less granularly.', 4),
  ('frase-vs-surfer-seo', 'Topic Research',           5, 3, 'Frase extracts questions from "People Also Ask" and competitor content automatically. Surfer focuses less on question-based topic research.', 5),
  ('frase-vs-surfer-seo', 'Ease of Use',              4, 4, 'Both have comparable learning curves. Frase''s interface is slightly more intuitive for writers; Surfer''s is more familiar to SEO specialists.', 6),
  ('frase-vs-surfer-seo', 'Pricing',                  5, 3, 'Frase Solo starts at $15/mo. Surfer Essential starts at $89/mo — a significant gap for freelancers and small teams.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'frase-vs-surfer-seo')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'frase-vs-surfer-seo');

-- 3. Runway vs Luma AI
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'runway-vs-luma-ai', 'runway', 'luma-ai',
  'Runway and Luma AI (Dream Machine) are two of the highest-quality AI video generators in 2026. Runway is the more feature-complete platform with editing tools, inpainting, and a broader creative toolkit. Luma AI focuses on pure generation quality — particularly cinematic realism in lighting and camera movement. For production workflows, Runway offers more control. For the most visually impressive single clips, Luma AI often delivers results that look closer to real footage.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'runway-vs-luma-ai')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('runway-vs-luma-ai', 'Cinematic Realism',       4, 5, 'Luma AI Dream Machine produces more naturally cinematic results for lighting, reflections, and camera movement on many prompt types.', 1),
  ('runway-vs-luma-ai', 'Motion Control',          5, 3, 'Runway offers more granular camera control including motion brush and specific movement parameters. Luma relies more on prompt interpretation.', 2),
  ('runway-vs-luma-ai', 'Feature Breadth',         5, 2, 'Runway includes inpainting, outpainting, background removal, and a video editor. Luma AI focuses solely on video generation.', 3),
  ('runway-vs-luma-ai', 'Generation Speed',        3, 4, 'Luma generates clips faster on average. Runway''s higher-resolution and longer-form output takes more time.', 4),
  ('runway-vs-luma-ai', 'API Access',              5, 4, 'Both offer developer APIs. Runway''s API is more mature with broader documentation and third-party integrations.', 5),
  ('runway-vs-luma-ai', 'iOS App',                 2, 5, 'Luma AI has a well-designed iOS app for mobile generation. Runway is primarily a web-based platform.', 6),
  ('runway-vs-luma-ai', 'Pricing',                 3, 4, 'Luma AI''s free tier is more generous for casual use. Runway''s paid plans are more expensive but reflect the broader production toolset.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'runway-vs-luma-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'runway-vs-luma-ai');

-- 4. Notion AI vs NotebookLM
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'notion-ai-vs-notebooklm', 'notion-ai', 'notebooklm',
  'Notion AI and NotebookLM are both AI tools for working with written information, but they serve different workflows. Notion AI is an assistant embedded inside a productivity workspace — it helps with writing, summarising, and organising work within Notion pages and databases. NotebookLM is a dedicated research and study tool that grounds AI responses entirely in documents you upload, with a focus on deep analysis and a unique Audio Overview feature. Choose Notion AI if you already use Notion for work. Choose NotebookLM for serious research on specific document sets.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'notion-ai-vs-notebooklm')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('notion-ai-vs-notebooklm', 'Document Grounding',     2, 5, 'NotebookLM''s entire design is grounded in uploaded sources with citations. Notion AI draws on general training plus page context but not specific uploaded documents.', 1),
  ('notion-ai-vs-notebooklm', 'Writing Assistance',     5, 2, 'Notion AI is a strong in-editor writing assistant for drafting, editing, and summarising. NotebookLM focuses on analysis rather than writing assistance.', 2),
  ('notion-ai-vs-notebooklm', 'Audio Overview',         1, 5, 'NotebookLM''s Audio Overview is a unique feature that converts document sets into a podcast-style conversation. Notion AI has no audio capabilities.', 3),
  ('notion-ai-vs-notebooklm', 'Workspace Integration',  5, 1, 'Notion AI is native to the Notion workspace. NotebookLM is a standalone research tool with no integration into productivity suites.', 4),
  ('notion-ai-vs-notebooklm', 'Research Depth',         3, 5, 'NotebookLM provides deeper analysis and cross-source synthesis on uploaded material. Notion AI is more useful for in-context page tasks.', 5),
  ('notion-ai-vs-notebooklm', 'Source Citation',        2, 5, 'NotebookLM cites exact source passages for every answer. Notion AI does not provide source citations.', 6),
  ('notion-ai-vs-notebooklm', 'Pricing',                3, 5, 'NotebookLM is free (Plus included in Google One AI Premium). Notion AI adds $10/mo to an existing Notion subscription.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'notion-ai-vs-notebooklm')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'notion-ai-vs-notebooklm');

-- 5. Grammarly vs Quillbot
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'grammarly-vs-quillbot', 'grammarly', 'quillbot',
  'Grammarly and QuillBot are the two most widely used AI writing improvement tools, but they solve different problems. Grammarly is primarily an editing assistant — it catches grammar, spelling, clarity, and tone issues in real time across every app you write in. QuillBot is primarily a rewriting and paraphrasing tool — it transforms existing text into new versions, which makes it more useful for repurposing content and avoiding repetition. Many writers use both: Grammarly for real-time editing while writing, QuillBot for reworking finished drafts.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'grammarly-vs-quillbot')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('grammarly-vs-quillbot', 'Real-Time Editing',        5, 2, 'Grammarly''s browser extension and desktop app provide real-time corrections across Gmail, Docs, Slack, and every web app. QuillBot requires pasting text.', 1),
  ('grammarly-vs-quillbot', 'Paraphrasing Quality',     3, 5, 'QuillBot''s paraphrase tool with multiple modes (standard, fluency, formal, creative) is best-in-class. Grammarly''s rewrite suggestions are more limited.', 2),
  ('grammarly-vs-quillbot', 'Grammar & Spelling',       5, 3, 'Grammarly is the benchmark for grammar checking with fine-grained explanations. QuillBot''s grammar checker is functional but less detailed.', 3),
  ('grammarly-vs-quillbot', 'Tone Detection',           5, 2, 'Grammarly''s tone detector and goal-setting features adjust suggestions to audience and formality level. QuillBot has basic tone modes but less nuance.', 4),
  ('grammarly-vs-quillbot', 'Plagiarism Detection',     5, 3, 'Grammarly includes a plagiarism checker on Premium plans. QuillBot includes a basic plagiarism checker on paid plans.', 5),
  ('grammarly-vs-quillbot', 'Content Repurposing',      2, 5, 'QuillBot is purpose-built for repurposing: summariser, paraphraser, and translator in one tool. Grammarly does not support content repurposing workflows.', 6),
  ('grammarly-vs-quillbot', 'Pricing',                  3, 5, 'QuillBot Premium at $4.17/mo (annual) is significantly cheaper than Grammarly Premium at $12/mo. QuillBot wins on price for comparable features.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'grammarly-vs-quillbot')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'grammarly-vs-quillbot');
