-- Phase 3 batch 6 of Task Taxonomy initiative (S128)
-- 27 mid-tail tasks pushing 384 -> 411 tasks (Phase 3 progress 82.2% of 500-target).
-- Coverage: data-analytics (+4), dev (+3), finance (+2), customer-success (+3), research (+3),
-- support (+4), design (+1), productivity (+2), sales (+1), writing (+3), marketing (+1).
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Gate A 31/40 PASS (9 conflicts), Gate B 27/31 PASS (3 fails Gate B + 1 fallback_min < 3 = cap-table).
-- Gate B fails dropped: feature-flags, database-migrations, revenue-recognition, brand-asset-management,
-- personal-finance, buyer-intent, sales-compensation. Defensive on apostrophes/contractions/em-dashes.
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === DATA-ANALYTICS (4) ===

-- 1. ai-for-data-warehouse
(
  'ai-for-data-warehouse', 'AI for Data Warehouse', '🏛️',
  ARRAY['data-analytics'], ARRAY['dbt','fivetran','atlan'], 3,
  'A modern data warehouse stack pulls raw data from source systems into a central analytics database, transforms it into clean modeled tables, and surfaces the lineage so analysts can trust what they query. AI-augmented data warehouse tools now suggest dbt model SQL from natural language prompts, auto-document column meaning, and auto-detect schema drift between source and warehouse. dbt leads the modern data stack as the transformation layer of choice; Fivetran provides managed extract-load with hundreds of pre-built connectors; Atlan delivers the catalog and lineage layer that ties source, transformation, and dashboard together.',
  'We weighted: connector breadth and reliability, transformation language depth, lineage and catalog completeness, and integration with Snowflake and downstream BI tools.',
  '[
    {"q":"dbt vs Fivetran - do we need both?","a":"Yes for most modern stacks. Fivetran handles the extract-load layer (pulling raw data from Salesforce, HubSpot, Stripe into Snowflake); dbt handles the transformation layer (cleaning raw tables into modeled analytics tables). They solve different layers of the modern data stack and most analytics teams run both."},
    {"q":"How does Atlan fit into the data warehouse stack?","a":"Atlan sits above dbt and Fivetran as the catalog and lineage layer. It documents what each table means, who owns it, and how columns flow from source to dashboard. Without a catalog, data teams answer the same definitional questions repeatedly; with a catalog, those answers are written once and surfaced where analysts are working."},
    {"q":"Should we adopt the modern data stack at any company size?","a":"Below 50 employees, a single source-of-truth dashboard built directly on Stripe and HubSpot exports is usually enough. Between 50 and 200, an extract-load tool like Fivetran into Postgres or BigQuery starts paying off. Above 200, the full Fivetran plus dbt plus Snowflake plus catalog stack becomes the standard for analytics maturity."}
  ]'::jsonb, 'data-analytics', 'advanced', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-product-metrics
(
  'ai-for-product-metrics', 'AI for Product Metrics', '📈',
  ARRAY['data-analytics'], ARRAY['posthog','mixpanel','amplitude'], 3,
  'Product metrics tools track how users move through your product so teams can spot friction, measure feature adoption, and forecast retention. AI-augmented product analytics now auto-detect anomalies across funnels, suggest retention experiments based on cohort patterns, and answer plain-English questions like which feature drove last week activation jump. PostHog leads open-source product analytics with self-hosting plus integrated session replay; Mixpanel offers the deepest funnel and cohort analysis for B2B SaaS; Amplitude provides the strongest enterprise-grade behavioral data platform.',
  'Selection prioritized: event-tracking SDK quality, funnel and cohort depth, real-time query latency, and self-serve dashboard creation by non-analysts.',
  '[
    {"q":"PostHog vs Mixpanel vs Amplitude?","a":"PostHog suits engineering-led teams that want self-hosting, integrated session replay, and a free tier; Mixpanel suits B2B SaaS product teams that need deep funnel and retention analysis; Amplitude suits enterprise teams with multiple product lines that need governance and large-scale behavioral data infrastructure. Most teams start with PostHog or Mixpanel and migrate to Amplitude when scale and governance needs grow."},
    {"q":"What product metrics matter most?","a":"For B2B SaaS the core four: weekly active users, time to first value, feature adoption rate, and 4-week retention. For consumer products: D1 D7 D30 retention curves plus session length. Tracking too many metrics splinters team focus; tracking the core four well drives most product decisions."},
    {"q":"How does AI help with product metrics analysis?","a":"3 ways: (1) anomaly detection across thousands of funnel slices flags drops a human would miss; (2) plain-English query interfaces let PMs ask questions without learning SQL; (3) cohort-suggestion engines surface retention experiments based on behavioral patterns. The AI layer turns analytics from analyst-bottlenecked to PM-self-serve."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-attribution-modeling
(
  'ai-for-attribution-modeling', 'AI for Attribution Modeling', '🎯',
  ARRAY['data-analytics'], ARRAY['segment','mixpanel','amplitude'], 3,
  'Attribution modeling answers the most expensive question in marketing: which channels actually drove the conversion. AI-augmented attribution tools now go beyond last-click to fit multi-touch models against historical data, surface incrementality estimates by channel, and reconcile click data across web, mobile, and offline touchpoints. Segment provides the customer-data-platform foundation that feeds clean event data into attribution engines; Mixpanel and Amplitude both run multi-touch attribution against their behavioral event tables.',
  'We weighted: identity-resolution accuracy across devices, multi-touch model variety, integration with paid ad platforms for cost data, and lift-test integration for incrementality validation.',
  '[
    {"q":"What is wrong with last-click attribution?","a":"Last-click gives 100 percent of the credit to the final touchpoint, which over-rewards retargeting and branded search while under-rewarding the upper-funnel channels that introduced the customer. Most companies running last-click cut their brand and content budgets too aggressively because the data does not surface upper-funnel impact. Multi-touch models distribute credit across the full journey."},
    {"q":"Multi-touch vs media-mix modeling?","a":"Multi-touch attribution stitches together user-level click data and assigns credit per touch; media-mix modeling uses aggregate spend and revenue time-series to estimate channel lift. MTA works best for digital-first brands with strong tracking; MMM works best for brands with TV, radio, and other un-trackable channels. Mature growth teams run both."},
    {"q":"How has iOS 14.5 changed attribution?","a":"3 effects: (1) iOS app install attribution lost meaningful resolution as IDFA opt-in rates dropped below 30 percent; (2) Facebook Conversions API and similar server-side approaches partially restored fidelity for web; (3) media-mix modeling regained popularity as a privacy-resilient method. Most companies post-2021 added MMM alongside MTA rather than relying on one alone."}
  ]'::jsonb, 'data-analytics', 'advanced', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-event-analytics
(
  'ai-for-event-analytics', 'AI for Event Analytics', '🔬',
  ARRAY['data-analytics'], ARRAY['posthog','segment','mixpanel'], 3,
  'Event analytics tools instrument every meaningful user action - signup, feature use, payment, churn - and store the events so teams can query behavior across any time horizon. AI-augmented event analytics surface anomalies in real time, suggest funnel optimizations from cohort patterns, and convert plain-English questions into SQL queries. PostHog leads on developer-friendly self-hosted event analytics; Segment provides the customer-data-platform layer that fans events out to many destinations; Mixpanel offers the most mature behavioral query interface for product teams.',
  'Selection prioritized: SDK reliability across web and mobile, query speed at billions of events scale, downstream tool integration, and AI assistant quality for non-SQL users.',
  '[
    {"q":"Event analytics vs general analytics?","a":"General analytics like Google Analytics tracks page views and aggregate sessions; event analytics tracks discrete user actions with custom properties so any question about behavior is answerable. Event analytics is the foundation for product, growth, and lifecycle marketing teams; page-view analytics alone cannot answer most product questions."},
    {"q":"Should we use Segment as our CDP?","a":"Yes if you fan event data to more than 4 destinations or run a marketing stack that needs identity resolution across web, mobile, and email. No if you only send events to one analytics platform - direct SDK integration is simpler and cheaper. Most companies hit the Segment threshold around 50 to 100 employees as the marketing stack expands."},
    {"q":"What is event taxonomy and why does it matter?","a":"Event taxonomy is the naming convention and property schema for every event you track. Bad taxonomy (signup_completed in some places, account_created in others) makes downstream analysis painful and breaks BI dashboards. Good taxonomy is documented, enforced via SDK wrappers, and reviewed quarterly. Time spent on taxonomy upfront pays back 10x in analyst hours saved."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DEV (3) ===

-- 5. ai-for-platform-engineering
(
  'ai-for-platform-engineering', 'AI for Platform Engineering', '🏗️',
  ARRAY['dev'], ARRAY['vercel','railway','netlify'], 3,
  'Platform engineering teams build the internal developer platform that lets product engineers ship without managing infrastructure - one push deploys preview URLs, another merge ships to production, all via paved paths. AI-augmented platform tools now auto-detect framework configuration, suggest fixes for failed builds, and roll back broken deploys without engineer intervention. Vercel leads frontend platform engineering with deep Next.js plus edge-runtime integration; Railway handles full-stack platform deployment with managed databases and workers; Netlify provides framework-agnostic Jamstack deployment.',
  'We weighted: framework auto-detection breadth, build-failure intelligence, environment-management UX, and rollback safety in production deploys.',
  '[
    {"q":"What is platform engineering vs DevOps?","a":"DevOps is the practice of merging dev and ops responsibilities; platform engineering is the discipline of building an internal product (the platform) that abstracts away infrastructure for product engineers. Platform teams have product roadmaps, internal customers (other engineers), and SLOs. Most companies above 200 engineers split out a platform team from the broader DevOps function."},
    {"q":"Build vs buy for the internal platform?","a":"Buy for standard concerns: deployment, preview environments, edge-runtime, log aggregation. Build for company-specific concerns: feature flags tied to your customer model, deployment policies that match your compliance posture. The build-vs-buy mistake most platform teams make is rebuilding deployment platforms that Vercel or Railway solve out of the box."},
    {"q":"How do AI-augmented platforms reduce ops load?","a":"3 ways: (1) failed-build summarization with suggested fixes resolves common issues without an SRE on-call; (2) auto-rollback on deploy failure prevents bad releases from sticking; (3) framework auto-detection eliminates per-app config files. Together these cut platform team queue depth roughly in half on most stacks."}
  ]'::jsonb, 'dev', 'advanced', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 6. ai-for-observability
(
  'ai-for-observability', 'AI for Observability', '🔭',
  ARRAY['dev'], ARRAY['datadog','sentry','bugsnag'], 3,
  'Observability is the practice of understanding production system behavior from the outside in - through logs, metrics, traces, and now AI-driven correlation. AI-augmented observability platforms group similar errors automatically, surface highest-user-impact issues first, correlate metric anomalies across services, and pull in source-map context so stack traces resolve to the original code line. Datadog leads enterprise full-stack observability spanning infrastructure, APM, logs, and security; Sentry leads application error monitoring with deep developer UX; Bugsnag specializes in mobile app stability with crash-free user-rate tracking.',
  'Selection prioritized: signal correlation across logs and traces, error-grouping accuracy, mobile crash handling, and integration with PagerDuty and Slack for paging.',
  '[
    {"q":"What are the 3 pillars of observability?","a":"Logs (timestamped event records), metrics (aggregated numerical measurements), and traces (distributed request paths across services). Mature observability stacks unify all three so that a metric anomaly drills into the related traces and logs. Datadog and Honeycomb represent the unified-three model; Sentry and Bugsnag focus deeper within the error-monitoring slice."},
    {"q":"Sentry vs Datadog - do we need both?","a":"For teams under 200 engineers Sentry alone often suffices since most production issues surface as application errors. For teams above 200 engineers running on Kubernetes with multiple service tiers, Datadog plus Sentry is common - Datadog handles infrastructure plus APM, Sentry handles error UX with deeper developer workflow integration."},
    {"q":"How does AI help with alert noise?","a":"3 mechanisms: (1) anomaly detection that learns baseline patterns instead of static thresholds reduces false positives on traffic-driven metrics; (2) related-incident grouping bundles cascading alerts from one root cause into a single page; (3) auto-summarization condenses log spikes into a 1-sentence root-cause hypothesis. Together these cut on-call paging volume 40 to 60 percent on most teams."}
  ]'::jsonb, 'dev', 'advanced', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-cloud-monitoring
(
  'ai-for-cloud-monitoring', 'AI for Cloud Monitoring', '☁️',
  ARRAY['dev'], ARRAY['datadog','sentry','bugsnag','pagerduty'], 3,
  'Cloud monitoring tools watch infrastructure health, application performance, and security signals across AWS, GCP, Azure, and edge providers - then page the right engineer when something breaks. AI-augmented cloud monitoring now auto-detects baseline anomalies, correlates incidents across services, suggests likely root causes, and routes alerts to the engineer most likely to resolve them. Datadog leads enterprise cloud monitoring with the broadest cloud and APM coverage; Sentry covers the application-error slice; Bugsnag covers mobile crashes; PagerDuty handles the on-call rotation and escalation layer.',
  'We weighted: cloud-provider coverage breadth, anomaly-detection accuracy, alert routing intelligence, and on-call rotation management depth.',
  '[
    {"q":"Datadog vs CloudWatch for AWS monitoring?","a":"CloudWatch is included with AWS and covers basic infrastructure metrics; Datadog adds cross-cloud APM, log aggregation, security monitoring, and richer dashboarding at additional cost. Most teams start with CloudWatch only, add Datadog when they hit 50+ engineers running multi-region or multi-cloud, or when CloudWatch dashboards become unwieldy."},
    {"q":"How does PagerDuty fit into the monitoring stack?","a":"PagerDuty is the routing layer above the monitoring tools - Datadog detects an anomaly, PagerDuty routes the page to the right on-call engineer with the right escalation path. Without PagerDuty (or competitors like Opsgenie), teams hand-build escalation rules in chat. PagerDuty becomes the standard around 30 to 50 engineers as on-call rotation maturity grows."},
    {"q":"What does good alert hygiene look like?","a":"3 rules: (1) every alert must have a runbook link with concrete next steps; (2) alerts that page on-call must be actionable - if the response is always wait and see, downgrade to a dashboard widget; (3) alert review monthly to retire noisy ones. Teams that follow these cut on-call burden 50 percent without missing real incidents."}
  ]'::jsonb, 'dev', 'advanced', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === FINANCE (2) ===

-- 8. ai-for-finops
(
  'ai-for-finops', 'AI for FinOps', '💰',
  ARRAY['finance'], ARRAY['ramp','brex','tipalti','airbase'], 3,
  'FinOps is the discipline of treating cloud and SaaS spending as a managed asset rather than an unmanaged cost - tagging spend by team, surfacing waste, and forecasting committed-use needs. AI-augmented FinOps platforms now auto-categorize transactions, flag spend anomalies before month-end close, suggest annual-commitment savings, and reconcile receipts across hundreds of vendors. Ramp leads modern corporate-card-plus-spend management with strong AI categorization; Brex covers a similar surface with deeper banking integration; Tipalti handles mass-payment automation; Airbase unifies AP, expense, and corporate cards.',
  'Selection prioritized: auto-categorization accuracy, spend-anomaly detection, vendor-onboarding ease, and reconciliation depth across cards plus AP.',
  '[
    {"q":"Ramp vs Brex - which suits a B2B startup?","a":"Ramp suits cost-conscious teams with strong category-spend visibility built-in and a free tier on the card; Brex suits venture-backed teams that want banking, treasury, and corporate cards in one stack. Most early-stage startups end up on Brex for the all-in-one banking story; growth-stage teams often migrate to Ramp for sharper spend management."},
    {"q":"What is the FinOps maturity model?","a":"3 stages: (1) visibility - all spend tagged and categorized; (2) optimization - committed-use plans, vendor consolidation, unused license cleanup; (3) governance - team-level budget guardrails, automated approval flows, anomaly alerts. Most companies ladder up over 18 to 24 months as cloud and SaaS line items grow."},
    {"q":"How do AI tools cut SaaS waste?","a":"4 mechanisms: (1) usage detection flags unused seats; (2) duplicate-tool detection finds 3 calendar tools across teams that could consolidate; (3) renewal-window surfacing prevents auto-renew on tools nobody uses; (4) negotiation-data benchmarks suggest fair pricing per category. Combined, mature FinOps tooling typically cuts 15 to 25 percent of SaaS spend in year one."}
  ]'::jsonb, 'finance', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 9. ai-for-treasury-management
(
  'ai-for-treasury-management', 'AI for Treasury Management', '🏦',
  ARRAY['finance'], ARRAY['ramp','brex','airbase'], 3,
  'Treasury management covers cash visibility, liquidity forecasting, payment scheduling, and bank-account reconciliation - work that used to require a dedicated treasurer plus spreadsheets and now runs through unified treasury platforms. AI-augmented treasury tools forecast cash runway across scenarios, auto-categorize bank transactions, surface idle cash for yield optimization, and reconcile multi-bank statements without manual matching. Ramp and Brex both extend their corporate-card stacks into treasury operations; Airbase covers AP plus treasury reconciliation in one suite.',
  'We weighted: bank-feed reliability, forecast model quality, multi-currency handling, and integration with the corporate-card and AP layers.',
  '[
    {"q":"Do startups need a treasury management system?","a":"Below 30 employees, a spreadsheet plus the bank dashboard is usually enough. Above 30 with multi-bank or multi-currency operations, a treasury platform pays for itself by catching reconciliation errors and surfacing yield opportunities. Series B and later companies almost always run a dedicated treasury layer."},
    {"q":"What is cash forecasting accuracy in practice?","a":"For predictable B2B SaaS revenue with monthly subscription payments, AI-driven 90-day forecasts hit 95 percent plus accuracy. For consumer or seasonal businesses, accuracy drops to 80 to 85 percent at the same horizon. The forecast value is not the precision but the early surfacing of liquidity risks 60 to 90 days out."},
    {"q":"How does treasury connect to the AP and card stack?","a":"In a unified suite (Airbase, Brex, Ramp), treasury sees the same transaction stream as AP and corporate cards, so cash forecasts reflect known upcoming AP runs and recurring card spend automatically. In a fragmented stack with separate vendors, a controller must hand-merge the data. Unified suites cut month-end close by 30 to 50 percent for finance teams under 20 people."}
  ]'::jsonb, 'finance', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === CUSTOMER-SUCCESS (3) ===

-- 10. ai-for-customer-lifecycle
(
  'ai-for-customer-lifecycle', 'AI for Customer Lifecycle', '🔄',
  ARRAY['customer-success'], ARRAY['vitally','gainsight','planhat'], 3,
  'Customer lifecycle management spans the full journey from onboarding through expansion, renewal, and advocacy - and the right tooling makes the difference between reactive churn fighting and proactive growth. AI-augmented customer-lifecycle platforms now surface health-score changes, suggest next-best-actions per account, automate playbook execution at lifecycle stages, and forecast churn risk weeks before contract end. Vitally leads modern usage-driven CS for B2B SaaS; Gainsight remains the enterprise standard with the deepest customer 360 view; Planhat positions on simplicity and faster time-to-value than enterprise alternatives.',
  'Selection prioritized: usage-data ingestion quality, health-score model flexibility, automation builder depth, and integration with CRM and billing systems.',
  '[
    {"q":"Vitally vs Gainsight - which fits a 100-person B2B SaaS?","a":"Vitally suits product-led B2B SaaS that already runs on a modern data stack and wants tight integration with usage events; Gainsight suits sales-led enterprise B2B with high-touch CSMs and complex playbook needs. The 100-person SaaS line typically goes Vitally if PLG or Gainsight if enterprise."},
    {"q":"What lifecycle stages should we automate first?","a":"3 stages with highest ROI: (1) onboarding milestones - automated nudges if customer has not hit first-value within 14 days; (2) renewal pre-flight - 90 days before renewal, surface usage trends and engagement patterns; (3) churn-risk - health-score drop triggers CSM outreach. Automating these three before others gives most teams a 6 to 12 month payback period."},
    {"q":"How accurate is AI-driven churn prediction?","a":"For B2B SaaS with 12 months of customer history and clean usage events, AI churn models hit 75 to 85 percent precision at the 30-day horizon. The value is not perfect prediction but earlier signal - human CSMs typically catch churn risk 14 days before contract end, AI models surface risk 60 to 90 days out. The window matters because saves at 60 days have far higher success rate than saves at 14 days."}
  ]'::jsonb, 'customer-success', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 11. ai-for-account-planning
(
  'ai-for-account-planning', 'AI for Account Planning', '📋',
  ARRAY['customer-success'], ARRAY['affinity','gainsight','clari'], 3,
  'Account planning is the structured discipline of mapping the buyer organization, identifying expansion paths, and aligning go-to-market resources to each strategic account - and AI tooling now does much of the org-mapping and signal-detection work. AI-augmented account-planning platforms enrich account data from public sources, map relationships from email and calendar metadata, surface expansion signals from product usage, and suggest playbook plays per buyer persona. Affinity leads relationship-graph mapping for deal teams; Gainsight provides the customer-success layer for post-sale account planning; Clari covers revenue-operations side of strategic accounts.',
  'We weighted: relationship-graph quality, data enrichment freshness, integration with CRM and email, and playbook-suggestion accuracy.',
  '[
    {"q":"Affinity vs Gainsight for account planning?","a":"Affinity focuses on pre-sale relationship-graph - mapping who-knows-who across the buyer org from email and calendar metadata. Gainsight focuses on post-sale account expansion - mapping product usage, success milestones, and expansion signals. Many strategic-account teams run both, with Affinity for pre-sale planning and Gainsight for post-sale execution."},
    {"q":"What goes into a good account plan?","a":"5 sections: (1) buying committee map with decision-maker, champions, blockers; (2) current state - what they bought, how they use it; (3) target state - what good looks like in 12 months; (4) expansion playbook - the 2 or 3 most-likely add-on plays; (5) review cadence. Teams that hit all 5 see 30 to 50 percent higher expansion revenue per account."},
    {"q":"How often should account plans be refreshed?","a":"Quarterly for strategic accounts (top 5 to 10 percent of revenue); semi-annually for mid-market; annually only for SMB. The refresh cadence should match the velocity of change in the buyer org - faster-changing buyers need quarterly. Most teams over-invest in SMB account planning and under-invest in strategic, exactly inverse of what generates revenue."}
  ]'::jsonb, 'customer-success', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 12. ai-for-renewal-forecasting
(
  'ai-for-renewal-forecasting', 'AI for Renewal Forecasting', '🗓️',
  ARRAY['customer-success'], ARRAY['vitally','gainsight','clari','churnzero'], 3,
  'Renewal forecasting predicts which customers will renew, which will churn, and which will expand - turning the renewal book from a black box into a forward-looking pipeline. AI-augmented renewal-forecasting platforms blend usage data, support ticket patterns, NPS scores, executive engagement, and contract history to score every renewal 60 to 180 days out. Vitally and Gainsight cover usage-driven forecasting for product-led and enterprise SaaS respectively; Clari extends pipeline forecasting into renewal pipelines; ChurnZero focuses specifically on retention and expansion forecasting.',
  'Selection prioritized: forecast accuracy at 90-day and 30-day windows, usage-signal richness, executive-engagement tracking, and integration with CRM renewal pipeline.',
  '[
    {"q":"How early should we forecast a renewal?","a":"180 days out for strategic accounts so CSMs have time to fix mid-cycle issues; 90 days out for mid-market; 60 days out for SMB. The forecast window should match the time-to-influence the renewal outcome - strategic deals need long lead time, SMB renewals are often won or lost in the final 30 days."},
    {"q":"What signals predict renewal best?","a":"4 strongest: (1) sustained product usage 90 days before renewal - falling usage is the leading indicator; (2) executive-sponsor engagement (responses to QBR invites, opens of strategic emails); (3) ticket sentiment trend; (4) feature adoption breadth. Teams that track all 4 hit 85 to 92 percent forecast accuracy at 60 days."},
    {"q":"Renewal forecasting vs revenue forecasting?","a":"Revenue forecasting (Clari, Gong) projects new-business closes from active sales pipeline; renewal forecasting projects retained revenue from the existing customer base. Both feed total-revenue forecasts but use different signals - sales pipeline for new business, usage and engagement for renewals. Mature revenue ops teams run both side by side."}
  ]'::jsonb, 'customer-success', 'intermediate', 320,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === RESEARCH (3) ===

-- 13. ai-for-research-repository
(
  'ai-for-research-repository', 'AI for Research Repository', '🗂️',
  ARRAY['research'], ARRAY['dovetail','maze','sprig'], 3,
  'A research repository is the searchable archive of every customer interview, usability test, and survey insight - and the difference between research that compounds and research that gets re-done quarterly. AI-augmented research repositories now auto-tag insights from raw transcripts, surface related findings across studies, suggest cross-study patterns, and convert plain-English questions into evidence-backed answers. Dovetail leads research-repository UX with strong AI tagging; Maze adds usability testing on top of repository; Sprig covers in-product research with AI synthesis built in.',
  'We weighted: transcript ingestion quality, auto-tagging accuracy, cross-study pattern detection, and integration with research workflow tools.',
  '[
    {"q":"Why does a research repository matter?","a":"3 reasons: (1) prevents research duplication - new PMs can find that the question was already answered 6 months ago; (2) compounds insight value - patterns become visible only across multiple studies; (3) democratizes research - sales and CS teams can self-serve the answers they need. Without a repository, research investment leaks out as turnover happens."},
    {"q":"Dovetail vs Maze for repository?","a":"Dovetail is repository-first with rich tagging and search; Maze adds the unmoderated usability test runner alongside the repository. Pure research teams pick Dovetail; teams that run heavy unmoderated testing pick Maze. Many teams under 200 use Dovetail and a separate tool for usability tests; larger teams often consolidate on Maze."},
    {"q":"How does AI auto-tagging compare to manual?","a":"AI tagging matches manual quality on 80 to 85 percent of insights and processes 20x faster. The remaining 15 to 20 percent need human review for nuance, especially around emotional tone or domain-specific terminology. Mature research teams use AI tagging as the first pass, then human review for high-stakes studies."}
  ]'::jsonb, 'research', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-customer-discovery
(
  'ai-for-customer-discovery', 'AI for Customer Discovery', '🔍',
  ARRAY['research'], ARRAY['dovetail','maze','typeform','sprig'], 3,
  'Customer discovery is the early-stage research that uncovers what users actually need, why they want it, and which solutions they will pay for - the foundation of any product that finds market fit. AI-augmented customer-discovery tools recruit participants matching specific criteria, run structured interviews with auto-transcription, surface themes across dozens of conversations, and suggest follow-up questions based on emerging patterns. Dovetail handles synthesis from interview transcripts; Maze runs unmoderated usability and concept tests; Typeform powers structured discovery surveys; Sprig captures in-product micro-interviews.',
  'Selection prioritized: participant recruiting depth, interview transcription accuracy, theme synthesis quality, and integration with research repository.',
  '[
    {"q":"How many discovery interviews are enough?","a":"For a new feature aimed at an existing audience: 8 to 12 interviews surface 80 percent of the meaningful themes. For a brand-new product or audience: 20 to 30 interviews. The diminishing-returns curve hits sharp around interview 10 to 12 in most contexts - beyond that, additional interviews mostly confirm rather than discover."},
    {"q":"Recruiting from existing customers vs cold?","a":"For early-stage discovery on assumptions about market need, cold recruiting from the target persona avoids confirmation bias from already-converted customers. For late-stage discovery on feature priorities, existing customers give faster signal because they already understand the product context. Most teams blend roughly 30 percent cold plus 70 percent existing customer for ongoing discovery."},
    {"q":"How does AI synthesis improve discovery?","a":"3 ways: (1) cross-interview pattern detection finds themes a researcher might miss after the 5th interview when fatigue sets in; (2) sentiment analysis surfaces emotional weight per topic, not just frequency; (3) follow-up question suggestions based on emerging gaps in evidence. Together these cut synthesis time roughly 70 percent on a 20-interview study."}
  ]'::jsonb, 'research', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 15. ai-for-feedback-synthesis
(
  'ai-for-feedback-synthesis', 'AI for Feedback Synthesis', '🧩',
  ARRAY['research'], ARRAY['dovetail','maze','sprig','lookback'], 3,
  'Feedback synthesis turns piles of raw customer input - support tickets, NPS comments, interview transcripts, app store reviews - into structured themes that drive product decisions. AI-augmented feedback synthesis tools cluster similar comments automatically, surface emerging themes before humans notice them, weight themes by customer revenue or segment, and suggest the highest-impact response. Dovetail leads research-repository synthesis; Maze covers usability-test synthesis; Sprig handles in-product feedback synthesis; Lookback specializes in moderated-research synthesis.',
  'We weighted: clustering accuracy, theme-weighting flexibility, integration with feedback sources, and synthesis-output quality for sharing with stakeholders.',
  '[
    {"q":"How is feedback synthesis different from sentiment analysis?","a":"Sentiment analysis labels feedback as positive, negative, or neutral; synthesis groups feedback into themes (pricing concerns, onboarding friction, feature requests). Sentiment is a thin signal; synthesis is a deep one. Most teams that adopted sentiment-only analysis in 2018 to 2020 layered synthesis on top by 2023 because sentiment alone could not drive decisions."},
    {"q":"Should we weight feedback by customer revenue?","a":"Yes for B2B SaaS where one enterprise customer carries more revenue than 50 SMB combined. No for consumer where weighting by revenue under-counts the silent majority. The right weighting depends on whether a small revenue-skew accurately reflects the broader user base or hides it."},
    {"q":"How accurate is AI-driven theme clustering?","a":"On clean B2B SaaS feedback (support tickets, NPS comments) AI clustering matches expert manual synthesis on 85 to 90 percent of themes. The remaining 10 to 15 percent need human review for edge cases or domain-specific language. The right pattern is AI for the initial clustering pass plus human for theme labeling and weighting."}
  ]'::jsonb, 'research', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SUPPORT (4) ===

-- 16. ai-for-call-center-analytics
(
  'ai-for-call-center-analytics', 'AI for Call Center Analytics', '📞',
  ARRAY['support'], ARRAY['gong-io','modjo','sembly-ai'], 3,
  'Call center analytics turns the highest-volume customer conversation channel into a managed feedback loop - surfacing rep-coaching opportunities, customer themes, and product issues that would otherwise stay buried in call recordings. AI-augmented call center analytics now auto-transcribe and summarize every call, score conversations against quality rubrics, surface coaching moments, and aggregate themes across thousands of conversations. Gong leads conversation intelligence for sales-led call centers; Modjo provides European-built conversation analytics with strong multi-language support; Sembly handles meeting and call summarization with broad SaaS integration.',
  'Selection prioritized: transcription accuracy across accents, conversation-scoring accuracy, theme aggregation quality, and integration with CRM and ticketing.',
  '[
    {"q":"What can call analytics surface that managers miss?","a":"4 patterns: (1) repeated objections that suggest pricing or positioning gaps; (2) rep behaviors that correlate with close rate (talk-ratio, question depth); (3) emerging product complaints before they hit support tickets; (4) compliance violations like missed disclosures. Without analytics, managers rely on spot-listen samples that miss most patterns."},
    {"q":"Privacy and consent for call recording?","a":"Most jurisdictions require disclosed two-party consent (the customer must be told the call is recorded). Some US states and EU countries require explicit opt-in; others accept implicit consent after disclosure. Compliance teams should review the call disclosure script and confirm consent capture before deploying analytics. Misconfigured consent capture is the most common compliance gap."},
    {"q":"How does AI scoring compare to manual QA?","a":"AI scoring runs 100 percent of calls in real time, vs manual QA that samples 2 to 5 percent. AI matches manual quality on rubric-based scoring (did the rep use the disclosure language) but lags humans on nuance scoring (did the rep show empathy at the right moment). Most teams use AI for the rubric layer and human QA for nuance."}
  ]'::jsonb, 'support', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 17. ai-for-omnichannel-support
(
  'ai-for-omnichannel-support', 'AI for Omnichannel Support', '💬',
  ARRAY['support'], ARRAY['gorgias','intercom','freshdesk','zendesk'], 3,
  'Omnichannel support unifies email, chat, SMS, social, and phone into a single agent workspace so a customer interaction continues seamlessly across channels - and so the support team measures performance consistently. AI-augmented omnichannel support tools auto-route tickets to the right team, suggest agent responses, summarize ticket history, and surface customer context from connected systems. Gorgias leads e-commerce omnichannel for Shopify-based brands; Intercom covers omnichannel for B2B SaaS with strong AI Resolution Bot; Freshdesk and Zendesk both offer enterprise-grade omnichannel for mature support orgs.',
  'We weighted: channel breadth, conversation-context preservation across channels, AI response quality, and integration depth with CRM and order systems.',
  '[
    {"q":"Gorgias vs Zendesk for ecommerce?","a":"Gorgias is built for Shopify and e-commerce specifically with deep order context and pre-built order-status macros; Zendesk is general-purpose with broader enterprise features and more customization. Shopify brands under 200 employees default to Gorgias; multi-channel retailers with complex enterprise needs often pick Zendesk."},
    {"q":"What does true omnichannel mean?","a":"Two requirements: (1) the agent sees the full conversation history across all channels in one timeline; (2) the customer can switch channels mid-conversation without re-explaining the issue. Most help desks marketed as omnichannel only meet the first; full omnichannel matters most for high-volume B2C support where channel-switching is common."},
    {"q":"How much does AI deflection cost-per-ticket reduction?","a":"For e-commerce with high order-status volume: 40 to 60 percent ticket deflection via AI auto-resolution. For B2B SaaS with complex issues: 15 to 30 percent. The deflection rate depends on the percentage of tickets that match repeatable patterns - e-commerce has many such patterns, complex B2B has fewer."}
  ]'::jsonb, 'support', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 18. ai-for-support-knowledge
(
  'ai-for-support-knowledge', 'AI for Support Knowledge', '📚',
  ARRAY['support'], ARRAY['document360','intercom','guru','zendesk'], 3,
  'Support knowledge platforms hold the answers customers (and agents) need - and the difference between fast resolution and long ticket cycles often comes down to whether the right answer surfaces at the right moment. AI-augmented support knowledge platforms now auto-suggest articles in agent workspaces, generate draft articles from resolved tickets, surface outdated content for review, and answer customer questions directly via chat. Document360 leads dedicated knowledge-base authoring; Intercom embeds knowledge directly into chat; Guru handles internal team knowledge; Zendesk Guide ties knowledge to the help-desk stack.',
  'Selection prioritized: AI search quality, agent-workspace integration, content-freshness flagging, and customer self-serve experience.',
  '[
    {"q":"External vs internal knowledge base?","a":"External KB serves customers via help center and chat (Document360, Zendesk Guide); internal KB serves agents and employees with playbooks and procedures (Guru, Confluence). Most mature support orgs run both, often with shared content tagged for visibility. Trying to merge them into one usually compromises both audiences."},
    {"q":"How often should KB articles be reviewed?","a":"3 cadences by content type: (1) feature-specific articles - quarterly review timed to release cycles; (2) policy and pricing articles - immediately on policy change; (3) general how-to articles - annually unless a triage flag surfaces. AI-driven content-freshness flagging catches outdated articles that would otherwise stay live for years."},
    {"q":"What is good KB search quality?","a":"3 metrics: (1) successful self-serve rate (the customer found the answer without filing a ticket); (2) zero-result search rate (queries with no matching article surface gaps); (3) helpful-article ratio (thumbs up vs thumbs down on article ratings). Good performance: 60 percent self-serve plus less than 5 percent zero-result plus more than 80 percent helpful."}
  ]'::jsonb, 'support', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 19. ai-for-ticket-prioritization
(
  'ai-for-ticket-prioritization', 'AI for Ticket Prioritization', '🚦',
  ARRAY['support'], ARRAY['gorgias','intercom','freshdesk','zendesk'], 3,
  'Ticket prioritization decides which customer waits 5 minutes and which waits 4 hours - and getting it wrong burns enterprise customers, breaks SLAs, and overloads agents on low-priority work. AI-augmented ticket-prioritization platforms now classify urgency from message content, weight tickets by customer revenue or segment, surface VIP escalations automatically, and detect sentiment escalation that signals a churn risk. Gorgias leads e-commerce prioritization with order-value weighting; Intercom covers B2B SaaS prioritization with revenue and intent signals; Freshdesk and Zendesk handle enterprise prioritization with full SLA management.',
  'We weighted: classification accuracy, customer-segment weighting flexibility, sentiment-escalation detection, and SLA-breach prevention.',
  '[
    {"q":"What signals should drive ticket priority?","a":"5 signals: (1) customer revenue or plan tier; (2) explicit urgency words in the message; (3) sentiment escalation (anger, frustration); (4) issue type (broken payment vs how-to question); (5) time-since-first-contact. Most teams over-rely on the first two and miss the productivity gains from sentiment and time-based signals."},
    {"q":"Should every ticket get an SLA?","a":"Yes for paid plans where SLA breach correlates with churn; informal SLAs only for free plans where strict SLAs would burn agent capacity on low-revenue customers. The most common SLA mistake is applying enterprise-grade SLAs across all plan tiers, which means agents spend time on low-value tickets while VIP issues queue up."},
    {"q":"How does AI handle false-positive escalations?","a":"3 mitigations: (1) confidence-threshold tuning so only high-confidence escalations route to senior agents; (2) feedback loops where wrongly escalated tickets retrain the classifier; (3) human review of borderline cases before SLA timer starts. With good tuning, AI escalation matches manual rates within 5 percent while running 100x more tickets."}
  ]'::jsonb, 'support', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (1) ===

-- 20. ai-for-product-mockups
(
  'ai-for-product-mockups', 'AI for Product Mockups', '🎨',
  ARRAY['design'], ARRAY['uizard','relume','galileo-ai','visily'], 3,
  'Product mockups translate a feature idea into something the team can react to before engineering builds it - and AI tools now compress the days of mockup work into minutes via prompt-to-design generation. AI-augmented mockup tools generate full screens from text prompts, auto-suggest layouts based on UX patterns, convert hand sketches to clean mockups, and produce ready-to-build component libraries. Uizard leads prompt-to-mockup generation with strong sketch-to-design support; Relume specializes in Webflow-component-based mockups; Galileo AI generates editable Figma files from prompts; Visily handles wireframe to mockup conversion.',
  'Selection prioritized: prompt-to-mockup quality, output editability in Figma, sketch input quality, and integration with downstream development workflow.',
  '[
    {"q":"AI mockups vs traditional Figma work?","a":"AI tools speed the first 70 percent of mockup work (layout, base components, common patterns); the final 30 percent (brand polish, micro-interactions, edge cases) still benefits from a designer in Figma. Most product teams use AI for early concept exploration and fall back to Figma for final design. Treating AI tools as Figma replacements rather than first-pass accelerators usually disappoints."},
    {"q":"How does Uizard compare to Galileo AI?","a":"Uizard exports clean editable mockups within its own app and offers strong sketch input; Galileo AI produces Figma-native files which slot into existing design workflows but skip the sketch input. Teams that already live in Figma pick Galileo AI; teams without Figma adoption pick Uizard for the all-in-one experience."},
    {"q":"Can AI mockups replace user research?","a":"No - AI mockups speed iteration on already-validated ideas but cannot validate need or usability. The right pattern is user research to identify the problem, AI mockups to iterate on solution concepts, then user testing to validate the chosen direction. Skipping research and jumping to AI mockups produces beautiful unwanted features."}
  ]'::jsonb, 'design', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === PRODUCTIVITY (2) ===

-- 21. ai-for-team-handbooks
(
  'ai-for-team-handbooks', 'AI for Team Handbooks', '📖',
  ARRAY['productivity'], ARRAY['document360','gitbook','slab'], 3,
  'A team handbook captures how the company actually works - hiring rubrics, decision-making processes, on-call rotations - so new hires ramp without 100 hours of one-on-one explanation. AI-augmented handbook tools auto-suggest sections, surface stale content, answer questions in chat from handbook content, and convert meeting transcripts into handbook entries. Document360 leads structured-handbook authoring with AI search; GitBook handles technical-handbook documentation with strong Git integration; Slab provides team-handbook UX with light-weight setup.',
  'We weighted: AI search quality, content-freshness detection, contributor experience, and integration with chat tools for in-context answers.',
  '[
    {"q":"Why does a team handbook beat a wiki?","a":"3 differences: (1) handbooks are intentionally curated (one canonical answer per topic) while wikis tend to fragment; (2) handbooks have explicit ownership per section so updates happen; (3) handbooks ship with onboarding pathways. Wikis decay faster than they grow - handbooks stay current because the company invests in maintenance."},
    {"q":"What sections matter most in a handbook?","a":"Top 6 by ROI: (1) hiring rubrics and interview process; (2) compensation and leveling; (3) decision-making framework; (4) communication norms (sync vs async, response times); (5) tool stack with onboarding paths; (6) values plus expected behaviors. Handbooks that cover these 6 well drive faster ramp time and cleaner culture transmission."},
    {"q":"How does AI keep handbooks current?","a":"3 mechanisms: (1) staleness detection flags pages not updated in 12 months; (2) link-rot detection catches broken references; (3) AI suggests updates based on chat context (if the team is discussing a topic with no handbook entry, suggest creating one). Together these cut handbook decay 50 to 70 percent vs unassisted maintenance."}
  ]'::jsonb, 'productivity', 'beginner', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 22. ai-for-shared-calendars
(
  'ai-for-shared-calendars', 'AI for Shared Calendars', '📅',
  ARRAY['productivity'], ARRAY['cal-com','reclaim-ai','motion'], 3,
  'Shared calendars turn meeting scheduling from a 4-email back-and-forth into a single link - and AI-augmented shared-calendar tools now go further by auto-blocking focus time, defending against meeting overload, and rescheduling conflicts intelligently. Cal.com leads open-source shared scheduling with strong customization; Reclaim AI provides AI-powered focus-time defense and habit scheduling; Motion combines calendar plus AI task management with auto-rescheduling.',
  'Selection prioritized: scheduling-link UX, AI auto-rescheduling intelligence, focus-time defense quality, and integration with Google Calendar plus Outlook.',
  '[
    {"q":"Cal.com vs Calendly?","a":"Cal.com is open-source with self-hosting, strong customization, and growing AI features; Calendly is the established standard with broader integrations and the most mature UX. Teams with engineering resources or specific compliance needs pick Cal.com; teams that want zero-setup pick Calendly. Both work well for the core scheduling-link use case."},
    {"q":"What does AI calendar defense do?","a":"3 main functions: (1) auto-blocks focus time on the calendar so meetings cannot eat deep work; (2) reschedules conflicts intelligently using meeting priority signals; (3) defends against day-fragmentation by clustering meetings into specific blocks. Reclaim and Motion both do these; the difference is workflow style, not capability."},
    {"q":"Should everyone in the team use the same calendar tool?","a":"Yes for the scheduling-link tool so meeting requests work cleanly across the team. No requirement on the AI calendar defense layer - that is personal productivity. Most teams standardize on one shared scheduling tool plus let individuals pick their own AI defense layer."}
  ]'::jsonb, 'productivity', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SALES (1) ===

-- 23. ai-for-account-mapping
(
  'ai-for-account-mapping', 'AI for Account Mapping', '🗺️',
  ARRAY['sales'], ARRAY['gong-io','affinity','clari'], 3,
  'Account mapping is the work of identifying who in the buyer organization holds budget, who blocks the deal, and who champions internally - and AI tooling now does much of the org-mapping work that previously took hours per account. AI-augmented account-mapping tools build relationship graphs from email and calendar metadata, enrich org charts from public sources, surface multi-thread engagement, and suggest the next-best contact to engage. Gong covers conversation-based account intelligence; Affinity leads relationship-graph mapping for deal teams; Clari extends pipeline forecasting with account-level insights.',
  'We weighted: relationship-graph accuracy, org-chart freshness, multi-threading detection, and integration with CRM contact records.',
  '[
    {"q":"Why does account mapping matter for B2B?","a":"In enterprise B2B with 5 to 10 stakeholders per deal, single-thread sales (one rep talking to one buyer) loses to multi-thread sales (rep plus exec plus PM talking to buyer plus exec plus PM). Account mapping shows where threads are missing - the rep sees the gap and engages the right title. Companies that adopt structured account mapping see 25 to 40 percent higher enterprise win rates."},
    {"q":"Affinity vs Gong for account mapping?","a":"Affinity maps the relationship-graph (who-knows-who across the buyer org from email plus calendar metadata); Gong maps the conversation-graph (what was said, by whom, when). Both useful, both different. Strategic-account teams often run both - Affinity for pre-sale relationship mapping, Gong for in-deal conversation intelligence."},
    {"q":"How fresh should the account map be?","a":"For active deals: refreshed every week, since stakeholders rotate and budget shifts. For dormant accounts: monthly is enough. The freshness gap is what AI tools solve - manual account-map maintenance is the first thing reps drop when busy, while AI keeps the map current automatically. Account maps that are 6 months stale are worse than no map at all."}
  ]'::jsonb, 'sales', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === WRITING (3) ===

-- 24. ai-for-internal-communications
(
  'ai-for-internal-communications', 'AI for Internal Communications', '📣',
  ARRAY['writing'], ARRAY['slab','slack','guru'], 3,
  'Internal communications covers the weekly all-hands, the cross-team launch announcement, the policy update - the work of keeping a fast-growing org informed without drowning everyone in noise. AI-augmented internal-comms tools draft announcements from bullet-point inputs, summarize long updates for skim-readers, suggest the right channel and audience, and surface stale information that needs refresh. Slab provides handbook-style structured comms; Slack remains the chat backbone with AI-summary and search layered in; Guru holds the internal-knowledge layer that comms reference back to.',
  'Selection prioritized: draft-quality from bullet-point inputs, audience-targeting suggestions, integration with chat tools, and search across past comms.',
  '[
    {"q":"How is internal-comms different from external-comms?","a":"Internal-comms optimizes for clarity and trust within an org that already shares context; external-comms optimizes for persuasion plus brand to audiences without context. Tone, length, and structure all differ. Companies that copy-paste external-comms tone into internal channels usually feel inauthentic to employees. Voice differentiation matters."},
    {"q":"What channel for what message?","a":"4-tier framework: (1) handbook for evergreen policies plus processes; (2) email for time-stamped one-way updates that need a paper trail; (3) chat for immediate discussions plus quick updates; (4) all-hands for high-context plus emotionally-weighted topics. Mismatched channel choice (a layoff via chat, a quick update via all-hands) breaks trust faster than the message content itself."},
    {"q":"How does AI improve internal comms?","a":"3 ways: (1) draft generation from bullet-point inputs cuts writing time 60 to 80 percent for standard updates; (2) audience-targeting suggestions reduce noise (do not message everyone, message the relevant team); (3) summarization helps skim-readers across long threads. The risk is over-AI-polished comms losing voice - keep the human edit pass."}
  ]'::jsonb, 'writing', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 25. ai-for-professional-bios
(
  'ai-for-professional-bios', 'AI for Professional Bios', '👔',
  ARRAY['writing'], ARRAY['jasper','copy-ai','writesonic','rytr'], 3,
  'A professional bio is the 50-word summary that lands speaking gigs, attracts hires, and signals positioning on LinkedIn - and most professionals over-describe their role while under-describing the unique value they bring. AI-augmented bio writing tools generate platform-specific drafts (LinkedIn, conference, podcast, byline), suggest crisp value-prop framing, and produce variants tuned for different audiences. Jasper leads professional-content generation with brand-voice support; Copy.ai offers strong template variety; Writesonic covers business-writing with multi-language support; Rytr provides budget-friendly bio generation.',
  'We weighted: platform-specific tone matching, value-prop crispness, variant generation quality, and tone customization for personal brand.',
  '[
    {"q":"How long should a professional bio be?","a":"3 lengths to keep ready: (1) 25 words for Twitter or speaker intros; (2) 75 words for LinkedIn About summary; (3) 250 words for conference programs and bylines. The same person writes 3 versions tuned to context. Trying to use a single 200-word bio for all contexts produces awkward fits everywhere."},
    {"q":"What makes a bio memorable?","a":"3 ingredients: (1) one specific accomplishment with a number (built X to Y revenue, scaled team from A to B); (2) a current focus that signals where you are headed (currently working on Z); (3) a personal touch that humanizes (lives in city, hobby, side project). Generic bios with title plus company plus years experience signal nothing memorable."},
    {"q":"Should AI write the whole bio or just edit?","a":"Best results come from AI generating 3 variants, you picking the best framing, then editing for voice. AI alone produces generic-sounding bios; AI plus your edit pass produces sharp bios in 10 minutes vs the hour it would take from scratch. Treat AI as draft generator, not final writer."}
  ]'::jsonb, 'writing', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 26. ai-for-recipe-writing
(
  'ai-for-recipe-writing', 'AI for Recipe Writing', '🍳',
  ARRAY['writing'], ARRAY['jasper','copy-ai','writesonic','rytr'], 3,
  'Recipe writing requires a specific structure - ingredient list, ordered steps, timing, yield, technique notes - and AI-augmented recipe tools now generate well-structured recipes from a dish concept, scale ingredient quantities, suggest substitutions, and adapt recipes for dietary restrictions. Jasper leads long-form recipe content with structured templates; Copy.ai handles recipe generation with strong variant production; Writesonic covers multi-language recipe content; Rytr provides budget-friendly recipe drafts.',
  'Selection prioritized: recipe-structure adherence, ingredient-substitution quality, multi-format export (blog, card, video script), and SEO optimization for recipe blogs.',
  '[
    {"q":"What makes a well-structured recipe?","a":"5 sections in order: (1) yield plus prep plus cook time at the top; (2) ingredient list grouped by recipe section; (3) numbered steps with technique callouts; (4) substitution notes per ingredient where relevant; (5) storage and reheating guidance. Recipes that hit all 5 outperform on save rates and cooking-success rates."},
    {"q":"Should AI write the whole recipe?","a":"AI is strong on structure (the right sections in the right order) and weak on recipe testing - it cannot taste the result or feel the dough texture. Best practice: AI generates the structured draft, you cook it, then revise the draft based on what worked vs what failed. Skipping the cook-test produces recipes that read well but disappoint when made."},
    {"q":"How do I make my recipe blog rank in search?","a":"4 SEO requirements: (1) Recipe schema JSON-LD with all properties (cookTime, recipeIngredient, recipeInstructions); (2) primary keyword in title, URL, h1, plus first 100 words; (3) recipe-specific image with descriptive alt text; (4) internal linking to related recipes. AI tools handle the schema and copy generation; the schema implementation often needs developer help."}
  ]'::jsonb, 'writing', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === MARKETING (1) ===

-- 27. ai-for-link-building
(
  'ai-for-link-building', 'AI for Link Building', '🔗',
  ARRAY['marketing'], ARRAY['semrush','ahrefs','surfer-seo','frase'], 3,
  'Link building remains one of the strongest organic-ranking signals, and AI-augmented tools now identify high-authority opportunity sites, draft personalized outreach emails, and predict link-acquisition probability based on prospect behavior. Semrush leads on link-prospecting plus outreach automation at scale; Ahrefs offers the deepest link-graph data and competitor backlink analysis; Surfer SEO covers content-led link building (skyscraper plus original-research) with AI drafting; Frase combines content optimization plus link-prospect surfacing.',
  'We weighted: link-graph data freshness, outreach-personalization quality, opportunity-scoring accuracy, and integration with CRM and email tools.',
  '[
    {"q":"What link-building tactics work in 2026?","a":"3 that still produce results: (1) original-research content (proprietary survey or data analysis worth citing); (2) digital PR (newsworthy stories that earn mentions in Tier-1 publications); (3) niche-relevant guest posts on sites with real audience plus topical authority. Tactics that no longer work: low-quality directory submissions, mass guest-post outreach, link exchanges. Google has discounted these to roughly zero."},
    {"q":"Semrush vs Ahrefs for link prospecting?","a":"Ahrefs has the largest plus freshest link-graph index (typically 60 to 100 percent more crawled URLs); Semrush adds stronger outreach-automation workflows plus broader keyword data alongside links. SEO specialists default to Ahrefs for the data depth; full-stack marketers default to Semrush for the integrated workflow."},
    {"q":"How does AI improve outreach response rates?","a":"3 ways: (1) personalization at scale (LLM drafts a custom intro paragraph per prospect referencing their recent content); (2) sequence optimization (AI predicts the right follow-up cadence per prospect); (3) negative-response classification (auto-removes uninterested prospects from sequences). Combined, AI-augmented outreach typically lifts response rates 2 to 3x vs templated outreach."}
  ]'::jsonb, 'marketing', 'intermediate', 4400,
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
