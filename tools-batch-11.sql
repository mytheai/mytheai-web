-- tools-batch-11.sql
-- 10 new tools: apollo, coda, glean, taplio, microsoft-designer, laxis, supernormal, adobe-premiere-pro, substack, capcut
-- DB: 133 → 143 tools after running
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

-- 1. Apollo.io
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'apollo', 'Apollo.io', 'Sales intelligence platform with 275M+ verified contacts and AI-powered outreach automation',
'Apollo.io is the leading sales intelligence and engagement platform, combining a database of over 275 million verified business contacts with AI-powered email sequencing, task automation, and CRM enrichment. Sales teams use Apollo to identify ideal prospects, verify contact information in real time, and run personalised outreach sequences at scale — replacing the manual work of list-building and cold prospecting with automated, data-driven workflows. Its Chrome extension enables instant contact lookup directly on LinkedIn profiles and company websites.

What distinguishes Apollo from comparable tools is its integration of data and execution in one platform. Rather than using separate tools for enrichment, sequencing, and CRM sync, Apollo handles all three without context-switching. It integrates with HubSpot, Salesforce, Outreach, and Salesloft, and its AI email personalisation features help teams increase reply rates without sacrificing sending volume. Apollo''s free plan includes 10,000 contact records per month, making it accessible for individual SDRs and founders before committing to a paid seat.',
'https://apollo.io', 'https://apollo.io', 'https://www.google.com/s2/favicons?domain=apollo.io&sz=64',
ARRAY['sales', 'marketing'], 'freemium', true, 49, 4.5, 2847, false, false, false,
ARRAY['275M+ verified contact database', 'Built-in email sequencing and automation', 'Real-time contact enrichment via Chrome extension', 'Generous free plan for individual users', 'Deep CRM integrations with HubSpot and Salesforce'],
ARRAY['Contact data accuracy varies by region and industry', 'Can feel overwhelming for users who only need basic prospecting', 'Email deliverability requires careful warm-up configuration'],
ARRAY['B2B lead generation and prospecting at scale', 'Automating cold outreach email sequences for sales teams', 'Enriching CRM records with verified contact and company data'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'apollo')
ON CONFLICT (slug) DO NOTHING;

-- 2. Coda
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'coda', 'Coda', 'The all-in-one doc that replaces documents, spreadsheets, and databases with a programmable canvas',
'Coda is a collaborative document platform that blends the functionality of documents, spreadsheets, and databases into a single tool with a powerful formula layer and native automation engine. Teams use Coda to build internal wikis, project trackers, lightweight CRMs, and automated approval workflows — all without leaving a single document. Coda AI can draft content, summarise tables, translate documents, and build automations from natural language prompts, reducing the technical barrier to creating dynamic team tooling.

What separates Coda from Notion and Google Docs is the programmability of its tables and the depth of its integration layer. Packs connect Coda to over 600 tools including GitHub, Jira, Salesforce, and Slack, allowing data to flow in and out of documents automatically. For operations teams, product managers, and founders who need documents that actually do things — route approvals, update records, trigger alerts, calculate forecasts — Coda provides the most flexible all-in-one canvas in the productivity category. Its free plan supports unlimited editors on one document.',
'https://coda.io', 'https://coda.io', 'https://www.google.com/s2/favicons?domain=coda.io&sz=64',
ARRAY['productivity', 'code-ai'], 'freemium', true, 19, 4.4, 1923, false, false, false,
ARRAY['Programmable tables and formulas rival spreadsheet tools', 'Native automation engine without Zapier dependency', 'Coda AI drafts and summarises content across any document', '600+ integrations via Packs', 'Flexible enough to replace multiple specialised tools'],
ARRAY['Steeper learning curve than Notion for basic users', 'Can become slow with very large datasets', 'Free plan limited to one document with all features'],
ARRAY['Building internal team wikis and knowledge bases', 'Creating automated project trackers with approval workflows', 'Running lightweight CRM or deal tracking directly in documents'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'coda')
ON CONFLICT (slug) DO NOTHING;

-- 3. Glean
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'glean', 'Glean', 'Enterprise AI search that connects every tool your company uses into one intelligent knowledge layer',
'Glean is an enterprise AI search platform that indexes content across every tool a company uses — Google Drive, Slack, Confluence, GitHub, Salesforce, Notion, and more than 100 other integrations — and provides a single intelligent search interface across all of them. Instead of switching between applications to find information, employees ask Glean in natural language and receive accurate answers drawn from the company''s actual internal content, with citations to the source documents they can verify and trace.

Glean Chat, the platform''s AI assistant, goes beyond search to help employees draft emails, summarise documents, and answer procedural questions using internal knowledge rather than generic training data. The platform is built specifically for enterprise security requirements: permission controls ensure users only see content they already have access to in the source system, and IT administrators control what data is indexed and retained. For knowledge-intensive organisations where employees spend hours per week searching for information across fragmented tool stacks, Glean is the most comprehensive AI search and knowledge management solution available.',
'https://glean.com', 'https://glean.com', 'https://www.google.com/s2/favicons?domain=glean.com&sz=64',
ARRAY['productivity', 'research-ai'], 'paid', false, 0, 4.3, 1205, false, true, false,
ARRAY['Unified search across 100+ enterprise tool integrations', 'Respects existing permission models — users only see authorised content', 'AI answers grounded in actual company knowledge, not generic training data', 'Reduces time spent searching for information across fragmented tools', 'Strong enterprise security and compliance controls'],
ARRAY['Enterprise-only pricing — not suitable for small teams or individuals', 'Requires IT setup and integration configuration', 'No free plan or self-service trial'],
ARRAY['Replacing fragmented multi-tool search for enterprise knowledge workers', 'Onboarding new employees by giving instant access to company knowledge', 'Answering procedural and policy questions using internal documentation'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'glean')
ON CONFLICT (slug) DO NOTHING;

-- 4. Taplio
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'taplio', 'Taplio', 'AI LinkedIn content platform for growing your professional audience through consistent, high-quality posts',
'Taplio is an AI-powered LinkedIn content platform designed for professionals who want to build a personal brand, grow their network, and generate leads through consistent LinkedIn activity. The AI drafts full post ideas based on your professional background, writes complete posts in your tone, and schedules content for the times your audience is most active — reducing the time investment required to maintain a high-quality LinkedIn presence from hours to minutes per week.

Beyond content creation, Taplio includes a relationship management layer that tracks who engages with your posts and surfaces contacts worth reaching out to. Its inspiration feed aggregates top-performing content from thought leaders in your industry, helping users understand what formats and topics resonate. For consultants, founders, executives, sales professionals, and recruiters who depend on LinkedIn for business development, Taplio handles the entire content workflow from ideation to scheduling and follow-up — making it the most purpose-built tool for LinkedIn growth in the market.',
'https://taplio.com', 'https://taplio.com', 'https://www.google.com/s2/favicons?domain=taplio.com&sz=64',
ARRAY['marketing', 'writing-ai'], 'paid', false, 39, 4.3, 876, false, false, false,
ARRAY['AI drafts full LinkedIn posts in your professional voice', 'Relationship management tracks engagement for follow-up outreach', 'Inspiration feed surfaces top-performing content by industry', 'Scheduling optimises post timing for maximum reach', 'Carousel builder for visual LinkedIn posts'],
ARRAY['LinkedIn-only — no support for other social platforms', 'Requires manual refinement to avoid AI-generic post tone', 'Pricing is high relative to tools that cover multiple platforms'],
ARRAY['Building a personal brand on LinkedIn as a founder or executive', 'Generating consistent thought leadership content for lead generation', 'Scheduling and managing LinkedIn content for a professional account'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'taplio')
ON CONFLICT (slug) DO NOTHING;

-- 5. Microsoft Designer
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'microsoft-designer', 'Microsoft Designer', 'Free AI design tool for social media graphics, presentations, and digital content — powered by DALL-E',
'Microsoft Designer is a free AI-powered graphic design tool available as a standalone web app and built into Microsoft 365 applications. It generates professional social media graphics, presentation slides, and digital content from text prompts, using DALL-E for image generation and offering smart layout suggestions that automatically adapt to different formats and aspect ratios. For users already in the Microsoft ecosystem, Designer connects directly with PowerPoint, Teams backgrounds, and OneDrive for seamless file access.

The tool is positioned as an accessible alternative to Canva for users who need quick, polished visuals without design training. Its AI can generate complete social graphics, suggest typography and colour palettes based on brand colours, and resize designs for multiple platforms in one click. Designer is available at no cost to all Microsoft account holders — including anyone with a Microsoft personal account — making it a natural starting point before committing to paid design subscriptions. Copilot integration means users can describe complex layouts in plain English and receive multiple design options to choose from.',
'https://designer.microsoft.com', 'https://designer.microsoft.com', 'https://www.google.com/s2/favicons?domain=microsoft.com&sz=64',
ARRAY['design-ai', 'image-ai'], 'freemium', true, 0, 4.2, 2341, false, false, false,
ARRAY['Completely free for Microsoft account holders', 'DALL-E image generation built in', 'Integrates with Microsoft 365 apps (PowerPoint, Teams)', 'One-click resize for multiple social media formats', 'No design experience required'],
ARRAY['Less template variety than Canva', 'Limited advanced design controls compared to Figma or Adobe tools', 'Best suited for social graphics — less capable for complex print or brand assets'],
ARRAY['Creating social media graphics quickly for Microsoft 365 users', 'Generating AI images for presentations and documents', 'Designing professional visuals without a Canva subscription'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'microsoft-designer')
ON CONFLICT (slug) DO NOTHING;

-- 6. Laxis
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'laxis', 'Laxis', 'AI meeting assistant with CRM sync that turns every sales call into structured notes and action items',
'Laxis is an AI meeting assistant that joins video calls on Google Meet, Zoom, and Microsoft Teams to transcribe conversations in real time, generate structured meeting summaries, and extract action items automatically. For sales teams, its standout feature is deep CRM integration — Laxis syncs call summaries, identified next steps, and deal notes directly into Salesforce and HubSpot immediately after each call ends, eliminating the post-call admin work that costs sales representatives hours each week.

The platform supports over 40 languages and can be trained on custom vocabulary and terminology, making it accurate for technical, legal, or industry-specific conversations where standard transcription tools struggle. Laxis''s conversational intelligence features track topics discussed across multiple calls with the same prospect over time, giving sales managers and account executives a longitudinal view of deal conversations without reviewing full recordings. Its free plan covers up to 300 minutes of meeting transcription per month — sufficient for moderate meeting loads before upgrading.',
'https://laxis.com', 'https://laxis.com', 'https://www.google.com/s2/favicons?domain=laxis.com&sz=64',
ARRAY['productivity', 'sales'], 'freemium', true, 16, 4.4, 743, false, false, false,
ARRAY['Direct Salesforce and HubSpot CRM sync after each call', 'Supports 40+ languages for international teams', 'Custom vocabulary training improves accuracy for technical conversations', 'Longitudinal deal tracking across multiple prospect calls', 'Free plan covers 300 minutes per month'],
ARRAY['Less brand recognition than Otter.ai or Fireflies', 'CRM sync limited to Salesforce and HubSpot on base plans', 'Mobile app experience is less polished than desktop'],
ARRAY['Automating post-call CRM updates for sales teams', 'Transcribing and summarising client meetings for account management', 'Tracking conversation trends across multiple calls with the same prospect'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'laxis')
ON CONFLICT (slug) DO NOTHING;

-- 7. Supernormal
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'supernormal', 'Supernormal', 'AI meeting notes that automatically join your calls and deliver structured summaries within minutes',
'Supernormal is an AI note-taking tool that automatically joins Google Meet, Zoom, and Microsoft Teams calls, records the conversation, and delivers a structured summary — with clearly labelled sections for key discussion points, decisions made, and action items with owners — within minutes of the call ending. Unlike manual note-taking, Supernormal captures everything discussed so participants can remain fully engaged in the conversation rather than typing throughout.

The platform integrates with Notion, Asana, Linear, HubSpot, and Slack to push action items and summaries directly into the tools where teams already track work — eliminating the copy-paste step between meeting notes and task management. Supernormal''s free plan supports unlimited meetings with full AI summaries, making it the most accessible fully-featured meeting notes tool available at any price point. For teams running five or more meetings per day, Supernormal removes the documentation burden while ensuring every decision and action item is captured, attributed, and surfaced where it needs to be.',
'https://supernormal.com', 'https://supernormal.com', 'https://www.google.com/s2/favicons?domain=supernormal.com&sz=64',
ARRAY['productivity'], 'freemium', true, 19, 4.5, 1124, false, true, false,
ARRAY['Unlimited meetings on the free plan', 'Structured summaries with decisions and action items clearly labelled', 'Integrates with Notion, Asana, Linear, HubSpot, and Slack', 'No manual setup required — joins calls automatically', 'Fast summary delivery within minutes of call end'],
ARRAY['Less advanced speaker identification than Fireflies or Otter', 'Search across historical meeting notes requires paid plan', 'Limited customisation of summary format on free tier'],
ARRAY['Capturing action items and decisions from team standups and planning meetings', 'Eliminating post-meeting notes for client calls and sales discovery', 'Syncing meeting outcomes directly into project management tools'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'supernormal')
ON CONFLICT (slug) DO NOTHING;

-- 8. Adobe Premiere Pro
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'adobe-premiere-pro', 'Adobe Premiere Pro', 'Industry-standard professional video editing software with AI-powered tools for faster, smarter editing',
'Adobe Premiere Pro is the industry-standard professional video editing application, used by filmmakers, television broadcasters, agency video teams, and content creators worldwide. Its recent AI features — powered by Adobe Sensei and the Firefly Video Model — include Generative Extend (seamlessly extends clips to fill gaps), Text-Based Editing (edit video by editing a transcript as a document), Auto Reframe (intelligently reframes footage for different aspect ratios with one click), automatic captions with 98%+ accuracy, and AI-powered audio cleanup that removes background noise and echo.

Premiere Pro is the centrepiece of a professional video workflow: it integrates directly with After Effects for motion graphics, Audition for audio post-production, Photoshop for image assets, and Adobe Stock for licensed media. While the learning curve is steeper than tools like CapCut or Descript, Premiere Pro offers capabilities at a level no other editing application matches — specifically for long-form narrative content, broadcast delivery, and colour-graded production work. It is available on Mac and Windows through a Creative Cloud subscription, with plans starting at $22.99/month.',
'https://adobe.com/products/premiere', 'https://adobe.com/products/premiere', 'https://www.google.com/s2/favicons?domain=adobe.com&sz=64',
ARRAY['video-ai'], 'paid', false, 23, 4.6, 4521, false, false, false,
ARRAY['Industry standard — universal in professional video production', 'Text-Based Editing makes rough cuts dramatically faster', 'Deep Adobe Creative Cloud integration (After Effects, Audition, Photoshop)', 'Generative Extend fills awkward gaps in footage seamlessly', 'Auto Reframe handles multi-platform aspect ratio exports'],
ARRAY['Subscription required — no perpetual licence option', 'Steep learning curve for new editors', 'Resource-intensive — requires a capable machine for smooth performance'],
ARRAY['Professional narrative and documentary film editing', 'Broadcast television and streaming platform content production', 'Creating polished marketing videos with multi-track audio and colour grading'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'adobe-premiere-pro')
ON CONFLICT (slug) DO NOTHING;

-- 9. Substack
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'substack', 'Substack', 'Newsletter and publishing platform with AI writing assistance, built-in payments, and audience growth tools',
'Substack is a newsletter and publishing platform that lets writers publish email newsletters, long-form articles, and podcasts directly to subscribers — with built-in payment processing, audience management, and AI writing assistance. Unlike traditional email marketing platforms, Substack is designed around editorial publishing: writers get a personal publication homepage, readers subscribe with a click, and paid subscriptions are handled natively without a third-party payment provider. Its AI features help writers draft content, generate post ideas, and improve clarity, while Substack Notes provides a Twitter-like feed for shorter updates within the same audience.

What sets Substack apart from Beehiiv and ConvertKit is its network: Substack''s built-in recommendation system surfaces new publications to readers based on what they already subscribe to, creating organic discovery that external newsletter platforms cannot replicate. Writers keep their subscriber lists and can export to any email platform if they choose to leave. The platform takes 10% of paid subscription revenue (none on free publications), with no upfront cost. With over 35 million active readers across the platform, Substack offers the largest built-in audience discovery network in independent publishing.',
'https://substack.com', 'https://substack.com', 'https://www.google.com/s2/favicons?domain=substack.com&sz=64',
ARRAY['writing-ai', 'marketing'], 'freemium', true, 0, 4.4, 3287, false, false, false,
ARRAY['Free to publish — platform only takes 10% of paid subscriptions', 'Built-in audience discovery via Substack network recommendations', 'AI writing assistance integrated directly into the editor', 'Subscribers are fully portable — you own your list', 'Handles newsletters, articles, podcasts, and Notes in one platform'],
ARRAY['10% revenue cut is high for large publications at scale', 'Less email deliverability control than dedicated ESP platforms', 'Limited design customisation compared to Ghost or dedicated website platforms'],
ARRAY['Launching a paid newsletter publication as an independent writer', 'Building an audience around expertise or niche content', 'Distributing long-form articles and journalism directly to email subscribers'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'substack')
ON CONFLICT (slug) DO NOTHING;

-- 10. CapCut
INSERT INTO tools (slug, name, tagline, description, website_url, affiliate_url, logo_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases, updated_at)
SELECT 'capcut', 'CapCut', 'Free AI video editor for short-form content — auto-captions, templates, voice cloning, and one-click effects',
'CapCut is a free AI-powered video editing app by ByteDance, available on iOS, Android, and as a web and desktop application. It has become the dominant tool for short-form video content creation, driven by an extensive set of AI features: auto-captions with 98%+ accuracy in over 30 languages, background removal without green screen, AI-generated B-roll from text prompts, voice cloning and AI voiceover, instant translation with lip sync, and smart cut tools that automatically identify the most engaging moments in long recordings for repurposing.

Originally built for TikTok creators, CapCut is now used widely across YouTube Shorts, Instagram Reels, and social media marketing teams at brands of all sizes. Its template library covers trending video formats, allowing creators and marketers to produce professional-looking short-form videos in minutes with no editing experience required. The free plan is highly functional for most use cases; CapCut Pro at $9.99/month removes watermarks, adds advanced AI effects, and increases cloud storage. For anyone producing short-form video content at volume, CapCut offers the best combination of AI capability, ease of use, and price available in the market.',
'https://capcut.com', 'https://capcut.com', 'https://www.google.com/s2/favicons?domain=capcut.com&sz=64',
ARRAY['video-ai'], 'freemium', true, 10, 4.6, 5843, false, true, false,
ARRAY['Completely free with highly functional AI features', 'Auto-captions in 30+ languages with 98%+ accuracy', 'AI B-roll generation from text prompts', 'Available on mobile, web, and desktop', 'Vast trending template library for short-form formats'],
ARRAY['ByteDance ownership raises data privacy concerns for enterprise users', 'Watermark on free plan exports', 'Less capable than Premiere Pro for long-form or professional production work'],
ARRAY['Creating short-form video content for TikTok, Reels, and YouTube Shorts', 'Adding AI-generated captions to video content for accessibility and engagement', 'Repurposing long-form videos into short clips using smart cut tools'],
NOW()
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'capcut')
ON CONFLICT (slug) DO NOTHING;
