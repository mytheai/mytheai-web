-- compare-batch-9.sql
-- 5 new comparison pairs
-- Safe to re-run (ON CONFLICT DO NOTHING + NOT EXISTS guard)

-- 1. mailchimp-vs-klaviyo
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'mailchimp-vs-klaviyo', 'mailchimp', 'klaviyo',
  'Mailchimp is the most popular general email marketing platform for small businesses; Klaviyo is built specifically for e-commerce with deep behavioural segmentation and revenue-focused automation. Mailchimp wins on ease of use and free plan generosity; Klaviyo wins for online stores serious about email-driven revenue.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mailchimp-vs-klaviyo')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('mailchimp-vs-klaviyo', 'E-commerce Integration',        3, 5, 'Klaviyo''s Shopify and WooCommerce integration is industry-leading', 1),
  ('mailchimp-vs-klaviyo', 'Ease of Use',                   5, 3, 'Mailchimp''s drag-and-drop editor is more beginner-friendly', 2),
  ('mailchimp-vs-klaviyo', 'Segmentation & Personalisation',3, 5, 'Klaviyo''s behavioural segmentation by purchase history and engagement is far more granular', 3),
  ('mailchimp-vs-klaviyo', 'AI Content Generation',         4, 3, 'Mailchimp''s AI writing and subject line suggestions are more developed', 4),
  ('mailchimp-vs-klaviyo', 'Free Plan',                     5, 2, 'Mailchimp''s free plan covers 500 contacts; Klaviyo''s free tier is limited to 250', 5),
  ('mailchimp-vs-klaviyo', 'SMS Marketing',                 2, 5, 'Klaviyo''s combined SMS and email flows are best-in-class for e-commerce', 6),
  ('mailchimp-vs-klaviyo', 'Automation & Flows',            3, 5, 'Klaviyo''s abandoned cart, win-back, and post-purchase flows are significantly more powerful', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'mailchimp-vs-klaviyo'
);

-- 2. hubspot-vs-pipedrive
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'hubspot-vs-pipedrive', 'hubspot', 'pipedrive',
  'HubSpot is an all-in-one marketing, sales, and service platform with a free CRM at its core; Pipedrive is a focused, easy-to-use sales CRM built around pipeline management. HubSpot wins for teams wanting an integrated marketing and sales stack; Pipedrive wins for pure sales teams who value simplicity and speed.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hubspot-vs-pipedrive')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('hubspot-vs-pipedrive', 'Ease of Use',            3, 5, 'Pipedrive''s visual pipeline UI is significantly faster to learn and navigate', 1),
  ('hubspot-vs-pipedrive', 'Free CRM',               5, 2, 'HubSpot''s free CRM is comprehensive; Pipedrive only offers a 14-day trial', 2),
  ('hubspot-vs-pipedrive', 'Marketing Tools',        5, 1, 'HubSpot includes email marketing, landing pages, and automation; Pipedrive does not', 3),
  ('hubspot-vs-pipedrive', 'Sales Pipeline',         4, 5, 'Pipedrive''s visual pipeline is purpose-built for sales teams and more intuitive', 4),
  ('hubspot-vs-pipedrive', 'AI Features',            4, 3, 'HubSpot''s AI assistant, forecasting, and content tools are more mature', 5),
  ('hubspot-vs-pipedrive', 'Reporting & Analytics',  4, 3, 'HubSpot''s reporting covers the full marketing and sales funnel', 6),
  ('hubspot-vs-pipedrive', 'Pricing',                2, 4, 'Pipedrive''s paid plans start lower; HubSpot''s paid tiers escalate significantly', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'hubspot-vs-pipedrive'
);

-- 3. adobe-photoshop-vs-figma
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'adobe-photoshop-vs-figma', 'adobe-photoshop', 'figma',
  'Adobe Photoshop is the industry standard for photo editing, image manipulation, and raster graphics; Figma is the leading UI/UX design and team collaboration tool. They serve fundamentally different purposes — Photoshop for photo and image work, Figma for interface and product design — and most professional design teams use both.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'adobe-photoshop-vs-figma')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('adobe-photoshop-vs-figma', 'Photo Editing',              5, 1, 'Photoshop is unmatched for photo retouching, compositing, and manipulation', 1),
  ('adobe-photoshop-vs-figma', 'UI/UX Design',               2, 5, 'Figma is the industry standard for interface and product design workflows', 2),
  ('adobe-photoshop-vs-figma', 'Real-time Collaboration',    2, 5, 'Figma''s multiplayer editing is its core strength; Photoshop is primarily single-user', 3),
  ('adobe-photoshop-vs-figma', 'AI Features',                5, 4, 'Photoshop''s Generative Fill and AI removal tools are more developed', 4),
  ('adobe-photoshop-vs-figma', 'Free Plan',                  1, 5, 'Figma has a generous free plan; Photoshop requires a Creative Cloud subscription', 5),
  ('adobe-photoshop-vs-figma', 'Learning Curve',             2, 4, 'Figma is significantly more accessible for design beginners', 6),
  ('adobe-photoshop-vs-figma', 'Vector Graphics',            2, 5, 'Figma is vector-native; Photoshop is primarily a raster editor', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'adobe-photoshop-vs-figma'
);

-- 4. ideogram-vs-midjourney
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'ideogram-vs-midjourney', 'ideogram', 'midjourney',
  'Midjourney produces the highest overall image quality of any AI generator; Ideogram specialises in accurate text rendering within images — solving the problem Midjourney and most AI image tools have long struggled with. They serve different creative needs: Midjourney for artistic quality, Ideogram for graphics with readable text.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ideogram-vs-midjourney')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('ideogram-vs-midjourney', 'Overall Image Quality',  3, 5, 'Midjourney v7 remains the benchmark for artistic AI image quality', 1),
  ('ideogram-vs-midjourney', 'Text in Images',         5, 2, 'Ideogram reliably renders legible, styled text; Midjourney frequently garbles it', 2),
  ('ideogram-vs-midjourney', 'Typography & Design',    5, 3, 'Ideogram''s styled text makes it ideal for social graphics and poster concepts', 3),
  ('ideogram-vs-midjourney', 'Free Plan',              5, 1, 'Ideogram has a functional free tier; Midjourney requires $10/month minimum', 4),
  ('ideogram-vs-midjourney', 'Style Range',            3, 5, 'Midjourney''s community and style diversity is significantly broader', 5),
  ('ideogram-vs-midjourney', 'Commercial Use',         4, 4, 'Both offer commercial licensing on paid plans', 6),
  ('ideogram-vs-midjourney', 'Ease of Use',            5, 3, 'Ideogram''s web interface is simpler; Midjourney''s Discord workflow is unconventional', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'ideogram-vs-midjourney'
);

-- 5. vapi-vs-elevenlabs
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'vapi-vs-elevenlabs', 'vapi', 'elevenlabs',
  'Vapi is a developer platform for building AI voice agents and automating phone conversations; ElevenLabs is the leading AI voice synthesis and cloning tool. Vapi focuses on conversational AI infrastructure and call automation; ElevenLabs focuses on producing the most realistic AI voices for content creation and narration.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'vapi-vs-elevenlabs')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('vapi-vs-elevenlabs', 'Voice Quality',              3, 5, 'ElevenLabs produces the most realistic and emotive AI voices available', 1),
  ('vapi-vs-elevenlabs', 'Voice Cloning',              2, 5, 'ElevenLabs'' voice cloning from short audio samples is best-in-class', 2),
  ('vapi-vs-elevenlabs', 'API & Developer Tools',      5, 4, 'Vapi is built for voice agent infrastructure with call routing and webhook support', 3),
  ('vapi-vs-elevenlabs', 'Voice Agents & Automation',  5, 2, 'Vapi handles full conversational AI phone agents; ElevenLabs is primarily synthesis', 4),
  ('vapi-vs-elevenlabs', 'Real-time Latency',          5, 4, 'Vapi''s real-time streaming is optimised for low-latency phone call use cases', 5),
  ('vapi-vs-elevenlabs', 'Free Plan',                  4, 4, 'Both offer free tiers with limited monthly usage', 6),
  ('vapi-vs-elevenlabs', 'Non-developer Access',       1, 5, 'ElevenLabs has a full web UI for non-technical users; Vapi requires API integration', 7)
) AS v(slug, name, a, b, notes, sort)
WHERE NOT EXISTS (
  SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'vapi-vs-elevenlabs'
);
