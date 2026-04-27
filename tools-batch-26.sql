-- tools-batch-26.sql
-- AI Sales & CRM tools (10 tools)
-- DB: ~282 tools -> ~292 tools
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

-- 1. Pipedrive
(
  'pipedrive', 'Pipedrive', 'Sales CRM built around activity-based selling',
  'Pipedrive is a sales-focused CRM built for teams that sell actively and need a clear pipeline view of every deal. Unlike general-purpose CRMs, Pipedrive organises everything around the activity - the next call, email, or meeting that moves a deal forward. Its visual pipeline board shows every open deal, stage probability, and stale deal at a glance. Pipedrive AI features include a sales assistant that suggests next actions based on deal history, an email writing assistant that drafts personalised outreach, and lead scoring that surfaces the highest-priority prospects. The platform integrates with Google Workspace, Microsoft 365, Slack, Zapier, and 400+ other tools. Pipedrive is popular with B2B sales teams from 5 to 500 people who want a CRM that focuses on closing rather than CRM administration. The reporting suite tracks conversion rates by stage, revenue forecasts by rep, and activity completion rates.',
  'https://www.google.com/s2/favicons?domain=pipedrive.com&sz=64',
  'https://pipedrive.com', 'https://pipedrive.com',
  ARRAY['crm', 'sales', 'productivity'],
  'paid', false, 14.00,
  4.4, 9800, false, false, false,
  ARRAY['Visual pipeline board built for active selling', 'AI sales assistant suggests next actions', 'Clean interface with low learning curve', 'Strong email integration and tracking'],
  ARRAY['No free plan', 'Reporting less powerful than Salesforce on base plans', 'Weaker marketing automation than HubSpot'],
  ARRAY['B2B sales teams managing deal pipelines and follow-ups', 'Small and mid-size companies replacing spreadsheet-based sales tracking', 'Teams wanting a CRM focused on activities rather than data entry']
),

-- 2. Close CRM
(
  'close-crm', 'Close', 'Sales CRM with built-in calling, SMS, and email for inside sales teams',
  'Close is a sales CRM built specifically for inside sales teams - teams that sell primarily through phone, email, and video rather than in-person meetings. Where most CRMs require separate tools for calling and emailing, Close includes a built-in power dialer, predictive dialer, SMS, and email sequences in a single platform. Sales reps can call prospects, leave voicemails automatically, send follow-up emails, and log everything without leaving the CRM. Close AI generates email drafts and call summaries, and its smart views surface the highest-priority leads automatically. The activity timeline shows every touchpoint with a contact - calls, emails, SMS, and notes - in chronological order. Close is particularly strong for SaaS companies with outbound sales motions and for recruiting teams. Its flat per-seat pricing with all features included (no feature gating) makes it predictable to budget for growing teams.',
  'https://www.google.com/s2/favicons?domain=close.com&sz=64',
  'https://close.com', 'https://close.com',
  ARRAY['crm', 'sales', 'ai-assistant'],
  'paid', false, 49.00,
  4.6, 2800, false, false, false,
  ARRAY['Built-in power dialer and predictive dialer', 'All features included at every pricing tier', 'AI call summaries and email drafts', 'Smart views prioritise highest-value leads automatically'],
  ARRAY['Higher per-seat cost than entry-level CRMs', 'Less suitable for field sales or complex enterprise deals', 'Fewer native integrations than Salesforce or HubSpot'],
  ARRAY['SaaS inside sales teams running high-volume outbound', 'Recruiting agencies managing candidate outreach', 'Teams replacing multiple calling and email tools with one platform']
),

-- 3. Attio
(
  'attio', 'Attio', 'Modern AI CRM that builds itself from your existing data',
  'Attio is a next-generation CRM that takes a fundamentally different approach: instead of forcing you to manually enter data, it automatically enriches your contacts and companies from your connected email, calendar, and communication tools. Every interaction you have is automatically logged, contacts are enriched with company data, funding rounds, and job titles from public sources, and the CRM builds itself as you work. Attio is built around objects and attributes that you can customise freely - creating the data model that fits your business rather than adapting your business to a predefined CRM structure. Its AI features include automated data enrichment, deal progress analysis, and natural language querying of your CRM data. Attio is particularly popular with venture-backed startups and growth-stage companies that want modern tooling without the configuration overhead of legacy CRMs. The collaboration features allow teams to share notes, view relationship history, and assign next steps without switching to separate tools.',
  'https://www.google.com/s2/favicons?domain=attio.com&sz=64',
  'https://attio.com', 'https://attio.com',
  ARRAY['crm', 'sales', 'ai-assistant', 'productivity'],
  'freemium', true, 0.00,
  4.7, 1200, false, false, false,
  ARRAY['CRM builds itself from email and calendar data automatically', 'Fully customisable data model with no predefined structure', 'AI data enrichment for contacts and companies', 'Modern interface with strong collaboration features'],
  ARRAY['Less mature than Salesforce or HubSpot for complex sales processes', 'Fewer native integrations with marketing tools', 'Best for relationship-based sales - less suited to high-volume transactional'],
  ARRAY['Startups and growth-stage companies replacing legacy CRMs', 'VC firms and BD teams managing relationship pipelines', 'Teams that hate manual CRM data entry and want automation']
),

-- 4. Affinity
(
  'affinity', 'Affinity', 'Relationship intelligence CRM for dealmakers and relationship-driven teams',
  'Affinity is a relationship intelligence platform built for professionals whose work is driven by who they know - venture capitalists, investment bankers, private equity firms, business development teams, and recruiters. It automatically captures every email, meeting, and interaction from your team''s inboxes and calendars, then maps the relationship graph: who knows whom, how strong the relationship is, and when the last touchpoint was. Affinity''s AI analyses relationship strength scores, surfaces warm introduction paths to target companies or individuals, and alerts you when a key relationship is going cold. For VC firms, it tracks portfolio company interactions and investor relationships across the entire team. The platform integrates with Gmail, Google Calendar, Outlook, LinkedIn, Salesforce, and Slack. Unlike traditional CRMs that require manual input, Affinity works in the background - ensuring the CRM reflects reality rather than whoever had time to update records last.',
  'https://www.google.com/s2/favicons?domain=affinity.co&sz=64',
  'https://affinity.co', 'https://affinity.co',
  ARRAY['crm', 'sales', 'ai-assistant'],
  'paid', false, 0.00,
  4.5, 980, false, false, false,
  ARRAY['Automatic relationship data capture from email and calendar', 'Relationship strength scores and warm intro path finding', 'Purpose-built for VC, PE, banking, and BD workflows', 'Team-wide relationship visibility with no manual data entry'],
  ARRAY['Custom pricing - not transparent on website', 'Overkill for standard sales teams outside dealmaking contexts', 'Learning curve for teams new to relationship-intelligence tools'],
  ARRAY['VC and PE firms tracking portfolio and investor relationships', 'Investment banking and M&A teams managing deal relationships', 'Enterprise BD teams finding warm paths into target accounts']
),

-- 5. Lemlist
(
  'lemlist', 'Lemlist', 'Multichannel cold outreach platform with AI personalisation',
  'Lemlist is a cold outreach platform that runs personalised email, LinkedIn, and phone sequences from a single campaign builder. Where basic email tools send the same message to everyone, Lemlist personalises at scale - inserting custom text, images, and even personalised videos into emails automatically based on prospect data. The AI features include a campaign builder that writes full outreach sequences from a prompt, a lead enrichment tool that finds verified email addresses and LinkedIn profiles, and a deliverability dashboard that monitors sender reputation and inbox placement. Lemlist''s LinkedIn automation handles connection requests, message sequences, and profile visits as part of multi-touch campaigns. The platform includes a built-in lead database with 450M+ contacts for teams that need prospecting and outreach in one tool. For sales teams and agencies running outbound campaigns, Lemlist reduces the time between identifying a prospect and sending a personalised, multi-channel sequence.',
  'https://www.google.com/s2/favicons?domain=lemlist.com&sz=64',
  'https://lemlist.com', 'https://lemlist.com',
  ARRAY['sales', 'marketing', 'ai-assistant'],
  'paid', false, 39.00,
  4.4, 3400, false, false, false,
  ARRAY['Multichannel sequences: email, LinkedIn, and phone in one campaign', 'AI writes full outreach sequences from a prompt', 'Built-in lead database with 450M+ contacts', 'Personalised images and videos in emails at scale'],
  ARRAY['No free plan - trial only', 'LinkedIn automation carries account risk if overused', 'Deliverability requires careful domain warm-up setup'],
  ARRAY['Sales teams running multichannel cold outreach campaigns', 'Agencies managing outbound for multiple clients', 'Founders doing cold outreach for early customer acquisition']
),

-- 6. Reply.io
(
  'reply-io', 'Reply.io', 'AI sales automation platform for outbound prospecting',
  'Reply.io is a sales automation platform that covers the full outbound workflow: prospect finding, email sequence automation, LinkedIn outreach, phone calls, and AI-generated personalisation. Jason AI (Reply''s built-in assistant) generates personalised email sequences from a description of the target audience, handles follow-up replies automatically for common objections, and books meetings directly in the calendar. Reply''s email validation and warm-up features maintain deliverability across unlimited connected mailboxes. The platform includes a prospect database with 140M+ contacts, Chrome extension for LinkedIn prospecting, and native CRM integrations with Salesforce, HubSpot, and Pipedrive. Reply.io is a strong competitor to Outreach and SalesLoft for mid-market sales teams that want automation without enterprise pricing. Its API allows technical teams to build custom outreach workflows.',
  'https://www.google.com/s2/favicons?domain=reply.io&sz=64',
  'https://reply.io', 'https://reply.io',
  ARRAY['sales', 'marketing', 'ai-assistant'],
  'freemium', true, 0.00,
  4.4, 2600, false, false, false,
  ARRAY['Jason AI handles replies and books meetings automatically', 'Full multichannel: email, LinkedIn, calls, and SMS', 'Built-in prospect database with 140M+ contacts', 'Unlimited mailboxes with deliverability tools'],
  ARRAY['Interface less polished than newer tools', 'Advanced AI features require higher-tier plans', 'LinkedIn automation volume limits apply'],
  ARRAY['Mid-market sales teams running outbound email and LinkedIn sequences', 'SDR teams automating top-of-funnel prospecting', 'Agencies managing multichannel outreach for clients']
),

-- 7. Outreach
(
  'outreach', 'Outreach', 'Enterprise sales execution platform for revenue teams',
  'Outreach is the leading enterprise sales execution platform, used by revenue teams at companies like Zoom, DocuSign, and Snowflake to systematise outbound prospecting, account management, and deal closing. It combines sales engagement (email sequences, call workflows, LinkedIn steps), deal management (pipeline visibility with AI-predicted close dates), and conversation intelligence (call recording, analysis, and coaching) in one platform. Outreach Kaia is the AI assistant that provides real-time talk track guidance during calls, captures action items automatically, and flags deal risk signals. The forecasting module uses machine learning on historical deal data to predict quarterly revenue with more accuracy than human judgment alone. For enterprise sales organisations with 20+ reps, Outreach reduces the management overhead of running a consistent, data-driven sales process. Its deep Salesforce integration makes it the default choice for teams already on the Salesforce stack.',
  'https://www.google.com/s2/favicons?domain=outreach.io&sz=64',
  'https://outreach.io', 'https://outreach.io',
  ARRAY['sales', 'ai-assistant', 'crm'],
  'paid', false, 0.00,
  4.4, 3800, false, false, false,
  ARRAY['Outreach Kaia provides real-time call guidance and action capture', 'AI forecasting predicts revenue with historical accuracy', 'Full sales execution: sequences, deals, and conversation intelligence', 'Deep Salesforce integration for enterprise GTM teams'],
  ARRAY['Enterprise pricing - custom quotes, not SMB-friendly', 'Steep setup and onboarding for smaller teams', 'Full value requires significant configuration and adoption effort'],
  ARRAY['Enterprise sales organisations standardising the full outbound process', 'Revenue operations teams building data-driven forecasting', 'Sales managers coaching reps with conversation intelligence data']
),

-- 8. Salesloft
(
  'salesloft', 'Salesloft', 'Revenue workflow platform for the full sales cycle',
  'Salesloft is a revenue workflow platform that covers pipeline generation, deal management, and forecast management in one AI-powered system. Its Rhythm feature aggregates signals from across your revenue stack - CRM updates, email engagement, call outcomes, and intent data - and surfaces the highest-priority actions for each rep every day. Salesloft AI generates email drafts, summarises calls, identifies deal risk early (flagging deals with no recent activity, missing stakeholders, or stalled stages), and provides next-step recommendations. The conversation intelligence module (powered by the Drift acquisition) records, transcribes, and analyses sales calls, surfacing coaching opportunities for managers. Salesloft integrates with Salesforce, Microsoft Dynamics, HubSpot, LinkedIn Sales Navigator, and Gong. For enterprise sales teams wanting a single platform to manage the full revenue cycle rather than stitching together point solutions, Salesloft is a primary competitor to Outreach.',
  'https://www.google.com/s2/favicons?domain=salesloft.com&sz=64',
  'https://salesloft.com', 'https://salesloft.com',
  ARRAY['sales', 'ai-assistant', 'crm'],
  'paid', false, 0.00,
  4.3, 2900, false, false, false,
  ARRAY['Rhythm prioritises daily actions from all revenue signals automatically', 'AI deal risk detection flags stalled deals early', 'Conversation intelligence with coaching recommendations', 'Covers pipeline gen, deal management, and forecasting in one platform'],
  ARRAY['Enterprise pricing - custom quotes required', 'Complexity requires strong RevOps support to configure', 'Some features still maturing after the Drift merger'],
  ARRAY['Enterprise sales teams replacing multiple point solutions with one platform', 'RevOps teams building systematic pipeline and forecast management', 'Sales managers using conversation intelligence for rep coaching']
),

-- 9. Gong
(
  'gong-io', 'Gong', 'Revenue intelligence platform powered by conversation AI',
  'Gong is the leading revenue intelligence platform, used by over 4,000 companies to capture and analyse every sales conversation - calls, emails, meetings, and web conferences. Its AI transcribes and analyses conversations to identify deal risk, winning patterns, competitor mentions, objections, and next steps automatically. Sales managers use Gong to coach reps with evidence from actual calls rather than gut feel - surfacing specific moments where a rep lost momentum or failed to ask a discovery question. The deal board shows every open deal with AI risk scores, engagement levels, and predicted close dates. Gong Forecast replaces manual pipeline reviews with AI-generated forecasts that pull directly from conversation activity. For enterprise and mid-market sales organisations, Gong is often the first revenue intelligence tool adopted before deciding on a full sales execution platform. It integrates with Salesforce, HubSpot, Outreach, Salesloft, Zoom, and Microsoft Teams.',
  'https://www.google.com/s2/favicons?domain=gong.io&sz=64',
  'https://gong.io', 'https://gong.io',
  ARRAY['sales', 'ai-assistant', 'crm'],
  'paid', false, 0.00,
  4.7, 4200, false, false, false,
  ARRAY['Market-leading conversation intelligence for call analysis and coaching', 'AI deal risk scores and predicted close dates from real activity data', 'Gong Forecast replaces manual pipeline reviews with AI predictions', 'Identifies winning patterns and competitor mentions across all calls'],
  ARRAY['Premium enterprise pricing - not suitable for small teams', 'Value depends on high call volume for AI training', 'Requires buy-in from reps to record all conversations'],
  ARRAY['Enterprise sales teams using data from calls to coach reps and forecast revenue', 'RevOps teams replacing gut-feel pipeline reviews with AI-driven forecasting', 'Sales managers identifying what separates top-performing reps from average']
),

-- 10. Lavender
(
  'lavender', 'Lavender', 'AI email coach that helps sales reps write better cold emails',
  'Lavender is an AI email assistant that lives inside Gmail and Outlook and gives real-time feedback on cold emails as you write them. Unlike tools that generate emails from scratch, Lavender scores your email on engagement predictors (personalisation, reading level, length, subject line, and call to action) and explains exactly what to fix to improve reply rates. It pulls prospect data from LinkedIn, Twitter, and news sources directly into the compose window - so you can personalise based on what the prospect posted this week or what their company just announced. Lavender Teammate shows how your top-performing colleague would approach the same email. The platform analyses your historical sent emails to identify patterns in your best-performing messages and applies them as coaching recommendations. Used by sales reps at Shopify, Verizon, and AWS, Lavender claims a 3x improvement in reply rates for active users. It works as a Chrome extension and integrates with Salesforce, Outreach, Salesloft, and HubSpot.',
  'https://www.google.com/s2/favicons?domain=lavender.ai&sz=64',
  'https://lavender.ai', 'https://lavender.ai',
  ARRAY['sales', 'ai-assistant', 'marketing'],
  'freemium', true, 0.00,
  4.6, 1800, false, false, false,
  ARRAY['Real-time email scoring with specific improvement suggestions', 'Prospect data pulled from LinkedIn and news directly into compose window', 'Learns from your own high-performing emails', 'Works inside Gmail and Outlook with no workflow change'],
  ARRAY['Focused on email only - not a full outreach platform', 'Most value for individual reps, not team-level analytics', 'Personalisation quality depends on prospect''s public profile activity'],
  ARRAY['SDRs and AEs improving cold email reply rates', 'Sales teams wanting AI coaching without replacing their existing email tools', 'Reps personalising emails at scale for ABM campaigns']
)

ON CONFLICT (slug) DO NOTHING;
