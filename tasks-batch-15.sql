-- Phase 3 batch 7 of Task Taxonomy initiative (S129)
-- 37 mid-tail tasks pushing 411 -> 448 tasks (Phase 3 progress 89.6% of 500-target).
-- Coverage: dev (+4), finance (+4), design (+4), sales (+4), hr-recruiting (+4), ops (+3),
-- marketing (+3), research (+2), customer-success (+3), productivity (+3), data-analytics (+3).
-- 7 of these were pre-identified Gate B fails from S125-S128 unblocked by S129 tier 19 backfill.
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Defensive on apostrophes/contractions/em-dashes/quoted-speech in JSON.
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === DEV (4) ===

-- 1. ai-for-feature-flags (UNBLOCKED by tier 19)
(
  'ai-for-feature-flags', 'AI for Feature Flags', '🚩',
  ARRAY['code-ai'], ARRAY['launchdarkly','statsig','optimizely'], 3,
  'Feature flag platforms decouple code deploys from feature releases by wrapping risky changes in runtime configuration. AI-augmented feature management now suggests segment targeting from behavioral data, auto-detects bad rollouts via anomaly detection on production metrics, and recommends experiment designs that meet statistical power requirements. LaunchDarkly leads enterprise feature management with deep governance; Statsig pairs flags with built-in product analytics and experimentation; Optimizely combines a veteran experimentation platform with content management for marketing teams.',
  'We weighted: SDK breadth and evaluation latency, governance depth (audit logs, RBAC), built-in experimentation rigor, and integration with Slack, Jira, and CI/CD pipelines.',
  '[
    {"q":"Do small teams need a feature flag platform?","a":"For teams under 10 engineers, environment variables or simple config files cover most use cases. Once the team is shipping multiple features per week with overlapping rollout schedules, a dedicated platform pays for itself by preventing config drift and enabling targeted rollouts. The Statsig free tier (1 million events per month) covers most early-stage SaaS without paid commitment."},
    {"q":"LaunchDarkly vs Statsig vs Optimizely?","a":"LaunchDarkly suits regulated industries needing enterprise governance; Statsig suits product-led teams wanting unified analytics plus flags; Optimizely suits marketing teams needing experimentation tied to content management. Most engineering-led B2B teams pick LaunchDarkly or Statsig; legacy enterprise marketing departments tend Optimizely."},
    {"q":"How does AI accelerate feature flag work?","a":"3 ways: (1) anomaly detection on production metrics auto-rolls back flags that hurt key indicators; (2) segment recommendation surfaces user cohorts likely to respond differently to a feature; (3) automated guardrails flag flag values that conflict with active experiments. The AI layer turns flags from manual config to self-correcting infrastructure."}
  ]'::jsonb, 'dev', 'intermediate', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-database-migrations (UNBLOCKED by tier 19)
(
  'ai-for-database-migrations', 'AI for Database Migrations', '🗄️',
  ARRAY['code-ai'], ARRAY['planetscale','neon','supabase'], 3,
  'Database migrations move schema and data from one state to another (adding columns, splitting tables, switching engines) without downtime or data loss. AI-augmented migration platforms now generate safe migration plans from schema diffs, predict query performance impact before deploy, and automate rollback paths if production metrics regress. PlanetScale brings Git-style branching to MySQL via Vitess; Neon delivers serverless Postgres with branching plus pgvector; Supabase wraps Postgres with auth, storage, and realtime in an open-source platform.',
  'Selection prioritized: zero-downtime schema change support, branching workflow quality, AI-assisted migration plan generation, and Postgres or MySQL extension ecosystem depth.',
  '[
    {"q":"PlanetScale vs Neon vs Supabase?","a":"PlanetScale is MySQL serverless with Vitess sharding (best for MySQL shops needing scale); Neon is Postgres serverless with scale-to-zero and pgvector (best for AI startups); Supabase is Postgres with batteries-included BaaS layer (best for full-stack apps wanting auth and realtime out of the box). Stack preference and feature breadth typically drive choice."},
    {"q":"How do migrations stay safe in production?","a":"Three pillars: (1) branching environments mirror production schema, (2) deploy requests run automated checks for breaking changes before merge, (3) zero-downtime online schema change tools (gh-ost, pt-osc, Vitess) execute the migration without locking tables. Modern platforms bundle all three so engineers ship without waking the on-call."},
    {"q":"When should we adopt branching workflow?","a":"Once the team passes 5 engineers shipping schema changes per month, branching prevents collision between concurrent migrations. Below that, a single dev database plus careful staging is enough. The branching paradigm matters most for teams running multiple feature branches against the same data shape."}
  ]'::jsonb, 'dev', 'advanced', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-serverless-functions
(
  'ai-for-serverless-functions', 'AI for Serverless Functions', '⚡',
  ARRAY['code-ai'], ARRAY['vercel','netlify','supabase','neon'], 3,
  'Serverless functions run backend code without managing servers, scaling to zero when idle and up to thousands of invocations per second on demand. AI-augmented serverless platforms now generate function code from natural language prompts, auto-tune memory and timeout settings based on observed traffic, and surface cold-start regressions before users notice. Vercel and Netlify lead frontend-cloud serverless with edge runtimes; Supabase brings Edge Functions tightly coupled to Postgres; Neon enables Postgres-backed serverless via scale-to-zero compute branches.',
  'We weighted: cold-start latency, edge-runtime support, integration with the framework ecosystem (Next.js, SvelteKit, Astro), and observability built in.',
  '[
    {"q":"Vercel vs Netlify vs Supabase Edge Functions?","a":"Vercel suits Next.js shops wanting tight framework integration plus edge runtime; Netlify suits framework-agnostic Jamstack teams (Astro, Hugo, Eleventy); Supabase Edge Functions suit teams already using Supabase Postgres for tight backend-database coupling. Most modern web stacks pick one of the first two for the frontend cloud and add Supabase Edge for database-heavy server logic."},
    {"q":"What workloads belong on serverless functions?","a":"Best fit: API endpoints with bursty traffic, webhooks from third-party services, scheduled background jobs, and per-request data fetching for SSR. Avoid: long-running batch jobs (>15 min timeout), CPU-bound ML inference (use dedicated GPU), and stateful workflows (use Temporal or similar). Cold starts hurt latency-critical paths under 100ms."},
    {"q":"How does the edge runtime differ from Node serverless?","a":"Edge runtimes (Vercel Edge, Netlify Edge, Cloudflare Workers) run JavaScript on geographically-distributed PoPs with sub-50ms cold starts but a restricted API surface (no Node-only modules, fewer Node APIs). Node serverless runs in centralized regions with full Node compatibility but 200-1000ms cold starts. Use edge for low-latency public APIs and Node serverless for full-feature backend work."}
  ]'::jsonb, 'dev', 'intermediate', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-build-pipelines
(
  'ai-for-build-pipelines', 'AI for Build Pipelines', '🔧',
  ARRAY['code-ai'], ARRAY['vercel','netlify','railway'], 3,
  'Build pipelines compile, test, and deploy application code from Git push to production URL, automating what used to require dedicated DevOps engineering. AI-augmented build platforms now diagnose failed builds with explanations, optimize cache strategies based on file-change patterns, and predict build duration so engineers know when to wait or work elsewhere. Vercel pioneered Git-connected preview deployments per PR; Netlify popularized branch deploys with form handling; Railway extends Git deploys to backend services with one-click Postgres and Redis attachments.',
  'Selection prioritized: deploy speed, cache hit rate on incremental builds, preview deployment quality, and integration with GitHub PR workflows.',
  '[
    {"q":"Why use a build platform over GitHub Actions?","a":"GitHub Actions is generic CI/CD that runs anything; Vercel/Netlify/Railway are opinionated build platforms that handle the deploy primitive (CDN propagation, domain routing, environment variables, rollback) end to end. For static sites, frontend apps, and small backend services, the integrated build platform saves weeks of CI/CD setup and ongoing maintenance. Complex monorepos with custom deploy targets often still need GitHub Actions in addition."},
    {"q":"What changed with Git-connected preview deployments?","a":"Before preview deploys, code review meant reading diffs in GitHub and trusting the PR description. With preview URLs (Vercel pioneered this), every PR gets a live URL of the proposed change running in production-like infrastructure. Designers and PMs review the actual UX, QA tests the functionality, and bugs surface 80 percent earlier. This is now table stakes for modern frontend workflows."},
    {"q":"How does AI improve build pipeline velocity?","a":"3 ways: (1) build-failure explanation (AI parses error logs and surfaces root cause in plain English), (2) intelligent caching (AI detects which files actually need rebuilding vs full reinstall), (3) test selection (AI runs only tests likely affected by changed code). Together these cut average PR-to-deploy time by 30 to 50 percent on mature pipelines."}
  ]'::jsonb, 'dev', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === FINANCE (4) ===

-- 5. ai-for-revenue-recognition (UNBLOCKED by tier 19)
(
  'ai-for-revenue-recognition', 'AI for Revenue Recognition', '📊',
  ARRAY['finance'], ARRAY['chargebee','baremetrics','chartmogul'], 3,
  'Revenue recognition translates contract terms into the revenue numbers reported on financial statements, applying ASC 606 rules for SaaS subscriptions, multi-element arrangements, and milestone-based contracts. AI-augmented RevRec platforms now classify contracts automatically, generate journal entries for recurring revenue, and detect deferred revenue mismatches before audit. Chargebee leads SaaS-billing-plus-RevRec for B2B subscription companies; Baremetrics and ChartMogul deliver subscription analytics and metrics for indie SaaS through mid-market.',
  'We weighted: ASC 606 compliance depth, multi-entity support for global ops, contract data ingestion automation, and integration with Stripe and accounting systems.',
  '[
    {"q":"When does a SaaS company need formal RevRec tooling?","a":"Below 1 million USD ARR, spreadsheets and Stripe reporting cover most needs. Between 1 and 5 million ARR, a subscription analytics tool (Baremetrics or ChartMogul) is enough to track MRR, churn, and basic deferrals. Above 5 million ARR or pre-IPO, dedicated RevRec (Chargebee plus an accounting integration) becomes necessary for ASC 606 compliance and audit readiness."},
    {"q":"What is the difference between subscription analytics and RevRec?","a":"Subscription analytics (Baremetrics, ChartMogul) reports operational metrics: MRR, ARR, churn, expansion, LTV. RevRec (Chargebee, Maxio, NetSuite) translates contracts into GAAP-compliant revenue journal entries for the accounting system. Most companies need both: analytics for the team dashboard, RevRec for the financial close."},
    {"q":"How does AI help with revenue recognition?","a":"3 ways: (1) contract classification (AI parses non-standard contracts and identifies the revenue-recognition treatment), (2) anomaly detection on deferred revenue rollforwards (catches misposted entries before close), (3) close acceleration (AI drafts the journal entries and the accounting team reviews rather than writes from scratch). The AI layer cuts close time by days for SaaS companies past 5 million ARR."}
  ]'::jsonb, 'finance', 'advanced', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 6. ai-for-personal-finance (UNBLOCKED by tier 19)
(
  'ai-for-personal-finance', 'AI for Personal Finance', '💰',
  ARRAY['finance'], ARRAY['copilot-money','monarch-money','rocket-money'], 3,
  'Personal finance apps aggregate bank, credit card, and investment accounts to track spending, build budgets, and surface forgotten subscriptions. AI-augmented personal finance now auto-categorizes transactions with learning that adapts to user corrections, detects recurring subscriptions across accounts, and surfaces unusual spending patterns before they become problems. Copilot Money leads iOS-native polished UX for Apple-platform users; Monarch Money serves cross-platform households needing couples plus shared budgets; Rocket Money owns subscription cancellation and bill negotiation.',
  'Selection prioritized: transaction-categorization accuracy, account aggregation reliability across institutions, household and shared-budget support, and subscription detection quality.',
  '[
    {"q":"Mint shut down - what is the best replacement?","a":"For iOS-and-Mac users wanting premium polish: Copilot Money. For cross-platform households needing shared budgets: Monarch Money. For users with many forgotten subscriptions: Rocket Money. Most former Mint users land on Monarch (closest UX match) or Copilot (better Apple experience) within their first month of switching."},
    {"q":"Are these apps safe with my bank credentials?","a":"All three use Plaid or similar regulated aggregators that hold read-only credentials in encrypted vaults. None of them initiate transfers or change account state. The standard guidance is to enable 2FA on every linked account and treat the personal finance app as a read-only dashboard, not a source of credentials."},
    {"q":"How does AI improve personal finance management?","a":"3 ways: (1) transaction auto-categorization learns from your corrections and stops asking after a few weeks, (2) subscription detection finds recurring charges hidden across credit cards, (3) cash-flow forecasting predicts low-balance moments before they happen. Together these cut weekly budget review time from 30 minutes to under 5."}
  ]'::jsonb, 'finance', 'beginner', 5400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-payroll-automation
(
  'ai-for-payroll-automation', 'AI for Payroll Automation', '💼',
  ARRAY['finance'], ARRAY['rippling','gusto','bamboohr'], 3,
  'Payroll automation handles wage calculation, tax withholding, benefits deductions, and direct deposit so finance teams stop running the payroll process by hand. AI-augmented payroll platforms now classify worker types automatically, detect anomalies in time-tracking data, and reconcile payroll-to-general-ledger journal entries without manual cross-checking. Rippling delivers the most integrated payroll-plus-IT-plus-HR platform with global coverage; Gusto leads small-business payroll with the cleanest setup experience; BambooHR pairs payroll with the strongest mid-market HR information system.',
  'We weighted: multi-state and global tax coverage, integration with time-tracking and accounting, benefits administration depth, and compliance audit-trail completeness.',
  '[
    {"q":"Rippling vs Gusto vs BambooHR for payroll?","a":"Rippling suits 50 to 500 employee companies wanting one platform for IT, HR, and payroll plus global expansion; Gusto suits 5 to 100 employee US-only businesses wanting simple setup and good service; BambooHR suits 50 to 1000 employee teams prioritizing the HR system with payroll bundled. Most growth-stage startups start with Gusto and migrate to Rippling at 100 employees."},
    {"q":"How does AI cut payroll close time?","a":"3 ways: (1) automatic time-tracking validation flags hours that look wrong before they hit gross pay, (2) classification engines distinguish W-2 vs 1099 vs international contractor automatically, (3) GL reconciliation maps payroll output to chart-of-accounts entries with audit-ready logs. The AI layer cuts a 4-hour close to under 30 minutes for mid-market teams."},
    {"q":"What about international payroll?","a":"For companies hiring in 5+ countries, dedicated employer-of-record (EOR) platforms (Deel, Remote, Velocity Global) handle the legal entity and tax compliance. Rippling has built-in EOR through Rippling Global; Gusto has limited international support; BambooHR partners with EORs rather than handling natively. The EOR plus US payroll combo is the typical stack at the 30-employee international threshold."}
  ]'::jsonb, 'finance', 'intermediate', 2900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 8. ai-for-expense-management
(
  'ai-for-expense-management', 'AI for Expense Management', '🧾',
  ARRAY['finance'], ARRAY['ramp','brex','airbase','tipalti'], 3,
  'Expense management platforms issue corporate cards, capture receipts, route approvals, and post journal entries to the accounting system without manual data entry. AI-augmented expense platforms now auto-categorize expenses from receipt OCR, detect policy violations before submission, and surface savings opportunities by analyzing vendor spend patterns. Ramp leads spend management with built-in savings recommendations and 1.5 percent universal cashback; Brex serves venture-backed startups with the cleanest mobile experience; Airbase combines cards, AP, and reimbursements; Tipalti owns the global mass-payments and AP automation niche.',
  'Selection prioritized: receipt OCR accuracy, policy enforcement granularity, accounting system integration, and global card and payment support.',
  '[
    {"q":"Ramp vs Brex vs Airbase?","a":"Ramp leads on cost savings (free tier plus universal cashback plus AI-driven savings recommendations); Brex leads on UX and venture-startup features; Airbase serves teams that need cards plus AP plus reimbursements in one platform. Most early-stage startups pick Brex; mid-market companies optimizing for cost pick Ramp; finance teams wanting unified spend management pick Airbase."},
    {"q":"What does AI add over receipt OCR?","a":"3 layers beyond OCR: (1) policy auto-enforcement (the system blocks non-compliant expenses at submission rather than rejecting after approval), (2) vendor spend analysis (AI clusters vendors and surfaces consolidation savings), (3) anomaly detection on expense patterns (catches duplicate submissions and unusual amounts before they hit GL). Receipt OCR is now table stakes; AI policy and analytics are the differentiator."},
    {"q":"When does a startup need expense software vs Stripe Issuing?","a":"Below 10 employees, founders often issue cards via Stripe Issuing or just use personal cards with reimbursement. Above 20 employees, dedicated expense software (Brex or Ramp free tier) saves the founder dozens of hours of monthly receipt chasing. Above 100 employees, Airbase or full Ramp Plus tier with policy enforcement and AP automation typically replaces the simple card model."}
  ]'::jsonb, 'finance', 'intermediate', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (4) ===

-- 9. ai-for-brand-asset-management (UNBLOCKED by tier 19)
(
  'ai-for-brand-asset-management', 'AI for Brand Asset Management', '🎨',
  ARRAY['marketing'], ARRAY['frontify','brandfolder','bynder'], 3,
  'Brand asset management platforms (DAMs) centralize logos, color palettes, photography, video, and templates so distributed teams pull approved assets rather than recreating them. AI-augmented DAMs now auto-tag visual content based on subject and style, surface asset performance analytics across channels, and enforce brand guidelines on user-generated content. Frontify pairs DAM with brand-portal and creative-collaboration; Brandfolder leads on AI-powered tagging and ecommerce platform integrations; Bynder owns enterprise governance for global brands.',
  'We weighted: AI-tagging accuracy, brand-guidelines distribution, asset analytics depth, and governance features for global multi-region rollouts.',
  '[
    {"q":"Frontify vs Brandfolder vs Bynder?","a":"Frontify suits mid-market brands wanting brand portal plus DAM in one cleaner UX; Brandfolder suits ecommerce and consumer brands needing AI-powered analytics with Smartsheet ecosystem; Bynder suits global enterprise brands needing deepest governance and regional asset variants. Most enterprise DAM RFPs end with one of these three after Adobe Experience Manager is eliminated on cost."},
    {"q":"When does a company need a real DAM vs Dropbox?","a":"Under 20 brand stakeholders, a Dropbox or Google Drive folder structure with naming conventions covers most needs. Above that, version drift, partner-distribution friction, and brand-compliance gaps drive the move to a dedicated DAM. The 100K USD plus annual marketing spend threshold typically signals readiness."},
    {"q":"How does AI tagging improve asset retrieval?","a":"Manual tagging is the failure point of every DAM (someone has to do it, and they stop after the first 200 assets). AI tagging analyzes image content, brand colors, and style attributes automatically so retrieval works on what an asset actually looks like rather than what someone remembered to tag. Retrieval time drops from minutes to seconds for catalogs of 1000 plus assets."}
  ]'::jsonb, 'design', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-design-handoff
(
  'ai-for-design-handoff', 'AI for Design Handoff', '🤝',
  ARRAY['marketing'], ARRAY['frontify','brandfolder','penpot'], 3,
  'Design handoff is the moment a designer ships specs to engineering: colors, spacing, font sizes, asset exports, and interaction notes that engineers turn into production code. AI-augmented handoff tools now generate component code from design files, auto-document design tokens for the design system, and surface inconsistencies between Figma artboards and the live product. Frontify and Brandfolder serve as the brand-asset distribution layer in the handoff workflow; Penpot delivers an open-source design tool with built-in handoff specs.',
  'Selection prioritized: token export quality, code-generation fidelity, integration with the design system source of truth, and asset distribution to engineering teams.',
  '[
    {"q":"What does AI add to design handoff?","a":"3 capabilities: (1) component code generation from design layers (90 percent of CSS done before the engineer opens the file), (2) design-system drift detection (AI flags artboards that depart from token-defined components), (3) automated documentation of design tokens for the codebase. Handoff time drops from hours to minutes per screen."},
    {"q":"Penpot vs commercial design tools?","a":"Penpot is open-source (free, self-hostable) with a Figma-like canvas and built-in handoff specs; commercial tools (Figma, Sketch) have larger plugin ecosystems and more polished UX. Teams locked into open-source stacks (regulated industries, EU-compliance-focused, or cost-sensitive) pick Penpot; teams already on Figma stay there because of plugin and workflow inertia."},
    {"q":"How do brand asset platforms fit handoff?","a":"DAMs (Frontify, Brandfolder) sit in handoff as the source of truth for logos, photography, illustrations, and brand-template assets. Designers pull from the DAM into the design tool; engineering pulls from the DAM into production code via API. The DAM ensures both surfaces show the latest approved version of every brand asset."}
  ]'::jsonb, 'design', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 11. ai-for-creative-collaboration
(
  'ai-for-creative-collaboration', 'AI for Creative Collaboration', '🎬',
  ARRAY['marketing'], ARRAY['frontify','brandfolder','bynder','penpot'], 3,
  'Creative collaboration tools coordinate the multi-step process of taking a brief through concept, design, review, approval, and publish without the back-and-forth living in disconnected email threads. AI-augmented creative platforms now route review requests intelligently based on stakeholder availability, summarize feedback into actionable change lists, and detect when a creative asset matches an approved brand template. Frontify pairs collaboration with brand portal; Brandfolder centralizes feedback within the DAM; Bynder offers enterprise creative workflow modules; Penpot delivers open-source design canvas with shared workspaces.',
  'We weighted: review and approval workflow flexibility, comment-thread organization, integration with design tools and DAM, and stakeholder-permissions granularity.',
  '[
    {"q":"Why do design teams adopt dedicated creative collaboration tools?","a":"The default review flow (email PDFs, Slack screenshots, sticky notes on prints) breaks down at 4+ stakeholders or 10+ active creative projects. Dedicated platforms preserve feedback context, version history, and approval state in one canvas so teams know what was changed when and why."},
    {"q":"What does AI add to creative review?","a":"3 capabilities: (1) feedback summarization (AI rolls 30 comments into a 5-bullet change list), (2) brand-compliance auto-check (AI flags assets that violate brand guidelines before review), (3) routing intelligence (AI suggests which reviewer to ping based on past responsiveness and expertise). Review cycle time drops from 5 to 2 days for typical campaign assets."},
    {"q":"Should we use a DAM as the collaboration tool too?","a":"For mid-market brands, yes (Frontify, Brandfolder, and Bynder all bundle creative collaboration into the DAM). For enterprise teams with 100+ active creative projects, a dedicated tool (Workfront, Lytho, Inmotion Now) plus the DAM as asset library typically scales better. The split happens around the 50-marketer-plus-agency threshold."}
  ]'::jsonb, 'design', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 12. ai-for-design-feedback
(
  'ai-for-design-feedback', 'AI for Design Feedback', '💭',
  ARRAY['marketing'], ARRAY['frontify','brandfolder','penpot'], 3,
  'Design feedback turns stakeholder reactions (love this, change that, this looks off) into specific change instructions a designer can act on without three rounds of clarification. AI-augmented feedback tools now classify comments by urgency and type, summarize free-text responses into structured change requests, and surface conflicting feedback between stakeholders before designers go heads-down. Frontify and Brandfolder host structured comment threads tied to assets; Penpot brings collaborative feedback into the open-source design canvas.',
  'Selection prioritized: comment-threading clarity, AI summarization quality, conflict-detection between stakeholders, and integration with the asset version history.',
  '[
    {"q":"What makes design feedback hard to scale?","a":"3 failure modes: (1) ambiguous wording (make it pop is not actionable), (2) conflicting stakeholder requests (CEO and PM ask for opposite changes), (3) feedback fragmentation across Slack, email, and the design tool. Dedicated platforms force structured feedback tied to specific layers and surface conflicts before designers spend hours on contradictory edits."},
    {"q":"How does AI improve feedback quality?","a":"3 ways: (1) AI classifies free-text comments into change-request categories (color, copy, layout, scope), (2) AI summarizes 20-comment threads into the 3 actionable changes that matter, (3) AI flags vague comments and prompts the reviewer to be more specific. The result is fewer redo cycles and faster sign-off."},
    {"q":"Are these tools worth it for solo designers?","a":"For freelancers managing 1 to 3 clients at a time, free Loom recordings and Figma comments cover most needs. Above that, structured platforms pay for themselves by preventing scope creep and giving the designer a clear paper trail when a stakeholder claims they did not approve a version."}
  ]'::jsonb, 'design', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SALES (4) ===

-- 13. ai-for-buyer-intent (UNBLOCKED by tier 19)
(
  'ai-for-buyer-intent', 'AI for Buyer Intent', '🎯',
  ARRAY['sales'], ARRAY['6sense','demandbase','clearbit','apollo'], 3,
  'Buyer intent platforms aggregate third-party signals (research activity, content consumption, technographic changes) to identify which target accounts are actively in-market for a category. AI-augmented intent platforms now blend first-party engagement with third-party signals, score account-fit-times-intent, and surface buyer-personas-engaged so sales reps know who to call and what to say. 6sense and Demandbase lead enterprise B2B intent platforms; Clearbit (now HubSpot Breeze) brings real-time enrichment plus reveal; Apollo combines intent with the largest contact database for outbound prospecting.',
  'We weighted: intent-signal quality and refresh frequency, account-fit scoring rigor, contact-data freshness, and integration with the CRM workflow.',
  '[
    {"q":"6sense vs Demandbase vs Clearbit vs Apollo?","a":"6sense leads on intent depth and predictive scoring for ABM; Demandbase leads on B2B advertising activation tied to intent; Clearbit (HubSpot) leads on real-time enrichment for inbound funnels; Apollo leads on contact database breadth for outbound prospecting. Most enterprise B2B teams run 6sense or Demandbase plus Apollo in tandem; mid-market often picks Apollo alone or HubSpot Breeze."},
    {"q":"What is the difference between intent data and prospecting data?","a":"Prospecting data (Apollo, ZoomInfo) tells you who works where and how to reach them. Intent data (6sense, Demandbase, G2 Buyer Intent) tells you which of those accounts are in-market right now. Combined, the rep calls the right person at the right account at the right moment. Either alone gives only half the picture."},
    {"q":"How accurate is third-party intent data?","a":"At account level, top platforms claim 70 to 85 percent precision on in-market accounts, validated against post-purchase analysis. At individual buyer level, accuracy drops to 30 to 50 percent (intent platforms know an account is researching, not necessarily who at the account). The buying-team-level signal (which personas are engaged) is the more reliable middle ground."}
  ]'::jsonb, 'sales', 'advanced', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-sales-compensation (UNBLOCKED by tier 19)
(
  'ai-for-sales-compensation', 'AI for Sales Compensation', '💵',
  ARRAY['sales'], ARRAY['captivateiq','spiff','salesforce-einstein'], 3,
  'Sales compensation platforms calculate commissions across complex plans (accelerators, kickers, splits, draws, clawbacks) and pay reps without spreadsheet sprawl. AI-augmented comp platforms now model plan changes against historical performance, detect plan-effectiveness drift, and surface dispute patterns before they become widespread complaints. CaptivateIQ leads platform-agnostic no-code commission design; Spiff (now Salesforce) delivers Salesforce-native compensation; Salesforce Einstein adds AI forecasting and quota recommendations across the Sales Cloud stack.',
  'Selection prioritized: plan-design flexibility, real-time payout transparency for reps, integration with CRM source-of-truth data, and analytics on plan effectiveness.',
  '[
    {"q":"CaptivateIQ vs Spiff vs Xactly?","a":"CaptivateIQ suits platform-agnostic teams (HubSpot, Pipedrive, multi-system) wanting strongest no-code formula builder; Spiff suits Salesforce-centric teams wanting native integration post-acquisition; Xactly is the legacy enterprise option for very large salesforces. Most modern mid-market teams pick CaptivateIQ; Salesforce-heavy enterprises post-2024 default to Spiff."},
    {"q":"What does AI improve in compensation work?","a":"3 ways: (1) plan modeling (AI simulates proposed plan changes against last-quarter deal data and predicts rep behavior), (2) dispute detection (AI flags reps whose calculated comp diverges from forecast and surfaces root cause), (3) quota recommendation (Einstein and similar tools propose reasonable quotas based on territory potential plus historical attainment). Plan tweaks happen monthly rather than quarterly."},
    {"q":"How big does the team need to be to need a comp tool?","a":"Below 10 quota-carriers, a well-built spreadsheet with version control suffices. Between 10 and 30, complexity grows enough that a dedicated tool prevents disputes and saves RevOps days of monthly close work. Above 30, the calculation complexity, plan variations across roles, and audit-trail requirements make dedicated comp software essential."}
  ]'::jsonb, 'sales', 'advanced', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 15. ai-for-account-based-marketing
(
  'ai-for-account-based-marketing', 'AI for Account-Based Marketing', '🏢',
  ARRAY['sales'], ARRAY['6sense','demandbase','clearbit','apollo'], 3,
  'Account-based marketing (ABM) flips the traditional lead funnel by treating target accounts as markets of one and orchestrating personalized campaigns across sales, marketing, and customer success. AI-augmented ABM platforms now identify target accounts from intent signals, personalize advertising at the account level, and coordinate sales-marketing plays so reps and marketers stop tripping over each other. 6sense and Demandbase lead enterprise ABM platforms with intent and advertising; Clearbit enables ABM enrichment for HubSpot stacks; Apollo combines ABM with prospecting at lower price points for mid-market teams.',
  'We weighted: target-account scoring accuracy, advertising-activation breadth, sales-marketing alignment features, and integration with the CRM and marketing automation stack.',
  '[
    {"q":"How does ABM differ from inbound marketing?","a":"Inbound marketing casts a wide net (SEO, content, demand gen) and waits for fit accounts to surface themselves. ABM picks 100 to 500 target accounts upfront and orchestrates personalized outreach across channels (ads, email, sales touches, executive sponsorship). Most B2B teams above 50 employees run both: inbound for top-of-funnel, ABM for high-value enterprise targets."},
    {"q":"6sense vs Demandbase for ABM specifically?","a":"6sense leads on intent-data depth (knows which accounts are researching what topics) and predictive scoring (which accounts will buy next 90 days). Demandbase leads on advertising activation (programmatic ads targeted to specific accounts based on intent). Most enterprise teams running large ABM programs evaluate both; smaller mid-market often picks one for both functions."},
    {"q":"What does AI add to ABM execution?","a":"3 layers: (1) target-account selection (AI identifies high-fit, high-intent accounts beyond what humans would pick), (2) message personalization (AI drafts account-specific outreach based on the account research history), (3) play orchestration (AI suggests next-best-action across channels for each account). Manual ABM works at 100 accounts; AI-driven ABM scales to 5000."}
  ]'::jsonb, 'sales', 'advanced', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 16. ai-for-call-recording-analysis
(
  'ai-for-call-recording-analysis', 'AI for Call Recording Analysis', '📞',
  ARRAY['sales'], ARRAY['gong-io','modjo','avoma','laxis'], 3,
  'Call recording analysis turns sales conversations into structured data: who spoke when, what objections came up, which competitors got mentioned, and which deals are at risk based on language patterns. AI-augmented call analysis now scores deal health from conversation signals, surfaces best practices across the team, and auto-fills CRM fields from call content. Gong leads enterprise revenue-intelligence; Modjo serves European mid-market with multi-language strength; Avoma combines meeting assistant plus revenue analytics; Laxis brings AI meeting note-taking with a sales-focused angle.',
  'Selection prioritized: transcription accuracy across accents and noisy environments, deal-risk-detection rigor, CRM auto-fill quality, and integration with the dialer or video stack.',
  '[
    {"q":"Gong vs Modjo vs Avoma vs Laxis?","a":"Gong is the enterprise standard with strongest deal-intelligence depth; Modjo suits European multi-language sales teams; Avoma blends meeting assistant utility with sales analytics; Laxis is a meeting AI that recently added sales-coaching features. Most enterprise sales teams running 30+ AEs pick Gong; smaller teams pick Avoma or Laxis for the price-feature balance."},
    {"q":"What deal-risk signals does AI catch?","a":"4 high-signal patterns: (1) decreasing prospect talk-time across calls (engagement dropping), (2) competitor mentions late in cycle (deal at risk of switch), (3) introduction of new stakeholders without warning (deal complexity rising), (4) shift from feature to price discussion (deal value at risk). Manual review catches some; AI catches all consistently across thousands of calls."},
    {"q":"Do reps resist call recording?","a":"Pushback is common in initial rollout but typically fades within 4 to 8 weeks once reps see the coaching benefit and AI-driven CRM auto-fill saves them admin time. Best-practice rollouts emphasize coaching-not-surveillance positioning, give reps access to their own conversation library, and tie call review to deal-strategy sessions rather than performance reviews."}
  ]'::jsonb, 'sales', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === HR-RECRUITING (4) ===

-- 17. ai-for-applicant-tracking
(
  'ai-for-applicant-tracking', 'AI for Applicant Tracking', '📋',
  ARRAY['marketing'], ARRAY['lever','greenhouse','ashby','eightfold'], 3,
  'Applicant tracking systems (ATS) manage the full hiring funnel from job posting through offer accept: candidate sourcing, scheduling, scorecards, and offer letters. AI-augmented ATS platforms now resume-screen at scale, surface high-fit candidates from the existing database, and auto-coordinate interview logistics across timezones. Lever pioneered the modern recruiting CRM with sourcing-plus-pipeline; Greenhouse leads structured hiring with scorecard rigor; Ashby brings analytics-first ATS with integrated sourcing; Eightfold uses AI matching against career trajectory data.',
  'We weighted: candidate-sourcing depth, structured-interview scorecard quality, AI matching accuracy, and analytics on funnel health and DEI signals.',
  '[
    {"q":"Lever vs Greenhouse vs Ashby vs Eightfold?","a":"Lever suits fast-growing startups wanting recruiting-CRM-plus-ATS in one; Greenhouse is the structured-hiring standard for mid-market and enterprise; Ashby is the modern analytics-heavy ATS that growth-stage companies increasingly pick; Eightfold leads talent-intelligence with AI matching against millions of profiles. Most Series A through C startups land on Greenhouse or Ashby."},
    {"q":"What does AI add over a basic ATS?","a":"3 capabilities: (1) resume screening at scale (AI ranks 500 applicants on fit signals so recruiters skip the obvious-no pile), (2) silver-medalist mining (AI surfaces past candidates from the database who fit a new opening), (3) interview-loop optimization (AI suggests panel composition based on past hiring outcomes). The AI layer cuts time-to-hire by 20 to 40 percent on high-volume roles."},
    {"q":"How does AI handle DEI in screening?","a":"Modern ATS platforms ship guardrails: redacting demographic information during screening, auditing AI-suggested rejections for adverse-impact patterns, and surfacing pipeline-diversity dashboards by stage. The risk of biased AI ranking is real but well-known; vendors that ignore it face regulatory scrutiny under emerging AI-hiring laws (NYC 144, EU AI Act). Best practice is to use AI for ranking suggestions and keep human decision authority on every reject."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 2900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 18. ai-for-hiring-pipeline
(
  'ai-for-hiring-pipeline', 'AI for Hiring Pipeline', '🔄',
  ARRAY['marketing'], ARRAY['lever','greenhouse','ashby','beamery'], 3,
  'Hiring pipeline tools manage the journey of candidates through stages (sourced, screened, interviewed, offered, hired) and surface where the funnel is leaking. AI-augmented pipeline platforms now predict drop-off probability per stage, recommend sourcing channels based on historical conversion, and surface time-to-hire bottlenecks before they hurt quarterly hiring goals. Lever and Greenhouse track pipeline within their broader ATS; Ashby leads with analytics-first pipeline reporting; Beamery delivers talent-CRM with strongest top-of-funnel sourcing pipeline.',
  'Selection prioritized: pipeline-stage configurability, conversion-rate analytics, time-in-stage tracking, and integration with sourcing channels.',
  '[
    {"q":"How does AI improve pipeline conversion?","a":"3 ways: (1) drop-off prediction (AI flags candidates likely to disengage based on response patterns), (2) sourcing-channel ROI (AI ranks LinkedIn vs employee referrals vs job boards by conversion at this company), (3) interview-stage time-management (AI surfaces stages where candidates wait too long). Pipeline conversion improves 10 to 25 percent on average within 6 months of AI-driven pipeline tooling."},
    {"q":"Beamery vs traditional ATS for pipeline?","a":"Beamery is talent-CRM-first (strongest at sourcing pipeline and nurture) with a lighter ATS layer; Greenhouse and Ashby are ATS-first (strongest at structured interview pipeline). Most enterprise teams run both: Beamery for top-of-funnel sourcing, Greenhouse or Ashby for the structured pipeline once a candidate is in interview process."},
    {"q":"What pipeline metrics matter most?","a":"4 core metrics: time-to-hire by role, drop-off rate per stage, source-of-hire conversion, and offer-accept rate. Above the team-of-50-recruiters threshold, add interviewer-load-balance, gender and ethnicity progression by stage, and rejection-reason taxonomy. The first 4 cover most decisions; the latter add depth for mature recruiting orgs."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 19. ai-for-recruiting-analytics
(
  'ai-for-recruiting-analytics', 'AI for Recruiting Analytics', '📊',
  ARRAY['analytics'], ARRAY['eightfold','beamery','lever','greenhouse'], 3,
  'Recruiting analytics turns hiring data (sourcing channels, pipeline funnels, time-to-hire, DEI indicators) into the dashboards that head-of-talent presents to the executive team. AI-augmented analytics now forecast hiring capacity, predict which open roles will close on time, and surface anomalies in funnel health that humans would miss. Eightfold leads talent-intelligence with strongest AI-driven analytics; Beamery brings sourcing-heavy analytics; Lever and Greenhouse provide ATS-native analytics that cover most growth-stage needs.',
  'We weighted: dashboard customization depth, predictive-forecast accuracy, DEI reporting rigor, and integration with the rest of the people stack.',
  '[
    {"q":"What recruiting analytics does the executive team care about?","a":"5 metrics typically reach the C-suite: time-to-fill (vs target), cost-per-hire, quality-of-hire (90-day retention), pipeline coverage ratio (open roles to active candidates), and DEI progression by stage. Below the executive level, recruiters track granular funnel metrics and channel ROI."},
    {"q":"How does AI improve recruiting forecasts?","a":"3 ways: (1) hiring-capacity forecast (AI predicts how many roles a recruiter can close based on past performance and pipeline state), (2) time-to-fill prediction per role (AI estimates date of close for each open req), (3) drop-off prediction at each stage. Forecasts that used to be wrong by 50 percent become wrong by 15 percent on mature data."},
    {"q":"Eightfold vs ATS-native analytics?","a":"Eightfold sits above the ATS as a talent-intelligence layer with deeper AI matching against external profiles and stronger forecasting; ATS-native analytics (Greenhouse Reporting, Ashby) cover the within-ATS funnel well but lack the external-talent-pool angle. Most companies under 500 hires per year stay with ATS-native; above that threshold Eightfold tends to win."}
  ]'::jsonb, 'hr-recruiting', 'advanced', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 20. ai-for-candidate-experience
(
  'ai-for-candidate-experience', 'AI for Candidate Experience', '🤝',
  ARRAY['marketing'], ARRAY['lever','greenhouse','ashby','beamery'], 3,
  'Candidate experience covers every touchpoint a job seeker has with a company: career site, application form, interview scheduling, follow-up emails, and rejection letters. AI-augmented experience tools now personalize career sites by visitor signals, automate scheduling without back-and-forth emails, and craft empathetic rejection letters that preserve future-pipeline relationships. Lever, Greenhouse, Ashby, and Beamery all bundle candidate-experience features as part of their broader recruiting platforms.',
  'Selection prioritized: branded career-site quality, scheduling automation, communication tone and quality, and feedback collection on candidate sentiment.',
  '[
    {"q":"Why does candidate experience matter to recruiting outcomes?","a":"3 hard returns: (1) employer-brand reputation (sites like Glassdoor amplify bad experiences), (2) silver-medalist re-engagement (rejected candidates apply again 30 to 50 percent more often after positive experience), (3) referral pipelines (candidates who had good experience refer others). Companies investing in candidate experience see 20 to 40 percent higher quality-of-hire and 2x referral pipeline."},
    {"q":"What does AI add to candidate communication?","a":"3 ways: (1) personalized career-site content based on visitor profile, (2) interview-scheduling automation (no more 5-email back-and-forth), (3) empathetic rejection-letter drafting with role-specific language. Together these reduce rejected-candidate negative-sentiment scores by 30 to 50 percent."},
    {"q":"How is candidate experience measured?","a":"3 standard metrics: NPS at offer-accept and rejection stages, application-completion rate (people who finish vs start), and time-to-respond (how quickly the company replies after a candidate action). Top performers measure NPS at every stage and share results with hiring managers monthly."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === OPS (3) ===

-- 21. ai-for-soc2-readiness
(
  'ai-for-soc2-readiness', 'AI for SOC 2 Readiness', '🛡️',
  ARRAY['analytics'], ARRAY['drata','secureframe','vanta'], 3,
  'SOC 2 readiness covers the controls (access management, change management, incident response, vendor risk) that auditors check during the SOC 2 Type 2 audit window. AI-augmented compliance platforms now auto-collect evidence from cloud providers and SaaS apps, flag control gaps before audit, and draft policy documentation tailored to the specific environment. Drata and Vanta lead the compliance-automation category with deep SaaS-app coverage; Secureframe brings strong risk-management plus compliance breadth.',
  'We weighted: integration breadth (auto-evidence collection from AWS, Okta, GitHub, etc), policy-template quality, audit-portal experience, and continuous-monitoring depth.',
  '[
    {"q":"Drata vs Vanta vs Secureframe?","a":"Drata leads on continuous-monitoring depth and integration breadth (250+ integrations); Vanta is the original compliance-automation platform with strongest SaaS-startup brand; Secureframe matches on integrations with stronger risk-management features. Most modern SaaS companies pick Drata or Vanta; Secureframe wins when compliance-plus-risk-management is the joint priority."},
    {"q":"How long does SOC 2 readiness take with vs without these tools?","a":"Without tooling, a first SOC 2 Type 2 audit takes 6 to 12 months of evidence collection plus policy authoring. With Drata, Vanta, or Secureframe, the readiness phase compresses to 2 to 4 months because evidence flows automatically and policy templates start from day one. The audit fieldwork stays similar (4 to 8 weeks) regardless of tooling."},
    {"q":"Is SOC 2 worth it before enterprise customers ask?","a":"For most B2B SaaS companies, yes once enterprise contracts begin appearing in pipeline. SOC 2 Type 1 (point-in-time) takes 1 to 2 months and unlocks most mid-market deals; Type 2 (12-month observation period) is required for enterprise. The investment (15K to 50K USD per year for the platform plus 15K to 30K for the auditor) typically pays back on the first 250K USD plus enterprise contract."}
  ]'::jsonb, 'ops', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 22. ai-for-procurement-automation
(
  'ai-for-procurement-automation', 'AI for Procurement Automation', '🛒',
  ARRAY['finance'], ARRAY['ramp','brex','airbase','tipalti'], 3,
  'Procurement automation handles purchase requests, vendor approvals, PO issuance, receipt capture, and AP matching so finance teams stop chasing email approvals and orphaned invoices. AI-augmented procurement platforms now auto-route requests by spend threshold, surface duplicate vendors and overlapping subscriptions, and detect invoice anomalies before payment. Ramp leads spend-management plus AI-driven savings recommendations; Brex offers strong corporate-card-plus-AP integration; Airbase combines cards, AP, and reimbursements; Tipalti owns global mass-payments and supplier onboarding.',
  'Selection prioritized: approval-workflow flexibility, vendor-onboarding rigor, AP automation depth, and integration with NetSuite or QuickBooks.',
  '[
    {"q":"Ramp vs Brex vs Airbase vs Tipalti for procurement?","a":"Ramp leads on cost savings and consolidated card-plus-AP for US-focused mid-market; Brex serves venture-backed startups with cleaner card UX; Airbase is the strongest at procurement workflows (intake forms, approval routing, vendor onboarding) for finance-led mid-market; Tipalti owns global mass-payment and supplier-onboarding for marketplace and ecommerce companies. The choice maps to where the procurement complexity lives."},
    {"q":"How does AI cut procurement cycle time?","a":"3 ways: (1) auto-routing of requests based on spend threshold and category, (2) duplicate-vendor detection (AI flags new requests for vendors already onboarded), (3) invoice-anomaly detection (AI catches duplicate invoices, price changes, and quantity mismatches before payment). Together these cut request-to-PO time from days to hours."},
    {"q":"When does a startup need procurement software?","a":"Below 50 employees, expense management plus shared-vendor-list spreadsheet covers most needs. Above 50, vendor sprawl (50+ active SaaS subscriptions, regional offices, global suppliers) drives the move to dedicated procurement. The 5 million USD annual non-payroll spend threshold typically signals readiness."}
  ]'::jsonb, 'ops', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 23. ai-for-audit-trails
(
  'ai-for-audit-trails', 'AI for Audit Trails', '🔍',
  ARRAY['analytics'], ARRAY['drata','secureframe','vanta','aikido-security'], 3,
  'Audit trails record who did what when across systems (logins, permission changes, data access, configuration edits) so auditors and incident-responders can reconstruct events after the fact. AI-augmented audit platforms now correlate events across SaaS apps, flag anomalous access patterns in real time, and auto-generate evidence packages for compliance audits. Drata, Vanta, and Secureframe ingest audit logs from connected systems for compliance evidence; Aikido Security adds AppSec audit context across code, cloud, and SaaS.',
  'We weighted: log-source coverage, anomaly-detection accuracy, audit-portal evidence-export quality, and retention compliance for regulated industries.',
  '[
    {"q":"Why are audit trails harder than they look?","a":"3 failure modes: (1) log fragmentation (every SaaS app has its own format and retention policy), (2) signal-to-noise (most events are routine; anomalies hide in volume), (3) audit-window matching (auditors ask for evidence from specific dates; pulling from 50 systems takes days). Dedicated platforms solve all three by centralizing, normalizing, and AI-enriching the audit-event stream."},
    {"q":"What does AI add to audit trails?","a":"3 layers: (1) cross-system correlation (a permission change in Okta plus a sensitive-data access in AWS plus an external Slack invite is a higher-priority signal than any one in isolation), (2) anomaly scoring (AI learns user patterns and flags unusual behavior), (3) evidence auto-generation (AI assembles the report auditors ask for from raw audit data). Audit prep time drops from weeks to hours."},
    {"q":"Drata vs Aikido for audit trails?","a":"Drata is compliance-platform-first (strongest at SOC 2, ISO 27001, HIPAA evidence); Aikido is security-platform-first (strongest at AppSec audit context plus cloud and code findings). Most mid-market SaaS companies need both: Drata for the compliance audit trail, Aikido for the security audit trail. They cover different audiences with overlapping data sources."}
  ]'::jsonb, 'ops', 'advanced', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === MARKETING (3) ===

-- 24. ai-for-conversion-rate-optimization
(
  'ai-for-conversion-rate-optimization', 'AI for Conversion Rate Optimization', '📈',
  ARRAY['marketing'], ARRAY['optimizely','statsig','launchdarkly','mixpanel'], 3,
  'Conversion rate optimization (CRO) is the discipline of turning more visitors into customers by running experiments on copy, layout, pricing, and flow. AI-augmented CRO platforms now generate test hypotheses from analytics anomalies, allocate traffic to winning variants automatically via multi-arm bandits, and surface segment-level effects that aggregate-level analysis would miss. Optimizely leads enterprise web experimentation; Statsig pairs flags and experiments with built-in product analytics; LaunchDarkly handles flag-based rollouts with experiment integration; Mixpanel provides the analytics layer that detects what to test next.',
  'Selection prioritized: statistical-engine rigor (false-discovery-rate control), segment analysis depth, experiment-velocity (how many can run concurrently), and integration with the analytics stack.',
  '[
    {"q":"What stack do top CRO teams use?","a":"3 layers: (1) analytics tool (Mixpanel, Amplitude, or PostHog) to identify what to test, (2) experimentation platform (Optimizely, Statsig, LaunchDarkly) to run the test, (3) qualitative tool (Hotjar, FullStory, or Sprig) to understand why the test won or lost. Most mature CRO programs run all three layers."},
    {"q":"How many experiments should we run?","a":"Healthy mid-market e-commerce or SaaS sites run 4 to 12 concurrent experiments at any time, ship 2 to 4 winning variants per month, and review results in a weekly stand-up. Below that volume, the program is under-investing; far above, the team typically lacks rigor on hypothesis quality and false-positive control."},
    {"q":"What does AI add beyond traditional A/B testing?","a":"3 capabilities: (1) hypothesis generation (AI surfaces test ideas from analytics anomalies humans would miss), (2) multi-arm bandit allocation (AI shifts traffic to winning variants in real time rather than waiting for full test completion), (3) segment-effect detection (AI finds which user segments responded differently to the treatment). Velocity goes up 2 to 3x without sacrificing rigor."}
  ]'::jsonb, 'marketing', 'advanced', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 25. ai-for-ab-testing-strategy
(
  'ai-for-ab-testing-strategy', 'AI for A/B Testing Strategy', '🧪',
  ARRAY['marketing'], ARRAY['statsig','launchdarkly','optimizely'], 3,
  'A/B testing strategy covers the upstream questions: what to test, how big a sample is needed, when to stop, and how to read inconclusive results. AI-augmented experimentation platforms now estimate sample sizes from baseline conversion, prevent peeking errors via sequential testing, and detect novelty effects that distort early-stage results. Statsig and LaunchDarkly lead modern experimentation built on flag infrastructure; Optimizely brings the most rigorous Stats Engine for marketing-led web experimentation.',
  'We weighted: statistical-engine rigor, sample-size estimation accuracy, novelty-detection methods, and ease of running experiments outside web (mobile, server-side).',
  '[
    {"q":"How long should an A/B test run?","a":"The honest answer is until the pre-calculated sample size is reached given target effect size and statistical power. Most platforms estimate this upfront from baseline conversion. Running shorter inflates false-positive rate; running longer wastes traffic. A typical mid-market test runs 2 to 4 weeks at 50 percent traffic each variant."},
    {"q":"What is the peeking problem and how do I avoid it?","a":"Peeking is checking results before the planned end of the test and stopping when one variant looks better. This inflates false-positive rate dramatically (5 percent target becomes 20 percent or worse). Modern platforms (Statsig, Optimizely) use sequential testing methods that explicitly correct for peeking. If your platform does not, set a fixed end date and refuse to look until then."},
    {"q":"What test ideas should we prioritize?","a":"3 high-ROI categories: (1) the highest-traffic surface (homepage, signup flow, product detail page), (2) the biggest revenue moment (cart abandonment, pricing page, upgrade flow), (3) anything triggered by analytics anomaly (a sudden drop signals a place to test recovery). Avoid endless button-color tests; they almost never move metrics."}
  ]'::jsonb, 'marketing', 'advanced', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 26. ai-for-personalization-engines
(
  'ai-for-personalization-engines', 'AI for Personalization Engines', '🎯',
  ARRAY['marketing'], ARRAY['optimizely','statsig','segment','launchdarkly'], 3,
  'Personalization engines vary the experience (content, copy, offers, layout) per user segment based on behavior, attributes, or intent. AI-augmented personalization now learns segment definitions from data automatically, predicts which content will convert per user, and runs continuous experimentation rather than static rules. Optimizely leads enterprise web personalization; Statsig pairs personalization with flag-based experimentation; Segment provides the customer-data-platform layer that feeds personalization decisions; LaunchDarkly enables flag-based personalization for product surfaces.',
  'Selection prioritized: real-time decisioning latency, segment-discovery quality, integration with the customer-data layer, and reporting on personalization lift.',
  '[
    {"q":"Personalization vs A/B testing - what is the difference?","a":"A/B testing finds the single best variant for the average user. Personalization finds the best variant per user segment (returning vs new, B2B vs B2C, mobile vs desktop). Most teams start with A/B testing then add personalization once they see segment-level effects in test results."},
    {"q":"What does AI improve in personalization?","a":"3 capabilities: (1) automatic segment discovery (AI clusters users into responsive segments humans would miss), (2) per-user content recommendation (AI predicts which variant will convert each user), (3) continuous experimentation (AI shifts treatment as user behavior changes rather than locking decisions in rules). The shift from rule-based to AI-driven personalization typically lifts conversion by 10 to 30 percent."},
    {"q":"Do we need a customer data platform (CDP) for personalization?","a":"For simple personalization (returning vs new, country, device), a basic web analytics tool is enough. For sophisticated personalization (per-account, per-cohort, multi-channel), a CDP like Segment unifies data from web, mobile, marketing automation, and CRM into one user profile that the personalization engine queries. The CDP investment pays off at the 10K MAU plus complex-segmentation threshold."}
  ]'::jsonb, 'marketing', 'advanced', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === RESEARCH (2) ===

-- 27. ai-for-research-archives
(
  'ai-for-research-archives', 'AI for Research Archives', '📚',
  ARRAY['research'], ARRAY['dovetail','maze','sprig','lookback'], 3,
  'Research archives store user-research artifacts (interview transcripts, recordings, notes, themes, insights) so future researchers can find what was already learned rather than re-running studies. AI-augmented research repositories now auto-tag transcripts by theme, surface relevant past findings when a new question is asked, and detect duplicate research that should consolidate. Dovetail leads research-repository for product teams; Maze brings unmoderated testing with archive layer; Sprig pairs in-product surveys with archive; Lookback owns moderated user-testing video archives.',
  'We weighted: search and retrieval quality across audio video and text, AI tagging depth, integration with research tools (Zoom, Calendly), and access controls for sensitive research.',
  '[
    {"q":"Dovetail vs Maze vs Sprig vs Lookback?","a":"Dovetail is the strongest pure research repository (best at organizing and retrieving past studies); Maze leads unmoderated remote testing with built-in archive; Sprig pairs in-product micro-surveys with archive of past findings; Lookback owns moderated video user-testing. Most product teams pick Dovetail as the central archive plus one of the testing tools as the data source."},
    {"q":"What does AI add to a research archive?","a":"3 capabilities: (1) auto-tagging of transcripts by theme so retrieval works across studies, (2) cross-study insight synthesis (AI surfaces patterns across multiple research projects), (3) duplicate-detection (AI flags new research questions that overlap with existing studies). The AI layer turns the archive from a digital filing cabinet to a queryable knowledge base."},
    {"q":"How do you keep researchers using the archive?","a":"3 patterns from teams that succeed: (1) make the archive the deliverable (researchers do not produce slides; they tag insights in the archive and link from Slack), (2) integrate archive search into the brief-writing workflow (every new study brief starts with a search of past findings), (3) measure archive engagement and reward researchers whose insights get cited most. Without these, archives die after 6 months of one-way uploads."}
  ]'::jsonb, 'research', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 28. ai-for-research-coordination
(
  'ai-for-research-coordination', 'AI for Research Coordination', '📅',
  ARRAY['research'], ARRAY['dovetail','respondent','userlytics','dscout'],3,
  'Research coordination handles the operational layer of user research: recruiting participants, scheduling sessions, paying incentives, handling consent forms, and managing the participant database. AI-augmented coordination platforms now match participants to studies based on profile attributes and past participation, automate scheduling across timezones, and detect fraudulent participants before sessions waste researcher time. Dovetail integrates light coordination into its repository; Respondent leads B2B participant marketplace; Userlytics covers UX testing with strong panel-management; dscout owns mobile-first ethnographic research with sophisticated participant matching.',
  'Selection prioritized: participant-panel quality, scheduling automation, incentive-payment infrastructure, and fraud-detection on participant identity.',
  '[
    {"q":"Where do participants come from?","a":"3 main sources: (1) panel marketplaces (Respondent, Userlytics, User Interviews) provide pre-vetted pools matched to study criteria, (2) own customer base via in-product opt-in (Sprig, Survicate) recruits from real users, (3) social and professional networks (LinkedIn outreach, niche communities) for hard-to-find segments. B2B research typically combines all three; consumer research relies more on marketplaces."},
    {"q":"What is the biggest coordination time-sink?","a":"Scheduling. A 30-participant study often takes 20 to 40 hours of coordinator time on logistics: timezone matching, reschedule handling, incentive payment, and consent forms. Modern coordination platforms cut this by 60 to 80 percent through automated scheduling, integrated payments, and templated consent flows."},
    {"q":"How does AI reduce participant-fraud risk?","a":"3 layers: (1) identity verification at signup (matching social profiles or email-domain patterns), (2) past-participation history (AI flags participants whose previous responses showed gaming patterns), (3) real-time response analysis during the session (AI detects copy-paste responses, contradictory answers, or rushed completion). High-incentive B2B studies see 5 to 15 percent fraud rates without screening; AI screening typically cuts this to under 2 percent."}
  ]'::jsonb, 'research', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === CUSTOMER-SUCCESS (3) ===

-- 29. ai-for-account-health
(
  'ai-for-account-health', 'AI for Account Health', '💚',
  ARRAY['analytics'], ARRAY['gainsight','vitally','clari'], 3,
  'Account health scoring synthesizes product-usage, support-ticket volume, NPS, executive engagement, and contract data into a single signal that flags at-risk accounts before they churn. AI-augmented health platforms now learn which signals actually predict churn at this company (vs generic templates), surface early warning at the contact level, and recommend specific plays for at-risk accounts. Gainsight is the customer-success-platform standard with strongest enterprise depth; Vitally serves modern B2B SaaS with stronger UX; Clari brings revenue-intelligence framing to account health.',
  'We weighted: signal-ingestion breadth (product usage, support, NPS, contract), AI churn-prediction accuracy, playbook automation, and integration with the CRM.',
  '[
    {"q":"Gainsight vs Vitally vs Clari?","a":"Gainsight is the enterprise CS-platform standard with deepest feature set; Vitally suits product-led B2B SaaS wanting cleaner UX and stronger product-usage integration; Clari is revenue-intelligence-first that adds account health to its forecasting story. Most enterprise teams pick Gainsight; modern PLG SaaS picks Vitally; revenue-led organizations layer Clari."},
    {"q":"What signals matter most for health?","a":"5 highest-signal inputs: (1) product engagement vs onboarding baseline (drop in DAU per account), (2) support-ticket-volume trend (rising volume signals product-fit issues), (3) executive-sponsor change (champion turnover is the highest churn signal), (4) NPS trajectory (declining is more predictive than absolute), (5) contract value vs target (under-contract usage signals lack of fit). AI weighting per company outperforms generic templates."},
    {"q":"How do CSMs use the health score?","a":"4 plays per score band: (1) green accounts get growth motion (expansion, upsell, advocacy), (2) yellow accounts get proactive QBRs and ROI reviews, (3) orange accounts get executive escalation and product-team involvement, (4) red accounts get save plays with discounts or scope changes. The ROI of the health platform comes from playbook automation, not the score itself."}
  ]'::jsonb, 'customer-success', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 30. ai-for-success-metrics
(
  'ai-for-success-metrics', 'AI for Success Metrics', '🎯',
  ARRAY['analytics'], ARRAY['gainsight','vitally','totango','planhat'], 3,
  'Success metrics define what good customer outcomes look like: product adoption depth, time-to-value, expansion revenue, NPS, and retention rate. AI-augmented metrics platforms now benchmark internal performance against industry peers, surface metric anomalies before they affect quarterly retention, and recommend specific actions to lift each metric. Gainsight, Vitally, Totango, and Planhat all surface success metrics with overlapping but distinct strengths across enterprise, mid-market, and product-led SaaS.',
  'Selection prioritized: dashboard customization depth, peer benchmarking, anomaly detection, and integration with revenue and product-data sources.',
  '[
    {"q":"What success metrics matter most for SaaS?","a":"5 core: gross retention rate, net retention rate, time-to-value (days from signup to first key action), product adoption rate (% of paid features used), and customer health score. Above the team-of-100 threshold add: expansion-revenue-per-CSM, advocacy rate (referrals, case studies, reviews), and renewal probability. The first 5 cover most decisions."},
    {"q":"Gainsight vs Vitally vs Totango vs Planhat?","a":"Gainsight is the enterprise standard with deepest depth; Vitally suits PLG SaaS with strong product-usage angle; Totango leads on workflow automation and CSM productivity; Planhat is the modern challenger with cleaner UX. The enterprise-mid-market split is Gainsight vs the rest; among the rest, Vitally for PLG, Totango for workflow-heavy, Planhat for clean UX."},
    {"q":"How does AI improve success metrics?","a":"3 ways: (1) peer-benchmarking (AI surfaces how this company compares to similar SaaS on key metrics), (2) anomaly detection (AI catches metric drift in specific segments before aggregate-level alarms fire), (3) action recommendation (AI suggests specific plays to lift each metric based on patterns from other accounts). The AI layer turns metrics from a dashboard to an action-engine."}
  ]'::jsonb, 'customer-success', 'intermediate', 1100,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 31. ai-for-customer-success-management
(
  'ai-for-customer-success-management', 'AI for Customer Success Management', '🤝',
  ARRAY['analytics'], ARRAY['gainsight','vitally','totango','planhat'], 3,
  'Customer success management coordinates the people-process-tooling layer that drives retention and expansion: CSM book-of-business assignment, QBR cadence, playbook execution, escalation routing, and renewal forecasting. AI-augmented CS platforms now assign accounts to CSMs based on fit, automate playbook triggers from health-score changes, and forecast renewal probability per account. Gainsight, Vitally, Totango, and Planhat all anchor this category with overlapping but distinct strengths.',
  'We weighted: book-of-business automation, playbook flexibility, renewal-forecasting accuracy, and CSM-experience UX (because CSMs adopt tools they like).',
  '[
    {"q":"How big does the CS team need to be to need a platform?","a":"Below 5 CSMs, a Salesforce or HubSpot custom dashboard with shared views covers most needs. Between 5 and 20, the playbook complexity and book-of-business management drives the move to a dedicated platform. Above 20, peer-benchmarking and forecasting requirements typically push to enterprise-grade Gainsight."},
    {"q":"What plays do CSMs run from these platforms?","a":"5 standard playbooks: (1) onboarding (90-day checklist with automation), (2) adoption (drive feature use after launch), (3) escalation (when health score drops to red), (4) renewal (90-day pre-renewal motion), (5) advocacy (case studies, referrals, reviews). Mature teams add expansion plays, executive-sponsor shifts, and quarterly-business-review cadence."},
    {"q":"How does AI add to CSM productivity?","a":"3 ways: (1) book-of-business optimization (AI re-assigns accounts when CSM patterns change), (2) playbook-trigger automation (AI fires the right play when signals match), (3) renewal forecasting (AI predicts renewal probability per account 90 days out). CSMs spend more time on strategy and less on coordination."}
  ]'::jsonb, 'customer-success', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === PRODUCTIVITY (3) ===

-- 32. ai-for-team-wikis
(
  'ai-for-team-wikis', 'AI for Team Wikis', '📖',
  ARRAY['analytics'], ARRAY['notion-ai','gitbook','document360','slab'], 3,
  'Team wikis house institutional knowledge: process docs, decisions, runbooks, design systems, onboarding guides, and how-we-work content that new hires need on day one. AI-augmented wikis now answer plain-English questions across the wiki content, surface stale documentation that needs review, and auto-suggest categorization for new pages. Notion AI dominates as the all-in-one workspace; GitBook leads developer-facing technical documentation; Document360 serves enterprise knowledge bases with strong access control; Slab focuses on team-handbook clarity and search.',
  'Selection prioritized: AI search and Q-and-A quality, content-staleness detection, integration with the rest of the work stack, and ease-of-contribution by non-technical authors.',
  '[
    {"q":"Notion vs GitBook vs Document360 vs Slab?","a":"Notion AI suits all-purpose knowledge plus task management plus database use cases (most flexible, busiest UI); GitBook leads developer documentation with Markdown-first editing; Document360 suits enterprise customer-facing knowledge bases with tier-based access; Slab is the cleanest team-internal handbook with strong search. Most early-stage startups land on Notion; engineering teams pick GitBook; mid-market customer-knowledge teams pick Document360; growing teams seeking lean wikis pick Slab."},
    {"q":"How does AI improve wiki ROI?","a":"3 ways: (1) Q-and-A search (instead of remembering where the doc is, ask the wiki), (2) staleness detection (AI flags docs that have not been touched but reference outdated info), (3) auto-categorization (AI suggests where new pages belong based on existing taxonomy). Together these solve the silent-killer of every wiki: the doc-rot that sets in after 12 months of use."},
    {"q":"Why do most team wikis fail?","a":"3 patterns: (1) one-time setup with no maintenance budget (docs go stale in 6 months), (2) too many tools (Notion plus Confluence plus Google Drive plus Slack creates 4 search surfaces), (3) authoring friction (people skip writing because the editor is awkward). Successful wikis solve the third with a clean editor, the second with consolidation, and the first with named owners and review cadence."}
  ]'::jsonb, 'productivity', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 33. ai-for-async-communication
(
  'ai-for-async-communication', 'AI for Async Communication', '💬',
  ARRAY['analytics'], ARRAY['loom','slack','linear'], 3,
  'Async communication tools let teams share context (videos, messages, decisions, status updates) without scheduling synchronous meetings, especially for distributed and global teams. AI-augmented async tools now summarize Loom recordings into text bullets, summarize long Slack threads into action items, and convert vague Linear comments into specific change requests. Loom leads async video for sharing demos and walkthroughs; Slack remains the chat-and-channels foundation with rich AI summarization; Linear delivers async-friendly task management with strong project-update flows.',
  'We weighted: AI summarization quality, integration with the broader work stack, mobile-experience quality, and search and retrieval depth across messages.',
  '[
    {"q":"Why does async communication fail in distributed teams?","a":"3 failure modes: (1) async messages get ignored when leaders respond synchronously to a few channels, (2) decisions get buried in long threads with no resolution at the bottom, (3) timezone-bridge delays compound when each round of question-answer takes 24 hours. Healthy async teams enforce written-decision-records, summary-as-resolution norms, and overlap-hour conventions."},
    {"q":"How does AI improve async velocity?","a":"3 capabilities: (1) Loom transcription plus summarization turns a 10-minute video into a scannable bullet list, (2) Slack thread summary catches up newcomers without reading 50 messages, (3) Linear comment-summarization turns vague feedback into specific actions. Async teams that lean into AI summarization see 2 to 3x faster decision velocity."},
    {"q":"What is the right async-vs-sync ratio?","a":"3 rules: (1) decisions with reversible outcomes go async (write-up plus 24-hour comment window), (2) decisions with irreversible outcomes go sync with async-prep (read-ahead doc plus meeting), (3) brainstorming and emotional conversations stay sync. Most healthy distributed teams run 60 to 80 percent async by hours, with sync hours protected for the high-value sync-required interactions."}
  ]'::jsonb, 'productivity', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 34. ai-for-second-brain
(
  'ai-for-second-brain', 'AI for Second Brain', '🧠',
  ARRAY['analytics'], ARRAY['mem-ai','readwise','notion-ai'], 3,
  'A second-brain system captures notes, highlights, ideas, and references in one searchable space so the human brain can stop trying to remember everything. AI-augmented second-brain tools now surface relevant past notes when working on a new project, summarize highlight collections into theme clusters, and convert messy capture into structured insight. Mem AI leads modern AI-native note-taking with strong contextual surfacing; Readwise owns reading highlight sync and review (Kindle, articles, podcasts); Notion AI delivers the all-in-one capture-plus-organize workspace.',
  'Selection prioritized: AI contextual surfacing quality, capture-from-anywhere ease, structured-vs-unstructured note balance, and review and resurface workflows.',
  '[
    {"q":"Mem AI vs Readwise vs Notion AI?","a":"Mem AI is AI-native note-taking with strongest auto-linking and surface-on-demand UX; Readwise is highlight-sync-and-review (best paired with another note tool, not as standalone capture); Notion AI is the all-in-one workspace where notes plus tasks plus databases coexist. Most second-brain practitioners run Mem or Notion as primary plus Readwise as the input pipeline from books and articles."},
    {"q":"What is the actual value of a second brain?","a":"3 returns: (1) reduced cognitive load (the brain stops trying to remember what was said in last quarter meeting), (2) faster context-recovery (when reopening a project, the second brain reconstructs context in seconds), (3) idea-connection (notes from one domain surface when working on another, sparking original thinking). The investment pays back when notes are reviewed and resurfaced, not just captured."},
    {"q":"What is the biggest second-brain mistake?","a":"3 traps: (1) over-organizing upfront (building a folder structure before knowing what notes look like), (2) under-resurfacing (capturing without reviewing kills the value), (3) tool-hopping (switching apps every 6 months loses the network of links). Modern AI tools reduce the first two by auto-tagging plus auto-resurface; consistency on tool choice solves the third."}
  ]'::jsonb, 'productivity', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DATA-ANALYTICS (3) ===

-- 35. ai-for-product-experimentation
(
  'ai-for-product-experimentation', 'AI for Product Experimentation', '🔬',
  ARRAY['analytics'], ARRAY['statsig','launchdarkly','optimizely','mixpanel'], 3,
  'Product experimentation tests proposed product changes (new features, pricing tiers, onboarding flows) on a portion of users to measure causal impact before committing to a full rollout. AI-augmented experimentation platforms now estimate sample size from baseline metrics, allocate traffic to winners via multi-arm bandits, and detect novelty effects that distort early results. Statsig and LaunchDarkly lead modern experimentation built on flag infrastructure; Optimizely brings rigorous Stats Engine for marketing-led experimentation; Mixpanel provides the analytics layer to identify what to test next.',
  'We weighted: statistical-engine rigor, sample-size estimation, server-side and mobile-experiment support, and integration with the analytics stack.',
  '[
    {"q":"Statsig vs LaunchDarkly vs Optimizely for product experiments?","a":"Statsig leads on built-in product analytics plus experiments (lowest cost of ownership for the integrated stack); LaunchDarkly leads on enterprise governance plus experimentation as a flag layer; Optimizely leads on web-marketing experimentation rigor. Most modern PLG SaaS picks Statsig; enterprise pickers go LaunchDarkly; marketing-led teams pick Optimizely."},
    {"q":"How is product experimentation different from web A/B testing?","a":"Web A/B testing (Optimizely classic) tests headline, copy, layout on a marketing site. Product experimentation tests in-product features: which onboarding step converts more users, whether a new pricing page lifts upgrade, whether a feature should ship to all users or be removed. Product experiments often run server-side and target authenticated users; web tests run client-side on anonymous traffic."},
    {"q":"What does AI add to product experimentation?","a":"3 ways: (1) sample-size estimation from baseline metrics so teams know up-front whether the test is feasible, (2) multi-arm bandit allocation that shifts traffic to winners during the test rather than after, (3) automatic peeking-correction (sequential testing) so analysts can monitor without inflating false-positive rate. Together these cut average experiment duration by 30 to 50 percent."}
  ]'::jsonb, 'data-analytics', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 36. ai-for-database-analytics
(
  'ai-for-database-analytics', 'AI for Database Analytics', '🗃️',
  ARRAY['analytics'], ARRAY['dbt','fivetran','atlan'], 3,
  'Database analytics is the modern data stack that turns raw operational data into trustable analytics tables for the business intelligence layer. AI-augmented data platforms now suggest dbt model SQL from natural-language questions, auto-document column meaning, and detect schema drift between source and warehouse before dashboards break. dbt leads the modern data stack as the transformation layer; Fivetran provides managed extract-load with hundreds of connectors; Atlan delivers the catalog plus lineage layer that ties source, transformation, and dashboard together.',
  'Selection prioritized: connector breadth (Fivetran), transformation-language depth (dbt), lineage and catalog completeness (Atlan), and integration with cloud warehouses.',
  '[
    {"q":"What is the modern data stack?","a":"5 layers in canonical order: (1) extract-load (Fivetran, Airbyte) pulls raw data into the warehouse, (2) warehouse (Snowflake, BigQuery, Redshift, Databricks) stores raw plus transformed data, (3) transformation (dbt) cleans raw into modeled analytics tables, (4) catalog (Atlan, Alation) documents what each table means, (5) BI (Looker, Tableau, Mode) presents dashboards. Most modern analytics teams run all 5 layers."},
    {"q":"When does a company need this full stack?","a":"Below 50 employees, Stripe plus HubSpot plus a single dashboard tool reading from those APIs is enough. Between 50 and 200, an EL tool (Fivetran) into Postgres or BigQuery starts paying off as data sources multiply. Above 200, the full Fivetran plus dbt plus warehouse plus catalog stack becomes the standard for analytics maturity. The threshold is data-source count more than employee count."},
    {"q":"How does AI improve the modern data stack?","a":"3 layers: (1) AI-assisted dbt model generation (analyst writes natural-language question, dbt generates the SQL plus the model), (2) AI auto-documentation (Atlan and similar tools generate column descriptions from data plus usage patterns), (3) AI lineage and impact analysis (when a source schema changes, AI predicts which downstream models break). The shift from analyst-bottlenecked to AI-augmented pipelines doubles team velocity."}
  ]'::jsonb, 'data-analytics', 'advanced', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 37. ai-for-business-metrics
(
  'ai-for-business-metrics', 'AI for Business Metrics', '📈',
  ARRAY['analytics'], ARRAY['mixpanel','amplitude','heap','posthog'], 3,
  'Business metrics dashboards present the numbers executives use to run the company: revenue, retention, growth, efficiency, and the operational KPIs upstream of those. AI-augmented metrics platforms now surface anomalies before the weekly review, generate plain-English explanations of metric movements, and forecast where metrics are headed if current trends continue. Mixpanel and Amplitude lead enterprise behavioral analytics; Heap pioneered auto-capture so teams stop missing events; PostHog leads open-source product analytics with self-hosting plus integrated session replay.',
  'We weighted: ease of dashboard creation by non-analysts, anomaly-detection rigor, behavioral-event-tracking depth, and integration with the warehouse layer.',
  '[
    {"q":"Mixpanel vs Amplitude vs Heap vs PostHog?","a":"Mixpanel suits B2B SaaS product teams with deep funnel and retention focus; Amplitude suits enterprise teams with multiple product lines needing governance; Heap pioneered auto-capture (records every event without manual instrumentation); PostHog is open-source-first with self-hosting plus integrated session replay. Most growth-stage SaaS picks Mixpanel; enterprise picks Amplitude; teams allergic to instrumentation pick Heap; engineering-led teams pick PostHog."},
    {"q":"What metrics belong on the executive dashboard?","a":"5 metrics typically reach the C-suite weekly: weekly active users (or DAU for consumer), revenue, gross retention rate, net retention rate, and headcount-vs-plan. Below the executive level, leaders track metrics specific to their function: marketing watches funnel conversion, product watches feature adoption, sales watches pipeline coverage."},
    {"q":"How does AI improve metrics review?","a":"3 ways: (1) anomaly detection (AI flags metric movements that exceed normal variance and surfaces likely root cause), (2) natural-language explanation (AI translates a 15 percent week-over-week conversion drop into a sentence about which segment caused it), (3) forecasting (AI projects where metrics are headed based on current trends). The weekly metrics meeting goes from numbers-recap to discussion-of-implications."}
  ]'::jsonb, 'data-analytics', 'intermediate', 590,
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
  status = EXCLUDED.status;
