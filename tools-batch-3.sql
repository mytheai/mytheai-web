-- tools-batch-3.sql
-- 10 new tools (brings total from 49 → 59)
-- Run in Supabase → SQL Editor (New query tab)
-- Uses ON CONFLICT (slug) DO NOTHING — safe to re-run

insert into tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, pricing_type, pricing_free_tier, rating, review_count, tags, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
values

-- 1. Monday.com
('monday', 'Monday.com', 'The work platform that makes teamwork click',
 'Monday.com is one of the most popular project management and work OS platforms, used by over 200,000 organisations worldwide. Built around visual, customisable boards, it lets teams manage projects, track progress, and automate repetitive tasks without writing a single line of code. In 2024, Monday.com expanded its AI capabilities with AI-generated column suggestions, automated status updates, and natural language formula builders. Its strength lies in flexibility — the same platform can run a marketing campaign, a software sprint, a client onboarding workflow, or a construction project. The interface is polished and intuitive, making it one of the easiest enterprise-grade tools to roll out across a team without training. Integrations cover 200+ apps including Slack, Salesforce, Jira, and Google Workspace.',
 'https://www.google.com/s2/favicons?domain=monday.com&sz=64',
 'https://monday.com', 'https://go.mytheai.com/monday',
 'freemium', true, 4.5, 12000,
 ARRAY['productivity', 'project-management'],
 false, false, false,
 ARRAY['Highly visual and customisable boards', 'Strong automation capabilities without code', 'Excellent onboarding and support', 'Wide integration ecosystem (200+ apps)', 'Scales well from small teams to enterprise'],
 ARRAY['Free plan is limited to 2 seats', 'Can become expensive at scale', 'Feature overload can overwhelm new users'],
 ARRAY['Managing marketing campaigns and content calendars', 'Tracking software development sprints and releases', 'Client-facing project dashboards and reporting'],
 now()),

-- 2. ClickUp
('clickup', 'ClickUp', 'The everything app for work — replace all your productivity apps with one',
 'ClickUp positions itself as the productivity platform that can replace every other tool in your stack — tasks, docs, goals, chat, whiteboards, and time tracking in a single workspace. Its AI layer, ClickUp Brain, generates task summaries, writes project briefs, answers questions from your workspace data, and automates status updates. With over 1,000 integrations and a free tier that is genuinely feature-rich, ClickUp has become the default choice for startups and agencies who want maximum functionality without maximum spend. The platform is highly customisable — you can structure it as a Kanban board, a list, a Gantt chart, or a calendar depending on how your team thinks. The downside is complexity: ClickUp has so many features that new users often take weeks to find their preferred configuration.',
 'https://www.google.com/s2/favicons?domain=clickup.com&sz=64',
 'https://clickup.com', 'https://go.mytheai.com/clickup',
 'freemium', true, 4.4, 9500,
 ARRAY['productivity', 'project-management'],
 false, false, false,
 ARRAY['Extremely feature-rich free plan', 'ClickUp AI summarises and writes within tasks', 'Replaces multiple tools in one workspace', 'Highly flexible — adaptable to any workflow', 'Strong time tracking and reporting'],
 ARRAY['Steep learning curve due to feature volume', 'Mobile app is slower than desktop', 'Notifications can become overwhelming'],
 ARRAY['All-in-one work management for product and engineering teams', 'Agency project tracking with client visibility', 'Replacing fragmented tool stacks with a unified workspace'],
 now()),

-- 3. Miro
('miro', 'Miro', 'The collaborative visual workspace for teams — brainstorm, plan, and create together',
 'Miro is the leading online whiteboard and visual collaboration platform, used by over 60 million people across 200,000 organisations. Teams use Miro to run brainstorming sessions, map user journeys, plan product roadmaps, run retrospectives, and facilitate workshops — all on an infinite digital canvas that everyone can edit simultaneously. Miro AI takes this further with automated diagramming, mind map generation from text prompts, and AI-powered sticky note clustering. For distributed teams, Miro bridges the gap that video calls alone cannot — it gives remote participants a shared creative space that feels close to being in the same room. The free plan allows unlimited team members with up to 3 editable boards, making it accessible for small teams to start without cost.',
 'https://www.google.com/s2/favicons?domain=miro.com&sz=64',
 'https://miro.com', 'https://go.mytheai.com/miro',
 'freemium', true, 4.6, 8200,
 ARRAY['productivity', 'design'],
 false, false, false,
 ARRAY['Best-in-class infinite canvas for visual thinking', 'Excellent real-time collaboration for remote teams', 'Miro AI generates diagrams and clusters ideas automatically', 'Rich template library (300+ templates)', 'Integrates with Jira, Slack, Asana, and Zoom'],
 ARRAY['Free plan limited to 3 editable boards', 'Can feel overwhelming on very large boards', 'Requires stable internet for smooth real-time collaboration'],
 ARRAY['Running remote brainstorming and ideation sessions', 'Mapping customer journeys and product roadmaps', 'Facilitating design sprints and agile retrospectives'],
 now()),

-- 4. QuillBot
('quillbot', 'QuillBot', 'AI-powered paraphrasing and writing improvement trusted by millions of students and professionals',
 'QuillBot is one of the most widely used AI writing tools, known primarily for its paraphrasing engine that rewrites text in multiple tones and styles. Beyond paraphrasing, QuillBot offers a grammar checker, summariser, co-writer, translator, and citation generator — making it a comprehensive writing assistant for students, researchers, and professionals who work with a lot of text. Its Chrome extension integrates directly into Google Docs, Gmail, and most writing environments, so users never have to leave their workflow. The free tier is functional and popular among students for essay refinement, while the Premium plan unlocks more paraphrasing modes, unlimited text length, and the plagiarism checker. QuillBot does not generate original content from scratch — it works with what you already have to make it clearer, shorter, or stylistically different.',
 'https://www.google.com/s2/favicons?domain=quillbot.com&sz=64',
 'https://quillbot.com', 'https://go.mytheai.com/quillbot',
 'freemium', true, 4.2, 14000,
 ARRAY['writing-ai', 'productivity'],
 false, false, false,
 ARRAY['Excellent paraphrasing with multiple tone modes', 'Works in browser via Chrome extension', 'Grammar checker is accurate and non-intrusive', 'Free tier is useful for basic paraphrasing', 'Supports 30+ languages'],
 ARRAY['Does not generate original content — refines existing text only', 'Plagiarism checker requires Premium plan', 'Paraphrased output can occasionally sound unnatural'],
 ARRAY['Refining academic essays and research papers', 'Simplifying technical writing for general audiences', 'Translating and paraphrasing content across languages'],
 now()),

-- 5. Pika
('pika', 'Pika', 'Transform ideas into stunning videos with AI — no video editing skills required',
 'Pika is one of the leading AI video generation platforms, enabling users to create short, high-quality videos from text prompts or images in seconds. Since launching in 2023, Pika has rapidly improved its motion quality, consistency, and control — making it a serious tool for marketers, content creators, and agencies who need video content at scale. Its most notable feature is the ability to animate still images, turning product photos or illustrations into eye-catching video clips for social media. Pika 2.0 introduced cinematic motion styles, aspect ratio control, and lip sync capabilities for avatar-based videos. The free tier gives new users a generous credit allowance to experiment, and paid plans unlock higher resolution, more monthly generations, and commercial usage rights.',
 'https://www.google.com/s2/favicons?domain=pika.art&sz=64',
 'https://pika.art', 'https://go.mytheai.com/pika',
 'freemium', true, 4.3, 3800,
 ARRAY['video-ai', 'image-ai'],
 false, true, false,
 ARRAY['Fast video generation from text or image prompts', 'High-quality motion with good temporal consistency', 'Image animation feature is unique and powerful', 'Free tier with generous credits for new users', 'Active development with frequent model improvements'],
 ARRAY['Maximum video length is still limited compared to professional tools', 'Commercial licensing requires a paid plan', 'Complex scenes with multiple characters can lose coherence'],
 ARRAY['Creating social media video content from product images', 'Animating brand illustrations and logo reveals', 'Generating B-roll footage for video productions'],
 now()),

-- 6. Suno
('suno', 'Suno', 'Create original songs and full music tracks from a simple text prompt — AI music generation for everyone',
 'Suno is the AI music generation platform that makes it possible for anyone — with no musical training — to create original, full-length songs with vocals, instrumentation, and lyrics from a single text prompt. Describe the genre, mood, and theme, and Suno produces a complete track in under a minute. The output quality is remarkably good — Suno-generated music often sounds indistinguishable from indie productions, covering genres from pop and hip-hop to jazz, metal, and classical. For content creators, marketers, and game developers, Suno offers an alternative to expensive royalty-free music libraries. The free plan provides a daily credit allowance for personal use, while paid plans unlock commercial licensing, more daily generations, and the ability to upload audio samples as style references.',
 'https://www.google.com/s2/favicons?domain=suno.com&sz=64',
 'https://suno.com', 'https://go.mytheai.com/suno',
 'freemium', true, 4.4, 4200,
 ARRAY['voice-ai', 'creative'],
 false, true, false,
 ARRAY['Creates complete songs with vocals from a text prompt', 'Wide genre coverage — pop to classical to metal', 'Free tier with daily credits for experimentation', 'Fast generation — full track in under 60 seconds', 'Constantly improving output quality'],
 ARRAY['Limited control over specific musical elements', 'Commercial use requires a paid plan', 'Lyrics can occasionally be nonsensical or repetitive'],
 ARRAY['Creating background music for YouTube and social media content', 'Generating jingles and brand audio for marketing campaigns', 'Producing placeholder music for game development and film projects'],
 now()),

-- 7. Asana
('asana', 'Asana', 'Manage your team''s work, projects, and tasks with AI-powered workflows',
 'Asana is one of the most established project management platforms, trusted by over 139,000 paying organisations including Spotify, Amazon, and Deloitte. It excels at structured work management — tasks, subtasks, dependencies, timelines, and portfolios — giving teams a clear view of who is doing what by when. Asana Intelligence, its AI layer, automates status updates, generates project briefs from goals, smart-assigns tasks based on workload, and surfaces priority items that need attention. Compared to more flexible tools like ClickUp or Monday.com, Asana is more opinionated — which means faster setup and less configuration for teams that want structure without spending hours customising. The free plan supports unlimited tasks and projects for teams of up to 15 people, making it viable for early-stage teams before upgrading.',
 'https://www.google.com/s2/favicons?domain=asana.com&sz=64',
 'https://asana.com', 'https://go.mytheai.com/asana',
 'freemium', true, 4.4, 10500,
 ARRAY['productivity', 'project-management'],
 false, false, false,
 ARRAY['Clean, intuitive interface — fast to onboard', 'AI automates status updates and task assignment', 'Strong timeline and dependency management', 'Portfolio view for managing multiple projects', 'Reliable free plan for teams up to 15'],
 ARRAY['AI features require the Business plan ($24.99/seat/mo)', 'Less flexible than ClickUp for custom workflows', 'Time tracking requires third-party integration'],
 ARRAY['Managing cross-functional marketing campaigns', 'Tracking software development sprints with dependencies', 'Coordinating client deliverables and agency workflows'],
 now()),

-- 8. Adobe Express
('adobe-express', 'Adobe Express', 'Create stunning graphics, social posts, and videos with AI-powered design tools',
 'Adobe Express is Adobe''s answer to Canva — a beginner-friendly design tool that puts the power of the Adobe Creative Cloud ecosystem in a simple drag-and-drop interface. It is particularly strong for social media content, presentations, flyers, and short videos, offering thousands of professionally designed templates and direct integration with Adobe Stock, Fonts, and Firefly AI. The Firefly generative AI features — text-to-image, generative fill, and background removal — are trained on licensed content, meaning everything you create is safe for commercial use. Express connects with Photoshop and Illustrator for more advanced editing when needed, and the free plan is generous with access to templates, basic Firefly credits, and core tools. For individuals and small businesses already in the Adobe ecosystem, it is a natural fit.',
 'https://www.google.com/s2/favicons?domain=adobe.com&sz=64',
 'https://adobe.com/express', 'https://go.mytheai.com/adobe-express',
 'freemium', true, 4.2, 5800,
 ARRAY['design', 'image-ai'],
 false, false, false,
 ARRAY['Firefly AI is commercially safe (trained on licensed content)', 'Direct integration with Adobe Creative Cloud', 'Strong template library for social and marketing content', 'Text-to-image and generative fill built in', 'Free plan with useful Firefly credits'],
 ARRAY['Less template variety than Canva for niche formats', 'Full features require a Creative Cloud subscription', 'Advanced design requires switching to Photoshop or Illustrator'],
 ARRAY['Creating branded social media graphics and posts', 'Designing marketing materials (flyers, brochures, ads)', 'Producing short promotional videos for Instagram and TikTok'],
 now()),

-- 9. Zoom
('zoom', 'Zoom', 'AI-powered video meetings, webinars, and team collaboration in one unified platform',
 'Zoom is the dominant video conferencing platform, used by over 300 million daily meeting participants worldwide. Beyond video calls, the Zoom platform now includes AI Companion — a built-in AI assistant that generates meeting summaries, captures action items, drafts follow-up emails, and answers questions based on meeting transcripts. This transforms Zoom from a simple calling tool into a productivity layer that ensures nothing falls through the cracks after a meeting. Zoom also offers Zoom Phone (cloud phone system), Zoom Webinars (for large-scale broadcasts), and Zoom Rooms (for conference room hardware). The free plan supports unlimited one-on-one meetings and 40-minute group meetings, making it the default starting point for most teams. AI Companion is included at no additional cost for paid subscribers.',
 'https://www.google.com/s2/favicons?domain=zoom.us&sz=64',
 'https://zoom.us', 'https://go.mytheai.com/zoom',
 'freemium', true, 4.3, 22000,
 ARRAY['productivity', 'voice-ai'],
 false, false, false,
 ARRAY['AI Companion summarises meetings and captures action items automatically', 'Universally adopted — no friction for external participants', 'Reliable video quality at enterprise scale', 'Integrated phone, webinar, and room hardware solutions', 'AI Companion included in paid plans at no extra cost'],
 ARRAY['Free plan limits group meetings to 40 minutes', 'Privacy concerns around AI meeting transcription', 'Video quality can degrade on slower connections'],
 ARRAY['Running client calls and demos with automatic meeting notes', 'Hosting company-wide webinars and all-hands meetings', 'Managing distributed team communications with AI-powered follow-up'],
 now()),

-- 10. Slack
('slack', 'Slack', 'Your team''s digital HQ — message, meet, and automate work with AI-powered workflows',
 'Slack is the leading team communication platform, used by over 200,000 paying organisations to replace internal email and unify team conversations. Slack AI, launched in 2024, adds a powerful intelligence layer: it can summarise channels and threads you missed, answer questions based on your workspace''s message history, and generate daily digests of important activity. Workflow Builder — Slack''s no-code automation tool — lets teams create automated processes triggered by messages, events, or schedules, eliminating manual handoffs. The Slack App Directory has over 2,600 integrations, making it the connective tissue between nearly every tool a modern team uses. The free plan retains 90 days of message history and supports unlimited channels, which is sufficient for many small teams. Paid plans unlock full history, larger file storage, and AI features.',
 'https://www.google.com/s2/favicons?domain=slack.com&sz=64',
 'https://slack.com', 'https://go.mytheai.com/slack',
 'freemium', true, 4.5, 18000,
 ARRAY['productivity', 'project-management'],
 false, false, false,
 ARRAY['Slack AI summarises channels and answers questions from history', 'Best-in-class integration ecosystem (2,600+ apps)', 'Workflow Builder automates team processes without code', 'Organises conversations by channel and thread — reduces noise', 'Widely adopted — minimises onboarding friction for new hires'],
 ARRAY['AI features require a paid plan', 'Can become a distraction — notification discipline required', 'Free plan limits message history to 90 days'],
 ARRAY['Centralising team communication across projects and departments', 'Building automated workflows between apps (Jira, GitHub, Salesforce)', 'Replacing email for internal collaboration in remote-first teams'],
 now())

ON CONFLICT (slug) DO NOTHING;
