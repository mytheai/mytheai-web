-- compare-batch-51.sql
-- 5 AI Workflow Automation tool comparison pairs
-- All tools from tools-batch-51 (zapier, make-com, activepieces, pipedream, bardeen, integrately, albato, workato, tray-io, pabbly-connect)
-- Run AFTER tools-batch-51 confirmed in Supabase

-- 1. zapier-vs-make-com
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'zapier-vs-make-com', 'zapier', 'make-com',
  'Zapier and Make.com are the two dominant no-code workflow automation platforms, but they represent different philosophies about how automation should work. Zapier is the approachable standard - a linear step-by-step builder with 6,000+ integrations and the simplest onboarding in the category. You can build a working automation in under 5 minutes without reading documentation. Make.com is the power user platform - a visual canvas where modules connect like a flowchart, enabling loops, conditional routing, data transformation, and complex multi-branch scenarios that Zapier handles clumsily. The critical difference is pricing: Make charges per operation across its entire workflow, while Zapier charges per task at the workflow level. For simple two-step automations, costs are similar. For complex scenarios with many steps, Make can be 5-10x cheaper at equivalent volume. Zapier wins for non-technical teams, anyone who needs quick setup over power, and teams heavily invested in Zapier integrations not available elsewhere. Make.com wins for teams with complex automation needs, higher task volumes, or anyone who has hit Zapier pricing frustration.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zapier-vs-make-com');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'zapier-vs-make-com', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Ease of Use', 5, 3, 'Zapier is the benchmark for automation ease of use - its linear trigger-action builder guides non-technical users step by step and the plain-English interface requires no training. Make.com''s visual canvas is powerful but requires more time to understand modules, data mapping, and scenario logic, particularly for users new to automation.'),
  ('Integration Library', 5, 4, 'Zapier has 6,000+ app integrations and consistently adds new tools before Make does. Make.com has 1,000+ integrations and covers all major platforms, but niche or newer SaaS apps are more likely to have a Zapier integration first. Both have HTTP modules for custom integrations when native apps are unavailable.'),
  ('Pricing Value', 2, 5, 'Make.com charges per operation across all modules in a scenario - a 10-step workflow costs 10 operations per run. Zapier charges per task at the workflow level regardless of steps. For identical complex workflows, Make typically costs 5-10x less at scale. Make''s Core plan at $9/mo provides 10,000 operations versus Zapier''s $49/mo Professional for 2,000 tasks.'),
  ('Complex Workflow Support', 2, 5, 'Make.com handles loops, iterators, aggregators, conditional routers, and nested scenarios that push the limits of what no-code automation can do. Zapier handles linear workflows well but conditional logic, loops, and multi-branch scenarios require workarounds that Make handles natively.'),
  ('AI Features', 4, 4, 'Both platforms have integrated AI steps in 2026. Zapier AI steps connect to OpenAI, Claude, and other LLMs for data classification, summarization, and generation within workflows. Make AI modules provide similar capabilities through HTTP requests and pre-built OpenAI modules. Neither platform has a clear AI advantage.'),
  ('Error Handling', 3, 5, 'Make.com provides built-in error handling paths - you can define what happens when a module fails without stopping the entire scenario. Zapier has improved its error notifications but handles errors as workflow failures rather than branching paths, making robust error handling harder to implement without workarounds.'),
  ('Migration and Switching Cost', 5, 3, 'Zapier''s 6,000 integrations mean almost every SaaS tool you use has a native connector - switching to Zapier from any other tool is straightforward. Migrating from Zapier to Make requires rebuilding each Zap as a Make scenario, which is time-intensive for teams with hundreds of automations.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zapier-vs-make-com')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zapier-vs-make-com');

-- 2. zapier-vs-activepieces
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'zapier-vs-activepieces', 'zapier', 'activepieces',
  'Zapier and Activepieces serve the same core automation need but represent different positions on the cost-control versus feature-completeness spectrum. Zapier is the mature market leader with 6,000+ integrations, a polished UX, and a track record that enterprise teams trust. Activepieces is the open-source challenger - it can be self-hosted for free, it has a growing integration library now above 200 pieces, and its cloud pricing undercuts Zapier significantly. The open-source model changes the calculus for cost-sensitive teams and developers: you can audit the code, contribute new integrations, and eliminate recurring SaaS costs entirely by running it on your own infrastructure. Zapier wins when you need the widest possible integration library, reliable enterprise support, and no engineering overhead. Activepieces wins for technical teams, privacy-conscious organizations, startups on tight budgets, and any team willing to trade integration breadth for significant cost savings or data sovereignty.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zapier-vs-activepieces');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'zapier-vs-activepieces', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Integration Library', 5, 3, 'Zapier has 6,000+ app integrations developed and maintained by Zapier''s team and app partners over 15 years. Activepieces has 200+ community-built pieces that cover the most popular platforms but misses niche and legacy enterprise tools. The gap narrows as the Activepieces community grows but Zapier''s breadth is a major advantage for teams with diverse integration needs.'),
  ('Pricing', 2, 5, 'Activepieces cloud starts free (1,000 tasks/mo) with Plus at $10/mo. Self-hosted Activepieces is free forever with only server costs. Zapier free tier gives 100 tasks/month; Professional is $49/mo. For teams running hundreds of automations at volume, Activepieces delivers 80-90% cost savings.'),
  ('Self-Hosting and Data Control', 1, 5, 'Activepieces is open source and designed for self-hosting - every workflow, credential, and data record stays on your own infrastructure. Zapier is a cloud-only SaaS with no self-hosting option, which is a non-starter for teams with strict data residency requirements.'),
  ('Ease of Use', 5, 4, 'Zapier''s onboarding is the benchmark for automation UX - guided setup, plain-English trigger descriptions, and thousands of Zap templates mean zero-to-automation in minutes. Activepieces has invested heavily in UX and is now comparable to Zapier for straightforward workflows, but the self-hosted setup adds complexity for teams without DevOps experience.'),
  ('Enterprise Features', 5, 3, 'Zapier offers SSO, audit logs, team management, and SOC2 compliance for enterprise teams. Activepieces enterprise features are in development - the open-source version lacks the compliance certifications and enterprise access controls that regulated industries require.'),
  ('Community and Ecosystem', 5, 4, 'Zapier''s 15-year ecosystem includes thousands of Zap templates, extensive documentation, and app partners. Activepieces'' Discord community is active and grows quickly, but the accumulated tutorials, templates, and third-party integrations that Zapier has built over a decade take time to replicate.'),
  ('AI and Code Steps', 3, 4, 'Activepieces AI piece supports OpenAI, Anthropic Claude, and other LLM providers with straightforward prompt-to-action steps. The code piece supports TypeScript natively - useful for developers who want logic without leaving the builder. Zapier AI steps are solid but the code step experience is less developer-friendly.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zapier-vs-activepieces')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zapier-vs-activepieces');

-- 3. pipedream-vs-zapier
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'pipedream-vs-zapier', 'pipedream', 'zapier',
  'Pipedream and Zapier both connect apps and automate workflows, but they target fundamentally different users. Zapier is built for non-technical teams - its plain-English builder, template library, and zero-code approach mean any team member can build automations without engineering help. Pipedream is built for developers - every workflow step can run real Node.js, Python, Bash, or Go code, giving engineers full programmatic control over data transformation and API calls that visual builders cannot replicate. The choice comes down to who will be building and maintaining your automations. If the answer is your sales team or operations manager, Zapier is correct. If the answer is an engineer or technical founder who wants workflow automation with the control of writing actual code, Pipedream is significantly more powerful. Pipedream also wins for AI pipeline development - building agents that call multiple LLMs, process responses, and branch based on outputs is natural in Pipedream''s code-first environment.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pipedream-vs-zapier');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'pipedream-vs-zapier', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Developer Experience', 5, 2, 'Pipedream provides a real code editor with syntax highlighting, npm package support, environment variables, version history, and live log streaming - the full developer workflow in a browser. Zapier code steps exist but are secondary to the visual builder and lack the IDE-like experience developers expect when writing production logic.'),
  ('Ease of Use for Non-Developers', 1, 5, 'Zapier is the gold standard for automation accessibility - any team member can build a Zap without reading documentation. Pipedream requires JavaScript or Python knowledge to use effectively. Non-technical users can use pre-built Pipedream actions but the full power of the platform requires coding ability.'),
  ('AI and LLM Integration', 5, 4, 'Pipedream natively integrates with OpenAI, Anthropic, and other AI APIs through both pre-built actions and raw code - you can build multi-step AI agents that chain LLM calls, parse structured outputs, and branch logic based on AI decisions. Zapier AI steps cover basic LLM use cases well but lack the code-level control for complex AI pipelines.'),
  ('Integration Library', 4, 5, 'Zapier has 6,000+ integrations. Pipedream has 2,000+ pre-built actions plus HTTP and SDK components that let developers integrate any API with code. For most popular tools the coverage is comparable; for niche tools, Zapier has broader official support.'),
  ('Pricing', 4, 3, 'Pipedream free tier provides 10,000 credits/month - generous for most developer workflows. Basic at $29/mo for 100,000 credits. Zapier free tier gives only 100 tasks/month with paid plans starting at $19.99/mo. For developer-level workflow volumes, Pipedream offers better value.'),
  ('Event Triggers and Webhooks', 5, 3, 'Pipedream is built around event-driven architecture - custom webhooks, HTTP triggers, scheduled triggers, and app event subscriptions are first-class primitives. Zapier supports webhooks but the platform was designed around polling triggers and event-driven patterns require more workarounds.'),
  ('Debugging and Observability', 5, 3, 'Pipedream shows live execution logs, step-by-step data previews, and error traces with the exact line of code that failed. Debugging complex workflows is a first-class experience. Zapier''s error history and task logs are functional for linear workflows but less useful when debugging complex multi-step automations.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pipedream-vs-zapier')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'pipedream-vs-zapier');

-- 4. make-com-vs-activepieces
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'make-com-vs-activepieces', 'make-com', 'activepieces',
  'Make.com and Activepieces are both positioned as power-user alternatives to Zapier, but they approach workflow automation from different angles. Make is a mature SaaS product with a sophisticated visual canvas, 1,000+ integrations, and years of enterprise use cases behind its feature set. Activepieces is the open-source newcomer that self-hosts for free and is building community-driven integrations rapidly. Make wins clearly on integration depth, visual workflow power, and feature maturity - its scenario canvas with loops, iterators, and error handling paths has no equivalent in Activepieces today. Activepieces wins on cost for self-hosted deployments and on data control for teams that cannot send workflow data to third-party SaaS platforms. The choice is practical: if integration library coverage and complex visual workflow building are your priorities, Make is the answer. If cost minimization, open-source customization, or data residency requirements matter, Activepieces is the right path.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'make-com-vs-activepieces');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'make-com-vs-activepieces', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Visual Workflow Builder', 5, 3, 'Make.com''s scenario canvas is the most powerful visual workflow builder in the no-code automation category - it supports conditional routers, iterators, aggregators, error handler paths, and nested scenarios in a visual graph. Activepieces'' builder is clean and functional for linear and moderately complex flows but does not yet match Make''s depth for advanced scenario design.'),
  ('Integration Coverage', 5, 3, 'Make.com has 1,000+ modules built and maintained by the Make team and verified app partners. Activepieces has 200+ community-built pieces. Both have HTTP modules for custom integrations, but Make''s broader library reduces the need for custom API work.'),
  ('Open Source and Self-Hosting', 1, 5, 'Activepieces is fully open source under the MIT license and designed for self-hosting - you can deploy it on your own infrastructure, audit the code, and contribute new integrations. Make.com is proprietary SaaS with no self-hosting option. For teams with data sovereignty requirements, this is a decisive factor.'),
  ('Pricing', 3, 5, 'Activepieces cloud starts free (1,000 tasks/mo) with Plus at $10/mo; self-hosted is free. Make.com core is $9/mo for 10,000 operations - already quite competitive. For high-volume scenarios on cloud, Make has an edge over Zapier but Activepieces self-hosted beats both at zero SaaS cost.'),
  ('Error Handling', 5, 3, 'Make.com error handling is a standout feature - you can define alternative execution paths when modules fail, set up retry logic, and configure error notifications without stopping scenario execution. Activepieces handles errors with notifications and retry options but lacks Make''s visual error branching within the scenario canvas.'),
  ('Enterprise Readiness', 5, 2, 'Make.com offers GDPR-compliant data residency options, team management, role-based access, and SSO for enterprise teams. Activepieces enterprise features are in early development - the community version lacks the compliance certifications and access controls that regulated industries require.'),
  ('Community and Resources', 5, 4, 'Make.com has 10+ years of accumulated templates, tutorials, and community resources. Activepieces'' community is small but growing quickly - the Discord is active and new pieces are shipping weekly. The gap in community resources matters most for users who rely on templates and third-party tutorials.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'make-com-vs-activepieces')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'make-com-vs-activepieces');

-- 5. workato-vs-tray-io
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'workato-vs-tray-io', 'workato', 'tray-io',
  'Workato and Tray.io are both enterprise-grade integration and automation platforms that compete in a segment above Zapier and Make - they are built for large organizations running complex, high-volume integration programmes with security, compliance, and IT governance requirements. Workato is the broader enterprise automation platform - it covers the full spectrum from IT automation to business process automation, with dedicated products for HR, finance, and customer operations teams. Tray.io is the technical integration platform - its Universal Automation Cloud is built for developers and integration teams who need to build sophisticated data pipelines, event-driven architectures, and API integrations at enterprise scale. Workato wins for enterprise organizations that want a single platform spanning IT and business automation with strong vendor support and pre-built recipes. Tray.io wins for technical teams building developer-first integrations and data pipeline automation where programmatic control and scalability are the primary requirements.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'workato-vs-tray-io');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'workato-vs-tray-io', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Enterprise Integration Depth', 5, 5, 'Both Workato and Tray.io connect to Salesforce, SAP, Oracle, Workday, ServiceNow, and other enterprise platforms with deep, certified integrations. Enterprise IT teams consider both platforms enterprise-ready for mission-critical integrations. Workato has a larger library of pre-built recipes; Tray.io provides more programmatic control for custom integrations.'),
  ('Non-Technical User Access', 5, 2, 'Workato is designed to empower business teams - HR, finance, and operations staff can build and manage their own automations using Workato''s recipe builder without engineering involvement. Tray.io is a developer-first platform where business users can trigger workflows but building new integrations requires technical skills.'),
  ('Developer and Code Flexibility', 3, 5, 'Tray.io''s Universal Automation Cloud provides JavaScript scripting, custom connectors, and a programming-first environment that developers use to build integrations with the full control of code. Workato supports Python scripts and custom connectors but the platform philosophy prioritizes low-code access over developer-first architecture.'),
  ('AI and Intelligent Automation', 5, 4, 'Workato''s AI features include natural language recipe creation, anomaly detection, and intelligent data mapping that reduce the technical skill required to build complex integrations. Tray.io''s AI capabilities focus on data transformation and pipeline optimization but the business-facing AI assistant features are less developed than Workato''s.'),
  ('Security and Compliance', 5, 5, 'Both Workato and Tray.io are SOC2 Type II certified, GDPR compliant, and HIPAA-eligible - standard requirements for enterprise software procurement. Both offer network isolation, audit logging, role-based access controls, and data encryption in transit and at rest. Neither has a meaningful compliance advantage.'),
  ('Pricing', 3, 3, 'Both Workato and Tray.io are enterprise-only with custom pricing and no self-serve plans. Workato minimum engagement typically starts at $10,000+ per year. Tray.io pricing is similarly positioned. Neither publishes transparent pricing and both require sales engagement to receive a quote. Total cost depends heavily on integration volume and team size.'),
  ('Pre-Built Content Library', 5, 3, 'Workato has thousands of pre-built recipes covering common enterprise automation patterns across HR, finance, IT, and sales operations. These recipes significantly reduce time-to-value for new integrations. Tray.io provides a connector library and templates but Workato''s pre-built recipe depth gives it a clear advantage for teams wanting accelerated deployment.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'workato-vs-tray-io')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'workato-vs-tray-io');
