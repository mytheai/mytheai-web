-- compare-batch-36.sql
-- 5 AI Presentation Tool comparison pairs
-- All batch-36 tools confirmed in DB; pitch/gamma/beautiful-ai/canva-ai confirmed from earlier batches
-- Safe to re-run: ON CONFLICT DO NOTHING + WHERE NOT EXISTS guards

-- 1. slidebean vs pitch
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT 'slidebean-vs-pitch', 'slidebean', 'pitch',
  'Slidebean is an AI pitch deck builder designed specifically for startup founders, using investor data to structure decks and tracking who reads them. Pitch is a collaborative presentation tool favoured by design-conscious teams for building polished branded decks with real-time collaboration. Slidebean wins for solo founders who need investor-ready structure fast; Pitch wins for teams that prioritise design quality and collaborative review.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'slidebean-vs-pitch');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'slidebean-vs-pitch', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Generation Quality',     4, 3, 'Slidebean generates investor-structured content using startup deck data. Pitch offers AI generation but is more template-driven and less startup-specific.'),
  ('Design Quality',            3, 5, 'Pitch has exceptional template design and brand consistency. Slidebean templates are professional but more formulaic.'),
  ('Collaboration',             2, 5, 'Pitch is built for team collaboration with comments, version history, and real-time co-editing. Slidebean is primarily a solo tool.'),
  ('Analytics and Tracking',   5, 2, 'Slidebean tracks individual viewer engagement per slide. Pitch offers basic view analytics. Slidebean is the clear winner here.'),
  ('Startup-Specific Features', 5, 2, 'Slidebean is purpose-built for pitch decks - funding stage templates, traction slide guidance, investor database integrations.'),
  ('Ease of Use',               4, 4, 'Both tools are well-designed and accessible. Slidebean''s structured approach is faster; Pitch requires more manual design decisions.'),
  ('Pricing',                   3, 4, 'Slidebean starts at $8/month. Pitch offers a generous free tier for small teams. Pitch wins on value for teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'slidebean-vs-pitch')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'slidebean-vs-pitch');

-- 2. prezi vs gamma
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT 'prezi-vs-gamma', 'prezi', 'gamma',
  'Prezi pioneered non-linear zooming presentations where content lives on a single canvas rather than sequential slides. Gamma is an AI-first tool that generates polished linear presentations from text prompts in seconds. Prezi wins for presenters who need non-linear narrative and audience-responsive storytelling; Gamma wins for speed and AI-generated first drafts of conventional presentations.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'prezi-vs-gamma');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'prezi-vs-gamma', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Generation Speed',       2, 5, 'Gamma generates a complete designed deck in under 60 seconds from a prompt. Prezi''s AI assists but building a Prezi canvas requires more manual effort.'),
  ('Presentation Format',       5, 2, 'Prezi''s non-linear canvas is unique and memorable. Gamma produces standard slide-based linear presentations, just faster than competitors.'),
  ('Design Quality',            3, 4, 'Gamma''s AI-generated layouts are clean and modern. Prezi canvas presentations look distinctive but require design skill to achieve at high quality.'),
  ('Learning Curve',            3, 4, 'Prezi has a steeper learning curve - the canvas format is unfamiliar to most slide-trained users. Gamma is immediately intuitive.'),
  ('Use Case Fit',              4, 4, 'Prezi excels at complex non-linear topics, educational content, and workshops. Gamma excels at quick internal updates, marketing decks, and first drafts.'),
  ('Collaboration',             3, 4, 'Gamma supports team comments and sharing. Prezi''s collaboration features are functional but less polished.'),
  ('Pricing',                   3, 4, 'Prezi''s professional plan is $19/month. Gamma has a free tier and paid plans from $8/month, making it accessible for individuals.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'prezi-vs-gamma')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'prezi-vs-gamma');

-- 3. visme vs canva-ai
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT 'visme-vs-canva-ai', 'visme', 'canva-ai',
  'Visme is a multi-format visual content platform covering presentations, infographics, reports, and data visualisations with strong chart and brand kit features. Canva AI is the dominant design platform with the broadest template library, most integrations, and highest brand recognition. Canva wins for general design versatility and team adoption; Visme wins for data-rich visual content and infographic depth.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'visme-vs-canva-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'visme-vs-canva-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Data Visualisation',        5, 3, 'Visme has superior chart and infographic tools with live data connections. Canva''s charts are functional but less data-focused.'),
  ('Template Library',          3, 5, 'Canva has the largest template library across all design categories. Visme has strong templates but fewer than Canva.'),
  ('AI Features',               4, 4, 'Both offer AI image generation, content suggestions, and brand application. Comparable quality in 2026.'),
  ('Brand Kit Management',      4, 5, 'Both have brand kit features. Canva''s is more polished and widely used for team brand enforcement.'),
  ('Format Coverage',           5, 4, 'Visme covers presentations, infographics, reports, social, video, and web content. Canva covers similar formats with stronger social and video tools.'),
  ('Ease of Use',               3, 5, 'Canva is consistently rated as more intuitive. Visme''s additional data features add some complexity.'),
  ('Pricing',                   3, 4, 'Visme starts at $12.25/month. Canva Pro is $12.99/month. Canva''s free tier is more generous, giving it a broader adoption base.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'visme-vs-canva-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'visme-vs-canva-ai');

-- 4. storydoc vs beautiful-ai
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT 'storydoc-vs-beautiful-ai', 'storydoc', 'beautiful-ai',
  'Storydoc creates interactive web-based sales decks with detailed engagement analytics showing exactly how prospects engage with each slide. Beautiful.ai is a smart slide editor where layouts adapt automatically as content is added, eliminating manual design work. Storydoc wins for sales teams tracking prospect engagement; Beautiful.ai wins for teams wanting fast, consistently designed decks without design overhead.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'storydoc-vs-beautiful-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'storydoc-vs-beautiful-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Sales Analytics',           5, 1, 'Storydoc tracks per-slide engagement, time-on-page, and viewer identity. Beautiful.ai has no comparable engagement tracking.'),
  ('Auto-Layout Intelligence',  2, 5, 'Beautiful.ai''s Smart Slide technology automatically rebalances layouts as content changes. Storydoc uses fixed interactive templates.'),
  ('Interactivity',             5, 2, 'Storydoc produces interactive web experiences with video embeds, animations, and personalisation. Beautiful.ai creates traditional slide decks.'),
  ('Design Consistency',        3, 5, 'Beautiful.ai enforces design consistency automatically through Smart Slides. Storydoc templates are consistent but less design-intelligent.'),
  ('CRM Integration',           4, 2, 'Storydoc integrates with Salesforce and HubSpot for pipeline-level deck analytics. Beautiful.ai has minimal CRM integration.'),
  ('AI Content Generation',     3, 3, 'Both offer AI content assistance. Neither leads significantly in generation quality.'),
  ('Pricing',                   2, 4, 'Storydoc starts at $30/month per user. Beautiful.ai starts at $12/month. Beautiful.ai wins on cost accessibility.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'storydoc-vs-beautiful-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'storydoc-vs-beautiful-ai');

-- 5. mentimeter vs genially
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT 'mentimeter-vs-genially', 'mentimeter', 'genially',
  'Mentimeter is a live audience engagement platform built for synchronised real-time polling during presentations - audience members respond on their devices and results appear live on the presenter''s screen. Genially creates interactive visual content where elements respond to clicks and hover actions, suited for self-paced exploration. Mentimeter wins for live synchronised audience engagement; Genially wins for asynchronous interactive content.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mentimeter-vs-genially');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'mentimeter-vs-genially', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Live Audience Interaction',  5, 1, 'Mentimeter is specifically built for synchronised real-time polling, quizzes, and word clouds during live sessions. Genially does not support live audience response.'),
  ('Async Interactive Content',  1, 5, 'Genially excels at self-paced interactive content where viewers click through at their own pace. Mentimeter requires a live presenter.'),
  ('Audience Analytics',         4, 3, 'Mentimeter provides real-time response data and session analytics. Genially provides view and interaction analytics for async content.'),
  ('Content Creation Speed',     3, 4, 'Both have intuitive editors. Genially''s free-canvas approach is flexible; Mentimeter''s slide-based format is faster for standard polling sessions.'),
  ('Education Use Cases',        4, 5, 'Both are widely used in education. Genially is stronger for student-paced interactive learning; Mentimeter for lecture-based engagement.'),
  ('Business/Events Use Cases',  5, 3, 'Mentimeter dominates corporate training, town halls, and conferences. Genially is used for interactive reports and product showcases.'),
  ('Pricing',                    3, 5, 'Mentimeter starts at $11.99/month. Genially has a very generous free tier with unlimited creations, making it more accessible for individuals.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mentimeter-vs-genially')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'mentimeter-vs-genially');
