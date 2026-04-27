-- compare-batch-18.sql
-- 5 new comparison pairs using tools already in DB
-- ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)

-- 1. suno-vs-udio: AI song generation head-to-head
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'suno-vs-udio', 'suno', 'udio',
  'Suno and Udio are the two leading AI full-song generators in 2026, both capable of producing complete tracks with vocals and instrumentation from a text prompt. Suno is more accessible, with a generous free tier and a simpler prompt interface that makes it the natural starting point for new users. Udio produces output that is often considered higher quality by musicians and audio professionals, with better genre coherence and more natural vocal delivery - but at a higher cost of entry. For casual creators who want to generate songs quickly and cheaply, Suno is the better choice. For creators where audio quality is the priority, Udio is worth the additional investment.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'suno-vs-udio');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('suno-vs-udio', 'Vocal Quality', 4, 5, 'Udio''s vocal synthesis is generally considered more natural and expressive. Suno vocals are strong but occasionally sound more synthetic on complex arrangements.', 1),
  ('suno-vs-udio', 'Genre Range', 5, 5, 'Both tools cover a wide range of genres from classical to hip-hop. Neither has a clear advantage in genre versatility.', 2),
  ('suno-vs-udio', 'Free Tier', 5, 4, 'Suno offers a more generous free tier with daily credits. Udio free tier is available but more limited in generation count.', 3),
  ('suno-vs-udio', 'Ease of Use', 5, 4, 'Suno has a simpler prompt interface. Udio gives more control over style parameters but requires more input to get the best results.', 4),
  ('suno-vs-udio', 'Commercial License', 3, 3, 'Both require paid plans for commercial use. Neither offers commercial licensing on the free tier.', 5),
  ('suno-vs-udio', 'Song Extension', 4, 5, 'Udio has a stronger song extension feature for building out full tracks from a generated seed. Suno extension is available but less flexible.', 6),
  ('suno-vs-udio', 'Pricing', 4, 3, 'Suno paid plans from $8/mo. Udio paid plans from $9.99/mo. Both are affordable; Suno is marginally cheaper.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'suno-vs-udio')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'suno-vs-udio');

-- 2. taskade-vs-notion-ai: AI-native PM vs AI-enhanced workspace
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'taskade-vs-notion-ai', 'taskade', 'notion-ai',
  'Taskade and Notion AI represent two different visions of AI in team workspaces. Taskade was built AI-first - its agent system is core to the product, not a layer added later. Notion AI is an add-on to an already mature workspace platform, bringing AI features to a tool that teams already use for documents and databases. Taskade is the better choice when AI automation of tasks is the primary goal. Notion AI is the better choice when the team already lives in Notion and wants AI assistance within that environment rather than switching tools.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'taskade-vs-notion-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('taskade-vs-notion-ai', 'AI Agent Capability', 5, 2, 'Taskade''s agents can autonomously complete tasks, research, and generate content within projects. Notion AI assists with writing and summarisation but does not act autonomously.', 1),
  ('taskade-vs-notion-ai', 'Database and Structure', 2, 5, 'Notion''s database system with relations, formulas, and filtered views is far more powerful than Taskade for structured data management.', 2),
  ('taskade-vs-notion-ai', 'Ease of Adoption', 4, 5, 'Notion has massive adoption and abundant learning resources. Taskade''s agent system requires more onboarding investment.', 3),
  ('taskade-vs-notion-ai', 'Template Library', 3, 5, 'Notion has thousands of community templates across every use case. Taskade templates are growing but smaller in selection.', 4),
  ('taskade-vs-notion-ai', 'Pricing', 5, 3, 'Taskade has a free tier and paid from $8/mo. Notion AI is $10/user/mo on top of a Notion plan - adds meaningful cost.', 5),
  ('taskade-vs-notion-ai', 'Real-Time Collaboration', 3, 5, 'Notion''s collaborative editing is more mature and reliable for large teams. Taskade real-time collaboration works but is less battle-tested at scale.', 6),
  ('taskade-vs-notion-ai', 'API and Integrations', 3, 5, 'Notion has a comprehensive API and hundreds of integrations. Taskade integrations are growing but fewer in number.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'taskade-vs-notion-ai')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'taskade-vs-notion-ai');

-- 3. pika-vs-runway: AI video generation quality vs accessibility
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'pika-vs-runway', 'pika', 'runway',
  'Pika and Runway are both leading AI video generation tools, but they occupy different positions in the market. Runway is the professional-grade platform with more advanced features, higher output quality, and a steeper price point - it is the tool professional video editors and creative directors reach for when quality is non-negotiable. Pika is the more accessible alternative with lower entry pricing and a free tier that makes it the natural starting point for individual creators and marketers. For teams where budget is the primary constraint, Pika delivers strong results at lower cost. For productions where visual quality is the priority, Runway Gen-3 still leads the field.',
  'runway', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pika-vs-runway');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('pika-vs-runway', 'Video Quality', 4, 5, 'Runway Gen-3 Alpha produces the highest-quality output in the AI video space. Pika 2.0 is excellent but a step below Runway on complex motion and scene coherence.', 1),
  ('pika-vs-runway', 'Free Tier', 5, 3, 'Pika offers monthly free credits. Runway free tier is limited to a small number of generation credits with watermarks.', 2),
  ('pika-vs-runway', 'Pricing', 5, 2, 'Pika plans from $8/mo. Runway plans from $15/mo with higher tiers needed for serious production use. Pika is significantly more accessible.', 3),
  ('pika-vs-runway', 'Camera Controls', 4, 5, 'Runway has more precise camera motion controls for professional productions. Pika camera controls are good for consumer use.', 4),
  ('pika-vs-runway', 'Image-to-Video', 5, 5, 'Both tools are strong at generating video from a source image. No clear winner on this feature.', 5),
  ('pika-vs-runway', 'Video Editing Features', 2, 5, 'Runway includes video editing, inpainting, and compositing tools alongside generation. Pika is focused on generation only.', 6),
  ('pika-vs-runway', 'Generation Speed', 4, 3, 'Pika generation is generally faster on standard queue. Runway can have longer waits at peak times on standard plans.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pika-vs-runway')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'pika-vs-runway');

-- 4. reflect-vs-mem-ai: networked notes vs AI-organised notes
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'reflect-vs-mem-ai', 'reflect', 'mem-ai',
  'Reflect and Mem are both AI-powered note-taking tools designed for individuals who want their notes to be more than a passive archive. Reflect uses a networked note approach with explicit backlinks and a graph view to visualise connections between ideas. Mem uses AI to organise notes automatically without requiring the user to create structure - notes just get captured and the AI surfaces connections when relevant. Reflect appeals to users who enjoy building their knowledge system deliberately. Mem appeals to users who want zero-maintenance organisation with intelligence built in. Neither is a replacement for Notion - both are personal knowledge management tools, not team collaboration platforms.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'reflect-vs-mem-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('reflect-vs-mem-ai', 'AI Organisation', 3, 5, 'Mem organises notes automatically with zero manual structure required. Reflect uses AI to assist but relies on user-created backlinks for the core graph.', 1),
  ('reflect-vs-mem-ai', 'Backlinks and Graph View', 5, 2, 'Reflect''s networked note system with a visual graph is a core feature. Mem has connection discovery but no visual graph.', 2),
  ('reflect-vs-mem-ai', 'Search Quality', 4, 5, 'Mem''s semantic search retrieves notes by meaning. Reflect search is strong but more keyword-dependent.', 3),
  ('reflect-vs-mem-ai', 'Privacy and Encryption', 5, 3, 'Reflect offers end-to-end encryption. Mem stores notes on its servers without E2E encryption.', 4),
  ('reflect-vs-mem-ai', 'Free Tier', 1, 3, 'Neither has a generous free tier. Reflect has no free tier. Mem has a limited free tier.', 5),
  ('reflect-vs-mem-ai', 'Writing Experience', 5, 4, 'Reflect has a clean, distraction-free writing interface. Mem''s interface is functional but less refined for long-form writing.', 6),
  ('reflect-vs-mem-ai', 'Meeting Integration', 3, 5, 'Mem integrates with calendar to surface relevant notes before meetings. Reflect has meeting note templates but less automatic integration.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'reflect-vs-mem-ai')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'reflect-vs-mem-ai');

-- 5. julius-ai-vs-chatgpt: data analysis vs general AI assistant
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'julius-ai-vs-chatgpt', 'julius-ai', 'chatgpt',
  'Julius AI and ChatGPT are both AI tools that can help with data analysis, but they are built for different depths of the task. Julius AI is specialised for quantitative analysis - it connects to spreadsheets and databases, runs statistical models, generates charts, and explains results in plain language. It is the right tool when the primary goal is data analysis and visualisation. ChatGPT with Code Interpreter can also perform data analysis but requires users to upload files and navigate a less specialised interface. For routine data work by finance, marketing, or operations teams without data science skills, Julius AI is more immediately useful. For general-purpose AI assistance that occasionally includes data work, ChatGPT is more versatile.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'julius-ai-vs-chatgpt');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('julius-ai-vs-chatgpt', 'Data Analysis Depth', 5, 3, 'Julius AI is purpose-built for statistical analysis, regression, forecasting, and chart generation. ChatGPT Code Interpreter covers basics but is less specialised.', 1),
  ('julius-ai-vs-chatgpt', 'Data Source Integration', 5, 2, 'Julius AI connects directly to Google Sheets, CSV files, and databases. ChatGPT requires manual file uploads for each session.', 2),
  ('julius-ai-vs-chatgpt', 'General Reasoning', 2, 5, 'ChatGPT is a superior general-purpose AI assistant for writing, coding, research, and reasoning tasks outside data analysis.', 3),
  ('julius-ai-vs-chatgpt', 'Ease of Use for Data', 5, 4, 'Julius AI''s natural language data interface is more intuitive for non-technical analysts. ChatGPT Code Interpreter requires more prompt engineering.', 4),
  ('julius-ai-vs-chatgpt', 'Pricing', 4, 4, 'Julius AI from $20/mo for data-focused plans. ChatGPT Plus at $20/mo. Comparable pricing; Julius AI more focused on data ROI.', 5),
  ('julius-ai-vs-chatgpt', 'Visualisation Quality', 5, 3, 'Julius AI produces publication-ready charts and tables. ChatGPT visualisations are functional but less polished.', 6),
  ('julius-ai-vs-chatgpt', 'Versatility', 1, 5, 'ChatGPT covers writing, coding, research, and conversation far beyond data. Julius AI is specialised for data analysis only.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'julius-ai-vs-chatgpt')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'julius-ai-vs-chatgpt');
