-- compare-batch-45.sql
-- 5 AI Meeting Intelligence comparison pairs
-- All tools from tools-batch-45 (confirmed in DB)
-- Run AFTER tools-batch-45 confirmed in Supabase
-- Actual slugs: grain, read-ai, jamie, sembly-ai, meetgeek,
--               notta, tactiq, chorus, modjo, airgram

-- 1. grain-vs-read-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'grain-vs-read-ai', 'grain', 'read-ai',
  'Grain and Read AI both record and transcribe video calls, but their core value propositions are different. Grain is built around shareable video clips - turning key meeting moments into short videos that can be shared in Slack or embedded in Notion. Read AI is built around meeting analytics - engagement scoring, participation tracking, and real-time summaries that update during the call. Grain wins for teams that need to surface and share specific moments from customer or research calls. Read AI wins for managers who want data on how their meetings are actually running.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'grain-vs-read-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'grain-vs-read-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Transcript Accuracy', 4, 4, 'Both produce high-quality transcripts across English and major languages. Neither requires a specific microphone setup - both work reliably with standard laptop audio.'),
  ('Meeting Summary Quality', 4, 5, 'Read AI summaries are structured with executive summary, decisions, action items, and questions asked. Grain summaries are good but secondary to its clip-sharing workflow.'),
  ('Video Clip Sharing', 5, 1, 'Grain''s clip creation and sharing is the core differentiator - teams can extract, annotate, and distribute specific moments as short videos. Read AI has no clip sharing feature.'),
  ('Engagement Analytics', 1, 5, 'Read AI tracks participation rates, speaking time, sentiment, and meeting scores. Grain has no engagement analytics - it is focused on content capture and sharing.'),
  ('CRM Integration', 4, 3, 'Grain syncs clips and summaries to Salesforce and HubSpot automatically. Read AI has CRM integration but it is less central to the product experience.'),
  ('Bot Requirement', 3, 5, 'Read AI processes audio directly without a bot joining the call - fully invisible to other participants. Grain requires a bot participant, which is visible to all attendees.'),
  ('Free Tier Generosity', 4, 3, 'Grain offers unlimited recordings with 10-hour storage on the free plan. Read AI free tier is more limited in recording volume and report depth.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'grain-vs-read-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'grain-vs-read-ai');

-- 2. chorus-vs-modjo
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'chorus-vs-modjo', 'chorus', 'modjo',
  'Chorus and Modjo are both sales conversation intelligence platforms, but they target different ends of the market. Chorus, owned by ZoomInfo, is an enterprise platform with deep CRM integrations, deal risk analysis, and team coaching at scale. Modjo is a leaner, faster-to-deploy alternative that delivers the core conversation intelligence features - call recording, topic detection, coaching notes - at a price point and complexity level that works for SMB sales teams. For companies with a mature sales tech stack and 50+ reps, Chorus offers more depth. For teams of 5 to 30 reps who want conversation intelligence without enterprise procurement cycles, Modjo is the more practical choice.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chorus-vs-modjo');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'chorus-vs-modjo', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Sales-Specific AI Analysis', 5, 4, 'Chorus identifies objections, competitor mentions, pricing discussions, and buying signals with AI trained on large enterprise sales call datasets. Modjo covers similar topics but with less depth on deal risk signals.'),
  ('CRM Integration Depth', 5, 3, 'Chorus integrates deeply with Salesforce, including deal health scoring and pipeline activity syncing. Modjo integrates with major CRMs but without the same level of deal intelligence automation.'),
  ('Coaching and Scorecards', 5, 4, 'Chorus call scorecards and coaching playlists are mature features designed for formal sales management at scale. Modjo coaching is solid but lighter on structured methodology enforcement.'),
  ('Implementation Speed', 2, 5, 'Modjo is typically live within a day. Chorus enterprise onboarding involves procurement, security review, and configuration that can take weeks to months.'),
  ('Pricing Accessibility', 1, 4, 'Chorus pricing is enterprise-tier, often $1,000+ per user per year. Modjo is significantly more affordable for small teams without disclosing exact pricing.'),
  ('Team Analytics', 5, 3, 'Chorus team analytics are comprehensive - topic trends across all reps, win/loss pattern analysis, and deal progression correlation. Modjo analytics cover key topics but with less statistical depth.'),
  ('SMB Fit', 2, 5, 'Modjo is specifically designed for the needs and budget of small to mid-size sales teams. Chorus is over-engineered and over-priced for teams below ~50 reps.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chorus-vs-modjo')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'chorus-vs-modjo');

-- 3. jamie-vs-meetgeek
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'jamie-vs-meetgeek', 'jamie', 'meetgeek',
  'Jamie and Meetgeek are both lightweight meeting assistants but with fundamentally different approaches. Jamie is a desktop app that works without ever joining as a bot - it records audio locally and processes it without a visible participant in the call, making it invisible to other attendees. Meetgeek joins as a bot participant, automates calendar-based attendance, and integrates with project management and CRM tools for automatic note distribution. Jamie wins for individuals who need an invisible, private assistant that works across all meeting formats including in-person. Meetgeek wins for teams who want automation across all recurring meetings with zero per-meeting effort.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'jamie-vs-meetgeek');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'jamie-vs-meetgeek', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Bot-Free Operation', 5, 1, 'Jamie requires no bot and leaves no trace in the meeting - participants cannot tell it is being used. Meetgeek joins as a named bot participant visible to everyone in the call.'),
  ('Works for In-Person Meetings', 5, 1, 'Jamie captures audio from the device microphone, making it work for in-person conversations, phone calls, and any format. Meetgeek only works with video conferencing platforms.'),
  ('Team Automation', 2, 5, 'Meetgeek integrates with Google Calendar and Outlook to join every scheduled meeting automatically. Jamie requires manual activation for each meeting.'),
  ('Integration Ecosystem', 2, 5, 'Meetgeek distributes notes automatically to Slack, Notion, HubSpot, Trello, and Asana. Jamie exports notes but has fewer native integrations for automated distribution.'),
  ('Summary Quality', 4, 4, 'Both produce clean, concise summaries focused on decisions and action items. Jamie summaries are slightly more concise; Meetgeek uses meeting-type templates that improve structure.'),
  ('Meeting Templates', 2, 5, 'Meetgeek offers pre-built templates for one-on-ones, sprint planning, sales calls, and other recurring formats. Jamie uses a single summary format for all meeting types.'),
  ('Pricing', 4, 4, 'Jamie free plan is limited to a few summaries per month; paid from $24/month. Meetgeek free plan is more generous; paid from $15/user/month for team features.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'jamie-vs-meetgeek')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'jamie-vs-meetgeek');

-- 4. notta-vs-tactiq
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'notta-vs-tactiq', 'notta', 'tactiq',
  'Notta and Tactiq are both transcription-focused meeting tools, but they serve different workflows. Notta is a standalone transcription platform that handles audio files, live recording, and YouTube video transcription in 58 languages - built for anyone who processes audio content at volume. Tactiq is a browser extension that works inside Zoom, Google Meet, and Microsoft Teams, adding a live transcript sidebar to the call with one-click export to project tools. Notta wins for high-volume transcription workflows and multilingual content. Tactiq wins for anyone who wants the simplest possible Zoom or Meet integration with minimal setup.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'notta-vs-tactiq');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'notta-vs-tactiq', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Language Support', 5, 2, 'Notta supports 58 languages with one-click translation. Tactiq supports English and a handful of major European languages - not suitable for multilingual transcription.'),
  ('Setup Simplicity', 3, 5, 'Tactiq is a browser extension that works in 60 seconds - install and it appears inside your next Zoom or Meet call. Notta requires account setup and has more configuration options.'),
  ('Audio File Transcription', 5, 1, 'Notta transcribes uploaded audio and video files, making it useful outside of live meetings. Tactiq only works for live video call transcription.'),
  ('Live Call Integration', 3, 5, 'Tactiq shows a live transcript sidebar during the call and lets you annotate in real time. Notta processes recordings after the fact rather than providing a live view during the call.'),
  ('Export Integrations', 3, 4, 'Tactiq exports directly to Notion, Jira, Salesforce, and Slack in one click. Notta export is solid but has fewer one-click integrations for project management tools.'),
  ('Price', 4, 4, 'Notta free tier includes 120 minutes/month; paid from $13.99/month. Tactiq free tier is limited; paid from $12/month. Both are affordable at individual scale.'),
  ('Use Case Breadth', 5, 2, 'Notta works for meetings, audio files, YouTube, podcasts, and any audio source. Tactiq is specifically a video call transcription tool and does nothing else.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'notta-vs-tactiq')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'notta-vs-tactiq');

-- 5. sembly-ai-vs-airgram
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'sembly-ai-vs-airgram', 'sembly-ai', 'airgram',
  'Sembly AI and Airgram are both full-featured meeting assistants, but with different strengths. Sembly AI leads on multilingual support and structured AI reporting - it processes meetings in 40+ languages and produces reports that separately flag decisions, risks, and commitments alongside the transcript. Airgram leads on collaborative meeting management - shared agendas, inline note-taking during calls, and collaborative meeting docs as the output. Sembly wins for global teams that need multilingual accuracy and structured reports. Airgram wins for teams that want the full meeting workflow from agenda to follow-up in one shared document.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sembly-ai-vs-airgram');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sembly-ai-vs-airgram', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Language Support', 5, 2, 'Sembly AI handles 40+ languages and mixed-language conversations where participants switch mid-call. Airgram focuses on English with limited multilingual support.'),
  ('Structured AI Reports', 5, 3, 'Sembly separates decisions, risks, and commitments from general discussion in its reports - useful for formal meeting records. Airgram summaries are well-organised but less granularly categorised.'),
  ('Pre-Meeting Agenda Collaboration', 2, 5, 'Airgram''s shared agenda builder lets teams prepare discussion points together before the call. Sembly has no pre-meeting collaboration features.'),
  ('Inline Note-Taking During Calls', 2, 5, 'Airgram lets participants add typed notes and action items directly during the meeting, which appear in the final doc. Sembly captures everything through AI without manual input.'),
  ('Meeting Doc Output', 3, 5, 'Airgram produces a full collaborative meeting document with agenda, notes, transcript, and action items in one place. Sembly produces a structured report but not a shared team document.'),
  ('Integration Ecosystem', 3, 4, 'Airgram integrates with Google Calendar, Outlook, Zoom, and Meet with Slack and Notion export. Sembly integrates with calendar tools and major conferencing platforms with similar breadth.'),
  ('Free Tier', 4, 4, 'Both tools offer free plans with meaningful limits for individual use before requiring a paid upgrade for team features.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sembly-ai-vs-airgram')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sembly-ai-vs-airgram');
