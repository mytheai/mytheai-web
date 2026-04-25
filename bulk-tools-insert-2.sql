-- Bulk insert 20 additional tools (Session 10)
-- Run in Supabase → SQL Editor after bulk-tools-insert.sql

insert into tools (slug, name, tagline, logo_url, website_url, affiliate_url, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, tags, pros, cons, use_cases) values

-- Design
('figma', 'Figma', 'The collaborative design tool with AI features for wireframing, prototyping, and UI design.',
 'https://www.google.com/s2/favicons?domain=figma.com&sz=64', 'https://figma.com', 'https://figma.com',
 'freemium', true, 15, 4.8, 28400, true, false, true,
 ARRAY['design','productivity'],
 ARRAY['Best-in-class collaborative design tool','AI-powered design suggestions and auto-layout','Massive plugin ecosystem','Free tier covers most individual needs'],
 ARRAY['Can be slow with very large files','Steeper learning curve for non-designers','Offline mode is limited'],
 ARRAY['UI/UX design and prototyping','Design system management','Collaborative wireframing with teams','Handoff to developers with inspect mode']),

('framer', 'Framer', 'Design and publish production-ready websites with AI — no-code with real code under the hood.',
 'https://www.google.com/s2/favicons?domain=framer.com&sz=64', 'https://framer.com', 'https://framer.com',
 'freemium', true, 15, 4.6, 8200, false, true, false,
 ARRAY['design','code-ai'],
 ARRAY['AI website generation from text prompts','Publishes real websites, not just prototypes','Beautiful animations built in','React components for developers'],
 ARRAY['Learning curve for non-designers','Paid plan required for custom domain','Less mature than Webflow for complex sites'],
 ARRAY['Landing page creation with AI assistance','Portfolio and personal site building','Startup marketing websites','Interactive prototypes for client presentations']),

-- Productivity / Notes
('airtable', 'Airtable', 'The flexible database-spreadsheet hybrid with AI for automations and data organization.',
 'https://www.google.com/s2/favicons?domain=airtable.com&sz=64', 'https://airtable.com', 'https://airtable.com',
 'freemium', true, 20, 4.5, 14600, false, false, false,
 ARRAY['productivity','automation'],
 ARRAY['Spreadsheet UX with relational database power','AI field for text generation and classification','Excellent for content and project tracking','Strong automation and integration ecosystem'],
 ARRAY['Expensive at scale for large teams','Formula syntax can be complex','Not a replacement for full RDBMS'],
 ARRAY['Content calendar and editorial planning','Product roadmap and feature tracking','CRM for small sales teams','Event planning and vendor management']),

('mem-ai', 'Mem', 'AI-powered notes that self-organize — automatically connects related ideas across your knowledge base.',
 'https://www.google.com/s2/favicons?domain=mem.ai&sz=64', 'https://mem.ai', 'https://mem.ai',
 'freemium', true, 14, 4.2, 3100, false, false, false,
 ARRAY['productivity'],
 ARRAY['AI automatically surfaces related notes','No folder structure needed — AI organizes for you','Fast capture with smart tagging','Chat with your notes via AI assistant'],
 ARRAY['Small community compared to Notion/Obsidian','Mobile app less polished','Limited third-party integrations'],
 ARRAY['Personal knowledge management','Research notes and idea capture','Meeting notes that link to past context','Writers building a second brain']),

-- CRM / Sales
('intercom', 'Intercom', 'AI-powered customer messaging platform with live chat, chatbots, and help center.',
 'https://www.google.com/s2/favicons?domain=intercom.com&sz=64', 'https://intercom.com', 'https://intercom.com',
 'paid', false, 39, 4.4, 12800, false, false, false,
 ARRAY['crm-sales','productivity'],
 ARRAY['Fin AI agent resolves 50%+ of support tickets','Unified inbox for all customer channels','Product tours and onboarding flows built in','Best-in-class help center search'],
 ARRAY['Expensive for startups — costs scale with contacts','Setup complexity for advanced workflows','Reporting less deep than Zendesk'],
 ARRAY['SaaS customer support at scale','Onboarding new users with product tours','Proactive messaging based on user behavior','Reducing support volume with AI chatbot']),

('zendesk', 'Zendesk AI', 'Enterprise customer service platform with AI-powered ticket routing, summarization, and agent assist.',
 'https://www.google.com/s2/favicons?domain=zendesk.com&sz=64', 'https://zendesk.com', 'https://zendesk.com',
 'paid', false, 55, 4.3, 18400, false, false, false,
 ARRAY['crm-sales'],
 ARRAY['AI ticket routing and priority classification','Agent Copilot suggests replies in real-time','Comprehensive analytics and SLA tracking','Scales to enterprise support teams of 1000+'],
 ARRAY['Expensive for smaller teams','Long implementation time','UI feels dated compared to newer tools'],
 ARRAY['Enterprise-scale customer support operations','Multi-channel support (email, chat, phone, social)','SLA tracking and compliance reporting','AI-assisted agent productivity at scale']),

('pipedrive', 'Pipedrive', 'Sales CRM with AI sales assistant for pipeline management, deal forecasting, and follow-ups.',
 'https://www.google.com/s2/favicons?domain=pipedrive.com&sz=64', 'https://pipedrive.com', 'https://pipedrive.com',
 'paid', false, 14, 4.4, 9600, false, false, false,
 ARRAY['crm-sales'],
 ARRAY['Visual pipeline management is best-in-class','AI Sales Assistant gives deal insights','Email integration tracks all communications','Affordable starting price for SMBs'],
 ARRAY['Limited marketing automation vs HubSpot','Reporting less advanced than Salesforce','Mobile app needs improvement'],
 ARRAY['Sales pipeline tracking for SMBs','Deal stage management and forecasting','Email follow-up automation','Sales team performance reporting']),

-- Analytics
('tableau', 'Tableau AI', 'The leading data visualization platform with Tableau AI for natural language queries and insights.',
 'https://www.google.com/s2/favicons?domain=tableau.com&sz=64', 'https://tableau.com', 'https://tableau.com',
 'paid', false, 75, 4.4, 16200, false, false, false,
 ARRAY['analytics'],
 ARRAY['Best-in-class interactive data visualization','Ask Data feature: query data in plain English','Handles millions of rows without performance lag','Salesforce CRM integration is seamless'],
 ARRAY['Very expensive starting at $75/user/month','Steep learning curve for advanced features','Slower to build dashboards vs Metabase'],
 ARRAY['Executive dashboards and C-suite reporting','Sales and marketing performance analytics','Supply chain and operations monitoring','Ad-hoc data exploration for analysts']),

('metabase', 'Metabase', 'Open-source business intelligence tool — SQL or no-code analytics for the whole team.',
 'https://www.google.com/s2/favicons?domain=metabase.com&sz=64', 'https://metabase.com', 'https://metabase.com',
 'freemium', true, 50, 4.5, 7800, false, false, true,
 ARRAY['analytics'],
 ARRAY['Free open-source version available','Non-technical users can build dashboards without SQL','Quick setup — connect DB and start in minutes','Embedded analytics for SaaS products'],
 ARRAY['Advanced features require paid cloud plan','Less powerful than Tableau for complex analysis','Limited visualization types vs Power BI'],
 ARRAY['Startup analytics dashboards','Embedded analytics in SaaS products','Non-technical team self-service reporting','Database monitoring and health metrics']),

('looker', 'Looker', 'Google Cloud BI platform with LookML for governed metrics and AI-powered exploration.',
 'https://www.google.com/s2/favicons?domain=looker.com&sz=64', 'https://looker.com', 'https://looker.com',
 'paid', false, 3000, 4.3, 6400, false, false, false,
 ARRAY['analytics'],
 ARRAY['LookML creates a single source of truth for metrics','Deep Google Cloud and BigQuery integration','Governed data model prevents metric inconsistency','Strong API for embedded analytics'],
 ARRAY['Very expensive — enterprise only pricing','LookML learning curve for analysts','Slower iteration than self-serve BI tools'],
 ARRAY['Enterprise data governance and metrics standardization','Google Cloud data stack analytics','Embedded analytics in enterprise SaaS','Cross-team KPI alignment and reporting']),

-- Research
('elicit', 'Elicit', 'AI research assistant that searches academic papers, summarizes findings, and extracts key data.',
 'https://www.google.com/s2/favicons?domain=elicit.com&sz=64', 'https://elicit.com', 'https://elicit.com',
 'freemium', true, 12, 4.5, 4200, false, true, false,
 ARRAY['ai-assistants'],
 ARRAY['Searches 200M+ academic papers automatically','Extracts key findings into structured tables','Summarizes papers without reading full PDFs','Great for literature reviews and systematic reviews'],
 ARRAY['Primarily academic literature — not web sources','Paid plan for high-volume research','Coverage weaker for recent preprints'],
 ARRAY['Academic literature reviews','Scientific research synthesis','Comparing study methodologies','Market research with academic backing']),

('consensus', 'Consensus', 'AI search engine that finds scientific consensus — cite-backed answers from peer-reviewed research.',
 'https://www.google.com/s2/favicons?domain=consensus.app&sz=64', 'https://consensus.app', 'https://consensus.app',
 'freemium', true, 9, 4.4, 3600, false, false, false,
 ARRAY['ai-assistants'],
 ARRAY['Answers backed by real peer-reviewed citations','Consensus meter shows scientific agreement level','Great for fact-checking health and science claims','Simpler interface than Elicit for quick queries'],
 ARRAY['Limited to academic research, no web sources','Slower than general AI for non-research questions','Paid plan for unlimited searches'],
 ARRAY['Fact-checking health and nutrition claims','Evidence-based content creation','Medical and science writing with citations','Academic paper discovery for specific topics']),

-- Video AI
('synthesia', 'Synthesia', 'AI video generation with 160+ digital avatars — create professional videos from text, no camera needed.',
 'https://www.google.com/s2/favicons?domain=synthesia.io&sz=64', 'https://synthesia.io', 'https://synthesia.io',
 'paid', false, 29, 4.5, 6800, false, true, true,
 ARRAY['video-ai'],
 ARRAY['160+ lifelike AI avatars, 120+ languages','No camera, studio, or actors needed','Best-in-class lip sync quality','Custom avatar from your own likeness'],
 ARRAY['Videos can still feel slightly uncanny','Limited creative control vs traditional video','Expensive for high-volume production'],
 ARRAY['Corporate training and e-learning at scale','Multilingual product demo videos','Internal communications without video team','Personalized sales videos at scale']),

('loom', 'Loom AI', 'Screen and camera recorder with AI transcription, summaries, and automatic chapter creation.',
 'https://www.google.com/s2/favicons?domain=loom.com&sz=64', 'https://loom.com', 'https://loom.com',
 'freemium', true, 12, 4.6, 11200, false, false, false,
 ARRAY['video-ai','productivity'],
 ARRAY['Instant async video with AI summary','Auto-generates transcripts and chapters','Viewer reactions and comments on timeline','Integrates with Slack, Notion, and Jira'],
 ARRAY['AI features require paid plan','Large files can take time to process','Limited video editing tools'],
 ARRAY['Async team communication replacing meetings','Bug reports and feature walkthroughs for engineers','Customer onboarding and tutorial videos','Sales follow-up videos for prospects']),

-- Voice / Audio
('fireflies-ai', 'Fireflies.ai', 'AI meeting recorder with transcription, speaker identification, and searchable conversation archive.',
 'https://www.google.com/s2/favicons?domain=fireflies.ai&sz=64', 'https://fireflies.ai', 'https://fireflies.ai',
 'freemium', true, 18, 4.4, 7400, false, false, false,
 ARRAY['voice-audio','productivity'],
 ARRAY['Auto-joins meetings and records without setup','Speaker identification across 40+ languages','Smart search across all past meetings','CRM sync pushes call notes to Salesforce/HubSpot'],
 ARRAY['Free plan limits storage to 800 minutes','Privacy concerns for sensitive meetings','Accuracy drops with heavy accents or crosstalk'],
 ARRAY['Sales call recording and CRM logging','Recruiting interview transcription','Team standup and planning meeting notes','Client meeting documentation and follow-ups']),

-- Dev Tools
('railway', 'Railway', 'Deploy any app in seconds — modern infrastructure platform with zero DevOps required.',
 'https://www.google.com/s2/favicons?domain=railway.app&sz=64', 'https://railway.app', 'https://railway.app',
 'freemium', true, 5, 4.6, 5200, false, true, false,
 ARRAY['code-ai'],
 ARRAY['Deploy from GitHub in under 2 minutes','Automatic HTTPS, scaling, and databases included','Simple pricing based on actual usage','Great developer experience vs AWS/GCP'],
 ARRAY['Less mature than Heroku/Render for some languages','Limited to smaller/medium workloads','Fewer regions than major cloud providers'],
 ARRAY['Deploying side projects and prototypes quickly','Startups needing simple production infrastructure','Staging environments for development teams','Database hosting with auto-backups']),

('vercel-v0', 'v0 by Vercel', 'AI UI generation from text prompts — generates React and Tailwind components instantly.',
 'https://www.google.com/s2/favicons?domain=v0.dev&sz=64', 'https://v0.dev', 'https://v0.dev',
 'freemium', true, 20, 4.5, 6900, false, true, true,
 ARRAY['code-ai'],
 ARRAY['Generates production-ready React + Tailwind UI','Chat to iterate and refine components','shadcn/ui components out of the box','One-click deploy to Vercel'],
 ARRAY['Best for UI components, not full app logic','Requires React/Tailwind knowledge to customize','Free tier has limited monthly credits'],
 ARRAY['Rapid UI prototyping for React apps','Generating component variants for A/B testing','Frontend developers accelerating design-to-code','Landing page sections and marketing UI']),

-- SEO / Marketing
('ahrefs', 'Ahrefs', 'SEO toolset for backlink analysis, keyword research, site audits, and competitor intelligence.',
 'https://www.google.com/s2/favicons?domain=ahrefs.com&sz=64', 'https://ahrefs.com', 'https://ahrefs.com',
 'paid', false, 99, 4.6, 13800, false, false, true,
 ARRAY['seo-marketing'],
 ARRAY['Largest backlink database after Google','Keyword difficulty scores are most accurate in market','Content gap analysis finds quick win opportunities','Site audit crawls up to 500 pages on starter plan'],
 ARRAY['No free tier — expensive at $99/mo minimum','Data export limits on lower plans','Learning curve for new SEO practitioners'],
 ARRAY['Backlink profile analysis and link building','Keyword research for SEO content strategy','Competitor content gap analysis','Technical SEO audits and health monitoring']);
