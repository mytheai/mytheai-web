-- compare-batch-28.sql
-- 5 comparison pairs: AI productivity tools (email clients, task managers, scheduling)
-- All pairs use tools confirmed in DB before or after tools-batch-28 runs
-- Run AFTER tools-batch-28.sql has been confirmed in DB
-- Safe to re-run: WHERE NOT EXISTS guards on all inserts

-- Pairs:
-- 1. superhuman-vs-shortwave (batch-28 both)
-- 2. todoist-vs-ticktick (batch-28 both)
-- 3. cal-com-vs-savvycal (batch-28 both)
-- 4. clockwise-vs-reclaim-ai (clockwise batch-28, reclaim-ai batch-10)
-- 5. sunsama-vs-motion (sunsama batch-28, motion batch-10)
-- NOTE: motion-vs-reclaim-ai already exists in compare-batch-10.sql - NOT added here

-- ============================================================
-- 1. superhuman-vs-shortwave
-- ============================================================
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT
  'superhuman-vs-shortwave',
  'superhuman',
  'shortwave',
  'Superhuman vs Shortwave is the premium AI email client head-to-head. Superhuman is the fastest email client available, built for keyboard-driven power users with the budget to pay for speed and AI. Shortwave brings meaningful AI features to Gmail at a fraction of the price, making it the best choice for most professionals. The right pick depends on how central email is to your day and how much you value raw speed vs cost efficiency.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'superhuman-vs-shortwave');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'superhuman-vs-shortwave', 'Speed and keyboard shortcuts', 5, 3, 'Superhuman is engineered around sub-1-second keyboard actions; Shortwave adds shortcuts but does not match Superhuman''s speed engineering'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'superhuman-vs-shortwave' AND name = 'Speed and keyboard shortcuts');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'superhuman-vs-shortwave', 'AI reply drafting', 5, 4, 'Both draft replies and summarise threads; Superhuman''s AI is more tightly integrated into the keyboard flow'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'superhuman-vs-shortwave' AND name = 'AI reply drafting');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'superhuman-vs-shortwave', 'Inbox organisation', 5, 4, 'Superhuman''s triage system and split inbox are more mature; Shortwave''s bundling and AI prioritisation are competitive'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'superhuman-vs-shortwave' AND name = 'Inbox organisation');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'superhuman-vs-shortwave', 'Value for money', 2, 5, 'Superhuman costs $30/month with no free tier; Shortwave offers a generous free tier and Pro at $9/month'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'superhuman-vs-shortwave' AND name = 'Value for money');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'superhuman-vs-shortwave', 'Gmail integration', 4, 5, 'Both work on Gmail; Shortwave is purpose-built as a Gmail layer with deeper Gmail-native features'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'superhuman-vs-shortwave' AND name = 'Gmail integration');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'superhuman-vs-shortwave', 'Onboarding experience', 5, 3, 'Superhuman''s personalised human-led onboarding is exceptional; Shortwave is self-serve with standard setup'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'superhuman-vs-shortwave' AND name = 'Onboarding experience');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'superhuman-vs-shortwave', 'Team and collaboration features', 3, 3, 'Neither excels at team collaboration - both are primarily individual email clients'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'superhuman-vs-shortwave' AND name = 'Team and collaboration features');

-- ============================================================
-- 2. todoist-vs-ticktick
-- ============================================================
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT
  'todoist-vs-ticktick',
  'todoist',
  'ticktick',
  'Todoist vs TickTick is the closest contest in personal task management. Todoist wins on polish, reliability, and integrations. TickTick wins on breadth, offering a built-in calendar, habit tracker, and Pomodoro timer that Todoist lacks. If you want the best pure task manager, choose Todoist. If you want fewer separate apps for your productivity stack, choose TickTick.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'todoist-vs-ticktick');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'todoist-vs-ticktick', 'Task management depth', 5, 4, 'Todoist''s project hierarchy, filters, and labels are more powerful for complex task organisation'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'todoist-vs-ticktick' AND name = 'Task management depth');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'todoist-vs-ticktick', 'Built-in calendar view', 2, 5, 'TickTick includes a full calendar view integrated with tasks; Todoist requires a third-party calendar integration'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'todoist-vs-ticktick' AND name = 'Built-in calendar view');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'todoist-vs-ticktick', 'Habit tracking', 1, 5, 'TickTick has a dedicated habit tracker built in; Todoist has no native habit tracking'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'todoist-vs-ticktick' AND name = 'Habit tracking');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'todoist-vs-ticktick', 'Integration ecosystem', 5, 3, 'Todoist integrates with 60+ apps including Slack, GitHub, and Google Calendar natively; TickTick integrations are more limited'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'todoist-vs-ticktick' AND name = 'Integration ecosystem');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'todoist-vs-ticktick', 'AI features', 4, 4, 'Both offer natural language task input and AI suggestions; neither has a significant AI advantage in 2026'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'todoist-vs-ticktick' AND name = 'AI features');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'todoist-vs-ticktick', 'Free tier value', 4, 5, 'TickTick''s free tier includes more features including calendar; Todoist''s free tier limits to 5 active projects'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'todoist-vs-ticktick' AND name = 'Free tier value');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'todoist-vs-ticktick', 'Platform and device support', 5, 5, 'Both support iOS, Android, macOS, Windows, and web with excellent sync; this is a draw'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'todoist-vs-ticktick' AND name = 'Platform and device support');

-- ============================================================
-- 3. cal-com-vs-savvycal
-- ============================================================
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT
  'cal-com-vs-savvycal',
  'cal-com',
  'savvycal',
  'Cal.com vs Savvycal represents two different philosophies in scheduling tools. Cal.com is the open-source Calendly alternative that prioritises flexibility, control, and enterprise features at a lower price. Savvycal is the premium experience tool that makes scheduling dramatically better for the person receiving the booking link. If you value control and team features, choose Cal.com. If you want the best booking experience for your clients, choose Savvycal.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'cal-com-vs-savvycal');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cal-com-vs-savvycal', 'Invitee booking experience', 3, 5, 'Savvycal shows invitees their own calendar overlaid with your availability - a meaningfully better experience for the recipient'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cal-com-vs-savvycal' AND name = 'Invitee booking experience');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cal-com-vs-savvycal', 'Open-source and self-hosting', 5, 1, 'Cal.com is fully open-source with a strong self-hosted option; Savvycal is closed-source SaaS only'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cal-com-vs-savvycal' AND name = 'Open-source and self-hosting');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cal-com-vs-savvycal', 'Team and round-robin scheduling', 5, 3, 'Cal.com has more mature team routing features including round-robin, collective, and managed event types'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cal-com-vs-savvycal' AND name = 'Team and round-robin scheduling');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cal-com-vs-savvycal', 'Integration breadth', 5, 3, 'Cal.com integrates with 100+ apps; Savvycal covers the core calendar and video conferencing integrations'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cal-com-vs-savvycal' AND name = 'Integration breadth');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cal-com-vs-savvycal', 'Interface polish', 3, 5, 'Savvycal''s interface is the cleanest in the scheduling category; Cal.com''s UI has improved but remains more complex'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cal-com-vs-savvycal' AND name = 'Interface polish');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cal-com-vs-savvycal', 'Pricing value', 5, 4, 'Cal.com offers a strong free tier and competitive paid plans; Savvycal starts at $12/month with no free tier for full features'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cal-com-vs-savvycal' AND name = 'Pricing value');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cal-com-vs-savvycal', 'Privacy and data control', 5, 3, 'Cal.com self-hosting keeps all booking data on your infrastructure; Savvycal is SaaS with standard data processing'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cal-com-vs-savvycal' AND name = 'Privacy and data control');

-- ============================================================
-- 4. clockwise-vs-reclaim-ai
-- ============================================================
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT
  'clockwise-vs-reclaim-ai',
  'clockwise',
  'reclaim-ai',
  'Clockwise vs Reclaim.ai are the two leading AI calendar optimisation tools, but they solve subtly different problems. Clockwise focuses on teams - it analyses your entire organisation''s calendar to move meetings and create shared focus time. Reclaim focuses on individuals and small teams - it defends your personal time by scheduling habits, tasks, and focus blocks automatically. The right choice depends on whether your pain is team coordination or personal time protection.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'clockwise-vs-reclaim-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clockwise-vs-reclaim-ai', 'Team calendar optimisation', 5, 3, 'Clockwise is built specifically for teams and analyses the whole org''s calendar; Reclaim''s team features are secondary to individual scheduling'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clockwise-vs-reclaim-ai' AND name = 'Team calendar optimisation');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clockwise-vs-reclaim-ai', 'Individual focus time protection', 3, 5, 'Reclaim automatically creates and defends focus blocks with high intelligence; Clockwise does this but with less granular personal control'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clockwise-vs-reclaim-ai' AND name = 'Individual focus time protection');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clockwise-vs-reclaim-ai', 'Task scheduling integration', 2, 5, 'Reclaim syncs tasks from Asana, Todoist, and Linear and auto-schedules them; Clockwise does not handle task scheduling'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clockwise-vs-reclaim-ai' AND name = 'Task scheduling integration');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clockwise-vs-reclaim-ai', 'Habit scheduling', 2, 5, 'Reclaim auto-schedules recurring habits like lunch, gym, and reading; Clockwise does not have habit scheduling'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clockwise-vs-reclaim-ai' AND name = 'Habit scheduling');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clockwise-vs-reclaim-ai', 'Meeting analytics and reporting', 5, 3, 'Clockwise provides rich team-level analytics on meeting load and focus time; Reclaim reporting is more personal'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clockwise-vs-reclaim-ai' AND name = 'Meeting analytics and reporting');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clockwise-vs-reclaim-ai', 'Free tier availability', 4, 5, 'Both have free tiers; Reclaim''s free tier is more generous for individual use'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clockwise-vs-reclaim-ai' AND name = 'Free tier availability');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clockwise-vs-reclaim-ai', 'Calendar provider support', 4, 4, 'Both support Google Calendar well; Clockwise has better Outlook/Office 365 support; Reclaim supports both adequately'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clockwise-vs-reclaim-ai' AND name = 'Calendar provider support');

-- ============================================================
-- 5. sunsama-vs-motion
-- ============================================================
INSERT INTO comparisons (slug, tool_a, tool_b, summary, winner, updated_at)
SELECT
  'sunsama-vs-motion',
  'sunsama',
  'motion',
  'Sunsama vs Motion is a philosophical difference as much as a product difference. Motion fully automates your schedule - it fills your calendar with tasks automatically and reschedules everything when plans change. Sunsama guides a daily planning ritual where you make intentional choices about what to do and when. Motion is for people who want AI to take over scheduling. Sunsama is for people who want AI to support better human decisions.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sunsama-vs-motion');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sunsama-vs-motion', 'Automation level', 2, 5, 'Motion fully automates task scheduling into calendar slots; Sunsama guides manual daily planning with AI assistance'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sunsama-vs-motion' AND name = 'Automation level');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sunsama-vs-motion', 'Daily planning ritual', 5, 2, 'Sunsama is built around structured morning and evening planning sessions; Motion eliminates this ritual by automating decisions'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sunsama-vs-motion' AND name = 'Daily planning ritual');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sunsama-vs-motion', 'Task source integrations', 5, 4, 'Sunsama pulls from Asana, Jira, Linear, Notion, GitHub, and Gmail; Motion covers the most common tools but has fewer sources'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sunsama-vs-motion' AND name = 'Task source integrations');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sunsama-vs-motion', 'Calendar fill and conflict handling', 2, 5, 'Motion automatically reschedules tasks when meetings move or work takes longer; Sunsama requires manual replanning'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sunsama-vs-motion' AND name = 'Calendar fill and conflict handling');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sunsama-vs-motion', 'Meeting scheduling', 3, 5, 'Motion includes a full meeting scheduler; Sunsama focuses on task planning and does not include booking links'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sunsama-vs-motion' AND name = 'Meeting scheduling');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sunsama-vs-motion', 'Intentional work culture fit', 5, 2, 'Sunsama is explicitly built for intentional, sustainable work practices; Motion''s automation can feel reactive rather than reflective'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sunsama-vs-motion' AND name = 'Intentional work culture fit');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sunsama-vs-motion', 'Pricing', 3, 3, 'Sunsama is $20/month; Motion is $19/month individual; both are premium tools with no meaningful free tier'
WHERE NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sunsama-vs-motion' AND name = 'Pricing');
