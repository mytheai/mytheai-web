-- compare-batch-4.sql
-- 5 new comparison pairs using tools already in DB
-- Pattern: ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)
-- Run in Supabase SQL Editor

-- 1. Windsurf vs Cursor
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'windsurf-vs-cursor', 'windsurf', 'cursor',
  'Windsurf and Cursor are the two leading AI-native code editors in 2026, both built on a VS Code foundation with deep AI integration. Cursor is the more established product with a larger community and stronger brand recognition among developers. Windsurf differentiates with its Cascade agentic model, which handles multi-step tasks more autonomously and maintains context better across long sessions. For most developers, the choice comes down to how much autonomy you want the AI to take — Cursor is more collaborative, Windsurf more agentic.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'windsurf-vs-cursor')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('windsurf-vs-cursor', 'AI Model Quality',        4, 4, 'Both support Claude, GPT-4o, and Gemini. Quality is roughly equal — the difference is in how the AI is applied.', 1),
  ('windsurf-vs-cursor', 'Agentic Capabilities',    5, 4, 'Windsurf''s Cascade handles multi-step tasks end-to-end more autonomously. Cursor''s agent mode is capable but requires more guidance.', 2),
  ('windsurf-vs-cursor', 'Editor Experience',       4, 5, 'Cursor has a more polished UI with stronger keyboard shortcuts and a more mature extension ecosystem from longer development.', 3),
  ('windsurf-vs-cursor', 'Context Retention',       5, 4, 'Windsurf maintains codebase context more reliably across extended sessions. Cursor can lose context on very large projects.', 4),
  ('windsurf-vs-cursor', 'Community & Resources',   3, 5, 'Cursor has a larger community, more tutorials, and more third-party content. Windsurf is growing but newer.', 5),
  ('windsurf-vs-cursor', 'Free Tier',               4, 4, 'Both offer generous free tiers. Windsurf''s free allowance is slightly higher; Cursor''s Pro at $20/mo is slightly pricier than Windsurf Pro at $15/mo.', 6),
  ('windsurf-vs-cursor', 'Reliability',             4, 4, 'Both are stable for daily use. Windsurf has had fewer reported performance issues; Cursor''s longer track record provides more predictability.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'windsurf-vs-cursor')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'windsurf-vs-cursor');

-- 2. Runway vs Pika
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'runway-vs-pika', 'runway', 'pika',
  'Runway and Pika are two of the most widely used AI video generators for creative professionals. Runway is the more powerful and feature-rich platform, with a full suite of video editing tools alongside generation. Pika is simpler, faster, and easier to pick up — ideal for creators who want polished short-form clips without a steep learning curve. Runway is the choice for professional productions; Pika is the choice for speed and social content.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'runway-vs-pika')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('runway-vs-pika', 'Video Quality',          5, 4, 'Runway Gen-3 Alpha produces higher overall visual quality, especially for complex scenes. Pika is very strong for stylised short clips.', 1),
  ('runway-vs-pika', 'Motion Control',         5, 4, 'Runway offers more granular camera movement controls and motion brush tools. Pika''s controls are simpler but sufficient for most use cases.', 2),
  ('runway-vs-pika', 'Ease of Use',            3, 5, 'Pika is significantly easier to learn. Runway has a steeper curve due to its broader feature set and more complex interface.', 3),
  ('runway-vs-pika', 'Feature Breadth',        5, 3, 'Runway includes inpainting, outpainting, background removal, and a full video editor. Pika focuses on core generation only.', 4),
  ('runway-vs-pika', 'Maximum Clip Length',    5, 3, 'Runway supports longer output clips. Pika generates shorter clips by default, though chaining is possible.', 5),
  ('runway-vs-pika', 'Speed',                  3, 5, 'Pika generates clips faster. Runway''s higher quality comes with longer queue and processing times.', 6),
  ('runway-vs-pika', 'Pricing',                3, 4, 'Pika''s free tier is more generous for casual use. Runway''s paid plans are more expensive but reflect the broader feature set.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'runway-vs-pika')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'runway-vs-pika');

-- 3. ElevenLabs vs Murf
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'elevenlabs-vs-murf', 'elevenlabs', 'murf',
  'ElevenLabs and Murf are the two leading AI voice generation platforms for professional use. ElevenLabs leads on voice quality and voice cloning — its voices are the most natural-sounding available and its cloning capability is unmatched. Murf leads on studio tooling, language breadth, and ease of use for corporate voiceover production. Choose ElevenLabs if voice realism is the priority; choose Murf if you need a complete production studio with diverse voice options across many languages.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'elevenlabs-vs-murf')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('elevenlabs-vs-murf', 'Voice Naturalness',       5, 4, 'ElevenLabs produces the most natural-sounding AI voices currently available. Murf is excellent but slightly behind at the quality ceiling.', 1),
  ('elevenlabs-vs-murf', 'Voice Cloning',           5, 3, 'ElevenLabs'' instant voice cloning is the industry benchmark. Murf offers cloning but with less realistic and consistent results.', 2),
  ('elevenlabs-vs-murf', 'Language Coverage',       4, 5, 'Murf supports 20+ languages with strong quality across them. ElevenLabs supports more languages but quality varies in less common ones.', 3),
  ('elevenlabs-vs-murf', 'Studio & Video Sync',     3, 5, 'Murf includes a built-in video timeline editor for syncing voiceover to footage. ElevenLabs focuses on voice generation without built-in video tools.', 4),
  ('elevenlabs-vs-murf', 'API Access',              5, 3, 'ElevenLabs has a developer-first API widely used in applications. Murf''s API is available but less robust for programmatic use.', 5),
  ('elevenlabs-vs-murf', 'Commercial Licensing',    4, 4, 'Both include commercial rights on paid plans. ElevenLabs'' licensing terms are clear; Murf explicitly states commercial use on all Creator plans and above.', 6),
  ('elevenlabs-vs-murf', 'Pricing',                 4, 3, 'ElevenLabs'' Starter at $5/mo is more accessible. Murf''s Creator at $19/mo reflects the added studio features but is pricier for voice-only use.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'elevenlabs-vs-murf')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'elevenlabs-vs-murf');

-- 4. Loom vs Descript
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'loom-vs-descript', 'loom', 'descript',
  'Loom and Descript both handle video recording and editing but from very different angles. Loom is purpose-built for async communication — quick screen recordings shared via link, with minimal editing. Descript is a full video and podcast editor where the transcript is the editing interface, designed for polished content production. If you need fast async updates, Loom is the right tool. If you are producing edited video content for an audience, Descript is the right tool.',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'loom-vs-descript')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('loom-vs-descript', 'Screen Recording',          5, 4, 'Loom is the benchmark for fast, shareable screen recording. Descript records well but its strength is in the editing, not the capture.', 1),
  ('loom-vs-descript', 'Video Editing',             2, 5, 'Descript''s transcript-based editing is the most intuitive video editor available. Loom offers only basic trim and cut tools.', 2),
  ('loom-vs-descript', 'AI Transcription',          4, 5, 'Both offer strong transcription. Descript''s is more accurate and directly tied to the editing workflow. Loom''s transcription is for search and captions.', 3),
  ('loom-vs-descript', 'Async Collaboration',       5, 3, 'Loom is built for async sharing with viewer reactions, comments, and link-based access. Descript focuses on production, not team communication.', 4),
  ('loom-vs-descript', 'Podcast Production',        1, 5, 'Descript is a leading podcast editor with filler word removal, multi-track mixing, and studio sound. Loom has no podcast production capabilities.', 5),
  ('loom-vs-descript', 'Ease of Use',               5, 3, 'Loom takes seconds to start a recording. Descript has a learning curve due to its more powerful editing environment.', 6),
  ('loom-vs-descript', 'Pricing',                   4, 3, 'Loom''s free plan is generous for small teams. Descript''s free tier is more limited; its Creator plan at $24/mo reflects the production tool positioning.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'loom-vs-descript')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'loom-vs-descript');

-- 5. Mixpanel vs Amplitude
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner)
SELECT 'mixpanel-vs-amplitude', 'mixpanel', 'amplitude',
  'Mixpanel and Amplitude are the two leading product analytics platforms for digital businesses. Both track user behaviour at the event level and support funnel analysis, cohort analysis, and retention charts. Amplitude differentiates with built-in A/B experimentation and session replay. Mixpanel differentiates with a simpler setup, real-time data, and a more generous free tier. The choice often comes down to whether you need experimentation (Amplitude) or a simpler, more immediate analytics experience (Mixpanel).',
  NULL
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mixpanel-vs-amplitude')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('mixpanel-vs-amplitude', 'Ease of Setup',          4, 3, 'Mixpanel is generally faster to instrument and query for new users. Amplitude has a steeper initial learning curve.', 1),
  ('mixpanel-vs-amplitude', 'Analytics Depth',        4, 5, 'Amplitude offers more advanced behavioural modelling and predictive analytics. Both are strong on core funnels and retention.', 2),
  ('mixpanel-vs-amplitude', 'A/B Testing',            3, 5, 'Amplitude includes built-in experimentation tied to analytics data. Mixpanel requires a separate third-party testing tool.', 3),
  ('mixpanel-vs-amplitude', 'Session Replay',         3, 5, 'Amplitude includes session replay for qualitative context. Mixpanel does not offer session replay natively.', 4),
  ('mixpanel-vs-amplitude', 'Real-Time Data',         5, 4, 'Mixpanel''s data is available in real time with no noticeable delay. Amplitude is near-real-time but with slight latency on large datasets.', 5),
  ('mixpanel-vs-amplitude', 'Free Tier',              5, 4, 'Mixpanel''s free plan supports 20M monthly events. Amplitude''s Starter is generous but tracks fewer events before paid plans are required.', 6),
  ('mixpanel-vs-amplitude', 'Pricing at Scale',       4, 3, 'Both platforms become expensive at enterprise scale. Amplitude''s pricing increases more steeply with event volume and advanced feature usage.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mixpanel-vs-amplitude')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'mixpanel-vs-amplitude');
