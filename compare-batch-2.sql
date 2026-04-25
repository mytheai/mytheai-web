-- compare-batch-2.sql
-- 5 new comparison pairs
-- Run in Supabase → SQL Editor (New query tab)
-- Uses ON CONFLICT DO NOTHING — safe to re-run

-- ============================================================
-- 1. cursor-vs-github-copilot
-- ============================================================

insert into comparisons (slug, tool_a_slug, tool_b_slug, summary, winner) values
('cursor-vs-github-copilot', 'cursor', 'github-copilot',
 'Cursor and GitHub Copilot are the two most popular AI coding tools, but they take fundamentally different approaches. Cursor is a full AI-native code editor — a VS Code fork where AI is built into every layer of the experience, from autocomplete to codebase-wide chat. GitHub Copilot is an extension that works inside any IDE you already use. Cursor wins for developers who want the most powerful AI coding experience available. Copilot wins for developers who need to stay in their existing IDE or work in an enterprise environment.',
 null)
ON CONFLICT (slug) DO NOTHING;

insert into comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
select * from (values
  ('cursor-vs-github-copilot', 'Code Completion',        5, 4, 'Cursor completions are more context-aware and accept multi-line suggestions; Copilot is excellent but slightly more conservative', 1),
  ('cursor-vs-github-copilot', 'Codebase Understanding', 5, 3, 'Cursor indexes your full repo for context; Copilot has limited multi-file awareness', 2),
  ('cursor-vs-github-copilot', 'Chat Interface',         5, 4, 'Cursor Chat queries your entire codebase; Copilot Chat is improving but more file-scoped', 3),
  ('cursor-vs-github-copilot', 'IDE Flexibility',        2, 5, 'Copilot works in VS Code, JetBrains, Vim, Neovim; Cursor is its own editor (VS Code fork)', 4),
  ('cursor-vs-github-copilot', 'AI Models',              5, 4, 'Cursor supports Claude, GPT-4o, and others; Copilot primarily uses OpenAI models', 5),
  ('cursor-vs-github-copilot', 'Enterprise / Teams',     3, 5, 'Copilot has mature enterprise controls, audit logs, and policy management; Cursor Teams is newer', 6),
  ('cursor-vs-github-copilot', 'Pricing',                4, 3, 'Cursor free tier is generous with 2,000 completions/month; Copilot requires $10/mo with no meaningful free tier', 7)
) as v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
where exists (select 1 from comparisons where slug = 'cursor-vs-github-copilot')
  and not exists (select 1 from comparison_criteria where comparison_slug = 'cursor-vs-github-copilot');

-- ============================================================
-- 2. grammarly-vs-jasper
-- ============================================================

insert into comparisons (slug, tool_a_slug, tool_b_slug, summary, winner) values
('grammarly-vs-jasper', 'grammarly', 'jasper',
 'Grammarly and Jasper are both AI writing tools, but they solve different problems. Grammarly is a writing assistant that improves text you have already written — fixing grammar, adjusting tone, and suggesting clarity improvements across every app you use. Jasper is a content generation platform that creates marketing copy, blog posts, and social content from scratch. Grammarly wins for professionals who want polished, error-free writing. Jasper wins for marketing teams who need to produce high-volume content at speed.',
 null)
ON CONFLICT (slug) DO NOTHING;

insert into comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
select * from (values
  ('grammarly-vs-jasper', 'Grammar & Correctness',  5, 3, 'Grammarly is the gold standard for grammar, style, and clarity correction', 1),
  ('grammarly-vs-jasper', 'Content Generation',     2, 5, 'Jasper is built for long-form content creation from prompts; Grammarly refines, not generates', 2),
  ('grammarly-vs-jasper', 'App Coverage',           5, 3, 'Grammarly works everywhere via browser extension and apps; Jasper requires the Jasper platform', 3),
  ('grammarly-vs-jasper', 'Templates & Formats',   2, 5, 'Jasper has 50+ templates for ads, emails, blog posts, and social content', 4),
  ('grammarly-vs-jasper', 'Brand Voice',            3, 5, 'Jasper Brand Voice learns your tone from samples; Grammarly style guides are more basic', 5),
  ('grammarly-vs-jasper', 'Free Tier',              4, 2, 'Grammarly free is genuinely useful for grammar; Jasper has no meaningful free tier', 6),
  ('grammarly-vs-jasper', 'Pricing',                4, 2, 'Grammarly Pro starts at $12/mo; Jasper starts at $39/mo — significantly more expensive', 7)
) as v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
where exists (select 1 from comparisons where slug = 'grammarly-vs-jasper')
  and not exists (select 1 from comparison_criteria where comparison_slug = 'grammarly-vs-jasper');

-- ============================================================
-- 3. claude-vs-gemini
-- ============================================================

insert into comparisons (slug, tool_a_slug, tool_b_slug, summary, winner) values
('claude-vs-gemini', 'claude', 'gemini',
 'Claude and Gemini are both powerful AI assistants made by AI-first companies — Anthropic and Google respectively. Claude is widely regarded as the best AI for writing, analysis, and following complex instructions, with a 200K token context window ideal for long documents. Gemini is deeply integrated with Google Workspace — Gmail, Docs, Drive, and Meet — making it the natural choice for individuals and teams already in the Google ecosystem. Claude wins for writing-heavy and research-intensive workflows. Gemini wins for teams who live in Google products.',
 null)
ON CONFLICT (slug) DO NOTHING;

insert into comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
select * from (values
  ('claude-vs-gemini', 'Writing Quality',    5, 4, 'Claude produces more nuanced, stylistically rich text; Gemini is competent but less distinctive', 1),
  ('claude-vs-gemini', 'Reasoning',          5, 4, 'Claude excels at multi-step reasoning and following precise, complex instructions', 2),
  ('claude-vs-gemini', 'Context Window',     5, 4, 'Claude has a 200K token window; Gemini 1.5 Pro has 1M but with quality tradeoffs at long range', 3),
  ('claude-vs-gemini', 'Multimodal',         4, 5, 'Gemini natively processes images, video, and audio; Claude handles images well but not video', 4),
  ('claude-vs-gemini', 'Google Ecosystem',   2, 5, 'Gemini is built into Gmail, Docs, Drive, Slides, and Meet; Claude has no native Google integration', 5),
  ('claude-vs-gemini', 'Free Tier',          4, 5, 'Gemini is free and baked into Google products; Claude free tier has usage caps', 6),
  ('claude-vs-gemini', 'Coding',             4, 4, 'Both are strong at code generation; Claude slightly better at instruction-following in complex codebases', 7)
) as v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
where exists (select 1 from comparisons where slug = 'claude-vs-gemini')
  and not exists (select 1 from comparison_criteria where comparison_slug = 'claude-vs-gemini');

-- ============================================================
-- 4. canva-ai-vs-adobe-firefly
-- ============================================================

insert into comparisons (slug, tool_a_slug, tool_b_slug, summary, winner) values
('canva-ai-vs-adobe-firefly', 'canva-ai', 'adobe-firefly',
 'Canva AI and Adobe Firefly are both AI-powered creative tools, but they serve different users. Canva is an all-in-one design platform that uses AI to make professional design accessible to non-designers — templates, social posts, presentations, and video in one place. Adobe Firefly is a generative AI image engine trained on licensed Adobe Stock content, built for professionals who need commercial-safe AI imagery integrated with Photoshop and Illustrator. Canva wins for non-designers who need fast, beautiful content. Firefly wins for professional creatives who need commercial-safe AI output in their existing Adobe workflow.',
 null)
ON CONFLICT (slug) DO NOTHING;

insert into comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
select * from (values
  ('canva-ai-vs-adobe-firefly', 'Ease of Use',             5, 3, 'Canva is famously beginner-friendly; Firefly requires comfort with Adobe products', 1),
  ('canva-ai-vs-adobe-firefly', 'AI Image Quality',        4, 5, 'Firefly produces higher-fidelity, more photorealistic images; Canva AI is good but more stylised', 2),
  ('canva-ai-vs-adobe-firefly', 'Commercial Safety',       4, 5, 'Firefly is trained entirely on licensed Adobe Stock — fully safe for commercial use', 3),
  ('canva-ai-vs-adobe-firefly', 'Template Library',        5, 2, 'Canva has 1M+ templates for every format; Firefly focuses on image generation only', 4),
  ('canva-ai-vs-adobe-firefly', 'Creative Suite Integration', 2, 5, 'Firefly integrates directly with Photoshop, Illustrator, and Creative Cloud', 5),
  ('canva-ai-vs-adobe-firefly', 'Free Tier',               5, 3, 'Canva free is very generous; Firefly free credits run out quickly', 6),
  ('canva-ai-vs-adobe-firefly', 'Pricing',                 4, 3, 'Canva Pro at $15/mo is strong value; Firefly requires a Creative Cloud subscription ($55+/mo)', 7)
) as v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
where exists (select 1 from comparisons where slug = 'canva-ai-vs-adobe-firefly')
  and not exists (select 1 from comparison_criteria where comparison_slug = 'canva-ai-vs-adobe-firefly');

-- ============================================================
-- 5. notion-ai-vs-mem
-- ============================================================

insert into comparisons (slug, tool_a_slug, tool_b_slug, summary, winner) values
('notion-ai-vs-mem', 'notion-ai', 'mem-ai',
 'Notion AI and Mem are both AI-powered note-taking and knowledge management tools, but they come at the problem differently. Notion is a structured workspace platform with an AI assistant added on top — ideal for teams who want databases, wikis, and project management alongside smart writing help. Mem is an AI-first personal knowledge base that automatically organises your notes based on context and surfaces relevant information without manual tagging or folder structures. Notion AI wins for teams who need shared knowledge and structured collaboration. Mem wins for individuals who want an AI that thinks and organises for them.',
 null)
ON CONFLICT (slug) DO NOTHING;

insert into comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
select * from (values
  ('notion-ai-vs-mem', 'Team Collaboration',    5, 2, 'Notion is a full team workspace; Mem is primarily designed for personal use', 1),
  ('notion-ai-vs-mem', 'Auto-Organisation',     2, 5, 'Mem AI automatically links and categorises notes; Notion requires manual structure', 2),
  ('notion-ai-vs-mem', 'Database & Structure',  5, 2, 'Notion databases, views, and relations are best-in-class for structured information', 3),
  ('notion-ai-vs-mem', 'AI Writing Assist',     4, 4, 'Both offer AI writing and summarisation; similar quality and capabilities', 4),
  ('notion-ai-vs-mem', 'Search & Recall',       4, 5, 'Mem surfaces relevant past notes automatically; Notion search requires knowing what to look for', 5),
  ('notion-ai-vs-mem', 'Free Tier',             4, 2, 'Notion free is generous for individuals; Mem free tier is very limited', 6),
  ('notion-ai-vs-mem', 'Pricing',               3, 3, 'Notion AI at $10/seat/mo; Mem at $14.99/mo — comparable, depending on team size', 7)
) as v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
where exists (select 1 from comparisons where slug = 'notion-ai-vs-mem')
  and not exists (select 1 from comparison_criteria where comparison_slug = 'notion-ai-vs-mem');
