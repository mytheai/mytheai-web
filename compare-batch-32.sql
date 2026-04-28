-- compare-batch-32.sql
-- 5 comparison pairs: AI project management tools (theme matches batch-32)
-- All pairs use tools confirmed in DB
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: wrike-vs-asana
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'wrike-vs-asana',
  'wrike',
  'asana',
  'Wrike vs Asana is the enterprise PM versus team workflow management debate that plays out in most mid-market procurement decisions. Wrike is built for complexity at scale: deep Gantt chart and resource management, custom approval workflows, budget tracking, time logging, and AI-powered Work Intelligence that predicts project risks and completion dates. Asana is built for team-level work management: clean task organisation, timeline views, automation rules, and a breadth of integrations that make it the default choice for cross-functional teams. The decision typically comes down to whether a team needs project governance (Wrike) or team-level workflow clarity (Asana). For organisations running complex multi-phase programmes with resource constraints and stakeholder reporting requirements, Wrike provides the governance depth Asana lacks. For teams that need fast adoption across mixed-skill groups with minimal training overhead, Asana is the more practical choice.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'wrike-vs-asana', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('AI project risk detection', 5, 3, 'Wrike''s Work Intelligence predicts project completion dates, surfaces at-risk tasks, and suggests task durations based on team velocity. Asana''s AI features include automated summaries and workflow generation but do not offer predictive risk scoring at the same depth.'),
  ('Resource management and capacity', 5, 3, 'Wrike includes built-in resource allocation, workload views, and capacity planning across multiple projects. Asana''s resource management requires a higher tier and is less granular than Wrike''s dedicated resource tools.'),
  ('Ease of adoption for non-technical users', 3, 5, 'Asana''s interface is immediately accessible for non-project-managers - the learning curve is low and the visual task organisation is intuitive. Wrike''s depth creates a steeper onboarding curve for users who are not familiar with enterprise PM concepts.'),
  ('Automation and workflow rules', 4, 4, 'Both platforms offer strong automation. Wrike''s approval workflows and custom request forms are more powerful for formal governance processes. Asana''s automation rules are easier to set up and cover most team workflow needs.'),
  ('Integration library breadth', 4, 5, 'Asana has over 200 native integrations and is one of the best-integrated PM tools available. Wrike integrates with 400+ tools but many are via Zapier. Asana''s native integrations tend to be deeper for commonly used tools.'),
  ('Reporting and executive dashboards', 4, 3, 'Wrike''s cross-project reporting and portfolio dashboards are more powerful for executive-level visibility. Asana''s dashboards are clean and customisable but less suited to complex multi-programme reporting.'),
  ('Pricing value for mid-size teams', 3, 4, 'Asana''s free tier is generous and the paid tiers scale predictably. Wrike''s free plan is very limited and the jump to paid is significant. For teams under 50 people, Asana typically delivers better value.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'wrike-vs-asana')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'wrike-vs-asana');

-- Pair 2: height-app-vs-linear
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'height-app-vs-linear',
  'height-app',
  'linear',
  'Height vs Linear compares two modern project management tools targeting software teams, with meaningfully different philosophies on what AI should do in PM. Linear is the established favourite for engineering teams: keyboard-first, fast, opinionated, with clean sprint management and a roadmap view that communicates work clearly to product stakeholders. Height is the AI-native challenger: it automates the routine overhead of PM - assigning tasks, writing subtasks, updating statuses, summarising project state - so engineers spend less time doing administrative work and more time building. Both tools deliberately reject the complexity of Jira and the feature sprawl of ClickUp. Linear wins on polish, community, and the confidence that comes from being a proven choice. Height wins on AI automation depth and its vision of autonomous project management. Teams choosing between them are essentially choosing between battle-tested simplicity (Linear) and ambitious AI-first automation (Height).',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'height-app-vs-linear', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('AI task automation depth', 5, 3, 'Height''s AI automatically breaks down tasks, suggests assignments based on past patterns, updates statuses, and summarises project state. Linear''s AI features include issue summarisation and some automation but do not reach the same level of autonomous task management.'),
  ('Interface speed and keyboard navigation', 4, 5, 'Linear is one of the fastest PM tools available, with keyboard-first navigation that engineering teams value highly. Height''s interface is also fast but Linear has a reputation advantage and more refined keyboard shortcuts from years of iteration.'),
  ('Sprint and cycle management', 4, 5, 'Linear''s cycle management is well-designed and a core part of the engineering team workflow. Height supports timelines and sprints but Linear''s cycle tooling is more mature and better integrated into the engineering planning ritual.'),
  ('Roadmap and stakeholder communication', 4, 4, 'Both tools include roadmap views for communicating work to non-engineering stakeholders. Linear''s roadmap is simpler and widely praised for its clarity. Height''s roadmap view is comparable but less established in practice.'),
  ('Integration with development tools', 4, 5, 'Linear has deep integrations with GitHub, GitLab, Figma, and Slack that are widely used by engineering teams. Height integrates with the key developer tools but Linear''s integrations are more mature and widely tested.'),
  ('Community and ecosystem maturity', 3, 5, 'Linear has a large engineering community, abundant documentation, and is the default PM tool recommendation in developer circles. Height has a smaller but growing community - the tool is newer and less battle-tested at scale.'),
  ('Pricing accessibility', 4, 4, 'Both tools offer free plans for small teams. Linear is $8/user/month on paid; Height starts at $8.50/user/month. The pricing difference is minimal - the decision is about AI depth vs ecosystem maturity.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'height-app-vs-linear')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'height-app-vs-linear');

-- Pair 3: plane-so-vs-linear
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'plane-so-vs-linear',
  'plane-so',
  'linear',
  'Plane vs Linear compares the leading open-source developer PM tool against the leading closed-source developer PM tool - a choice that ultimately comes down to data control versus product polish. Linear is the polished, fast, and well-integrated commercial product that has become the default issue tracker for engineering teams that have outgrown Jira without wanting ClickUp''s complexity. Plane is the open-source alternative that can be self-hosted for full data control, customised to specific workflows, and run at zero per-seat cost with infrastructure as the only expense. Both support issues, sprints, cycles, roadmaps, and modules. Linear wins on interface refinement, integration depth, and the confidence of using a broadly adopted standard. Plane wins on data ownership, pricing at scale, and the customisability that comes with open-source. Privacy-conscious organisations, teams in regulated industries, and companies with strong engineering capacity to manage their own infrastructure will find Plane compelling. Everyone else will likely default to Linear.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'plane-so-vs-linear', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Self-hosting and data control', 5, 1, 'Plane can be fully self-hosted - teams run it on their own infrastructure with complete data ownership. Linear is a cloud-only SaaS product with no self-hosting option, which is a disqualifying factor for some regulated or privacy-conscious organisations.'),
  ('Interface polish and speed', 3, 5, 'Linear''s interface is one of the fastest and most refined in the PM category, built with keyboard-first navigation that engineers love. Plane''s interface is clean and functional but does not match Linear''s level of polish and performance optimisation.'),
  ('Integration library', 3, 5, 'Linear has deep native integrations with GitHub, GitLab, Figma, Slack, and the major developer tools. Plane''s hosted version integrates with GitHub and Slack, but the integration library is smaller and less mature than Linear''s.'),
  ('AI features', 3, 4, 'Linear''s AI includes issue summarisation and some automated planning assistance. Plane''s AI features include issue summarisation and sprint planning assistance on the hosted version but are less developed than Linear''s overall.'),
  ('Pricing at scale', 5, 3, 'Plane''s self-hosted version has no per-seat cost beyond infrastructure. For teams over 50 people, the cost difference becomes significant. Linear at $8/user/month across a 100-person engineering team is $9,600/year; Plane on self-hosted infrastructure is dramatically cheaper.'),
  ('Community and ecosystem', 4, 5, 'Linear has a larger established community, more third-party integrations, and stronger brand recognition in engineering circles. Plane has an active open-source community and growing adoption, but Linear is the more established default.'),
  ('Setup and maintenance overhead', 2, 5, 'Linear requires no setup - teams are running within minutes. Plane self-hosting requires server provisioning, maintenance, and upgrades. The hosted Plane cloud version reduces this barrier but adds cost.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'plane-so-vs-linear')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'plane-so-vs-linear');

-- Pair 4: smartsheet-vs-clickup
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'smartsheet-vs-clickup',
  'smartsheet',
  'clickup',
  'Smartsheet vs ClickUp represents two philosophies on how work management should be structured. Smartsheet starts from the spreadsheet - its grid-based interface is immediately accessible to operations, finance, and HR teams that live in Excel or Google Sheets, while offering automation, Gantt charts, and cross-sheet formulas underneath. ClickUp starts from comprehensiveness - tasks, docs, goals, time tracking, dashboards, whiteboards, and chat in a single workspace, with a steeper learning curve as the tradeoff. For organisations that already use spreadsheets as their operational backbone and need to add workflow automation without retraining staff on a new paradigm, Smartsheet is the natural extension. For teams that want to consolidate multiple tools into one workspace and are willing to invest time in setup and configuration, ClickUp provides more breadth. Smartsheet is the choice for structured operations; ClickUp is the choice for teams willing to build their own system of work.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'smartsheet-vs-clickup', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Adoption ease for non-technical users', 5, 3, 'Smartsheet''s grid interface is immediately familiar to anyone who uses spreadsheets. ClickUp''s feature density creates a steeper onboarding curve - teams typically need to invest in setup and training before the platform delivers value.'),
  ('Feature breadth and tool consolidation', 3, 5, 'ClickUp covers tasks, docs, goals, time tracking, dashboards, whiteboards, and chat in one workspace. Smartsheet is focused on project and work management - it does not aim to replace communication or documentation tools.'),
  ('Spreadsheet and formula capabilities', 5, 2, 'Smartsheet''s cross-sheet formulas, conditional logic, and cell formatting match spreadsheet-power-user expectations. ClickUp has basic formula support in some views but is not designed for complex data manipulation.'),
  ('AI features', 4, 3, 'Smartsheet''s AI includes natural language formula generation, automated workflow suggestions, and an AI assistant for cell-level content generation. ClickUp''s AI generates task summaries, subtasks, and content but is less integrated into the spreadsheet-style data workflow.'),
  ('Automation and workflow rules', 4, 4, 'Both platforms offer robust automation. Smartsheet''s automation is more structured and easier to configure for operations workflows. ClickUp''s automation is powerful but requires more configuration effort to get right.'),
  ('Enterprise security and compliance', 5, 3, 'Smartsheet includes audit logging, data loss prevention, SSO, and enterprise governance features that make it common in compliance-sensitive industries. ClickUp has enterprise features but Smartsheet''s compliance depth is stronger.'),
  ('Pricing accessibility', 3, 5, 'ClickUp''s free tier is one of the most generous in the category - teams can run meaningful workflows without paying. Smartsheet''s free plan is limited and costs increase significantly with advanced features. ClickUp offers better value for budget-conscious teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'smartsheet-vs-clickup')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'smartsheet-vs-clickup');

-- Pair 5: basecamp-vs-notion-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'basecamp-vs-notion-ai',
  'basecamp',
  'notion-ai',
  'Basecamp vs Notion AI compares two tools that have both chosen simplicity over feature bloat, but have arrived at very different products. Basecamp is a project management tool with deliberate constraints: message boards, to-do lists, file storage, a schedule, and group chat - nothing more. Its unique Hill Charts give a nuanced view of project progress. The $299/month flat pricing model makes it excellent value for teams with 20+ people. Notion AI is a flexible workspace that combines notes, databases, wikis, task management, and AI assistance in a single tool, adapting to each team''s preferred structure. Basecamp wins when teams want opinionated project communication structure and a predictable, flat pricing model. Notion AI wins when teams want flexibility to build their own system of work - documentation, knowledge management, and task tracking in a single connected workspace. The choice is often between Basecamp''s calm clarity and Notion AI''s flexible power.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'basecamp-vs-notion-ai', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Simplicity and ease of use', 5, 4, 'Basecamp''s deliberately constrained interface is one of the easiest PM tools to onboard a team onto - there is nothing to configure, no views to set up, no system to design. Notion AI is simple relative to enterprise PM tools but requires upfront structure decisions about how to organise databases and pages.'),
  ('AI assistance', 1, 5, 'Notion AI is deeply integrated - it can summarise pages, generate content, translate documents, answer questions about your workspace, and assist with writing across the entire platform. Basecamp''s AI features are very limited; the platform prioritises simplicity over AI capability.'),
  ('Pricing at scale', 5, 3, 'Basecamp''s $299/month flat rate covers unlimited users and unlimited projects. For teams of 20+ people, this is significantly cheaper than per-seat tools. Notion AI charges per seat plus an AI add-on, which adds up for larger teams.'),
  ('Knowledge management and documentation', 2, 5, 'Notion AI''s database-driven approach to documentation and knowledge management is one of its strongest features. Basecamp has message boards and file storage but is not designed as a knowledge base or documentation platform.'),
  ('Project progress visibility', 4, 3, 'Basecamp''s Hill Charts are a genuinely unique and honest representation of project progress - distinguishing between problem-solving and execution phases. Notion AI''s project tracking is flexible but relies on teams building their own tracking databases.'),
  ('Flexibility and customisation', 1, 5, 'Notion AI adapts to almost any workflow through its flexible database and page structure. Basecamp is intentionally opinionated - what you see is what you get, with no customisation of the core structure.'),
  ('Async communication and client handoffs', 5, 3, 'Basecamp''s message boards and Campfire chat are designed for async-first teams and agency client communication. Notion AI has commenting and sharing but is less structured for client-facing project communication workflows.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'basecamp-vs-notion-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'basecamp-vs-notion-ai');
