-- compare-batch-21.sql
-- 5 new comparison pairs - all tools confirmed in Supabase DB
-- Pairs verified against compare-batch-2 through compare-batch-20 - no duplicates
-- chatgpt-vs-claude, zapier-vs-make, grammarly-vs-writesonic, ahrefs-vs-semrush, cursor-vs-replit
-- ON CONFLICT (slug) DO NOTHING (idempotent)

-- ============================================================
-- PAIR 1: ChatGPT vs Claude
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'chatgpt-vs-claude',
  'chatgpt',
  'claude',
  'ChatGPT and Claude are the two most widely used AI assistants in 2026, produced by OpenAI and Anthropic respectively. ChatGPT leads on ecosystem breadth - GPTs, plugins, image generation via DALL-E, and deep integration with third-party tools make it the more versatile platform for users who need a broad toolkit in one place. Claude leads on writing quality and reasoning nuance - its output is more polished, it follows complex multi-step instructions more reliably, and it maintains context across longer documents without degradation. For coding, both are capable, though Cursor and other tools built on Claude suggest Anthropic models have an edge on code quality. For research, Perplexity dominates both. The right choice depends on whether you value ecosystem breadth (ChatGPT) or output quality and instruction-following (Claude).',
  NULL,
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('chatgpt-vs-claude', 'Writing Quality', 4, 5, 'Claude produces more polished, natural prose. ChatGPT is capable but can feel formulaic on complex writing tasks.', 1),
  ('chatgpt-vs-claude', 'Coding Assistance', 4, 5, 'Claude edges out on code quality and debugging reasoning. Both are strong; Claude 3.7 Sonnet is a top model for code generation.', 2),
  ('chatgpt-vs-claude', 'Ecosystem and Integrations', 5, 3, 'ChatGPT has GPTs, plugins, DALL-E, and deep third-party integrations. Claude ecosystem is growing but narrower.', 3),
  ('chatgpt-vs-claude', 'Instruction Following', 4, 5, 'Claude is notably more reliable at complex multi-step instructions and maintaining constraints across long conversations.', 4),
  ('chatgpt-vs-claude', 'Context and Document Length', 4, 5, 'Claude 3.7 Sonnet offers a 200K token context window. ChatGPT context is smaller and degrades earlier on very long documents.', 5),
  ('chatgpt-vs-claude', 'Image and Multimodal', 5, 4, 'ChatGPT integrates DALL-E for image generation. Claude reads images well but does not generate them.', 6),
  ('chatgpt-vs-claude', 'Value for Money', 4, 4, 'Both offer capable free tiers. Paid plans are $20/month each. Value depends on use case - no clear winner at parity pricing.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatgpt-vs-claude')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'chatgpt-vs-claude');

-- ============================================================
-- PAIR 2: Zapier vs Make
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'zapier-vs-make',
  'zapier',
  'make',
  'Zapier and Make (formerly Integromat) are the two dominant no-code automation platforms, serving different ends of the complexity spectrum. Zapier is the easier option: its linear Zap builder, 6,000+ app integrations, and AI-powered Zap creation make it the fastest way to automate simple to moderate workflows without any technical background. Make is the more powerful option: its visual scenario builder with branching logic, data transformation, and error handling supports complex automations that Zapier struggles to express cleanly. Zapier costs significantly more per task at scale; Make''s pricing by operations rather than tasks is more economical for high-volume automations. The decision usually comes down to technical comfort and workflow complexity - Zapier for non-technical teams automating standard business processes, Make for technical teams or anyone building complex conditional logic, data pipelines, or integrations with custom APIs.',
  NULL,
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('zapier-vs-make', 'Ease of Use', 5, 3, 'Zapier''s linear Zap builder is the easiest automation interface available. Make''s visual canvas is powerful but has a steeper learning curve.', 1),
  ('zapier-vs-make', 'Automation Complexity', 3, 5, 'Make handles branching logic, data transformation, and error routing that Zapier cannot express cleanly. Zapier suits linear workflows.', 2),
  ('zapier-vs-make', 'App Integrations', 5, 4, 'Zapier connects to 6,000+ apps. Make has 1,000+ integrations, fewer but sufficient for most use cases.', 3),
  ('zapier-vs-make', 'Pricing Value', 3, 5, 'Make charges per operation and is significantly cheaper at scale. Zapier''s per-task pricing adds up quickly for high-volume workflows.', 4),
  ('zapier-vs-make', 'AI Features', 4, 4, 'Zapier AI creates Zaps from plain English. Make has AI components for processing but less integrated AI workflow creation.', 5),
  ('zapier-vs-make', 'Error Handling', 3, 5, 'Make has sophisticated error handling routes and retry logic. Zapier error handling is simpler and less configurable.', 6),
  ('zapier-vs-make', 'Team Collaboration', 4, 4, 'Both support team workspaces and sharing. Zapier Teams is slightly more polished; Make has strong folder and team management.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zapier-vs-make')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zapier-vs-make');

-- ============================================================
-- PAIR 3: Grammarly vs Writesonic
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'grammarly-vs-writesonic',
  'grammarly',
  'writesonic',
  'Grammarly and Writesonic serve adjacent but distinct writing needs. Grammarly is fundamentally an editing and proofreading tool - it improves content you have already written, catching grammar issues, tone mismatches, clarity problems, and now offering AI rewrites within its editing interface. Writesonic is a content generation tool - it creates first drafts from prompts, generates SEO-optimised blog posts, rewrites for different audiences, and outputs marketing copy at scale. The comparison is less head-to-head and more sequential: many writers use Writesonic to generate a draft and Grammarly to edit it. Where they compete directly is in AI writing assistance: Grammarly''s generative features are more restrained and editorial; Writesonic''s generation is higher volume but requires more editing. For teams that primarily need editing and consistency checking, Grammarly wins. For teams that need volume content generation with SEO optimisation, Writesonic wins.',
  'grammarly',
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('grammarly-vs-writesonic', 'Writing Quality', 5, 3, 'Grammarly produces cleaner, more natural edits. Writesonic drafts are functional but typically require significant editing.', 1),
  ('grammarly-vs-writesonic', 'Grammar and Editing', 5, 2, 'Grammarly is the category leader for grammar checking, tone analysis, and clarity suggestions. Writesonic''s editing is basic.', 2),
  ('grammarly-vs-writesonic', 'Content Generation Volume', 3, 5, 'Writesonic generates long-form content, landing pages, and campaigns at scale. Grammarly''s generation is limited to shorter rewrites.', 3),
  ('grammarly-vs-writesonic', 'SEO Features', 2, 5, 'Writesonic includes keyword integration, SEO scoring, and Chatsonic for research-backed content. Grammarly has no SEO features.', 4),
  ('grammarly-vs-writesonic', 'Ease of Use', 5, 4, 'Grammarly installs as a browser extension and works everywhere. Writesonic requires opening a separate platform for each generation.', 5),
  ('grammarly-vs-writesonic', 'Brand and Tone Consistency', 5, 3, 'Grammarly''s Style Guide (Business) enforces brand voice across teams. Writesonic tone settings are less sophisticated.', 6),
  ('grammarly-vs-writesonic', 'Pricing Value', 4, 4, 'Grammarly Premium at $12/month for editing. Writesonic from $20/month for generation. Both reasonable for their primary use case.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'grammarly-vs-writesonic')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'grammarly-vs-writesonic');

-- ============================================================
-- PAIR 4: Ahrefs vs Semrush
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'ahrefs-vs-semrush',
  'ahrefs',
  'semrush',
  'Ahrefs and Semrush are the two dominant professional SEO platforms, and the comparison between them comes up in virtually every SEO team''s tool evaluation. Ahrefs has the stronger backlink database and link analysis features - for link building campaigns, competitive backlink research, and understanding domain authority, Ahrefs data is generally considered more accurate and comprehensive. Semrush has the broader feature set - its Position Tracking, site audit, local SEO, social media, advertising research, and content marketing tools cover more of the marketing stack beyond pure SEO. Pricing is comparable at the Lite/Pro tier. Teams that are primarily doing SEO and link building tend to prefer Ahrefs. Teams that need an all-in-one marketing intelligence platform often choose Semrush for its broader scope. Both have strong keyword research, site audit, and competitor analysis tools - the difference is primarily in depth of backlink data versus breadth of marketing features.',
  NULL,
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('ahrefs-vs-semrush', 'Backlink Database', 5, 4, 'Ahrefs has the largest backlink index and is generally considered more accurate for link analysis. Semrush backlinks are comprehensive but smaller.', 1),
  ('ahrefs-vs-semrush', 'Keyword Research', 5, 5, 'Both are excellent for keyword research with large databases and difficulty scoring. Semrush keyword data is slightly broader; Ahrefs depth metrics are more reliable.', 2),
  ('ahrefs-vs-semrush', 'Site Audit', 4, 5, 'Semrush Site Audit is widely considered more comprehensive and actionable. Ahrefs Site Audit covers the essentials well.', 3),
  ('ahrefs-vs-semrush', 'Competitor Analysis', 5, 5, 'Both excel at competitor research. Semrush includes advertising and social data; Ahrefs focuses on organic search intelligence.', 4),
  ('ahrefs-vs-semrush', 'Content Marketing Tools', 3, 5, 'Semrush has a full content marketing toolkit including the SEO Writing Assistant. Ahrefs content tools are more limited to content gap analysis.', 5),
  ('ahrefs-vs-semrush', 'Ease of Use', 5, 4, 'Ahrefs interface is cleaner and faster to navigate for focused SEO tasks. Semrush''s broader feature set makes the interface more complex.', 6),
  ('ahrefs-vs-semrush', 'Pricing Value', 4, 4, 'Both start around $99-129/month at entry level. Ahrefs pricing is more straightforward; Semrush has more add-on costs for premium features.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ahrefs-vs-semrush')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'ahrefs-vs-semrush');

-- ============================================================
-- PAIR 5: Cursor vs Replit
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'cursor-vs-replit',
  'cursor',
  'replit',
  'Cursor and Replit both use AI to accelerate software development, but they target different workflows and developer experience levels. Cursor is a VS Code fork for professional developers who want AI deeply integrated into their existing local development workflow - it keeps all your VS Code extensions, settings, and keybindings while adding powerful AI editing, codebase-aware chat, and Composer for autonomous multi-file changes. Replit is a browser-based IDE targeting beginners, students, and developers who want zero setup - it runs in the browser, deploys with one click, and has an AI coding assistant that can build entire applications from prompts. Professional developers almost always choose Cursor for serious work; beginners, students, and anyone who needs to code without a local setup will find Replit more accessible. The two tools rarely compete for the same user in practice.',
  NULL,
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('cursor-vs-replit', 'AI Code Generation', 5, 4, 'Cursor''s Composer handles complex multi-file changes with codebase context. Replit AI is strong for full app generation from prompts.', 1),
  ('cursor-vs-replit', 'Setup and Accessibility', 2, 5, 'Replit requires no installation - runs entirely in the browser. Cursor requires local installation and setup of development environment.', 2),
  ('cursor-vs-replit', 'Professional Development', 5, 3, 'Cursor retains full VS Code extension ecosystem and local development workflow. Replit is constrained by browser environment limitations.', 3),
  ('cursor-vs-replit', 'Collaboration', 3, 5, 'Replit has multiplayer collaboration and public project sharing built in. Cursor collaboration requires external git workflows.', 4),
  ('cursor-vs-replit', 'Deployment', 3, 5, 'Replit deploys apps with one click from the IDE. Cursor requires separate deployment setup through Vercel, Railway, or cloud providers.', 5),
  ('cursor-vs-replit', 'Language and Framework Support', 5, 4, 'Cursor supports any language and framework through VS Code ecosystem. Replit supports many languages but some advanced setups require workarounds.', 6),
  ('cursor-vs-replit', 'Pricing Value', 4, 4, 'Cursor Pro at $20/month for professionals. Replit Core at $25/month. Both offer free tiers. Cursor better value for professionals; Replit better for learners.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'cursor-vs-replit')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cursor-vs-replit');
