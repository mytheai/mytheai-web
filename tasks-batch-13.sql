-- Phase 3 batch 5 of Task Taxonomy initiative (S127)
-- 25 mid-tail tasks pushing 359 -> 384 tasks (Phase 3 progress 77% of 500-target).
-- Coverage: dev (+5), data-analytics (+5), ops (+4), finance (+2), hr-recruiting (+2),
-- design (+3), research (+2), support (+2). Customer-success/marketing/writing/sales/productivity at cap.
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Gate A 27/28 PASS (1 dropped: knowledge-bases synonym), Gate B 27/27 PASS (100% - Block A backfill unlocked all).
-- 10 tasks were previously-blocked candidates (S125 + S126 Gate B failures) now PASS thanks to Block A Mode D tier 18.
-- Defensive on apostrophes + contractions + em-dashes (S122 + S125 + S126 lessons).
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === DEV (5) ===

-- 1. ai-for-error-monitoring
(
  'ai-for-error-monitoring', 'AI for Error Monitoring', '🐛',
  ARRAY['dev'], ARRAY['sentry','datadog','bugsnag'], 3,
  'Error monitoring is the difference between users hitting silent bugs and engineers fixing them before customers notice. AI-augmented error monitoring platforms now group similar errors automatically, surface the highest-user-impact issues first, and pull in source-map context so stack traces resolve to the original code line. Sentry leads modern application error monitoring with strong source-map handling and session replay; Datadog covers errors as part of full-stack observability for enterprise; Bugsnag specializes in mobile-app stability with crash-free user-rate tracking.',
  'We weighted: stack-trace quality with source-map handling, error-grouping accuracy, user-impact prioritization, and integration with Slack and PagerDuty for alerting.',
  '[
    {"q":"Sentry vs Datadog for error monitoring?","a":"Sentry is error-monitoring-first with the deepest stack-trace handling and developer UX; Datadog covers errors as one slice of full-stack observability across infrastructure, APM, and logs. Most engineering teams under 200 engineers default to Sentry; enterprise teams running on Datadog often layer Sentry alongside for the deeper error UX."},
    {"q":"How do AI platforms group similar errors?","a":"3 signals: (1) stack-trace fingerprint (top frames of the call stack); (2) error message pattern matching; (3) user-context (browser, OS, app version). Top platforms blend these to avoid spurious noise from minor format variations while still separating genuinely distinct bugs. Grouping accuracy hits 90 to 95 percent on clean codebases."},
    {"q":"Should we monitor errors in development too?","a":"Yes for staging environments to catch regressions before they hit production; no for local dev where the noise overwhelms signal. Most teams keep production tracked with full alerting, staging tracked with summary alerts only, and local dev untracked. The pattern catches release regressions early without burning engineer attention on local noise."}
  ]'::jsonb, 'dev', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-deployment-automation
(
  'ai-for-deployment-automation', 'AI for Deployment Automation', '🚀',
  ARRAY['dev'], ARRAY['vercel','netlify','railway'], 3,
  'Deployment automation in 2026 means push to Git, get a preview URL, merge to ship globally - the once-painful work of CI/CD pipelines, CDN configuration, and edge runtime is now handled by integrated frontend cloud platforms. AI-augmented deployment platforms surface build failures with suggested fixes, auto-detect framework and configuration, and roll back broken deploys without engineer intervention. Vercel leads modern frontend deployment with tight Next.js integration and strong edge-runtime; Netlify pioneered Jamstack deployment with framework-agnostic support; Railway handles full-stack deployment including databases and background workers.',
  'Selection prioritized: framework auto-detection, build-failure intelligence, edge-runtime depth, and integration with Git workflows.',
  '[
    {"q":"Vercel vs Netlify for deployment?","a":"Vercel has tighter Next.js integration with deeper edge-runtime support and image optimization; Netlify has stronger framework-agnostic positioning with cleaner pricing for non-Next.js stacks. Next.js shops default to Vercel; Astro, Hugo, SvelteKit, and Eleventy projects often pick Netlify."},
    {"q":"What about backend deployment?","a":"Vercel and Netlify focus on frontend with serverless API extensions; full-stack apps with traditional databases and long-running workers fit better on Railway, Render, or Fly.io. The choice depends on architecture: serverless-first picks Vercel or Netlify; container-and-database-first picks Railway."},
    {"q":"How do preview deployments help?","a":"3 ways: (1) every PR gets a live URL stakeholders can review, replacing screenshot-and-Loom workflows; (2) automated tests run against the preview rather than only after merge; (3) regressions caught in preview never hit production. Companies that adopt preview-deploy workflows cut bug-leak rates 30 to 50 percent."}
  ]'::jsonb, 'dev', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-llm-monitoring
(
  'ai-for-llm-monitoring', 'AI for LLM Monitoring', '🔭',
  ARRAY['dev'], ARRAY['langfuse','langsmith','helicone'], 3,
  'LLM monitoring (tracking prompts, responses, latency, cost, and quality across production AI applications) became essential as teams shipped LLM features and discovered that quality regressions, cost spikes, and latency drift happen invisibly without telemetry. AI-augmented LLM observability platforms now capture every model call into searchable trace UIs, surface quality regressions across model versions, and run evaluation suites against production traces. Langfuse leads open-source LLM observability with strong LangChain integration; LangSmith ships LangChain-native observability from the LangChain team; Helicone offers proxy-based one-line setup with strong cost-tracking.',
  'We weighted: trace UI quality, evaluation-suite depth, cost-tracking accuracy, and integration with major LLM frameworks (LangChain, LlamaIndex, direct OpenAI and Anthropic).',
  '[
    {"q":"Langfuse vs LangSmith vs Helicone?","a":"Langfuse is open-source-first with broadest framework support and self-host option; LangSmith is LangChain-native with tightest framework integration; Helicone is proxy-first with fastest setup. LangChain-heavy teams pick LangSmith; framework-agnostic teams pick Langfuse; teams wanting simplest integration pick Helicone."},
    {"q":"What metrics matter for LLM monitoring?","a":"5 layers: (1) cost per request and per user; (2) latency (p50, p95, p99); (3) error rate and timeouts; (4) quality drift across model versions; (5) eval scores against benchmark suites. Strong observability covers all 5; weak observability stops at cost and latency."},
    {"q":"How do we evaluate LLM quality in production?","a":"3 patterns: (1) automated evals (LLM-as-judge against rubrics); (2) human review of sampled traces (5-10 percent of production traffic); (3) explicit user feedback (thumbs up or down on each response). Strong programs blend all 3; eval-only programs miss user-perceived quality issues."}
  ]'::jsonb, 'dev', 'advanced', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-rag-applications
(
  'ai-for-rag-applications', 'AI for RAG Applications', '🧠',
  ARRAY['dev'], ARRAY['langchain','crewai','langflow','hugging-face'], 3,
  'Retrieval-augmented generation (RAG) became the default architecture for AI applications that need accurate domain-specific answers from private knowledge bases rather than relying on the LLM training data alone. AI-augmented RAG platforms now handle document ingestion, embedding, retrieval, and prompt orchestration through high-level abstractions rather than custom code. LangChain leads RAG application frameworks with broad ecosystem support; CrewAI and LangFlow ship visual or agent-first abstractions on top of LangChain primitives; Hugging Face hosts the open-source models and embedding APIs most RAG stacks rely on.',
  'Selection prioritized: framework expressiveness, retrieval quality, multi-step orchestration support, and integration with vector databases.',
  '[
    {"q":"LangChain vs LlamaIndex for RAG?","a":"LangChain has broader framework scope (agents, chains, memory) and larger ecosystem; LlamaIndex focuses tighter on retrieval and indexing with stronger out-of-box quality on document Q-and-A. Most teams start with LangChain for flexibility; teams focused on knowledge-base-Q-and-A pick LlamaIndex for the retrieval depth."},
    {"q":"What does a strong RAG stack look like?","a":"5 components: (1) document loaders (PDF, Notion, web, etc.); (2) chunking strategy (size and overlap); (3) embedding model (OpenAI, Cohere, or open-source via Hugging Face); (4) vector store (Pinecone, Chroma, Weaviate); (5) prompt orchestration with LLM (LangChain, LlamaIndex). Tuning each layer compounds quality; weak chunking or weak embeddings cap RAG performance regardless of LLM choice."},
    {"q":"How do we evaluate RAG quality?","a":"3 metrics: (1) retrieval precision (did we get the right context); (2) faithfulness (did the answer follow the retrieved context); (3) end-to-end accuracy on labeled benchmark questions. Tools like RAGAS automate retrieval and faithfulness scoring; end-to-end accuracy still needs hand-labeled benchmarks for the specific domain."}
  ]'::jsonb, 'dev', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 5. ai-for-prompt-engineering
(
  'ai-for-prompt-engineering', 'AI for Prompt Engineering', '✨',
  ARRAY['dev'], ARRAY['langfuse','langsmith','helicone'], 3,
  'Prompt engineering (the work of designing, testing, and iterating prompts that produce reliable LLM output) used to be an undisciplined craft of trial-and-error in Notion docs; AI-augmented LLM platforms now treat prompts as versioned artifacts with evaluation suites and A-B testing. Modern prompt management platforms version prompts in Git-like history, run evaluation suites across prompt versions, and surface which prompt template performs best per use case. Langfuse and LangSmith lead prompt management with deep observability integration; Helicone offers prompt experimentation alongside its proxy-based observability.',
  'We weighted: prompt-versioning workflow, evaluation-suite depth, A-B testing support, and integration with LLM frameworks.',
  '[
    {"q":"Should we treat prompts like code?","a":"Yes for production prompts. Versioning, testing, code review, and rollback discipline applied to prompts catches regressions and makes iteration safe. Production prompts that lack version control behave like undocumented logic that no one can audit when quality regresses."},
    {"q":"What is the right way to test a prompt?","a":"3 layers: (1) snapshot tests (specific inputs to specific expected outputs); (2) eval suites (LLM-as-judge against quality rubrics across 50-200 examples); (3) production sampling (5-10 percent of real traffic with human review). Strong programs run all 3; weak programs ship without any of them and pay for it during outages."},
    {"q":"How often should prompts change?","a":"Weekly is reasonable during active product development; monthly stabilizes as the use case matures. Stability is a feature for production prompts that work; instability creates noise and quality drift. The pattern is to batch prompt changes alongside model upgrades or evaluation-driven improvements rather than ad-hoc tweaks."}
  ]'::jsonb, 'dev', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DATA-ANALYTICS (5) ===

-- 6. ai-for-data-pipelines
(
  'ai-for-data-pipelines', 'AI for Data Pipelines', '🔀',
  ARRAY['data-analytics'], ARRAY['fivetran','dbt','segment','rudderstack'], 3,
  'Data pipelines (the systems that move data from source applications to analytics warehouses) used to be hand-rolled Python scripts that broke whenever a SaaS schema changed. AI-augmented pipeline platforms now handle 500 plus pre-built connectors that auto-detect schema changes, handle incremental syncs, and produce ELT-ready output for warehouses. Fivetran leads ELT extraction and loading with the broadest connector library; dbt handles the transformation layer with software-engineering discipline; Segment and RudderStack cover behavioral event tracking and customer-data unification.',
  'Selection prioritized: connector coverage, schema-change handling, transformation discipline, and integration with modern data warehouses.',
  '[
    {"q":"Fivetran vs custom Python pipelines?","a":"Fivetran wins for the long-tail of SaaS sources because the maintenance cost of custom connectors outweighs the build cost within 6-12 months at most companies. Custom Python remains right for proprietary internal data or edge cases Fivetran does not support. Most modern data teams default to Fivetran for SaaS sources."},
    {"q":"Do we need both Fivetran and dbt?","a":"Yes for most modern data stacks. Fivetran handles extract and load (the EL in ELT); dbt handles transformation (the T). Together they form the modern data stack core. Smaller teams sometimes use Fivetran-only or dbt-only setups but lose discipline at one layer."},
    {"q":"Segment vs RudderStack?","a":"Segment is the established leader with broadest integration ecosystem and strongest enterprise support; RudderStack is open-source-leaning with stronger warehouse-native architecture and lower cost at scale. Engineering-heavy teams pick RudderStack; broader teams pick Segment for the integration breadth."}
  ]'::jsonb, 'data-analytics', 'advanced', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-data-quality
(
  'ai-for-data-quality', 'AI for Data Quality', '🧐',
  ARRAY['data-analytics'], ARRAY['monte-carlo','dbt','fivetran','datadog'], 3,
  'Data quality issues (broken pipelines, schema changes, distribution shifts, freshness lag) used to surface only when an executive noticed wrong numbers in a dashboard. AI-augmented data observability platforms now learn expected data patterns automatically and alert data engineers when anomalies suggest pipeline issues - before downstream reports show wrong numbers. Monte Carlo created the data observability category with the deepest enterprise adoption; dbt provides data tests as part of transformation discipline; Fivetran ships pipeline-level monitoring; Datadog covers data infrastructure monitoring as part of full-stack observability.',
  'We weighted: anomaly-detection accuracy, end-to-end lineage, alert quality, and integration with modern data stack.',
  '[
    {"q":"What are the dimensions of data quality?","a":"5 standard dimensions: (1) freshness (how recent is the data); (2) volume (expected row counts); (3) distribution (statistical patterns); (4) schema (column presence and types); (5) lineage (where the data came from). Strong observability covers all 5 automatically; weak observability covers only freshness and schema."},
    {"q":"Monte Carlo vs dbt tests?","a":"dbt tests are inline in transformation code and catch known issues you wrote tests for; Monte Carlo runs continuously and detects anomalies you did not anticipate. The pattern is to use both: dbt tests for known-good invariants, Monte Carlo for unknown-unknown anomalies."},
    {"q":"How quickly should data quality alerts fire?","a":"Within 30 minutes for daily-refresh data; within 5 minutes for hourly-refresh data; within 1 minute for real-time data. Slower alerts mean wrong numbers reach dashboards before alerts reach humans. The cost of stale alerts is invisible quality erosion."}
  ]'::jsonb, 'data-analytics', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 8. ai-for-data-discovery
(
  'ai-for-data-discovery', 'AI for Data Discovery', '🔍',
  ARRAY['data-analytics'], ARRAY['atlan','dbt','datadog'], 3,
  'Data discovery (the work of finding the right table, dashboard, or metric for a question) used to mean asking around in Slack channels and hoping someone with tribal knowledge responded. AI-augmented data catalogs now surface relevant data assets by natural-language search, show column-level lineage so analysts understand context, and embed annotations alongside data in the tools where teams actually work. Atlan leads modern data catalogs built for analytics teams; dbt provides documentation and lineage as part of transformation; Datadog adds monitoring context to data assets.',
  'Selection prioritized: search quality, lineage depth, in-tool annotations, and integration with Slack and analytics platforms.',
  '[
    {"q":"Atlan vs Collibra for data discovery?","a":"Atlan is built for modern analytics teams with strong dbt and Snowflake integration and Slack-native discovery; Collibra is built for IT data governance with deeper compliance features for regulated industries. Modern analytics teams pick Atlan; finance and healthcare enterprises pick Collibra."},
    {"q":"How does AI help data discovery?","a":"3 ways: (1) semantic search across tables, columns, and dashboards; (2) auto-generated documentation from data context; (3) lineage tracing that surfaces upstream and downstream dependencies. The combination compresses the find-the-right-data step from days to minutes."},
    {"q":"Do we need a catalog at small scale?","a":"Below 10 analysts and 100 tables, dbt documentation suffices for most teams. Above 25 analysts and 500 tables, a dedicated catalog (Atlan, Collibra) becomes high-leverage. The threshold is judgment rather than strict count; the cost of not finding data outweighs catalog cost when search becomes routine."}
  ]'::jsonb, 'data-analytics', 'advanced', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 9. ai-for-event-tracking
(
  'ai-for-event-tracking', 'AI for Event Tracking', '📡',
  ARRAY['data-analytics'], ARRAY['segment','rudderstack','hubspot'], 3,
  'Event tracking (capturing user behavior signals like clicks, page views, feature usage) is the foundation of product analytics, marketing attribution, and personalized customer experiences. AI-augmented customer data platforms now unify event streams across channels, enrich events with user context automatically, and route enriched events to dozens of downstream destinations. Segment leads enterprise event tracking with broadest destination ecosystem; RudderStack ships open-source-leaning warehouse-first event tracking; HubSpot covers event tracking integrated with CRM and marketing automation.',
  'We weighted: event-schema flexibility, identity resolution depth, destination ecosystem breadth, and integration with data warehouse.',
  '[
    {"q":"Segment vs RudderStack?","a":"Segment is established with the broadest destination ecosystem and strongest enterprise SLA; RudderStack is open-source-leaning with warehouse-native architecture and lower cost at scale. Engineering-heavy teams pick RudderStack; broader marketing-and-product teams pick Segment for the destination breadth."},
    {"q":"What event schema should we use?","a":"Stick to a documented event taxonomy with 50-100 named events covering core user behaviors. More than 200 events per product becomes unmaintainable; fewer than 50 misses important signal. Strong taxonomies use verb-object naming (Clicked Signup, Viewed Pricing, Completed Purchase) and document required properties per event."},
    {"q":"Should we track everything?","a":"No. Track high-leverage events that drive product decisions, marketing attribution, and trust signals. Tracking everything creates noise, slows down events, and overwhelms downstream analytics. Strong programs track 50-100 events with clear documentation; weak programs track 500 events nobody understands."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-data-engineering
(
  'ai-for-data-engineering', 'AI for Data Engineering', '⚙️',
  ARRAY['data-analytics'], ARRAY['dbt','fivetran','segment','rudderstack'], 3,
  'Data engineering (building and maintaining the systems that move, transform, and serve data) used to require specialized engineers writing custom Python and Spark; AI-augmented modern data stack platforms now collapse most of that work into managed services. Modern data engineering platforms handle ingestion via Fivetran, transformation via dbt, behavioral events via Segment or RudderStack, and orchestration via Airflow alternatives - reducing custom code by 80 to 90 percent at most teams. The remaining custom work focuses on orchestration logic, business-specific transformations, and ML-feature pipelines.',
  'Selection prioritized: ingestion automation, transformation discipline, behavioral-event capture, and integration with cloud data warehouses.',
  '[
    {"q":"What does a modern data engineering stack look like?","a":"5 layers: (1) ingestion (Fivetran for SaaS, Segment or RudderStack for events); (2) storage (Snowflake, BigQuery, Databricks); (3) transformation (dbt); (4) orchestration (Dagster, Prefect, or Airflow); (5) BI and reverse ETL (Looker, Hex, Census). Strong stacks integrate all 5; weak stacks force custom code at multiple layers."},
    {"q":"How big does a team need to be for dedicated data engineering?","a":"At 10 plus analysts or 5 plus data scientists, a dedicated data engineer becomes high-leverage to maintain the pipeline reliability that makes analytics fast. Below that, analytics engineers (analysts who write dbt) handle most data engineering work using managed platforms."},
    {"q":"Should we build or buy data engineering tools?","a":"Buy for ingestion (Fivetran), transformation (dbt), and storage (warehouse vendor). Build only for proprietary internal sources Fivetran does not cover and ML feature pipelines that require custom logic. Companies that try to build the whole stack end up rebuilding what managed services already solved."}
  ]'::jsonb, 'data-analytics', 'advanced', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === OPS (4) ===

-- 11. ai-for-incident-management
(
  'ai-for-incident-management', 'AI for Incident Management', '🚨',
  ARRAY['ops'], ARRAY['datadog','pagerduty','sentry'], 3,
  'Incident management (the discipline of responding to production outages and restoring service quickly) determines whether outages become 15-minute blips or 4-hour catastrophes. AI-augmented incident platforms now route alerts to the right on-call engineer based on team, severity, and service ownership, surface related incidents from history, and produce post-mortem drafts automatically. Datadog covers incident management as part of full-stack observability; PagerDuty leads dedicated on-call alerting with broadest monitoring tool integration; Sentry surfaces error-driven incidents with strong release-context.',
  'We weighted: alert-routing intelligence, on-call schedule depth, post-mortem workflow, and integration with monitoring tools.',
  '[
    {"q":"PagerDuty vs Opsgenie?","a":"PagerDuty has the broadest monitoring tool integration ecosystem and stronger stakeholder communication features; Opsgenie integrates more tightly with Atlassian (Jira, Confluence) and ships at lower price for smaller teams. Atlassian-heavy teams pick Opsgenie; broader integration needs pick PagerDuty."},
    {"q":"What goes in a strong post-mortem?","a":"5 sections: (1) timeline of events; (2) impact analysis (users affected, duration, financial cost); (3) root cause; (4) action items with owners; (5) what went well. Strong post-mortems are blameless and focus on systems improvements; weak post-mortems blame individuals and miss systemic patterns."},
    {"q":"How quickly should we acknowledge incidents?","a":"Within 5 minutes during business hours; within 15 minutes off-hours. Slower acknowledgement amplifies user impact and erodes trust with stakeholders. The acknowledgement signal does not require resolution speed - it signals someone is working on the issue."}
  ]'::jsonb, 'ops', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 12. ai-for-compliance-monitoring
(
  'ai-for-compliance-monitoring', 'AI for Compliance Monitoring', '🛡️',
  ARRAY['ops'], ARRAY['vanta','drata','secureframe','aikido-security'], 3,
  'Compliance monitoring (continuously verifying that security and operational controls meet SOC 2, ISO 27001, HIPAA, GDPR standards) used to mean annual audit scrambles with screenshot binders and spreadsheets. AI-augmented compliance platforms now connect to cloud infrastructure, identity systems, and HR platforms to verify controls in real time and produce auditor-ready reports on demand. Vanta leads SaaS compliance automation with the cleanest UX for fast first audits; Drata offers stronger continuous monitoring depth; Secureframe covers 30 plus frameworks with human compliance support; Aikido Security focuses on application security as part of compliance.',
  'Selection prioritized: continuous-monitoring depth, framework breadth, auditor-collaboration workflow, and integration with infrastructure and HR systems.',
  '[
    {"q":"Vanta vs Drata vs Secureframe?","a":"Vanta has cleanest UX and fastest setup for first SOC 2; Drata has stronger continuous monitoring and richer auditor workflows; Secureframe has broadest framework support (30 plus) with human compliance experts. Most SaaS startups under 100 employees pick Vanta; mid-market multi-framework picks Drata or Secureframe."},
    {"q":"How long does SOC 2 take?","a":"Type I (point-in-time) takes 4-8 weeks with AI compliance platforms; Type II (3-12 month observation period) takes that observation window plus 6-8 weeks for auditor review. Companies running compliance manually consistently take 2-3x longer because evidence collection is the bottleneck."},
    {"q":"Should compliance be ongoing or audit-driven?","a":"Ongoing. Audit-driven compliance creates 3-month sprints of pain followed by 9-month drift. AI compliance platforms make continuous monitoring affordable and reduce audit prep from weeks to days. The pattern compounds: continuous monitoring catches drift in days, not next-audit-cycle."}
  ]'::jsonb, 'ops', 'advanced', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 13. ai-for-vendor-risk
(
  'ai-for-vendor-risk', 'AI for Vendor Risk', '🔐',
  ARRAY['ops'], ARRAY['vanta','drata','secureframe','aikido-security'], 3,
  'Vendor risk management (assessing the security, compliance, and operational reliability of third-party SaaS vendors) became a board-level concern as data-breach disclosure laws expanded and vendor footprints grew to hundreds of SaaS apps per company. AI-augmented vendor risk platforms now automate security questionnaire collection, score vendors against risk frameworks, and continuously monitor for security incidents at vendors. Vanta and Drata bundle vendor risk into their compliance platforms; Secureframe ships dedicated vendor management workflow; Aikido Security focuses on application-level vendor risk for code dependencies.',
  'We weighted: questionnaire automation, risk-scoring depth, continuous monitoring, and integration with procurement and security workflows.',
  '[
    {"q":"What vendor risk dimensions matter most?","a":"5 layers: (1) security posture (SOC 2, ISO, penetration testing); (2) data handling (where does customer data live, who can access); (3) financial stability (recent funding, runway, customer concentration); (4) operational reliability (uptime SLAs, incident history); (5) compliance fit (HIPAA, GDPR alignment with your obligations). Strong programs cover all 5."},
    {"q":"How often should we re-assess vendors?","a":"Annually for low-risk vendors; quarterly for high-risk (payment processors, identity providers, data processors); immediately on incident or significant business change. AI platforms surface re-assessment cadence automatically based on risk score and elapsed time."},
    {"q":"Vanta vs dedicated vendor risk tools?","a":"Vanta and similar compliance platforms cover the basic 80 percent of vendor risk for SaaS startups; dedicated tools (OneTrust, ProcessUnity) cover the remaining 20 percent for regulated industries with deep compliance obligations. Most SaaS companies under 500 employees stay with bundled compliance tools; financial services and healthcare often layer dedicated vendor risk."}
  ]'::jsonb, 'ops', 'advanced', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-saas-operations
(
  'ai-for-saas-operations', 'AI for SaaS Operations', '🧰',
  ARRAY['ops'], ARRAY['ramp','brex','vanta','rippling','airbase'], 3,
  'SaaS operations (the work of managing the 100 plus SaaS subscriptions a typical company runs - procurement, license tracking, security review, renewal management) used to be scattered across spreadsheets and finance team email threads. AI-augmented operations platforms now unify spend visibility, security posture, license utilization, and renewal calendars into single dashboards. Ramp and Brex blend SaaS spend management into broader corporate-card platforms; Vanta tracks SaaS security posture as part of compliance; Rippling unifies SaaS, HR, and IT into a single platform; Airbase ships dedicated SaaS spend with approval workflows.',
  'Selection prioritized: license-utilization tracking, renewal-calendar automation, security-posture integration, and procurement workflow depth.',
  '[
    {"q":"What is the typical SaaS spend at a startup?","a":"Roughly 6-12K USD per employee annually at SaaS-heavy companies; 4-8K at lighter SaaS use. Companies under 50 employees typically spend 300-700K annually on 80-150 different SaaS tools. License utilization audits commonly find 20-40 percent of seats unused or duplicate."},
    {"q":"Ramp vs Airbase for SaaS operations?","a":"Ramp is broader corporate-card-and-spend with strong SaaS spend visibility built in; Airbase has deeper dedicated SaaS spend workflow with stronger procurement and approval flows. Companies optimizing for spend visibility pick Ramp; companies focused on procurement discipline pick Airbase."},
    {"q":"How do we cut SaaS spend without breaking workflows?","a":"3 disciplines: (1) license utilization audit quarterly; (2) renewal calendar with 90-day advance review; (3) consolidate adjacent tools (multiple project trackers, multiple chat tools). Strong programs cut 15-25 percent of SaaS spend annually without team disruption."}
  ]'::jsonb, 'ops', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === FINANCE (2) ===

-- 15. ai-for-startup-finance
(
  'ai-for-startup-finance', 'AI for Startup Finance', '💎',
  ARRAY['finance'], ARRAY['pilot','bench','zeni','docyt','ramp','brex'], 3,
  'Startup finance (bookkeeping, tax, fundraising prep, cash management, investor reporting) used to require dedicated CFO and controller hires before product-market fit; AI-augmented startup finance platforms now bundle bookkeeping, tax, and CFO advisory at predictable monthly subscription rates accessible from day one. Modern platforms generate clean GAAP books in real time, run tax compliance automatically, produce investor updates from current data, and integrate with corporate cards for spend visibility. Pilot leads venture-backed startup finance with multi-entity and ASC 606 support; Bench targets SMB and seed-stage finance; Zeni and Docyt offer AI-first finance with on-demand human advisory; Ramp and Brex provide the corporate-card-and-spend layer.',
  'We weighted: GAAP book quality, tax-compliance automation, investor-reporting workflow, and integration with corporate-card spend.',
  '[
    {"q":"When does a startup need real finance help?","a":"Day 1 for bookkeeping and tax (founders should never DIY books past month 3); 3-5 employees for spend management (Ramp, Brex); 25-50 employees for CFO advisory (fractional or full-time). Companies that delay each tier pay more in catch-up costs than they save by waiting."},
    {"q":"Pilot vs Bench for startup finance?","a":"Pilot ships venture-backed-startup-grade finance with multi-entity, ASC 606 revenue recognition, and Series A-ready audit trail; Bench fits SMB and pre-seed companies with simpler needs at lower price. Series A and beyond picks Pilot; pre-seed and seed picks Bench."},
    {"q":"Should founders touch bookkeeping?","a":"Only to set the strategic chart of accounts and review monthly. Day-to-day bookkeeping (transaction categorization, reconciliation, accruals) should always be a paid service or AI-platform-with-bookkeeper. Founder time on bookkeeping is the highest-cost-lowest-leverage time in a startup."}
  ]'::jsonb, 'finance', 'advanced', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 16. ai-for-billing-automation
(
  'ai-for-billing-automation', 'AI for Billing Automation', '📤',
  ARRAY['finance'], ARRAY['tipalti','airbase','pandadoc','docyt'], 3,
  'Billing automation (invoice generation, payment processing, subscription management, revenue recognition) used to consume entire finance-team weeks at month-end and surface revenue leakage when done manually. AI-augmented billing platforms now generate invoices from contract terms, reconcile payments against invoices automatically, surface dunning candidates before customers churn, and produce revenue-recognition entries per ASC 606 standards. Tipalti specializes in mass-payout AP automation at global scale; Airbase blends billing into broader spend management; PandaDoc handles contract-to-invoice workflow; Docyt covers AR-and-AP automation for SMB.',
  'Selection prioritized: invoice-generation automation, payment-reconciliation accuracy, dunning-workflow depth, and integration with billing systems.',
  '[
    {"q":"How much revenue leakage is typical?","a":"For SaaS, 1-3 percent of billed revenue is typical for unreconciled accounts (failed payments not retried, missing customer credits, double-billed invoices). At 10M ARR that is 100-300K USD of leakage annually. Strong billing automation catches 80-90 percent of leakage; the cost of platforms is paid back many times over."},
    {"q":"Tipalti vs Airbase for billing?","a":"Tipalti is the AP-and-mass-payouts specialist with deepest global tax-and-compliance handling; Airbase is broader spend management with billing integrated. Companies running mass payouts (marketplaces, freelancer networks) pick Tipalti; companies focused on internal spend pick Airbase."},
    {"q":"Should billing run daily or monthly?","a":"Daily for high-velocity companies (ecommerce, marketplaces, sub-100-employee SaaS at scale); weekly is acceptable for stable mature companies; monthly is too slow and creates blind spots that compound. Modern platforms make daily billing operations affordable."}
  ]'::jsonb, 'finance', 'advanced', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === HR-RECRUITING (2) ===

-- 17. ai-for-talent-pipeline
(
  'ai-for-talent-pipeline', 'AI for Talent Pipeline', '🎯',
  ARRAY['hr'], ARRAY['eightfold','beamery','lever','greenhouse','ashby'], 3,
  'Talent pipeline management (sourcing candidates, building relationships before specific roles open, and re-engaging past applicants) is the highest-leverage recruiting discipline yet often skipped because it requires sustained investment without immediate ROI. AI-augmented talent platforms now automate sourcing from public profiles, score candidates against role requirements, and re-engage past applicants when relevant roles open. Eightfold leads enterprise talent intelligence with the deepest skill-graph; Beamery focuses on talent CRM with strong nurture workflows; Lever, Greenhouse, and Ashby ship modern ATS with talent-pipeline features built in.',
  'We weighted: sourcing automation, candidate-scoring depth, re-engagement workflow, and integration with ATS systems.',
  '[
    {"q":"Eightfold vs Beamery for talent pipeline?","a":"Eightfold has the deepest AI talent platform with skill-graph at the core, used at enterprise scale (10K plus employees); Beamery focuses on talent CRM with stronger nurture and engagement workflows. Pure talent intelligence at enterprise picks Eightfold; broader talent CRM picks Beamery."},
    {"q":"How big should the talent pipeline be?","a":"3-5x the open headcount target. If you plan to hire 20 engineers next year, the pipeline should hold 60-100 engaged engineers in various stages. Smaller pipelines force reactive hiring; larger pipelines waste time on cold relationships that never convert."},
    {"q":"Should AI source candidates automatically?","a":"Yes for the volume layer (LinkedIn-style sourcing of profiles matching role criteria); no for the qualification layer (resume review, fit assessment, interview scheduling). Strong programs use AI for top-of-funnel volume and humans for relationship-and-judgment work."}
  ]'::jsonb, 'hr-recruiting', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 18. ai-for-360-feedback
(
  'ai-for-360-feedback', 'AI for 360 Feedback', '🔄',
  ARRAY['hr'], ARRAY['lattice','culture-amp','15five'], 3,
  '360-degree feedback (collecting performance perspectives from manager, peers, direct reports, and self-assessment) provides richer signal than manager-only review but historically created painful logistics overhead. AI-augmented HRIS platforms now run 360 cycles with automated stakeholder selection, generate consolidated themes from open-ended responses, and produce manager-coaching summaries for each review. Lattice leads modern 360 feedback tied to performance cycles; Culture Amp pairs 360 with engagement signals; 15Five focuses on lighter continuous 360 alongside weekly check-ins.',
  'Selection prioritized: stakeholder-selection automation, response-aggregation quality, theme-detection depth, and integration with performance reviews.',
  '[
    {"q":"How many reviewers per 360 cycle?","a":"6-10 reviewers for individual contributors (1 manager, 3-4 peers, 2-3 cross-functional, self); 8-12 for managers (add 2-3 direct reports). More reviewers create dilution; fewer reviewers risk biased signal. The standard 6-10 floor balances signal quality with response burden."},
    {"q":"Lattice vs Culture Amp for 360?","a":"Lattice integrates 360 with performance review cycles for cleaner promotion and compensation context; Culture Amp pairs 360 with engagement surveys for richer organizational signals. Performance-cycle-led companies pick Lattice; engagement-led companies pick Culture Amp."},
    {"q":"Should 360 affect compensation directly?","a":"Indirectly through performance review aggregate, not directly through individual 360 scores. Direct compensation impact creates gaming dynamics where peers reward each other strategically. Strong programs use 360 for development conversations and performance-context, with compensation decisions still owned by manager judgment."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (3) ===

-- 19. ai-for-game-art
(
  'ai-for-game-art', 'AI for Game Art', '🎮',
  ARRAY['design'], ARRAY['midjourney','leonardo-ai','flux','krea-ai'], 3,
  'Game art (character concepts, environment design, prop design, UI elements, marketing visuals) used to require AAA-budget art teams; AI image-generation platforms now produce production-quality starting points that small teams refine in weeks rather than months. AI platforms generate consistent character designs across poses, build environment art with style coherence, and produce prop and UI iterations at scale. Midjourney leads cinematic game art with strongest style coherence; Leonardo AI specializes in game-asset workflows with character-sheet generation; Flux produces highly photorealistic and stylized output; Krea AI focuses on real-time creative iteration with strong style transfer.',
  'We weighted: style-coherence across iterations, character-consistency support, multi-pose generation, and licensing clarity for commercial use.',
  '[
    {"q":"Midjourney vs Leonardo AI for game art?","a":"Midjourney has the highest cinematic quality for hero art and concept work; Leonardo AI has stronger game-asset workflows with character-sheet generation, style consistency across multiple assets, and direct game-engine export options. Concept and marketing art picks Midjourney; production game development picks Leonardo."},
    {"q":"Can we use AI game art commercially?","a":"Yes for most major platforms (Midjourney, Leonardo, Flux Schnell) under their commercial license tiers. Major game distribution platforms (Steam, Epic) accept AI-assisted art with disclosure. Always check the specific platform license; AI-generated images cannot currently be copyrighted in the US but can be used commercially."},
    {"q":"How do we keep characters consistent across art?","a":"3 techniques: (1) reference-image approach where one strong generation becomes the base for variations; (2) tools with explicit character sheets (Leonardo AI, ComfyUI workflows); (3) LoRA fine-tuning on the character. The simplest start is the reference-image approach in Midjourney v6 or Leonardo character workflows."}
  ]'::jsonb, 'design', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 20. ai-for-storyboards
(
  'ai-for-storyboards', 'AI for Storyboards', '🎬',
  ARRAY['design'], ARRAY['midjourney','leonardo-ai','flux'], 3,
  'Storyboards (visual sequence boards that pre-visualize scenes for video, animation, or product launches) used to take days of hand-drawing or stock-photo collaging; AI image-generation platforms now produce coherent storyboard frames from text descriptions in minutes. AI platforms generate scene-by-scene visual sequences with style consistency, support character continuity across frames, and produce variations for client review. Midjourney leads cinematic storyboard quality with strong style coherence; Leonardo AI offers character-sheet workflows that help maintain continuity; Flux produces photorealistic frames that work for live-action storyboarding.',
  'Selection prioritized: scene coherence across frames, character continuity, style flexibility, and speed of generation.',
  '[
    {"q":"What goes in a strong storyboard?","a":"5 elements per frame: (1) shot composition (wide, medium, close-up); (2) camera angle and movement; (3) character placement and expression; (4) key prop and scene element; (5) lighting and mood notes. Strong storyboards convey camera direction beyond visual content; weak storyboards function as pretty mood boards."},
    {"q":"How long should storyboard frames take?","a":"With AI assistance: 5-10 minutes per frame including iteration; full 30-frame sequence in 4-6 hours for a director plus AI artist team. Without AI: same sequence takes 2-3 days hand-drawn. Compression compounds across multiple sequences and project iterations."},
    {"q":"Can AI replace a storyboard artist?","a":"For pre-visualization and rapid iteration, yes. For final production storyboards that drive shooting decisions on set, AI generates strong starting points that storyboard artists refine for camera-precision and continuity. Strong workflows use AI for ideation and humans for production-ready precision."}
  ]'::jsonb, 'design', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 21. ai-for-photo-editing
(
  'ai-for-photo-editing', 'AI for Photo Editing', '📸',
  ARRAY['design'], ARRAY['photoroom','picsart','runway'], 3,
  'Photo editing (background removal, retouching, color correction, object removal, image upscaling) used to require Photoshop expertise and meaningful time investment per image; AI photo-editing platforms now handle most edits in seconds with one-click workflows. AI platforms now produce production-quality background removal, retouch portraits naturally, generate alternative backgrounds, and upscale images without quality loss. Photoroom leads ecommerce-focused background removal and editing with mobile-first UX; Picsart covers social-and-creative photo editing across web and mobile; Runway handles advanced video and image AI editing including object removal and inpainting.',
  'We weighted: edit quality on production output, multi-format support, batch-processing throughput, and integration with creative workflows.',
  '[
    {"q":"Photoroom vs Picsart vs Runway?","a":"Photoroom is ecommerce-focused with strongest one-click product photography workflows; Picsart is social-creative-focused with broader effects and templates; Runway is advanced AI editing with video and inpainting depth. Ecommerce sellers pick Photoroom; social creators pick Picsart; professional creators pick Runway for advanced workflows."},
    {"q":"How accurate is AI background removal?","a":"For clean subjects (clear edges, plain backgrounds), 95-99 percent accurate without manual cleanup. For complex subjects (hair, glass, transparent objects, overlapping foreground), accuracy drops to 70-85 percent and may need manual refinement. The pattern is: use AI as the first pass and refine the 5-15 percent of cases AI handles imperfectly."},
    {"q":"Should we batch-process photos with AI?","a":"Yes for high-volume use cases (ecommerce catalogs, social media production, real estate listings) where consistency matters more than per-photo customization. Batch processing trades per-photo polish for throughput; for hero or campaign images, individual edits with AI assistance produce stronger results."}
  ]'::jsonb, 'design', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === RESEARCH (2) ===

-- 22. ai-for-audience-research
(
  'ai-for-audience-research', 'AI for Audience Research', '👥',
  ARRAY['research','marketing'], ARRAY['sparktoro','similarweb','hubspot'], 3,
  'Audience research (understanding who your customers are, where they hang out online, what they read and follow) replaces guesswork with data when planning marketing channels, content topics, and partnership targets. AI-augmented audience research platforms now crawl public web data to surface what podcasts your audience listens to, what social accounts they follow, what websites they visit, and what hashtags they use. SparkToro leads indie audience research with transparent pricing and strong searchable database; Similarweb covers enterprise web traffic intelligence at scale; HubSpot blends audience research with broader marketing automation.',
  'Selection prioritized: data freshness, segmentation flexibility, channel-discovery depth, and integration with marketing platforms.',
  '[
    {"q":"SparkToro vs Similarweb?","a":"SparkToro is audience-and-influence-research-focused with cleanest UX for indie marketers and transparent pricing from 50 USD per month; Similarweb is enterprise web-traffic-and-channel-analytics with deeper data at higher price (200 USD plus per month for individual access). Indie marketers pick SparkToro; enterprise market intelligence picks Similarweb."},
    {"q":"What audience signals matter most?","a":"5 layers: (1) where they consume content (podcasts, websites, social); (2) who they trust (specific influencers, accounts, publications); (3) what topics matter to them (hashtags, search queries); (4) demographic and firmographic context (job title, industry, company size); (5) buying signals (events attended, tools mentioned, hiring patterns). Strong programs research all 5; weak programs stop at demographic data."},
    {"q":"How often should we re-run audience research?","a":"Annually for stable categories; quarterly for fast-moving categories (consumer tech, AI, crypto); immediately when launching into a new market segment. Stale audience research misdirects channel investment toward where customers used to be rather than where they are now."}
  ]'::jsonb, 'research', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 23. ai-for-research-tagging
(
  'ai-for-research-tagging', 'AI for Research Tagging', '🏷️',
  ARRAY['research'], ARRAY['dovetail','maze','sprig','lookback'], 3,
  'Research tagging (assigning thematic codes to interview transcripts, survey responses, and observation notes) is foundational for cross-study synthesis but historically consumed 40-60 percent of qualitative research time. AI-augmented research platforms now generate first-pass tags automatically from a corpus, suggest taxonomy refinements based on emerging patterns, and let researchers iterate on the codebook collaboratively. Dovetail leads research-platform tagging with strong codebook collaboration; Maze and Sprig ship lighter automatic tagging tied to specific study types; Lookback supports inline tagging during moderated sessions.',
  'We weighted: first-pass tag quality, codebook iteration UX, multi-coder reliability, and integration with research repositories.',
  '[
    {"q":"How accurate is AI tagging vs human?","a":"On clearly-defined codes, AI matches expert-coder agreement at 75-85 percent on first pass. On nuanced or interpretive codes, accuracy drops to 60-70 percent. The pattern is to use AI as a first-pass to scale coverage, then have the researcher refine the 15-25 percent AI gets wrong. Time savings reach 5-10x with quality matching expert coders after refinement."},
    {"q":"Dovetail vs Maze for research tagging?","a":"Dovetail is the research repository with deeper codebook collaboration and longitudinal cross-study analysis; Maze ships lighter tagging tied to usability tests with stronger out-of-box quality on specific study types. Pure research tagging at scale picks Dovetail; usability-test-led teams pick Maze."},
    {"q":"Should AI build the codebook itself?","a":"AI generates a strong starting taxonomy from a sample; the researcher should refine for theoretical fit and domain context. Pure-AI codebooks miss the nuance that comes from researcher knowledge of the domain and stakeholders. Hybrid AI-and-researcher codebooks consistently outperform either alone in qualitative research."}
  ]'::jsonb, 'research', 'intermediate', 320,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SUPPORT (2) ===

-- 24. ai-for-ticket-deflection
(
  'ai-for-ticket-deflection', 'AI for Ticket Deflection', '↩️',
  ARRAY['customer-service'], ARRAY['intercom','gorgias','forethought','freshchat'], 3,
  'Ticket deflection (resolving customer questions before they become support tickets) is the single biggest lever in support cost containment, and AI-augmented support platforms now deflect 30-50 percent of tier-1 questions through conversational help centers and proactive in-product messaging. AI platforms now answer questions in natural language with citation, suggest help-center articles in real time during conversations, and surface friction patterns where deflection failed for content-team review. Intercom leads conversational deflection for SaaS with strong AI agent (Fin); Gorgias dominates ecommerce ticket deflection with Shopify-native workflows; Forethought specializes in enterprise deflection with deep ticket-classification; Freshchat covers SMB and mid-market deflection.',
  'Selection prioritized: deflection rate accuracy, content-quality from knowledge base, friction-detection depth, and integration with help-center systems.',
  '[
    {"q":"What deflection rate is realistic?","a":"30-50 percent for SaaS and ecommerce after 60-90 days of tuning; 50-70 percent for very high-volume well-documented categories (account questions, order status). Above 70 percent often means the bot forces resolutions customers later escalate, damaging trust more than higher human-touch rates."},
    {"q":"Intercom vs Gorgias for deflection?","a":"Intercom is SaaS-product-led with conversational UX and strong AI agent (Fin); Gorgias is ecommerce-native with order-context awareness for resolution. SaaS picks Intercom; Shopify and BigCommerce stores pick Gorgias."},
    {"q":"How do we measure deflection quality?","a":"3 metrics: (1) deflection rate (percent of tickets resolved without human agent); (2) escalation rate (percent of AI-handled tickets customers later escalate); (3) CSAT on AI-handled vs human-handled. Healthy deployments lift deflection without raising escalation or hurting CSAT."}
  ]'::jsonb, 'support', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 25. ai-for-conversation-analytics
(
  'ai-for-conversation-analytics', 'AI for Conversation Analytics', '🎙️',
  ARRAY['customer-service','sales'], ARRAY['gong-io','intercom','gainsight','sembly-ai'], 3,
  'Conversation analytics (extracting patterns from sales calls, support tickets, and customer interviews to surface trends, coaching moments, and product signals) used to require manually reviewing recordings or transcripts. AI-augmented conversation platforms now analyze every conversation automatically, surface common topics and objections, and produce dashboards that show how conversation patterns shift over time. Gong leads enterprise sales conversation analytics with deepest call-data depth; Intercom covers support conversation analytics integrated with messaging; Gainsight ships customer success conversation analytics; Sembly AI focuses on meeting intelligence with extensible analytics.',
  'We weighted: pattern-detection accuracy, dashboard quality, trend-surfacing intelligence, and integration with CRM and support platforms.',
  '[
    {"q":"What patterns does conversation analytics surface?","a":"5 strong patterns: (1) common objections and their handling quality; (2) competitor mentions and context; (3) feature-request frequency; (4) sentiment trends across deals or accounts; (5) talk-listen ratio and conversation flow. Strong analytics covers all 5; weak analytics stops at sentiment alone."},
    {"q":"Gong vs Sembly AI?","a":"Gong is the enterprise leader with deepest call-data analytics, largest benchmark dataset, and strongest coaching workflows; Sembly is meeting-intelligence-first with extensible analytics layer. Sales orgs above 30 reps pick Gong; smaller teams or meeting-intelligence-led teams pick Sembly."},
    {"q":"Should every conversation be analyzed?","a":"For B2B SaaS sales above 5K USD ACV, yes - the coaching value compounds quickly. Disclosure is required by law in many jurisdictions; modern platforms automate the disclosure prompt. For very small deals or quick support tickets, analytics may produce more noise than signal; sample analysis is sufficient."}
  ]'::jsonb, 'support', 'advanced', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
)

ON CONFLICT (slug) DO UPDATE SET
  title = EXCLUDED.title,
  emoji = EXCLUDED.emoji,
  primary_tags = EXCLUDED.primary_tags,
  picked_slugs = EXCLUDED.picked_slugs,
  fallback_min = EXCLUDED.fallback_min,
  intro = EXCLUDED.intro,
  methodology = EXCLUDED.methodology,
  faqs = EXCLUDED.faqs,
  category = EXCLUDED.category,
  difficulty = EXCLUDED.difficulty,
  monthly_search_volume = EXCLUDED.monthly_search_volume,
  related_top10_slugs = EXCLUDED.related_top10_slugs,
  related_use_case_slug = EXCLUDED.related_use_case_slug,
  related_blog_slugs = EXCLUDED.related_blog_slugs,
  status = EXCLUDED.status,
  updated_at = NOW();
