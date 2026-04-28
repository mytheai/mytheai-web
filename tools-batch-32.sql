-- tools-batch-32.sql
-- 10 AI project management and team collaboration tools
-- Target: DB ~342 → ~352 tools
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

INSERT INTO tools (
  slug, name, tagline, description, logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick, pros, cons, use_cases
) VALUES

('wrike',
 'Wrike',
 'Powerful project management for enterprise teams',
 'Wrike is an enterprise-grade project management platform used by over 20,000 organisations worldwide. It combines task management, project planning, resource allocation, and workflow automation in a single platform built for scale. The AI-powered features include Work Intelligence, which automatically surfaces risks, suggests task durations, and predicts project completion dates based on team velocity. Wrike supports multiple project views including Gantt charts, Kanban boards, calendars, and table views, making it adaptable to different team workflows. The platform is built for organisations that need strong governance over projects - including custom approval workflows, budget tracking, time logging, and detailed permission management. Wrike integrates with over 400 tools including Salesforce, Slack, Microsoft Teams, and the full Adobe Creative Cloud suite, making it particularly popular with marketing and creative agencies managing complex multi-stakeholder projects.',
 'https://www.google.com/s2/favicons?domain=wrike.com&sz=64',
 'https://wrike.com', 'https://go.mytheai.com/wrike',
 ARRAY['project-management', 'productivity', 'team-collaboration'],
 'freemium', true, 9.80,
 4.3, 1876, false, false, false,
 ARRAY['Excellent Gantt chart and resource management', 'AI risk and timeline prediction', 'Strong enterprise security and compliance features'],
 ARRAY['Steep learning curve for new users', 'Free plan is very limited', 'Can feel heavy for small teams'],
 ARRAY['Enterprise project management and tracking', 'Cross-department campaign management', 'Resource allocation and capacity planning']
),

('smartsheet',
 'Smartsheet',
 'The enterprise platform for dynamic work management',
 'Smartsheet is a work execution platform that combines the familiarity of a spreadsheet with project management, automation, and reporting capabilities. Unlike traditional PM tools, Smartsheet''s grid-based interface feels immediately accessible to teams already comfortable in Excel or Google Sheets, while offering far more power underneath: automated workflows, cross-sheet formulas, Gantt charts, Kanban views, and real-time dashboards. The AI features include formula generation from natural language, automated workflow suggestions, and an AI assistant for summarising sheet data and generating content directly in cells. Smartsheet is widely adopted in operations, finance, HR, and project delivery teams because it sits between a spreadsheet and a full PM tool - flexible enough for custom processes but structured enough for reporting. The platform includes robust enterprise controls including audit logging, data loss prevention, and SSO, making it a common choice for compliance-sensitive industries.',
 'https://www.google.com/s2/favicons?domain=smartsheet.com&sz=64',
 'https://smartsheet.com', 'https://go.mytheai.com/smartsheet',
 ARRAY['project-management', 'productivity', 'operations'],
 'freemium', true, 9.00,
 4.3, 1654, false, false, false,
 ARRAY['Familiar spreadsheet interface lowers adoption barrier', 'AI formula generation saves significant time', 'Strong cross-team reporting and dashboard capabilities'],
 ARRAY['UI feels dated compared to modern PM tools', 'Automation can be complex to configure', 'Costs increase significantly with advanced features'],
 ARRAY['Operations and process tracking', 'Project delivery reporting for executives', 'Cross-functional team coordination']
),

('basecamp',
 'Basecamp',
 'Simple, calm project management for small teams',
 'Basecamp is a project management and team communication platform built around simplicity. Where most PM tools add features continuously, Basecamp has deliberately kept its interface minimal: each project contains message boards, to-do lists, file storage, a shared schedule, group chat (Campfire), and automatic check-ins. The AI features are limited compared to competitors - Basecamp focuses on reducing complexity rather than adding AI capabilities. What makes Basecamp distinctive is the pricing model: a flat $299/month covers unlimited users and unlimited projects, which makes it excellent value for agencies and teams with 20+ people. The "Hill Charts" feature is unique - a visual status tracker that shows whether work items are in the problem-solving phase (climbing the hill) or execution phase (rolling down), giving a more nuanced view of progress than simple completion percentages. Basecamp suits teams that want clear communication and accountability without the cognitive overhead of feature-heavy platforms.',
 'https://www.google.com/s2/favicons?domain=basecamp.com&sz=64',
 'https://basecamp.com', 'https://go.mytheai.com/basecamp',
 ARRAY['project-management', 'productivity', 'team-collaboration'],
 'paid', false, 15.00,
 4.1, 987, false, false, false,
 ARRAY['Flat pricing makes it cost-effective for larger teams', 'Deliberately simple interface reduces overwhelm', 'Hill Charts give a unique and honest view of project progress'],
 ARRAY['Very limited AI features compared to competitors', 'No Gantt charts or time tracking built in', 'Not suitable for complex multi-dependency projects'],
 ARRAY['Agency client project communication', 'Remote team coordination and async work', 'Simple project tracking for non-technical teams']
),

('height-app',
 'Height',
 'The autonomous project collaboration tool',
 'Height is a modern project management tool that uses AI to automate the routine work of project management: assigning tasks, writing subtasks, updating statuses, and summarising project state. The AI assistant can break down a high-level task into subtasks automatically, suggest which team member should own an item based on past work patterns, and generate a project status summary on demand. Height supports standard project views including boards, lists, Gantt-style timelines, and spreadsheet views, and the interface is noticeably fast compared to heavier enterprise tools. The tool targets software development teams and product organisations that find Jira too complex but want more power than Linear for cross-team coordination. Real-time collaboration is smooth with conflict-free editing, and the notification system is well designed to avoid the alert fatigue common in other PM tools. Height is building toward a vision of an AI-native PM tool where much of the administrative overhead is handled automatically.',
 'https://www.google.com/s2/favicons?domain=height.app&sz=64',
 'https://height.app', 'https://go.mytheai.com/height-app',
 ARRAY['project-management', 'productivity', 'ai-assistants'],
 'freemium', true, 8.50,
 4.2, 342, false, true, false,
 ARRAY['AI-powered task breakdown and assignment automation', 'Fast and clean interface with low cognitive overhead', 'Good real-time collaboration without conflicts'],
 ARRAY['Smaller community than established tools', 'Some enterprise features still maturing', 'Integration library smaller than Asana or ClickUp'],
 ARRAY['Product and engineering team task management', 'AI-assisted project planning and breakdown', 'Cross-team sprint and milestone tracking']
),

('plane-so',
 'Plane',
 'Open-source project management for modern software teams',
 'Plane is an open-source project management tool designed as a developer-friendly alternative to Jira and Linear. It supports issues, sprints, cycles, modules, and roadmaps with a clean interface that prioritises keyboard navigation and fast workflows. The open-source version can be self-hosted, giving engineering teams full data control and the ability to customise the tool to their exact workflow without vendor lock-in. The hosted cloud version adds team collaboration features, integrations with GitHub and Slack, and AI-powered features including issue summarisation and automated sprint planning assistance. Plane positions itself between the simplicity of Linear and the complexity of Jira - suitable for engineering teams that have outgrown a simple task manager but don''t need the full weight of enterprise Jira. The roadmap view is particularly strong for communicating work to product and business stakeholders.',
 'https://www.google.com/s2/favicons?domain=plane.so&sz=64',
 'https://plane.so', 'https://go.mytheai.com/plane-so',
 ARRAY['project-management', 'productivity', 'coding-tools'],
 'freemium', true, 0.00,
 4.3, 412, false, true, false,
 ARRAY['Open-source with self-hosting option for data control', 'Clean interface optimised for engineering teams', 'Strong roadmap and sprint management features'],
 ARRAY['Self-hosting requires technical setup and maintenance', 'Fewer integrations than Jira or Asana', 'AI features less developed than closed-source competitors'],
 ARRAY['Engineering team issue tracking and sprint planning', 'Open-source project management with self-hosting', 'Product roadmap communication to stakeholders']
),

('huly',
 'Huly',
 'Open-source all-in-one project management and collaboration platform',
 'Huly is an open-source alternative to Linear, Jira, Slack, and Notion combined. It provides project management (issues, sprints, roadmaps), team communication (channels, threads, direct messages), knowledge management (documents, wikis), and HR/team management in a single self-hostable platform. The ambition is to replace multiple SaaS subscriptions with one open-source tool that development teams fully control. The AI features include issue summarisation, automatic documentation from meeting transcripts, and AI-assisted planning. Huly is particularly appealing to privacy-conscious organisations, teams in regions with data residency requirements, and companies that want to avoid accumulating separate subscriptions for project management, communication, and documentation. The interface quality is comparable to premium commercial tools, and the active open-source community contributes frequent improvements. For engineering-led companies that want to consolidate their toolstack, Huly represents a genuinely compelling alternative to multiple paid subscriptions.',
 'https://www.google.com/s2/favicons?domain=huly.io&sz=64',
 'https://huly.io', 'https://go.mytheai.com/huly',
 ARRAY['project-management', 'productivity', 'team-collaboration'],
 'freemium', true, 0.00,
 4.2, 287, false, true, false,
 ARRAY['Replaces multiple tools (Jira, Slack, Notion) in one platform', 'Open-source with self-hosting for full data control', 'Active community with rapid feature development'],
 ARRAY['Self-hosting requires infrastructure and maintenance', 'Less mature than established commercial tools', 'Community and support resources smaller than major competitors'],
 ARRAY['Consolidating project management and team communication', 'Privacy-first teams that need self-hosted infrastructure', 'Engineering teams reducing SaaS subscription sprawl']
),

('teamwork',
 'Teamwork',
 'Project management built for client services teams',
 'Teamwork is a project management platform purpose-built for client-facing teams: agencies, consultancies, and professional services firms. The platform includes the full PM suite - tasks, milestones, Gantt charts, time tracking, and Kanban boards - but layers on client-specific features that generic PM tools lack: client portals with custom branding, project profitability tracking, retainer management, and detailed time billing reports that plug into accounting tools like QuickBooks and Xero. The AI features include task breakdown suggestions, automated time entry, and project status summarisation. For agency owners tracking utilisation rates and client profitability, Teamwork provides reporting depth that tools like Asana and ClickUp do not. The billing and invoicing integration means project managers can close the loop between time spent and revenue generated without switching tools.',
 'https://www.google.com/s2/favicons?domain=teamwork.com&sz=64',
 'https://teamwork.com', 'https://go.mytheai.com/teamwork',
 ARRAY['project-management', 'productivity', 'operations'],
 'freemium', true, 10.99,
 4.2, 1123, false, false, false,
 ARRAY['Client portals with custom branding for agency use', 'Built-in time tracking and billing integration', 'Project profitability reporting not available in generic PM tools'],
 ARRAY['Interface feels less modern than competitors like Linear', 'Can be expensive for smaller agencies', 'Some features require higher tier plans'],
 ARRAY['Agency project management and client delivery', 'Client billing and time tracking integration', 'Retainer and profitability management for services firms']
),

('nifty',
 'Nifty',
 'Milestone-based project management for growing teams',
 'Nifty is a project management platform that organises work around milestones rather than individual tasks. Each project visualises progress through milestone roadmaps, making it easy for teams and stakeholders to understand where a project stands at a glance. Below the milestone layer, tasks, docs, files, discussions, and time tracking are organised in a familiar structure. The AI features include task generation from project descriptions, meeting summarisation, and automated progress updates. Nifty positions itself as the PM tool for teams that want a clear project narrative - a roadmap view that communicates progress meaningfully - rather than just a list of tasks. It integrates with GitHub for development teams, and includes client portals similar to Teamwork for agency use cases. The pricing is competitive with Asana and ClickUp at equivalent feature levels.',
 'https://www.google.com/s2/favicons?domain=nifty.pm&sz=64',
 'https://nifty.pm', 'https://go.mytheai.com/nifty',
 ARRAY['project-management', 'productivity', 'team-collaboration'],
 'freemium', true, 7.00,
 4.1, 456, false, false, false,
 ARRAY['Milestone roadmap view gives clear project narrative', 'Built-in docs, time tracking, and discussions', 'Competitive pricing compared to Asana at similar features'],
 ARRAY['Less name recognition reduces ecosystem integrations', 'AI features less powerful than dedicated AI-native tools', 'Milestone structure may feel rigid for agile teams'],
 ARRAY['Product roadmap and milestone tracking', 'Agency client project visibility and reporting', 'Team coordination across design, development, and delivery']
),

('hive',
 'Hive',
 'AI-powered project management for high-performing teams',
 'Hive is a project management platform with AI built into the core workflow. The AI assistant, HiveGPT, generates project plans from brief descriptions, writes task summaries, drafts email updates to stakeholders, and creates meeting agendas from project status. Hive supports multiple views including Gantt, Kanban, calendar, and portfolio views, and includes built-in time tracking, resourcing, and approval workflows. What differentiates Hive from competitors is the proactive AI: rather than waiting to be asked, Hive''s AI surfaces bottlenecks, flags overdue work, and suggests rebalancing task assignments when team members are over-capacity. The platform integrates with over 1,000 tools via native connectors and Zapier. Hive targets teams that want AI deeply embedded in project operations rather than bolted on as an optional chatbot.',
 'https://www.google.com/s2/favicons?domain=hive.com&sz=64',
 'https://hive.com', 'https://go.mytheai.com/hive',
 ARRAY['project-management', 'productivity', 'ai-assistants'],
 'freemium', true, 12.00,
 4.2, 678, false, false, false,
 ARRAY['AI proactively surfaces bottlenecks and capacity issues', 'Strong portfolio view for managing multiple projects', 'HiveGPT generates plans and updates automatically'],
 ARRAY['AI features require higher tier plans', 'Interface can feel busy with all views enabled', 'Smaller user community than Asana or ClickUp'],
 ARRAY['AI-assisted project planning and status reporting', 'Resource management and capacity balancing', 'Multi-project portfolio oversight for team leads']
),

('productive',
 'Productive',
 'Agency management software for profitability and delivery',
 'Productive is an agency management platform that combines project management, resource planning, time tracking, and financial management in a single tool. Where Teamwork focuses on client delivery, Productive adds a financial operations layer: budget tracking, profitability reports per project and client, revenue forecasting, and purchase order management. The AI features include utilisation forecasting, automated time entry suggestions, and project budget alerts before overruns occur. For agencies managing 20+ concurrent projects with different billing models (fixed fee, time and materials, retainers), Productive provides financial visibility that generic PM tools cannot match. The sales CRM add-on tracks pipeline and converts won deals directly into projects, reducing the handoff friction between sales and delivery teams. Productive is used by over 1,600 agencies globally.',
 'https://www.google.com/s2/favicons?domain=productive.io&sz=64',
 'https://productive.io', 'https://go.mytheai.com/productive',
 ARRAY['project-management', 'productivity', 'operations'],
 'paid', false, 9.00,
 4.4, 534, false, false, false,
 ARRAY['Agency-specific financial tracking and profitability reports', 'Utilisation forecasting prevents over-capacity situations', 'Sales-to-delivery pipeline reduces team handoff friction'],
 ARRAY['No free plan - paid only from the start', 'Overkill for teams that do not need financial PM integration', 'Steeper learning curve for operations-heavy features'],
 ARRAY['Agency profitability and budget management', 'Resource utilisation planning across client accounts', 'Time tracking integrated with billing and financial reporting']
)

ON CONFLICT (slug) DO NOTHING;
