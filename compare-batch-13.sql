-- compare-batch-13.sql - 5 new comparison pairs
-- Run AFTER tools-batch-13.sql has been confirmed (taskade, sudowrite, podcastle, castmagic, reflect)
-- Uses ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)

-- 1. taskade-vs-notion-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'taskade-vs-notion-ai', 'taskade', 'notion-ai',
  'Taskade and Notion AI both bring AI to team productivity, but with different foundations. Taskade is an AI-native workspace built around AI agents that can run workflows autonomously. Notion AI is a powerful add-on layered onto Notion''s flexible document and database system. Taskade wins for teams that want AI-driven project automation. Notion AI wins for teams already in Notion who want writing and thinking assistance within their existing workspace.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'taskade-vs-notion-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('taskade-vs-notion-ai', 'AI Capabilities', 5, 4, 'Taskade has autonomous AI agents; Notion AI focuses on writing and summarization', 1),
  ('taskade-vs-notion-ai', 'Task Management', 5, 4, 'Taskade is purpose-built for tasks; Notion tasks are built on a document system', 2),
  ('taskade-vs-notion-ai', 'Databases & Docs', 2, 5, 'Notion''s database and wiki system is far more flexible than Taskade', 3),
  ('taskade-vs-notion-ai', 'Team Collaboration', 5, 4, 'Both support real-time collaboration; Taskade free plan includes unlimited members', 4),
  ('taskade-vs-notion-ai', 'Pricing', 4, 3, 'Taskade free plan is generous; Notion AI costs extra on top of the base plan', 5),
  ('taskade-vs-notion-ai', 'Ease of Use', 4, 4, 'Both have learning curves; Taskade AI features are more discoverable', 6),
  ('taskade-vs-notion-ai', 'Integrations', 3, 5, 'Notion has a larger integration and API ecosystem', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'taskade-vs-notion-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'taskade-vs-notion-ai');

-- 2. sudowrite-vs-jasper
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'sudowrite-vs-jasper', 'sudowrite', 'jasper',
  'Sudowrite and Jasper both use AI for writing but serve completely different purposes. Sudowrite is built specifically for fiction writers - novels, screenplays, and creative storytelling. Jasper is built for marketing and business writing - ads, blog posts, product descriptions, and brand content. Sudowrite wins for novelists and creative writers. Jasper wins for marketing teams and content strategists.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sudowrite-vs-jasper');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('sudowrite-vs-jasper', 'Creative Fiction Writing', 5, 2, 'Sudowrite is purpose-built for narrative; Jasper has limited fiction features', 1),
  ('sudowrite-vs-jasper', 'Marketing Content', 1, 5, 'Jasper dominates for ads, SEO content, and brand voice consistency', 2),
  ('sudowrite-vs-jasper', 'Voice Consistency', 5, 4, 'Sudowrite learns authorial style across a full manuscript', 3),
  ('sudowrite-vs-jasper', 'Templates', 2, 5, 'Jasper has 50+ marketing templates; Sudowrite has narrative-specific tools', 4),
  ('sudowrite-vs-jasper', 'Pricing', 4, 3, 'Sudowrite starts at $19/mo; Jasper starts at $49/mo', 5),
  ('sudowrite-vs-jasper', 'Team Features', 2, 5, 'Jasper has brand voice, team workspaces, and campaign management', 6),
  ('sudowrite-vs-jasper', 'Output Quality (niche)', 5, 5, 'Both excel in their respective domains - comparing is category confusion', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sudowrite-vs-jasper')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sudowrite-vs-jasper');

-- 3. podcastle-vs-riverside
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'podcastle-vs-riverside', 'podcastle', 'riverside',
  'Podcastle and Riverside are both browser-based podcast recording platforms, but they have distinct strengths. Podcastle offers strong AI editing features including filler word removal and audio enhancement. Riverside focuses on high-quality separate audio and video track recording for professional post-production. Podcastle wins for solo podcasters who want automated editing. Riverside wins for interview shows where recording quality and separate tracks matter most.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'podcastle-vs-riverside');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('podcastle-vs-riverside', 'Recording Quality', 4, 5, 'Riverside records separate high-quality tracks per participant locally', 1),
  ('podcastle-vs-riverside', 'AI Editing', 5, 3, 'Podcastle removes filler words and silences automatically', 2),
  ('podcastle-vs-riverside', 'Video Recording', 3, 5, 'Riverside is built for video podcasting with HD studio-quality output', 3),
  ('podcastle-vs-riverside', 'Pricing', 4, 3, 'Podcastle free tier is more generous; Riverside full features cost more', 4),
  ('podcastle-vs-riverside', 'Audio Enhancement', 5, 4, 'Podcastle''s Magic Dust AI audio restoration is a standout feature', 5),
  ('podcastle-vs-riverside', 'Post-Production', 3, 5, 'Riverside separate tracks integrate better with Descript and Adobe Audition', 6),
  ('podcastle-vs-riverside', 'Ease of Use', 5, 4, 'Podcastle is simpler to set up and use for beginners', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'podcastle-vs-riverside')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'podcastle-vs-riverside');

-- 4. castmagic-vs-descript
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'castmagic-vs-descript', 'castmagic', 'descript',
  'Castmagic and Descript both work with audio and video content, but from opposite directions. Castmagic focuses on turning recordings into written content assets - show notes, blog posts, social clips, and newsletters. Descript focuses on editing audio and video by editing the transcript, then exporting polished final media. Castmagic wins for content repurposing and distribution. Descript wins for audio and video editing and production.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'castmagic-vs-descript');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('castmagic-vs-descript', 'Content Repurposing', 5, 3, 'Castmagic generates 10+ content assets per recording automatically', 1),
  ('castmagic-vs-descript', 'Audio/Video Editing', 1, 5, 'Descript''s transcript-based editing is the core product; Castmagic does not edit', 2),
  ('castmagic-vs-descript', 'Transcription Quality', 4, 5, 'Both are accurate; Descript has more speaker identification features', 3),
  ('castmagic-vs-descript', 'Pricing', 3, 4, 'Castmagic is paid-only; Descript has a useful free plan', 4),
  ('castmagic-vs-descript', 'Social Media Output', 5, 3, 'Castmagic generates social posts, newsletters, and clips natively', 5),
  ('castmagic-vs-descript', 'Voice Cloning', 2, 5, 'Descript''s Overdub is best-in-class for correcting recorded speech', 6),
  ('castmagic-vs-descript', 'Workflow Fit', 4, 4, 'Castmagic for publishing workflow; Descript for editing workflow', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'castmagic-vs-descript')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'castmagic-vs-descript');

-- 5. reflect-vs-notebooklm
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'reflect-vs-notebooklm', 'reflect', 'notebooklm',
  'Reflect and NotebookLM both use AI to help you work with information, but they serve different workflows. Reflect is an ongoing personal knowledge management app with backlinks, daily notes, and AI that queries your note archive over time. NotebookLM is Google''s project-based research assistant that answers questions grounded in documents you upload. Reflect wins for daily note-taking and long-term knowledge building. NotebookLM wins for deep research on a defined set of documents.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'reflect-vs-notebooklm');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('reflect-vs-notebooklm', 'Daily Note-Taking', 5, 2, 'Reflect designed for ongoing daily capture; NotebookLM is project-based', 1),
  ('reflect-vs-notebooklm', 'Document Research', 2, 5, 'NotebookLM answers questions grounded in uploaded documents with citations', 2),
  ('reflect-vs-notebooklm', 'AI Integration', 4, 5, 'NotebookLM AI is deeply integrated; Reflect AI is strong but secondary', 3),
  ('reflect-vs-notebooklm', 'Pricing', 3, 5, 'NotebookLM is free; Reflect costs $10/month', 4),
  ('reflect-vs-notebooklm', 'Knowledge Graph', 5, 2, 'Reflect''s backlink system builds connections over time; NotebookLM is document-scoped', 5),
  ('reflect-vs-notebooklm', 'Ease of Use', 4, 5, 'NotebookLM is extremely simple to start; Reflect has more setup', 6),
  ('reflect-vs-notebooklm', 'Long-term Memory', 5, 2, 'Reflect accumulates knowledge over time; NotebookLM resets per project', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'reflect-vs-notebooklm')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'reflect-vs-notebooklm');
