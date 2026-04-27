-- compare-batch-26.sql
-- 5 comparison pairs: AI sales & CRM tools (all tools confirmed in DB after batch-26)
-- All tools confirmed in Supabase DB before writing
-- Requires: tools-batch-26.sql confirmed in DB (gong-io, outreach, salesloft, pipedrive, close-crm, attio, affinity, lemlist, reply-io, lavender already in DB)
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: gong-io-vs-outreach
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'gong-io-vs-outreach',
  'gong-io',
  'outreach',
  'Gong and Outreach are the two most widely deployed enterprise sales platforms, but they approach the revenue team problem from opposite directions. Gong starts from conversation intelligence - recording, transcribing, and analysing every sales interaction to surface what is working, where deals are at risk, and how reps can improve. Its forecasting and deal management capabilities are built on top of this conversation data layer, giving them an advantage in accuracy over systems that rely on CRM data entry. Outreach starts from sales execution - giving reps a systematic workflow of sequences, tasks, and playbooks to run, with AI layered on top for guidance and automation. Both platforms have moved into each other''s territory: Gong now has deal management and forecasting; Outreach has Kaia for real-time call guidance. The decision for most enterprise teams comes down to starting point: if you want to understand why deals are won or lost, start with Gong. If you want to standardise and scale how reps execute across the full sales cycle, start with Outreach. Many large sales organisations use both.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'gong-io-vs-outreach', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Conversation Intelligence', 5, 3, 'Gong is the market leader in call analysis, coaching, and pattern recognition across conversations. Outreach Kaia is solid but less mature.'),
  ('Sales Execution and Sequencing', 3, 5, 'Outreach is built around systematic sequence execution, task management, and playbook adherence. Gong''s sequencing is less central.'),
  ('Deal Management', 4, 4, 'Both platforms offer AI-scored deal boards. Gong''s deal intelligence derives from conversation signals; Outreach''s from CRM activity and sequence data.'),
  ('Revenue Forecasting', 5, 4, 'Gong Forecast uses conversation-derived signals for higher accuracy. Outreach forecasting is activity-based and strong, but conversation data gives Gong an edge.'),
  ('Real-Time Call Guidance', 3, 5, 'Outreach Kaia provides live in-call talk track prompts and competitor battlecards. Gong''s real-time guidance is less developed.'),
  ('Salesforce Integration', 5, 5, 'Both have deep, bidirectional Salesforce integrations. Standard for enterprise sales teams on either platform.'),
  ('Pricing and Accessibility', 2, 2, 'Both are custom-quote enterprise platforms with significant minimum commitments. Not suitable for small or early-stage teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gong-io-vs-outreach')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'gong-io-vs-outreach');

-- Pair 2: pipedrive-vs-close-crm
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'pipedrive-vs-close-crm',
  'pipedrive',
  'close-crm',
  'Pipedrive and Close are both sales-focused CRMs designed for active selling teams, but they serve different sales motions. Pipedrive organises everything around the visual pipeline - deals moving through stages, activity completion rates, and forecast accuracy by stage. It is the right choice for teams with a structured B2B sales process where managing deal progression is the primary job. Close is built specifically for inside sales: teams that close through high-volume phone calls, emails, and SMS rather than in-person meetings. Its built-in power dialer, predictive dialer, voicemail drop, and SMS are all first-party features included in the price - not add-ons. A Pipedrive team needs separate calling tools; a Close team has everything built in. Pipedrive is the better visual pipeline manager with a larger integration ecosystem; Close is the better communication-first CRM for high-volume outbound teams. The choice is straightforward once you know your primary sales motion.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'pipedrive-vs-close-crm', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Visual Pipeline Management', 5, 3, 'Pipedrive''s visual board is purpose-built for deal stage tracking. Close has a pipeline view but it is secondary to the activity-based inbox.'),
  ('Built-in Calling and Dialing', 1, 5, 'Close includes a power dialer, predictive dialer, and voicemail drop at every tier. Pipedrive requires a third-party integration for calling.'),
  ('Built-in SMS and Email Sequences', 2, 5, 'Close includes email sequences and two-way SMS natively. Pipedrive''s email integration is solid but sequences require add-ons.'),
  ('AI Features', 3, 4, 'Close''s AI generates email drafts, call summaries, and smart views for lead prioritisation. Pipedrive AI suggests next actions and writes emails but is less developed.'),
  ('Integration Ecosystem', 5, 3, 'Pipedrive integrates with 400+ tools including HubSpot, Slack, and Zapier. Close has good integrations but a smaller marketplace.'),
  ('Ease of Setup', 4, 4, 'Both are notably faster to set up than Salesforce or HubSpot. Pipedrive''s visual interface is intuitive; Close''s inbox-style layout takes brief adjustment.'),
  ('Pricing Transparency', 4, 4, 'Pipedrive starts at $14/seat/month; Close at $49/seat/month (all features included). Close''s flat pricing is simpler - no feature gating by tier.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pipedrive-vs-close-crm')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'pipedrive-vs-close-crm');

-- Pair 3: attio-vs-affinity
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'attio-vs-affinity',
  'attio',
  'affinity',
  'Attio and Affinity are both modern CRMs that auto-capture relationship data from email and calendar rather than requiring manual entry, but they are built for different types of relationship-driven work. Attio is a flexible CRM for growth-stage companies - teams that want a customisable data model, automatic enrichment, and modern collaboration features, without the configuration overhead of Salesforce or the legacy UX of HubSpot. It works for sales pipelines, recruiting, customer success, and partnerships. Affinity is built specifically for dealmakers - venture capital, private equity, investment banking, and enterprise BD - where the relationship graph itself is the asset. Affinity maps who knows whom across the entire firm''s network, scores relationship strength, and surfaces warm introduction paths to target companies. For a SaaS startup wanting a better CRM, Attio is the answer. For a VC firm wanting visibility into the firm''s collective relationship network, Affinity is built for exactly that use case.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'attio-vs-affinity', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Automatic Data Capture', 5, 5, 'Both auto-sync contacts, companies, and interactions from email and calendar. Neither requires manual CRM data entry as a core workflow.'),
  ('Relationship Intelligence', 3, 5, 'Affinity''s core differentiator: relationship strength scoring, warm intro path finder, and relationship graph across the whole team. Attio has enrichment but not this depth of relationship mapping.'),
  ('CRM Customisation', 5, 2, 'Attio allows fully custom objects, attributes, and data models. Affinity is more structured around its relationship intelligence use case with less flexibility.'),
  ('Sales Pipeline Management', 5, 2, 'Attio is designed for structured pipeline management with kanban boards and automation. Affinity''s pipeline features are more basic.'),
  ('VC and PE Workflow Fit', 2, 5, 'Affinity is purpose-built for investor workflows: portfolio tracking, LP relationships, and deal sourcing. Attio can be configured for this but is not purpose-built for it.'),
  ('Pricing Transparency', 3, 1, 'Attio has a free tier and transparent paid plans. Affinity pricing is custom and requires a sales conversation - typically enterprise-level cost.'),
  ('Team Collaboration', 4, 4, 'Both offer team-wide relationship visibility and shared notes. Affinity''s collaboration is oriented toward deal teams; Attio''s is more general.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'attio-vs-affinity')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'attio-vs-affinity');

-- Pair 4: lemlist-vs-reply-io
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'lemlist-vs-reply-io',
  'lemlist',
  'reply-io',
  'Lemlist and Reply.io are both multichannel cold outreach platforms that run email, LinkedIn, and phone sequences from a single campaign builder, but they have different strengths that make each better for specific use cases. Lemlist is the stronger tool for personalisation at scale - its ability to insert custom images, videos, and dynamic text variables into cold emails at volume is genuinely differentiated, and its AI campaign builder generates complete multichannel sequences from a prompt. Reply.io''s advantage is its Jason AI assistant, which goes further than sequence generation: Jason handles initial outreach, responds to common objections automatically, and books meetings directly into the calendar without rep involvement. Reply.io also has a larger built-in prospect database (140M+) and more robust deliverability tooling for teams managing large numbers of connected mailboxes. For agencies and teams where personalisation is the primary lever, Lemlist is the better choice. For teams prioritising automation depth and AI-handled responses, Reply.io has the edge.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'lemlist-vs-reply-io', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Personalisation at Scale', 5, 3, 'Lemlist''s image and video personalisation (inserting prospect-specific visuals into emails) is a unique capability. Reply.io personalises with text variables but not visual elements.'),
  ('AI Reply Handling', 2, 5, 'Jason AI (Reply.io) handles objection responses and books meetings automatically. Lemlist''s AI generates sequences but does not handle replies autonomously.'),
  ('Built-in Lead Database', 4, 5, 'Reply.io includes a 450M+ contact database. Lemlist also has a database but Reply.io''s is larger and more deeply integrated into the prospecting workflow.'),
  ('Deliverability Tools', 4, 5, 'Both include email warm-up and health monitoring. Reply.io''s unlimited mailbox support and deliverability dashboard are more comprehensive for high-volume senders.'),
  ('LinkedIn Automation', 5, 4, 'Both offer LinkedIn connection requests, messages, and profile visits in sequences. Lemlist''s LinkedIn integration is slightly more advanced with more trigger options.'),
  ('Campaign Setup Speed', 4, 3, 'Lemlist''s AI campaign builder generates a full multichannel sequence from a prompt quickly. Reply.io offers more configuration options, which adds setup time.'),
  ('Pricing', 3, 4, 'Lemlist starts at $39/month (no free plan). Reply.io has a free tier and starts lower, making it more accessible for early-stage teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lemlist-vs-reply-io')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lemlist-vs-reply-io');

-- Pair 5: zendesk-vs-intercom
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'zendesk-vs-intercom',
  'zendesk',
  'intercom',
  'Zendesk and Intercom are the two most widely deployed customer communication platforms, but they approach the problem from very different philosophies. Zendesk is a helpdesk - it is built around the ticket as the fundamental unit of work, with enterprise-grade SLA management, routing rules, reporting, and compliance tools that make it the standard for large support operations. Intercom is built around the customer conversation - it started as a live chat and in-app messaging product, and its AI-first approach means that Fin AI (its chatbot) handles the majority of customer queries before a human agent ever sees them. Intercom is stronger for product-led companies where support happens in-app and at-scale AI resolution is the primary goal. Zendesk is stronger for companies with complex support operations, high agent counts, and enterprise compliance requirements. Many enterprise companies use both - Zendesk for the support queue and SLA management, Intercom for in-app chat and proactive messaging. The choice is rarely about which is better and more often about which fits your support motion.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'zendesk-vs-intercom', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('AI Resolution Rate', 3, 5, 'Intercom Fin AI resolves 50%+ of queries without human involvement in optimised deployments. Zendesk AI is effective but Intercom leads on autonomous resolution.'),
  ('Enterprise SLA Management', 5, 3, 'Zendesk has deep SLA policy management, escalation rules, and compliance features for enterprise support operations. Intercom is less structured here.'),
  ('In-App Messaging and Chat', 3, 5, 'Intercom was built for in-app and web chat - it is a first-class experience. Zendesk''s chat (previously Zopim) is functional but secondary to the ticketing core.'),
  ('Proactive Messaging', 2, 5, 'Intercom allows targeted in-app messages, onboarding flows, and behavioural triggers based on user actions. Zendesk is primarily reactive (ticket-in, response-out).'),
  ('Reporting and Analytics', 5, 3, 'Zendesk''s reporting suite is deep: SLA adherence, agent performance, CSAT trends, and custom dashboards. Intercom reporting is improving but less comprehensive.'),
  ('Free Plan or Low-Cost Entry', 2, 2, 'Neither tool is affordable for small teams. Zendesk starts at $55/agent/month; Intercom at $39/seat/month with significant add-on costs at scale.'),
  ('Help Centre and Knowledge Base', 4, 4, 'Both offer solid help centre and knowledge base tools. Zendesk Guide is mature; Intercom Articles integrates tightly with Fin AI for self-service resolution.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zendesk-vs-intercom')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zendesk-vs-intercom');
