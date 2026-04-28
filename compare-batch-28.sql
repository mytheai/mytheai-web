-- compare-batch-28.sql
-- 5 comparison pairs: AI productivity tools (email clients, task managers, scheduling)
-- All pairs use tools confirmed in DB after tools-batch-28 runs
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria
-- NOTE: motion-vs-reclaim-ai already exists in compare-batch-10.sql - NOT added here

-- Pair 1: superhuman-vs-shortwave
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'superhuman-vs-shortwave',
  'superhuman',
  'shortwave',
  'Superhuman vs Shortwave is the premium AI email client head-to-head. Superhuman is the fastest email client available, built for keyboard-driven power users willing to pay $30/month for speed and AI. Shortwave brings meaningful AI features to Gmail at a fraction of the price, making it the best choice for most professionals. Superhuman wins on raw speed, polish, and onboarding quality. Shortwave wins on value, free tier, and Gmail-native depth. The right pick depends on how central email is to your workflow and how much you value speed vs cost.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'superhuman-vs-shortwave', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Speed and keyboard shortcuts', 5, 3, 'Superhuman is engineered around sub-1-second keyboard actions; Shortwave adds shortcuts but does not match Superhuman''s speed engineering'),
  ('AI reply drafting', 5, 4, 'Both draft replies and summarise threads; Superhuman''s AI is more tightly integrated into the keyboard flow'),
  ('Inbox organisation', 5, 4, 'Superhuman''s triage system and split inbox are more mature; Shortwave''s bundling and AI prioritisation are competitive'),
  ('Value for money', 2, 5, 'Superhuman costs $30/month with no free tier; Shortwave offers a generous free tier and Pro at $9/month'),
  ('Gmail integration', 4, 5, 'Both work on Gmail; Shortwave is purpose-built as a Gmail layer with deeper Gmail-native features'),
  ('Onboarding experience', 5, 3, 'Superhuman''s personalised human-led onboarding is exceptional; Shortwave is self-serve with standard setup'),
  ('Team and collaboration features', 3, 3, 'Neither excels at team collaboration - both are primarily individual email clients')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'superhuman-vs-shortwave')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'superhuman-vs-shortwave');

-- Pair 2: todoist-vs-ticktick
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'todoist-vs-ticktick',
  'todoist',
  'ticktick',
  'Todoist vs TickTick is the closest contest in personal task management. Todoist wins on polish, reliability, and integrations. TickTick wins on breadth - it includes a built-in calendar, habit tracker, and Pomodoro timer that Todoist lacks. If you want the best pure task manager, choose Todoist. If you want fewer separate apps for your productivity stack, choose TickTick.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'todoist-vs-ticktick', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Task management depth', 5, 4, 'Todoist''s project hierarchy, filters, and labels are more powerful for complex task organisation'),
  ('Built-in calendar view', 2, 5, 'TickTick includes a full calendar view integrated with tasks; Todoist requires a third-party calendar integration'),
  ('Habit tracking', 1, 5, 'TickTick has a dedicated habit tracker built in; Todoist has no native habit tracking'),
  ('Integration ecosystem', 5, 3, 'Todoist integrates with 60+ apps including Slack, GitHub, and Google Calendar natively; TickTick integrations are more limited'),
  ('AI features', 4, 4, 'Both offer natural language task input and AI suggestions; neither has a significant AI advantage in 2026'),
  ('Free tier value', 4, 5, 'TickTick''s free tier includes more features including calendar; Todoist''s free tier limits to 5 active projects'),
  ('Platform and device support', 5, 5, 'Both support iOS, Android, macOS, Windows, and web with excellent sync - this is a draw')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'todoist-vs-ticktick')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'todoist-vs-ticktick');

-- Pair 3: cal-com-vs-savvycal
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'cal-com-vs-savvycal',
  'cal-com',
  'savvycal',
  'Cal.com vs Savvycal represents two different philosophies in scheduling tools. Cal.com is the open-source Calendly alternative that prioritises flexibility, control, and enterprise features at a lower price. Savvycal is the premium experience tool that makes scheduling dramatically better for the person receiving the booking link. If you value control and team features, choose Cal.com. If you want the best booking experience for your clients, choose Savvycal.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cal-com-vs-savvycal', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Invitee booking experience', 3, 5, 'Savvycal shows invitees their own calendar overlaid with your availability - a meaningfully better experience for the recipient'),
  ('Open-source and self-hosting', 5, 1, 'Cal.com is fully open-source with a strong self-hosted option; Savvycal is closed-source SaaS only'),
  ('Team and round-robin scheduling', 5, 3, 'Cal.com has more mature team routing features including round-robin, collective, and managed event types'),
  ('Integration breadth', 5, 3, 'Cal.com integrates with 100+ apps; Savvycal covers the core calendar and video conferencing integrations'),
  ('Interface polish', 3, 5, 'Savvycal''s interface is the cleanest in the scheduling category; Cal.com''s UI has improved but remains more complex'),
  ('Pricing value', 5, 4, 'Cal.com offers a strong free tier and competitive paid plans; Savvycal starts at $12/month with no free tier for full features'),
  ('Privacy and data control', 5, 3, 'Cal.com self-hosting keeps all booking data on your infrastructure; Savvycal is SaaS with standard data processing')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'cal-com-vs-savvycal')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cal-com-vs-savvycal');

-- Pair 4: clockwise-vs-reclaim-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'clockwise-vs-reclaim-ai',
  'clockwise',
  'reclaim-ai',
  'Clockwise vs Reclaim.ai are the two leading AI calendar optimisation tools, but they solve subtly different problems. Clockwise focuses on teams - it analyses your entire organisation''s calendar to move meetings and create shared focus time. Reclaim focuses on individuals and small teams - it defends your personal time by scheduling habits, tasks, and focus blocks automatically. The right choice depends on whether your pain is team coordination or personal time protection.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clockwise-vs-reclaim-ai', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Team calendar optimisation', 5, 3, 'Clockwise is built specifically for teams and analyses the whole org''s calendar; Reclaim''s team features are secondary to individual scheduling'),
  ('Individual focus time protection', 3, 5, 'Reclaim automatically creates and defends focus blocks with high intelligence; Clockwise does this but with less granular personal control'),
  ('Task scheduling integration', 2, 5, 'Reclaim syncs tasks from Asana, Todoist, and Linear and auto-schedules them; Clockwise does not handle task scheduling'),
  ('Habit scheduling', 2, 5, 'Reclaim auto-schedules recurring habits like lunch, gym, and reading; Clockwise does not have habit scheduling'),
  ('Meeting analytics and reporting', 5, 3, 'Clockwise provides rich team-level analytics on meeting load and focus time; Reclaim reporting is more personal'),
  ('Free tier availability', 4, 5, 'Both have free tiers; Reclaim''s free tier is more generous for individual use'),
  ('Calendar provider support', 4, 4, 'Both support Google Calendar well; Clockwise has better Outlook/Office 365 support; Reclaim supports both adequately')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'clockwise-vs-reclaim-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clockwise-vs-reclaim-ai');

-- Pair 5: sunsama-vs-motion
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'sunsama-vs-motion',
  'sunsama',
  'motion',
  'Sunsama vs Motion is a philosophical difference as much as a product difference. Motion fully automates your schedule - it fills your calendar with tasks automatically and reschedules everything when plans change. Sunsama guides a daily planning ritual where you make intentional choices about what to do and when. Motion is for people who want AI to take over scheduling. Sunsama is for people who want AI to support better human decisions.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sunsama-vs-motion', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Automation level', 2, 5, 'Motion fully automates task scheduling into calendar slots; Sunsama guides manual daily planning with AI assistance'),
  ('Daily planning ritual', 5, 2, 'Sunsama is built around structured morning and evening planning sessions; Motion eliminates this ritual by automating decisions'),
  ('Task source integrations', 5, 4, 'Sunsama pulls from Asana, Jira, Linear, Notion, GitHub, and Gmail; Motion covers the most common tools but has fewer sources'),
  ('Calendar fill and conflict handling', 2, 5, 'Motion automatically reschedules tasks when meetings move or work takes longer; Sunsama requires manual replanning'),
  ('Meeting scheduling', 3, 5, 'Motion includes a full meeting scheduler; Sunsama focuses on task planning and does not include booking links'),
  ('Intentional work culture fit', 5, 2, 'Sunsama is explicitly built for intentional, sustainable work practices; Motion''s automation can feel reactive rather than reflective'),
  ('Pricing', 3, 3, 'Sunsama is $20/month; Motion is $19/month individual; both are premium tools with no meaningful free tier')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sunsama-vs-motion')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sunsama-vs-motion');
