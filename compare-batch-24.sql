-- compare-batch-24.sql
-- 5 comparison pairs: no-code / low-code platform comparisons
-- All tools confirmed in Supabase DB before writing
-- Requires: tools-batch-24.sql confirmed in DB (bubble, glide, retool, softr, adalo, appsmith, xano, noloco, windmill, weweb)
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: retool-vs-appsmith
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'retool-vs-appsmith',
  'retool',
  'appsmith',
  'Retool and Appsmith are the two dominant internal tool builders - both use a drag-and-drop UI with data source connectors and minimal JavaScript for wiring components together. The core difference is deployment model and pricing philosophy. Retool is cloud-hosted with per-seat pricing that gets expensive at scale; Appsmith is open-source and self-hostable with a free tier that has no user limits. Feature parity is high on the basics - tables, forms, charts, queries - but Retool has a larger template library and a more polished cloud experience, while Appsmith gives teams with data privacy requirements the option to run entirely on their own infrastructure. For startups on a budget or teams with compliance constraints, Appsmith is compelling. For teams that prioritise speed and a managed cloud with more templates, Retool wins.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'retool-vs-appsmith', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Ease of Setup', 4, 4, 'Both have quick starts. Retool cloud is faster; Appsmith self-hosted adds infrastructure setup time.'),
  ('Component Library', 5, 4, 'Retool has a larger library of pre-built components and templates. Appsmith is catching up but slightly behind.'),
  ('Data Source Integrations', 5, 4, 'Both support databases, REST APIs, GraphQL. Retool has more native connectors out of the box.'),
  ('Self-Hosting Option', 2, 5, 'Retool self-hosting is enterprise-only. Appsmith open-source can be self-hosted for free.'),
  ('Pricing at Scale', 2, 5, 'Retool per-seat pricing grows fast. Appsmith self-hosted has no per-seat cost; cloud plan more competitive.'),
  ('AI Features', 4, 3, 'Retool AI generates queries from natural language. Appsmith AI assist is less mature.'),
  ('Template Library', 5, 3, 'Retool has significantly more pre-built app templates for common use cases.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'retool-vs-appsmith')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'retool-vs-appsmith');

-- Pair 2: bubble-vs-webflow
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'bubble-vs-webflow',
  'bubble',
  'webflow',
  'Bubble and Webflow are both powerful no-code builders but they solve fundamentally different problems. Webflow is a visual website and CMS builder - outstanding for marketing sites, content-driven websites, and landing pages - but it is not designed for building web applications with complex user logic, authentication flows, or relational databases. Bubble is a full visual programming environment for web applications - you can build multi-sided marketplaces, SaaS products, and booking platforms with real business logic. If you are building a website or marketing presence, Webflow is faster and better. If you are building a web application where users log in, create data, and interact with each other, Bubble is the right tool. They are complements rather than true competitors - many teams use Webflow for marketing and Bubble for the product itself.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'bubble-vs-webflow', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Web App Logic', 5, 2, 'Bubble supports full app logic with workflows, conditions, loops, and API calls. Webflow is limited to CMS and basic interactions.'),
  ('Design Control', 3, 5, 'Webflow offers pixel-perfect design control. Bubble''s design system is more constrained.'),
  ('Database and Users', 5, 2, 'Bubble has a full built-in database with user auth and permissions. Webflow CMS is content-focused, not app-data-focused.'),
  ('Learning Curve', 3, 4, 'Webflow is easier to learn for designers. Bubble requires understanding of data types and workflows.'),
  ('SEO and Marketing Sites', 2, 5, 'Webflow is purpose-built for SEO, CMS, and marketing sites. Bubble is not optimised for this.'),
  ('Marketplace and Plugins', 4, 4, 'Both have active plugin ecosystems. Bubble plugins focus on app functionality; Webflow on design and CMS.'),
  ('Performance', 3, 5, 'Webflow outputs clean, fast static HTML/CSS. Bubble apps can be slower due to client-side rendering.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'bubble-vs-webflow')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'bubble-vs-webflow');

-- Pair 3: n8n-vs-windmill
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'n8n-vs-windmill',
  'n8n',
  'windmill',
  'n8n and Windmill are both developer-oriented workflow and automation platforms, but they take different approaches to the same problem. n8n is a visual node-based automation tool - you connect pre-built nodes for 350+ apps and services, and write JavaScript or Python in code nodes when needed. Windmill is a code-first platform where you write actual Python, TypeScript, Go, or Bash scripts, then chain them visually and schedule or trigger them. n8n is better for teams who want visual automation with occasional code; Windmill is better for engineering teams who want to write and deploy scripts without managing infrastructure. Both are open-source and self-hostable. n8n has a significantly larger integration library; Windmill has a more powerful execution environment for complex scripts and data pipelines.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'n8n-vs-windmill', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Integration Library', 5, 2, 'n8n has 350+ native app integrations. Windmill relies on writing code to call APIs - fewer pre-built connectors.'),
  ('Code Execution', 3, 5, 'n8n supports JS/Python in nodes. Windmill runs full scripts in Python, TypeScript, Go, Bash with proper package management.'),
  ('Non-Technical Accessibility', 4, 2, 'n8n is usable by technical non-developers. Windmill requires coding ability.'),
  ('Script Infrastructure', 3, 5, 'Windmill handles scheduling, secrets, permissions, and execution environments - full script platform. n8n is workflow-focused.'),
  ('AI Workflow Support', 5, 3, 'n8n has dedicated AI nodes for LLM calls, agent loops, and vector stores. Windmill AI features are more basic.'),
  ('Self-Hosting', 4, 5, 'Both support self-hosting. Windmill is designed from the ground up for this; n8n requires more ops work at scale.'),
  ('Pricing Model', 4, 4, 'Both are free to self-host. Cloud plans are similarly priced. n8n charges by workflow executions; Windmill by compute.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'n8n-vs-windmill')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'n8n-vs-windmill');

-- Pair 4: lovable-vs-bubble
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'lovable-vs-bubble',
  'lovable',
  'bubble',
  'Lovable and Bubble represent two generations of no-code app building. Bubble is the mature visual programming environment: you design every screen, configure every workflow, and connect every data type through a graphical interface that gives you complete control. Lovable is the AI-native alternative: you describe your app in natural language and Lovable generates the React code, database schema, and UI automatically. Lovable is dramatically faster for the first version of an app - you can have something working in minutes rather than hours. But Bubble gives non-technical builders more direct control over the output without understanding the generated code. Lovable is best for people comfortable iterating through AI conversation; Bubble is best for visual thinkers who want to see and control every component directly. The underlying output also differs: Lovable generates real deployable React code that developers can inspect and extend; Bubble keeps everything inside its proprietary platform.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'lovable-vs-bubble', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Speed to First Working App', 5, 3, 'Lovable generates a working app from a prompt in minutes. Bubble requires manual design and workflow setup.'),
  ('Non-Technical Control', 3, 5, 'Bubble gives direct visual control over every element. Lovable requires prompting to make changes.'),
  ('Code Ownership', 5, 1, 'Lovable generates deployable React code you own. Bubble keeps your app locked in its platform.'),
  ('AI Generation', 5, 2, 'Lovable is built on AI generation. Bubble has some AI features but is primarily a manual visual tool.'),
  ('Design Customisation', 3, 4, 'Bubble offers more granular design control. Lovable output is good but style changes require prompting.'),
  ('Database and Backend', 4, 5, 'Both use Supabase for data. Bubble''s visual database builder is more accessible for non-developers.'),
  ('Learning Curve', 4, 3, 'Lovable is more intuitive if you can describe what you want. Bubble has a steeper learning curve upfront.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lovable-vs-bubble')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lovable-vs-bubble');

-- Pair 5: adalo-vs-glide
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'adalo-vs-glide',
  'adalo',
  'glide',
  'Adalo and Glide are both no-code mobile app builders, but they serve different audiences and use cases. Glide is the fastest path from a Google Sheet or Airtable base to a working mobile app - it reads your existing data and generates an app around it in minutes. Adalo starts from a blank canvas with its own built-in database and lets you design screens with full drag-and-drop control. Glide is better if your data already lives in a spreadsheet and you need a quick app for an internal team or small user base. Adalo is better when you are building a more complex consumer app that needs custom data relationships, multiple user roles, and finer design control. Both can publish to iOS and Android (with an Adalo subscription or Glide Business plan). Glide''s AI columns are a genuine differentiator - letting you add AI-powered data transformations without leaving the platform.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'adalo-vs-glide', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Speed of Setup', 3, 5, 'Glide builds an app from a spreadsheet in minutes. Adalo requires manual screen and data design.'),
  ('Data Source Flexibility', 3, 4, 'Adalo has its own built-in database. Glide connects to Google Sheets, Airtable, Excel, SQL, and more.'),
  ('Design Control', 5, 3, 'Adalo offers drag-and-drop control over every screen element. Glide uses template layouts with limited customisation.'),
  ('AI Features', 2, 5, 'Glide AI columns transform data with AI directly in the spreadsheet. Adalo has no comparable AI feature.'),
  ('iOS and Android Publishing', 5, 4, 'Adalo publishes to both stores on paid plans. Glide can publish apps; native app publishing has more constraints.'),
  ('User Roles and Permissions', 4, 4, 'Both handle multiple user roles. Adalo gives slightly more granular screen-level permissions.'),
  ('Use Case Fit', 4, 4, 'Adalo suits consumer apps with complex logic. Glide suits internal tools and simple apps built on existing spreadsheet data.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'adalo-vs-glide')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'adalo-vs-glide');
