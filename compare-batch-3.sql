-- compare-batch-3.sql
-- 5 new comparison pairs: high search-volume candidates
-- Pattern: ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent, safe to re-run)
-- Run in Supabase SQL Editor

-- 1. ChatGPT vs Gemini
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'chatgpt-vs-gemini', 'chatgpt', 'gemini',
  'ChatGPT and Gemini are the two most widely used AI assistants in 2026. ChatGPT leads on plugin ecosystem, image generation, and developer integrations. Gemini leads on real-time web search, Google Workspace integration, and the longest context window (1M tokens on Pro). For most professionals, the choice comes down to ecosystem: Google or OpenAI.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatgpt-vs-gemini')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('chatgpt-vs-gemini', 'Writing Quality',       4, 4, 'Both produce high-quality prose. ChatGPT slightly more versatile across tones; Gemini cleaner for structured formats.', 1),
  ('chatgpt-vs-gemini', 'Real-Time Web Search',  3, 5, 'Gemini has native Google Search integration. ChatGPT Browse is functional but less deeply integrated.', 2),
  ('chatgpt-vs-gemini', 'Context Window',        4, 5, 'ChatGPT: 128K tokens. Gemini Pro: 1M tokens — decisive advantage for very long documents.', 3),
  ('chatgpt-vs-gemini', 'Image Generation',      5, 3, 'ChatGPT includes DALL-E 3. Gemini''s image generation is more restricted on the standard plan.', 4),
  ('chatgpt-vs-gemini', 'Coding Ability',        4, 4, 'Both competitive. ChatGPT edges ahead on complex reasoning; Gemini strong for large-codebase analysis.', 5),
  ('chatgpt-vs-gemini', 'Ecosystem & Plugins',   5, 3, 'ChatGPT has hundreds of integrations and a mature plugin store. Gemini integrates with Google Workspace.', 6),
  ('chatgpt-vs-gemini', 'Pricing',               4, 4, 'ChatGPT Plus: $20/mo. Gemini Advanced: $19.99/mo. Essentially equal at the individual tier.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatgpt-vs-gemini')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'chatgpt-vs-gemini');

-- 2. Asana vs Monday
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'asana-vs-monday', 'asana', 'monday',
  'Asana and Monday.com are the two most popular project management platforms for mid-size teams. Asana is more structured and task-focused, preferred by project managers running cross-functional work. Monday is more visual and flexible, preferred by teams who want highly customised workflows and a spreadsheet-like experience. Both have strong AI features added in 2025.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'asana-vs-monday')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('asana-vs-monday', 'Ease of Setup',          3, 5, 'Monday is faster to set up with highly visual templates. Asana requires more configuration for complex workflows.', 1),
  ('asana-vs-monday', 'Task Management',        5, 4, 'Asana has more granular task controls, dependencies, and milestone tracking built in.', 2),
  ('asana-vs-monday', 'Customisation',          3, 5, 'Monday is highly flexible with custom columns, formulas, and board layouts. Asana is more opinionated.', 3),
  ('asana-vs-monday', 'Reporting & Dashboards', 4, 4, 'Both offer strong portfolio views and dashboards. Monday''s are more visual; Asana''s are more data-dense.', 4),
  ('asana-vs-monday', 'Integrations',           5, 4, 'Both integrate with Slack, Jira, and Google Workspace. Asana has a slightly larger integration library.', 5),
  ('asana-vs-monday', 'AI Features',            4, 4, 'Both added AI task drafting and smart suggestions in 2025. Roughly equivalent at current release.', 6),
  ('asana-vs-monday', 'Pricing',                3, 4, 'Monday free plan supports unlimited boards. Asana free plan limited to 15 users with basic features.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'asana-vs-monday')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'asana-vs-monday');

-- 3. ClickUp vs Asana
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'clickup-vs-asana', 'clickup', 'asana',
  'ClickUp positions itself as the all-in-one productivity platform with docs, goals, whiteboards, and time tracking alongside project management. Asana is more focused and polished for pure project and task management. ClickUp offers more features at a lower price point, but Asana is less overwhelming for teams that do not need everything.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'clickup-vs-asana')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('clickup-vs-asana', 'Feature Breadth',       5, 3, 'ClickUp includes docs, whiteboards, goals, time tracking, and email. Asana focuses on tasks and projects.', 1),
  ('clickup-vs-asana', 'Ease of Use',           3, 5, 'Asana is significantly more polished and easier to learn. ClickUp''s breadth creates a steeper learning curve.', 2),
  ('clickup-vs-asana', 'Task Management',       4, 5, 'Both are strong. Asana''s task hierarchy and dependencies are more refined for complex project management.', 3),
  ('clickup-vs-asana', 'Customisation',         5, 3, 'ClickUp offers extensive custom fields, views, and automations. Asana is more structured with less flexibility.', 4),
  ('clickup-vs-asana', 'Free Plan',             5, 3, 'ClickUp''s free plan is one of the most generous available. Asana free is limited to 15 users and basic views.', 5),
  ('clickup-vs-asana', 'Reliability',           3, 5, 'Asana has a strong track record for stability. ClickUp has historically had more performance issues at scale.', 6),
  ('clickup-vs-asana', 'Pricing',               5, 3, 'ClickUp Unlimited at $7/user/mo. Asana Starter at $10.99/user/mo. ClickUp is meaningfully cheaper.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'clickup-vs-asana')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clickup-vs-asana');

-- 4. Zoom vs Google Meet
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'zoom-vs-google-meet', 'zoom', 'google-meet',
  'Zoom and Google Meet are the two dominant video conferencing platforms in 2026. Zoom leads on features, recording quality, and webinar capabilities. Google Meet leads on simplicity, Google Workspace integration, and the fact that it requires no download for participants. The right choice depends almost entirely on which ecosystem your team already lives in.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zoom-vs-google-meet')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('zoom-vs-google-meet', 'Video Quality',          5, 4, 'Zoom offers more resolution options and consistently strong quality. Meet is reliable but slightly behind at high participant counts.', 1),
  ('zoom-vs-google-meet', 'Ease of Joining',        3, 5, 'Google Meet requires no download — join from a browser link in one click. Zoom still prompts for the desktop app.', 2),
  ('zoom-vs-google-meet', 'Google Workspace Sync',  2, 5, 'Meet is native to Google Calendar and Gmail. Zoom requires a third-party integration to achieve the same flow.', 3),
  ('zoom-vs-google-meet', 'Webinars & Large Events',5, 3, 'Zoom Webinars is an industry standard for large virtual events. Meet is best for internal meetings under 500 people.', 4),
  ('zoom-vs-google-meet', 'Recording & Transcripts',5, 4, 'Both offer cloud recording and auto-transcription. Zoom''s recording management is more mature.', 5),
  ('zoom-vs-google-meet', 'AI Features',            4, 4, 'Zoom AI Companion and Google Meet AI notes both summarise meetings and generate action items in 2025.', 6),
  ('zoom-vs-google-meet', 'Pricing',                3, 5, 'Google Meet is included with Google Workspace. Zoom Pro at $13.33/mo adds paid cost for comparable core features.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zoom-vs-google-meet')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zoom-vs-google-meet');

-- 5. Slack vs Microsoft Teams
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'slack-vs-teams', 'slack', 'microsoft-teams',
  'Slack and Microsoft Teams are the two dominant workplace communication platforms. Slack is more beloved by developers and tech-forward companies for its interface, integrations, and developer culture. Teams is deeply embedded in Microsoft 365 and often the default choice for enterprises already using Office. The decision is usually driven by which productivity suite an organisation already pays for.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'slack-vs-teams')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('slack-vs-teams', 'User Experience',         5, 3, 'Slack is widely considered the better-designed product. Teams is functional but feels heavier and more complex.', 1),
  ('slack-vs-teams', 'Microsoft 365 Integration',2, 5, 'Teams is native to Word, Excel, SharePoint, and OneDrive. Slack''s Office integrations are third-party.', 2),
  ('slack-vs-teams', 'Developer Integrations',  5, 3, 'Slack has a richer app directory with thousands of integrations. Teams has improved but lags in breadth.', 3),
  ('slack-vs-teams', 'Video Calls',             3, 5, 'Teams has a more mature video calling experience built in. Slack Huddles are lightweight but less featured.', 4),
  ('slack-vs-teams', 'Search & History',        4, 4, 'Both offer message search. Slack''s search is faster and more intuitive; Teams indexes SharePoint content too.', 5),
  ('slack-vs-teams', 'AI Features',             4, 4, 'Slack AI and Microsoft Copilot in Teams both summarise threads and answer questions. Roughly equivalent in 2025.', 6),
  ('slack-vs-teams', 'Pricing',                 3, 4, 'Teams is included in most Microsoft 365 plans. Slack Pro at $7.25/user/mo is an additional cost for similar features.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'slack-vs-teams')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'slack-vs-teams');
