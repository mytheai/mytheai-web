-- Mode D tier 19 backfill (S129)
-- 18 tools across feature-flags, dev databases, brand DAM, billing, personal finance, B2B intent, sales compensation.
-- All 18 PASS S86 quality gates: operational + favicon loads + actively shipped + category leader.
-- Unblocks Phase 3 batch 6 deferred candidates: feature-flags, database-migrations, brand-asset-management,
-- revenue-recognition, personal-finance, buyer-intent, sales-compensation, cap-table-management.
-- Idempotent: ON CONFLICT (slug) DO NOTHING.
-- apollo-io dropped (already in catalog as slug 'apollo' = Apollo.io).

INSERT INTO tools (
  slug, name, tagline, description, logo_url, website_url, affiliate_url,
  pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count,
  featured, trending, editor_pick, tags, pros, cons, use_cases, integrations,
  scores, pricing_verified_at
) VALUES

-- 1. LaunchDarkly - feature flag platform leader
('launchdarkly', 'LaunchDarkly', 'Feature management platform for progressive delivery, experimentation, and runtime config.',
'LaunchDarkly is the category-defining feature flag platform that turns code deploys into independent releases controlled by configuration rather than git pushes. Engineering teams wrap risky changes in flags, ship code dark to production, then progressively roll out to internal users, beta cohorts, percentage of traffic, or specific accounts based on targeting rules. Built-in experimentation layer lets product managers run randomized tests on flag values to measure impact before committing to a launch. The differentiator vs Statsig is enterprise depth: governance workflows, scheduled releases, audit logs, role-based access, and a federated SDK that ships to 25 plus languages with sub-50ms flag evaluation latency. Pricing starts at 20 USD per seat per month for Starter and scales by monthly active users. Vs Statsig: LaunchDarkly is enterprise feature management first; Statsig is experimentation-first with feature flags secondary. Most regulated industries (healthcare, finance) default to LaunchDarkly. Used by Atlassian, IBM, NBC, BMW. Series D plus funding (3 billion USD valuation 2022).',
'', 'https://launchdarkly.com', 'https://launchdarkly.com',
'paid', true, 20, 4.6, 0,
false, false, false,
ARRAY['code-ai'],
ARRAY['Industry-standard for enterprise feature management','Sub-50ms flag evaluation across 25+ SDKs','Strong governance: audit logs, role-based access, scheduled releases','Built-in experimentation engine with statistical rigor','Targeting rules support complex segmentation'],
ARRAY['Pricing scales fast at high MAU counts','Per-seat plus per-MAU model gets expensive','Steeper learning curve than simpler flag tools','Free tier limited to 14-day trial only'],
ARRAY['Progressive feature rollouts','A/B testing and experimentation','Trunk-based development support','Operational toggles for kill switches','Targeted releases by user segment','Compliance-driven release governance'],
ARRAY['github','slack','jira','microsoft-365'],
'{"trajectory":4.5,"ease_of_use":4,"reliability":5,"integrations":5,"feature_depth":5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 2. Statsig - experimentation-first feature flags
('statsig', 'Statsig', 'Product experimentation and feature flags built by ex-Facebook experimentation team.',
'Statsig was built by the team that designed Facebook internal experimentation infrastructure and brings the same statistical rigor to mid-market and enterprise teams in 2026. The differentiator is the unified product analytics plus feature flags plus experimentation stack: events flow into Statsig once, then power flag evaluation, A/B test stat computations, funnel analysis, and retention dashboards without duplicating instrumentation. Generous free tier (1 million events per month, 10 feature flags, unlimited team members) made it the fast-growing default for startups and Series A through C product teams. Paid Pro tier starts at 50 USD per month with no per-seat fees. Vs LaunchDarkly: Statsig is experimentation-first with built-in product analytics; LaunchDarkly is feature management first with optional experimentation. Vs Amplitude plus split.io combo: Statsig collapses both into one platform at lower cost. Used by Notion, OpenAI, Lattice, Whatnot. Series C 2024.',
'', 'https://www.statsig.com', 'https://www.statsig.com',
'freemium', true, 50, 4.7, 0,
false, true, false,
ARRAY['code-ai','analytics'],
ARRAY['Most generous free tier in the category (1M events/month)','Unified analytics plus flags plus experiments in one platform','Statistical rigor inherited from Facebook experimentation team','No per-seat pricing - flat platform pricing','Strong API and SDK coverage for modern stacks'],
ARRAY['Smaller enterprise governance feature set than LaunchDarkly','Documentation can lag rapid feature shipping cadence','Self-serve onboarding can feel sparse for large teams','Some advanced experimentation features require Pro tier'],
ARRAY['Product experimentation','Feature flag rollouts','Funnel and retention analytics','Holdout group analysis','Statistical significance testing','Multi-arm bandit experiments'],
ARRAY['github','slack','segment','jira'],
'{"trajectory":5,"ease_of_use":4.5,"reliability":4.5,"integrations":4.5,"feature_depth":4.5,"pricing_value":5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 3. Optimizely - experimentation platform veteran
('optimizely', 'Optimizely', 'Digital experience platform with web experimentation, feature flags, and content management.',
'Optimizely is the longest-running experimentation vendor in the category, originally a web A/B testing platform that has expanded into a full digital experience cloud covering content management, personalization, feature experimentation, and analytics. The 2020 acquisition of Episerver merged a CMS into the experimentation core, making Optimizely uniquely positioned for marketing teams that want experimentation tied to content workflows. Web Experimentation product remains a category benchmark: visual editor for non-technical users, server-side experimentation for engineering teams, and a rigorous Stats Engine that controls false discovery rate. Pricing is enterprise-quote-only with starting tiers around 50K USD per year. Vs VWO and Convert: Optimizely has deeper enterprise feature set, stronger statistical foundation, and integrated CMS angle; competitors win on price and self-serve onboarding. Used by Salesforce, IBM, Microsoft, Dollar Shave Club. Strong fit for global brands running 50 plus concurrent experiments across web, mobile, and feature rollouts.',
'', 'https://www.optimizely.com', 'https://www.optimizely.com',
'paid', false, 50000, 4.4, 0,
false, false, false,
ARRAY['analytics'],
ARRAY['Veteran experimentation platform with strongest Stats Engine','Visual editor for non-technical marketers','Server-side experimentation for engineering teams','Integrated CMS via Episerver acquisition','Enterprise governance and compliance features'],
ARRAY['Enterprise pricing only (50K+ USD per year typical)','Bloated suite - many products customers do not need','UI complexity higher than newer competitors','Slower feature shipping cadence than Statsig'],
ARRAY['Web A/B testing','Server-side feature experimentation','Multivariate testing','Personalization at scale','CMS plus experimentation workflow','Multi-page funnel optimization'],
ARRAY['salesforce','hubspot','google','segment'],
'{"trajectory":3.5,"ease_of_use":3.5,"reliability":4.5,"integrations":5,"feature_depth":5,"pricing_value":3,"output_quality":4.5}'::jsonb,
NOW()
),

-- 4. PlanetScale - serverless MySQL platform
('planetscale', 'PlanetScale', 'Serverless MySQL platform built on Vitess with branching and zero-downtime migrations.',
'PlanetScale is the serverless MySQL platform built on Vitess (the sharding layer that powers YouTube and Slack at scale) and brings Git-style branching to database schema management. The killer feature is database branching: developers spin up isolated database branches for feature work, run schema migrations, then merge to production with deploy requests that detect breaking changes before they ship. Zero-downtime migrations work because Vitess handles online schema changes natively. Pricing starts at 39 USD per month for Scaler tier (free Hobby tier was removed mid-2024 then partially restored late 2024). Vs Neon: PlanetScale is MySQL serverless with branching focus; Neon is Postgres serverless with similar branching. Stack preference often determines choice (Rails and PHP shops tend MySQL; modern Python and TypeScript shops tend Postgres). Used by Square Cash, GitHub, Intercom. Funded through Series C; founded by team that originally built Vitess at YouTube.',
'', 'https://planetscale.com', 'https://planetscale.com',
'paid', false, 39, 4.6, 0,
false, false, false,
ARRAY['code-ai'],
ARRAY['Database branching like Git for schema work','Zero-downtime migrations via Vitess online schema change','Built by Vitess core team (proven at YouTube scale)','Strong dev workflow with deploy requests and branch comparisons','Read replicas and sharding handled transparently'],
ARRAY['MySQL only - no Postgres support','No free tier on production-grade plans','Pricing starts at 39 USD per month minimum','Vitess paradigm requires shifting some MySQL habits'],
ARRAY['Serverless MySQL hosting','Schema migration workflow','Database branching for feature dev','Read-replica scaling','Sharded multi-tenant databases','Zero-downtime production schema changes'],
ARRAY['github','slack'],
'{"trajectory":4,"ease_of_use":4.5,"reliability":5,"integrations":4,"feature_depth":4.5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 5. Neon - serverless Postgres
('neon', 'Neon', 'Serverless Postgres with branching, autoscaling, and instant database provisioning.',
'Neon is the serverless Postgres platform that brings true scale-to-zero economics to relational databases: branches sleep when idle (paying nothing) and wake on first query in under a second. The architecture separates compute from storage so multiple compute branches share the same Postgres data, enabling Git-style branching for schema and data. The free tier covers most side projects (3 GB storage, 100 hours compute) and paid Launch tier starts at 19 USD per month. Vs PlanetScale: Neon is Postgres-native (full SQL plus JSONB plus extensions like pgvector); PlanetScale is MySQL-only. Vs Supabase: Neon focuses on raw Postgres compute with branching; Supabase wraps Postgres with auth, storage, edge functions, and realtime out of the box. Most modern AI startups (RAG apps, vector workloads) pick Neon for the pgvector support plus serverless economics. Used by Replit, Vercel, Retool. Series A 2023, acquired by Databricks May 2025 (keeps shipping as standalone product).',
'', 'https://neon.tech', 'https://neon.tech',
'freemium', true, 19, 4.7, 0,
false, true, false,
ARRAY['code-ai'],
ARRAY['True scale-to-zero (branches sleep when idle)','Postgres branching for dev workflow','Free tier covers most side projects','First-class pgvector support for AI/RAG workloads','Instant provisioning - new branch in under 1 second'],
ARRAY['Cold start latency on idle branches (sub-second but noticeable)','No connection pooling on Free tier (PgBouncer required)','Compute hour limits on lower tiers','Acquired by Databricks 2025 - long-term roadmap less certain'],
ARRAY['Serverless Postgres hosting','RAG and vector workloads (pgvector)','Database branching for feature dev','Multi-tenant Postgres at scale','Preview environments per PR','Read-only branches for analytics'],
ARRAY['github','slack'],
'{"trajectory":5,"ease_of_use":5,"reliability":4.5,"integrations":4.5,"feature_depth":4.5,"pricing_value":4.5,"output_quality":5}'::jsonb,
NOW()
),

-- 6. Supabase - open-source Firebase alternative
('supabase', 'Supabase', 'Open-source Firebase alternative - Postgres, auth, storage, edge functions, and realtime in one platform.',
'Supabase is the open-source backend-as-a-service that wraps Postgres with everything modern apps need: row-level security auth, file storage, edge functions, realtime subscriptions, and a generated REST plus GraphQL API. The differentiator vs Firebase is Postgres at the core, which gives developers full SQL, JSONB, pgvector, full-text search, and any standard Postgres extension rather than locking them into a NoSQL document model. Free tier is generous (500 MB database, 50K monthly auth users, 1 GB storage); Pro tier starts at 25 USD per month and adds dedicated resources, daily backups, and more bandwidth. Vs Neon: Supabase wraps Postgres with batteries-included BaaS layer; Neon focuses on raw Postgres compute primitives. Vs Firebase: Supabase has full SQL plus open-source self-host option; Firebase has tighter Google Cloud integration plus mature mobile SDK. Used by Mozilla, GitHub, Bun, Resend. Series C 2024 (2 billion USD valuation), 1M plus developers.',
'', 'https://supabase.com', 'https://supabase.com',
'freemium', true, 25, 4.8, 0,
false, true, false,
ARRAY['code-ai'],
ARRAY['Open-source - can self-host the entire stack','Full Postgres power (SQL, JSONB, pgvector, extensions)','Generous free tier covers most side projects','Realtime subscriptions and edge functions built in','Strong dev experience with auto-generated APIs'],
ARRAY['Self-host requires DevOps expertise to maintain','Pricing scales with bandwidth, can surprise at scale','Cold-start delays on auto-paused free projects','Some Pro features not at parity with Firebase ecosystem'],
ARRAY['Postgres-backed app backend','User authentication and row-level security','File and image storage','Realtime subscriptions','Vector embeddings for AI apps','Auto-generated REST and GraphQL APIs'],
ARRAY['github','slack'],
'{"trajectory":5,"ease_of_use":5,"reliability":4.5,"integrations":4.5,"feature_depth":5,"pricing_value":4.5,"output_quality":5}'::jsonb,
NOW()
),

-- 7. Frontify - brand asset management platform
('frontify', 'Frontify', 'Brand management platform for guidelines, digital assets, and creative workflows.',
'Frontify is the brand management platform that combines a digital asset library (DAM), brand guidelines portal, and creative collaboration workspace into one product. The brand portal aspect is what differentiates it from pure DAMs: marketing, design, and partner teams access logos, color palettes, typography rules, photography, and templates through a public-or-restricted brand site rather than scattered Dropbox folders. AI-assisted asset tagging and search shipped in 2024. Pricing is enterprise-quote-only, typical deployments 30K to 100K USD per year. Vs Brandfolder: Frontify leans creative collaboration plus brand portal; Brandfolder leans pure DAM with stronger ecommerce integrations. Vs Bynder: Frontify has cleaner UX and lower-friction onboarding; Bynder has deeper enterprise governance for global teams. Used by Lufthansa, Allianz, Volkswagen, Vodafone. Series C-funded, ~700 employees, profitable 2023. Strong fit for mid-market to enterprise brands managing 1K plus assets across regions.',
'', 'https://www.frontify.com', 'https://www.frontify.com',
'paid', false, 30000, 4.6, 0,
false, false, false,
ARRAY['marketing'],
ARRAY['Brand portal and DAM in one platform','AI-assisted asset tagging and search','Strong creative collaboration features','Cleaner UX than legacy enterprise DAMs','White-label brand sites for partner enablement'],
ARRAY['Enterprise pricing only (30K+ USD per year typical)','Long sales cycle and onboarding','Smaller integration ecosystem than Bynder','Some advanced workflow features locked to top tier'],
ARRAY['Brand guideline portal','Digital asset library (DAM)','Logo and template distribution','Creative review and approval workflows','Marketing campaign collaboration','Partner enablement with brand assets'],
ARRAY['slack','salesforce','hubspot','dropbox'],
'{"trajectory":4,"ease_of_use":4.5,"reliability":4.5,"integrations":4,"feature_depth":4.5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 8. Brandfolder - DAM with ecommerce focus
('brandfolder', 'Brandfolder', 'Enterprise digital asset management with AI-powered organization and analytics.',
'Brandfolder is the enterprise DAM acquired by Smartsheet in 2020 that focuses on asset organization, distribution, and analytics for marketing-heavy organizations. The Brand Intelligence layer (AI-powered tagging, smart search, asset performance analytics) is the differentiator: the platform learns which assets perform best and surfaces insights about asset usage across teams and channels. Tight integration with Smartsheet workflows is a unique angle for teams already invested in that ecosystem. Pricing is enterprise-quote-only with deployments typically starting around 25K USD per year. Vs Frontify: Brandfolder leans pure DAM with stronger analytics and ecommerce integrations (Shopify, Salesforce Commerce); Frontify leans brand portal plus creative collaboration. Vs Bynder: Brandfolder has cleaner UX and Smartsheet ecosystem; Bynder has deeper enterprise governance for global rollouts. Used by Slack, Universal Music Group, Burton, Arc teryx. Strong fit for retail and consumer brands managing product imagery at scale.',
'', 'https://brandfolder.com', 'https://brandfolder.com',
'paid', false, 25000, 4.5, 0,
false, false, false,
ARRAY['marketing'],
ARRAY['AI-powered asset tagging and search','Asset performance analytics built in','Tight Smartsheet workflow integration','Strong ecommerce platform integrations','Clean UX with fast onboarding'],
ARRAY['Enterprise pricing (25K+ USD per year typical)','Less brand-portal depth than Frontify','Some advanced features locked to top tier','Smartsheet acquisition shifted product focus toward existing customers'],
ARRAY['Marketing asset organization','Product imagery management at scale','Asset usage analytics','Brand asset distribution to partners','Creative review workflows','Multi-team asset governance'],
ARRAY['slack','salesforce','hubspot','dropbox'],
'{"trajectory":3.5,"ease_of_use":4.5,"reliability":4.5,"integrations":4.5,"feature_depth":4.5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 9. Bynder - enterprise DAM for global brands
('bynder', 'Bynder', 'Enterprise digital asset management for global brands with deep governance and workflow.',
'Bynder is the enterprise DAM purpose-built for global brands managing tens of thousands of assets across regional teams, agencies, and channels. The differentiator is governance depth: granular permissions, regional asset variants (right-to-left scripts, market-specific imagery, localized video), automated content workflows, and detailed audit trails meet the compliance needs of regulated industries. Creative Workflow module manages briefs, approvals, and version control end to end. Pricing is enterprise-quote-only with deployments 40K to 200K USD per year typical. Vs Frontify and Brandfolder: Bynder has the deepest enterprise governance and workflow features but a steeper learning curve and higher cost. Used by Spotify, KLM, Five Guys, Puma, Icelandair. KKR acquired majority stake 2022 (revaluation around 1 billion USD). Strong fit for large global brands needing localized asset variants and complex approval workflows. Often the platform that survives an enterprise DAM RFP after Frontify and Brandfolder are eliminated on governance gaps.',
'', 'https://www.bynder.com', 'https://www.bynder.com',
'paid', false, 40000, 4.4, 0,
false, false, false,
ARRAY['marketing'],
ARRAY['Deepest enterprise governance in the DAM category','Regional asset variants for global brands','Built-in creative workflow and approvals','Detailed audit logs meet compliance requirements','Strong API and integration ecosystem'],
ARRAY['Steepest learning curve in the DAM category','Highest pricing tier (40K+ USD per year typical)','UI complexity reflects feature breadth','Implementation often requires consulting engagement'],
ARRAY['Global brand asset management','Regional asset localization','Creative workflow and approvals','Asset distribution to agencies and channels','Compliance-driven asset governance','Marketing campaign asset orchestration'],
ARRAY['salesforce','hubspot','slack','microsoft-365'],
'{"trajectory":3.5,"ease_of_use":3.5,"reliability":4.5,"integrations":4.5,"feature_depth":5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 10. Chargebee - subscription billing platform
('chargebee', 'Chargebee', 'Subscription billing and revenue management platform for SaaS and ecommerce companies.',
'Chargebee is the subscription billing platform built specifically for SaaS, ecommerce, and recurring-revenue businesses navigating complex pricing models, tax compliance, and revenue recognition. Where Stripe Billing handles core subscription primitives well, Chargebee adds depth: dunning management, churn prevention via cancel-flows, multi-entity revenue recognition (RevRec), tax automation across 100 plus jurisdictions, and a no-code billing engine that lets RevOps teams change plans without engineering. Free tier covers companies up to 250K USD annual recurring revenue; Performance tier starts at 249 USD per month. Vs Stripe Billing: Chargebee is dedicated subscription billing with deeper RevOps tooling; Stripe Billing is part of broader payments platform with simpler primitives. Most B2B SaaS companies past 1M USD ARR pick Chargebee for the RevRec and multi-entity needs. Used by Calendly, Freshworks, Pret A Manger, Study.com. Series H 2022 (3.5 billion USD valuation).',
'', 'https://www.chargebee.com', 'https://www.chargebee.com',
'freemium', true, 249, 4.5, 0,
false, false, false,
ARRAY['analytics'],
ARRAY['Free tier up to 250K USD ARR','Deepest RevRec and multi-entity support in the category','No-code billing engine for RevOps teams','Tax automation across 100+ jurisdictions','Built-in dunning and churn-prevention flows'],
ARRAY['Pricing scales with revenue, gets expensive at scale','Implementation can take 4-8 weeks','UI complexity reflects feature breadth','Some advanced flows require Enterprise tier'],
ARRAY['SaaS subscription billing','Revenue recognition and ASC 606 compliance','Tax compliance for global SaaS','Dunning and failed-payment recovery','Multi-entity billing for global ops','Pricing experimentation without engineering'],
ARRAY['salesforce','hubspot','slack','stripe'],
'{"trajectory":4,"ease_of_use":4,"reliability":5,"integrations":5,"feature_depth":5,"pricing_value":4,"output_quality":4.5}'::jsonb,
NOW()
),

-- 11. Copilot Money - personal finance app
('copilot-money', 'Copilot Money', 'iOS and Mac personal finance app with AI-powered budgeting, investing, and net worth tracking.',
'Copilot Money is the iOS and Mac personal finance app that emerged as the leading Mint replacement after Intuit shut Mint down in 2024. The app aggregates bank, credit card, investment, and crypto accounts via Plaid plus direct integrations, then auto-categorizes transactions with a learning algorithm that adapts to user corrections. The differentiator is design: Copilot focuses on a clean iOS-native experience with strong custom-categorization, recurring subscription detection, and budgets that handle real-life messiness (monthly minus annual rollovers, shared expenses). Apple-platform exclusivity is intentional: no Android, no web app. Pricing is 13 USD per month or 95 USD per year; 30-day free trial. Vs Monarch Money: Copilot is iOS-and-Mac-only with cleaner consumer UX; Monarch is cross-platform (web, iOS, Android) with stronger couples plus household features. Vs Rocket Money: Copilot is full-featured budgeting plus net worth tracker; Rocket Money focuses on subscription cancellation. Strong fit for Apple-platform users who want premium polish.',
'', 'https://copilot.money', 'https://copilot.money',
'paid', false, 13, 4.8, 0,
false, false, false,
ARRAY['finance'],
ARRAY['Cleanest iOS-native personal finance UX','Strong AI-powered transaction auto-categorization','Recurring subscription detection built in','Investment and crypto account aggregation','Active developer with rapid feature shipping'],
ARRAY['iOS and Mac only - no Android, no web','13 USD per month is mid-tier pricing','Smaller user community than Monarch','Some integrations US-only'],
ARRAY['Personal budgeting','Net worth tracking','Subscription monitoring','Investment portfolio tracking','Expense categorization','Cash flow analysis'],
ARRAY[]::text[],
'{"trajectory":5,"ease_of_use":5,"reliability":4.5,"integrations":3.5,"feature_depth":4,"pricing_value":4,"output_quality":4.5}'::jsonb,
NOW()
),

-- 12. Monarch Money - cross-platform personal finance
('monarch-money', 'Monarch Money', 'Cross-platform personal finance app for couples and households with unified budget tracking.',
'Monarch Money is the cross-platform personal finance app (web, iOS, Android) that became the most popular Mint replacement for couples and shared-finance households after Mint shut down in 2024. The differentiator vs Copilot Money is shared-finance support: two users can collaborate on the same household budget, see all accounts and transactions across both partners, and discuss spending in built-in chat threads. Goals tracking, net worth charts, and customizable dashboards work the same on web, iOS, and Android. The app aggregates accounts via Plaid plus Finicity plus direct integrations covering 13K plus financial institutions. Pricing is 14.99 USD per month or 99.99 USD per year (50 percent off first year for new users). Vs Copilot Money: Monarch is cross-platform with stronger couples and household features; Copilot is iOS-and-Mac-only with cleaner consumer UX. Vs Rocket Money: Monarch is full budgeting plus net worth; Rocket focuses on subscription cancellation. Strong fit for couples managing shared finances or anyone needing web access.',
'', 'https://www.monarchmoney.com', 'https://www.monarchmoney.com',
'paid', false, 14, 4.7, 0,
false, true, false,
ARRAY['finance'],
ARRAY['Cross-platform: web, iOS, Android','Shared-household and couples-budget features','13K+ institution coverage via Plaid plus Finicity','Goal tracking and net worth charts','Active community and rapid feature shipping'],
ARRAY['No free tier - paid only after 7-day trial','Some integrations less reliable than Plaid-only competitors','Mobile app feature parity trails web','Power-user features have learning curve'],
ARRAY['Couples and household budgeting','Net worth tracking across partners','Goal-based savings tracking','Investment portfolio aggregation','Transaction categorization','Cash flow forecasting'],
ARRAY[]::text[],
'{"trajectory":5,"ease_of_use":4.5,"reliability":4.5,"integrations":4.5,"feature_depth":4.5,"pricing_value":4,"output_quality":4.5}'::jsonb,
NOW()
),

-- 13. Rocket Money - subscription tracker plus budgeting
('rocket-money', 'Rocket Money', 'Personal finance app for subscription cancellation, bill negotiation, and budget tracking.',
'Rocket Money (formerly Truebill) is the personal finance app that pioneered subscription tracking and automated cancellation as a primary feature. The product detects recurring subscriptions across linked accounts, surfaces the ones users have forgotten, and offers concierge cancellation (the Rocket Money team contacts the vendor on the user behalf). Bill negotiation service contests cable and phone bills for a percentage of savings. Free tier covers basic budgeting and subscription tracking; Premium starts at 4 USD per month (12 USD per month for full bill negotiation). Vs Copilot and Monarch: Rocket Money leads on subscription cancellation and bill negotiation; the budgeting and net worth tracking are functional but not differentiated. Most users use Rocket Money alongside (not instead of) a primary budgeting tool. Acquired by Rocket Companies (NYSE:RKT, parent of Rocket Mortgage) 2021 for 1.27 billion USD; product still ships as standalone app. Strong fit for users with 5 plus active subscriptions wanting forgotten-subscription cleanup.',
'', 'https://www.rocketmoney.com', 'https://www.rocketmoney.com',
'freemium', true, 4, 4.4, 0,
false, false, false,
ARRAY['finance'],
ARRAY['Best-in-class subscription detection and cancellation','Concierge cancellation - team handles vendor calls','Bill negotiation service for cable and phone','Free tier covers basic features','Easy onboarding with Plaid account linking'],
ARRAY['Premium pricing (4-12 USD per month) varies by feature','Bill negotiation takes percentage cut of savings','Budgeting features less differentiated than Monarch or Copilot','Some users report aggressive upsell prompts'],
ARRAY['Subscription cancellation','Bill negotiation','Forgotten subscription cleanup','Basic budgeting','Credit score monitoring','Auto-savings goals'],
ARRAY[]::text[],
'{"trajectory":4,"ease_of_use":4.5,"reliability":4,"integrations":4,"feature_depth":4,"pricing_value":4.5,"output_quality":4}'::jsonb,
NOW()
),

-- 14. 6sense - B2B account intelligence
('6sense', '6sense', 'B2B account intelligence platform with intent data and predictive AI for revenue teams.',
'6sense is the B2B account intelligence platform that uses third-party intent data, technographic signals, and AI to identify which accounts are in-market for a given solution before they raise their hand. Revenue teams (sales, marketing, ABM) use 6sense to prioritize outbound, time outreach to active research moments, and personalize messaging to where an account is in the buying journey. The Sales Intelligence and ABM modules surface which accounts are researching what topics, which competitors they evaluate, and which buyer personas are engaged. Pricing is enterprise-quote-only, typical deployments 60K to 200K USD per year. Vs Demandbase: 6sense leads on intent data depth and predictive scoring; Demandbase leads on advertising activation and broader ABM platform. Most enterprise B2B revenue teams evaluate both in head-to-head RFPs. Used by Cisco, ZoomInfo, Snowflake, Splunk. Series E 2022 (5.2 billion USD valuation). Strong fit for B2B teams with 50 plus AEs running ABM at scale.',
'', 'https://6sense.com', 'https://6sense.com',
'paid', false, 60000, 4.5, 0,
false, false, false,
ARRAY['sales','marketing'],
ARRAY['Industry-leading intent data depth','Predictive AI for in-market account identification','Strong sales intelligence layer','Buyer persona engagement tracking','Tight Salesforce and HubSpot integration'],
ARRAY['Enterprise pricing (60K+ USD per year typical)','Implementation takes 6-10 weeks','UI complexity reflects feature breadth','Some intent data accuracy concerns at low volumes'],
ARRAY['Account-based marketing (ABM)','Intent data sourcing','Predictive lead scoring','Buyer journey mapping','Sales prospecting prioritization','Account engagement tracking'],
ARRAY['salesforce','hubspot','slack','linkedin'],
'{"trajectory":4.5,"ease_of_use":3.5,"reliability":4.5,"integrations":5,"feature_depth":5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 15. Demandbase - ABM platform
('demandbase', 'Demandbase', 'ABM platform combining account intelligence, advertising, and revenue activation.',
'Demandbase is the original account-based marketing (ABM) platform that pioneered IP-to-account matching for B2B advertising in the early 2010s and has since expanded into a full revenue activation platform. The differentiator vs 6sense is breadth: Demandbase combines account intelligence (intent, fit, engagement), B2B advertising activation (programmatic ad targeting at the account level), and a rich data graph from the Demandbase Cloud. The platform plays especially well for marketing teams that want to run targeted display campaigns to specific accounts based on intent signals. Pricing is enterprise-quote-only, typical deployments 50K to 250K USD per year. Vs 6sense: Demandbase leads on advertising activation and platform breadth; 6sense leads on intent data depth and predictive scoring. Used by Adobe, Workday, Box, Cisco, Salesloft. Acquired Engagio 2020, InsideView 2021, DemandMatrix 2021 (consolidated B2B data graph). Strong fit for B2B teams running ad-driven ABM at scale.',
'', 'https://www.demandbase.com', 'https://www.demandbase.com',
'paid', false, 50000, 4.4, 0,
false, false, false,
ARRAY['sales','marketing'],
ARRAY['Original ABM platform with deepest market history','Built-in B2B programmatic advertising','Demandbase Cloud data graph from 3 acquisitions','Account-level ad targeting based on intent','Rich account fit and engagement scoring'],
ARRAY['Enterprise pricing (50K+ USD per year typical)','Multi-product platform - some redundancy','Implementation takes 6-12 weeks','UI inherited from acquisitions feels fragmented'],
ARRAY['Account-based marketing','B2B programmatic advertising','Account intent monitoring','Sales and marketing alignment','Pipeline acceleration','Multi-channel ABM orchestration'],
ARRAY['salesforce','hubspot','slack','linkedin'],
'{"trajectory":3.5,"ease_of_use":3.5,"reliability":4.5,"integrations":5,"feature_depth":5,"pricing_value":3.5,"output_quality":4.5}'::jsonb,
NOW()
),

-- 16. Clearbit - B2B data enrichment (now HubSpot Breeze)
('clearbit', 'Clearbit', 'B2B data enrichment and lead intelligence (now part of HubSpot Breeze Intelligence).',
'Clearbit is the B2B data enrichment platform acquired by HubSpot in November 2023 and now embedded into HubSpot Breeze Intelligence. The product enriches leads, contacts, and accounts in real time with firmographic data (company size, industry, tech stack, revenue) and contact data (job title, role, seniority) sourced from public web crawling plus partner data. The historical use case was as a Salesforce or HubSpot data layer for sales and marketing teams; the post-acquisition direction tightens the integration with HubSpot CRM and surfaces enrichment natively in HubSpot workflows. Pricing transitioned to HubSpot Breeze pricing model (bundled with Sales Hub Professional and Enterprise tiers); standalone Clearbit subscriptions still available for non-HubSpot customers. Vs ZoomInfo and Apollo: Clearbit is real-time data enrichment focus; ZoomInfo leads on contact database breadth; Apollo leads on outbound prospecting features. Used by Segment, Asana, Stripe, Atlassian. Strong fit for HubSpot users wanting native enrichment.',
'', 'https://clearbit.com', 'https://clearbit.com',
'paid', true, 0, 4.4, 0,
false, false, false,
ARRAY['sales','marketing'],
ARRAY['Strong real-time data enrichment via API','Tight HubSpot integration post-acquisition','Quality firmographic and contact data','Free Logo and Tech Look Up APIs','Reveal API for de-anonymizing website visitors'],
ARRAY['Standalone pricing model in transition post-HubSpot acquisition','Smaller contact database than ZoomInfo','Some legacy products being deprecated','API rate limits on lower tiers'],
ARRAY['Lead and account enrichment','B2B firmographic data','Contact data appending','De-anonymizing website visitors','CRM data hygiene','Real-time lead routing'],
ARRAY['salesforce','hubspot','slack','segment'],
'{"trajectory":3.5,"ease_of_use":4.5,"reliability":4.5,"integrations":5,"feature_depth":4,"pricing_value":4,"output_quality":4.5}'::jsonb,
NOW()
),

-- 17. CaptivateIQ - sales compensation management
('captivateiq', 'CaptivateIQ', 'Sales compensation management platform with no-code commission plan design.',
'CaptivateIQ is the modern sales compensation platform that lets RevOps teams design, calculate, and pay commission plans without engineering or spreadsheet sprawl. The differentiator is the no-code formula builder: complex commission rules (accelerators, kickers, draws, clawbacks, splits) get built visually rather than encoded in IF-statement-laden Excel files. Real-time payout dashboards give reps visibility into earned commissions and forecasts; analytics show plan-effectiveness across quotas. Pricing is enterprise-quote-only, typical deployments 30K to 100K USD per year for mid-market teams. Vs Spiff (now Salesforce): CaptivateIQ stays standalone with stronger no-code formula builder and platform independence; Spiff is now Salesforce-native with tighter Sales Cloud integration. Most teams running Salesforce default to Spiff post-acquisition; teams on HubSpot, Pipedrive, or platform-agnostic preferences pick CaptivateIQ. Used by Gong, Atlassian, Affirm, ServiceTitan, Intercom. Series C 2022 (1.25 billion USD valuation). Strong fit for RevOps teams managing 50 plus reps on complex commission plans.',
'', 'https://www.captivateiq.com', 'https://www.captivateiq.com',
'paid', false, 30000, 4.7, 0,
false, false, false,
ARRAY['sales'],
ARRAY['Best-in-class no-code commission plan builder','Real-time rep payout dashboards','Strong analytics on plan effectiveness','Platform-agnostic (Salesforce, HubSpot, Pipedrive)','Active product team with rapid feature shipping'],
ARRAY['Enterprise pricing (30K+ USD per year typical)','Implementation takes 4-8 weeks','Best fit for teams with complex plans (overkill for simple commissions)','Smaller user community than legacy Xactly'],
ARRAY['Sales commission calculation','Complex plan design (accelerators, kickers, splits)','Real-time payout visibility for reps','Plan effectiveness analytics','Quota and territory management','Commission dispute reduction'],
ARRAY['salesforce','slack','hubspot'],
'{"trajectory":5,"ease_of_use":4.5,"reliability":4.5,"integrations":5,"feature_depth":5,"pricing_value":4,"output_quality":4.5}'::jsonb,
NOW()
),

-- 18. Spiff - Salesforce-native sales compensation
('spiff', 'Spiff', 'Sales compensation platform now part of Salesforce - native to Sales Cloud workflows.',
'Spiff is the sales compensation platform acquired by Salesforce in February 2024 and integrated into Salesforce Sales Cloud as the native commission management product. The original Spiff differentiator was a spreadsheet-like formula language familiar to RevOps teams used to Excel; post-acquisition the product also benefits from native Sales Cloud integration (pulls deal data, attainment, and quota directly without sync delays). Real-time payout statements and rep portals show commission accrual transaction-by-transaction. Pricing transitioned to enterprise Salesforce contracts; standalone Spiff subscriptions still available for non-Salesforce customers. Vs CaptivateIQ: Spiff is Salesforce-native (best fit for Sales Cloud shops); CaptivateIQ is platform-agnostic with stronger no-code formula builder. Most teams already on Salesforce default to Spiff post-acquisition for the data-sync depth. Used by FreshBooks, ZoomInfo, Asana, Lyft. Strong fit for Salesforce-centric RevOps teams replacing legacy Xactly or Anaplan deployments.',
'', 'https://spiff.com', 'https://spiff.com',
'paid', false, 25000, 4.6, 0,
false, false, false,
ARRAY['sales'],
ARRAY['Native Salesforce Sales Cloud integration','Spreadsheet-like formula language for RevOps teams','Real-time payout statements and rep portals','Strong fit for Salesforce-centric organizations','Backed by Salesforce post-acquisition'],
ARRAY['Best fit only for Salesforce customers','Standalone pricing model in transition post-acquisition','Less platform-agnostic than CaptivateIQ','Some advanced features locked to Sales Cloud Enterprise'],
ARRAY['Sales commission calculation','Salesforce-native compensation','Real-time payout visibility','Plan modeling and what-if analysis','Quota attainment tracking','Commission dispute resolution'],
ARRAY['salesforce','slack','hubspot'],
'{"trajectory":4,"ease_of_use":4.5,"reliability":5,"integrations":5,"feature_depth":4.5,"pricing_value":4,"output_quality":4.5}'::jsonb,
NOW()
)

ON CONFLICT (slug) DO NOTHING;
