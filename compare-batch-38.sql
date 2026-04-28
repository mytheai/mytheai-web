-- compare-batch-38.sql
-- 5 AI data analysis tool comparison pairs
-- DEPENDENCY: tools-batch-38.sql must be run first (formula-bot, polymer, akkio, rows,
--   obviously-ai, gigasheet, hal9, seek-ai, outerbase, deepnote)
-- All pairs verified absent from compare-batch-1 through compare-batch-37

INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, criteria, updated_at)
VALUES

-- 1. deepnote vs rows: collaborative notebook vs AI spreadsheet
(
  'deepnote-vs-rows',
  'deepnote',
  'rows',
  'Deepnote is a collaborative data science notebook for teams that code - Python, SQL, R in a Jupyter-compatible environment with real-time multiplayer and scheduling. Rows is an AI-powered spreadsheet with built-in data connectors and GPT functions inside cells, built for analysts who think in spreadsheets rather than code. The choice depends on whether your team writes code or formulas.',
  NULL,
  ARRAY[
    ROW('Ease of Use', 3, 5, 'Rows requires no coding - GPT functions work like Excel formulas. Deepnote requires Python or SQL knowledge to get full value.')::comparison_criterion,
    ROW('Data Connectivity', 4, 5, 'Rows has 50+ native connectors to live data sources - Stripe, HubSpot, Google Analytics. Deepnote connects to databases via code and has fewer turnkey integrations.')::comparison_criterion,
    ROW('Collaboration', 5, 4, 'Deepnote offers real-time multiplayer notebook editing similar to Google Docs. Rows supports collaborative editing but is less optimized for simultaneous code development.')::comparison_criterion,
    ROW('AI Features', 4, 5, 'Rows embeds GPT directly into cells for classification, summarization, and generation at scale. Deepnote AI assists with code generation and debugging.')::comparison_criterion,
    ROW('Sharing and Publishing', 4, 5, 'Rows publishes analyses as interactive shareable reports with a URL. Deepnote can publish notebooks but the output is less polished for non-technical audiences.')::comparison_criterion,
    ROW('Scalability', 4, 3, 'Deepnote handles large datasets with compute resources and scheduled runs. Rows works best for datasets that fit in a browser-based spreadsheet environment.')::comparison_criterion,
    ROW('Pricing', 4, 4, 'Both offer free plans. Deepnote teams plans from $39/month. Rows paid plans from $59/month.')::comparison_criterion
  ],
  NOW()
),

-- 2. akkio vs obviously-ai: no-code ML platforms
(
  'akkio-vs-obviously-ai',
  'akkio',
  'obviously-ai',
  'Akkio and Obviously AI are both no-code machine learning platforms that let business teams build predictive models without writing code. Akkio integrates more deeply with CRM and marketing tools for ongoing scoring workflows. Obviously AI is faster for one-off predictions and produces more executive-friendly explainability output. Both are strong for non-technical teams.',
  NULL,
  ARRAY[
    ROW('Ease of Use', 5, 5, 'Both are genuinely no-code. Upload a CSV, select a target column, and get a trained model in minutes. Neither requires data science knowledge.')::comparison_criterion,
    ROW('CRM and Tool Integrations', 5, 3, 'Akkio integrates with HubSpot, Salesforce, and Google Sheets for live prediction scoring in existing workflows. Obviously AI has fewer direct CRM integrations.')::comparison_criterion,
    ROW('Explainability', 4, 5, 'Obviously AI produces clean, plain-language explanations of model drivers designed for stakeholder presentations. Akkio explanations are solid but less polished.')::comparison_criterion,
    ROW('API Deployment', 4, 5, 'Obviously AI one-click API deployment allows predictions to be embedded in other applications without engineering support. Akkio offers API access on higher-tier plans.')::comparison_criterion,
    ROW('Chat and Conversational Interface', 5, 3, 'Akkio chat lets you ask questions about your data and get visualizations in conversation. Obviously AI is more workflow-oriented with less conversational capability.')::comparison_criterion,
    ROW('Pricing', 4, 4, 'Akkio from $49/month. Obviously AI from $75/month. Both are competitive for the ML automation value delivered.')::comparison_criterion,
    ROW('Model Accuracy', 4, 4, 'Both platforms use automated model selection across multiple algorithms and tune hyperparameters automatically. Accuracy is comparable for standard business prediction tasks.')::comparison_criterion
  ],
  NOW()
),

-- 3. outerbase vs seek-ai: natural language SQL tools
(
  'outerbase-vs-seek-ai',
  'outerbase',
  'seek-ai',
  'Outerbase and Seek AI both let users query databases in plain English without writing SQL. Outerbase is a full collaborative database workspace with dashboards and team features. Seek AI focuses on enterprise data warehouse accuracy with query validation to prevent incorrect results. Choose Outerbase for team collaboration; Seek AI for enterprise accuracy requirements.',
  NULL,
  ARRAY[
    ROW('Natural Language Accuracy', 4, 5, 'Seek AI includes query validation to catch incorrect joins and ambiguous references before returning wrong answers - critical for business users. Outerbase is accurate but has fewer validation guardrails.')::comparison_criterion,
    ROW('Collaborative Features', 5, 3, 'Outerbase is built as a team workspace - shared queries, dashboards, and comments. Seek AI focuses on the query interface with less collaborative tooling.')::comparison_criterion,
    ROW('Database Support', 5, 4, 'Outerbase supports PostgreSQL, MySQL, BigQuery, Snowflake, and more. Seek AI targets enterprise data warehouses: Snowflake, BigQuery, Redshift, and Databricks.')::comparison_criterion,
    ROW('Dashboard Building', 5, 3, 'Outerbase builds shareable dashboards from query results. Seek AI returns visualizations but is not a dashboard platform.')::comparison_criterion,
    ROW('Enterprise Readiness', 3, 5, 'Seek AI is built for enterprise environments with compliance, SSO, and the accuracy requirements of large organizations. Outerbase targets a broader range of team sizes.')::comparison_criterion,
    ROW('Pricing', 5, 3, 'Outerbase has a free plan with paid from $25/month. Seek AI is custom enterprise pricing - significantly higher investment.')::comparison_criterion,
    ROW('Setup Complexity', 4, 4, 'Both require database connection setup. Outerbase is slightly faster to get started for smaller databases. Seek AI enterprise implementation involves more configuration.')::comparison_criterion
  ],
  NOW()
),

-- 4. formula-bot vs rows: formula generation vs full AI spreadsheet
(
  'formula-bot-vs-rows',
  'formula-bot',
  'rows',
  'Formula Bot generates Excel and Google Sheets formulas, SQL, and code from plain English - it is a generation assistant that makes you faster in the tools you already use. Rows is a full AI-powered spreadsheet with live data connectors and GPT functions built in. If you want to stay in Excel or Google Sheets, Formula Bot wins. If you are willing to move to a new spreadsheet, Rows is more powerful.',
  NULL,
  ARRAY[
    ROW('Works With Existing Tools', 5, 2, 'Formula Bot generates formulas you paste into Excel and Google Sheets - no new tool adoption required. Rows is a separate product that replaces your current spreadsheet.')::comparison_criterion,
    ROW('AI Capabilities', 3, 5, 'Rows embeds GPT directly into cells for large-scale classification, summarization, and generation across thousands of rows. Formula Bot generates formulas but does not run AI on your data directly.')::comparison_criterion,
    ROW('Live Data Connections', 1, 5, 'Rows connects to 50+ data sources natively - Stripe, HubSpot, Google Analytics. Formula Bot does not manage data connections.')::comparison_criterion,
    ROW('Learning Curve', 5, 4, 'Formula Bot requires no workflow change - describe the formula, copy it in. Rows requires learning a new spreadsheet environment.')::comparison_criterion,
    ROW('Formula Coverage', 5, 3, 'Formula Bot covers Excel, Google Sheets, SQL, VBA, Python, and R across the full range of formula complexity. Rows focuses on its own formula and AI function environment.')::comparison_criterion,
    ROW('Pricing', 5, 4, 'Formula Bot free plan available. Rows free plan available. Formula Bot Pro from $9/month; Rows paid from $59/month.')::comparison_criterion,
    ROW('Collaboration', 2, 5, 'Rows supports real-time collaborative editing and publishes shareable reports. Formula Bot is an individual generation tool without collaboration features.')::comparison_criterion
  ],
  NOW()
),

-- 5. polymer vs gigasheet: data exploration vs big data spreadsheet
(
  'polymer-vs-gigasheet',
  'polymer',
  'gigasheet',
  'Polymer and Gigasheet both work without SQL or code, but serve different data scales and audiences. Polymer turns small-to-medium datasets into shareable interactive dashboards and apps in minutes. Gigasheet handles massive files - billions of rows - that crash Excel and Google Sheets. Choose Polymer for shareable business dashboards; Gigasheet for big file analysis.',
  NULL,
  ARRAY[
    ROW('Data Scale', 3, 5, 'Gigasheet is built for billion-row files that no other browser tool can handle. Polymer works best with datasets that fit comfortably in a standard spreadsheet environment.')::comparison_criterion,
    ROW('Visualization and Dashboards', 5, 3, 'Polymer auto-generates visualizations and publishes polished shareable dashboards. Gigasheet has basic filtering and grouping but is not a visualization platform.')::comparison_criterion,
    ROW('Ease of Use', 5, 5, 'Both require no code or SQL. Polymer feels like a BI tool for non-technical users. Gigasheet feels like a supercharged spreadsheet for large files.')::comparison_criterion,
    ROW('Shareability', 5, 4, 'Polymer publishes interactive dashboards as URLs shareable with anyone. Gigasheet shares filtered views via link but the output is less designed for non-technical audiences.')::comparison_criterion,
    ROW('Use Case Fit', 3, 5, 'Gigasheet is purpose-built for security, data engineering, and operations teams with large log and event files. Polymer is built for business analysts and marketing teams.')::comparison_criterion,
    ROW('AI Features', 4, 3, 'Polymer AI surfaces trends and anomalies automatically. Gigasheet focuses on data exploration capability rather than AI-generated insights.')::comparison_criterion,
    ROW('Pricing', 4, 3, 'Polymer free plan available, paid from $29/month. Gigasheet free plan available, paid from $99/month for large file support.')::comparison_criterion
  ],
  NOW()
)

ON CONFLICT (slug) DO NOTHING;
