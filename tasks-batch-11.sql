-- Phase 3 batch 3 of Task Taxonomy initiative (S125)
-- 41 mid-tail tasks pushing 278 -> 319 tasks (Phase 3 progress 64% of 500-target).
-- Coverage: research (+5), customer-success (+7), finance (+3), dev (+1),
-- support (+4), hr-recruiting (+4), ops (+1), design (+3), sales (+4),
-- marketing (+3), writing (+3), productivity (+3).
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Gate A 55/55 PASS, Gate B 41/55 PASS (14 dropped: catalog gaps in dev infra/security/data warehouse).
-- Defensive on apostrophes (S122 lesson): no quoted speech or contractions in JSON values.
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === RESEARCH (5) ===

-- 1. ai-for-thematic-analysis
(
  'ai-for-thematic-analysis', 'AI for Thematic Analysis', '🧵',
  ARRAY['research'], ARRAY['dovetail','maze','sprig','lookback','dscout'], 3,
  'Thematic analysis used to mean a researcher reading 30 interview transcripts and color-coding excerpts in a spreadsheet for 2 weeks. AI-augmented research platforms now cluster transcripts into themes in minutes, surface representative quotes per theme, and let the researcher refine the taxonomy interactively. Dovetail leads the category for product research teams; Maze ships lighter thematic clustering tied to usability testing; Sprig and Lookback target product analytics and remote interviews; dscout focuses on diary studies with rich qualitative data.',
  'We weighted: clustering accuracy on noisy transcripts, quote-extraction quality, codebook collaboration features, and integration with research repositories.',
  '[
    {"q":"How accurate is AI clustering vs manual coding?","a":"For 30-50 transcripts, AI clustering matches manual coding accuracy at roughly 80-85% on the first pass and reaches parity after one round of researcher refinement. The time savings are 5-10x; the quality lift comes from the researcher catching edge cases AI missed."},
    {"q":"Dovetail vs Maze for thematic analysis?","a":"Dovetail is the deeper research repository with stronger codebook collaboration and longitudinal analysis; Maze is lighter and tied to usability testing flows. Pure thematic analysis at scale picks Dovetail; combined with usability testing picks Maze."},
    {"q":"Can AI replace a researcher for thematic analysis?","a":"No. AI clusters and summarizes; the researcher decides what the themes mean for the product. The discipline of asking what a theme implies and what action follows is the work that drives product decisions, and AI does not replace that judgment."}
  ]'::jsonb, 'research', 'intermediate', 390,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-user-testing
(
  'ai-for-user-testing', 'AI for User Testing', '🧪',
  ARRAY['research'], ARRAY['maze','dovetail','sprig','lookback','respondent','dscout','userlytics'], 3,
  'User testing in 2026 means moderated interviews, unmoderated task tests, prototype walkthroughs, and longitudinal diary studies, often run in parallel by a single researcher or PM. AI-augmented platforms now auto-transcribe sessions, surface friction patterns from screen-recordings, recruit panelists by demographics, and summarize findings into shareable reports. Maze leads unmoderated prototype testing for product teams; Dovetail anchors moderated research repositories; Sprig blends product analytics with in-product testing; Lookback handles moderated remote interviews; Respondent and Userlytics specialize in panel recruiting.',
  'Selection prioritized: study-setup speed, panel-recruitment depth, AI transcription and friction-detection accuracy, and report-generation quality.',
  '[
    {"q":"Maze vs UserTesting for unmoderated tests?","a":"Maze is the modern AI-first option with cleaner UX and faster setup; UserTesting (legacy) has the largest panel and enterprise features. Product teams under 200 employees typically pick Maze; enterprise research orgs pick UserTesting."},
    {"q":"How many users do we need per study?","a":"5 users surface 80% of usability issues per Nielsen research, and that holds for unmoderated AI-recorded tests too. For thematic analysis or attitudinal research, 15-20 is the floor. Beyond 30 the marginal insight per participant drops sharply."},
    {"q":"Should we use AI to write study questions?","a":"AI is useful for generating initial question drafts and surfacing leading-question risks; the researcher should refine and order them. Studies designed entirely by AI miss context about what the team has already learned and what decisions hinge on the study."}
  ]'::jsonb, 'research', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-academic-summarization
(
  'ai-for-academic-summarization', 'AI for Academic Summarization', '📚',
  ARRAY['research'], ARRAY['elicit','scispace','humata','consensus'], 3,
  'Academic summarization used to mean reading 50 abstracts to find 5 relevant papers, then reading those 5 in full to extract findings. AI research assistants now process the entire corpus in minutes: summarizing methodology, extracting findings, and showing how each paper connects to the research question. Elicit leads structured-finding extraction across paper sets; SciSpace specializes in PDF chat for deep paper engagement; Humata handles long-document Q-and-A; Consensus aggregates findings across papers to surface scientific consensus.',
  'We weighted: extraction accuracy on technical methodology, citation handling, multi-paper synthesis quality, and integration with reference managers.',
  '[
    {"q":"Elicit vs SciSpace for academic work?","a":"Elicit is faster for cross-paper synthesis and structured extraction (methodology, findings, populations); SciSpace is better for deep engagement with a single paper, with strong PDF chat and equation handling. Researchers planning a literature review pick Elicit; those reading specific papers pick SciSpace."},
    {"q":"How accurate is AI on scientific findings?","a":"On methodology and stated findings, accuracy is 90-95%. On nuanced interpretation and limitations, AI underperforms a domain expert by 15-25%. Always validate critical citations directly in the source paper before quoting in your own work."},
    {"q":"Can AI replace a literature review?","a":"No. AI dramatically accelerates the discovery and triage phases, but the synthesis and argumentation that define a literature review require human judgment. Researchers using AI report 3-5x time savings on the mechanical parts and equal time on synthesis."}
  ]'::jsonb, 'research', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-paper-discovery
(
  'ai-for-paper-discovery', 'AI for Paper Discovery', '🔎',
  ARRAY['research'], ARRAY['elicit','scispace','humata','consensus'], 3,
  'Finding the right academic paper used to mean keyword search in Google Scholar followed by chasing citations. AI paper discovery tools now understand research questions semantically, surface papers based on conceptual overlap rather than literal keyword match, and rank by relevance to the actual question. Elicit leads question-driven paper retrieval with structured extraction; SciSpace pairs discovery with deep paper engagement; Consensus surfaces paper sets organized around scientific consensus or disagreement; Humata finds related work inside long PDFs.',
  'Selection prioritized: semantic search quality, citation graph traversal, recency filtering, and integration with reference managers.',
  '[
    {"q":"Elicit vs Google Scholar for discovery?","a":"Elicit understands the research question semantically and ranks by methodology relevance; Google Scholar is keyword-based and ranks by citation count. For exploratory research questions Elicit surfaces 30-50% more relevant papers; for known-citation lookup Google Scholar is faster."},
    {"q":"Are AI tools current with the latest papers?","a":"Most major tools index Semantic Scholar or OpenAlex with updates within 1-2 weeks of preprint publication. Coverage is strongest in computer science, biomedical, and chemistry; weakest in humanities and area studies where indexing lags."},
    {"q":"Can AI surface contradictory findings?","a":"Yes, and Consensus is designed for it: query a question, see papers grouped by conclusion (yes, no, mixed). This pattern is more valuable than naive list-of-papers because the researcher immediately sees the state of the literature rather than needing to read every paper to triangulate."}
  ]'::jsonb, 'research', 'intermediate', 320,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 5. ai-for-research-operations
(
  'ai-for-research-operations', 'AI for Research Operations', '🛠️',
  ARRAY['research'], ARRAY['dovetail','maze','sprig','lookback','optimal-workshop'], 3,
  'Research operations is the unsexy infrastructure that makes user research scale: panel management, study scheduling, repository hygiene, intake triage, and stakeholder distribution. AI-augmented research platforms now auto-tag insights to themes, route research requests to the right researcher, surface duplicate-study risk, and keep the repository discoverable. Dovetail leads research repositories with strong taxonomy and search; Maze handles panel management for usability testing; Sprig ties research to product analytics; Lookback manages moderated session logistics; Optimal Workshop covers tree-testing and information architecture.',
  'We weighted: repository taxonomy quality, intake-routing automation, panel-management depth, and duplicate-study prevention.',
  '[
    {"q":"Why does ResearchOps matter for small teams?","a":"Even at 1-2 researchers, the time spent on logistics (scheduling, panel management, sharing findings) consumes 30-40% of capacity. AI-augmented ResearchOps platforms cut that to 10-15%, freeing researchers for higher-leverage analysis and synthesis work."},
    {"q":"Dovetail vs Maze for ResearchOps?","a":"Dovetail is the dedicated research repository with the deepest taxonomy and search; Maze covers panel and usability testing logistics but lighter on repository. Teams running mostly usability testing pick Maze; teams running diverse methods pick Dovetail."},
    {"q":"How do we prevent duplicate studies?","a":"3 tactics: (1) intake form that searches the repository for similar past studies before approving new ones; (2) tagging discipline so past studies surface for similar questions; (3) quarterly review of repository to merge or archive overlapping insights. Tools support all three."}
  ]'::jsonb, 'research', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === CUSTOMER-SUCCESS (7) ===

-- 6. ai-for-feature-adoption
(
  'ai-for-feature-adoption', 'AI for Feature Adoption', '📈',
  ARRAY['customer-service'], ARRAY['userpilot','pendo','vitally','gainsight','planhat'], 3,
  'Feature adoption is the gap between shipping a feature and seeing customers actually use it; teams that close this gap retain customers 30-50% better than those that do not. AI-augmented adoption platforms surface which accounts have not yet used a new feature, generate in-app tooltips and walkthroughs, and trigger CSM outreach when usage stalls. Userpilot and Pendo lead in-product adoption tooling for product-led SaaS; Vitally and Gainsight surface adoption signals into CSM workflows; Planhat ties adoption tracking to renewal forecasting.',
  'Selection prioritized: in-product walkthrough quality, segmentation depth, CSM-alert routing, and integration with product analytics.',
  '[
    {"q":"Userpilot vs Pendo for feature adoption?","a":"Userpilot is the modern AI-first option with cleaner UX and faster setup, well-suited to teams under 200 customers; Pendo has deeper analytics and enterprise scale. Mid-market product-led SaaS picks Userpilot; enterprise picks Pendo."},
    {"q":"How do we measure feature adoption properly?","a":"3 layers: (1) reach (% of accounts who tried the feature once); (2) frequency (return-use rate over 30 days); (3) depth (% of feature surface area used). Reach without frequency is vanity; depth without reach is over-investment."},
    {"q":"Should we force-open new features for users?","a":"No, but you should make the on-ramp obvious. Best practice: contextual tooltip on first relevant interaction, not modal interruption. Forced modals drive 5-10% activation but tank trust; contextual tooltips drive 25-35% activation and lift NPS."}
  ]'::jsonb, 'customer-success', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-customer-loyalty
(
  'ai-for-customer-loyalty', 'AI for Customer Loyalty', '💎',
  ARRAY['customer-service','marketing'], ARRAY['klaviyo','omnisend','mailchimp'], 3,
  'Customer loyalty in 2026 is built through personalized lifecycle messaging and reward-program intelligence rather than generic monthly newsletters. AI-augmented platforms now segment customers by predicted lifetime value, generate personalized retention offers based on past purchase patterns, and trigger win-back campaigns before churn becomes visible in dashboards. Klaviyo leads ecommerce loyalty with deep predictive segmentation; Omnisend ships ecommerce-focused loyalty automation with SMS and email; Mailchimp covers SMB loyalty across verticals with simpler workflow.',
  'We weighted: predictive segmentation accuracy, channel coordination, reward-program flexibility, and integration with ecommerce stacks.',
  '[
    {"q":"Klaviyo vs Mailchimp for customer loyalty?","a":"Klaviyo has deeper predictive segmentation and ecommerce-native flows (cart abandonment, post-purchase, win-back); Mailchimp covers more verticals but with less ecommerce depth. Shopify and BigCommerce stores pick Klaviyo; SMBs across verticals pick Mailchimp."},
    {"q":"What signals predict customer churn?","a":"5 strong signals: declining purchase frequency, declining average order value, reduced email engagement, support-ticket sentiment shift, and time-since-last-purchase exceeding the cohort median. AI platforms blend these into a churn-risk score in real time."},
    {"q":"Are loyalty programs worth the investment?","a":"For repeat-purchase categories (beauty, food, fashion), yes: strong loyalty programs lift repeat rate 15-25% and average order value 10-15%. For one-time-purchase categories (durable goods), loyalty programs underperform retention via post-purchase support."}
  ]'::jsonb, 'customer-success', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 8. ai-for-customer-marketing
(
  'ai-for-customer-marketing', 'AI for Customer Marketing', '🎯',
  ARRAY['customer-service','marketing'], ARRAY['hubspot','klaviyo','mailchimp'], 3,
  'Customer marketing (marketing to existing customers for expansion, advocacy, and retention) generates 3-5x higher ROI than acquisition marketing yet is chronically underinvested. AI-augmented platforms now segment customers by upsell-readiness, generate personalized expansion offers based on usage signals, and orchestrate advocacy campaigns at scale. HubSpot leads B2B customer marketing with strong CRM-marketing alignment; Klaviyo handles ecommerce customer marketing with deep behavioral segmentation; Mailchimp covers SMB customer marketing across verticals.',
  'Selection prioritized: customer-segmentation depth, expansion-trigger automation, advocacy workflow, and integration with CRM and product data.',
  '[
    {"q":"How is customer marketing different from acquisition marketing?","a":"Customer marketing targets paying users for expansion, retention, and advocacy; acquisition marketing targets prospects. Customer marketing has 3-5x higher conversion and 5-10x higher ROI because the relationship and product context already exist. Many companies underinvest because attribution is harder."},
    {"q":"HubSpot vs Klaviyo for customer marketing?","a":"HubSpot is the broader B2B platform with strong CRM-marketing alignment and account-based features; Klaviyo is ecommerce-native with deep behavioral segmentation and SMS. B2B SaaS picks HubSpot; ecommerce picks Klaviyo."},
    {"q":"What metrics matter for customer marketing?","a":"Net Revenue Retention is the headline metric (target 110-130% for SaaS, 100-110% for ecommerce); Net Promoter Score and advocacy participation rate are leading indicators. Email open rate and click rate are vanity metrics for customer marketing because the relationship already exists."}
  ]'::jsonb, 'customer-success', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 9. ai-for-customer-data
(
  'ai-for-customer-data', 'AI for Customer Data', '🗂️',
  ARRAY['customer-service','data-analytics'], ARRAY['segment','rudderstack','hubspot','klaviyo'], 3,
  'Customer data platforms unify behavioral, transactional, and profile data into a single source of truth for downstream activation in marketing, sales, and product. AI-augmented CDPs now resolve identities across anonymous and known sessions, suggest segment definitions based on behavioral patterns, and surface data-quality issues before they reach activation tools. Segment leads enterprise CDPs with strong infrastructure and integrations; RudderStack ships open-source-leaning CDP for engineering-heavy teams; HubSpot and Klaviyo bundle lighter CDP capabilities into broader marketing platforms.',
  'We weighted: identity-resolution accuracy, schema-flexibility, integration breadth, and privacy-control depth.',
  '[
    {"q":"Segment vs RudderStack?","a":"Segment is the established leader with the largest integration catalog and easiest setup; RudderStack is open-source-leaning with stronger warehouse-native architecture and lower cost at scale. Engineering-heavy teams pick RudderStack; broader teams pick Segment."},
    {"q":"Do we need a CDP if we have HubSpot or Klaviyo?","a":"Not until the data complexity exceeds what the marketing platform can handle. HubSpot and Klaviyo include lighter CDP capabilities. Companies cross 50 employees with 5+ source systems and 5+ activation systems typically benefit from a dedicated CDP."},
    {"q":"How does identity resolution work?","a":"3 layers: deterministic matching on shared identifiers (email, phone, user-id); probabilistic matching on device fingerprints and session signals; first-party graph stitching across known and anonymous sessions. Top CDPs reach 85-95% resolution accuracy on multi-channel data."}
  ]'::jsonb, 'customer-success', 'advanced', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-cs-automation
(
  'ai-for-cs-automation', 'AI for CS Automation', '🔄',
  ARRAY['customer-service'], ARRAY['vitally','intercom','gainsight','planhat','totango'], 3,
  'Customer success automation in 2026 spans health-score monitoring, playbook execution, in-app messaging, and CSM-task generation, all triggered by usage signals rather than calendar dates. AI-augmented CS platforms now run hundreds of micro-playbooks in the background, surface only the human-judgment moments to CSMs, and auto-generate account briefs before every customer call. Vitally and Intercom lead Slack-native CS automation for product-led SaaS; Gainsight handles enterprise CS orchestration; Planhat ties automation to renewal forecasting; Totango focuses on usage-driven account management.',
  'Selection prioritized: playbook-trigger accuracy, in-app messaging depth, CSM-task generation quality, and integration with product analytics.',
  '[
    {"q":"What can CS automation realistically replace?","a":"3 categories: data-pull (account briefs, usage rollups, dashboard exports), routine outreach (renewal reminders, NPS surveys, onboarding nudges), and CSM-task generation (next-step surfacing). What it cannot replace: strategic relationship work, executive sponsor mapping, and judgment calls on at-risk accounts."},
    {"q":"Vitally vs Gainsight for CS automation?","a":"Vitally is the modern Slack-native option with faster setup and product-led-SaaS workflows; Gainsight has the deepest orchestration and enterprise scale. Companies under 200 customers default to Vitally; enterprise SaaS picks Gainsight."},
    {"q":"Does CS automation hurt customer relationships?","a":"Only when poorly tuned. Done well, automation removes the busywork that pulls CSMs away from customers; CSMs spend more time in higher-quality conversations. The risk is over-automation of nuanced moments (escalation, executive briefings) which should stay human."}
  ]'::jsonb, 'customer-success', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 11. ai-for-customer-experience
(
  'ai-for-customer-experience', 'AI for Customer Experience', '🌟',
  ARRAY['customer-service'], ARRAY['intercom','gainsight','sprinklr'], 3,
  'Customer experience (CX) is the cumulative impression a customer forms across every touchpoint with a brand, and AI now lets companies measure and improve CX across channels in real time. AI-augmented CX platforms unify support, success, and feedback signals; surface friction patterns across the journey; and orchestrate consistent experiences across channels. Intercom leads modern AI-first CX for product-led SaaS with conversational UX at the core; Gainsight covers post-sale CX with health-score depth; Sprinklr handles social and omnichannel CX at enterprise scale.',
  'We weighted: channel coverage, sentiment-detection accuracy, journey-mapping depth, and integration with product analytics.',
  '[
    {"q":"How do we actually measure CX?","a":"3 layers: transactional (CSAT, CES, NPS at touchpoint level); relational (annual NPS, customer health score, retention); experiential (journey maps, friction analysis, persona research). The blend gives a richer picture than any single metric, especially for B2B."},
    {"q":"Intercom vs Gainsight for CX?","a":"Intercom is conversational-CX-first with strongest in-product messaging and AI agent; Gainsight is health-score-and-renewal-first with deepest CSM orchestration. Product-led SaaS picks Intercom; enterprise CSM picks Gainsight."},
    {"q":"What is the ROI of CX investment?","a":"Companies in the top quartile of CX maturity see 1.5-2x revenue growth and 2-3x retention rates compared to bottom quartile, per Forrester research. The lift compounds: better CX leads to higher retention, higher referrals, and lower acquisition cost."}
  ]'::jsonb, 'customer-success', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 12. ai-for-customer-effort-score
(
  'ai-for-customer-effort-score', 'AI for Customer Effort Score', '📏',
  ARRAY['customer-service'], ARRAY['intercom','vitally','gainsight','sprig'], 3,
  'Customer Effort Score (CES) measures how easy it is for customers to get value from a product or resolve an issue, and it predicts retention better than NPS for many SaaS categories. AI-augmented CX platforms now run CES surveys at the moment of effort, correlate scores with friction events from product analytics, and surface specific friction patterns rather than aggregate scores. Intercom and Vitally collect CES inline with support and CS workflows; Gainsight ties CES to health scoring; Sprig embeds micro-surveys directly in product flows.',
  'Selection prioritized: in-context survey UX, sentiment-correlation depth, friction-mapping quality, and integration with product analytics.',
  '[
    {"q":"CES vs NPS for SaaS?","a":"CES predicts retention better at the touchpoint level (support resolution, onboarding, feature adoption); NPS is better as a relational annual signal. Most SaaS companies run both: CES at touchpoints, NPS quarterly. Using only one underweights the other dimension of customer signal."},
    {"q":"How is CES scored?","a":"Standard scale is 1-5 or 1-7 in response to a single question (typical phrasing: how easy was it to resolve your issue today). Score is typically averaged across responses; the strongest practice is to surface the verbatim comments alongside the score because the comments drive action."},
    {"q":"How often should we run CES?","a":"At every meaningful effort touchpoint (support resolution, onboarding step completion, feature first-use), with 5-10% sampling at high-traffic touchpoints to avoid survey fatigue. Aggregate weekly; investigate friction patterns monthly."}
  ]'::jsonb, 'customer-success', 'intermediate', 210,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === FINANCE (3) ===

-- 13. ai-for-fundraising-prep
(
  'ai-for-fundraising-prep', 'AI for Fundraising Prep', '💰',
  ARRAY['finance'], ARRAY['pilot','bench','airbase','docyt','zeni'], 3,
  'Fundraising prep used to mean a 4-6 week scramble to clean books, build a financial model, and assemble a data room. AI bookkeeping platforms now ship investor-ready books year-round, generate due-diligence packages on demand, and integrate with cap-table and data-room tools to automate the artifacts investors expect. Pilot leads venture-backed startup fundraising prep with multi-entity and revenue-recognition support; Bench targets seed-stage SMB fundraising; Airbase, Docyt, and Zeni cover spend management and bookkeeping for fundraising-stage companies.',
  'We weighted: GAAP-book quality, due-diligence package automation, cap-table integration, and historical-financial-cleanup depth.',
  '[
    {"q":"How early should fundraising prep start?","a":"6 months ahead for Series A, 9-12 months for Series B and beyond. The compression of recent rounds (8-12 weeks from pitch to term sheet) means the prep work has to be done before the process starts. Late prep is the single most common reason term sheets get pulled."},
    {"q":"Pilot vs Bench for fundraising prep?","a":"Pilot is tier-A for venture-backed Series A and beyond, with multi-entity support and ASC 606 revenue recognition; Bench fits pre-seed and seed companies under 5M ARR. Most Series A-stage companies need Pilot tier; earlier-stage can get away with Bench."},
    {"q":"What goes in a strong data room?","a":"5 core sections: corporate (formation docs, cap table, options), financial (historicals, model, MRR breakdown), commercial (top customers, churn, pipeline), legal (contracts, IP, employment), and product (roadmap, security posture). AI bookkeeping platforms automate the financial section; the rest is manual but template-able."}
  ]'::jsonb, 'finance', 'advanced', 390,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-cash-management
(
  'ai-for-cash-management', 'AI for Cash Management', '💵',
  ARRAY['finance'], ARRAY['ramp','brex','airbase','tipalti'], 3,
  'Cash management in 2026 spans operating cash, treasury yield optimization, AP timing, and FX hedging, all increasingly automated through AI corporate-finance platforms. AI-augmented platforms now forecast cash positions 60-90 days out, suggest yield-tier moves between checking and treasury accounts, and time AP runs to match cash inflows. Ramp and Brex lead AI corporate cards with embedded cash-management; Airbase ties cash management to AP workflow; Tipalti specializes in mass payouts and global AP cash management.',
  'Selection prioritized: cash-forecasting accuracy, treasury-yield integration, AP-timing automation, and integration with banking partners.',
  '[
    {"q":"Ramp vs Brex for cash management?","a":"Ramp has stronger spend controls and cash-forecasting for SMB and mid-market; Brex has stronger treasury yield (currently 4-5% APY on idle cash) and international coverage. Companies focused on spend control pick Ramp; companies optimizing yield on larger cash balances pick Brex."},
    {"q":"How accurate is AI cash forecasting?","a":"On 30-day horizons, 90-95% accuracy when payroll, AP, and recurring revenue are wired in. On 60-90 day horizons, accuracy drops to 75-85% because variable AR collection and large lumpy payments introduce noise. Treat the forecast as decision-support, not commitment."},
    {"q":"Should we keep cash in treasury or money-market?","a":"For most SaaS companies, idle cash above 6 months runway should sit in a treasury sweep (4-5% APY) rather than checking (often 0%). Below 6 months runway, keep more in checking for operational flexibility. The yield difference compounds meaningfully at 5M+ cash balances."}
  ]'::jsonb, 'finance', 'advanced', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 15. ai-for-financial-dashboards
(
  'ai-for-financial-dashboards', 'AI for Financial Dashboards', '📊',
  ARRAY['finance','data-analytics'], ARRAY['ramp','brex','airbase','chartmogul','baremetrics'], 3,
  'Financial dashboards in 2026 read directly from bookkeeping and billing platforms in real time rather than monthly spreadsheet exports. AI-augmented dashboards now surface anomalies (unexpected spend categories, MRR dips, AR aging) before the finance team notices, generate executive summaries automatically, and answer ad-hoc questions in natural language. Ramp, Brex, and Airbase ship spend dashboards integrated with corporate cards; ChartMogul and Baremetrics specialize in SaaS subscription metrics dashboards.',
  'We weighted: real-time accuracy, anomaly detection quality, ad-hoc query support, and integration with bookkeeping and billing.',
  '[
    {"q":"What metrics belong on a SaaS finance dashboard?","a":"5 headline metrics: MRR with breakdown by new, expansion, churn; cash runway in months; gross margin; net revenue retention; CAC payback. Beyond these, dashboards become noisy. Add deeper metrics on dedicated views rather than crowding the headline."},
    {"q":"ChartMogul vs Baremetrics for SaaS dashboards?","a":"ChartMogul has deeper subscription analytics and customer-lifecycle metrics; Baremetrics is faster to deploy with cleaner UX. SaaS companies above 1M ARR with complex billing pick ChartMogul; smaller or simpler-billing companies pick Baremetrics."},
    {"q":"How fresh should financial data be?","a":"Daily refresh is the standard for operational dashboards (cash, spend, MRR); real-time is overkill and creates noise. Monthly refresh is too stale; teams miss anomaly windows. Weekly refresh is acceptable only for stable mature companies; growth-stage companies need daily."}
  ]'::jsonb, 'finance', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DEV (1) ===

-- 16. ai-for-code-translation
(
  'ai-for-code-translation', 'AI for Code Translation', '🔁',
  ARRAY['dev'], ARRAY['cursor','copilot-microsoft','codeium','replit','tabnine'], 3,
  'Code translation between languages (Python to TypeScript, Java to Kotlin, COBOL to Java) used to be a multi-month manual exercise; AI coding assistants now produce idiomatic translations in minutes with the developer reviewing for edge cases. Cursor and Copilot lead translation quality through deep IDE context; Codeium and Tabnine offer enterprise-grade translation with on-prem deployment options; Replit handles full-app translation including dependencies and config.',
  'Selection prioritized: idiom quality, dependency-graph awareness, test-suite preservation, and IDE integration depth.',
  '[
    {"q":"Cursor vs Copilot for code translation?","a":"Cursor has deeper repository-context awareness which improves multi-file translation quality; Copilot has broader language coverage and tighter VS Code integration. Modern web stacks (TypeScript, React, Python) translate well in both; legacy languages (COBOL, mainframe) work better in Cursor with explicit context loading."},
    {"q":"How accurate is AI code translation?","a":"For greenfield-style code (modern frameworks, well-tested), 85-95% of the translation works without modification. For legacy code with implicit conventions, accuracy drops to 60-75%. Always run the existing test suite against the translation; fix what breaks rather than reading every line."},
    {"q":"When should we not use AI for translation?","a":"3 cases: (1) safety-critical code (medical, aerospace, finance core) where every line needs human verification anyway; (2) tightly-coupled-to-platform code (mainframe assembly, embedded firmware); (3) code where the original is undocumented and AI cannot infer intent. In those cases AI is still useful as a starting point but the time savings shrink."}
  ]'::jsonb, 'dev', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SUPPORT (4) ===

-- 17. ai-for-support-tickets
(
  'ai-for-support-tickets', 'AI for Support Tickets', '🎫',
  ARRAY['customer-service'], ARRAY['intercom','zendesk','gorgias','zoho-desk','freshchat'], 3,
  'Support ticket volume has grown 30-40% year-over-year for most SaaS and ecommerce companies, and headcount cannot scale linearly with volume. AI-augmented support platforms now classify and route tickets in seconds, draft response suggestions for agents, auto-resolve 30-50% of tier-1 tickets, and surface deflection opportunities back to the product team. Intercom and Zendesk lead AI-first ticketing for SaaS; Gorgias dominates Shopify and BigCommerce ecommerce ticketing; Zoho Desk and Freshchat cover SMB ticketing across verticals.',
  'We weighted: classification accuracy, auto-resolution depth, agent-assist quality, and integration with knowledge-base and product analytics.',
  '[
    {"q":"Intercom vs Zendesk for SaaS support?","a":"Intercom is the modern AI-first option with conversational UX and product-led-SaaS strengths; Zendesk has deeper enterprise features and broader integration ecosystem. SaaS under 500 customers typically picks Intercom; enterprise SaaS picks Zendesk."},
    {"q":"What ticket types should AI auto-resolve?","a":"Account-level questions (password reset, billing changes, plan upgrades), known-bug workarounds with documented solutions, and product-usage questions covered in the knowledge base. Anything requiring judgment, multi-step debugging, or relationship management should route to humans."},
    {"q":"How do we measure AI ticket-handling quality?","a":"3 metrics: (1) deflection rate (% of tickets resolved without agent touch); (2) escalation rate (% of AI-handled tickets that customers later escalate); (3) CSAT on AI-handled vs human-handled tickets. Healthy AI deployment lifts deflection without raising escalation or hurting CSAT."}
  ]'::jsonb, 'support', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 18. ai-for-escalation-management
(
  'ai-for-escalation-management', 'AI for Escalation Management', '🚨',
  ARRAY['customer-service'], ARRAY['intercom','gorgias','zoho-desk','freshchat','liveagent'], 3,
  'Escalation management is the difference between a frustrated customer and a churned one, and AI now surfaces escalation risk before customers explicitly demand a manager. AI-augmented support platforms now detect escalation cues (sentiment shift, repeated contact, account value), route at-risk tickets to senior agents automatically, and brief the senior agent with full context before pickup. Intercom and Gorgias lead escalation-routing for modern support; Zoho Desk and Freshchat cover SMB escalation workflows; LiveAgent handles voice and multi-channel escalation.',
  'Selection prioritized: sentiment-detection accuracy, routing-rule flexibility, agent-handoff context, and integration with CRM for account-value awareness.',
  '[
    {"q":"What signals predict escalation?","a":"5 strong signals: customer sentiment shift to negative within a thread, repeated contact within 48 hours on the same issue, mentions of churn or competitors, account value above a threshold, and tier-1 agent uncertainty (long handle time, multiple knowledge-base searches). AI platforms blend these in real time."},
    {"q":"How early should we escalate?","a":"At the first strong signal, not after the customer asks for a manager. Escalating proactively (with context already loaded for the senior agent) recovers 60-80% of at-risk situations; reactive escalation after explicit demand recovers 20-40%."},
    {"q":"Intercom vs Gorgias for escalation?","a":"Intercom has stronger sentiment-detection and proactive escalation features for SaaS; Gorgias is ecommerce-native with order-context awareness for escalation routing. SaaS picks Intercom; Shopify and BigCommerce stores pick Gorgias."}
  ]'::jsonb, 'support', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 19. ai-for-chat-routing
(
  'ai-for-chat-routing', 'AI for Chat Routing', '🚦',
  ARRAY['customer-service'], ARRAY['intercom','drift','gorgias','crisp','freshchat'], 3,
  'Chat routing in 2026 is multi-dimensional: language, account tier, expertise area, agent availability, and conversation intent all factor into who picks up what. AI-augmented chat platforms now classify intent at first message, route to the right specialist or AI agent automatically, and rebalance load across the team in real time. Intercom and Drift lead AI-first chat routing for B2B SaaS; Gorgias handles ecommerce chat routing with order context; Crisp and Freshchat cover SMB chat across verticals.',
  'We weighted: intent-classification accuracy, multi-criteria routing flexibility, agent-load balancing, and integration with CRM and product analytics.',
  '[
    {"q":"Intercom vs Drift for chat routing?","a":"Intercom has deeper SaaS product-led routing with strong in-app integration and AI agent (Fin); Drift is more sales-funnel-oriented with stronger pre-sales routing and account-based features. Product-support-heavy SaaS picks Intercom; sales-led SaaS picks Drift."},
    {"q":"Should AI agents handle the first message?","a":"Yes for most SaaS and ecommerce: AI agents handle 30-50% of first messages with high CSAT, and route the rest to humans with context. Pure-human first response is operationally expensive and slower; pure-AI handling without escalation paths frustrates customers on complex issues."},
    {"q":"How do we set up multi-criteria routing?","a":"3 layers: (1) language and channel (deterministic); (2) intent and topic (AI-classified); (3) account tier and value (CRM-driven). Apply layers in order; the first match routes the conversation. Avoid more than 5 routing rules per layer to prevent maintenance debt."}
  ]'::jsonb, 'support', 'intermediate', 390,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 20. ai-for-customer-service-automation
(
  'ai-for-customer-service-automation', 'AI for Customer Service Automation', '🤖',
  ARRAY['customer-service'], ARRAY['intercom','gorgias','forethought','freshchat','capacity'], 3,
  'Customer service automation has matured from rigid rule-based bots to AI agents that handle multi-turn conversations across email, chat, and voice. Modern AI service platforms now resolve 30-50% of tier-1 tickets end to end, hand off to humans with full context when needed, and continuously learn from outcomes. Intercom Fin leads SaaS service automation with conversational UX; Gorgias automates ecommerce ticketing with Shopify-native workflows; Forethought specializes in enterprise service AI with deep ticket-classification; Freshchat and Capacity cover broader SMB service automation.',
  'Selection prioritized: end-to-end resolution rate, conversational depth, handoff quality, and integration with knowledge-base and CRM.',
  '[
    {"q":"What auto-resolution rate is realistic?","a":"30-50% for SaaS and ecommerce after 60-90 days of tuning; 50-70% for very high-volume well-documented categories (account questions, order status). Going above 70% usually means the bot is forcing resolutions customers later escalate, which damages trust more than higher human-touch rates."},
    {"q":"Intercom Fin vs Forethought?","a":"Intercom Fin is tightly integrated with Intercom workflows and best for companies already on Intercom; Forethought is ATS-agnostic and integrates across multiple ticketing platforms. Existing Intercom users pick Fin; multi-platform enterprise picks Forethought."},
    {"q":"Does AI service hurt customer satisfaction?","a":"Only when poorly tuned. Done well (clear AI-vs-human signal, easy human escalation, accurate resolution), AI service ranks at 75-85% CSAT, comparable to human service for routine questions. Customers prefer fast accurate AI to slow accurate human for tier-1 issues."}
  ]'::jsonb, 'support', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === HR-RECRUITING (4) ===

-- 21. ai-for-employee-handbook
(
  'ai-for-employee-handbook', 'AI for Employee Handbook', '📖',
  ARRAY['hr'], ARRAY['notion-ai','document360','gitbook','coda','guru'], 3,
  'Employee handbooks used to be static PDFs that nobody read; modern AI-augmented knowledge platforms now turn them into searchable conversational resources where employees ask questions in natural language and get policy-cited answers. Notion AI and Coda treat the handbook as a structured doc with AI Q-and-A on top; Document360 and GitBook specialize in technical and policy documentation; Guru handles knowledge-management with verified-answer workflow.',
  'We weighted: search and Q-and-A quality, content-freshness workflow, multi-entity support, and integration with Slack and HRIS.',
  '[
    {"q":"Notion AI vs Document360 for handbooks?","a":"Notion AI is broader and works for companies already on Notion (and most are); Document360 is purpose-built for policy and technical docs with stronger version control and approval flows. Sub-200-employee companies pick Notion AI; mid-market and enterprise pick Document360."},
    {"q":"How often should the handbook be updated?","a":"Quarterly review at minimum, with immediate updates when a policy materially changes (compensation, leave, remote work). Tools should flag stale sections after 90-180 days of no edit. Handbooks more than 12 months stale lose employee trust and create legal exposure."},
    {"q":"Should we let AI answer policy questions directly?","a":"Yes for clear policy questions (PTO accrual, expense limits, benefits enrollment), with citation links to the source policy. No for nuanced or sensitive questions (harassment reporting, accommodation, termination) which should always route to HR humans even when the bot could answer."}
  ]'::jsonb, 'hr-recruiting', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 22. ai-for-onboarding-checklists
(
  'ai-for-onboarding-checklists', 'AI for Onboarding Checklists', '✅',
  ARRAY['hr'], ARRAY['lattice','rippling','gusto','bamboohr','notion-ai'], 3,
  'New-hire onboarding checklists determine whether week 1 is productive or chaotic, and AI-augmented platforms now generate role-specific checklists from a job description, route tasks to the right department automatically, and surface bottlenecks (missing equipment, incomplete I-9) before day 1. Lattice and 15Five tie onboarding to performance cycles; Rippling and Gusto integrate onboarding with payroll and benefits; BambooHR covers SMB HRIS-driven onboarding; Notion AI handles flexible doc-based onboarding for tech-forward teams.',
  'Selection prioritized: checklist-generation quality, multi-department routing, equipment-and-access automation, and integration with HRIS and payroll.',
  '[
    {"q":"What goes in a strong onboarding checklist?","a":"4 categories: (1) admin (paperwork, equipment, accounts); (2) people (manager 1-on-1s, team intros, buddy assignment); (3) learning (product training, role-specific guides); (4) goals (30-60-90 day expectations). Strong checklists hit all 4 in week 1."},
    {"q":"Rippling vs BambooHR for onboarding?","a":"Rippling is broader (HRIS, payroll, IT, finance) with deeper automation across departments; BambooHR is HRIS-focused with cleaner UX for SMB. Companies under 200 employees often pick BambooHR; companies with growing IT and finance complexity pick Rippling."},
    {"q":"How long should onboarding take?","a":"30 days for individual contributor roles in established companies; 60-90 days for management or specialist roles; 90-120 days for executive roles. Shorter onboarding correlates with higher 90-day attrition; over-investing in onboarding consistently lifts retention."}
  ]'::jsonb, 'hr-recruiting', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 23. ai-for-compensation-management
(
  'ai-for-compensation-management', 'AI for Compensation Management', '💸',
  ARRAY['hr'], ARRAY['rippling','lattice','gusto','15five','bamboohr'], 3,
  'Compensation management spans benchmarking, band design, merit-cycle execution, equity grants, and pay-equity audits, and AI-augmented HRIS platforms now automate most of the mechanical work. AI platforms surface pay-equity risk by demographic, suggest market-aligned merit-cycle increases, and route approvals across managers and HR in parallel. Rippling and BambooHR lead HRIS-driven compensation for SMB and mid-market; Lattice and 15Five tie compensation to performance cycles; Gusto handles payroll-integrated compensation for SMB.',
  'We weighted: benchmark-data accuracy, band-design support, merit-cycle workflow, and pay-equity-audit depth.',
  '[
    {"q":"How do we set compensation bands?","a":"3 inputs: market data (Radford, Pave, or built-in HRIS benchmarks), internal job-leveling, and budget constraints. Bands typically span 20-30% from band minimum to maximum, with target at the 50th percentile of market for most roles. Top-tier roles target 75th percentile to compete."},
    {"q":"Rippling vs Lattice for comp?","a":"Rippling integrates compensation with payroll and benefits across the full HRIS; Lattice ties compensation to performance reviews and goal cycles. Operationally-led companies pick Rippling; performance-led companies pick Lattice."},
    {"q":"How often should we audit pay equity?","a":"Annually at minimum, with mid-cycle checks during merit and promotion rounds. AI platforms surface gaps by demographic in real time; humans investigate root causes (justified for skill or tenure differences vs unexplained). Companies that audit annually see 30-50% lower regulatory exposure."}
  ]'::jsonb, 'hr-recruiting', 'advanced', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 24. ai-for-skills-assessment
(
  'ai-for-skills-assessment', 'AI for Skills Assessment', '🎓',
  ARRAY['hr'], ARRAY['lattice','culture-amp','15five','eightfold'], 3,
  'Skills assessment used to mean annual performance review surveys filled out from memory; modern AI-augmented platforms now build skill profiles from project work, peer feedback, and learning history continuously. AI-augmented HRIS platforms surface skill gaps against role expectations, suggest learning paths to close gaps, and aggregate skill data to inform internal mobility and workforce planning. Lattice and Culture Amp lead skills-assessment inside performance platforms; 15Five ties skills to weekly check-ins; Eightfold leads enterprise AI talent intelligence with skill-graph at the core.',
  'Selection prioritized: skill-graph depth, assessment-input quality, learning-path generation, and integration with performance and learning systems.',
  '[
    {"q":"How do AI platforms build skill profiles?","a":"3 inputs: explicit (self-assessment, manager assessment, peer feedback); implicit (project work, code commits, document authorship); learning history (courses completed, certifications earned). Top platforms blend all three for the richest profile; explicit-only platforms drift from reality fast."},
    {"q":"Lattice vs Eightfold for skills?","a":"Lattice ships skills inside the performance review platform with cleaner UX for sub-1000-employee companies; Eightfold has the deepest skill graph (millions of skills) and works at enterprise scale. Sub-1000 employees pick Lattice; 5000+ employees pick Eightfold."},
    {"q":"Should skills be tied to compensation?","a":"Indirectly through role-level expectations: skills define readiness for the next role-level, role-level determines compensation. Direct skill-to-pay creates gaming dynamics where employees over-claim skills. Tie skills to mobility and development, not directly to pay."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === OPS (1) ===

-- 25. ai-for-team-coordination
(
  'ai-for-team-coordination', 'AI for Team Coordination', '🤝',
  ARRAY['ops'], ARRAY['slack','asana','monday','clickup','notion-ai'], 3,
  'Team coordination across 5-50 person teams requires visible work, clear ownership, and asynchronous decision-making, and AI-augmented work platforms now surface what is moving, what is blocked, and who needs what across the team in real time. AI platforms generate weekly team summaries, surface dependency risks across project lines, and suggest workload rebalancing when a team member is overloaded. Slack and Notion lead async team coordination for tech-forward teams; Asana, Monday, and ClickUp anchor structured project coordination across verticals.',
  'We weighted: dependency-tracking depth, summary-generation quality, workload-balancing intelligence, and integration with chat and dev tools.',
  '[
    {"q":"Slack vs Asana for team coordination?","a":"Slack handles real-time and async conversation; Asana handles structured project work. Most teams need both: Slack for conversation, Asana or similar for tracking deliverables. Companies that try to coordinate from Slack alone hit a ceiling around 10-15 people; structured platforms scale further."},
    {"q":"How often should teams hold sync meetings?","a":"Weekly for status, monthly for planning, quarterly for strategy. Daily standups work for engineering teams; non-engineering teams typically over-meet at daily cadence. AI platforms generate async status summaries that replace 50-70% of routine sync meetings."},
    {"q":"Notion vs ClickUp for team coordination?","a":"Notion is doc-first with lighter project tracking; ClickUp is project-first with embedded docs. Tech-forward teams that want flexible workspaces pick Notion; teams that need structured PM with timelines and dependencies pick ClickUp."}
  ]'::jsonb, 'ops', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (3) ===

-- 26. ai-for-brand-design
(
  'ai-for-brand-design', 'AI for Brand Design', '🎨',
  ARRAY['design'], ARRAY['figma','canva-ai','adobe-firefly','uizard'], 3,
  'Brand design (logos, color systems, typography, brand guidelines) used to require a senior designer or external agency for any new brand asset. AI-augmented design platforms now generate brand-aligned assets from a brand-system definition, enforce brand consistency across team output, and produce variations (social, web, print) automatically. Figma is the canvas where brand systems live and AI plug-ins generate variations; Canva AI handles brand-aligned content generation for non-designers; Adobe Firefly produces high-quality brand imagery at scale; Uizard generates branded UI mockups from prompts.',
  'Selection prioritized: brand-system enforcement, asset-generation quality, brand-consistency checking, and integration with design and content workflows.',
  '[
    {"q":"Figma vs Canva for brand design?","a":"Figma is the design-first platform where brand systems are defined and maintained (color tokens, typography, component libraries); Canva is the consumption-first platform where non-designers create brand-aligned content. Most teams need both: Figma for the brand system, Canva for execution at scale."},
    {"q":"Can AI replace a brand designer?","a":"For asset variation and consistency enforcement, yes. For brand strategy, identity creation, and original logo design, no. AI accelerates execution after the brand strategy and identity are defined; the strategic and creative-direction work still belongs to senior designers."},
    {"q":"How do we keep AI output on-brand?","a":"3 layers: (1) brand-system definition in Figma or a DAM with explicit color, typography, and component tokens; (2) AI tools constrained to those tokens (Canva brand kits, Figma plug-ins with brand guards); (3) review workflow where senior designer approves AI-generated assets before publication."}
  ]'::jsonb, 'design', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 27. ai-for-banner-ads
(
  'ai-for-banner-ads', 'AI for Banner Ads', '🖼️',
  ARRAY['design','marketing'], ARRAY['canva-ai','figma','adobe-firefly'], 3,
  'Banner ad production used to require a designer producing 20-50 size variations per campaign manually. AI-augmented design platforms now generate brand-aligned banner sets from a single hero asset, resize automatically across IAB standard sizes, and produce A-B test variations at scale. Canva AI leads non-designer banner production with template-driven workflows; Figma anchors designer-led banner systems with auto-layout and plug-ins; Adobe Firefly produces high-quality original imagery for hero assets.',
  'We weighted: multi-size auto-resize quality, brand-system enforcement, A-B variation generation, and integration with ad platforms.',
  '[
    {"q":"How many banner variations should we make?","a":"5-10 variations per campaign across sizes is the sweet spot: enough to cover IAB standard sizes (300x250, 728x90, 320x50, 160x600) plus 2-3 creative variations for A-B testing. Beyond 20 variations the marginal lift drops sharply and creative fatigue rises."},
    {"q":"Canva AI vs Figma for banner ads?","a":"Canva AI is faster for non-designer marketing teams with template-driven workflows; Figma is the choice for designer-led brand-system-aligned banners with deeper customization. Marketing-led campaigns pick Canva; design-led brand campaigns pick Figma."},
    {"q":"Should AI write banner ad copy?","a":"AI is useful for drafting and A-B variations of headline and CTA copy; the strategist should set the value proposition and brand voice. Pure-AI banner copy underperforms human-strategist copy by 15-25% on click-through; AI-assisted human copy outperforms pure-human by 5-10% through faster variation testing."}
  ]'::jsonb, 'design', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 28. ai-for-character-design
(
  'ai-for-character-design', 'AI for Character Design', '🦸',
  ARRAY['design'], ARRAY['midjourney','leonardo-ai','flux','krea-ai'], 3,
  'Character design for games, animation, and brand mascots used to take a designer days to weeks per character; AI image-generation platforms now produce dozens of character iterations in minutes for the designer to refine. Midjourney leads cinematic-quality character imagery with strong style coherence; Leonardo AI specializes in game-asset character production with consistent character workflows; Flux produces highly photorealistic and stylized characters; Krea AI focuses on real-time creative iteration with strong style transfer.',
  'Selection prioritized: character-consistency across iterations, style-control depth, multi-pose generation, and licensing clarity for commercial use.',
  '[
    {"q":"Midjourney vs Leonardo AI for character design?","a":"Midjourney has the highest cinematic quality for hero character art; Leonardo AI has stronger game-asset workflows with character-sheet generation and consistent multi-pose output. Concept art and brand mascots pick Midjourney; game development picks Leonardo."},
    {"q":"How do we keep a character consistent across poses?","a":"3 techniques: (1) reference-image approach where the first generation becomes the base for variations; (2) tools with explicit character sheets (Leonardo AI, ComfyUI workflows); (3) LoRA fine-tuning on the character for tools that support it. The simplest start is the reference-image approach in Midjourney v6."},
    {"q":"Can we use AI characters commercially?","a":"Yes for most major platforms (Midjourney, Leonardo, Flux Schnell) under their commercial license tiers; check the specific platform license and the country IP context. AI-generated images cannot currently be copyrighted in the US (Thaler v Perlmutter 2023), but they can be used commercially. Licensing varies by tool."}
  ]'::jsonb, 'design', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SALES (4) ===

-- 29. ai-for-buyer-enablement
(
  'ai-for-buyer-enablement', 'AI for Buyer Enablement', '🛍️',
  ARRAY['sales'], ARRAY['gamma-app','pitch','qwilr','storydoc','beautiful-ai'], 3,
  'Buyer enablement (giving buyers the content and context they need to make purchase decisions) replaced traditional seller-led pitches at most modern B2B companies. AI-augmented enablement platforms now generate personalized buyer microsites, surface usage signals when buyers engage with content, and adapt the narrative based on which sections the buyer reads. Gamma and Pitch lead AI-first interactive presentations; Qwilr and Storydoc specialize in interactive proposals with engagement tracking; Beautiful AI handles AI-generated polished decks for sales motion.',
  'We weighted: interactive-content generation quality, engagement tracking depth, personalization at scale, and integration with CRM.',
  '[
    {"q":"Why is buyer enablement different from sales enablement?","a":"Sales enablement equips sellers; buyer enablement equips buyers directly. Modern B2B buyers complete 60-80% of the journey before talking to a seller (per Gartner research); the buyer-enablement content they consume independently determines the deal. Companies that ship strong buyer-enablement content win 20-30% more deals."},
    {"q":"Qwilr vs Storydoc for proposals?","a":"Qwilr is the established interactive-proposal platform with strong CRM integration and analytics; Storydoc has stronger AI-generated narrative and visual storytelling. Sales-ops-led companies pick Qwilr; growth-stage companies that want differentiated narrative pick Storydoc."},
    {"q":"What goes in a buyer enablement asset?","a":"5 core sections: problem framing for the buyer cohort, solution narrative tied to specific outcomes, customer-proof (case studies, ROI data), pricing transparency, and next-step pathing. Avoid generic feature checklists; buyers consume narrative-driven content 3-5x more deeply than feature-list content."}
  ]'::jsonb, 'sales', 'intermediate', 390,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 30. ai-for-sales-presentations
(
  'ai-for-sales-presentations', 'AI for Sales Presentations', '🎤',
  ARRAY['sales'], ARRAY['gamma-app','pitch','beautiful-ai','storydoc'], 3,
  'Sales presentations in 2026 are interactive web experiences rather than static PowerPoint decks, and AI-augmented platforms now generate brand-aligned decks from a prompt or outline in minutes. AI platforms produce coherent narrative structures, generate brand-aligned visuals, and track buyer engagement section by section after delivery. Gamma leads AI-first interactive presentations with strong narrative generation; Pitch handles team-collaborative pitch decks for venture-backed companies; Beautiful AI specializes in polished AI-generated decks; Storydoc focuses on interactive web-based presentations with engagement tracking.',
  'Selection prioritized: narrative generation quality, brand-alignment, post-meeting engagement tracking, and integration with CRM.',
  '[
    {"q":"Gamma vs Pitch for sales decks?","a":"Gamma is faster (AI generates a coherent deck from a prompt in seconds) and works well for solo sellers; Pitch is team-collaborative with stronger pitch-template library and venture-backed-company workflows. Solo SDRs and AEs pick Gamma; sales teams with structured pitch processes pick Pitch."},
    {"q":"How long should a sales deck be?","a":"10-15 slides for a cold first-call deck; 20-30 slides for a discovery-stage deck with custom content. Beyond 30 slides the buyer disengages; under 10 slides leaves the buyer with unanswered questions. Modern AI platforms generate the right length from buyer-stage context."},
    {"q":"Should AI write sales-deck copy?","a":"AI is useful for first-draft narrative structure and section copy; the seller should add specific customer context, proof points, and pricing details. Pure-AI decks underperform seller-customized decks by 30-40% on close rate; AI-drafted seller-customized decks outperform pure-seller decks by 10-15% through better structure."}
  ]'::jsonb, 'sales', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 31. ai-for-pipeline-coaching
(
  'ai-for-pipeline-coaching', 'AI for Pipeline Coaching', '📞',
  ARRAY['sales'], ARRAY['gong-io','avoma','modjo','sembly-ai'], 3,
  'Pipeline coaching is the difference between a sales manager who scales a team to quota and one who hits quota only because of star reps. AI-augmented revenue intelligence platforms now record and transcribe every call, surface coaching moments by deal stage, and generate manager-coaching plans personalized per rep. Gong leads enterprise revenue intelligence with the deepest coaching analytics; Avoma and Modjo ship modern AI-first coaching for mid-market sales teams; Sembly AI handles meeting intelligence with coaching extensions.',
  'We weighted: call-analysis depth, coaching-moment extraction quality, manager-workflow integration, and rep-personalization features.',
  '[
    {"q":"Gong vs Avoma for pipeline coaching?","a":"Gong is the enterprise leader with deepest analytics and largest call-data set for benchmarks; Avoma is a faster-to-deploy mid-market option with cleaner UX. Sales teams above 30 reps and with structured coaching processes pick Gong; mid-market teams under 30 reps pick Avoma."},
    {"q":"How does AI surface coaching moments?","a":"3 patterns: (1) deal-stage transitions (discovery to demo, demo to proposal) where rep behavior diverges from team-average; (2) language patterns (talk-listen ratio, monolog length, question depth); (3) buyer-signal handling (objections, competitor mentions, pricing pushback). Manager reviews 2-3 moments per rep per week."},
    {"q":"How often should managers coach?","a":"Weekly 1-on-1 coaching conversations for individual contributors, with AI surfacing 2-3 specific call moments to discuss. Monthly deal-review coaching for stage-stuck deals. Quarterly skill-development reviews tied to manager growth plans. AI removes the prep work so managers can focus on the conversation itself."}
  ]'::jsonb, 'sales', 'advanced', 210,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 32. ai-for-objection-handling
(
  'ai-for-objection-handling', 'AI for Objection Handling', '🛡️',
  ARRAY['sales'], ARRAY['gong-io','lavender','modjo','sembly-ai'], 3,
  'Objection handling is the highest-leverage skill in sales: closing reps handle the same 10 objections they have heard hundreds of times with stronger responses than rookie reps. AI-augmented sales platforms now extract objections from every call, build an objection-response library from the team-average best answer, and coach reps in real time during live calls. Gong leads enterprise objection-handling analytics; Lavender ships AI coaching for cold-email and prospecting objections; Modjo focuses on European mid-market objection coaching; Sembly AI extracts objections from meeting transcripts.',
  'Selection prioritized: objection-extraction accuracy, response-library quality, real-time coaching depth, and integration with CRM.',
  '[
    {"q":"What are the most common B2B objections?","a":"5 patterns cover 80% of B2B objections: pricing (too expensive, no budget), timing (not now, internal priority shift), authority (need to check with team or boss), competitor (already use X, evaluating Y), and value (unclear ROI, alternative DIY). Strong response libraries cover all 5."},
    {"q":"Gong vs Lavender for objection handling?","a":"Gong covers full-funnel objection handling across calls and meetings with enterprise-grade analytics; Lavender is cold-email and prospecting focused with real-time coaching while writing. Pipeline-stage objection coaching picks Gong; outbound-cadence objection coaching picks Lavender."},
    {"q":"Can AI generate objection responses?","a":"AI generates a strong first-draft response by analyzing how top reps on the team handle the objection; the rep should customize for the specific buyer context and objection nuance. Pure-AI responses feel generic and underperform; AI-drafted rep-customized responses match top-rep performance with 50% less prep time."}
  ]'::jsonb, 'sales', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === MARKETING (3) ===

-- 33. ai-for-content-promotion
(
  'ai-for-content-promotion', 'AI for Content Promotion', '📣',
  ARRAY['marketing'], ARRAY['buffer','hootsuite','sprout-social','publer','metricool'], 3,
  'Content promotion (the work of getting an asset in front of the right audiences after it ships) consumes 50-70% of the value of any content investment when done well and 5-10% when done poorly. AI-augmented social and content platforms now schedule content across channels with channel-optimized formats, identify high-performing audience segments to amplify, and surface evergreen-promotion opportunities for older content. Buffer and Hootsuite lead multi-channel social scheduling; Sprout Social anchors enterprise social with deeper analytics; Publer and Metricool target SMB and mid-market with AI-first scheduling.',
  'We weighted: cross-channel format adaptation, audience-amplification intelligence, evergreen-promotion automation, and analytics depth.',
  '[
    {"q":"How much should we promote vs create?","a":"Many marketing teams create 70-80% and promote 20-30%; the inverted ratio (create 30-40%, promote 60-70%) lifts ROI 3-5x for most established companies. New companies need more creation; mature companies leave more value on the table by under-promoting existing content."},
    {"q":"Buffer vs Hootsuite?","a":"Buffer has cleaner UX and faster setup, well-suited to SMB and content-creator teams; Hootsuite has deeper enterprise features and larger integration ecosystem. SMB and modern content teams pick Buffer; enterprise marketing picks Hootsuite."},
    {"q":"What channels should we promote on?","a":"3 layers: (1) owned (email list, blog, podcast); (2) earned (social shares, partner mentions, PR); (3) paid (sponsored social, search, display retargeting). Strong promotion mixes all 3 with budget weighted to where the buyer audience actually is. B2B leans owned and earned; ecommerce leans paid."}
  ]'::jsonb, 'marketing', 'intermediate', 390,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 34. ai-for-conversion-optimization
(
  'ai-for-conversion-optimization', 'AI for Conversion Optimization', '🎯',
  ARRAY['marketing'], ARRAY['hubspot','klaviyo','intercom'], 3,
  'Conversion optimization (lifting the % of visitors who take a target action) is one of the highest-leverage marketing investments because compounding gains stack across channels. AI-augmented platforms now run automated A-B tests, personalize content by visitor segment, and surface friction patterns from session-replay data. HubSpot leads B2B conversion optimization with strong CRM-marketing alignment; Klaviyo handles ecommerce conversion with deep behavioral segmentation and email-flow optimization; Intercom optimizes in-product conversion with contextual messaging.',
  'Selection prioritized: A-B testing depth, segmentation flexibility, friction-detection quality, and integration with analytics and CRM.',
  '[
    {"q":"What conversion rates are realistic?","a":"Benchmarks vary by industry: B2B SaaS landing pages convert 2-5%; ecommerce product pages convert 1-3%; B2B free-trial signup pages convert 8-15%. Conversion-rate growth from 2% to 4% doubles revenue at the same traffic; consistent CRO investment compounds dramatically over 12-24 months."},
    {"q":"HubSpot vs Klaviyo for conversion?","a":"HubSpot is the broader B2B platform with strong CRM-marketing alignment for funnel optimization; Klaviyo is ecommerce-native with deep behavioral segmentation and email-flow optimization. B2B SaaS picks HubSpot; ecommerce picks Klaviyo."},
    {"q":"Should we A-B test everything?","a":"No. A-B test high-leverage moments (pricing-page CTAs, signup forms, top-of-funnel headlines) with clear hypotheses. Skip A-B testing on low-traffic pages, marginal copy tweaks, and brand-equity choices that need consistency. Tests need 5000-10000 visitors per variant for reliable signal."}
  ]'::jsonb, 'marketing', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 35. ai-for-marketing-operations
(
  'ai-for-marketing-operations', 'AI for Marketing Operations', '⚙️',
  ARRAY['marketing','ops'], ARRAY['hubspot','activecampaign','mailchimp','klaviyo'], 3,
  'Marketing operations is the back-end discipline that makes marketing campaigns actually run: data flows, automation logic, attribution, lead routing, and tech-stack governance. AI-augmented MOps platforms now build automation flows from natural language, surface tech-stack overlap and waste, and audit data quality continuously. HubSpot leads B2B marketing operations with the deepest workflow automation and CRM integration; ActiveCampaign covers SMB and mid-market MOps with strong automation flexibility; Mailchimp handles SMB MOps across verticals; Klaviyo is the ecommerce MOps leader with deep behavioral data infrastructure.',
  'We weighted: automation-flow flexibility, data-quality audit depth, attribution sophistication, and integration with CRM and CDP.',
  '[
    {"q":"What does marketing operations actually own?","a":"4 functions: (1) tech-stack architecture (which tools, how they integrate); (2) automation logic (lead routing, scoring, nurturing flows); (3) data quality (CRM hygiene, deduplication, field standards); (4) attribution and reporting. MOps lives between marketing strategy and engineering execution."},
    {"q":"HubSpot vs ActiveCampaign for MOps?","a":"HubSpot is the broader B2B platform with the deepest CRM-marketing-sales alignment; ActiveCampaign has more flexible automation logic at lower price point for SMB and mid-market. Companies above 100 employees with sales-marketing alignment needs pick HubSpot; SMB with automation-heavy needs pick ActiveCampaign."},
    {"q":"How do we measure MOps success?","a":"3 leading indicators: (1) data-quality score (% of leads with clean fields); (2) campaign-deployment speed (time from brief to live); (3) automation reliability (% of flows running without errors). Lagging indicator: marketing-attributed pipeline contribution. MOps that scores well on leading indicators delivers stronger pipeline."}
  ]'::jsonb, 'marketing', 'advanced', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === WRITING (3) ===

-- 36. ai-for-microcopy
(
  'ai-for-microcopy', 'AI for Microcopy', '✏️',
  ARRAY['writing','design'], ARRAY['jasper','copy-ai','anyword'], 3,
  'Microcopy (button labels, error messages, empty states, form helper text, tooltips) shapes user experience more than long-form copy yet rarely gets dedicated attention. AI-augmented writing platforms now generate brand-voice-aligned microcopy variants in seconds, A-B test microcopy at scale, and surface friction patterns from product analytics that microcopy can fix. Jasper and Copy AI lead general-purpose AI writing with brand-voice training; Anyword specializes in conversion-optimized copy with A-B testing infrastructure.',
  'Selection prioritized: brand-voice consistency, A-B variation generation quality, character-count constraints, and integration with design tools.',
  '[
    {"q":"How does microcopy affect conversion?","a":"Significantly. Better button labels lift CTR 5-25% per Nielsen Norman Group studies; clearer error messages reduce form abandonment 10-30%; warm empty-state copy lifts feature adoption 15-40%. Compounded across thousands of touchpoints, microcopy quality drives meaningful product-wide conversion lift."},
    {"q":"Jasper vs Copy AI for microcopy?","a":"Jasper has stronger brand-voice training and longer-form context support; Copy AI has cleaner microcopy templates and faster variation generation. Brand-voice-strict companies pick Jasper; speed-of-execution-focused teams pick Copy AI."},
    {"q":"Should designers or writers own microcopy?","a":"UX writers when they exist (companies above 100 employees often have them); designers and PMs in their absence. The worst pattern is microcopy as an afterthought during dev handoff. Strong teams treat microcopy as a design deliverable that ships with the mockup, not after."}
  ]'::jsonb, 'writing', 'beginner', 210,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 37. ai-for-product-copy
(
  'ai-for-product-copy', 'AI for Product Copy', '🛒',
  ARRAY['writing','marketing'], ARRAY['jasper','copy-ai','writesonic','anyword','hypotenuse-ai'], 3,
  'Product copy (descriptions, feature pages, pricing pages, comparison pages) drives 20-40% of purchase decisions yet often stays generic and feature-list-driven. AI-augmented writing platforms now generate benefit-focused product copy from feature inputs, optimize for SEO and conversion in parallel, and produce variations for A-B testing across audience segments. Jasper and Copy AI lead general AI writing for product teams; Writesonic and Anyword specialize in conversion-optimized product copy; Hypotenuse AI handles bulk product-description generation for ecommerce catalogs.',
  'We weighted: benefit-extraction quality from feature inputs, SEO-optimization depth, A-B variation generation, and bulk-output capability.',
  '[
    {"q":"What makes strong product copy?","a":"3 layers: (1) clear value proposition tied to a specific buyer outcome; (2) proof points (data, customer quotes, comparisons) that back the value claim; (3) clear next-step CTA. Strong product copy answers what does this do for me, why should I trust you, and what should I do now."},
    {"q":"Jasper vs Hypotenuse AI for ecommerce?","a":"Jasper is a general AI writer with stronger brand voice for premium products; Hypotenuse AI is built for ecommerce catalog scale with bulk-description generation. Boutique ecommerce brands pick Jasper; high-SKU-count catalogs (1000+ products) pick Hypotenuse."},
    {"q":"Should AI write all product copy?","a":"AI handles standard descriptions and benefit-extraction well; humans should own positioning copy (homepage hero, pricing-page narrative, brand voice) and customer-quote selection. The mix lifts both speed (AI for the long tail) and quality (humans for the high-leverage moments)."}
  ]'::jsonb, 'writing', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 38. ai-for-script-writing
(
  'ai-for-script-writing', 'AI for Script Writing', '🎬',
  ARRAY['writing'], ARRAY['sudowrite','jasper','copy-ai','writesonic','rytr'], 3,
  'Script writing for video (YouTube, social, course content, internal training) requires a structure (hook, setup, payoff) that differs significantly from blog or email writing. AI-augmented writing platforms now generate scripts from a topic outline with appropriate pacing for the target medium, suggest visual cues alongside dialogue, and produce multiple format variations (long-form, short-form, vertical). Sudowrite leads narrative-style script writing for creative teams; Jasper and Copy AI handle marketing video scripts at scale; Writesonic and Rytr cover SMB script writing across formats.',
  'Selection prioritized: medium-specific pacing, narrative structure, visual-cue generation, and integration with video editing tools.',
  '[
    {"q":"How long should a YouTube script be?","a":"Long-form YouTube (8-12 minutes) needs roughly 1500-2200 words; YouTube Shorts under 60 seconds needs 100-150 words; tutorial videos can run 2000-3500 words depending on technical depth. AI platforms estimate runtime from word count and pacing; treat as a starting point and read aloud for final timing."},
    {"q":"Sudowrite vs Jasper for scripts?","a":"Sudowrite has stronger narrative-structure tools (story beats, character voice consistency) for creative or storytelling video; Jasper is faster for marketing-style scripts with brand-voice consistency. Creator-led narrative video picks Sudowrite; marketing-led product video picks Jasper."},
    {"q":"Should AI write the hook?","a":"AI generates a strong first-pass hook, but the creator should own the final version because the hook carries the most viewer-retention weight. The first 3-7 seconds determine 30-50% of total watch time; that 3-7 seconds deserves human craft even when the rest of the script is AI-drafted."}
  ]'::jsonb, 'writing', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === PRODUCTIVITY (3) ===

-- 39. ai-for-time-blocking
(
  'ai-for-time-blocking', 'AI for Time Blocking', '⏰',
  ARRAY['productivity'], ARRAY['reclaim-ai','motion','sunsama','cal-com'], 3,
  'Time blocking (assigning calendar slots to specific work types rather than reacting to whatever lands in the inbox) is one of the highest-leverage productivity habits, and AI calendar platforms now automate the scheduling work that makes time blocking actually work. AI calendar platforms now auto-schedule focus blocks around meetings, defend high-leverage work from low-priority interruptions, and reschedule blocks when conflicts arise. Reclaim AI leads automated time-blocking with smart-defense for focus work; Motion blends time-blocking with task-management auto-scheduling; Sunsama focuses on daily-planning rituals; Cal.com handles meeting scheduling that respects time-blocking discipline.',
  'We weighted: auto-scheduling intelligence, conflict-resolution UX, focus-defense depth, and integration with task and calendar tools.',
  '[
    {"q":"Reclaim AI vs Motion?","a":"Reclaim AI is calendar-first with focus-defense as the headline feature, well-suited to people whose primary tool is the calendar; Motion is task-first with auto-scheduling on top, well-suited to people whose primary tool is the task list. Calendar-led individuals pick Reclaim; task-led individuals pick Motion."},
    {"q":"How long should focus blocks be?","a":"90-minute blocks are the sweet spot for deep work matching ultradian rhythm; 25-minute Pomodoro blocks work for shallow execution work; 4-hour deep-work blocks work for senior individual contributors with minimal interruption. Beyond 4 hours, attention-fade dominates and quality drops."},
    {"q":"Should we time-block every hour?","a":"No. Time-block 60-70% of the workday for committed work; leave 30-40% buffer for ad-hoc collaboration, urgent issues, and recovery. Calendars time-blocked above 80% become brittle; small disruptions cascade into compounding rescheduling work."}
  ]'::jsonb, 'productivity', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 40. ai-for-meeting-templates
(
  'ai-for-meeting-templates', 'AI for Meeting Templates', '📋',
  ARRAY['productivity'], ARRAY['notion-ai','fireflies-ai','coda'], 3,
  'Meeting templates (1-on-1 agendas, project-status reviews, decision-making frameworks) raise meeting quality more than any individual facilitation skill, yet most teams meet without templates and end with unclear outcomes. AI-augmented productivity platforms now suggest the right template by meeting type, pre-populate context from prior meetings and project state, and auto-capture decisions and action items. Notion AI and Coda lead doc-based meeting templates with rich integrations; Fireflies AI handles meeting recording and transcript-driven follow-up alongside templates.',
  'Selection prioritized: template-library depth, context-pre-population quality, decision-capture workflow, and integration with calendar and task tools.',
  '[
    {"q":"What meeting templates have the highest leverage?","a":"4 templates cover 80% of recurring meetings: 1-on-1 (manager-direct conversation cadence), project status (weekly cross-functional updates), decision-making framework (DACI or similar for major decisions), and retrospective (post-launch or post-incident). Teams that template these 4 cut meeting time 20-30%."},
    {"q":"Notion AI vs Fireflies AI for meeting templates?","a":"Notion AI is the doc-first option where templates live alongside other team workspaces; Fireflies AI is recording-first with templates that auto-fill from transcripts. Companies that already run on Notion pick Notion AI; companies focused on async-first culture pick Fireflies."},
    {"q":"Should every meeting have an agenda?","a":"Yes for any meeting longer than 15 minutes with more than 2 attendees. Agendas filter out meetings that should be async messages; AI platforms generate agendas from a one-line description, removing the friction that makes people skip the step. Cancel meetings without agendas; the discipline compounds quickly."}
  ]'::jsonb, 'productivity', 'beginner', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 41. ai-for-team-performance
(
  'ai-for-team-performance', 'AI for Team Performance', '🚀',
  ARRAY['productivity','hr'], ARRAY['lattice','culture-amp','15five'], 3,
  'Team performance management spans goal-setting, weekly check-ins, performance reviews, and development conversations, and AI-augmented platforms now make the cadence sustainable rather than burdensome. AI platforms now auto-summarize check-in patterns, surface goal-progress risks, generate development plans from skill profiles, and produce performance-review drafts from continuous feedback. Lattice leads modern team performance for tech-forward companies; Culture Amp pairs performance with engagement signals; 15Five focuses on weekly check-ins and development conversations.',
  'We weighted: check-in quality, goal-tracking depth, review-draft quality, and integration with HRIS and Slack.',
  '[
    {"q":"How often should teams hold check-ins?","a":"Weekly for direct-team check-ins, monthly for cross-team alignment, quarterly for goal-cycle reviews. AI platforms make weekly check-ins sustainable by auto-summarizing input and surfacing pattern shifts; without AI assistance, weekly check-ins become a drag and team adoption collapses within 6-12 months."},
    {"q":"Lattice vs 15Five for team performance?","a":"Lattice has the deepest performance-cycle workflow with goals, reviews, and career pathing integrated; 15Five focuses on weekly check-ins with lighter performance-review tooling. Companies above 100 employees with formal review cycles pick Lattice; companies below 100 employees that prioritize check-ins pick 15Five."},
    {"q":"Are performance reviews still useful?","a":"Yes when paired with continuous feedback, no when standalone. Annual-only reviews lag behavior change by 6-12 months and lose employee trust; reviews fed by continuous feedback throughout the year accelerate development and surface promotion-readiness reliably. Modern platforms make continuous feedback sustainable."}
  ]'::jsonb, 'productivity', 'intermediate', 720,
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
