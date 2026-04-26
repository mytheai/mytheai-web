-- compare-batch-10.sql
-- 5 new comparison pairs
-- Safe to re-run (ON CONFLICT DO NOTHING + NOT EXISTS guard)

-- 1. motion-vs-reclaim-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'motion-vs-reclaim-ai', 'motion', 'reclaim-ai',
  'Motion and Reclaim.ai are both AI scheduling tools that optimise how work gets onto your calendar — but they approach the problem differently. Motion auto-schedules all your tasks into time blocks each morning using AI prioritisation, creating a fully planned day automatically. Reclaim.ai focuses on syncing tasks from existing project management tools and protecting time for habits and focus blocks within a busier schedule. Motion wins for individuals who want full AI-driven time blocking; Reclaim wins for teams who need scheduling to work alongside their existing task systems.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'motion-vs-reclaim-ai')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('motion-vs-reclaim-ai', 'AI Task Scheduling',         5, 4, 'Motion''s daily auto-scheduling creates a complete planned day; Reclaim is more rule-based', 1),
  ('motion-vs-reclaim-ai', 'Project Management Integration', 3, 5, 'Reclaim syncs with Asana, Linear, Jira, and ClickUp; Motion has its own built-in task system', 2),
  ('motion-vs-reclaim-ai', 'Habit & Focus Blocks',       3, 5, 'Reclaim''s habit blocking and focus time protection are core features', 3),
  ('motion-vs-reclaim-ai', 'Team Scheduling',            4, 4, 'Both support team coordination; Motion adds project timeline views for teams', 4),
  ('motion-vs-reclaim-ai', 'Calendar Sync',              4, 5, 'Reclaim supports multi-calendar sync across Google and Outlook accounts', 5),
  ('motion-vs-reclaim-ai', 'Free Plan',                  1, 4, 'Reclaim has a functional free plan; Motion requires a paid subscription', 6),
  ('motion-vs-reclaim-ai', 'Learning Curve',             3, 4, 'Motion requires trusting AI to plan your day; Reclaim''s rule-based system is more predictable', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'motion-vs-reclaim-ai'
);

-- 2. clay-vs-apollo
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'clay-vs-apollo', 'clay', 'apollo',
  'Clay and Apollo are both sales intelligence platforms, but they serve different buyer profiles. Clay is a data enrichment powerhouse — it pulls from 75+ sources simultaneously to build the richest possible prospect profiles, then uses AI to write hyper-personalised outreach. Apollo is a more complete sales platform: it combines a large contact database (275M+ records) with email sequencing, CRM sync, and workflow automation. Clay wins for enrichment depth and personalisation quality; Apollo wins for teams who want an all-in-one prospecting and outreach platform.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'clay-vs-apollo')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('clay-vs-apollo', 'Contact Data Enrichment',  5, 4, 'Clay''s waterfall enrichment from 75+ sources produces richer profiles than Apollo''s single database', 1),
  ('clay-vs-apollo', 'Contact Database Size',    2, 5, 'Apollo has 275M+ verified contacts; Clay relies on third-party sources rather than its own database', 2),
  ('clay-vs-apollo', 'Email Sequencing',         2, 5, 'Apollo includes full sequencing and automation; Clay focuses on enrichment, not outreach execution', 3),
  ('clay-vs-apollo', 'AI Personalisation',       5, 4, 'Clay''s AI research and message writing is the most sophisticated in the market', 4),
  ('clay-vs-apollo', 'CRM Integration',          4, 5, 'Apollo''s native HubSpot and Salesforce sync is tighter; Clay requires more setup', 5),
  ('clay-vs-apollo', 'Ease of Use',              2, 4, 'Apollo is far more accessible; Clay has a steep learning curve for non-technical users', 6),
  ('clay-vs-apollo', 'Free Plan',                3, 4, 'Apollo''s free plan is more generous; Clay offers limited free credits', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clay-vs-apollo'
);

-- 3. veed-io-vs-submagic
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'veed-io-vs-submagic', 'veed-io', 'submagic',
  'VEED.io and Submagic are both browser-based AI video editing tools, but they target different workflows. VEED.io is a full-featured online editor with a broad toolset — subtitles, translations, screen recording, AI avatars, and brand kit management. Submagic is purpose-built for short-form viral video: it adds animated captions, trending sound effects, descriptions, and viral hooks automatically, optimised specifically for TikTok and Reels. VEED.io wins for breadth and team use; Submagic wins for creators focused purely on short-form content performance.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'veed-io-vs-submagic')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('veed-io-vs-submagic', 'Short-form Optimisation',  3, 5, 'Submagic is purpose-built for viral short-form; VEED is general-purpose', 1),
  ('veed-io-vs-submagic', 'Caption Quality',          4, 5, 'Submagic''s animated, styled captions are optimised for viewer retention on social feeds', 2),
  ('veed-io-vs-submagic', 'Feature Breadth',          5, 2, 'VEED includes translation, screen recording, avatars, brand kits — Submagic is caption-focused', 3),
  ('veed-io-vs-submagic', 'AI Features',              4, 4, 'Both use AI for captions; VEED adds AI avatars and dubbing; Submagic adds viral hook generation', 4),
  ('veed-io-vs-submagic', 'Team Collaboration',       5, 2, 'VEED has brand kit and team features; Submagic is primarily for individual creators', 5),
  ('veed-io-vs-submagic', 'Free Plan',                4, 3, 'VEED''s free plan covers basic editing; Submagic''s free tier is limited to a few videos per month', 6),
  ('veed-io-vs-submagic', 'Ease of Use',              4, 5, 'Submagic''s single-purpose interface is extremely fast to use for its target workflow', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'veed-io-vs-submagic'
);

-- 4. codeium-vs-github-copilot
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'codeium-vs-github-copilot', 'codeium', 'github-copilot',
  'Codeium and GitHub Copilot are the two most widely used AI coding assistants — and the central question is whether the free option is good enough. Codeium is completely free for individuals, supports 70+ programming languages across 40+ IDEs, and delivers strong autocomplete performance. GitHub Copilot costs $10/month but offers deeper context understanding, better multi-file awareness, and tighter GitHub integration. Codeium wins on value; Copilot wins on capability for professional developers.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'codeium-vs-github-copilot')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('codeium-vs-github-copilot', 'Free Plan',               5, 2, 'Codeium is completely free for individual developers; Copilot requires $10/month (free for students)', 1),
  ('codeium-vs-github-copilot', 'Code Completion Quality', 4, 5, 'Copilot''s multi-line completions and context awareness are more consistent', 2),
  ('codeium-vs-github-copilot', 'IDE Support',             5, 4, 'Codeium supports 40+ IDEs including JetBrains, Vim, and Emacs; Copilot focuses on VS Code and JetBrains', 3),
  ('codeium-vs-github-copilot', 'Language Support',        5, 5, 'Both support 70+ programming languages with strong performance on popular stacks', 4),
  ('codeium-vs-github-copilot', 'AI Chat Features',        4, 5, 'Copilot Chat has deeper codebase context; Codeium Chat is functional but less contextually aware', 5),
  ('codeium-vs-github-copilot', 'GitHub Integration',      1, 5, 'Copilot is built into GitHub for PR reviews, issue resolution, and Actions; Codeium has no GitHub features', 6),
  ('codeium-vs-github-copilot', 'Enterprise Features',     3, 5, 'Copilot Enterprise offers codebase-wide context indexing; Codeium Teams is more limited', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'codeium-vs-github-copilot'
);

-- 5. pictory-vs-invideo-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'pictory-vs-invideo-ai', 'pictory', 'invideo-ai',
  'Pictory and InVideo AI are both text-to-video platforms for marketers and content creators who want to turn written content into polished videos without editing skills. Pictory specialises in converting long-form content — blog posts, scripts, webinars — into shorter summary videos using stock footage and AI voiceover. InVideo AI is more generative: describe the video you want in a prompt and it builds a complete video with scenes, voiceover, and music. Pictory wins for repurposing existing written content; InVideo AI wins for creating original videos from scratch.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pictory-vs-invideo-ai')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('pictory-vs-invideo-ai', 'Text-to-Video from Prompts', 3, 5, 'InVideo AI generates complete original videos from a text description; Pictory needs source content', 1),
  ('pictory-vs-invideo-ai', 'Blog/Article Repurposing',   5, 3, 'Pictory''s core use case is turning blog posts and scripts into shareable video summaries', 2),
  ('pictory-vs-invideo-ai', 'Stock Media Library',        4, 5, 'InVideo has the larger stock footage and audio library for building original videos', 3),
  ('pictory-vs-invideo-ai', 'AI Voiceover',               4, 4, 'Both offer realistic AI voiceovers in multiple languages and voices', 4),
  ('pictory-vs-invideo-ai', 'Ease of Use',                4, 5, 'InVideo AI''s prompt-based interface is the simplest entry point in the category', 5),
  ('pictory-vs-invideo-ai', 'Free Plan',                  3, 4, 'InVideo offers more free video exports per month; Pictory''s free tier is more limited', 6),
  ('pictory-vs-invideo-ai', 'Output Quality',             4, 4, 'Both produce similar quality stock-based videos; quality depends on content and prompt specificity', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'pictory-vs-invideo-ai'
);
