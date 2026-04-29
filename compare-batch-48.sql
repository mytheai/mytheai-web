-- compare-batch-48.sql
-- 5 AI UX Research tool comparison pairs
-- All tools from tools-batch-48 (confirmed in DB after running that batch)
-- Run AFTER tools-batch-48 confirmed in Supabase
-- Slugs used: dovetail, maze, sprig, lyssna, lookback, optimal-workshop, userlytics, dscout

-- 1. dovetail-vs-maze
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'dovetail-vs-maze', 'dovetail', 'maze',
  'Dovetail and Maze serve fundamentally different research needs, even though both are used by product and design teams. Dovetail is a research repository and qualitative analysis platform - it synthesises insights from interviews, surveys, and support data into a searchable knowledge base that the whole organisation can access. Maze is a rapid unmoderated testing platform - it runs prototype tests and usability studies and delivers quantitative task data within hours. Dovetail wins for teams doing ongoing qualitative research that needs to be shared, organised, and acted on across the organisation. Maze wins for teams that need fast, quantitative usability validation of a specific prototype or design decision without scheduling sessions. Many mature product teams use both: Maze for rapid testing and Dovetail to store and synthesise the insights that come out of it.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'dovetail-vs-maze');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'dovetail-vs-maze', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Research Repository', 5, 1, 'Dovetail is built specifically to store, tag, and surface insights from any research source - interviews, surveys, support data, and NPS. Maze has no repository function - results stay in the study and are not aggregated across research rounds.'),
  ('Prototype Testing Speed', 2, 5, 'Maze delivers prototype test results with task success rates, heatmaps, and misclick data within hours from a built-in panel. Dovetail does not run usability tests - it analyses data from tools like Maze after the fact.'),
  ('Qualitative AI Analysis', 5, 3, 'Dovetail AI automatically themes and tags qualitative data across hundreds of interview transcripts and open responses. Maze AI summarises open-text responses per study but does not synthesise across multiple research rounds.'),
  ('Quantitative Task Data', 1, 5, 'Maze records task success rates, time-on-task, misclick rates, and heatmaps per participant - all quantitative, immediately actionable metrics. Dovetail handles qualitative synthesis, not quantitative measurement.'),
  ('Team Access to Insights', 5, 3, 'Dovetail is designed so any team member - product, engineering, design, or leadership - can search and discover customer evidence without researcher mediation. Maze results are typically reviewed by the researcher and shared manually.'),
  ('Participant Panel', 1, 5, 'Maze has a built-in panel of 100,000 plus participants for unmoderated tests - no recruitment needed. Dovetail requires participants to already be recruited and research already conducted to have data to analyse.'),
  ('Pricing', 4, 3, 'Dovetail has a free plan with reasonable limits for small teams. Maze free plan allows limited tests; paid plans start around $99 per month for meaningful usage - higher entry cost than Dovetail for basic research needs.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'dovetail-vs-maze')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'dovetail-vs-maze');

-- 2. sprig-vs-lyssna
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'sprig-vs-lyssna', 'sprig', 'lyssna',
  'Sprig and Lyssna both collect user feedback, but from completely different positions in the user journey. Sprig captures feedback from users who are currently using your product - in-product micro-surveys embedded in the product experience itself. Lyssna captures feedback from recruited participants who are shown designs or prototypes in a structured research session outside the product. Sprig wins for product teams running continuous discovery on their active user base - ongoing NPS, feature satisfaction surveys, and churn exit questions triggered by real user behaviour. Lyssna wins for design teams that need to validate a new design, landing page, or concept with external participants before it goes into the product - preference tests, first-click tests, and five-second tests for rapid pre-launch validation.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sprig-vs-lyssna');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sprig-vs-lyssna', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('In-Product Feedback', 5, 1, 'Sprig embeds surveys and micro-questions directly inside the product experience, triggered by user actions. Lyssna is an external research platform - participants are recruited and directed to a test link outside the product.'),
  ('Design Validation Speed', 2, 5, 'Lyssna preference tests, first-click tests, and five-second tests deliver results from a 690,000-plus participant panel within hours. Sprig is not designed for pre-launch design validation - it requires the product to be live.'),
  ('Continuous Discovery', 5, 1, 'Sprig runs permanent in-product surveys generating ongoing user intelligence without scheduling research sessions. Lyssna runs discrete studies on demand - it is not an always-on continuous feedback system.'),
  ('Participant Access', 3, 5, 'Lyssna panel of 690,000 plus participants with demographic filtering removes recruitment friction for external studies. Sprig uses your own product users as the participant pool - valuable but only accessible post-launch.'),
  ('AI Analysis', 4, 4, 'Both tools have AI that processes open-text responses and surfaces themes. Sprig AI analyses in-product responses at scale. Lyssna AI generates test summaries and key finding highlights across study participants.'),
  ('Session Recording', 4, 2, 'Sprig includes session recordings and heatmaps alongside in-product survey data, combining behavioural and attitudinal signals. Lyssna does not include session recording as part of its core feature set.'),
  ('Pricing', 3, 4, 'Lyssna has a free plan with meaningful functionality for small design teams. Sprig free plan is available but meaningful usage for active products requires a paid plan starting around $175 per month.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sprig-vs-lyssna')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sprig-vs-lyssna');

-- 3. lookback-vs-userlytics
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'lookback-vs-userlytics', 'lookback', 'userlytics',
  'Lookback and Userlytics both conduct remote user research, but they serve different scale and budget profiles. Lookback is a research quality platform for teams conducting high-value moderated and unmoderated sessions where the nuance of participant reactions is essential - ideal for qualitative research with 5 to 15 participants. Userlytics is an enterprise platform for large-scale studies reaching hundreds of participants across global markets, with AI video analysis that identifies sentiment and confusion patterns without watching every session. Lookback wins for teams prioritising session quality, researcher control, and the depth of moderated interviews. Userlytics wins for enterprise teams that need to run large-scale international studies with detailed demographic targeting and comprehensive video analysis across many sessions simultaneously.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lookback-vs-userlytics');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'lookback-vs-userlytics', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Moderated Session Quality', 5, 4, 'Lookback provides simultaneous screen, face, and audio capture with real-time researcher annotation - designed for high-quality moderated session depth. Userlytics supports moderated sessions but the platform is optimised for unmoderated scale.'),
  ('Participant Scale', 2, 5, 'Userlytics panel of 2 million plus participants enables large-scale international studies across languages, countries, and demographic profiles. Lookback is suited to studies of 5 to 20 participants, not mass-scale research.'),
  ('AI Video Analysis', 2, 5, 'Userlytics AI analyses session videos to detect sentiment, flag moments of confusion, and generate cross-session summaries without watching every recording. Lookback does not have comparable automated video analysis at scale.'),
  ('Participant Price per Session', 4, 2, 'Lookback session costs are lower for small-scale research - it does not require enterprise-level participant recruitment budgets. Userlytics per-participant pricing for specialist professional profiles can be significant.'),
  ('Highlight Reel Creation', 5, 3, 'Lookback highlight reel feature compiles key moments from multiple sessions into a short evidence video for stakeholder communication. Userlytics has clip sharing but highlight reel creation is less streamlined.'),
  ('Enterprise Compliance', 2, 5, 'Userlytics enterprise plan includes custom SLAs, dedicated customer success management, and integration with enterprise research stacks and data warehouses. Lookback is not positioned for enterprise compliance requirements.'),
  ('Free Plan', 1, 1, 'Neither Lookback nor Userlytics offers a free plan. Lookback starts from $25 per month; Userlytics enterprise pricing requires a sales conversation.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lookback-vs-userlytics')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lookback-vs-userlytics');

-- 4. optimal-workshop-vs-maze
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'optimal-workshop-vs-maze', 'optimal-workshop', 'maze',
  'Optimal Workshop and Maze both run unmoderated user tests, but they focus on different research questions. Optimal Workshop is the specialist platform for information architecture research - treejack tests that validate navigation structures, card sorting studies that reveal user mental models, and first-click tests that confirm whether labels lead users where they expect to go. Maze is a general-purpose usability testing platform covering prototype testing, task-based usability studies, tree testing, card sorting, and surveys in one tool. Optimal Workshop wins when information architecture research is the primary need and statistical rigor matters - dendrograms, agreement scores, and IA-specific analysis are stronger than Maze. Maze wins when the team needs to validate both the IA and the visual prototype design in one platform, or when speed and an integrated prototype connection to Figma are the priority.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'optimal-workshop-vs-maze');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'optimal-workshop-vs-maze', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Tree Testing Depth', 5, 3, 'Optimal Workshop Treejack provides detailed IA analysis with success rates, directness scores, and path visualisation. Maze tree testing covers the basics but with less IA-specific statistical depth than Optimal Workshop.'),
  ('Card Sorting Analysis', 5, 3, 'Optimal Workshop card sorting generates dendrograms and agreement scores that make IA grouping decisions defensible. Maze card sorting is solid for quick studies but the analysis output is less statistically rich.'),
  ('Prototype Testing', 1, 5, 'Maze connects directly to Figma prototypes and measures task completion, heatmaps, and misclick rates on interactive designs. Optimal Workshop does not support prototype testing.'),
  ('Platform Breadth', 2, 5, 'Maze covers prototype testing, usability studies, surveys, tree testing, and card sorting in one platform. Optimal Workshop is specialised for IA methods and does not cover prototype or task-flow testing.'),
  ('Figma Integration', 1, 5, 'Maze integrates directly with Figma for instant prototype connection. Optimal Workshop has no Figma integration and is not designed for prototype validation workflows.'),
  ('Free Plan', 4, 4, 'Both offer free plans with meaningful but limited functionality for individual researchers and small teams.'),
  ('IA Specialist Credibility', 5, 3, 'Optimal Workshop is the industry-standard tool for IA research - its treejack and card sort outputs are widely recognised as rigorous in the UX research community. Maze IA tools are respected but not the first-choice reference tool for IA specialists.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'optimal-workshop-vs-maze')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'optimal-workshop-vs-maze');

-- 5. dscout-vs-lookback
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'dscout-vs-lookback', 'dscout', 'lookback',
  'Dscout and Lookback both capture user behaviour, but through fundamentally different research paradigms. Dscout captures longitudinal, in-context experiences through diary studies on a mobile app - participants record short video diary entries about their experience using a product or performing a task throughout their daily lives over days or weeks. Lookback captures a single high-quality research session in a video call environment, with the researcher watching in real time or participants recording themselves completing tasks independently. Dscout wins when the research question requires understanding the real-world, over-time experience - how a product fits into a user''s actual routine, what problems emerge over days of use, or what the usage context looks like in natural life. Lookback wins when the research question requires depth and nuance in a single session - understanding why a user struggled with a specific flow, getting at the reasoning behind a decision, or capturing high-quality evidence for stakeholder communication.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'dscout-vs-lookback');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'dscout-vs-lookback', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Longitudinal Research', 5, 1, 'Dscout diary studies run over days or weeks capturing experiences as they happen across a participant''s real life. Lookback sessions are single-session events and do not support longitudinal study designs.'),
  ('In-Context Real World Capture', 5, 2, 'Dscout participants record video diary entries on their phone wherever they are - at work, at home, in transit. Lookback captures a screen and camera session in a controlled environment, not real-world context.'),
  ('Session Quality and Depth', 2, 5, 'Lookback provides high-quality simultaneous screen, face, and audio capture with real-time researcher annotation during moderated sessions. Dscout diary entries are short self-recorded mobile videos with varying quality.'),
  ('Researcher Control', 1, 5, 'Lookback moderated sessions give the researcher full control to probe, redirect, and follow up on interesting behaviour in real time. Dscout diary studies are participant-led - the researcher cannot intervene during data collection.'),
  ('Highlight Reel Creation', 3, 5, 'Lookback highlight reel feature compiles key session moments into a stakeholder-ready evidence video. Dscout has clip sharing but highlight reel creation for stakeholder communication is less developed.'),
  ('Participant Effort Required', 3, 4, 'Lookback requires participants to schedule and attend a session, which creates a recruitment and scheduling burden. Dscout missions are completed in participants'' own time on their own device, which can reduce scheduling friction.'),
  ('Pricing Transparency', 3, 2, 'Lookback has published pricing from $25 per month. Dscout enterprise pricing requires a sales conversation and is typically higher - appropriate for teams with dedicated research budgets.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'dscout-vs-lookback')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'dscout-vs-lookback');
