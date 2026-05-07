-- Phase 3 batch 4 of Task Taxonomy initiative (S126)
-- 40 mid-tail tasks pushing 319 -> 359 tasks (Phase 3 progress 72% of 500-target).
-- Coverage: research (+4), customer-success (+4), finance (+4), dev (+3),
-- support (+4), hr-recruiting (+3), ops (+4), design (+3), data-analytics (+3),
-- sales (+4), marketing (+4). Writing/productivity at 30 cap, no add.
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Gate A 55/55 PASS, Gate B 54/55 PASS (1 dropped: saas-metrics missing profitwell).
-- 14 candidates intentionally dropped to keep all 13 categories in 23-31 spread band.
-- Defensive on apostrophes (S122 lesson): no quoted speech or contractions in JSON values.
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === RESEARCH (4) ===

-- 1. ai-for-customer-interviews
(
  'ai-for-customer-interviews', 'AI for Customer Interviews', '🎙️',
  ARRAY['research'], ARRAY['dovetail','maze','lookback','respondent','userlytics'], 3,
  'Customer interviews are the highest-signal source of qualitative product insight, and AI now compresses the work of running 30-50 interviews from a multi-week project into a few days. AI-augmented research platforms now recruit panelists by demographic and behavior, transcribe and tag interviews automatically, and surface representative quotes per theme. Dovetail leads research repositories with strongest cross-interview synthesis; Lookback handles moderated remote interviews with screen-share and recording; Respondent and Userlytics specialize in panel recruiting with vetted participant pools; Maze covers lighter usability-test interviews tied to prototypes.',
  'We weighted: panel-recruitment quality, transcription and tagging accuracy, cross-interview synthesis depth, and integration with research repositories.',
  '[
    {"q":"How many customer interviews do we need?","a":"5-8 interviews surface most usability issues in a specific persona; 15-20 interviews are needed for thematic analysis across personas; 30+ for longitudinal or attitudinal research. Beyond 30 the marginal insight per interview drops sharply unless you are deliberately exploring multiple segments."},
    {"q":"Dovetail vs Lookback for interviews?","a":"Dovetail is the research repository with deeper cross-interview analysis and codebook collaboration; Lookback is the moderated-session platform with stronger live-interview UX and screen-share. Most teams need both: Lookback for running interviews, Dovetail for analyzing across them."},
    {"q":"Should AI run the interview itself?","a":"No for early discovery interviews where rapport and follow-up questions matter; AI-led interviews underperform on depth. Yes for structured survey-style interviews and for transcript and follow-up summarization. The split lets the human focus on the conversation while AI handles logistics."}
  ]'::jsonb, 'research', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-user-journey-mapping
(
  'ai-for-user-journey-mapping', 'AI for User Journey Mapping', '🗺️',
  ARRAY['research'], ARRAY['dovetail','maze','sprig','optimal-workshop'], 3,
  'User journey mapping (visualizing the stages, actions, and emotions a user goes through to accomplish a goal) is foundational research yet often skipped because manual mapping takes weeks. AI-augmented research platforms now generate first-pass journey maps from interview transcripts and product analytics, surface friction patterns at each stage, and let the team refine the map collaboratively. Dovetail leads journey-map generation from research data; Sprig blends product analytics with in-product feedback for behavioral journey mapping; Maze handles task-flow mapping for usability testing; Optimal Workshop covers information-architecture journeys with tree-testing.',
  'Selection prioritized: stage-extraction quality from research data, friction-pattern surfacing, collaboration UX, and integration with product analytics.',
  '[
    {"q":"What goes in a strong journey map?","a":"4 layers: (1) stages (awareness, consideration, onboarding, daily use, advocacy); (2) user actions and goals at each stage; (3) thoughts and emotions (especially friction points); (4) tools or touchpoints involved. Maps stronger than this become noisy; maps lighter than this miss empathy."},
    {"q":"Dovetail vs Sprig for journey mapping?","a":"Dovetail builds journey maps from interview and qualitative research; Sprig builds them from in-product behavioral data. The richest maps blend both: qualitative for emotion and intent, quantitative for behavior. Most teams start with one and add the other after 6-12 months."},
    {"q":"How often should journey maps be updated?","a":"Annually for stable mature products; quarterly for products undergoing significant feature shifts; immediately after major persona-research projects. Stale journey maps are worse than no journey map because they create false confidence in outdated user understanding."}
  ]'::jsonb, 'research', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-qualitative-coding
(
  'ai-for-qualitative-coding', 'AI for Qualitative Coding', '🏷️',
  ARRAY['research'], ARRAY['dovetail','maze','sprig','lookback'], 3,
  'Qualitative coding (assigning thematic tags to passages of interview or survey data) used to be the most time-consuming part of qualitative research, often consuming 60-70% of total project time. AI-augmented research platforms now generate first-pass codes automatically from a corpus, suggest taxonomy refinements based on emerging themes, and let researchers iterate on the codebook collaboratively. Dovetail leads research-platform qualitative coding with strong codebook collaboration; Maze and Sprig ship lighter automatic coding tied to specific study types; Lookback supports inline tagging during moderated sessions.',
  'We weighted: first-pass code quality, codebook iteration UX, multi-coder reliability, and integration with research-data sources.',
  '[
    {"q":"How accurate is AI qualitative coding?","a":"On the first pass, AI matches expert-coder agreement at 75-85% for clearly-defined codes; falls to 60-70% for nuanced or interpretive codes. The pattern is to use AI as a first-pass to scale coverage, then have the researcher refine the 15-25% AI gets wrong. Time savings are 5-10x with quality matching expert coders after refinement."},
    {"q":"What is inter-coder reliability and does AI help?","a":"Inter-coder reliability measures how consistently 2 or more researchers apply the same codes to the same data. Acceptable thresholds are Cohen kappa 0.8 or above. AI helps by serving as a baseline coder; researchers reach reliability faster by aligning on AI output rather than starting from scratch."},
    {"q":"Should we let AI build the codebook itself?","a":"AI generates a strong starting taxonomy from a sample of data; the researcher should refine for theoretical fit and domain context. Pure-AI codebooks miss the nuance that comes from researcher knowledge of the domain and stakeholders. Hybrid AI-and-researcher codebooks consistently outperform either alone."}
  ]'::jsonb, 'research', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-research-recruiting
(
  'ai-for-research-recruiting', 'AI for Research Recruiting', '🎯',
  ARRAY['research'], ARRAY['respondent','userlytics','dscout','dovetail'], 3,
  'Research recruiting (finding the right participants for a study) is often the bottleneck that delays research projects by weeks; AI-augmented panel platforms now match researchers to vetted participants in hours rather than days. Modern platforms screen for behavioral and demographic criteria automatically, surface participant fit scores from past study performance, and handle scheduling and incentive payment. Respondent leads B2B research recruiting with vetted professional panels; Userlytics covers usability testing with diverse user pools; dscout specializes in mobile diary studies; Dovetail handles internal-panel management for companies running their own research panels.',
  'Selection prioritized: panel quality and vetting depth, screening criteria flexibility, scheduling automation, and participant-fit scoring.',
  '[
    {"q":"Respondent vs UserTesting for recruiting?","a":"Respondent has stronger B2B and professional panels (job-title screening, company-size filters); UserTesting has the largest consumer panel and broader demographic coverage. B2B SaaS research picks Respondent; consumer product research picks UserTesting."},
    {"q":"How long should recruiting take?","a":"24-72 hours from study spec to interview start for niche professional roles; 4-12 hours for consumer studies. Recruiting that takes longer than 1 week usually means the screening criteria are too narrow; loosen 1-2 criteria and re-screen rather than waiting longer."},
    {"q":"What incentives are appropriate?","a":"60-90 minutes of time merits 75-150 USD for professionals (varies by seniority and country) and 30-75 USD for consumers. Lower incentives risk no-shows and underqualified participants; higher incentives skew toward professional research participants who optimize for studies. Match the incentive to the audience."}
  ]'::jsonb, 'research', 'intermediate', 320,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === CUSTOMER-SUCCESS (4) ===

-- 5. ai-for-customer-engagement
(
  'ai-for-customer-engagement', 'AI for Customer Engagement', '💬',
  ARRAY['customer-service'], ARRAY['intercom','vitally','gainsight','planhat'], 3,
  'Customer engagement (the depth and frequency of meaningful interactions between a customer and a product) predicts retention better than feature adoption alone. AI-augmented engagement platforms now surface engagement scores per account, trigger personalized re-engagement campaigns when scores drop, and recommend specific outreach actions to CSMs. Intercom leads conversational engagement for product-led SaaS; Vitally and Gainsight tie engagement to CSM workflows; Planhat focuses on engagement trends as renewal signal.',
  'We weighted: engagement-score accuracy, re-engagement campaign automation, CSM-action recommendation quality, and integration with product analytics.',
  '[
    {"q":"What signals predict engagement decline?","a":"5 strong signals: (1) login-frequency drop of 40%+ over 30 days; (2) feature-usage breadth decline; (3) support-ticket sentiment shift; (4) executive-sponsor change at the customer; (5) competitor-mentions in support or sales conversations. AI platforms blend these into a real-time score."},
    {"q":"Intercom vs Gainsight for engagement?","a":"Intercom is messaging-led with conversational engagement at the core, well-suited to product-led SaaS; Gainsight is CSM-orchestration-led with deeper health-score and renewal forecasting. Conversational SaaS picks Intercom; high-touch enterprise CS picks Gainsight."},
    {"q":"Should we automate re-engagement?","a":"Yes for early-warning engagement drops (low-touch automated outreach scales); no for severe disengagement (the at-risk account deserves human CSM attention). Automation handles 70-80% of mild engagement drops; humans handle the 20-30% of severe drops that drive most churn."}
  ]'::jsonb, 'customer-success', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 6. ai-for-customer-insights
(
  'ai-for-customer-insights', 'AI for Customer Insights', '🔬',
  ARRAY['customer-service','research'], ARRAY['intercom','dovetail','sprig','gainsight'], 3,
  'Customer insights are the synthesized understanding of who customers are, what they need, and what changes their behavior, drawn from product data, support conversations, surveys, and interviews. AI-augmented platforms now unify these signals into a single insight repository, surface emerging themes across signal sources, and recommend product and CS actions. Intercom blends support and product signals into customer insights; Dovetail leads research-driven customer insights; Sprig pairs in-product micro-surveys with behavioral data; Gainsight ties insights to CSM and renewal workflows.',
  'Selection prioritized: multi-source signal blending, theme-emergence quality, action-recommendation depth, and integration with product analytics.',
  '[
    {"q":"What goes into a customer insights repository?","a":"4 signal sources: (1) qualitative research (interviews, surveys, diary studies); (2) product behavioral data (feature usage, funnel drop-off, session paths); (3) support and CS conversation data (ticket themes, sentiment); (4) sales-call data (objections, competitor mentions). Strong repositories blend all 4 with cross-source linking."},
    {"q":"Intercom vs Dovetail for insights?","a":"Intercom captures support and in-product conversational signals natively; Dovetail captures research and structured insight data. Most growth-stage SaaS companies need both: Intercom for inbound conversational, Dovetail for outbound research, with shared tagging across them."},
    {"q":"How do we make insights actionable?","a":"3 disciplines: (1) link every insight to specific product or CS hypotheses, not standalone observations; (2) attach action owners with deadlines; (3) review insights monthly to retire stale ones and surface compounding patterns. Insights that sit in a repository without action drive zero product change."}
  ]'::jsonb, 'customer-success', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-success-dashboards
(
  'ai-for-success-dashboards', 'AI for Success Dashboards', '📊',
  ARRAY['customer-service'], ARRAY['gainsight','vitally','planhat','totango'], 3,
  'Success dashboards aggregate customer health, adoption, sentiment, and renewal signals into the operating view CSMs and executives use daily. AI-augmented CS platforms now generate dashboards that highlight at-risk accounts in priority order, surface anomalies (sudden usage drop, sentiment shift), and produce executive summaries automatically. Gainsight leads enterprise success dashboards with the deepest customization; Vitally ships modern Slack-native dashboards for product-led SaaS; Planhat focuses on renewal-forecast dashboards; Totango handles usage-driven success dashboards.',
  'We weighted: dashboard customization depth, anomaly-detection quality, executive-summary generation, and integration with product analytics and CRM.',
  '[
    {"q":"What metrics belong on a success dashboard?","a":"5 layers: (1) at-risk-account list ranked by churn probability; (2) net revenue retention trend; (3) adoption metrics for newly shipped features; (4) CSM-workload distribution; (5) renewal forecast for next 90-180 days. Dashboards beyond these 5 become noisy; dashboards lighter than these miss strategic signal."},
    {"q":"Vitally vs Gainsight for dashboards?","a":"Vitally is faster to deploy with Slack-native UX, well-suited to companies under 200 customers; Gainsight has deeper customization and enterprise scale. Mid-market product-led SaaS picks Vitally; enterprise CSM picks Gainsight."},
    {"q":"How often should dashboards be reviewed?","a":"Daily by CSMs (5-10 minute scan for at-risk-account triggers); weekly by CS leadership (workload, NPS, expansion pipeline); monthly by executives (NRR, renewal forecast, expansion metrics). The right cadence depends on the audience; one dashboard cannot serve all 3 effectively."}
  ]'::jsonb, 'customer-success', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 8. ai-for-onboarding-tracking
(
  'ai-for-onboarding-tracking', 'AI for Onboarding Tracking', '📈',
  ARRAY['customer-service'], ARRAY['userpilot','pendo','vitally','gainsight'], 3,
  'Onboarding tracking is the difference between knowing customers signed up and knowing they got to value, and AI-augmented platforms now measure activation at the granular step level rather than the binary signup-or-not level. AI platforms surface stalled onboardings before customers churn silently, generate in-product nudges at friction points, and route at-risk new accounts to CSMs proactively. Userpilot and Pendo lead in-product onboarding tracking with strong walkthrough generation; Vitally and Gainsight tie onboarding signals into broader CS workflows.',
  'Selection prioritized: step-level activation tracking, friction-detection quality, in-product nudge generation, and integration with CSM workflows.',
  '[
    {"q":"What is the onboarding activation metric?","a":"The single behavioral milestone that correlates most strongly with retention, defined per product. For Slack it was sending 2000 team messages; for Dropbox it was uploading a file from 2 devices. Define yours from cohort analysis and track religiously; new-user activation rate predicts 12-month retention better than any other early metric."},
    {"q":"Userpilot vs Pendo for onboarding tracking?","a":"Userpilot is the modern AI-first option with cleaner UX for sub-200-customer SaaS; Pendo has deeper product analytics and enterprise scale. Mid-market product-led SaaS picks Userpilot; enterprise SaaS picks Pendo."},
    {"q":"How long should onboarding take?","a":"For SaaS: time-to-first-value in under 10 minutes for self-serve products, under 30 days for enterprise products. For ecommerce: time-to-second-purchase in under 30 days. Companies that compress these by 30-50% see proportional retention lift; over-investing in onboarding consistently pays back."}
  ]'::jsonb, 'customer-success', 'intermediate', 320,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === FINANCE (4) ===

-- 9. ai-for-financial-projections
(
  'ai-for-financial-projections', 'AI for Financial Projections', '📉',
  ARRAY['finance'], ARRAY['pilot','bench','airbase','docyt','zeni'], 3,
  'Financial projections drive every major decision a growing company makes (hiring, fundraising, runway management, market expansion) and AI-augmented bookkeeping platforms now produce defensible projections in hours rather than weeks. AI platforms blend historical financials with assumption inputs, run sensitivity analyses across scenarios, and surface assumption-quality warnings when inputs depart from comparable-company norms. Pilot leads venture-backed startup projections with multi-entity and ASC 606 support; Bench targets SMB projections; Airbase, Docyt, and Zeni cover spend and bookkeeping inputs that feed projection models.',
  'We weighted: assumption-input quality, scenario-analysis depth, comparable-company benchmark integration, and historical-cleanup support.',
  '[
    {"q":"Pilot vs Bench for financial projections?","a":"Pilot ships venture-backed-startup-grade projections with multi-entity and revenue-recognition support; Bench targets SMB and seed-stage projections with simpler model structure. Series A and beyond picks Pilot; pre-seed and seed picks Bench."},
    {"q":"How accurate are AI financial projections?","a":"On 6-12 month horizons, accuracy is 85-95% when historical inputs are clean and assumptions are well-documented. On 24-36 month horizons, accuracy drops to 50-70% because variable assumptions compound. Treat the projection as decision-support, not commitment, and revisit quarterly."},
    {"q":"Should AI generate the assumptions?","a":"AI suggests assumptions from comparable-company benchmarks and historical patterns; the finance team should validate and adjust. Pure-AI assumptions miss strategic context (planned market expansion, hiring freeze, product pivot); finance-team-customized assumptions outperform AI by 20-30% on 12-month accuracy."}
  ]'::jsonb, 'finance', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-investor-updates
(
  'ai-for-investor-updates', 'AI for Investor Updates', '📨',
  ARRAY['finance'], ARRAY['pilot','bench','docyt','zeni'], 3,
  'Investor updates (typically monthly or quarterly emails to existing investors) are how venture-backed companies maintain board and follow-on fundraising momentum. AI-augmented bookkeeping platforms now generate update drafts from real-time financial and operational data, surface metric trends with month-over-month commentary, and let founders edit rather than write from scratch. Pilot leads investor-update automation for venture-backed startups; Bench, Docyt, and Zeni provide the bookkeeping data layer that feeds update narratives.',
  'Selection prioritized: data-freshness in update drafts, narrative-generation quality, metric-explanation depth, and customization flexibility.',
  '[
    {"q":"How long should an investor update be?","a":"500-800 words for monthly updates; 1500-2500 words for quarterly. Beyond 2500 words investors skim; below 500 words for monthly creates concern. Strong updates lead with key metrics, end with asks, and tell the story in the middle."},
    {"q":"What metrics belong in every update?","a":"5 core metrics: revenue (MRR or top-line) with month-over-month growth; customer count and churn; cash runway; major hires and departures; specific asks (intros, talent, customer leads). Beyond these, optional metrics by stage and category."},
    {"q":"Should AI write the entire update?","a":"AI generates a strong first-pass draft from data; founders should add narrative, strategic context, and personality. Pure-AI updates feel generic and underperform on investor engagement; AI-assisted founder-customized updates ship 5x faster than manually-written updates with similar quality."}
  ]'::jsonb, 'finance', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 11. ai-for-board-prep
(
  'ai-for-board-prep', 'AI for Board Prep', '🎯',
  ARRAY['finance'], ARRAY['pilot','bench','docyt','zeni'], 3,
  'Board prep used to consume 20-40 hours of CEO and CFO time per quarterly board meeting; AI-augmented platforms now produce board-deck drafts with current financials, KPI trends, and executive summaries in 1-2 hours. AI platforms generate board-deck templates with company-specific metrics, surface board-relevant anomalies for the CEO to address, and produce ahead-of-meeting analyst-style commentary. Pilot leads board-prep automation for venture-backed startups; Bench, Docyt, and Zeni provide the bookkeeping data backbone for board metrics.',
  'We weighted: board-deck template quality, financial-data freshness, anomaly-surfacing depth, and customization for different board profiles.',
  '[
    {"q":"What goes in a strong board deck?","a":"5 sections: (1) executive summary (1 page on the most important news and asks); (2) financial review (revenue, margin, cash, runway); (3) operational metrics (customer, product, team); (4) strategic discussion (1-2 deep topics for board input); (5) appendix (detailed financials and supplementary data). Strong decks lead with the strategic discussion, not financials."},
    {"q":"How long should a board deck be?","a":"15-25 slides for the main deck; 50-100 slides total with appendix. Decks longer than 25 main slides force surface coverage rather than depth; shorter decks miss the discussion frame. Pre-meeting reading time should be 30-45 minutes."},
    {"q":"Should AI generate board commentary?","a":"AI generates strong first-pass commentary on metrics movements; the CEO should add strategic context and forward-looking judgment. Pure-AI commentary feels mechanical to experienced board members; CEO-customized AI-assisted commentary ships 4-5x faster than manual prep with similar quality."}
  ]'::jsonb, 'finance', 'advanced', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 12. ai-for-billing-reconciliation
(
  'ai-for-billing-reconciliation', 'AI for Billing Reconciliation', '🧮',
  ARRAY['finance'], ARRAY['tipalti','airbase','pandadoc','docyt'], 3,
  'Billing reconciliation (matching invoices, payments, refunds, and credits across customer accounts and bank records) consumes massive finance-team hours when done manually and surfaces revenue leakage when not done at all. AI-augmented finance platforms now reconcile billing in real time, surface discrepancies above a configurable threshold, and route corrections through approval workflows. Tipalti specializes in mass-payout and AP reconciliation at global scale; Airbase blends reconciliation with broader spend management; PandaDoc handles contract-to-payment reconciliation; Docyt automates AR-and-AP reconciliation for SMB.',
  'Selection prioritized: reconciliation accuracy, discrepancy-surfacing speed, approval-workflow flexibility, and integration with billing and banking systems.',
  '[
    {"q":"How much revenue leakage is typical?","a":"For SaaS, 1-3% of billed revenue is typical for unreconciled accounts (failed payments not retried, missing customer credits, double-billed invoices). At 10M ARR that is 100-300K of leakage. Strong reconciliation catches 80-90% of leakage; the cost of reconciliation tools is paid back many times over."},
    {"q":"Tipalti vs Airbase for reconciliation?","a":"Tipalti is the AP-and-payouts specialist with deepest global tax-and-compliance handling; Airbase is broader spend management with reconciliation built in. Companies running mass payouts (marketplaces, freelancer networks) pick Tipalti; companies focused on internal spend reconciliation pick Airbase."},
    {"q":"Should reconciliation be daily or monthly?","a":"Daily for high-velocity companies (ecommerce, marketplaces, sub-100-employee SaaS at scale); weekly is acceptable for stable mature companies; monthly is too slow and creates blind spots that compound. Modern platforms make daily reconciliation cheap."}
  ]'::jsonb, 'finance', 'advanced', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DEV (3) ===

-- 13. ai-for-code-review-comments
(
  'ai-for-code-review-comments', 'AI for Code Review Comments', '💬',
  ARRAY['dev'], ARRAY['cursor','copilot-microsoft','codeium','replit','tabnine'], 3,
  'Code review comments shape engineering culture and catch the bugs no test suite catches; AI-augmented coding assistants now surface review-worthy issues before the human reviewer opens the PR. AI platforms now flag potential bugs, suggest naming and clarity improvements, and surface security concerns alongside human reviewer comments. Cursor leads modern AI-pair-programming with strong repo-context awareness; Copilot covers broader language coverage with tight VS Code integration; Codeium and Tabnine target enterprise code review with on-prem deployment; Replit handles full-app review including dependencies and config.',
  'We weighted: bug-catching accuracy, comment-quality on naming and structure, security-issue detection, and integration with PR workflows.',
  '[
    {"q":"Cursor vs Copilot for code review?","a":"Cursor has deeper repository-context awareness which produces stronger comments on cross-file changes; Copilot has broader language coverage and lighter setup. Modern web stacks (TypeScript, React, Python) work in both; complex multi-service repos work better in Cursor with explicit context loading."},
    {"q":"What code-review issues does AI catch reliably?","a":"3 categories: (1) naming clarity (variable names, function names, comment-code mismatch); (2) common bug patterns (off-by-one errors, null-handling, race conditions in obvious cases); (3) security smells (SQL injection patterns, exposed secrets, unsafe deserialization). What it misses: domain-specific business logic and intent-vs-implementation gaps."},
    {"q":"Should AI replace human code review?","a":"No. AI catches mechanical issues at scale; humans catch logic-and-design issues that require system context. The strongest pattern is AI-as-first-pass-reviewer (covers 60-70% of mechanical issues) with humans focused on architecture, business logic, and team learning. Companies that try to skip human review hit quality cliffs."}
  ]'::jsonb, 'dev', 'intermediate', 320,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-dev-onboarding
(
  'ai-for-dev-onboarding', 'AI for Dev Onboarding', '🚀',
  ARRAY['dev'], ARRAY['cursor','copilot-microsoft','replit','codeium'], 3,
  'New engineer onboarding to a codebase used to take weeks of pair programming and documentation reading; AI-augmented coding assistants now compress that to days by answering codebase-specific questions in real time. AI platforms now answer architecture questions from repo context, generate first-PR-ready stubs from feature descriptions, and surface internal-API usage patterns without requiring senior engineer time. Cursor leads codebase-context-aware onboarding with strong repo understanding; Copilot covers VS Code-native onboarding with broader language support; Replit handles full-environment onboarding for early-stage teams; Codeium serves enterprise dev onboarding with on-prem deployment.',
  'Selection prioritized: codebase-context awareness, onboarding-doc generation quality, first-PR support depth, and integration with internal docs.',
  '[
    {"q":"Cursor vs Copilot for onboarding?","a":"Cursor reads the entire repo and answers architecture questions with deep context; Copilot has broader language coverage but lighter repo context. New engineers ramping on complex codebases pick Cursor; engineers ramping on standard frameworks pick Copilot."},
    {"q":"How long should dev onboarding take?","a":"With AI assistance: first PR in 2-5 days; productive contributor in 2-4 weeks; full team-velocity contributor in 6-10 weeks. Without AI assistance: each milestone takes roughly 1.5-2x longer. The compression compounds across the engineering team and is meaningful at hiring-heavy companies."},
    {"q":"Should AI replace senior-engineer onboarding time?","a":"For codebase navigation and standard architectural questions, yes. For team norms, code review culture, and high-stakes architectural decisions, no. The strongest pattern uses AI for self-serve learning and reserves senior-engineer time for judgment-heavy moments. Companies that under-invest in human onboarding hit retention cliffs."}
  ]'::jsonb, 'dev', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 15. ai-for-shell-scripts
(
  'ai-for-shell-scripts', 'AI for Shell Scripts', '🐚',
  ARRAY['dev'], ARRAY['cursor','copilot-microsoft','codeium','replit'], 3,
  'Shell scripts (bash, zsh, PowerShell) are the glue that holds developer workflows together, and AI coding assistants now generate idiomatic shell from natural-language descriptions in seconds. AI platforms produce strong first-pass scripts for common DevOps and automation tasks, surface portability issues across shells, and explain existing shell code that engineers inherit. Cursor leads with deep repository context for project-specific shell needs; Copilot has broader shell coverage and tight VS Code integration; Codeium covers enterprise shell scripting with security-aware suggestions; Replit handles shell scripts in cloud-IDE context.',
  'We weighted: idiom quality across bash and zsh, portability awareness, security-issue detection, and explanation quality for legacy scripts.',
  '[
    {"q":"How accurate is AI for shell scripts?","a":"For common patterns (file operations, log parsing, API calls, deployment scripts), 90-95% of generated scripts work without modification. For edge cases (signal handling, complex pipelines, race conditions), accuracy drops to 60-75%. Always test generated scripts in a non-production environment before running."},
    {"q":"Cursor vs Copilot for shell?","a":"Cursor has deeper project context which helps when generating scripts that integrate with existing tooling; Copilot has broader shell-pattern training and tighter VS Code integration. DevOps engineers in complex repos pick Cursor; developers writing standalone scripts pick Copilot."},
    {"q":"What security issues should we watch for?","a":"3 patterns AI sometimes misses: (1) command injection from unquoted variables; (2) silent failure modes (set -e, set -u, set -o pipefail discipline); (3) credential handling (avoid hardcoded secrets, use proper secret stores). Always review generated scripts for these before production deployment."}
  ]'::jsonb, 'dev', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SUPPORT (4) ===

-- 16. ai-for-support-routing
(
  'ai-for-support-routing', 'AI for Support Routing', '🚦',
  ARRAY['customer-service'], ARRAY['intercom','gorgias','zoho-desk','freshchat'], 3,
  'Support routing (sending each ticket to the right agent or AI bot based on topic, language, account tier, and agent expertise) determines whether tickets resolve in 5 minutes or 5 hours. AI-augmented support platforms now classify ticket intent at first message, route by multi-criteria logic in real time, and rebalance load across the team automatically. Intercom and Gorgias lead AI-first support routing for SaaS and ecommerce; Zoho Desk and Freshchat cover SMB routing across verticals.',
  'Selection prioritized: intent-classification accuracy, multi-criteria routing flexibility, agent-load balancing intelligence, and integration with CRM.',
  '[
    {"q":"Intercom vs Gorgias for support routing?","a":"Intercom has stronger SaaS-product-led routing with in-app messaging and AI agent (Fin); Gorgias is ecommerce-native with order-context awareness for routing decisions. SaaS picks Intercom; Shopify and BigCommerce stores pick Gorgias."},
    {"q":"How do we set up routing rules?","a":"3 layers: (1) hard rules (language, channel, business-hours); (2) intent and topic (AI-classified); (3) account tier and value (CRM-driven). Apply layers in order; first match routes the ticket. Avoid more than 5 rules per layer to prevent maintenance debt and unpredictable routing."},
    {"q":"Should AI agents handle tier-1 routing?","a":"Yes for most SaaS and ecommerce: AI agents handle 30-50% of tier-1 tickets end to end with high CSAT, and route the remainder to humans with full context. Pure-human first response is operationally expensive and slower; pure-AI handling without human escalation paths frustrates customers on complex issues."}
  ]'::jsonb, 'support', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 17. ai-for-help-center
(
  'ai-for-help-center', 'AI for Help Center', '📖',
  ARRAY['customer-service'], ARRAY['document360','intercom','gorgias','zoho-desk','helpjuice'], 3,
  'Help centers in 2026 are conversational AI experiences rather than static FAQ pages, and well-built help centers deflect 30-50% of tier-1 support tickets while improving customer satisfaction. AI-augmented help platforms now answer questions in natural language with citation links, surface gaps where customers asked questions the help center could not answer, and continuously update content from support-conversation patterns. Document360 leads dedicated help-center platforms with strong publishing workflows; Intercom and Gorgias bundle AI help centers into broader support platforms; Zoho Desk and Helpjuice cover SMB help centers across verticals.',
  'We weighted: AI Q-and-A quality, content-freshness workflow, gap-detection depth, and integration with support and chat platforms.',
  '[
    {"q":"How do we measure help-center effectiveness?","a":"3 metrics: (1) deflection rate (% of customer questions resolved in help center without ticket); (2) self-serve CSAT (CSAT on AI-answered questions); (3) gap rate (% of questions where help center had no useful answer). Strong help centers hit 30-50% deflection, 4.0+ CSAT, and under 15% gap rate."},
    {"q":"Document360 vs Intercom for help centers?","a":"Document360 is purpose-built for help-center publishing with strong content workflow and version control; Intercom bundles a help center into broader support platform with conversational integration. Companies focused on docs picking Document360; companies wanting integrated support pick Intercom."},
    {"q":"How often should help-center content be updated?","a":"Continuously based on support-conversation patterns. AI platforms surface the top 10-20 questions per week that the help center failed to answer; content team writes those answers and ships within 7 days. This compounding loop drives help-center quality up faster than scheduled-review cadence."}
  ]'::jsonb, 'support', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 18. ai-for-support-quality-assurance
(
  'ai-for-support-quality-assurance', 'AI for Support Quality Assurance', '✅',
  ARRAY['customer-service'], ARRAY['intercom','gorgias','zoho-desk','freshchat'], 3,
  'Support quality assurance (sampling and grading agent conversations to maintain quality and surface coaching opportunities) used to mean managers reviewing 1-2% of tickets manually; AI-augmented QA platforms now grade 100% of conversations automatically. AI platforms now grade tickets against quality rubrics, surface coaching moments per agent, and flag systemic issues across the team. Intercom and Gorgias lead AI-first support QA for SaaS and ecommerce; Zoho Desk and Freshchat cover SMB QA across verticals.',
  'Selection prioritized: grading-rubric flexibility, coaching-moment quality, systemic-issue detection, and integration with agent-performance data.',
  '[
    {"q":"What does support QA grade on?","a":"5 standard dimensions: (1) tone and empathy; (2) accuracy of information provided; (3) resolution quality (was the issue actually resolved); (4) communication clarity; (5) policy adherence. Strong rubrics weight resolution and accuracy heavily; weaker rubrics over-index on tone and miss substance."},
    {"q":"How much QA coverage is needed?","a":"With manual QA, sampling 2-5% of tickets is the budget-feasible ceiling for most teams. With AI QA, 100% coverage is feasible at low cost; the bottleneck shifts to manager-review of AI-flagged moments rather than the grading itself. AI lifts coverage 20-50x without proportional cost."},
    {"q":"Should AI grades affect agent performance reviews?","a":"AI grades inform but should not solely determine performance reviews. The pattern is to use AI grades as a starting point for managerial review, surface specific coaching moments, and let managers make final judgment calls. Pure-AI-grade performance management creates gaming dynamics and erodes agent trust."}
  ]'::jsonb, 'support', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 19. ai-for-faq-bots
(
  'ai-for-faq-bots', 'AI for FAQ Bots', '🤖',
  ARRAY['customer-service'], ARRAY['intercom','forethought','freshchat','capacity'], 3,
  'FAQ bots have evolved from rigid keyword-match scripts to AI agents that understand intent, hold multi-turn conversations, and resolve tier-1 questions end to end. Modern AI FAQ platforms now answer questions from a knowledge base with citation, hand off to humans with full context when needed, and continuously learn from conversation outcomes. Intercom Fin leads SaaS FAQ bots with conversational UX; Forethought specializes in enterprise FAQ-and-resolution bots; Freshchat and Capacity cover SMB and mid-market FAQ-bot deployment.',
  'We weighted: knowledge-base integration depth, multi-turn conversation quality, handoff context preservation, and integration with help-center content.',
  '[
    {"q":"What auto-resolution rate should we expect?","a":"30-50% for well-tuned FAQ bots after 60-90 days of training; 50-70% for high-volume well-documented categories (account questions, order status). Above 70% usually means the bot forces resolutions customers later escalate, which damages trust more than higher human-touch rates."},
    {"q":"Intercom Fin vs Forethought?","a":"Intercom Fin is tightly integrated with Intercom workflows, best for companies already on Intercom; Forethought is platform-agnostic and integrates across multiple ticketing systems. Existing Intercom users pick Fin; multi-platform enterprise picks Forethought."},
    {"q":"How do FAQ bots stay current?","a":"3 mechanisms: (1) auto-pull from help-center content with daily refresh; (2) flag conversations where the bot lacked a useful answer for content team review; (3) learn from agent overrides when humans resolve differently than the bot suggested. Bots that lack continuous learning hit a quality plateau within 3-6 months."}
  ]'::jsonb, 'support', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === HR-RECRUITING (3) ===

-- 20. ai-for-employee-development
(
  'ai-for-employee-development', 'AI for Employee Development', '🌱',
  ARRAY['hr'], ARRAY['lattice','culture-amp','15five'], 3,
  'Employee development (the structured work of helping team members grow toward their next role) is one of the strongest retention drivers and one of the most under-invested areas at most companies. AI-augmented HRIS platforms now generate personalized development plans from skill gaps, suggest learning resources matched to career goals, and prompt managers when development conversations are overdue. Lattice leads modern employee development tied to performance cycles; Culture Amp pairs development with engagement signals; 15Five focuses on weekly check-ins and development conversations.',
  'Selection prioritized: skill-gap analysis depth, learning-resource matching, manager-prompt quality, and integration with performance reviews.',
  '[
    {"q":"How does AI generate development plans?","a":"3 inputs: (1) skill profile from prior assessments and project work; (2) target role-level expectations; (3) interest signals from career conversations and self-assessment. AI suggests 3-5 specific development actions per quarter; the manager and employee refine. Plans built without all 3 inputs underperform."},
    {"q":"Lattice vs 15Five for development?","a":"Lattice ties development to performance review cycles with stronger structure for promotions; 15Five focuses on weekly check-ins with lighter performance-cycle integration. Companies above 100 employees with formal review cycles pick Lattice; smaller teams that prioritize check-in cadence pick 15Five."},
    {"q":"How often should development conversations happen?","a":"Quarterly minimum for explicit career conversations; monthly mentions in 1-on-1s for incremental progress. Annual-only conversations consistently underdeliver because progress signals get lost in 12-month gaps. Tools that prompt managers automatically lift cadence reliability significantly."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 21. ai-for-job-descriptions
(
  'ai-for-job-descriptions', 'AI for Job Descriptions', '📝',
  ARRAY['hr','writing'], ARRAY['notion-ai','jasper','copy-ai','writesonic'], 3,
  'Job descriptions are the first impression a candidate has of a company and the single most-leveraged piece of recruiting content; AI-augmented writing platforms now generate role-specific JDs in minutes that recruiters previously took hours to draft. AI platforms produce inclusive language by default, surface bias-risk phrasing, and produce versions optimized for LinkedIn, Indeed, and the careers page. Notion AI leads team-collaborative JD writing for tech-forward companies; Jasper, Copy AI, and Writesonic cover JD generation across verticals with brand-voice support.',
  'We weighted: role-specific quality, inclusive-language defaults, channel-format optimization, and integration with ATS systems.',
  '[
    {"q":"What goes into a strong JD?","a":"5 core sections: (1) role mission (what success looks like in 6-12 months); (2) responsibilities (5-7 specific outcome-oriented bullets); (3) qualifications (must-haves vs nice-to-haves clearly separated); (4) compensation transparency (band or range); (5) company-context narrative. Strong JDs lead with mission, not the company-history paragraph."},
    {"q":"How does AI surface bias in JDs?","a":"AI platforms flag gendered language (rockstar, ninja, aggressive), exclusionary requirements (10+ years experience, master degree required when not actually required), and tone issues that disproportionately deter underrepresented candidates. Tools surface these patterns; humans decide what to change."},
    {"q":"Should AI write the entire JD?","a":"AI generates a strong first-pass draft from a role brief and competitive scan; the hiring manager and recruiter should refine for company-specific context and team-fit detail. Pure-AI JDs feel generic and underperform on application rates; AI-drafted human-customized JDs ship 5-10x faster than manually-written JDs with similar quality."}
  ]'::jsonb, 'hr-recruiting', 'beginner', 2900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 22. ai-for-promotion-decisions
(
  'ai-for-promotion-decisions', 'AI for Promotion Decisions', '🎖️',
  ARRAY['hr'], ARRAY['lattice','culture-amp','15five','eightfold'], 3,
  'Promotion decisions used to depend heavily on manager memory and recency bias; AI-augmented HRIS platforms now aggregate continuous performance signals to support decisions with broader and more equitable evidence. AI platforms surface promotion-readiness signals (skill profile, role-level performance, peer feedback), flag fairness concerns across demographic groups, and produce promotion-decision packets for review committees. Lattice leads promotion workflow tied to performance cycles; Culture Amp pairs promotion with engagement and pay-equity data; 15Five covers SMB promotion processes; Eightfold handles enterprise promotion intelligence with skill-graph at the core.',
  'Selection prioritized: signal aggregation depth, fairness-audit features, decision-packet quality, and integration with performance and compensation systems.',
  '[
    {"q":"What signals support promotion decisions?","a":"4 signal sources: (1) sustained performance against role-level expectations over 6-12 months; (2) skill profile relative to next-role expectations; (3) peer and stakeholder feedback; (4) impact stories with measurable outcomes. Decisions made with all 4 signal sources outperform decisions made with manager memory alone."},
    {"q":"How do we ensure fairness in promotions?","a":"3 disciplines: (1) calibration committees that review decisions across teams to surface inconsistency; (2) AI fairness audits that flag pattern differences by demographic group; (3) clear role-level rubrics applied consistently. Companies running all 3 see 30-50% reduction in promotion-disparity by demographic group."},
    {"q":"Lattice vs Eightfold for promotions?","a":"Lattice has cleaner promotion-cycle UX integrated with performance reviews; Eightfold has the deepest skill-readiness signals across roles. Sub-1000-employee companies pick Lattice; 5000+ employees with formal calibration processes pick Eightfold."}
  ]'::jsonb, 'hr-recruiting', 'advanced', 320,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === OPS (4) ===

-- 23. ai-for-knowledge-transfer
(
  'ai-for-knowledge-transfer', 'AI for Knowledge Transfer', '🔗',
  ARRAY['ops'], ARRAY['notion-ai','document360','gitbook','coda','guru'], 3,
  'Knowledge transfer (the structured work of moving expertise from senior employees, departing employees, or specialist teams to broader organization access) determines whether companies retain institutional knowledge or lose it. AI-augmented knowledge platforms now extract knowledge from email threads and Slack channels, surface tacit knowledge through conversational interviews, and structure documentation for searchable retrieval. Notion AI leads team-collaborative knowledge management; Document360 specializes in technical and policy documentation; GitBook handles dev-focused knowledge bases; Coda builds flexible knowledge workspaces; Guru ships verified-answer workflow for sales and support knowledge.',
  'We weighted: knowledge-extraction depth, documentation-structure quality, search and retrieval intelligence, and integration with chat and email tools.',
  '[
    {"q":"When is knowledge transfer most critical?","a":"3 moments: (1) before a senior employee departs; (2) when a specialist team scales beyond original team size; (3) during product handoffs between engineering teams. Companies that systemize transfer at these moments retain 60-80% of institutional knowledge; ad-hoc transfer retains 20-40%."},
    {"q":"Notion AI vs Guru?","a":"Notion AI is the broader workspace platform with rich content types and team workflows; Guru focuses on verified-answer knowledge for sales and support contexts. Tech-forward companies that already use Notion pick Notion AI; sales-and-support teams pick Guru for verification rigor."},
    {"q":"Can AI extract knowledge from chat history?","a":"Yes, with diminishing returns. Tools surface frequent question patterns, accepted-answer threads, and recurring decision rationales from Slack history; the output captures 40-60% of usable knowledge. The remaining 40-60% requires structured interviews with domain experts because tacit knowledge does not appear in chat threads."}
  ]'::jsonb, 'ops', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 24. ai-for-meeting-coordination
(
  'ai-for-meeting-coordination', 'AI for Meeting Coordination', '📅',
  ARRAY['ops','productivity'], ARRAY['cal-com','reclaim-ai','sunsama','motion'], 3,
  'Meeting coordination across distributed teams (timezone alignment, calendar conflicts, prep-time defense) consumes massive collective hours when done manually; AI-augmented scheduling platforms now coordinate meetings in seconds while respecting individual focus-time preferences. AI platforms now propose meeting slots based on participant availability, defend focus-time blocks from low-priority meetings, and reschedule automatically when conflicts arise. Cal.com leads modern open-source-friendly scheduling with strong API; Reclaim AI focuses on focus-time defense alongside meeting scheduling; Sunsama emphasizes intentional daily-planning coordination; Motion blends scheduling with task-management auto-scheduling.',
  'Selection prioritized: multi-party scheduling intelligence, focus-time-defense depth, conflict-resolution UX, and integration with calendar and task systems.',
  '[
    {"q":"Cal.com vs Calendly?","a":"Cal.com is the open-source-friendly modern alternative with stronger API and self-host options; Calendly is the established leader with broader enterprise features. Tech-forward teams that want extensibility pick Cal.com; broader business teams pick Calendly."},
    {"q":"How do we coordinate across timezones?","a":"3 disciplines: (1) shared async-first culture so most coordination happens in writing; (2) explicit core-collaboration windows when all timezones overlap (typically 2-4 hours); (3) AI scheduling that surfaces fairness in meeting-time distribution across regions. Tools support all 3."},
    {"q":"Should every meeting have an agenda?","a":"Yes for any meeting longer than 15 minutes with more than 2 attendees. Agendas filter out meetings that should be async messages; AI platforms auto-generate agendas from a one-line description. Cancel meetings without agendas; the discipline compounds quickly across the team."}
  ]'::jsonb, 'ops', 'beginner', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 25. ai-for-purchase-orders
(
  'ai-for-purchase-orders', 'AI for Purchase Orders', '🧾',
  ARRAY['ops','finance'], ARRAY['ramp','brex','airbase','tipalti'], 3,
  'Purchase order management (PO creation, vendor matching, approval routing, 3-way matching to invoices and receipts) consumes finance-team hours and creates compliance risk when done in spreadsheets. AI-augmented spend platforms now generate POs from purchase requests, route for approval based on amount and category, and 3-way-match automatically to flag discrepancies. Ramp and Brex blend PO management into broader corporate-card and spend platforms; Airbase ships dedicated AP and PO workflow; Tipalti specializes in mass-payout PO management with global tax compliance.',
  'We weighted: PO-generation quality from purchase requests, approval-routing flexibility, 3-way matching accuracy, and integration with bookkeeping.',
  '[
    {"q":"Do we need formal POs?","a":"For SMB and early-stage companies under 100 employees, lighter PR-and-approval flow often suffices; formal POs add overhead. Above 100 employees or above 5M annual spend, formal POs become valuable for audit trail, vendor accountability, and 3-way matching. The threshold is judgment, not strict."},
    {"q":"Ramp vs Airbase for POs?","a":"Ramp blends POs into broader spend management with strong card-and-bill workflows; Airbase has deeper dedicated AP and PO workflow with strong approval-routing. Companies optimizing for spend visibility pick Ramp; companies focused on AP-and-PO depth pick Airbase."},
    {"q":"What is 3-way matching and why does it matter?","a":"3-way matching compares the PO (what was ordered), the receipt (what was delivered), and the invoice (what was billed) to confirm they agree before payment. Manual 3-way matching is error-prone and slow; AI 3-way matching catches 95%+ of discrepancies in seconds and surfaces only the exceptions for human review."}
  ]'::jsonb, 'ops', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 26. ai-for-vendor-onboarding
(
  'ai-for-vendor-onboarding', 'AI for Vendor Onboarding', '🤝',
  ARRAY['ops','finance'], ARRAY['ramp','brex','airbase','tipalti'], 3,
  'Vendor onboarding (collecting tax forms, banking details, contracts, and compliance documentation before payment can flow) used to take 2-4 weeks per vendor; AI-augmented spend platforms now compress this to days through self-serve portals and automated document collection. AI platforms route W-9 collection, bank verification, contract execution, and compliance checks in parallel rather than sequentially. Ramp, Brex, and Airbase ship integrated vendor onboarding alongside spend management; Tipalti specializes in global vendor onboarding with 200+ country tax-form support.',
  'Selection prioritized: self-serve portal UX, document-collection automation, compliance-check depth, and integration with global tax-form requirements.',
  '[
    {"q":"What documents are required for vendor onboarding?","a":"4 standard categories: (1) tax forms (W-9 for US, W-8BEN for international); (2) banking and payment details (bank verification, ACH or wire); (3) commercial contracts (MSA, SOW); (4) compliance attestations (data protection, security if relevant). Strong onboarding collects all 4 in a single self-serve flow."},
    {"q":"Tipalti vs Ramp for vendor onboarding?","a":"Tipalti is the global specialist with 200+ country tax-form support and deepest compliance handling; Ramp is broader spend management with lighter vendor onboarding. Companies running large international vendor networks pick Tipalti; companies primarily US-domestic pick Ramp."},
    {"q":"How do we audit vendor onboarding compliance?","a":"3 disciplines: (1) document-completeness checks before any payment is sent; (2) periodic re-verification (annual W-9 refresh, banking-detail confirmation); (3) audit logs of who approved each vendor and when. AI platforms automate all 3; manual processes consistently miss expired documents and create regulatory exposure."}
  ]'::jsonb, 'ops', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (3) ===

-- 27. ai-for-color-palettes
(
  'ai-for-color-palettes', 'AI for Color Palettes', '🎨',
  ARRAY['design'], ARRAY['figma','canva-ai','adobe-firefly'], 3,
  'Color palette generation used to require designer expertise in color theory and brand application; AI-augmented design platforms now generate accessible brand-aligned palettes from a hero color, mood, or reference image in seconds. AI platforms now surface accessibility-compliant pairings, generate light-and-dark mode variants automatically, and apply palettes across design-system tokens. Figma anchors design-system color tokens with strong plug-in ecosystem; Canva AI generates palettes for non-designer marketing teams; Adobe Firefly produces palettes from imagery and brand context.',
  'We weighted: accessibility-compliance defaults, design-system token integration, light-and-dark variant generation, and integration with brand systems.',
  '[
    {"q":"What makes a strong color palette?","a":"4 attributes: (1) accessible contrast ratios (WCAG AA at minimum, AAA for typography-heavy products); (2) clear semantic structure (primary, secondary, success, warning, error); (3) light and dark mode variants; (4) extensibility for brand applications across digital and print. Strong palettes ship 8-12 core colors with explicit semantic meaning."},
    {"q":"Should palettes match brand or personality?","a":"Both, in priority order: brand identity (consistency across surfaces) sets the boundaries, personality (tone of voice in color choices) refines within those boundaries. Pure-personality palettes drift from brand recognition; pure-brand palettes feel generic. The strongest brand systems define both layers."},
    {"q":"How does AI handle accessibility in palettes?","a":"AI platforms calculate contrast ratios automatically and refuse generations below WCAG AA by default. Tools surface high-risk pairings (text on backgrounds, button states) and suggest accessible alternatives. The accessibility floor is automatic; the accessibility ceiling still requires designer judgment for typography and layout context."}
  ]'::jsonb, 'design', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 28. ai-for-design-systems
(
  'ai-for-design-systems', 'AI for Design Systems', '🧩',
  ARRAY['design'], ARRAY['figma','uizard','penpot'], 3,
  'Design systems (the codified set of components, tokens, patterns, and guidelines that ship product UI) used to require dedicated design-system teams; AI-augmented design platforms now generate component libraries from brand-system definitions and keep design-and-code in sync. AI platforms now generate component variants from a single base, surface design-system drift between Figma and code, and produce documentation alongside components. Figma is the canonical design-system canvas with deep plug-in ecosystem; Uizard generates AI-first design systems from prompts; Penpot serves as the open-source design-system platform.',
  'Selection prioritized: component-library generation quality, design-and-code sync, documentation depth, and integration with developer workflows.',
  '[
    {"q":"When does a company need a design system?","a":"At 3-5 designers and 10-20 engineers shipping product, the cost of inconsistency exceeds the cost of building a design system. Companies smaller than this can use a component library without formal system governance; companies larger than this without a system typically face significant UI-debt by the time they reach 50 employees."},
    {"q":"Figma vs Penpot for design systems?","a":"Figma has the most mature design-system tooling with broadest plug-in ecosystem; Penpot is the open-source alternative with strong native dev-handoff and self-host options. Most teams default to Figma; teams that need open-source or self-hosted picks Penpot."},
    {"q":"Can AI build a design system from scratch?","a":"AI generates strong starting components (buttons, inputs, cards, modals) from a brand-system definition; the design team should refine for product-specific patterns and edge cases. Pure-AI design systems miss the nuanced patterns that come from real product use; AI-generated foundations with designer-curated patterns ship 3-5x faster than designer-only systems."}
  ]'::jsonb, 'design', 'advanced', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 29. ai-for-app-icons
(
  'ai-for-app-icons', 'AI for App Icons', '📱',
  ARRAY['design'], ARRAY['figma','midjourney','canva-ai','adobe-firefly'], 3,
  'App icon design (iOS, Android, web favicon, browser-extension icon) requires brand-system precision at small sizes where details collapse; AI image-generation platforms now produce strong starting points that designers refine. AI platforms generate icon variants from brand-system inputs, scale across required sizes automatically, and surface accessibility and platform-guideline issues. Figma anchors icon design with vector precision and plug-in ecosystem; Midjourney generates strong stylized icon concepts; Canva AI handles icon production for non-designer teams; Adobe Firefly produces brand-aligned icon variants.',
  'We weighted: small-size legibility, platform-guideline compliance, brand-system alignment, and multi-size export workflow.',
  '[
    {"q":"What sizes do we need for app icons?","a":"For iOS: 1024x1024 master plus auto-generated smaller sizes. For Android: adaptive icons with foreground and background layers. For web: 512x512 maskable plus 32x32 and 16x16 favicons. Strong icon systems ship a master vector that exports cleanly to all required sizes."},
    {"q":"Midjourney vs Figma for app icons?","a":"Midjourney generates concept-quality icons that need vector recreation in Figma for production; Figma builds production-ready vector icons that need designer skill but ship directly. Concept exploration picks Midjourney; final production picks Figma."},
    {"q":"How do we test icon legibility?","a":"3 tests: (1) view at smallest required size (16x16 web, 29x29 iOS settings) to confirm details survive; (2) test on light and dark backgrounds (some icons fail in one mode); (3) place alongside competitor icons to confirm differentiation. Icons that fail any of these need refinement before launch."}
  ]'::jsonb, 'design', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DATA-ANALYTICS (3) ===

-- 30. ai-for-marketing-analytics
(
  'ai-for-marketing-analytics', 'AI for Marketing Analytics', '📈',
  ARRAY['data-analytics','marketing'], ARRAY['hubspot','klaviyo','intercom','activecampaign'], 3,
  'Marketing analytics in 2026 spans attribution, channel performance, content engagement, and lifecycle metrics, all increasingly unified through AI-augmented platforms. AI platforms now reconcile multi-touch attribution across channels, surface channel-mix optimization opportunities, and answer ad-hoc questions in natural language. HubSpot leads B2B marketing analytics with strong CRM-marketing alignment; Klaviyo handles ecommerce marketing analytics with deep behavioral segmentation; Intercom adds in-product engagement analytics; ActiveCampaign covers SMB marketing analytics with broad channel support.',
  'Selection prioritized: attribution-model depth, channel-mix optimization, ad-hoc query support, and integration with CRM and product analytics.',
  '[
    {"q":"What attribution model should we use?","a":"3 models with different strengths: (1) first-touch (over-credits awareness channels); (2) last-touch (over-credits conversion channels); (3) multi-touch with data-driven weighting (most accurate but requires sufficient data volume). For B2B with long sales cycles, multi-touch is usually right; for ecommerce, last-touch is often acceptable."},
    {"q":"HubSpot vs Klaviyo for marketing analytics?","a":"HubSpot is the broader B2B platform with strong CRM-marketing-sales alignment; Klaviyo is ecommerce-native with deeper behavioral segmentation and email-flow analytics. B2B SaaS picks HubSpot; ecommerce picks Klaviyo."},
    {"q":"How fresh should marketing data be?","a":"Daily refresh is the standard for operational dashboards; real-time is overkill and creates noise without strategic value. Monthly refresh is too stale for active campaign optimization. Weekly refresh is acceptable only for stable mature companies; growth-stage companies need daily."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 31. ai-for-spreadsheet-analysis
(
  'ai-for-spreadsheet-analysis', 'AI for Spreadsheet Analysis', '📑',
  ARRAY['data-analytics'], ARRAY['julius-ai','formula-bot','akkio','outerbase','seek-ai'], 3,
  'Spreadsheet analysis is still where most company decisions get made, and AI-augmented spreadsheet platforms now answer business questions from raw data without requiring SQL or pivot-table fluency. AI platforms now generate formulas from natural-language descriptions, run statistical analyses on selected ranges, and produce charts and pivot-style summaries automatically. Julius AI leads natural-language spreadsheet analysis with strong statistical depth; Formula Bot specializes in Excel and Google Sheets formula generation; Akkio handles predictive modeling on spreadsheet data; Outerbase and Seek AI bring SQL-and-spreadsheet hybrid analysis for technical users.',
  'We weighted: natural-language analysis quality, formula-generation accuracy, statistical-depth, and integration with Excel and Google Sheets.',
  '[
    {"q":"Julius AI vs Formula Bot?","a":"Julius AI is broader natural-language data analysis with strong statistical and visualization output; Formula Bot is focused on generating Excel and Google Sheets formulas from descriptions. Analysts running ad-hoc data analysis pick Julius; spreadsheet users wanting formula help pick Formula Bot."},
    {"q":"How accurate is AI on spreadsheet analysis?","a":"For descriptive statistics, sums, averages, group-bys, and standard charts, accuracy is 95-99%. For nuanced analysis (causal inference, regression interpretation, statistical significance), accuracy drops and outputs need human validation. AI is reliable for what spreadsheets do today; less reliable for inferential statistics."},
    {"q":"Should AI replace SQL or spreadsheets entirely?","a":"No. AI accelerates analysis on existing data infrastructure; the data infrastructure (warehouse, spreadsheets) still matters. The pattern is to use AI as a layer on top of existing tools, not as a replacement. Companies that try to skip data infrastructure end up with shallow analysis that does not compound."}
  ]'::jsonb, 'data-analytics', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 32. ai-for-sales-analytics
(
  'ai-for-sales-analytics', 'AI for Sales Analytics', '📊',
  ARRAY['data-analytics','sales'], ARRAY['gong-io','clari','avoma','modjo'], 3,
  'Sales analytics in 2026 spans pipeline health, deal velocity, win-rate decomposition, rep performance, and forecast accuracy, all increasingly automated through AI-augmented revenue intelligence platforms. AI platforms now reconcile CRM data with conversation data from calls and emails, surface deal-risk signals before they become forecast misses, and produce manager dashboards with anomaly highlights. Gong leads enterprise sales analytics with the deepest call-data integration; Clari focuses on revenue forecasting and pipeline analytics; Avoma and Modjo cover mid-market sales analytics with strong call-intelligence.',
  'Selection prioritized: CRM-and-call-data integration, deal-risk signal quality, forecast accuracy, and integration with conversation platforms.',
  '[
    {"q":"What signals predict deal risk?","a":"5 strong signals: (1) declining call cadence between rep and buyer; (2) competitor mentions in conversations; (3) buyer-side stakeholder shifts (champion change, executive sponsor loss); (4) timeline elongation past historical norms; (5) pricing-pushback pattern. AI platforms blend these in real time."},
    {"q":"Gong vs Clari?","a":"Gong leads in conversation-data depth and rep-coaching analytics; Clari leads in forecast accuracy and revenue-operations workflow. Most enterprise sales orgs need both: Gong for the conversation layer, Clari for the forecast layer. Mid-market companies with smaller sales orgs typically start with one."},
    {"q":"How accurate is AI sales forecasting?","a":"For 30-60 day horizons, accuracy is 85-95% when CRM and conversation data are well-integrated. For 90-180 day horizons, accuracy drops to 65-80% because variable factors compound. Treat forecasts as decision-support, not commitment, and revise weekly based on new signal."}
  ]'::jsonb, 'data-analytics', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SALES (4) ===

-- 33. ai-for-sales-meetings
(
  'ai-for-sales-meetings', 'AI for Sales Meetings', '🎯',
  ARRAY['sales'], ARRAY['gong-io','avoma','modjo','sembly-ai','fireflies-ai'], 3,
  'Sales meetings (discovery, demo, proposal-review, close) are where deals get won or lost, and AI-augmented meeting platforms now record, transcribe, and summarize every meeting while surfacing coaching moments in real time. AI platforms now generate meeting summaries with action items, surface buyer-signal patterns, and produce next-step recommendations to keep deals moving. Gong leads enterprise sales-meeting intelligence with the deepest analytics; Avoma and Modjo cover mid-market meeting intelligence with cleaner UX; Sembly AI and Fireflies AI focus on meeting recording with extensible coaching layers.',
  'We weighted: transcription accuracy, summary-generation quality, buyer-signal extraction depth, and integration with CRM and email.',
  '[
    {"q":"Gong vs Avoma for sales meetings?","a":"Gong is the enterprise leader with deepest analytics, largest call-data benchmarks, and strongest coaching workflows; Avoma is faster to deploy with cleaner UX and stronger SMB and mid-market positioning. Sales orgs above 30 reps with structured coaching pick Gong; mid-market under 30 reps pick Avoma."},
    {"q":"How does AI extract buyer signals?","a":"3 patterns: (1) language analysis (tone shifts, decision-criteria signals, urgency markers); (2) topic detection (competitor mentions, pricing concerns, integration questions); (3) participant analysis (who spoke, who stayed silent, who asked questions). Top platforms surface these in real time and post-meeting summaries."},
    {"q":"Should we record every sales meeting?","a":"Yes for B2B SaaS sales over 5K ACV; the coaching value compounds quickly. Disclosure is required by law in many jurisdictions; modern platforms automate the disclosure prompt. Smaller deals may not justify the recording overhead, though even short discovery calls benefit from AI summaries."}
  ]'::jsonb, 'sales', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 34. ai-for-sales-onboarding
(
  'ai-for-sales-onboarding', 'AI for Sales Onboarding', '🎓',
  ARRAY['sales','hr'], ARRAY['gong-io','lavender','modjo','avoma'], 3,
  'Sales onboarding (ramping new reps from hire to quota-attainment) used to take 6-12 months and cost the company 100K-300K per rep in lost productivity; AI-augmented sales platforms now compress ramp time by 30-50%. AI platforms now provide rep-personalized coaching from senior-rep call libraries, surface skill gaps from early-call analytics, and route weekly coaching plans automatically. Gong leads enterprise sales onboarding with the deepest call-library and rep-comparison; Lavender focuses on cold-email and prospecting onboarding; Modjo and Avoma cover mid-market onboarding with cleaner UX.',
  'Selection prioritized: rep-personalization depth, call-library quality, coaching-plan generation, and integration with CRM and meeting platforms.',
  '[
    {"q":"How long should sales onboarding take?","a":"With AI assistance: time-to-first-deal in 30-45 days; productive-rep status in 90-120 days; full-quota attainment in 180-240 days for B2B SaaS. Without AI assistance: each milestone takes 1.5-2x longer. Compression compounds across the team and is meaningful at hiring-heavy sales orgs."},
    {"q":"Gong vs Lavender for onboarding?","a":"Gong is full-funnel sales onboarding with deep call-library access and rep coaching; Lavender focuses specifically on cold-email and prospecting outreach. Full-cycle B2B SaaS reps benefit from Gong; SDR and outbound-prospecting roles benefit from Lavender."},
    {"q":"What is the role of senior-rep call libraries?","a":"Call libraries are recordings of senior-rep calls (discovery, demo, close) that new reps study to learn the company-specific motion. AI platforms make libraries searchable by topic, deal stage, and outcome; new reps consume relevant calls in 2-3 hours per week and ramp 40-60% faster than reps without library access."}
  ]'::jsonb, 'sales', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 35. ai-for-sales-content
(
  'ai-for-sales-content', 'AI for Sales Content', '📂',
  ARRAY['sales'], ARRAY['gamma-app','pitch','qwilr','storydoc'], 3,
  'Sales content (case studies, ROI calculators, security overviews, executive briefs, comparison decks) determines whether a buyer can self-serve research or has to ask the seller for everything. AI-augmented content platforms now generate buyer-stage-specific content packages, track buyer engagement section by section, and surface content gaps from buyer questions. Gamma and Pitch lead AI-first interactive sales content; Qwilr handles interactive proposals with engagement tracking; Storydoc focuses on AI-generated narrative content with strong visual storytelling.',
  'We weighted: content-generation quality, buyer-engagement tracking, gap-detection from buyer questions, and integration with CRM.',
  '[
    {"q":"What sales content has the highest leverage?","a":"4 categories: (1) buyer-persona-specific case studies (3-5 per major persona); (2) ROI-calculator templates buyers can self-customize; (3) competitor-comparison briefs (objective and well-researched); (4) security and compliance overviews. Strong libraries cover all 4 with regularly-updated content."},
    {"q":"Qwilr vs Storydoc for sales content?","a":"Qwilr is the established interactive-proposal platform with strong CRM integration and engagement analytics; Storydoc has stronger AI-generated narrative and visual storytelling. Sales-ops-led companies pick Qwilr; growth-stage companies that want differentiated narrative pick Storydoc."},
    {"q":"How often should sales content be refreshed?","a":"Quarterly review at minimum, with immediate updates when product changes materially or competitor positioning shifts. Stale sales content (more than 12 months old without review) consistently underperforms and erodes seller credibility with buyers who notice outdated screenshots, pricing, or claims."}
  ]'::jsonb, 'sales', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 36. ai-for-deal-rooms
(
  'ai-for-deal-rooms', 'AI for Deal Rooms', '🏢',
  ARRAY['sales'], ARRAY['storydoc','qwilr','gamma-app','pitch'], 3,
  'Deal rooms (shared digital spaces where buyer and seller exchange documents, proposals, and decision artifacts) replaced email threads at most modern B2B sales orgs. AI-augmented deal-room platforms now generate buyer-personalized rooms automatically, track engagement at section level, and prompt sellers when buyers stall on specific decision criteria. Storydoc and Qwilr lead modern AI-first deal rooms with strong narrative generation; Gamma and Pitch ship interactive deck workflows that double as deal rooms.',
  'Selection prioritized: room-personalization depth, engagement tracking granularity, seller-action prompts, and integration with CRM.',
  '[
    {"q":"Why use a deal room over email?","a":"3 advantages: (1) consistent buyer experience (vs scattered email threads); (2) section-level engagement tracking (which content the buyer actually consumes); (3) easier multi-stakeholder buying (champion can share with full buying committee). Companies that ship deal rooms see 15-25% higher close rates than email-only sales motions."},
    {"q":"Storydoc vs Qwilr for deal rooms?","a":"Storydoc is the AI-first option with stronger narrative generation and visual storytelling; Qwilr is the established interactive-proposal platform with deeper CRM integration and pricing-table workflows. Growth-stage companies that want differentiated narrative pick Storydoc; sales-ops-led companies pick Qwilr."},
    {"q":"What goes in a strong deal room?","a":"5 sections: (1) executive summary tailored to the buyer; (2) ROI calculator and case studies; (3) interactive pricing and proposal; (4) implementation timeline and success-criteria; (5) supporting documents (security, compliance, references). Strong rooms lead with the executive summary, not the company-history paragraph."}
  ]'::jsonb, 'sales', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === MARKETING (4) ===

-- 37. ai-for-content-ideas
(
  'ai-for-content-ideas', 'AI for Content Ideas', '💡',
  ARRAY['marketing'], ARRAY['jasper','copy-ai','writesonic','rytr','anyword'], 3,
  'Content idea generation (the work of finding topics that match audience interest, search demand, and brand positioning) is the bottleneck that gates content production at most marketing teams. AI-augmented writing platforms now surface content ideas from competitive analysis, search-trend data, and audience-intent signals, then generate outlines and briefs from selected ideas. Jasper and Copy AI lead general-purpose content idea generation; Writesonic and Rytr cover SMB content ideation across formats; Anyword specializes in conversion-focused content with brand-voice training.',
  'We weighted: idea-quality and freshness, search-intent integration, brief-generation depth, and integration with content management.',
  '[
    {"q":"How does AI surface content ideas?","a":"3 inputs: (1) audience-intent signals (search trends, social conversations, support questions); (2) competitive-content gaps (topics competitors cover that you do not); (3) brand positioning (what topics fit your perspective). AI surfaces hundreds of candidates; the content team selects the 5-10 worth executing per week."},
    {"q":"Jasper vs Copy AI for ideas?","a":"Jasper has stronger brand-voice training and longer-form context; Copy AI has cleaner idea-generation templates and faster variation. Brand-voice-strict companies pick Jasper; speed-of-execution-focused teams pick Copy AI."},
    {"q":"Should AI generate the entire content calendar?","a":"AI generates a strong starting calendar from search and competitive data; the content team should refine for strategic priorities, brand positioning, and seasonal context. Pure-AI calendars miss what is happening at the company; AI-drafted human-curated calendars consistently outperform either alone."}
  ]'::jsonb, 'marketing', 'beginner', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 38. ai-for-marketing-personas
(
  'ai-for-marketing-personas', 'AI for Marketing Personas', '🎭',
  ARRAY['marketing'], ARRAY['hubspot','klaviyo','intercom'], 3,
  'Marketing personas (semi-fictional buyer archetypes that capture demographics, behaviors, goals, and objections) ground campaigns in real audience understanding rather than generic spray-and-pray messaging. AI-augmented marketing platforms now generate personas from CRM behavioral data, customer-research transcripts, and product-usage signals, surfacing patterns that manual persona work misses. HubSpot leads B2B persona generation with strong CRM-marketing alignment; Klaviyo handles ecommerce personas with deep behavioral segmentation; Intercom adds in-product engagement signals to persona profiles.',
  'Selection prioritized: persona-generation quality from real data, segmentation depth, persona-application across campaigns, and integration with CRM.',
  '[
    {"q":"How many personas should we have?","a":"3-5 active personas for most companies; more personas dilute focus and create maintenance debt. Strong persona sets cover the major buyer types with enough behavioral and motivational distinction to inform messaging differences. Beyond 5 personas, the marginal segmentation value drops sharply."},
    {"q":"HubSpot vs Klaviyo for personas?","a":"HubSpot is broader B2B persona work with CRM-marketing alignment; Klaviyo is ecommerce-native with deeper behavioral segmentation and email-flow personalization. B2B SaaS picks HubSpot; ecommerce picks Klaviyo."},
    {"q":"How often should personas be updated?","a":"Annually for stable mature companies; quarterly for growth-stage companies; immediately after major customer-research projects or significant product pivots. Stale personas misdirect campaigns and reinforce outdated assumptions. Tools that auto-flag persona-data drift help teams maintain freshness."}
  ]'::jsonb, 'marketing', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 39. ai-for-blog-promotion
(
  'ai-for-blog-promotion', 'AI for Blog Promotion', '📡',
  ARRAY['marketing'], ARRAY['buffer','hootsuite','publer','sprout-social'], 3,
  'Blog promotion (the work of distributing a blog post after publish across social, email, communities, and partnerships) typically generates 70-80% of post traffic; without promotion, even high-quality content stays invisible. AI-augmented social platforms now schedule promotion across channels with channel-optimized formats, identify high-performing audience segments to amplify, and surface evergreen-promotion opportunities for older posts. Buffer leads SMB-friendly multi-channel scheduling; Hootsuite anchors enterprise social with deeper analytics; Publer ships AI-first scheduling for SMB; Sprout Social covers enterprise social with deepest reporting.',
  'We weighted: cross-channel format adaptation, audience-amplification intelligence, evergreen-promotion automation, and analytics depth.',
  '[
    {"q":"What channels should we promote blog posts on?","a":"3 layers: (1) owned (email list, blog homepage, RSS); (2) earned (social shares, newsletter mentions, partner cross-promotion); (3) paid (sponsored social, search retargeting). Strong promotion mixes all 3 with emphasis where audience attention is. B2B leans owned-and-earned; ecommerce leans paid."},
    {"q":"Buffer vs Hootsuite for blog promotion?","a":"Buffer has cleaner UX and faster setup, well-suited to SMB and mid-market; Hootsuite has deeper enterprise features and broader integration ecosystem. SMB and modern content teams pick Buffer; enterprise marketing picks Hootsuite."},
    {"q":"Should we promote evergreen content too?","a":"Yes. Evergreen posts (still-accurate content from 6-24 months ago) generate compounding traffic when promoted regularly. AI platforms surface high-performing evergreen posts and queue them for re-promotion every 4-12 weeks. Companies that promote evergreen content see 30-60% higher traffic from existing posts."}
  ]'::jsonb, 'marketing', 'beginner', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 40. ai-for-marketing-roi
(
  'ai-for-marketing-roi', 'AI for Marketing ROI', '💹',
  ARRAY['marketing','data-analytics'], ARRAY['hubspot','klaviyo','activecampaign'], 3,
  'Marketing ROI measurement (attributing pipeline and revenue to marketing investments across channels) is the most-debated discipline in modern marketing because attribution remains genuinely hard at the channel level. AI-augmented marketing platforms now run multi-touch attribution models, blend marketing-mix modeling with attribution for the strongest signal, and surface channel-level ROI with confidence intervals. HubSpot leads B2B marketing-ROI measurement with strong CRM-marketing-sales alignment; Klaviyo handles ecommerce ROI with deep behavioral segmentation; ActiveCampaign covers SMB ROI with broad channel support.',
  'Selection prioritized: attribution-model depth, marketing-mix-modeling support, confidence-interval handling, and integration with CRM and revenue systems.',
  '[
    {"q":"Why is marketing attribution so hard?","a":"3 reasons: (1) buyers interact across channels in non-linear paths that cookies and tracking pixels miss; (2) brand and dark-social impact resist measurement entirely; (3) attribution windows lag (B2B sales cycles run 60-180 days). Modern platforms blend multiple imperfect signals (multi-touch attribution, marketing-mix modeling, customer surveys) for the strongest available signal."},
    {"q":"HubSpot vs Klaviyo for marketing ROI?","a":"HubSpot is broader B2B with strong CRM-marketing-sales attribution across long sales cycles; Klaviyo is ecommerce-native with stronger behavioral and email-flow ROI. B2B SaaS picks HubSpot; ecommerce picks Klaviyo."},
    {"q":"How should we report marketing ROI to leadership?","a":"3 layers: (1) channel-level efficiency (cost per lead, cost per opportunity, cost per closed-won by channel); (2) blended ROI (total marketing spend vs marketing-attributed revenue); (3) leading indicators (pipeline contribution, audience growth, brand-search trend). Strong reports show all 3 layers; weak reports over-index on a single metric."}
  ]'::jsonb, 'marketing', 'advanced', 1900,
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
