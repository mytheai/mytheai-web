-- Mode D tier 18 backfill (S127)
-- 18 tools across dev infra, data warehouse, security/compliance, LLM observability, finance/equity, marketing/audience research.
-- All 18 PASS S86 quality gates: operational HTTP 200 + favicon loads + actively shipped + category leader.
-- Unblocks ~10 previously-failed Phase 3 batch 5 candidates (data-pipelines, error-monitoring, incident-management,
-- deployment-automation, llm-monitoring, data-quality, data-discovery, compliance-monitoring, vendor-risk, audience-research).
-- Idempotent: ON CONFLICT (slug) DO NOTHING.

INSERT INTO tools (
  slug, name, tagline, description, logo_url, website_url, affiliate_url,
  pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count,
  featured, trending, editor_pick, tags, pros, cons, use_cases, integrations,
  scores, pricing_verified_at
) VALUES

-- 1. Sentry - Application error monitoring leader
('sentry', 'Sentry', 'Application error monitoring and performance tracing for production code.',
'Sentry is the de facto standard for application error monitoring across web, mobile, and backend services in 2026. The product captures unhandled exceptions, performance regressions, and user-impact data in real time, then surfaces what to fix first based on user-impact volume. Open-source roots (the core SDK and self-hosted server are free) plus a generous free tier on cloud (5K errors per month) made it the default starting point for indie devs and growing engineering teams. Paid tiers start at 26 USD per month and unlock session replay, distributed tracing, profiling, and alert integrations across Slack, GitHub, Jira, and PagerDuty. Vs Datadog: Sentry is error-monitoring-first with developer-friendly stack traces and source-map handling; Datadog is observability-first with deeper infrastructure metrics. Most teams under 200 engineers default to Sentry; enterprise platforms often layer Datadog at the infra level alongside Sentry for app errors. Trust signal: NASDAQ-track unicorn (3 billion USD valuation 2024), used by 4M plus developers across companies including Microsoft, Atlassian, and Robinhood.',
'', 'https://sentry.io', 'https://sentry.io',
'freemium', true, 26, 4.7, 0,
false, true, false,
ARRAY['code-ai'],
ARRAY['Best-in-class stack traces with source-map handling','Generous free tier (5K errors/month)','Open-source self-host option','Session replay shows exactly what user did before crash','Tight integration with GitHub, Slack, Jira, PagerDuty'],
ARRAY['Pricing scales fast at high error volume','Less infrastructure-monitoring depth than Datadog','Some advanced features locked behind Business tier','Self-host requires DevOps expertise to maintain'],
ARRAY['Production error monitoring','Performance regression detection','Mobile app crash analytics','Release health tracking','Stack-trace debugging for distributed systems'],
ARRAY['github','slack','jira','microsoft-365'],
'{"trajectory":5,"ease_of_use":4.5,"reliability":5,"integrations":5,"feature_depth":4.5,"pricing_value":4.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 2. Datadog - Observability platform leader
('datadog', 'Datadog', 'Cloud monitoring and observability platform for infrastructure, apps, and security.',
'Datadog is the comprehensive observability platform that unified infrastructure monitoring, APM, log management, security monitoring, and synthetic testing into a single SaaS in the late 2010s and remains the category leader in 2026. The breadth is the differentiator: where Sentry focuses on application errors and Splunk on logs, Datadog covers all of them with deep cross-product correlation. 600 plus integrations means the agent picks up data from AWS, Kubernetes, Postgres, Kafka, and most modern cloud services with minimal config. Pricing is per-host plus per-product (infrastructure 15 USD per host, APM 31 USD per host, logs by ingestion volume); large deployments easily exceed 50K USD per month, which is the historical complaint. Vs Grafana Cloud: Datadog is enterprise-easy with strongest UX; Grafana is open-source-flexible with lower cost at scale. Public market (NASDAQ:DDOG, 40 billion USD plus market cap), used by Samsung, Whole Foods, and 28K plus customers globally.',
'', 'https://www.datadoghq.com', 'https://www.datadoghq.com',
'paid', true, 15, 4.6, 0,
false, false, false,
ARRAY['code-ai','analytics'],
ARRAY['Most comprehensive observability platform','600+ integrations - agent picks up cloud services automatically','Strong cross-product correlation (infra + APM + logs)','Enterprise-easy with best UX in category','Synthetic monitoring and security monitoring built in'],
ARRAY['Pricing complexity - many products, easy to overspend','Per-host model expensive for large fleets','Steeper learning curve than focused tools','Vendor-lockin risk given depth of integrations'],
ARRAY['Cloud infrastructure monitoring','Application performance management','Log aggregation and analysis','Security monitoring (CSPM)','Synthetic uptime testing','Distributed tracing for microservices'],
ARRAY['slack','github','jira','microsoft-365'],
'{"trajectory":5,"ease_of_use":4,"reliability":5,"integrations":5,"feature_depth":5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 3. Bugsnag - Application stability monitoring
('bugsnag', 'Bugsnag', 'Application stability monitoring with crash-free user-rate tracking.',
'Bugsnag is the application stability monitoring platform acquired by SmartBear in 2021 and still actively shipped as a focused alternative to Sentry. The differentiator is the stability metric: rather than counting errors, Bugsnag reports the percentage of user sessions that completed without a crash, which executives and product teams understand instantly. Built-in support for iOS, Android, web, React Native, and backend stacks; release-tracking dashboards show how each version affects user experience. Free tier covers 7.5K events per month; paid tiers from 15 USD per month add team collaboration, advanced filtering, and integrations with Slack, GitHub, Jira, and Microsoft 365. Vs Sentry: Bugsnag has stronger mobile-app-stability story; Sentry has broader feature surface (session replay, profiling, tracing). Mobile-heavy teams often pick Bugsnag; web-heavy teams pick Sentry. Used by Mailchimp, Lyft, Yelp.',
'', 'https://www.bugsnag.com', 'https://www.bugsnag.com',
'freemium', true, 15, 4.5, 0,
false, false, false,
ARRAY['code-ai'],
ARRAY['Strong mobile-app crash tracking story','Stability score executives understand instantly','Free tier (7.5K events/month) for small teams','Built-in support for iOS, Android, React Native','Release health dashboards out of the box'],
ARRAY['Smaller feature surface than Sentry','Less active development cadence post-SmartBear acquisition','Web-application UX trails Sentry','Integration ecosystem narrower than Sentry'],
ARRAY['Mobile app crash monitoring','Release stability tracking','Crash-free user rate reporting','Multi-platform error monitoring','Stack-trace debugging'],
ARRAY['github','slack','jira','microsoft-365'],
'{"trajectory":3.5,"ease_of_use":4.5,"reliability":4.5,"integrations":4,"feature_depth":4,"pricing_value":4,"output_quality":4}'::jsonb,
NOW()
),

-- 4. Vercel - Frontend cloud platform
('vercel', 'Vercel', 'Frontend cloud platform - deploy Next.js, React, and modern web apps globally.',
'Vercel is the frontend cloud platform built by the team behind Next.js, and is the default deploy target for modern React-based applications in 2026. The product collapses what used to be CDN, build pipeline, edge functions, and serverless backend into a single Git-connected workflow: push to GitHub, get a preview URL, merge to ship to production globally. The free Hobby tier covers most personal projects; Pro starts at 20 USD per seat per month and unlocks team collaboration, analytics, and higher limits. Vs Netlify: Vercel has tighter Next.js integration with edge-runtime support and image-optimization built in; Netlify has stronger static-site focus and simpler pricing. Next.js shops default to Vercel; framework-agnostic Jamstack teams pick Netlify. Series E 2024 (3.25 billion USD valuation), used by Notion, Hashnode, and tens of thousands of indie developers.',
'', 'https://vercel.com', 'https://vercel.com',
'freemium', true, 20, 4.7, 0,
false, true, false,
ARRAY['code-ai'],
ARRAY['Best-in-class Next.js integration with edge runtime','Git-connected preview URLs per commit','Generous free Hobby tier covers most personal projects','Built-in image optimization and analytics','Global edge network with strong performance'],
ARRAY['Pricing scales fast at high traffic','Best-suited to React/Next.js stack (lighter for non-React)','Functions billing complexity','Team Pro tier required even for small teams'],
ARRAY['Next.js production deployment','Static site hosting with CDN','Preview deployments per PR','Edge functions and serverless API','React app hosting at scale'],
ARRAY['github','slack'],
'{"trajectory":5,"ease_of_use":5,"reliability":4.5,"integrations":4.5,"feature_depth":4.5,"pricing_value":4,"output_quality":4.5}'::jsonb,
NOW()
),

-- 5. Netlify - Jamstack deployment platform
('netlify', 'Netlify', 'Build and deploy modern web projects with continuous deployment from Git.',
'Netlify pioneered the Jamstack movement by combining static-site hosting with build pipelines, edge functions, and form handling into a single deployment platform. The product focus stays on framework-agnostic web hosting (works equally well with Next.js, Astro, Hugo, and SvelteKit) with a developer experience tuned for Git-based workflows. Free Starter plan handles small personal projects; Pro starts at 19 USD per seat per month and adds team features and higher limits. Vs Vercel: Netlify has cleaner pricing model and stronger non-Next.js framework support; Vercel has tighter Next.js integration and edge-runtime depth. Most static and JAMstack sites work in either; Next.js apps prefer Vercel; Hugo, Astro, and Eleventy projects often pick Netlify. Series D-funded, used by Reuters, Citrix, and 4M plus developers.',
'', 'https://www.netlify.com', 'https://www.netlify.com',
'freemium', true, 19, 4.5, 0,
false, false, false,
ARRAY['code-ai'],
ARRAY['Framework-agnostic Jamstack hosting','Git-connected continuous deployment','Built-in form handling and identity service','Strong Astro, Hugo, SvelteKit support','Cleaner pricing model than Vercel'],
ARRAY['Less optimized for Next.js than Vercel','Edge function ecosystem behind Vercel','Build minutes can run out on free tier fast','Less developer mindshare than Vercel in 2026'],
ARRAY['Static site deployment','Jamstack web hosting','Form handling without backend','Preview deployments per branch','Edge functions for global API'],
ARRAY['github','slack'],
'{"trajectory":4,"ease_of_use":5,"reliability":4.5,"integrations":4.5,"feature_depth":4.5,"pricing_value":4,"output_quality":4.5}'::jsonb,
NOW()
),

-- 6. PagerDuty - Incident management standard
('pagerduty', 'PagerDuty', 'Incident management and on-call alerting for engineering and operations teams.',
'PagerDuty is the incident management standard that turns a noisy stream of monitoring alerts into routed, escalated, and tracked incidents handled by the right on-call engineer. Integrations with 700 plus monitoring tools (Datadog, Sentry, Splunk, AWS CloudWatch) feed into PagerDuty rules engines that decide who gets paged based on team, severity, time of day, and escalation policy. Beyond alerting, the platform handles incident tracking, on-call schedule management, post-mortem workflows, and stakeholder communication. NYSE:PD public company; Free tier covers 5 users with limited integrations; Professional tier starts at 21 USD per user per month and unlocks full feature set. Vs Opsgenie (Atlassian): PagerDuty has broader integration ecosystem and stronger stakeholder communication; Opsgenie integrates more tightly with Jira and Atlassian stack. Used by Slack, Stripe, Box, and 21K plus companies.',
'', 'https://www.pagerduty.com', 'https://www.pagerduty.com',
'paid', true, 21, 4.5, 0,
false, false, false,
ARRAY['code-ai','customer-service'],
ARRAY['700+ monitoring tool integrations','Strong on-call schedule management','Sophisticated escalation policy engine','Stakeholder communication beyond engineer alerts','NYSE-public reliability'],
ARRAY['Pricing per-user adds up at scale','UI feels dated compared to newer entrants','Configuration complexity for non-trivial routing','Feature gaps without Business tier'],
ARRAY['Incident response routing','On-call schedule management','Post-mortem workflow','Critical alerting from Datadog/Sentry/CloudWatch','Stakeholder updates during outages'],
ARRAY['slack','github','jira','microsoft-365'],
'{"trajectory":4,"ease_of_use":4,"reliability":5,"integrations":5,"feature_depth":4.5,"pricing_value":3.5,"output_quality":4}'::jsonb,
NOW()
),

-- 7. dbt - Data transformation standard
('dbt', 'dbt', 'Transform data in your warehouse with SQL and software-engineering best practices.',
'dbt (data build tool) became the modern data stack standard by treating data transformation as software engineering rather than ad-hoc SQL queries. Analysts write modular SQL models (with version control, tests, documentation, and CI/CD), and dbt orchestrates the dependency graph to materialize tables and views in the warehouse. dbt Core is open-source and free; dbt Cloud (the managed offering from dbt Labs) starts at 100 USD per developer per month and adds scheduling, web IDE, and observability. The product became near-ubiquitous in 2022-2024 across data teams running Snowflake, BigQuery, Redshift, or Databricks. Vs Fivetran: dbt handles transformation (T in ELT); Fivetran handles extraction and loading (EL). Most modern data stacks use both. Series D-funded, used by JetBlue, GitLab, HubSpot.',
'', 'https://www.getdbt.com', 'https://www.getdbt.com',
'freemium', true, 100, 4.7, 0,
false, true, false,
ARRAY['analytics','code-ai'],
ARRAY['Open-source dbt Core is free forever','Treats data transformation as software engineering','Modular SQL with version control and tests','Strongest community in the modern data stack','Native integration with Snowflake/BigQuery/Databricks'],
ARRAY['Cloud pricing per-developer adds up at large teams','Learning curve for analysts new to Git workflow','Self-hosted Core requires DevOps for orchestration','Performance bottlenecks on very large pipelines'],
ARRAY['Data warehouse transformation pipelines','Analytics engineering workflow','Data testing and documentation','Modern data stack core','Cross-team analytics collaboration'],
ARRAY['snowflake','slack','github'],
'{"trajectory":5,"ease_of_use":4,"reliability":5,"integrations":4.5,"feature_depth":5,"pricing_value":4.5,"output_quality":5}'::jsonb,
NOW()
),

-- 8. Fivetran - ELT leader
('fivetran', 'Fivetran', 'Automated data movement from 500+ SaaS sources into your warehouse.',
'Fivetran is the ELT (extract-load-transform) leader that automated the once-painful work of building and maintaining custom data pipelines from SaaS apps to data warehouses. The product offers 500 plus pre-built connectors (Salesforce, HubSpot, Stripe, Shopify, NetSuite) that auto-handle schema changes, incremental syncs, and historical backfills. Pricing is consumption-based by Monthly Active Rows; small startups pay 1-5K USD per month, enterprise customers exceed 100K USD per month. Vs Stitch (Talend) and Airbyte: Fivetran has the broadest connector library and strongest reliability SLA; Airbyte is open-source-leaning and cheaper at scale. Most enterprise data teams default to Fivetran for the reliability-and-coverage breadth; cost-sensitive teams pick Airbyte. Series E 2021 (5.6 billion USD valuation), used by Square, Pfizer, Asics.',
'', 'https://www.fivetran.com', 'https://www.fivetran.com',
'paid', true, 120, 4.5, 0,
false, false, false,
ARRAY['analytics'],
ARRAY['500+ pre-built connectors covering most SaaS','Auto-handles schema changes and incremental syncs','Strongest reliability SLA in ELT category','Free 14-day trial plus modest free tier','Native integration with all major warehouses'],
ARRAY['Consumption pricing by Monthly Active Rows can surprise teams','Cost scales fast at large data volumes','Less flexible than Airbyte for custom sources','Smaller community than open-source alternatives'],
ARRAY['SaaS-to-warehouse data ingestion','Automated ELT pipeline maintenance','Multi-source data unification','Modern data stack ingestion layer','Reverse ETL setup'],
ARRAY['snowflake','slack','github'],
'{"trajectory":4.5,"ease_of_use":4.5,"reliability":5,"integrations":5,"feature_depth":4.5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 9. Monte Carlo - Data observability category leader
('monte-carlo', 'Monte Carlo', 'Data observability platform - detect data quality issues before they reach reports.',
'Monte Carlo created the data observability category in 2019 by applying SRE-style monitoring discipline to data pipelines. The platform automatically learns expected patterns in your data (row counts, distribution shifts, schema changes, freshness) and alerts data engineers when anomalies suggest broken pipelines or data-quality issues - before downstream dashboards or ML models surface wrong numbers. Integrates with Snowflake, BigQuery, Databricks, and dbt; pricing is enterprise-quote-based and starts roughly 50K USD per year for mid-market data teams. Vs Anomalo and Bigeye: Monte Carlo is the established category leader with broadest enterprise adoption; Anomalo and Bigeye are newer challengers with cleaner UX at smaller scale. Series D-funded (1.6 billion USD valuation), used by Fox, JetBlue, Vox Media.',
'', 'https://www.montecarlodata.com', 'https://www.montecarlodata.com',
'paid', false, 4000, 4.5, 0,
false, false, false,
ARRAY['analytics'],
ARRAY['Created and leads the data observability category','Auto-learns data patterns without manual rule-writing','Strong end-to-end lineage from warehouse to dashboard','Native integration with dbt, Snowflake, Looker','Established enterprise track record'],
ARRAY['Enterprise pricing only - no SMB tier','Quote-based with annual contract minimum','Steep learning curve for smaller data teams','Newer alternatives have cleaner UX'],
ARRAY['Data pipeline anomaly detection','Data freshness monitoring','Schema change alerting','Data lineage tracking','Data quality SLA enforcement'],
ARRAY['snowflake','slack'],
'{"trajectory":4.5,"ease_of_use":3.5,"reliability":4.5,"integrations":4,"feature_depth":5,"pricing_value":3,"output_quality":4.5}'::jsonb,
NOW()
),

-- 10. Atlan - Modern data catalog
('atlan', 'Atlan', 'Modern data catalog with active metadata and column-level lineage.',
'Atlan is the modern data catalog that solved the discovery and governance problem for data teams running on Snowflake, BigQuery, dbt, and Looker. Where legacy catalogs (Alation, Collibra) were built for IT data governance, Atlan was built for analytics and engineering teams: column-level lineage that traces data from source through dbt models to dashboards, in-tool annotations that move with the data, and Slack-native discovery so analysts find context without leaving their workflow. Pricing is enterprise-quote-based, typically 40-80K USD per year for mid-market. Vs Collibra: Atlan is faster to deploy with stronger modern-stack integration; Collibra has deeper governance and compliance features for regulated industries. Series C 2024-2025 funding, used by Postman, GitHub, Plaid, RedHat.',
'', 'https://atlan.com', 'https://atlan.com',
'paid', false, 3300, 4.6, 0,
false, false, false,
ARRAY['analytics'],
ARRAY['Modern data catalog built for analytics teams','Column-level lineage from source to dashboard','Slack-native discovery and collaboration','Strong dbt and Snowflake native integration','Faster deploy than legacy catalogs'],
ARRAY['Enterprise pricing only - no SMB tier','Quote-based with annual contract','Lighter governance features than Collibra for regulated industries','Younger product than legacy alternatives'],
ARRAY['Data discovery and search','Column-level data lineage','Active metadata management','Data governance for modern stack','Cross-team data documentation'],
ARRAY['snowflake','slack'],
'{"trajectory":5,"ease_of_use":4.5,"reliability":4.5,"integrations":4.5,"feature_depth":4.5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 11. Drata - Compliance automation
('drata', 'Drata', 'SOC 2, ISO 27001, HIPAA compliance automation with continuous monitoring.',
'Drata automates the soul-crushing manual work of SOC 2, ISO 27001, HIPAA, GDPR, and PCI compliance audits by continuously collecting evidence from cloud infrastructure, identity systems, and HR platforms. Where the legacy approach meant spreadsheets and screenshot binders, Drata connects to AWS, Okta, Rippling, GitHub, and 100 plus other services to verify controls in real time and produce auditor-ready reports on demand. Pricing starts roughly 7.5K USD per year for SOC 2 only and scales with framework count and team size. Vs Vanta: Drata has stronger continuous-monitoring depth and richer auditor-collaboration workflow; Vanta has cleaner UX and slightly faster initial setup. Most SaaS startups under 100 employees pick Vanta; mid-market and multi-framework picks Drata. Series C 2022 (2 billion USD valuation), used by Lemonade, Notion, BambooHR.',
'', 'https://drata.com', 'https://drata.com',
'paid', false, 625, 4.6, 0,
false, false, false,
ARRAY['cybersecurity','legal'],
ARRAY['Continuous evidence collection across 100+ services','Multi-framework support (SOC 2, ISO, HIPAA, GDPR, PCI)','Strong auditor-collaboration workflow','Real-time control monitoring vs annual audit prep','Series C trajectory and enterprise readiness'],
ARRAY['Pricing not transparent - quote-based','Annual contract minimum','Setup overhead for first framework','Slightly steeper learning curve than Vanta'],
ARRAY['SOC 2 audit preparation','ISO 27001 compliance','HIPAA compliance for healthcare','Continuous compliance monitoring','Multi-framework audit consolidation'],
ARRAY['slack','github','salesforce','microsoft-365'],
'{"trajectory":5,"ease_of_use":4,"reliability":4.5,"integrations":4.5,"feature_depth":5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 12. Secureframe - Compliance automation
('secureframe', 'Secureframe', 'Compliance automation for SOC 2, ISO 27001, HIPAA, GDPR, and PCI DSS.',
'Secureframe is the compliance automation platform that competes head-to-head with Drata and Vanta for SOC 2 and adjacent compliance frameworks. The differentiator is depth across 30 plus frameworks, an AI-augmented control-mapping engine that suggests evidence reuse across audits, and a compliance-team-style human service layer that helps companies through their first audit. Pricing starts roughly 7K USD per year for single-framework SOC 2 and scales with frameworks and headcount. Vs Drata: Secureframe has richer multi-framework support and human compliance support; Drata has stronger continuous monitoring and slightly cleaner integrations UX. Series C 2022 funding, used by AngelList, Drift, Frame.io.',
'', 'https://secureframe.com', 'https://secureframe.com',
'paid', false, 583, 4.5, 0,
false, false, false,
ARRAY['cybersecurity','legal'],
ARRAY['30+ compliance frameworks supported','AI-augmented control mapping across frameworks','Human compliance-expert service layer','Strong evidence reuse for multi-framework audits','Series C funding and enterprise track record'],
ARRAY['Pricing not transparent - quote-based','UI slightly behind Drata in modern feel','Annual contract minimum','Smaller mindshare than Vanta or Drata'],
ARRAY['SOC 2 Type II audit','ISO 27001 certification','HIPAA compliance','Multi-framework consolidated compliance','First-time audit guidance with human support'],
ARRAY['slack','github','salesforce','microsoft-365'],
'{"trajectory":4,"ease_of_use":4,"reliability":4.5,"integrations":4,"feature_depth":5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 13. Langfuse - Open-source LLM observability
('langfuse', 'Langfuse', 'Open-source LLM observability and prompt management for AI applications.',
'Langfuse is the open-source LLM observability platform that became the standard tracing layer for AI applications built with LangChain, LlamaIndex, and direct OpenAI or Anthropic APIs in 2024-2025. The product captures every LLM call (prompts, responses, latency, cost) into a searchable trace UI, surfaces quality regressions across model versions, and runs evaluation suites against production traces. Open-source self-hosted is free; Langfuse Cloud has a generous free tier (50K observations per month) and paid tiers from 59 USD per month. Vs Helicone: Langfuse has stronger LangChain native integration and richer evaluation tooling; Helicone has simpler setup as a drop-in proxy and stronger cost-tracking. Y Combinator plus Series A 2024, used by Khan Academy, Samsara, and thousands of indie AI developers.',
'', 'https://langfuse.com', 'https://langfuse.com',
'freemium', true, 59, 4.7, 0,
false, true, false,
ARRAY['code-ai'],
ARRAY['Open-source self-hosted is free forever','Strong LangChain and LlamaIndex native integration','Generous free Cloud tier (50K observations/month)','Built-in evaluation suite for production traces','Y Combinator + Series A trajectory'],
ARRAY['Setup more involved than proxy approach (Helicone)','Smaller customer base than older observability tools','Self-host requires DevOps to maintain','Community evaluation library still maturing'],
ARRAY['LLM application observability','Prompt management with version control','Production trace debugging','LLM cost tracking and analysis','AI application evaluation suites'],
ARRAY['slack','github'],
'{"trajectory":5,"ease_of_use":4,"reliability":4.5,"integrations":4.5,"feature_depth":4.5,"pricing_value":5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 14. Helicone - LLM observability gateway
('helicone', 'Helicone', 'Open-source observability and gateway for LLM applications.',
'Helicone is the open-source LLM observability and gateway product that ships as a one-line proxy for OpenAI, Anthropic, and other LLM APIs. The trade-off Helicone optimizes for vs Langfuse is setup simplicity: change your API base URL to Helicone, and every LLM call gets logged with cost, latency, and prompt-response data. Beyond observability, Helicone offers caching, rate limiting, and prompt experimentation. Free tier covers 100K requests per month; paid tiers from 80 USD per month. Vs Langfuse: Helicone is faster to integrate (proxy approach); Langfuse has deeper LangChain integration and richer evaluation features. Y Combinator-funded, used by SkillUp, Cohere, Sequoia portfolio companies.',
'', 'https://www.helicone.ai', 'https://www.helicone.ai',
'freemium', true, 80, 4.5, 0,
false, false, false,
ARRAY['code-ai'],
ARRAY['One-line proxy setup - fastest integration in category','Built-in caching and rate limiting','Strong cost-tracking and analytics dashboards','Free tier covers 100K requests/month','Y Combinator-funded with strong customer signal'],
ARRAY['Less depth than Langfuse on evaluation tooling','Proxy approach adds latency layer','Smaller mindshare than Langfuse','Roadmap evolving fast - some features in beta'],
ARRAY['LLM API observability via proxy','LLM cost analysis and optimization','LLM response caching','Prompt experimentation and A/B testing','Multi-provider LLM management'],
ARRAY['slack','github'],
'{"trajectory":4.5,"ease_of_use":5,"reliability":4.5,"integrations":4,"feature_depth":4,"pricing_value":4.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 15. Carta - Cap table standard
('carta', 'Carta', 'Cap table management, equity, and 409A valuations for venture-backed companies.',
'Carta is the cap table and equity management standard for venture-backed companies in the US, used by 40K plus startups and 7K plus funds. The product unified what used to be spreadsheet-and-PDF chaos: founder cap tables, employee equity grants, 409A valuations, board consent management, and secondary tender offers. Pricing scales with cap table size; free for very early stage, 2.4K USD per year starting tier for seed companies, custom pricing for Series A and beyond. Vs Pulley: Carta has the broader ecosystem (most VCs already use Carta on their fund side); Pulley has cleaner UX and better pricing for early-stage. Most venture-backed companies default to Carta because their investors already use it. Backed by Sequoia, Andreessen Horowitz, and others (peak valuation 7.4 billion USD 2022).',
'', 'https://carta.com', 'https://carta.com',
'paid', true, 200, 4.3, 0,
false, false, false,
ARRAY['finance','hr'],
ARRAY['Industry standard cap table platform','Used by most VCs - investor relationships flow through Carta','409A valuations integrated','Board consent and secondary tender features','Comprehensive equity management for full lifecycle'],
ARRAY['Pricing increased significantly post-2022','UX feels enterprise-heavy for early-stage founders','Multiple historical PR incidents (data handling, secondary)','Premium tiers required for many basic features'],
ARRAY['Cap table management','Employee equity grant administration','409A valuation','Board consent workflow','Secondary tender offer execution'],
ARRAY['slack','salesforce'],
'{"trajectory":3.5,"ease_of_use":3.5,"reliability":4.5,"integrations":4,"feature_depth":5,"pricing_value":3,"output_quality":4}'::jsonb,
NOW()
),

-- 16. Pulley - Modern cap table for early-stage
('pulley', 'Pulley', 'Modern cap table software for early-stage startups, lower cost than Carta.',
'Pulley is the cap table and equity management platform built as a modern alternative to Carta, focused on transparent pricing and cleaner founder UX for early-stage startups. The product covers cap tables, employee equity, 409A valuations, and board approvals; the differentiator is pricing (free up to 25 stakeholders, 1.2K USD per year for the next tier vs Carta 2.4K USD per year) and a cleaner modern UI. Vs Carta: Pulley costs less and ships better UX at early stage; Carta has broader VC adoption (most institutional investors are already on Carta). Solo founders and seed-stage companies often pick Pulley; venture-backed companies past Series A typically default to Carta because their investors are there. Y Combinator-funded, used by 5K plus startups and growing.',
'', 'https://pulley.com', 'https://pulley.com',
'freemium', true, 100, 4.6, 0,
false, false, false,
ARRAY['finance','hr'],
ARRAY['Free up to 25 stakeholders','Cleaner UX than Carta for early-stage founders','Transparent pricing without sales calls','409A valuations integrated','Y Combinator-funded with strong startup ecosystem fit'],
ARRAY['Smaller VC adoption - investors may push for Carta','Less feature depth than Carta at later stage','Smaller secondary-tender ecosystem','Founder-led companies may outgrow at Series A+'],
ARRAY['Early-stage cap table management','Employee equity grants','409A valuation','Board approvals and consents','Founder equity scenario modeling'],
ARRAY['slack','salesforce'],
'{"trajectory":4.5,"ease_of_use":4.5,"reliability":4.5,"integrations":4,"feature_depth":4,"pricing_value":4.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 17. SparkToro - Audience research
('sparktoro', 'SparkToro', 'Audience research tool that tells you what your customers read, follow, and watch.',
'SparkToro is the audience research platform from Rand Fishkin (Moz cofounder) that answers a hard marketing question: where does my target audience hang out online. The product crawls public web data to surface what podcasts your audience listens to, what social accounts they follow, what websites they visit, and what hashtags they use - all queryable by demographic and interest filters. Pricing is transparent: free tier with limited searches, paid tiers from 50 USD per month. Vs Similarweb: SparkToro is audience-and-influence-research-focused with cleaner UX for marketers; Similarweb is web-traffic-analytics-focused at enterprise scale. SparkToro fits indie marketing teams; Similarweb fits enterprise market intelligence. Profitable indie SaaS (no VC), used by tens of thousands of solo marketers and small marketing teams.',
'', 'https://sparktoro.com', 'https://sparktoro.com',
'freemium', true, 50, 4.6, 0,
false, false, false,
ARRAY['research','seo-marketing'],
ARRAY['Audience research focused on where customers actually are','Transparent pricing without sales calls','Profitable indie SaaS - founder-aligned','Strong searchable database of podcasts/sites/social','Clean UX optimized for marketers'],
ARRAY['Smaller dataset than enterprise alternatives','Best for English-speaking audiences','Some niche audiences poorly represented','Free tier limited to 5 searches/month'],
ARRAY['Target audience research','Influencer and podcast discovery','Content marketing strategy','Persona research','Competitive audience analysis'],
ARRAY['slack','hubspot'],
'{"trajectory":3.5,"ease_of_use":5,"reliability":4.5,"integrations":3.5,"feature_depth":4,"pricing_value":4.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 18. Similarweb - Web traffic intelligence
('similarweb', 'Similarweb', 'Web traffic analytics and digital intelligence platform for marketing and competitive research.',
'Similarweb is the digital intelligence leader that estimates web and app traffic, competitive marketing channels, and audience behavior across millions of websites. The data is sourced from a global panel, ISP partnerships, and direct integrations; accuracy is highest for Top 10K websites and degrades for niche sites. Free Browser Extension and limited web access; paid tiers start roughly 200 USD per month for individual users and scale to 50K USD plus per year for enterprise contracts. Vs SparkToro: Similarweb is web-traffic-and-channel-analytics-focused; SparkToro is audience-and-influence-research-focused. Marketing teams running competitive intelligence at scale pick Similarweb; indie marketers exploring audience picks SparkToro. Public on NASDAQ:SMWB, used by Google, Wayfair, Nike.',
'', 'https://www.similarweb.com', 'https://www.similarweb.com',
'paid', true, 200, 4.4, 0,
false, false, false,
ARRAY['research','seo-marketing','analytics'],
ARRAY['Largest web traffic intelligence dataset','Channel-level marketing intelligence','NASDAQ-public reliability','Strong for Top 10K sites accuracy','Browser extension free for casual use'],
ARRAY['Pricing opaque - quote-based for serious tiers','Accuracy degrades for niche/small sites','Annual contract for full feature access','Steep learning curve for the depth of data'],
ARRAY['Competitive web traffic analysis','Marketing channel mix intelligence','Industry benchmarking','Audience behavior research','Market share analysis'],
ARRAY['slack','salesforce','hubspot'],
'{"trajectory":4,"ease_of_use":4,"reliability":4.5,"integrations":4,"feature_depth":5,"pricing_value":3,"output_quality":4.5}'::jsonb,
NOW()
)

ON CONFLICT (slug) DO NOTHING;
