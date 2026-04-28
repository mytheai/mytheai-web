-- tools-batch-38.sql
-- 10 AI Data Analysis and BI tools
-- Target: ~402 → ~412 tools
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

INSERT INTO tools (
  slug, name, tagline, description, logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick, pros, cons, use_cases
) VALUES

(
  'formula-bot', 'Formula Bot', 'Turn plain English into spreadsheet formulas instantly',
  'Formula Bot is an AI assistant that converts plain English descriptions into Excel formulas, Google Sheets formulas, SQL queries, VBA scripts, and regular expressions. Instead of searching Stack Overflow for the right formula syntax, analysts type what they want in plain language and get accurate, explained formula output immediately. The tool supports complex nested formulas, array formulas, and cross-sheet references. It includes a formula explainer mode that breaks down existing formulas into plain English - useful for inheriting spreadsheets built by others. Formula Bot also handles Google Apps Script generation for automation tasks. With a generous free tier and affordable paid plans, it is the go-to formula tool for non-technical analysts, operations teams, and anyone who regularly works with spreadsheet data.',
  'https://www.google.com/s2/favicons?domain=formulabot.com&sz=64',
  'https://formulabot.com', 'https://formulabot.com',
  ARRAY['data-analysis', 'productivity', 'spreadsheets'], 'freemium', true, 6.99,
  4.5, 890, false, false, false,
  ARRAY['Converts plain English to Excel, Sheets, SQL, and VBA formulas', 'Formula explainer mode breaks down complex existing formulas', 'Handles nested and array formulas accurately', 'Generous free tier with daily formula credits'],
  ARRAY['Free tier has daily usage limits', 'Less useful for very simple formulas analysts already know', 'No direct spreadsheet integration - copy-paste workflow'],
  ARRAY['Converting text descriptions to Excel formulas for non-technical users', 'Explaining inherited spreadsheet formulas from previous owners', 'Generating SQL queries from natural language descriptions']
),

(
  'polymer', 'Polymer', 'Transform spreadsheet data into interactive apps and insights',
  'Polymer is a no-code AI data exploration platform that turns spreadsheets, CSV files, and connected databases into interactive dashboards and searchable data apps. Users upload their Google Sheets, Airtable exports, or CSV files and Polymer automatically generates charts, filters, and summary cards. The AI layer surfaces patterns and anomalies in the data, suggesting relevant visualizations without the user needing to define them manually. Polymer supports team sharing, embedded dashboards, and white-label data portals - making it useful for agencies presenting data to clients and operations teams who need self-service access to live data. Unlike Tableau or Power BI which require data modeling expertise, Polymer is designed for business users who live in spreadsheets and want richer visualization without a learning curve.',
  'https://www.google.com/s2/favicons?domain=polymersearch.com&sz=64',
  'https://polymersearch.com', 'https://polymersearch.com',
  ARRAY['data-analysis', 'no-code', 'analytics'], 'freemium', true, 10.00,
  4.3, 340, false, false, false,
  ARRAY['Converts spreadsheets to interactive dashboards with no setup', 'AI surfaces patterns and anomalies automatically', 'Shareable embeddable data portals for client work', 'Works directly with Google Sheets and CSV files'],
  ARRAY['Limited to spreadsheet-scale data (not warehouse-level)', 'Dashboard customization less deep than Tableau or Looker', 'Paid plans required for team collaboration features'],
  ARRAY['Converting Google Sheets data into shareable client dashboards', 'Self-service data exploration for non-technical operations teams', 'Building embeddable data portals for agency client reporting']
),

(
  'akkio', 'Akkio', 'No-code machine learning for business teams',
  'Akkio is a no-code machine learning platform that enables business analysts to build predictive models without writing a single line of code. Users connect their data sources, select a prediction target (churn, conversion, revenue, etc.), and Akkio automatically selects, trains, and evaluates models using AutoML. The platform supports classification, regression, and time-series forecasting tasks and generates plain English explanations of which features most influence predictions. Akkio integrates with HubSpot, Salesforce, Google Sheets, and major databases, allowing predictions to flow directly into existing workflows. It is particularly popular with marketing and revenue operations teams for lead scoring, churn prediction, and pipeline forecasting where ML value is high but hiring a data scientist is not feasible.',
  'https://www.google.com/s2/favicons?domain=akkio.com&sz=64',
  'https://akkio.com', 'https://akkio.com',
  ARRAY['data-analysis', 'machine-learning', 'no-code'], 'paid', false, 49.00,
  4.4, 520, false, false, false,
  ARRAY['Full AutoML pipeline with no coding required', 'Plain English feature importance explanations', 'Direct integration with HubSpot, Salesforce, and Google Sheets', 'Supports churn, conversion, forecasting, and classification tasks'],
  ARRAY['No free tier - starts at $49/month', 'Limited to structured tabular data (no image or text ML)', 'Less flexible than Python-based ML for advanced use cases'],
  ARRAY['Building lead scoring models for sales teams without a data scientist', 'Predicting customer churn from CRM and product usage data', 'Forecasting revenue and inventory without coding']
),

(
  'rows', 'Rows', 'The AI-powered spreadsheet with built-in data connectors',
  'Rows is a modern spreadsheet that integrates AI directly into cells and workflows. Users can call GPT functions inside formulas to summarize text, classify data, extract entities, or generate content at scale across rows of data. The platform includes native connectors to 50+ data sources including Stripe, Google Analytics, HubSpot, and SQL databases, meaning data flows into the spreadsheet without manual export-import cycles. Rows supports real-time collaboration with Google Docs-style multiplayer editing, and analyses can be published as interactive reports or embedded in web pages. For data teams that live in spreadsheets but need richer analysis than Excel or Google Sheets provides, Rows bridges the gap between simple spreadsheets and heavyweight BI tools.',
  'https://www.google.com/s2/favicons?domain=rows.com&sz=64',
  'https://rows.com', 'https://rows.com',
  ARRAY['data-analysis', 'spreadsheets', 'productivity'], 'freemium', true, 14.00,
  4.4, 610, false, false, false,
  ARRAY['GPT functions built directly into spreadsheet formulas', '50+ native data source connectors without manual exports', 'Publishable interactive reports from spreadsheet data', 'Real-time collaboration with version history'],
  ARRAY['Steeper learning curve than Google Sheets for occasional users', 'Free tier limited to small datasets', 'Some data connectors require paid plan'],
  ARRAY['Running AI text analysis across thousands of rows of customer data', 'Building live dashboards connected directly to APIs and databases', 'Replacing manual data export-import cycles with automatic data feeds']
),

(
  'obviously-ai', 'Obviously AI', 'Build and deploy predictive AI models in minutes',
  'Obviously AI is a no-code predictive analytics platform that enables non-technical business users to build and deploy machine learning models from CSV files or database connections. The interface guides users through model building with a step-by-step wizard: upload data, select the prediction column, and Obviously AI trains multiple models, selects the best performer, and presents accuracy metrics in plain English. Models can be consumed via API, embedded in Zapier workflows, or exported for use in other tools. Common use cases include sales forecasting, customer lifetime value prediction, inventory optimization, and HR attrition modeling. The platform is designed for business users who understand the data and the business problem but have no programming background.',
  'https://www.google.com/s2/favicons?domain=obviously.ai&sz=64',
  'https://obviously.ai', 'https://obviously.ai',
  ARRAY['data-analysis', 'machine-learning', 'no-code'], 'paid', false, 75.00,
  4.3, 290, false, false, false,
  ARRAY['Step-by-step wizard makes ML accessible to non-technical users', 'Models deployable via API for integration into other tools', 'Zapier integration for no-code prediction workflows', 'Plain English accuracy metrics and model explanations'],
  ARRAY['No free tier - higher starting price than competitors', 'Limited to structured tabular data use cases', 'Advanced model tuning not possible without custom plan'],
  ARRAY['Predicting which sales leads are most likely to convert', 'Forecasting inventory demand without hiring a data scientist', 'Identifying employees at risk of attrition using HR data']
),

(
  'gigasheet', 'Gigasheet', 'Analyze billions of rows in a browser - no code required',
  'Gigasheet is a browser-based spreadsheet designed for big data - handling CSV, JSON, and log files up to billions of rows without any database setup, coding, or software installation. It is particularly popular with security operations teams for analyzing threat intelligence feeds, firewall logs, and network events that are too large for Excel or Google Sheets. Analysts can filter, group, deduplicate, and pivot enormous datasets entirely in the browser. Gigasheet supports automatic data type detection, column enrichment with threat intelligence APIs, and shareable links to filtered views - enabling teams to collaborate on large datasets without email attachments or database access. For operations teams, security analysts, and data engineers who routinely work with large files, Gigasheet removes the technical barrier of big data analysis.',
  'https://www.google.com/s2/favicons?domain=gigasheet.com&sz=64',
  'https://gigasheet.com', 'https://gigasheet.com',
  ARRAY['data-analysis', 'analytics', 'security'], 'freemium', true, 0.00,
  4.5, 380, false, false, false,
  ARRAY['Handles billions of rows in a browser with no setup', 'Purpose-built for large log, event, and security data files', 'Shareable filtered views for team collaboration', 'Automatic data type detection and column enrichment'],
  ARRAY['Not designed for relational data modeling or joins', 'Less visualization depth than dedicated BI tools', 'Free tier has file size and row limits'],
  ARRAY['Analyzing large security event logs and threat intelligence feeds', 'Exploring massive CSV exports from databases without SQL access', 'Deduplicating and cleaning large data files for downstream analysis']
),

(
  'hal9', 'Hal9', 'Ask your data questions in plain English',
  'Hal9 is a natural language BI platform that connects to databases, data warehouses, and spreadsheets, allowing teams to explore and visualize data by asking questions in plain English. The AI generates SQL queries, creates charts, and returns answers without requiring users to write queries or configure dashboards manually. Hal9 supports multiple LLM backends including OpenAI and Anthropic models, and enterprise deployments can run entirely on-premises for data governance. The platform includes an agent layer that can chain multiple data operations together - answering multi-step analytical questions like comparing cohort performance over time without manual query building. Hal9 is suitable for both technical data teams wanting faster exploration and non-technical stakeholders who need self-service access to data.',
  'https://www.google.com/s2/favicons?domain=hal9.com&sz=64',
  'https://hal9.com', 'https://hal9.com',
  ARRAY['data-analysis', 'analytics', 'ai-assistants'], 'freemium', true, 0.00,
  4.2, 210, false, false, false,
  ARRAY['Natural language queries generate SQL and charts automatically', 'Supports on-premises deployment for data governance requirements', 'Multi-LLM backend support including OpenAI and Anthropic', 'Agent layer handles multi-step analytical questions'],
  ARRAY['Smaller user community than established BI tools', 'Complex analytical questions may require refinement prompts', 'Enterprise features require higher-tier plans'],
  ARRAY['Enabling non-technical business users to self-serve data questions', 'Rapid data exploration without writing SQL queries', 'Running natural language analytics against internal databases securely']
),

(
  'seek-ai', 'Seek AI', 'Query your database with natural language, not SQL',
  'Seek AI is a natural language to SQL platform that allows analysts and business users to query production databases by typing questions in plain English. The AI generates accurate SQL, explains what the query does, and returns results in formatted tables or charts. Seek AI learns the schema and terminology of the connected database, improving accuracy over time as it builds understanding of table relationships, naming conventions, and common query patterns. It supports PostgreSQL, MySQL, Snowflake, BigQuery, and other major databases. Access controls ensure users only query data they are authorized to see, making it suitable for multi-tenant or sensitive data environments. For organizations where SQL knowledge is a bottleneck to data access, Seek AI democratizes analytics without requiring a data engineering team to build BI dashboards for every question.',
  'https://www.google.com/s2/favicons?domain=seek.ai&sz=64',
  'https://seek.ai', 'https://seek.ai',
  ARRAY['data-analysis', 'analytics', 'sql'], 'paid', false, 0.00,
  4.3, 180, false, false, false,
  ARRAY['Natural language queries generate accurate SQL automatically', 'Learns database schema and naming conventions over time', 'Row-level access controls for multi-tenant data environments', 'Supports Postgres, MySQL, Snowflake, BigQuery'],
  ARRAY['Enterprise pricing not publicly listed - requires sales contact', 'Query accuracy depends on clean schema naming and documentation', 'Less suitable for highly complex multi-join analytical queries'],
  ARRAY['Enabling product managers and marketers to query databases without SQL', 'Reducing data engineering bottleneck for ad-hoc business questions', 'Building self-service analytics access with data governance controls']
),

(
  'outerbase', 'Outerbase', 'A smarter interface for your database',
  'Outerbase is an AI-powered database interface that makes it easy to view, query, edit, and visualize data without writing raw SQL. It connects to PostgreSQL, MySQL, SQLite, Cloudflare D1, Turso, and other databases and presents data in a spreadsheet-style interface with natural language query capabilities. The AI layer generates SQL from plain English, explains complex queries, and helps write data transformations. Outerbase also supports collaborative dashboards, chart building, and table-level permissions for team access control. For developers and small data teams who want a cleaner, more intelligent interface to their database than a raw SQL client like TablePlus or DBeaver, Outerbase provides a modern alternative with AI assistance built in.',
  'https://www.google.com/s2/favicons?domain=outerbase.com&sz=64',
  'https://outerbase.com', 'https://outerbase.com',
  ARRAY['data-analysis', 'databases', 'developer-tools'], 'freemium', true, 0.00,
  4.4, 260, false, false, false,
  ARRAY['Spreadsheet-style interface makes database browsing intuitive', 'AI generates and explains SQL from plain English', 'Connects to Postgres, MySQL, Cloudflare D1, Turso, and more', 'Collaborative dashboards with table-level access controls'],
  ARRAY['Younger product with smaller community than TablePlus or DBeaver', 'Advanced database administration features still maturing', 'Some data source connectors in active development'],
  ARRAY['Replacing raw SQL clients with an AI-assisted database browser', 'Enabling non-developers to view and edit database records safely', 'Building shared dashboards from database data without BI setup']
),

(
  'deepnote', 'Deepnote', 'Collaborative data science notebooks with AI built in',
  'Deepnote is a cloud-based collaborative data science notebook that combines Jupyter-compatible Python and SQL notebooks with real-time team collaboration, AI code assistance, and one-click publishing. Unlike Jupyter notebooks which require local setup and file sharing via Git, Deepnote works entirely in the browser with Google Docs-style multiplayer editing - multiple team members can work on the same notebook simultaneously. The built-in AI assists with code completion, debugging, and explanation, and notebooks can be connected to databases, APIs, and S3 buckets as data sources. Deepnote also supports scheduled notebook runs, making it usable as a lightweight data pipeline. It is popular with data science teams at startups and scaleups who want the flexibility of notebooks without the friction of local environment management.',
  'https://www.google.com/s2/favicons?domain=deepnote.com&sz=64',
  'https://deepnote.com', 'https://deepnote.com',
  ARRAY['data-analysis', 'coding', 'machine-learning'], 'freemium', true, 0.00,
  4.6, 740, false, false, false,
  ARRAY['Real-time collaborative editing like Google Docs for notebooks', 'AI code completion and debugging built into the editor', 'No local environment setup - fully browser-based', 'Scheduled notebook runs for lightweight data pipeline use cases'],
  ARRAY['Heavy Python/ML workflows may prefer local Jupyter for performance', 'Free tier has compute and storage limits', 'Enterprise security features (SSO, private cloud) require higher plan'],
  ARRAY['Collaborative data science and ML experiments across distributed teams', 'Teaching and sharing reproducible data analysis without local setup', 'Running AI-assisted exploratory data analysis on connected databases']
)

ON CONFLICT (slug) DO NOTHING;
