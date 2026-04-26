-- tools-batch-10.sql
-- 10 new tools: motion, reclaim-ai, clay, gong, veed-io, pictory, pitch, submagic, codeium, posthog
-- Safe to re-run (ON CONFLICT DO NOTHING + NOT EXISTS guard)
-- IMPORTANT: column is pricing_starting_price (NOT starting_price)

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'motion', 'Motion', 'AI scheduler that builds your perfect workday automatically',
'Motion is an AI-powered scheduling and task management tool that automatically builds your daily plan based on your priorities, deadlines, and calendar availability. Unlike traditional task managers where you manually arrange your work, Motion''s algorithm analyses your to-do list alongside your free time slots and generates an optimised schedule for each day — rescheduling automatically when priorities shift or meetings run long. This makes it especially useful for knowledge workers and managers who deal with frequent interruptions and competing demands across multiple projects.

The core value proposition is the elimination of planning overhead. Rather than spending 20–30 minutes each morning deciding what to work on and when, Motion handles the scheduling logic and surfaces a ready-to-execute plan. It integrates with Google Calendar and Outlook for seamless calendar management and pulls in tasks from its built-in project management features. The tool is focused on individual productivity rather than team project management — it is not a Jira or Linear replacement. At $19/month for individuals, Motion is a premium productivity tool best suited to professionals who are consistently overwhelmed by too many tasks and too little time, and for whom the planning savings and reduction in missed deadlines justify the subscription within weeks of adoption.',
NULL, 'https://usemotion.com', 'https://usemotion.com',
ARRAY['productivity', 'scheduling'], 'paid', false, 19, 4.4, 890, false, false, false,
ARRAY['Automatically schedules tasks around meetings in real time', 'Eliminates daily planning overhead', 'Handles priority conflicts and rescheduling automatically', 'Integrates with Google Calendar and Outlook'],
ARRAY['No free plan — paid-only from day one', 'Focused on individuals, not team projects', 'Less suitable for creative or unpredictable workloads'],
ARRAY['Knowledge workers juggling meetings and deep work', 'Founders and managers with constantly shifting priorities', 'Anyone who consistently runs out of time on important tasks']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'motion')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'reclaim-ai', 'Reclaim.ai', 'Smart calendar that automatically protects time for what matters',
'Reclaim.ai is a smart calendar automation tool that uses AI to protect time for your priorities — automatically scheduling habits, focus blocks, and tasks around your existing meetings. Unlike manual calendar blocking, Reclaim continuously adjusts your schedule in real time as new meetings arrive or priorities change. It integrates with Google Calendar and syncs tasks from Asana, Linear, Jira, and ClickUp to auto-schedule deep work sessions around your meeting load. This makes it particularly effective for software developers, project managers, and distributed teams trying to balance structured work with an unpredictable meeting schedule.

The tool''s standout features include Habits (auto-scheduled recurring blocks for exercise, lunch, or admin that flex around meetings), Smart Meetings (scheduling links that find mutual availability across a team), and Buffer Time (automatic gaps added between meetings). Reclaim differs from Motion in approach: where Motion generates a full day plan from scratch, Reclaim is intelligent calendar management that protects blocks you define within your existing Google Calendar workflow. The free plan covers basic habits and 3 task syncs; paid plans start at $10/user/month and unlock full task sync across all tools, team scheduling features, and analytics. For remote and hybrid teams trying to reduce meeting overload and protect focus time, Reclaim offers a meaningful productivity lift with minimal behaviour change required.',
NULL, 'https://reclaim.ai', 'https://reclaim.ai',
ARRAY['productivity', 'scheduling'], 'freemium', true, 10, 4.5, 1240, false, true, false,
ARRAY['Automatically schedules habits and tasks around meetings', 'Real-time calendar adjustments as priorities change', 'Generous free plan with core features', 'Strong integrations with Asana, Linear, Jira, and ClickUp'],
ARRAY['Google Calendar only — no Outlook support on free plan', 'Less opinionated daily planning than Motion', 'Team features require paid plan'],
ARRAY['Developers protecting deep work time from meeting sprawl', 'Remote teams coordinating across time zones', 'Professionals building consistent daily habits']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'reclaim-ai')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'clay', 'Clay', 'AI-powered prospecting and data enrichment for outbound sales',
'Clay is an AI-powered relationship management and sales intelligence platform built for modern go-to-market teams. It aggregates data from over 75 third-party providers — including LinkedIn, Crunchbase, Apollo, Hunter, and Clearbit — into a single spreadsheet-like interface, then uses its AI agent (Claygent) to research, enrich, and personalise outreach at scale. Instead of manually researching each prospect, Clay automates the lookup of company details, funding rounds, job changes, tech stacks, and contact information — enabling teams to build hyper-targeted lead lists without hours of manual research per campaign.

The platform is particularly powerful for sales, growth, and recruiting teams running personalised outbound campaigns. Claygent can browse websites, extract specific information, and write personalised first lines for emails based on real prospect data — automating tasks that would previously require a research analyst. Clay is not a CRM: it is a data enrichment and workflow tool that typically feeds into HubSpot, Salesforce, or email sequencing tools like Instantly or Smartlead for actual outreach execution. Free accounts allow a limited number of data lookups per month; paid plans scale by credit consumption, with most serious outbound teams spending $149/month or more. Clay has become a cornerstone of the modern sales stack for teams serious about personalised outbound at scale.',
NULL, 'https://clay.com', 'https://clay.com',
ARRAY['crm', 'sales'], 'freemium', true, 149, 4.6, 780, false, true, false,
ARRAY['Aggregates 75+ data providers in one interface', 'Claygent AI automates prospect research at scale', 'Generates personalised email openers from real data', 'Dramatically reduces manual prospecting time'],
ARRAY['Expensive at scale — credits add up quickly', 'Steep learning curve for non-technical users', 'Not a CRM — requires pairing with an outreach tool'],
ARRAY['Sales teams building targeted outbound lead lists', 'Growth teams running personalised acquisition campaigns', 'Recruiters researching candidates at scale']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'clay')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'gong', 'Gong', 'Revenue intelligence platform that analyses every sales conversation',
'Gong is a revenue intelligence platform that records, transcribes, and analyses sales calls and customer conversations using AI. It automatically identifies deal risks, coaching opportunities, and market trends from the actual conversations happening between your sales team and prospects — removing the need for reps to manually log call notes or managers to shadow every call. Gong integrates with Zoom, Google Meet, Salesforce, HubSpot, and major enterprise communication platforms, pulling conversation data directly into deal management and forecasting workflows.

The platform''s AI surfaces patterns across thousands of calls: which talk tracks correlate with wins, which objections most often kill conversions, when prospects disengage mid-deal, and which reps need coaching on specific skills. For revenue leaders, Gong provides pipeline accuracy by cross-referencing CRM data with actual conversation signals — flagging deals that reps overvalue based on engagement data rather than gut feel. Gong is a premium enterprise tool with custom pricing based on team size, typically starting at approximately $5,000/year for small teams. It is best suited to companies with dedicated sales teams running structured discovery and demo processes where systematic analysis of thousands of conversations provides measurable improvements in win rate, deal size, and ramp time for new hires.',
NULL, 'https://gong.io', 'https://gong.io',
ARRAY['crm', 'analytics'], 'paid', false, NULL, 4.5, 2100, false, false, false,
ARRAY['AI analysis of every sales call without manual note-taking', 'Deal risk signals from actual conversation data', 'Sales coaching at scale with specific skill feedback', 'Improves forecast accuracy beyond CRM self-reporting'],
ARRAY['Enterprise pricing — not accessible to small teams', 'Requires organisational buy-in for call recording culture', 'Custom pricing with no self-serve option'],
ARRAY['Sales leaders wanting data-driven coaching at scale', 'Revenue operations teams improving forecast accuracy', 'Enterprises reducing ramp time for new sales hires']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'gong')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'veed-io', 'VEED.IO', 'Browser-based video editor with AI subtitles, avatars, and translation',
'VEED.IO is a browser-based video editing platform with a comprehensive suite of AI tools for content creators, marketers, and social media teams. Its AI features include automatic subtitle generation with 95%+ accuracy across 100+ languages, AI avatar creation for faceless video content, background removal, eye contact correction, and AI script writing. Unlike desktop editors, VEED runs entirely in the browser with no installation required, making it accessible to creators and teams without professional video editing backgrounds. The full editing timeline covers everything from raw footage trimming to branded export.

The platform is particularly strong for short-form and social content workflows: one-click subtitle styling, automatic video reformatting for different aspect ratios (16:9 to 9:16 for TikTok and Reels), and direct publishing integrations. VEED''s AI translation feature can auto-dub videos in over 50 languages, making it useful for international content distribution without separate localisation costs. The free plan allows video exports up to 10 minutes with a VEED watermark; paid plans start at $12/month and remove watermarks while expanding export options and adding team collaboration. For content teams and creators who need polished, subtitle-ready video output without professional editing skills, VEED offers the fastest path from raw footage to publish-ready content.',
NULL, 'https://veed.io', 'https://veed.io',
ARRAY['video-ai', 'design'], 'freemium', true, 12, 4.3, 3200, false, false, false,
ARRAY['No installation — runs fully in the browser', 'Auto subtitles in 100+ languages with high accuracy', 'AI avatar creation for faceless video content', 'Auto-reformats videos for different social platforms'],
ARRAY['Free plan adds a watermark to exports', 'Less powerful than desktop editors for complex projects', 'AI dubbing quality varies by language'],
ARRAY['Content creators adding subtitles to social videos', 'Marketing teams repurposing content for multiple platforms', 'International teams creating multilingual video content']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'veed-io')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'pictory', 'Pictory', 'Turn articles and scripts into engaging videos with AI',
'Pictory is an AI video creation platform that converts long-form text — blog posts, articles, scripts, or URLs — into short, shareable videos with AI voiceover, stock footage, and captions. It is designed for content repurposing: taking existing written content and automatically generating a video summary with matching visuals and narration, without requiring any video editing skill. Pictory also converts long webinar recordings, podcasts, and Zoom sessions into bite-sized social clips by identifying the most engaging moments using AI highlight detection.

The tool is primarily used by bloggers, content marketers, and online course creators who want to extend their written content''s reach to video-native platforms like YouTube, LinkedIn, and Instagram without a separate video production workflow. Pictory''s strength is automation speed — a 2,000-word article can become a 2-minute branded video in under 10 minutes, with customisable templates ensuring visual consistency across content. The AI voiceover engine supports multiple languages and voices, removing the need for recording equipment. Paid plans start at $19/month for 30 videos per month; higher tiers unlock more monthly videos, custom AI voices, and team collaboration features. Pictory does not replace full-scale video production but excels at systematic content repurposing and reach extension at minimal time cost.',
NULL, 'https://pictory.ai', 'https://pictory.ai',
ARRAY['video-ai', 'content'], 'paid', false, 19, 4.2, 1560, false, false, false,
ARRAY['Converts blog posts to video in under 10 minutes', 'AI highlight detection for long recordings', 'No video editing skills required', 'Broad stock footage and music library included'],
ARRAY['No permanent free plan — trial only', 'AI-selected visuals sometimes miss context', 'Less control than manual video editors'],
ARRAY['Bloggers repurposing written content as video', 'Course creators converting webinar recordings to clips', 'Marketers scaling video output without a production team']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'pictory')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'pitch', 'Pitch', 'Collaborative AI presentation tool for modern teams',
'Pitch is a collaborative presentation tool built for modern teams, combining a polished slide editor with AI content generation and real-time collaboration. The AI assistant can generate full slide decks from a brief, rewrite slide content to match a specified tone, suggest layouts, and create speaker notes — significantly reducing the time from rough ideas to a first presentable draft for business presentations, pitch decks, and team reviews. Pitch is built as a direct alternative to Google Slides and PowerPoint, with a focus on design quality and collaborative workflow.

The platform''s template library covers investor pitch decks, OKR review decks, case studies, and marketing presentations with professional designs that non-designers can customise without breaking visual hierarchy. Real-time collaboration allows multiple team members to edit simultaneously with version history and inline commenting — a clear workflow advantage over static PowerPoint files passed back and forth via email. Pitch integrates with Figma, Loom, and major data tools for embedding live charts and recordings directly in slides. The free plan is functional for individuals and small teams; team plans start at $25/month and add advanced collaboration, custom branding, analytics on shared presentations, and guest access controls. For startups building investor decks, agencies presenting to clients, or internal teams running structured reviews, Pitch reduces the gap between having good ideas and presenting them well.',
NULL, 'https://pitch.com', 'https://pitch.com',
ARRAY['design', 'productivity'], 'freemium', true, 25, 4.4, 1890, false, false, false,
ARRAY['AI generates full decks from a brief', 'Real-time collaboration with version history', 'Professional template library for common deck types', 'Presentation analytics to track engagement'],
ARRAY['Team plans start at $25/month — higher than Google Slides', 'Export to PowerPoint is less polished', 'Fewer animation options than Canva or PowerPoint'],
ARRAY['Startups building investor pitch decks', 'Agencies presenting proposals and case studies to clients', 'Teams running structured OKR and strategy reviews']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'pitch')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'submagic', 'Submagic', 'AI captions and short-form video enhancement for creators',
'Submagic is an AI-powered tool for adding animated captions and enhancing short-form video content, built specifically for the TikTok, YouTube Shorts, and Instagram Reels creator workflow. It automatically transcribes video audio, generates styled captions with word-by-word highlighting, and adds B-roll suggestions, emojis, and visual elements aligned with high-performing short-form formats. The caption style with highlighted words follows the proven pattern used by top creator accounts and podcasters, making content more watchable on muted feeds and increasing on-screen engagement.

The tool also generates AI-written video descriptions, hashtag sets, and titles optimised for each platform, and can create short highlight clips from longer content by identifying the most engaging segments automatically. Unlike generic subtitle tools, Submagic is designed specifically for the short-form creator workflow: fast, opinionated output that minimises editing decisions. Additional features include background music suggestions, scene transitions, and auto-formatted exports for different aspect ratios. The free plan includes a limited number of videos per month with a watermark; paid plans start at $15/month and unlock watermark-free exports, longer video support, and higher monthly generation limits. For creators producing consistent short-form content across multiple platforms, Submagic reduces the caption and publishing workflow from hours to minutes.',
NULL, 'https://submagic.co', 'https://submagic.co',
ARRAY['video-ai', 'content'], 'freemium', true, 15, 4.3, 2340, false, true, false,
ARRAY['Animated captions in the proven word-highlight format', 'Auto-generates descriptions, hashtags, and titles', 'Fast — captions ready in under 2 minutes', 'Optimised specifically for TikTok, Reels, and Shorts'],
ARRAY['Less control than manual caption editors', 'Watermark on free plan', 'Best for short-form only — not long-form video'],
ARRAY['Podcasters repurposing episodes as short social clips', 'Creators posting consistently across TikTok, Reels, and Shorts', 'Marketing teams adding captions to social video at scale']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'submagic')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'codeium', 'Codeium', 'Free AI code completion and chat for 70+ languages and editors',
'Codeium is an AI code completion and chat tool that provides free GitHub Copilot-equivalent functionality across 70+ programming languages and 40+ editors, including VS Code, JetBrains, Vim, Neovim, and Emacs. Its autocomplete engine generates multi-line code suggestions in real time as you type, while the integrated AI chat allows developers to explain code, find bugs, generate tests, and refactor directly within their editor. Codeium is trained on a broad public code corpus and produces suggestions competitive with paid alternatives across the most common programming tasks in Python, JavaScript, TypeScript, Java, Go, and Rust.

The primary differentiator is pricing: the individual plan is permanently free with unlimited code completions and chat messages, making it the default choice for independent developers, students, and anyone who wants AI code assistance without a monthly subscription. Codeium''s context awareness has improved significantly across newer model versions — it understands file-level context, recent edits, and repository structure for more relevant, less repetitive suggestions. Enterprise teams can access Codeium Enterprise for self-hosted deployment, audit logs, enterprise SSO, and access controls to prevent code leakage to external servers. For developers who find GitHub Copilot''s $10/month difficult to justify or who prefer not to send proprietary code to OpenAI''s infrastructure, Codeium is the strongest free and privacy-conscious alternative.',
NULL, 'https://codeium.com', 'https://codeium.com',
ARRAY['code-ai'], 'freemium', true, 0, 4.4, 4500, false, true, false,
ARRAY['Permanently free for individual developers with no usage cap', 'Supports 70+ languages and 40+ editors', 'Self-hosted enterprise option for code privacy', 'AI chat for explanation, debugging, and test generation'],
ARRAY['Suggestions occasionally less contextually accurate than Copilot on complex codebases', 'No native GitHub PR review integration', 'Smaller community and fewer integrations than Copilot'],
ARRAY['Students and independent developers wanting free AI coding help', 'Teams that cannot send proprietary code to external AI providers', 'Developers evaluating AI code tools before committing to a paid plan']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'codeium')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
SELECT 'posthog', 'PostHog', 'Open-source product analytics, session replay, and feature flags in one',
'PostHog is an open-source product analytics platform that combines event tracking, session recording, feature flags, A/B testing, and user surveys in a single tool — replacing the need for separate Mixpanel, Hotjar, LaunchDarkly, and Optimizely subscriptions. Its AI features include natural language querying (ask questions about your data in plain English and get SQL-generated results), automated insight suggestions, and anomaly detection for unexpected traffic or conversion changes. PostHog is fully self-hostable on any cloud infrastructure, making it the standard choice for companies with strict data residency requirements or those who want to avoid sending user behaviour data to third-party analytics vendors.

The platform targets product and engineering teams building digital products who need deep behavioural analytics without vendor lock-in or per-seat pricing. PostHog''s SQL-based query engine allows custom analysis beyond pre-built dashboards, and the open-source codebase means teams can extend it with custom plugins and integrations. The cloud-hosted version is free up to 1 million events per month — generous enough for most early-stage startups to instrument their entire product without a procurement process. Paid tiers scale by event volume with transparent per-event pricing and no seat restrictions. For product teams that want the analytical depth of Mixpanel, the session recording of Hotjar, and the feature flag capabilities of LaunchDarkly in a single unified platform, PostHog provides the most cost-effective all-in-one option.',
NULL, 'https://posthog.com', 'https://posthog.com',
ARRAY['analytics'], 'freemium', true, 0, 4.5, 2870, false, true, false,
ARRAY['Free up to 1M events/month — generous for startups', 'Open-source and fully self-hostable', 'Combines analytics, session replay, feature flags, and A/B testing', 'No per-seat pricing — scales with events, not headcount'],
ARRAY['UI is more technical than Mixpanel or Amplitude', 'Self-hosting requires DevOps capacity to maintain', 'Feature flag UI less polished than dedicated tools like LaunchDarkly'],
ARRAY['Startups instrumenting product analytics without a large budget', 'Engineering teams self-hosting to keep user data on their own infrastructure', 'Product teams consolidating multiple analytics tools into one platform']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'posthog')
ON CONFLICT (slug) DO NOTHING;
