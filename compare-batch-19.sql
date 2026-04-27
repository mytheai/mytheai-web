-- compare-batch-19.sql
-- 5 new comparison pairs using tools already in DB
-- ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)

-- 1. descript-vs-riverside: podcast production platforms
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'descript-vs-riverside', 'descript', 'riverside',
  'Descript and Riverside are both popular tools for podcast and video production, but they solve different parts of the workflow. Riverside is optimised for recording - it captures locally at the highest quality regardless of internet connection, producing studio-grade audio and 4K video for remote guests. Descript is optimised for editing - its transcript-based editing paradigm makes post-production accessible to non-editors, and its AI features streamline the entire finishing process. Many professional podcasters use both: Riverside for the recording session, Descript for editing and production. As standalone tools, Riverside is the better choice if recording quality is the priority; Descript is better if post-production ease is the priority.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'descript-vs-riverside');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('descript-vs-riverside', 'Recording Quality', 3, 5, 'Riverside records locally at each participant''s device, eliminating streaming compression. Descript is primarily an editor - its recording quality depends on the source input.', 1),
  ('descript-vs-riverside', 'Post-Production Editing', 5, 2, 'Descript''s transcript-based editing and AI tools (filler word removal, Studio Sound, Overdub) make it the stronger post-production platform.', 2),
  ('descript-vs-riverside', 'Guest Experience', 3, 5, 'Riverside handles remote guests natively with no quality loss. Descript editing works on any uploaded file but is not a recording solution for remote guests.', 3),
  ('descript-vs-riverside', 'AI Features', 5, 4, 'Descript''s Overdub, Studio Sound, and filler word removal are more advanced than Riverside''s AI editing suite.', 4),
  ('descript-vs-riverside', 'Video Clip Generation', 4, 5, 'Riverside''s Magic Clips feature is more sophisticated for automatic social media clip creation. Descript supports clip creation but requires more manual work.', 5),
  ('descript-vs-riverside', 'Pricing', 4, 3, 'Descript free tier is more generous. Riverside free tier is limited. Both paid plans are competitively priced.', 6),
  ('descript-vs-riverside', 'Ease of Use', 5, 4, 'Descript''s transcript editing is highly intuitive for non-editors. Riverside is straightforward for recording but less so for post-production.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'descript-vs-riverside')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'descript-vs-riverside');

-- 2. writesonic-vs-rytr: AI writing tools by budget
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'writesonic-vs-rytr', 'writesonic', 'rytr',
  'Writesonic and Rytr are both accessible AI writing tools, but they serve different budgets and use cases. Writesonic is the more capable option with real-time web research, Brand Voice, and a long-form article writer that produces SEO-grounded content with citations. Rytr is the most affordable option in the category - its Unlimited plan at $29/mo removes word limits at a price point below most competitors. For teams with budget as the primary constraint and simpler content needs, Rytr delivers strong value. For teams who need higher-quality output, SEO grounding, or brand consistency, Writesonic justifies the higher cost.',
  'writesonic', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'writesonic-vs-rytr');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('writesonic-vs-rytr', 'Content Quality', 5, 3, 'Writesonic produces higher-quality long-form content with real-time research grounding. Rytr is better for short-form and simple use cases.', 1),
  ('writesonic-vs-rytr', 'SEO Features', 5, 2, 'Writesonic has a dedicated SEO article writer with real-time citations. Rytr does not have SEO-specific features.', 2),
  ('writesonic-vs-rytr', 'Pricing', 3, 5, 'Rytr Unlimited at $29/mo is among the cheapest unlimited AI writing plans available. Writesonic starts at $16/mo but usage limits apply.', 3),
  ('writesonic-vs-rytr', 'Free Tier', 4, 5, 'Both have free tiers. Rytr''s free tier at 10,000 characters/month is more generous than Writesonic''s.', 4),
  ('writesonic-vs-rytr', 'Use Case Range', 5, 5, 'Both cover a wide range of content types. Writesonic has more use cases; Rytr covers the most common ones well.', 5),
  ('writesonic-vs-rytr', 'Language Support', 4, 5, 'Rytr supports 30+ languages with consistent quality. Writesonic supports multiple languages but with variable output quality.', 6),
  ('writesonic-vs-rytr', 'Brand Voice', 5, 2, 'Writesonic''s Brand Voice feature trains on existing content. Rytr has basic tone selection but no true brand voice training.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'writesonic-vs-rytr')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'writesonic-vs-rytr');

-- 3. podcastle-vs-descript: podcast editing tools
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'podcastle-vs-descript', 'podcastle', 'descript',
  'Podcastle and Descript are both browser-based podcast production tools with strong AI editing features, but Descript is the more powerful and versatile of the two. Descript handles both audio and video, has a more advanced voice cloning system (Overdub), and is more widely adopted by professional podcasters and agencies. Podcastle is the better choice for solo podcasters who want a simpler, more affordable entry point to AI-assisted podcast production - its browser-based workflow requires no software installation and covers the core production needs without overwhelming beginners with options.',
  'descript', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'podcastle-vs-descript');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('podcastle-vs-descript', 'Ease of Use for Beginners', 5, 4, 'Podcastle has a simpler, more guided interface. Descript has a learning curve despite its intuitive editing paradigm.', 1),
  ('podcastle-vs-descript', 'Video Production', 1, 5, 'Descript handles video editing in addition to audio. Podcastle is audio-only.', 2),
  ('podcastle-vs-descript', 'Voice Cloning', 4, 5, 'Descript''s Overdub voice cloning is more advanced and better quality. Podcastle''s Revoice is functional but less refined.', 3),
  ('podcastle-vs-descript', 'AI Filler Word Removal', 5, 5, 'Both tools automatically remove filler words. Performance is comparable.', 4),
  ('podcastle-vs-descript', 'Recording Quality', 4, 3, 'Podcastle''s browser recording is solid. Descript recording quality is decent but Descript is primarily an editor, not a recorder.', 5),
  ('podcastle-vs-descript', 'Pricing', 5, 3, 'Podcastle from $11.99/mo. Descript from $24/mo. Podcastle is significantly more affordable for solo podcasters.', 6),
  ('podcastle-vs-descript', 'Professional Adoption', 3, 5, 'Descript is used by professional agencies and media companies. Podcastle is more popular with solo creators and beginners.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'podcastle-vs-descript')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'podcastle-vs-descript');

-- 4. castmagic-vs-opus-clip: content repurposing tools
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'castmagic-vs-opus-clip', 'castmagic', 'opus-clip',
  'Castmagic and Opus Clip both repurpose long-form audio and video into shorter content, but they take different approaches. Opus Clip is optimised for video clip extraction - it identifies the most engaging moments in a video and reformats them into vertical short-form clips for TikTok, Instagram Reels, and YouTube Shorts. Castmagic is optimised for written content extraction - it takes audio or video and generates transcripts, show notes, newsletters, social captions, and blog outlines from the same recording. For video creators focused on social media clip distribution, Opus Clip is the stronger choice. For podcast producers and content teams who need written output from their recordings, Castmagic delivers more value.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'castmagic-vs-opus-clip');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('castmagic-vs-opus-clip', 'Short-Form Video Clips', 2, 5, 'Opus Clip''s core feature is identifying and formatting viral-worthy video clips. Castmagic does not generate video clips - written content only.', 1),
  ('castmagic-vs-opus-clip', 'Written Content Extraction', 5, 2, 'Castmagic generates transcripts, show notes, newsletters, and social captions. Opus Clip focuses on video, not written content.', 2),
  ('castmagic-vs-opus-clip', 'Audio-Only Support', 5, 2, 'Castmagic works with audio files and podcasts. Opus Clip requires video input.', 3),
  ('castmagic-vs-opus-clip', 'Social Media Captions', 5, 4, 'Castmagic generates social captions as text. Opus Clip generates video clips with captions burned in.', 4),
  ('castmagic-vs-opus-clip', 'Pricing', 4, 4, 'Castmagic from $39/mo. Opus Clip from $15/mo for limited clips. Both require paid plans for meaningful use.', 5),
  ('castmagic-vs-opus-clip', 'Free Tier', 2, 4, 'Opus Clip has a limited free tier with watermarked clips. Castmagic has no free tier.', 6),
  ('castmagic-vs-opus-clip', 'Workflow Integration', 4, 4, 'Both integrate into creator workflows. Castmagic integrates with podcast hosts; Opus Clip integrates with social scheduling tools.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'castmagic-vs-opus-clip')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'castmagic-vs-opus-clip');

-- 5. frase-vs-surfer-seo: SEO content tools
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'frase-vs-surfer-seo', 'frase', 'surfer-seo',
  'Frase and Surfer SEO are both AI-powered SEO content tools used by content teams and agencies to create articles that rank. They overlap significantly in functionality but differ in their emphasis. Surfer SEO is the more established platform with a stronger keyword research layer and more comprehensive scoring against competitors. Frase offers a tighter integration between research and writing - the workflow from keyword to brief to draft happens within one tool. Both are valid choices for SEO content teams; the decision often comes down to whether a team already uses Surfer''s broader SEO ecosystem or prefers Frase''s more self-contained writing workflow.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'frase-vs-surfer-seo');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('frase-vs-surfer-seo', 'Brief Generation', 5, 5, 'Both generate high-quality content briefs from competitor analysis. Feature parity on this core capability.', 1),
  ('frase-vs-surfer-seo', 'AI Writing Integration', 5, 4, 'Frase''s AI writing is more tightly integrated into the brief-to-draft workflow. Surfer AI writing is good but feels more like an add-on.', 2),
  ('frase-vs-surfer-seo', 'Content Scoring', 4, 5, 'Surfer''s Content Score is the more widely recognised benchmark. Frase scoring is accurate but less established as an industry standard.', 3),
  ('frase-vs-surfer-seo', 'Keyword Research', 3, 5, 'Surfer has stronger keyword research and SERP analysis tools. Frase keyword research is functional but less comprehensive.', 4),
  ('frase-vs-surfer-seo', 'Pricing', 4, 3, 'Frase starts at $44.99/mo. Surfer starts at $99/mo. Frase is significantly cheaper at entry level.', 5),
  ('frase-vs-surfer-seo', 'Question Research', 5, 3, 'Frase''s question research identifying what searchers ask is a standout feature. Surfer has People Also Ask data but Frase integrates it more usefully.', 6),
  ('frase-vs-surfer-seo', 'Team Features', 4, 5, 'Surfer has stronger team collaboration features. Frase team features are adequate but less robust at scale.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'frase-vs-surfer-seo')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'frase-vs-surfer-seo');
