-- compare-batch-12.sql - 5 new comparison pairs
-- Run AFTER tools-batch-12.sql has been confirmed (warp, recraft-ai, instantly-ai, avoma, tana)
-- Uses ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)

-- 1. warp-vs-github-copilot
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'warp-vs-github-copilot', 'warp', 'github-copilot',
  'Warp and GitHub Copilot both bring AI to the developer workflow, but in different ways. Warp is an AI-native terminal that replaces your command line, while GitHub Copilot is an IDE plugin that autocompletes code. Warp wins for terminal power users who live in the command line. Copilot wins for developers who want AI assistance inside their code editor.',
  'github-copilot', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'warp-vs-github-copilot');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('warp-vs-github-copilot', 'Core Use Case', 4, 5, 'Warp excels as an AI terminal; Copilot is broader for any coding language', 1),
  ('warp-vs-github-copilot', 'AI Quality', 4, 5, 'Copilot uses Claude and GPT-4; Warp AI is strong for command suggestions', 2),
  ('warp-vs-github-copilot', 'IDE Integration', 2, 5, 'Warp is terminal-only; Copilot integrates with VS Code, JetBrains, Neovim', 3),
  ('warp-vs-github-copilot', 'Pricing', 4, 3, 'Warp free tier is generous; Copilot starts at $10/mo', 4),
  ('warp-vs-github-copilot', 'Ease of Use', 5, 4, 'Warp has intuitive UI; Copilot requires manual prompt discipline', 5),
  ('warp-vs-github-copilot', 'Platform Support', 3, 5, 'Warp is Mac/Linux only; Copilot works everywhere', 6),
  ('warp-vs-github-copilot', 'Team Features', 3, 4, 'Both offer team plans; Copilot has enterprise GitHub integration', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'warp-vs-github-copilot')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'warp-vs-github-copilot');

-- 2. recraft-ai-vs-ideogram
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'recraft-ai-vs-ideogram', 'recraft-ai', 'ideogram',
  'Recraft AI and Ideogram are both AI image generators with strong text rendering, but they serve different design needs. Recraft specializes in vector graphics, brand assets, and design-system-ready outputs. Ideogram excels at photorealistic images and creative artwork with reliable text in images. Recraft wins for designers and brand teams; Ideogram wins for content creators and marketers.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'recraft-ai-vs-ideogram');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('recraft-ai-vs-ideogram', 'Image Quality', 4, 5, 'Ideogram produces more photorealistic and artistic outputs', 1),
  ('recraft-ai-vs-ideogram', 'Text in Images', 5, 5, 'Both are industry-leading for accurate text rendering in images', 2),
  ('recraft-ai-vs-ideogram', 'Vector & SVG Output', 5, 1, 'Recraft uniquely supports vector and SVG export; Ideogram does not', 3),
  ('recraft-ai-vs-ideogram', 'Brand Asset Creation', 5, 3, 'Recraft built for logos, icons, and design systems', 4),
  ('recraft-ai-vs-ideogram', 'Pricing', 4, 4, 'Both offer free tiers with paid credits; similar value', 5),
  ('recraft-ai-vs-ideogram', 'Ease of Use', 4, 5, 'Ideogram has simpler prompt interface; Recraft has more design controls', 6),
  ('recraft-ai-vs-ideogram', 'Style Variety', 3, 5, 'Ideogram supports more artistic styles and aesthetics', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'recraft-ai-vs-ideogram')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'recraft-ai-vs-ideogram');

-- 3. instantly-ai-vs-apollo
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'instantly-ai-vs-apollo', 'instantly-ai', 'apollo',
  'Instantly AI and Apollo are both outbound sales platforms but with different strengths. Instantly specializes in cold email sending infrastructure with high deliverability, unlimited sending accounts, and AI-generated sequences. Apollo is a full sales intelligence platform with a massive B2B database, prospecting tools, and CRM features. Instantly wins for cold email volume; Apollo wins as an all-in-one prospecting and engagement platform.',
  'apollo', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'instantly-ai-vs-apollo');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('instantly-ai-vs-apollo', 'Contact Database', 2, 5, 'Apollo has 275M+ verified B2B contacts; Instantly has none built-in', 1),
  ('instantly-ai-vs-apollo', 'Email Deliverability', 5, 4, 'Instantly built for inbox placement with unlimited sending accounts', 2),
  ('instantly-ai-vs-apollo', 'AI Personalization', 4, 4, 'Both generate personalized email sequences with AI', 3),
  ('instantly-ai-vs-apollo', 'Pricing', 4, 3, 'Instantly starts cheaper; Apollo scales better with contact data included', 4),
  ('instantly-ai-vs-apollo', 'CRM Features', 2, 4, 'Apollo has built-in CRM and pipeline; Instantly integrates with others', 5),
  ('instantly-ai-vs-apollo', 'Analytics', 4, 4, 'Both have strong campaign and sequence analytics', 6),
  ('instantly-ai-vs-apollo', 'Ease of Use', 5, 4, 'Instantly is simpler to set up; Apollo requires more configuration', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'instantly-ai-vs-apollo')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'instantly-ai-vs-apollo');

-- 4. avoma-vs-otter-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'avoma-vs-otter-ai', 'avoma', 'otter-ai',
  'Avoma and Otter.ai both transcribe and analyze meetings, but target different users. Avoma is a full meeting intelligence platform for sales and customer success teams, with CRM sync, deal tracking, and coaching features. Otter.ai is a broader transcription tool suited for general note-taking, lectures, and business meetings. Avoma wins for revenue teams; Otter.ai wins for general transcription at lower cost.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'avoma-vs-otter-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('avoma-vs-otter-ai', 'Transcription Accuracy', 5, 4, 'Both are excellent; Avoma slightly better with sales jargon', 1),
  ('avoma-vs-otter-ai', 'AI Meeting Summary', 5, 4, 'Avoma generates structured summaries with action items and topics', 2),
  ('avoma-vs-otter-ai', 'CRM Integration', 5, 2, 'Avoma syncs with Salesforce, HubSpot, Pipedrive natively', 3),
  ('avoma-vs-otter-ai', 'Pricing', 3, 5, 'Otter.ai is significantly cheaper with a generous free plan', 4),
  ('avoma-vs-otter-ai', 'Sales Coaching', 5, 1, 'Avoma has call scoring, coaching templates, and rep analytics', 5),
  ('avoma-vs-otter-ai', 'General Use Cases', 3, 5, 'Otter.ai works great for lectures, interviews, podcasts', 6),
  ('avoma-vs-otter-ai', 'Ease of Setup', 4, 5, 'Otter.ai connects in minutes; Avoma requires CRM configuration', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'avoma-vs-otter-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'avoma-vs-otter-ai');

-- 5. tana-vs-notebooklm
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'tana-vs-notebooklm', 'tana', 'notebooklm',
  'Tana and NotebookLM both aim to help you think and research more effectively, but take very different approaches. Tana is a structured knowledge graph with supertags, custom fields, and powerful outlining. NotebookLM is Google''s AI research assistant that answers questions grounded in your uploaded documents. Tana wins for knowledge management power users; NotebookLM wins for research and document analysis.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'tana-vs-notebooklm');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('tana-vs-notebooklm', 'Research & Q&A', 3, 5, 'NotebookLM answers questions grounded in your documents with citations', 1),
  ('tana-vs-notebooklm', 'Knowledge Structure', 5, 2, 'Tana''s supertags and fields create a powerful structured knowledge graph', 2),
  ('tana-vs-notebooklm', 'Ease of Use', 2, 5, 'NotebookLM is extremely simple; Tana has a steep learning curve', 3),
  ('tana-vs-notebooklm', 'Pricing', 3, 5, 'NotebookLM is free; Tana is paid', 4),
  ('tana-vs-notebooklm', 'Document Analysis', 2, 5, 'NotebookLM excels at analyzing PDFs, docs, and YouTube videos', 5),
  ('tana-vs-notebooklm', 'Daily Note-Taking', 5, 2, 'Tana designed for ongoing structured note-taking; NotebookLM is project-based', 6),
  ('tana-vs-notebooklm', 'AI Integration', 4, 5, 'NotebookLM AI is deeply integrated; Tana AI is a newer addition', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'tana-vs-notebooklm')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'tana-vs-notebooklm');
