-- tools-batch-28.sql
-- AI Productivity Tools: task management, calendar intelligence, email, scheduling (10 tools)
-- DB: ~302 tools -> ~312 tools
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING
-- Confirmed NOT in DB: sunsama, akiflow, clockwise, todoist, ticktick, superhuman, shortwave, spark-mail, savvycal, cal-com
-- Already in DB (skipped): motion (batch-10), reclaim-ai (batch-10)

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

-- 1. Sunsama
(
  'sunsama', 'Sunsama', 'Daily planning tool that turns scattered tasks into a focused, time-blocked day',
  'Sunsama is a daily planning application built around the principle of doing fewer things better. Each morning it guides you through a structured planning ritual: reviewing tasks from Asana, Linear, Jira, GitHub, Gmail, Notion, and Todoist, selecting what you will actually work on today, estimating time for each, and time-blocking the day on your calendar. The AI component analyses your task backlog and estimated hours to flag when you are overcommitting - a persistent problem that most task managers ignore entirely. The daily review process is as structured as the morning ritual: you log actual time spent on each task, reflect on what moved forward, and roll incomplete items to the next day with a reason. This combination of structured planning and intentional reflection distinguishes Sunsama from apps that just store tasks. Sunsama integrates with Google Calendar, Outlook, Asana, Linear, Jira, GitHub, Notion, Todoist, Slack, and Gmail. It is popular with individual contributors, founders, and knowledge workers who feel overwhelmed by fragmented to-do lists and want a single place to decide what gets their attention each day. Sunsama is subscription-only with no free tier, reflecting its positioning as a deliberate focus tool rather than a volume productivity platform.',
  'https://www.google.com/s2/favicons?domain=sunsama.com&sz=64',
  'https://sunsama.com', 'https://sunsama.com',
  ARRAY['productivity', 'ai-assistant'],
  'paid', false, 20.00,
  4.6, 890, false, false, false,
  ARRAY['Structured morning planning ritual that builds a focused daily schedule', 'Aggregates tasks from Asana, Jira, Linear, GitHub, Notion, and Gmail into one view', 'Time-blocking on calendar removes ambiguity about when tasks will get done', 'Daily review builds self-awareness about where time actually goes'],
  ARRAY['No free tier - $20/month after trial', 'Requires daily commitment to the ritual to get full value', 'Less useful for teams than for individual knowledge workers'],
  ARRAY['Knowledge workers who feel overwhelmed by fragmented task lists across multiple tools', 'Founders and managers who need to protect deep work time against meeting creep', 'Anyone practicing time-blocking who wants a structured daily planning process']
)
ON CONFLICT (slug) DO NOTHING;

-- 2. Akiflow
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES
(
  'akiflow', 'Akiflow', 'Task and calendar app that captures from anywhere and time-blocks your day automatically',
  'Akiflow is a productivity platform that combines a task manager, time-blocking calendar, and universal inbox into one application. Its core workflow: tasks captured from any source - email, Slack, Jira, Notion, Asana, Trello, GitHub, or directly typed - land in a single inbox. You review the inbox once or twice a day, planning each task by dragging it onto the calendar to time-block it. The AI scheduling assistant can suggest optimal time slots based on your calendar patterns and energy preferences, and can auto-schedule batches of tasks into available calendar slots with one action. Akiflow''s Command Bar - invoked by keyboard shortcut from any application - allows capturing a task, scheduling an event, or searching across all connected apps without switching context. It syncs bidirectionally with Google Calendar and Outlook, meaning time blocks appear as calendar events visible to others for scheduling purposes. The analytics dashboard shows where your time actually went versus where you planned it, surfacing recurring patterns (such as meetings consistently running over their blocks) that compound over time. Akiflow is positioned at the intersection of a serious task manager and a calendar - more structured than Todoist, more flexible than pure time-blocking tools.',
  'https://www.google.com/s2/favicons?domain=akiflow.com&sz=64',
  'https://akiflow.com', 'https://akiflow.com',
  ARRAY['productivity', 'ai-assistant'],
  'paid', false, 19.00,
  4.5, 620, false, false, false,
  ARRAY['Universal inbox captures tasks from 10+ integrations in one place', 'Command Bar works from any app with a keyboard shortcut', 'Bidirectional Google Calendar and Outlook sync for time-blocked tasks', 'Analytics show planned vs actual time use over time'],
  ARRAY['No meaningful free tier', 'Windows desktop app is stronger than the mobile experience', 'Requires consistent daily review habit to stay useful'],
  ARRAY['Developers and knowledge workers capturing tasks from Jira, GitHub, and Slack in one flow', 'People who time-block but need a tool that connects task management and calendar without manual copying', 'Individuals who want analytics on where their working time actually goes']
)
ON CONFLICT (slug) DO NOTHING;

-- 3. Clockwise
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES
(
  'clockwise', 'Clockwise', 'AI calendar assistant that optimises your schedule to protect focus time automatically',
  'Clockwise is an AI-powered calendar assistant that works on top of Google Calendar to automatically optimise your schedule for deep work. It learns your meeting preferences - morning versus afternoon, solo work versus collaboration, commute times, and focus time requirements - and then works continuously in the background to protect blocks of uninterrupted time by moving flexible meetings to less disruptive slots. For teams, Clockwise is most powerful when multiple members use it: it finds optimal meeting windows across the whole team''s preferences simultaneously, dramatically reducing the back-and-forth of scheduling. The Flexible Meetings feature allows you to mark events as movable, giving Clockwise permission to shift them within a defined window to protect focus blocks. Clockwise integrates with Slack (updating your status automatically to indicate focus mode) and with Asana, Linear, and Jira to schedule tasks alongside meetings. The AI scheduling links can be shared externally as smart availability links that show only slots Clockwise has determined are low-disruption based on your calendar patterns. Used widely at companies including HubSpot, Duolingo, and Twitter/X. The free plan covers individual calendar optimisation; team features and the AI scheduling links require a paid plan.',
  'https://www.google.com/s2/favicons?domain=getclockwise.com&sz=64',
  'https://getclockwise.com', 'https://getclockwise.com',
  ARRAY['productivity', 'ai-assistant'],
  'freemium', true, 0.00,
  4.5, 1800, false, false, false,
  ARRAY['Automatically moves flexible meetings to protect deep work blocks', 'Team scheduling finds optimal meeting windows across multiple calendars', 'Slack integration updates status to signal focus mode automatically', 'Works continuously in the background without manual input'],
  ARRAY['Only works with Google Calendar - no Outlook support', 'Team features require paid plan', 'Less useful for individuals with mostly fixed, non-flexible meetings'],
  ARRAY['Knowledge workers who lose focus time to scattered meetings and need automatic protection', 'Engineering and design teams who need uninterrupted blocks for deep work', 'Teams who schedule many internal meetings and want AI to find optimal windows']
)
ON CONFLICT (slug) DO NOTHING;

-- 4. Todoist
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES
(
  'todoist', 'Todoist', 'Trusted task manager with AI scheduling that works across every device and platform',
  'Todoist is one of the most widely used task management applications in the world, with over 42 million users across iOS, Android, web, Mac, Windows, and browser extensions. Its AI assistant - Todoist AI - analyses your backlog and scheduling patterns to suggest due dates and priority levels for new tasks, automatically schedule tasks across upcoming days based on your workload, and break large tasks into smaller subtasks from a natural language description. The quick-add bar parses natural language for dates, priorities, and projects: typing "Submit report to Sarah next Friday p1" creates a high-priority task due next Friday without clicking through any menus. Projects, sections, filters, and labels let you organise tasks at any level of complexity. Todoist integrates with Google Calendar (bidirectional), Outlook Calendar, Slack, Gmail, Zapier, IFTTT, and dozens more. Its Karma system gamifies productivity by tracking daily and weekly completion streaks, giving individuals a visual signal of consistency over time. The free plan covers 5 active projects and 5 collaborators - genuinely useful for personal task management. Pro and Business plans unlock AI features, reminders, calendar sync, and up to 500 projects.',
  'https://www.google.com/s2/favicons?domain=todoist.com&sz=64',
  'https://todoist.com', 'https://todoist.com',
  ARRAY['productivity', 'ai-assistant'],
  'freemium', true, 0.00,
  4.6, 9200, false, false, false,
  ARRAY['Natural language input for quick task capture without clicking menus', 'Available on every platform with reliable sync and offline mode', 'AI scheduling assistant suggests due dates and workload distribution', 'Generous free tier with 5 active projects and collaborators'],
  ARRAY['No built-in time-blocking or calendar view (separate app required)', 'AI features locked to Pro and Business plans', 'Less suited to project management with complex dependencies'],
  ARRAY['Individuals managing personal task lists across work and life', 'Teams needing a lightweight shared task manager with clear ownership', 'Anyone building a daily productivity habit who wants a reliable, low-friction capture tool']
)
ON CONFLICT (slug) DO NOTHING;

-- 5. TickTick
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES
(
  'ticktick', 'TickTick', 'All-in-one task manager with built-in calendar, habits, and Pomodoro timer',
  'TickTick is a task management application that combines task lists, a built-in calendar view, habit tracking, and a Pomodoro focus timer in a single subscription - features that most competitors either omit or charge separately for. Its calendar integration is native: tasks and events appear together in a unified calendar view, allowing you to see your day as a mix of scheduled commitments and actionable items without switching apps. The habit tracker lets you define daily or weekly habits alongside tasks, building a complete picture of your productive day in one tool. The focus session timer uses the Pomodoro technique (customisable work and break intervals) with ambient sound options and session statistics. TickTick''s AI Smart Date parsing turns natural language like "submit brief by end of next week" into scheduled tasks with appropriate due dates and reminders. The Eisenhower Matrix view automatically sorts tasks by importance and urgency, helping users identify what actually needs attention versus what feels urgent but is not. TickTick has a strong free tier covering core task management, but the built-in calendar, habits, and Pomodoro timer require a Premium subscription at $35.99/year - substantially cheaper than most alternatives.',
  'https://www.google.com/s2/favicons?domain=ticktick.com&sz=64',
  'https://ticktick.com', 'https://ticktick.com',
  ARRAY['productivity', 'ai-assistant'],
  'freemium', true, 0.00,
  4.6, 5400, false, false, false,
  ARRAY['Built-in calendar, habit tracker, and Pomodoro timer in one subscription', 'Native calendar view shows tasks and events together without a separate app', 'Eisenhower Matrix view automatically categorises tasks by urgency and importance', 'Very affordable Premium plan at $35.99/year'],
  ARRAY['AI features less advanced than some newer competitors', 'Team collaboration features are more basic than dedicated project tools', 'Mobile app occasionally lags behind desktop feature releases'],
  ARRAY['Individuals who want task management, calendar, habits, and Pomodoro in one affordable tool', 'Students and freelancers building daily structure without complex project management needs', 'Anyone who has tried separate apps for tasks, habits, and focus sessions and wants one subscription instead']
)
ON CONFLICT (slug) DO NOTHING;

-- 6. Superhuman
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES
(
  'superhuman', 'Superhuman', 'AI-powered email client built for speed, designed for people who treat inbox zero as infrastructure',
  'Superhuman is a premium email client that layers AI intelligence and keyboard-driven speed on top of Gmail and Google Workspace. Its central premise is that email is a primary productivity surface for most professionals, and the default Gmail or Outlook interface introduces too much friction. Superhuman''s interface is built entirely for keyboard shortcuts - every action has a two-key command - so experienced users process email at roughly twice the speed of a standard client. The AI layer includes: Superhuman AI, which drafts complete replies in your voice from a brief description of what you want to say; Priority Inbox, which uses AI to separate important emails from everything else before you open them; Social Insights, which surfaces LinkedIn profile data for anyone who emails you; and Read Statuses, which shows when your sent emails were opened and on which device. Remind Me converts emails into timed tasks: you snooze a thread until the timing is right (when the flight lands, in 3 days, next Monday at 9am) and it disappears from your inbox and resurfaces automatically. Superhuman requires a 1:1 onboarding call to get started and costs $30/month - a deliberate positioning decision that targets senior professionals and executives for whom time saved on email has clear economic value.',
  'https://www.google.com/s2/favicons?domain=superhuman.com&sz=64',
  'https://superhuman.com', 'https://superhuman.com',
  ARRAY['productivity', 'ai-assistant'],
  'paid', false, 30.00,
  4.7, 2100, false, false, false,
  ARRAY['Keyboard-driven speed lets experienced users process email significantly faster', 'AI drafts complete context-aware replies in your voice from a brief description', 'Priority Inbox surfaces important emails before you open them', 'Remind Me snooze system turns emails into time-based tasks without a separate app'],
  ARRAY['$30/month is expensive compared to free email clients', 'Requires 1:1 onboarding call to get started', 'Only supports Gmail and Google Workspace - not Outlook or other providers'],
  ARRAY['Executives and senior professionals who spend significant time in email and value speed', 'Sales and BD leaders who rely on email as a primary revenue channel', 'Anyone who has adopted Inbox Zero as a practice and needs tooling that makes maintenance sustainable']
)
ON CONFLICT (slug) DO NOTHING;

-- 7. Shortwave
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES
(
  'shortwave', 'Shortwave', 'AI email app for Google Workspace that summarises threads, drafts replies, and triages your inbox automatically',
  'Shortwave is an AI-native email client built specifically for Gmail and Google Workspace. Its AI capabilities go beyond simple reply drafting: Shortwave can summarise long email threads into a brief overview, answer questions about your email history ("Did Sarah confirm the contract?"), triage your inbox by grouping related threads into bundles, and draft contextually appropriate replies based on the full conversation history. The bundle system organises emails by sender type - newsletters, notifications, receipts, conversations - and processes entire categories at once rather than requiring individual email decisions. Shortwave''s Ask AI feature treats your inbox as a searchable knowledge base: you can ask natural language questions across all your historical emails and get direct answers with source citations. This is particularly useful for finding specific details from long email chains without scrolling through threads. The drafting assistant understands context from the full thread and can be instructed to match your usual communication style. Shortwave is a strong alternative to Superhuman for teams that want AI email capabilities but find Superhuman''s price or onboarding requirement prohibitive. Free plan covers 1 Gmail account with limited AI requests; Pro plan at $9/month adds unlimited AI and multiple accounts.',
  'https://www.google.com/s2/favicons?domain=shortwave.com&sz=64',
  'https://shortwave.com', 'https://shortwave.com',
  ARRAY['productivity', 'ai-assistant'],
  'freemium', true, 0.00,
  4.4, 780, false, false, false,
  ARRAY['Thread summarisation condenses long email chains into brief overviews', 'Ask AI searches your email history with natural language questions', 'Bundle triage processes entire categories of email at once', 'Strong alternative to Superhuman at a fraction of the price'],
  ARRAY['Gmail and Google Workspace only - no Outlook support', 'Free tier limits AI requests', 'Less mature than Superhuman for power keyboard users'],
  ARRAY['Professionals who need to stay on top of high-volume Gmail without spending hours triaging', 'Teams who need to search email history to answer questions quickly', 'Anyone who wants AI email capabilities but cannot justify Superhuman''s $30/month']
)
ON CONFLICT (slug) DO NOTHING;

-- 8. Spark Mail
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES
(
  'spark-mail', 'Spark Mail', 'Smart AI email client with team collaboration features and intelligent inbox prioritisation',
  'Spark Mail is an email client for iOS, macOS, Android, and Windows that uses AI to automatically separate important personal emails from newsletters, notifications, and team messages - without requiring manual filters or rules. Its Smart Inbox groups emails by type so you read the important messages first and batch-process the rest. Spark AI generates email drafts from a short description, adjusts tone (formal, friendly, concise), improves grammar and clarity, and can shorten or expand a draft to match the situation. The Gatekeeper feature allows you to approve new senders before their emails reach your inbox - a useful spam reduction mechanism for inboxes that receive high volumes of cold outreach. Team collaboration features let multiple people draft a reply together, leave internal comments on email threads, and assign emails to teammates as tasks - without the recipient seeing the collaboration layer. Send Later and Remind Me controls turn Spark into a light task layer on top of email. Supports Gmail, Outlook, Exchange, iCloud, Yahoo, IMAP and most major providers. Free plan covers individual use with full AI access; Premium plan adds team features.',
  'https://www.google.com/s2/favicons?domain=sparkmailapp.com&sz=64',
  'https://sparkmailapp.com', 'https://sparkmailapp.com',
  ARRAY['productivity', 'ai-assistant'],
  'freemium', true, 0.00,
  4.5, 3200, false, false, false,
  ARRAY['Works with Gmail, Outlook, Exchange, iCloud, and most email providers', 'Smart Inbox automatically separates personal emails from newsletters and notifications', 'Team collaboration lets multiple people draft and comment on emails internally', 'Gatekeeper controls who can reach your inbox with new messages'],
  ARRAY['Team features require Premium plan', 'Some advanced features iOS-first with delayed Android release', 'AI draft quality less consistent than Superhuman for complex replies'],
  ARRAY['Small teams who want to collaborate on email responses without adding another tool', 'Professionals with high inbox volume who need intelligent triage across multiple accounts', 'Anyone who wants a capable AI email client that works with any email provider']
)
ON CONFLICT (slug) DO NOTHING;

-- 9. SavvyCal
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES
(
  'savvycal', 'SavvyCal', 'Scheduling tool that respects the invitee''s calendar by showing their availability alongside yours',
  'SavvyCal is a scheduling platform that solves a specific frustration with traditional scheduling tools: the invitee sees your available slots but has no visibility into what those slots cost them in terms of their own schedule. SavvyCal''s scheduling links let invitees overlay their own calendar on top of yours as they pick a time, so they can see immediately which of your available slots conflicts with their existing commitments or falls during their preferred working hours. This small change significantly improves scheduling quality: meetings land in slots that work for both parties rather than slots the host happened to mark as open. SavvyCal supports round-robin scheduling for teams, one-off and recurring meeting types, collective meeting links where multiple hosts must all be available, and custom availability windows by meeting type. Its Ranked Availability feature lets you mark preferred times within your available window, nudging invitees toward your optimal slots without removing their choice. Integrates with Google Calendar, Outlook, iCloud, Zoom, Google Meet, and Zapier. Free tier covers one scheduling link with unlimited meetings; paid plans from $12/month unlock multiple link types and team features.',
  'https://www.google.com/s2/favicons?domain=savvycal.com&sz=64',
  'https://savvycal.com', 'https://savvycal.com',
  ARRAY['productivity', 'ai-assistant'],
  'freemium', true, 0.00,
  4.5, 540, false, false, false,
  ARRAY['Invitees can overlay their own calendar to see which slots work for them too', 'Ranked Availability nudges invitees toward preferred times without removing choice', 'Genuinely better scheduling experience than Calendly for both parties', 'Round-robin and collective scheduling for teams'],
  ARRAY['Less brand recognition than Calendly - some invitees unfamiliar with the interface', 'Free tier limited to one scheduling link', 'Fewer integrations than some larger scheduling tools'],
  ARRAY['Consultants and coaches who want meetings to land in times that work for both parties', 'Sales teams doing discovery calls who want to reduce back-and-forth on scheduling', 'Anyone frustrated that their scheduling tool does not account for what is convenient for the invitee']
)
ON CONFLICT (slug) DO NOTHING;

-- 10. Cal.com
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES
(
  'cal-com', 'Cal.com', 'Open-source scheduling infrastructure with AI booking and white-label options',
  'Cal.com is an open-source scheduling platform and a direct Calendly alternative, offering unlimited event types and booking pages at no cost on its hosted plan. Its open-source codebase means teams can self-host the entire scheduling infrastructure for complete data ownership and custom branding - a meaningful advantage for enterprises and regulated industries where sending scheduling data through third-party SaaS is a compliance concern. The AI booking features include an AI scheduling assistant that can book meetings through a conversational interface, available as an embeddable widget or standalone booking page. Cal.com supports all standard scheduling workflows: individual availability links, team round-robin, collective meetings, paid booking (Stripe integration), and workflows that send SMS and email reminders automatically. The marketplace lists 200+ integrations including Google Calendar, Outlook, Zoom, Google Meet, Salesforce, HubSpot, Lark, and Zapier. Its team features allow unlimited team members and event types at the Team plan. Cal.com is used by Vercel, Twilio, HubSpot, and thousands of individual developers as scheduling infrastructure. The free plan covers everything an individual needs; Team plan at $12/seat/month adds team scheduling, analytics, and workflow automation.',
  'https://www.google.com/s2/favicons?domain=cal.com&sz=64',
  'https://cal.com', 'https://cal.com',
  ARRAY['productivity', 'ai-assistant'],
  'freemium', true, 0.00,
  4.6, 2800, false, false, false,
  ARRAY['Open-source codebase allows self-hosting for complete data ownership', 'Unlimited event types and booking pages on free plan', '200+ integrations with one-click installs', 'AI conversational booking assistant for natural language scheduling'],
  ARRAY['Self-hosting requires technical setup and maintenance', 'UI less polished than Calendly for non-technical invitees', 'Advanced analytics and automation require paid plan'],
  ARRAY['Developers and technical teams who want scheduling infrastructure they can self-host and customise', 'Businesses that need white-label booking pages for client-facing scheduling', 'Anyone using Calendly and paying for features available free on Cal.com']
)
ON CONFLICT (slug) DO NOTHING;
