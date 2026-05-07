-- Phase 3 batch 1 of Task Taxonomy initiative (S121)
-- 34 mid-tail tasks pushing 200 -> 234 tasks (Phase 3 begins, +17% over Phase 2 finish).
-- Coverage: customer-success (+2), hr-recruiting (+5), ops (+4), support (+3), sales (+3),
-- marketing (+4), writing (+2), design (+3), data-analytics (+3), dev (+1), productivity (+1),
-- research (+1), finance (+2). Final spread per category 14-26.
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Gate A 34/34 PASS, Gate B 34/34 PASS (5 sessions running 100% hit rate).
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === CUSTOMER-SUCCESS (2) ===

-- 1. ai-for-customer-retention
(
  'ai-for-customer-retention', 'AI for Customer Retention', '🔁',
  ARRAY['customer-service'], ARRAY['vitally','gainsight','planhat','churnzero','catalyst'], 3,
  'Customer retention is the difference between a SaaS that compounds and one that leaks faster than it acquires. AI tools now flag at-risk accounts weeks before churn happens by combining product-usage telemetry, support-ticket sentiment, and renewal-cycle context into a single health score. Vitally and Gainsight lead the enterprise CSM platforms; Planhat layers retention playbooks onto a customer ops stack; ChurnZero and Catalyst focus on usage-driven retention plays for mid-market SaaS.',
  'We weighted: depth of usage signal coverage, predictive churn-score accuracy, automated playbook execution, and integrations with CRM and product analytics.',
  '[
    {"q":"What is the best leading indicator of churn?","a":"Drop in product usage by a primary stakeholder is more predictive than NPS or support tickets alone. Most platforms blend feature-adoption decay, login frequency, and support sentiment into a composite score that fires 60-90 days before non-renewal."},
    {"q":"Vitally vs Gainsight?","a":"Gainsight is the heaviest enterprise platform with deep journey orchestration but a steep onboarding cost; Vitally ships faster on Slack-native CSM workflows for product-led SaaS. Companies under 200 customers default to Vitally; enterprises with multi-product portfolios pick Gainsight."},
    {"q":"Can AI alone retain customers?","a":"AI surfaces the at-risk signal; the save still requires a human CSM or proactive product fix. Tools like ChurnZero automate the first-touch playbook (in-app message, email cadence) but the retention save itself depends on whether the underlying value gap can be closed."}
  ]'::jsonb, 'customer-success', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-account-expansion
(
  'ai-for-account-expansion', 'AI for Account Expansion', '📈',
  ARRAY['customer-service'], ARRAY['vitally','gainsight','planhat','catalyst','totango'], 3,
  'Net revenue retention above 110% is the single best predictor of SaaS valuation, and account expansion is how you get there. AI-powered CSM platforms now identify upsell windows by tracking feature-limit adoption, seat saturation, and competitive-product overlap inside existing accounts. Vitally, Gainsight, and Planhat surface expansion playbooks alongside renewal forecasts; Catalyst and Totango focus on usage-based expansion triggers for product-led growth.',
  'We weighted: expansion-signal precision, playbook automation depth, CRM and billing integration cleanliness, and CSM-to-AE handoff workflow quality.',
  '[
    {"q":"What is the strongest expansion signal?","a":"Approaching a feature or seat limit is the cleanest signal because it ties directly to a billing event. Usage spikes in adjacent product modules and stakeholder expansion (new logins from a different department) are secondary but often surface bigger deals."},
    {"q":"Should the CSM or AE own expansion?","a":"Net-new logos to AE; expansion within existing accounts splits between CSM (for usage-based upsell, seat expansion) and AE (for new product modules, multi-year renewals). The AI platform should route opportunities by deal size and complexity."},
    {"q":"How accurate is the expansion forecast?","a":"Tools like Gainsight and Vitally ship 70-80% precision on expansion calls when integration with usage telemetry and billing is clean. Forecast quality degrades sharply in accounts where the CRM lacks accurate product-usage data."}
  ]'::jsonb, 'customer-success', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === HR-RECRUITING (5) ===

-- 3. ai-for-employee-feedback
(
  'ai-for-employee-feedback', 'AI for Employee Feedback', '💬',
  ARRAY['hr'], ARRAY['lattice','culture-amp','15five'], 3,
  'Employee feedback in 2026 is continuous, sentiment-aware, and connected to performance outcomes rather than once-a-year survey events. Lattice integrates feedback into 1-on-1s and goal cycles; Culture Amp ships science-backed engagement surveys with AI sentiment analysis on open-ended responses; 15Five blends weekly check-ins with manager coaching prompts. The shift is from collecting feedback to closing the loop on it before disengagement compounds.',
  'We weighted: open-text sentiment accuracy, manager action-prompt quality, integration with performance and goal cycles, and survey-fatigue mitigation.',
  '[
    {"q":"Lattice vs Culture Amp?","a":"Culture Amp is engagement-survey-first with deep DEI and benchmark data; Lattice is performance-management-first with feedback as one module. Companies optimizing for engagement insights pick Culture Amp; companies optimizing for performance cycles pick Lattice."},
    {"q":"How does AI improve feedback quality?","a":"AI clusters open-text responses into themes, surfaces tone shifts month over month, and flags managers whose teams show declining sentiment scores before formal surveys catch it. The signal-to-noise ratio improves materially over manual coding."},
    {"q":"Is anonymous feedback still anonymous with AI?","a":"Reputable platforms anonymize at the response level before AI processing and aggregate to teams of 5+ before showing managers. Single-respondent themes are suppressed automatically. Always verify the platform privacy posture before rollout."}
  ]'::jsonb, 'hr-recruiting', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-employee-surveys
(
  'ai-for-employee-surveys', 'AI for Employee Surveys', '📊',
  ARRAY['hr'], ARRAY['culture-amp','15five','lattice'], 3,
  'Employee surveys went from annual to pulse to AI-summarized in three years. The leading platforms now ship pre-built question banks validated against engagement-outcome research, AI-driven sentiment analysis on open-text, and benchmark data against industry peers. Culture Amp owns the science-backed survey category with the deepest benchmark library; 15Five and Lattice integrate surveys into a broader performance stack.',
  'Selection criteria: question-bank scientific validity, open-text sentiment accuracy, peer-benchmark depth, and ease of action-planning post-survey.',
  '[
    {"q":"How often should we run pulse surveys?","a":"Monthly is the sweet spot for most companies. Weekly creates survey fatigue without enough signal change to justify it; quarterly misses fast-moving sentiment shifts. The cadence should match the action-planning cycle."},
    {"q":"Are AI-summarized open-text responses accurate?","a":"Theme extraction is 85-90% accurate at scale (100+ responses); sentiment polarity hits 90%+. Single-response sarcasm and culture-specific phrases still trip up models. Always spot-check 10-20 responses against the AI summary before sharing with leadership."},
    {"q":"Can we benchmark against competitors?","a":"Culture Amp ships the deepest benchmark library across industries and company sizes. Lattice and 15Five offer lighter benchmark data primarily for engagement scores. Vendor-anonymized peer data is the closest you get to direct competitor comparison."}
  ]'::jsonb, 'hr-recruiting', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 5. ai-for-pto-management
(
  'ai-for-pto-management', 'AI for PTO Management', '🏖️',
  ARRAY['hr'], ARRAY['rippling','greenhouse','bamboohr','lever'], 3,
  'PTO management used to mean a Slack message to the manager and a spreadsheet update. AI-driven HRIS platforms now auto-balance accruals across jurisdictions, flag policy conflicts before approval, and predict team coverage gaps when multiple requests cluster. Rippling and BambooHR lead the all-in-one HRIS category; Greenhouse and Lever bundle PTO into broader recruiting and onboarding flows.',
  'We weighted: multi-country accrual rule support, calendar and Slack integration depth, manager-approval workflow quality, and audit-trail completeness for compliance.',
  '[
    {"q":"Rippling vs BambooHR for PTO?","a":"Rippling handles complex multi-country accruals and per-employee policy variation natively; BambooHR is simpler, US-first, and faster to roll out for SMBs under 200 employees. Both auto-deduct PTO from payroll runs."},
    {"q":"How does AI flag coverage gaps?","a":"The system reads team rosters, in-flight projects, and overlapping PTO requests; it warns managers when approving a request would leave a function under-staffed. Some platforms suggest alternate dates that minimize coverage risk."},
    {"q":"Can employees see manager PTO?","a":"Most platforms ship calendar visibility configurable by team or department; manager PTO is usually visible to direct reports for planning purposes. Privacy settings vary by platform and HR policy."}
  ]'::jsonb, 'hr-recruiting', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 6. ai-for-job-interviews
(
  'ai-for-job-interviews', 'AI for Job Interviews', '🎤',
  ARRAY['hr'], ARRAY['ashby','goodtime','metaview','greenhouse','lever'], 3,
  'Job interviews in 2026 are AI-augmented end to end: scheduling, transcription, scorecard suggestions, and bias-flagging on hiring loops. Ashby and Greenhouse lead modern ATS platforms with structured interview scoring; GoodTime auto-schedules complex multi-interviewer loops; Metaview transcribes and analyzes interview content for consistency and quality. Lever rounds out the mid-market ATS category with strong sourcing-to-offer workflow.',
  'Selection prioritized: scheduling-automation depth, structured scorecard quality, bias-flagging accuracy, and ATS-wide consistency across hiring loops.',
  '[
    {"q":"Does AI help reduce interviewer bias?","a":"Tools like Metaview flag asymmetric question coverage, talking-time imbalance, and inconsistent scoring across candidates. The detection is more reliable than human self-audit but does not replace structured interview training."},
    {"q":"Ashby vs Greenhouse for interview workflow?","a":"Ashby ships native scheduling, scorecards, and analytics in one product with a steeper learning curve; Greenhouse is the enterprise default with a richer integration ecosystem but adds GoodTime or another scheduler for complex loops."},
    {"q":"Is AI transcription private?","a":"Reputable platforms (Metaview, Ashby) encrypt at rest, comply with GDPR and SOC 2, and let candidates opt out at scheduling. Always verify candidate-facing disclosure language matches the platform privacy posture."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-onboarding-workflows
(
  'ai-for-onboarding-workflows', 'AI for Onboarding Workflows', '🚀',
  ARRAY['hr','automation'], ARRAY['rippling','greenhouse','bamboohr','lever'], 3,
  'New-hire onboarding used to involve 30 emails, 12 software accounts, and a stack of paperwork. AI-driven HRIS platforms now provision SaaS accounts, send compliance forms, route equipment shipments, and trigger manager check-ins from a single workflow tied to the offer-accept event. Rippling owns the IT-onboarding category; BambooHR is the SMB default; Greenhouse and Lever bundle onboarding into ATS-led platforms.',
  'We weighted: SaaS provisioning breadth, document-collection automation, manager-prompt quality, and integration with payroll and benefits enrollment.',
  '[
    {"q":"Rippling vs BambooHR for onboarding?","a":"Rippling auto-provisions Slack, Google Workspace, GitHub, and 600+ SaaS apps from a single offer-accept event; BambooHR focuses on the HR side (forms, benefits, payroll) and integrates with IT separately. IT-heavy companies pick Rippling."},
    {"q":"How long does AI onboarding take to set up?","a":"Initial workflow setup is 2-4 weeks for the first role template; subsequent roles fork from existing templates in hours. Most companies see ROI within 60 days through reduced manager and IT time per new hire."},
    {"q":"Does AI replace HR business partners?","a":"No. AI handles the repetitive provisioning and form-collection layer; HRBPs focus on culture integration, role clarity, and 30-60-90 check-ins. The split lets HRBPs scale with headcount without linear hiring."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === OPS (4) ===

-- 8. ai-for-okr-tracking
(
  'ai-for-okr-tracking', 'AI for OKR Tracking', '🎯',
  ARRAY['productivity','hr'], ARRAY['lattice','culture-amp','15five','bamboohr'], 3,
  'OKR tracking only works if updates happen weekly without becoming a tax on managers. AI-augmented platforms now auto-pull progress signals from Jira, Salesforce, and product analytics to update key results without human input. Lattice and 15Five lead the integrated performance-and-OKR category; Culture Amp adds OKR alongside engagement surveys; BambooHR ships lighter goal tracking inside its HRIS.',
  'Selection prioritized: data-source breadth for auto-updates, alignment-tree visualization quality, manager-prompt cadence, and quarterly check-in workflow depth.',
  '[
    {"q":"Lattice vs 15Five for OKRs?","a":"Lattice has the cleaner alignment tree across teams and a stronger performance-cycle integration; 15Five is more lightweight with weekly check-ins as the primary cadence. Companies running quarterly OKR cycles formally pick Lattice."},
    {"q":"Should OKRs auto-update from data?","a":"Yes for measurable outputs (revenue, signups, latency); no for outcome-driven KRs that require human judgment (customer-perceived quality). The mix should be 60-70% auto-tracked and 30-40% human-judged."},
    {"q":"How granular should OKRs be?","a":"Company-level: 3-5 objectives, 2-4 key results each. Team-level: 3-5 objectives mapped to company OKRs. Individual-level: optional and often skipped to avoid OKR fatigue. Annual planning then quarterly check-ins is the standard cadence."}
  ]'::jsonb, 'ops', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 9. ai-for-it-tickets
(
  'ai-for-it-tickets', 'AI for IT Tickets', '🛠️',
  ARRAY['customer-service','automation'], ARRAY['front-app','liveagent','intercom','zendesk','zoho-desk'], 3,
  'IT helpdesks process thousands of tickets monthly: password resets, software access requests, hardware issues. AI now auto-classifies tickets by urgency and category, drafts first-touch responses, and routes to the right tier without human triage. Front and Intercom lead modern shared-inbox AI; Zendesk and Zoho Desk own enterprise IT-helpdesk; LiveAgent fits SMBs with mixed customer-and-internal support.',
  'We weighted: classification accuracy, response-draft quality, escalation-routing depth, and integration with knowledge bases and asset management.',
  '[
    {"q":"What percent of IT tickets can AI auto-resolve?","a":"Tier-1 password resets, account unlocks, and standard software requests can hit 60-70% auto-resolution with a well-tuned knowledge base. Tier-2 hardware and access issues drop to 20-30% deflection. Tier-3 incidents stay human-led."},
    {"q":"Front vs Zendesk for IT?","a":"Front is shared-inbox-native and faster for IT teams under 50 agents; Zendesk has deeper IT-asset and ITIL workflow support for enterprise. SMB IT picks Front; large IT orgs pick Zendesk or ServiceNow."},
    {"q":"Does AI replace tier-1 IT?","a":"It replaces 50-70% of the volume but not the role. Tier-1 shifts toward exception handling, knowledge-base curation, and AI-output review. Headcount per ticket drops materially but does not zero out."}
  ]'::jsonb, 'ops', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-process-documentation
(
  'ai-for-process-documentation', 'AI for Process Documentation', '📚',
  ARRAY['productivity','documentation'], ARRAY['document360','notion-ai','gitbook','slab','coda'], 3,
  'Process documentation is the work nobody owns and everybody needs. AI-augmented documentation tools now auto-generate first drafts from screen recordings, suggest updates when source content changes, and surface stale pages before they cause incidents. Notion AI and Coda blend docs with database workflow; Document360 and GitBook target structured product knowledge; Slab fits internal-handbook and SOP use cases.',
  'Selection prioritized: AI draft quality from source material, search and linking depth, stale-content detection, and team permissions for sensitive SOPs.',
  '[
    {"q":"Notion vs Document360 for SOPs?","a":"Notion is faster to start, more flexible, and integrates with team workflow but lacks formal versioning and approval cycles. Document360 ships structured versioning, change tracking, and a help-center publish flow for customer-facing or compliance-heavy SOPs."},
    {"q":"Can AI keep docs current?","a":"Yes for low-stakes content (release notes, weekly updates); no for high-stakes (legal, security policy). AI flags stale pages by detecting source-of-truth changes (code commits, policy doc updates) but human review is still required before publish."},
    {"q":"How do we prevent doc sprawl?","a":"One canonical home per topic, deep search via AI, and a quarterly archival pass on pages with low view counts. Tools like Slab and Document360 surface duplicates and consolidation candidates automatically."}
  ]'::jsonb, 'ops', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 11. ai-for-supplier-onboarding
(
  'ai-for-supplier-onboarding', 'AI for Supplier Onboarding', '🤝',
  ARRAY['productivity'], ARRAY['ironclad','contractbook','juro','oneflow'], 3,
  'Supplier onboarding bottlenecks every new vendor: NDA, MSA, W-9, payment terms, security review. AI-powered contract platforms now extract clauses from supplier paper, auto-redline against your playbook, and route compliance and finance approvals in parallel rather than sequentially. Ironclad leads the enterprise CLM category; Juro and Oneflow target mid-market with strong UX; Contractbook focuses on SMB and Nordic markets.',
  'We weighted: clause extraction accuracy, playbook redline quality, parallel-routing workflow depth, and integration with procurement and ERP.',
  '[
    {"q":"How long does supplier onboarding take with AI?","a":"Cycles compress from 2-4 weeks to 3-7 days for standard vendors when contract redline, security review, and payment-form collection run in parallel. Complex enterprise vendors with custom MSAs still take 2-3 weeks."},
    {"q":"Ironclad vs Juro?","a":"Ironclad is the heavyweight CLM with deep integrations to Salesforce, NetSuite, and Workday for enterprise; Juro is faster to deploy with a friendlier UX for legal teams under 20 people. Mid-market companies often start with Juro and graduate to Ironclad."},
    {"q":"Can AI replace the supplier risk review?","a":"AI surfaces red flags (missing insurance, unfavorable indemnity, payment-term anomalies) but the risk decision still sits with finance and legal. The platform compresses review time without replacing the judgment layer."}
  ]'::jsonb, 'ops', 'intermediate', 320,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SUPPORT (3) ===

-- 12. ai-for-knowledge-management
(
  'ai-for-knowledge-management', 'AI for Knowledge Management', '🧠',
  ARRAY['customer-service','documentation'], ARRAY['document360','gitbook','slab','guru','tettra'], 3,
  'Knowledge management is the boring infrastructure that determines whether new hires take 30 days or 90 days to ramp. AI-augmented KM platforms now answer questions in Slack from internal docs, suggest updates when source content drifts, and surface verified-vs-stale signals so users trust what they read. Guru and Tettra lead the internal-knowledge-card category; Document360 and GitBook target product-knowledge bases; Slab fits team handbooks and engineering wikis.',
  'Selection prioritized: search and chat-from-docs accuracy, verification workflow quality, integrations with Slack and Teams, and stale-content detection.',
  '[
    {"q":"Guru vs Notion for knowledge?","a":"Guru is purpose-built for verified knowledge cards with expiration dates and review cycles; Notion is a flexible workspace where knowledge competes with project docs. Companies serious about knowledge governance pick Guru; smaller teams default to Notion."},
    {"q":"How accurate is AI search on internal docs?","a":"Modern semantic search hits 80-90% top-3 accuracy when the corpus is curated and tagged. Accuracy degrades sharply with stale content, duplicate pages, and uncurated drafts. Quality of search reflects quality of upstream content."},
    {"q":"How do we keep knowledge fresh?","a":"Assign every page an owner, set quarterly review cycles, and use stale-content alerts. Tools like Guru auto-prompt owners to verify cards every 30-90 days; Document360 ships change-detection alerts when source-of-truth content updates."}
  ]'::jsonb, 'support', 'beginner', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 13. ai-for-multilingual-support
(
  'ai-for-multilingual-support', 'AI for Multilingual Support', '🌐',
  ARRAY['translation','customer-service'], ARRAY['lokalise','crowdin','lilt','transifex','unbabel'], 3,
  'Multilingual support is the difference between launching in 1 country and 30. AI translation platforms now ship localized help content, auto-translate tickets in real time, and route to native-speaker agents only for high-stakes conversations. Lokalise and Crowdin lead the localization-platform category for product UI and help content; Lilt and Unbabel focus on AI-augmented translation for customer support; Transifex covers content-management-driven localization.',
  'We weighted: live-translation latency, language-pair coverage, glossary and tone-of-voice control, and integration with helpdesk platforms.',
  '[
    {"q":"Lokalise vs Crowdin?","a":"Lokalise has cleaner UX for product teams and a faster API for CI-driven localization; Crowdin has deeper community-translation features and broader file-format support. Engineering-led localization picks Lokalise; community-driven localization picks Crowdin."},
    {"q":"Is AI translation good enough for support?","a":"For tier-1 tickets in high-resource languages (ES, DE, FR, JA), yes with 90%+ quality after glossary tuning. For tier-2 complex cases or low-resource languages, hybrid AI-plus-human review remains the standard."},
    {"q":"How do we maintain brand voice across languages?","a":"Glossary management plus tone-of-voice settings per locale. Tools like Lilt and Unbabel let you upload terminology and style guides; the AI applies them per translation. Quality jumps materially after 200-500 reference translations."}
  ]'::jsonb, 'support', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-help-articles
(
  'ai-for-help-articles', 'AI for Help Articles', '📖',
  ARRAY['customer-service','writing-ai'], ARRAY['document360','front-app','intercom','zoho-desk','helpjuice'], 3,
  'Help articles are the silent deflection engine of every support team. AI-augmented help platforms now suggest article topics from ticket clusters, draft articles from past resolutions, and update outdated content when product changes ship. Intercom and Front bundle AI help-content into shared inbox; Document360 and Helpjuice are dedicated knowledge-base platforms; Zoho Desk fits SMB support with bundled article management.',
  'Selection prioritized: ticket-to-article suggestion accuracy, draft quality, search and self-service deflection rates, and integration with helpdesk platforms.',
  '[
    {"q":"How do we prioritize which articles to write?","a":"Ticket-cluster analysis. Tools like Intercom group similar tickets and rank by volume; the top 10-20 clusters typically cover 60-70% of total ticket volume. Write articles for those first before broadening."},
    {"q":"Is AI-drafted help content good enough?","a":"For procedural articles (how-to, troubleshooting steps), yes with light human review. For conceptual content (why X feature exists, when to use it), AI drafts need substantial human rewriting to match brand voice and accuracy."},
    {"q":"How do we measure self-service success?","a":"Deflection rate (tickets avoided per article view) and CSAT on self-service path. Best-in-class deflection is 30-50% on top articles; below 10% suggests article quality or discoverability issues."}
  ]'::jsonb, 'support', 'beginner', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SALES (3) ===

-- 15. ai-for-sales-decks
(
  'ai-for-sales-decks', 'AI for Sales Decks', '📊',
  ARRAY['crm-sales','presentation'], ARRAY['gamma-app','pitch','beautiful-ai','decktopus'], 3,
  'Sales decks used to take a designer 4 hours and a hand-off; AI presentation tools now ship first drafts in 90 seconds with brand-tuned templates. Gamma generates structured decks from prompts; Pitch ships collaborative decks with team-template enforcement; Beautiful.ai auto-arranges layouts as content changes; Decktopus targets sales-pitch-specific frameworks. The win is removing the slide-by-slide grind so reps spend time on customization.',
  'We weighted: prompt-to-deck quality, brand-template enforcement, collaborative editing depth, and export options for prospect-ready PDFs.',
  '[
    {"q":"Gamma vs Pitch for sales decks?","a":"Gamma generates content from a prompt faster and is better for cold-prospect decks; Pitch is stronger for team consistency and brand-locked templates across many reps. Solo AEs pick Gamma; sales orgs over 10 reps pick Pitch."},
    {"q":"How brand-aligned are AI-generated decks?","a":"Out-of-the-box AI decks need brand-template upload to look professional. After uploading logos, fonts, and color tokens, modern tools enforce brand consistency at 85-90% quality. Custom illustration and animation still require human design."},
    {"q":"Can AI personalize per-prospect?","a":"Yes for surface-level (prospect company name, industry framing, competitive references); no for deep account research. Tools integrate with CRM and LinkedIn but the strategic narrative still comes from the AE."}
  ]'::jsonb, 'sales', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 16. ai-for-meeting-prep
(
  'ai-for-meeting-prep', 'AI for Meeting Prep', '🔍',
  ARRAY['meeting-ai','crm-sales'], ARRAY['gong-io','grain','avoma','fireflies-ai','sembly-ai'], 3,
  'Meeting prep is the difference between a discovery call that lands and one that wastes 30 minutes. AI meeting platforms now pull prior call notes, CRM history, and prospect news into a single brief delivered 15 minutes before the meeting. Gong and Modjo own the revenue-intelligence category; Grain ships fast prep briefs from past calls; Avoma and Fireflies blend transcription with prep automation; Sembly auto-generates agenda suggestions.',
  'Selection prioritized: prep-brief quality, CRM-history integration, prospect-news enrichment, and calendar-integration latency.',
  '[
    {"q":"What goes in a strong meeting prep brief?","a":"3 things: prior conversation summary (key pain points, asks, objections), CRM-relevant deal context (stage, ARR, last activity), and prospect news from the past 30 days (funding, hires, product launches). Anything beyond that gets ignored."},
    {"q":"Gong vs Grain for prep?","a":"Gong is the enterprise revenue-intelligence platform with deep deal-stage intelligence; Grain is faster, cheaper, and better for individual rep workflow. Sales teams under 50 reps default to Grain; 100+ reps pick Gong."},
    {"q":"How early should the brief land?","a":"15-20 minutes pre-meeting is optimal. Earlier and the rep does not read it; later and there is no time to act on insights. Calendar-trigger automation handles the timing."}
  ]'::jsonb, 'sales', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 17. ai-for-prospecting
(
  'ai-for-prospecting', 'AI for Prospecting', '🎯',
  ARRAY['crm-sales','automation'], ARRAY['lavender','clay','lemlist','reply-io','smartlead'], 3,
  'Prospecting is now an AI-orchestrated workflow, not a manual list-pull. Modern platforms enrich account data, draft personalized outreach per contact, and run multi-channel sequences across email, LinkedIn, and SMS. Clay leads the data-enrichment-and-orchestration category; Lavender focuses on personalized email coaching; Lemlist and Smartlead run high-deliverability cold email; Reply.io handles multi-channel cadence.',
  'We weighted: data-enrichment depth, personalization-prompt quality, deliverability-protection features, and multi-channel sequence support.',
  '[
    {"q":"Clay vs Apollo for prospecting?","a":"Clay is enrichment-and-workflow-first with 50+ data providers and AI-orchestrated playbooks; Apollo is database-and-cadence-first with proprietary contact data and built-in sequencing. Sophisticated SDR teams blend both: Apollo for raw data, Clay for orchestration."},
    {"q":"How do we keep cold email deliverable?","a":"Domain warmup, sub-200 daily volume per inbox, no links in the first email, and rotating sender pools. Tools like Smartlead and Lemlist automate warmup; the orchestration is on you."},
    {"q":"Does AI personalization actually outperform templates?","a":"On reply rate, 1.5-2.5x lift over generic templates when personalization references real prospect signals (recent post, role change, company news). When personalization is just first-name-and-company swap, no lift."}
  ]'::jsonb, 'sales', 'intermediate', 2900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === MARKETING (4) ===

-- 18. ai-for-content-marketing
(
  'ai-for-content-marketing', 'AI for Content Marketing', '✍️',
  ARRAY['writing-ai','seo-ai'], ARRAY['jasper','copy-ai','frase','writesonic','scalenut'], 3,
  'Content marketing in 2026 is no longer about volume; it is about velocity-with-quality, and AI compresses the research-to-publish cycle from 8 hours to 2. Jasper leads the enterprise content-AI category with brand voice and team workflows; Copy.ai and Writesonic target SMB with broader use-case coverage; Frase and Scalenut blend SEO research with content drafting. The discipline is using AI to scaffold drafts faster, not to ship slop.',
  'Selection prioritized: brand-voice consistency, SEO research depth, draft-to-publish workflow, and team collaboration features.',
  '[
    {"q":"Jasper vs Copy.ai for content marketing?","a":"Jasper has stronger brand-voice features and team workflow for content teams 10+ people; Copy.ai is faster for solo marketers and small teams under 5 people. Both produce comparable raw draft quality at the article level."},
    {"q":"Can AI write SEO-ranking content?","a":"Yes when paired with proper SEO research (keyword intent, SERP gap analysis) and human editing for first-hand expertise signals. Pure AI output ranks poorly because Google now weights experience and originality. Frase and Scalenut bundle the research; the editing layer is on you."},
    {"q":"How long should AI-drafted articles take to ship?","a":"For 1500-2000 word SEO articles: 90-120 minutes from prompt to publish. The compression comes from research, outline, and first-draft phases; final editing and fact-check still take 30-45 minutes per article."}
  ]'::jsonb, 'marketing', 'beginner', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 19. ai-for-podcast-marketing
(
  'ai-for-podcast-marketing', 'AI for Podcast Marketing', '🎙️',
  ARRAY['social-media-ai'], ARRAY['castmagic','descript','opus-clip','swell-ai','repurpose-io'], 3,
  'Podcast marketing is no longer about the audio file; it is about the 30-piece content waterfall a single episode generates. AI tools now extract show notes, social clips, transcripts, and email summaries automatically from each recording. Castmagic and Swell AI focus on podcast-specific repurposing; Descript handles editing plus repurposing; Opus Clip generates short-form vertical clips; Repurpose.io targets multi-channel distribution.',
  'We weighted: clip-selection quality (which moments resonate), caption accuracy, multi-format export depth, and brand-template control.',
  '[
    {"q":"Best tool for podcast clips?","a":"Opus Clip leads on auto-selecting viral moments and generating vertical clips with captions optimized for TikTok and Reels. Descript is stronger when you want manual control over each clip with editing precision."},
    {"q":"How do we measure podcast marketing ROI?","a":"Top-of-funnel: downloads and clip impressions. Mid-funnel: email subscriber lift and direct site traffic. Bottom-funnel: branded-search lift and demo requests citing the show. Most B2B podcasts measure on branded-search and pipeline-influence rather than downloads alone."},
    {"q":"Castmagic vs Descript?","a":"Castmagic is podcast-specific with one-click show notes, social posts, and email summaries from a single upload; Descript is a broader audio-and-video editor with repurposing as one feature. Pure podcast workflow picks Castmagic; multi-format creators pick Descript."}
  ]'::jsonb, 'marketing', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 20. ai-for-webinar-promotion
(
  'ai-for-webinar-promotion', 'AI for Webinar Promotion', '📡',
  ARRAY['marketing'], ARRAY['hubspot','klaviyo','activecampaign','mailchimp'], 3,
  'Webinar promotion lives or dies on registration volume and show-up rate, and AI marketing automation now handles both layers from a single workflow. Modern platforms segment audiences by past-engagement, draft personalized invite copy, run multi-channel reminders, and trigger replays for no-shows. HubSpot is the enterprise marketing-automation default; Klaviyo and ActiveCampaign target ecommerce and SMB; Mailchimp handles SMB email-first promotion.',
  'Selection prioritized: segmentation depth, multi-channel cadence support, registration-platform integration, and replay-followup automation.',
  '[
    {"q":"What registration-to-show-up rate is realistic?","a":"30-40% for cold-audience webinars; 50-60% for warm-list webinars; 70%+ for community-driven or paid events. AI-driven multi-touch reminders lift show-up by 10-20 points over single-email reminders."},
    {"q":"HubSpot vs ActiveCampaign for webinars?","a":"HubSpot integrates webinar registration, CRM, and content marketing in one stack with deep reporting; ActiveCampaign is faster and cheaper for SMB with strong automation flows. Enterprise picks HubSpot; SMB under 50 employees picks ActiveCampaign."},
    {"q":"Should we promote via partner audiences?","a":"Yes for top-of-funnel growth. Partner co-promotion (newsletter swaps, co-hosted webinars) typically delivers 2-3x the registration of paid social for B2B audiences when audience-fit is strong."}
  ]'::jsonb, 'marketing', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 21. ai-for-marketing-emails
(
  'ai-for-marketing-emails', 'AI for Marketing Emails', '📧',
  ARRAY['marketing'], ARRAY['mailerlite','beehiiv','hubspot','omnisend','klaviyo'], 3,
  'Marketing emails in 2026 are AI-personalized at the segment-of-one level, not the broadcast level. Modern platforms segment by behavior, predict best send-time per recipient, and auto-generate subject-line variants tested against deliverability and open-rate data. Klaviyo and HubSpot lead enterprise; Mailchimp covers SMB and ecommerce; Beehiiv targets newsletter creators; MailerLite and Omnisend serve SMB and ecommerce respectively.',
  'We weighted: segmentation depth, send-time optimization quality, AI subject-line and copy generation, and deliverability protection features.',
  '[
    {"q":"Klaviyo vs Mailchimp for ecommerce?","a":"Klaviyo is the ecommerce default with deep Shopify integration, behavior-based segmentation, and revenue-attribution reporting; Mailchimp is broader and easier for non-ecommerce SMB use cases. Shopify stores over $1M annual revenue pick Klaviyo."},
    {"q":"Are AI-generated subject lines actually better?","a":"On open rate, 5-15% lift over human-written when AI is fed historical open-rate data. The lift comes from variant testing at scale, not from any single line being better. Without historical data, AI subject lines perform at-or-below human."},
    {"q":"How often should we email subscribers?","a":"Newsletter cadence: weekly is the sweet spot for engaged audiences, biweekly for broader. Promotional emails: 2-4 per month max before unsubscribe rates spike. Transactional and behavior-triggered emails do not count toward this cadence."}
  ]'::jsonb, 'marketing', 'beginner', 2900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === WRITING (2) ===

-- 22. ai-for-rewriting
(
  'ai-for-rewriting', 'AI for Rewriting', '🔄',
  ARRAY['writing-ai'], ARRAY['grammarly','jasper','copy-ai','wordtune','quillbot'], 3,
  'Rewriting is the workhorse use case of AI writing tools: tighten copy, change tone, fix awkward phrasing, adapt for different audiences. Quillbot and Wordtune are dedicated rewriting platforms with multiple modes (formal, casual, simpler, expanded); Grammarly bundles rewriting into a broader writing assistant; Jasper and Copy.ai treat rewriting as one of many content workflows.',
  'Selection prioritized: rewrite-mode breadth, tone preservation accuracy, browser and editor integration, and multi-language support.',
  '[
    {"q":"Quillbot vs Wordtune?","a":"Quillbot is stronger on academic and formal rewriting with citation-aware modes; Wordtune is faster for casual and conversational rewrites with cleaner tone control. Students and researchers pick Quillbot; marketers and writers pick Wordtune."},
    {"q":"Does Grammarly do enough rewriting?","a":"Grammarly catches grammar and surface-level rephrasing but does not match Quillbot or Wordtune for substantive rewrites. Use Grammarly as a final-pass editor and Quillbot or Wordtune for restructuring."},
    {"q":"Is rewritten content still mine?","a":"Yes legally, but stylometric analysis can detect AI-rewriting if the source content was original. For SEO and academic contexts where originality matters, rewrite as a starting point and add substantive human edits before publishing."}
  ]'::jsonb, 'writing', 'beginner', 3600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 23. ai-for-paraphrasing
(
  'ai-for-paraphrasing', 'AI for Paraphrasing', '📝',
  ARRAY['writing-ai'], ARRAY['grammarly','jasper','frase','wordtune','quillbot'], 3,
  'Paraphrasing tools rewrite source text while preserving meaning, useful for avoiding duplication, simplifying language, or adapting tone. Quillbot is the category leader with 7 paraphrasing modes including formal, simple, and creative; Wordtune ships fast paraphrasing inside browsers and editors; Jasper and Copy.ai paraphrase as part of broader content workflows; Grammarly adds paraphrasing to its grammar engine.',
  'We weighted: paraphrase-mode breadth, meaning-preservation accuracy, plagiarism-detection compatibility, and browser-extension integration.',
  '[
    {"q":"Is paraphrased content plagiarism?","a":"Legally and ethically, paraphrasing without citation when the source idea is not yours is still plagiarism. Paraphrasing your own prior work for tone adaptation is not. Always cite source when paraphrasing third-party ideas, regardless of how transformative the rewrite."},
    {"q":"Quillbot modes I should know?","a":"Standard (default), Fluency (improves readability), Formal (academic tone), Simple (lower reading level), Creative (more aggressive rephrasing), Expand (adds detail), Shorten (compresses). Most users default to Standard or Fluency."},
    {"q":"Will paraphrasing fool AI detectors?","a":"Mixed results. Modern AI detectors (GPTZero, Originality.ai) catch 60-80% of paraphrased AI content. Heavy human edits after paraphrasing are still required to pass detection in academic or content-marketing contexts where AI usage is restricted."}
  ]'::jsonb, 'writing', 'beginner', 2900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (3) ===

-- 24. ai-for-illustrations
(
  'ai-for-illustrations', 'AI for Illustrations', '🎨',
  ARRAY['design'], ARRAY['midjourney','flux','leonardo-ai','ideogram','stable-diffusion'], 3,
  'Illustrations used to mean a $500 freelance commission and a 2-week turnaround. AI illustration tools now generate brand-consistent custom artwork in seconds at a fraction of the cost. Midjourney leads on visual quality and style consistency; Flux ships top-tier photorealism and typography; Leonardo AI offers fine-tuned models for specific styles; Ideogram excels at typography-heavy illustrations; Stable Diffusion underpins many open-source workflows.',
  'Selection prioritized: visual quality, style-consistency across iterations, typography support, and API access for production workflows.',
  '[
    {"q":"Midjourney vs Flux for illustrations?","a":"Midjourney has stronger artistic-style range (oil paint, watercolor, anime) and brand-consistency via style references; Flux beats Midjourney on photorealism and rendering text correctly inside images. Marketing illustrations pick Midjourney; product photography picks Flux."},
    {"q":"Can AI match a specific brand style?","a":"Yes via style references, custom-trained LoRAs (Stable Diffusion, Leonardo), or seed-based prompting. Brand consistency at 80-90% quality is achievable after 50-100 reference images. Pixel-perfect logo and mascot consistency still requires manual touch-up."},
    {"q":"Are AI illustrations safe to use commercially?","a":"Generally yes for tools with explicit commercial-use licenses (Midjourney, Flux paid tiers, Leonardo). Always verify the platform terms; some restrict commercial use on free tiers. For trademarked characters or known artist styles, copyright risk is unsettled in 2026."}
  ]'::jsonb, 'design', 'beginner', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 25. ai-for-thumbnails
(
  'ai-for-thumbnails', 'AI for Thumbnails', '🖼️',
  ARRAY['design','social-media-ai'], ARRAY['midjourney','leonardo-ai','photoroom','picsart'], 3,
  'YouTube and social thumbnails carry 80% of click-through weight, and AI tools now generate scroll-stopping designs in 60 seconds. Photoroom and Picsart specialize in product and creator-content thumbnails with background removal and template libraries; Midjourney and Leonardo AI generate raw artwork that designers composite into thumbnails. The shift is from per-thumbnail design hours to template-driven AI workflows.',
  'We weighted: template library quality, background-removal accuracy, text-overlay control, and platform-specific export formats (YouTube, TikTok, IG).',
  '[
    {"q":"Best tool for YouTube thumbnails?","a":"Photoroom for creators using product or face-based thumbnails (background remove, template apply, text overlay in 60 seconds); Midjourney plus Photoshop for cinematic concept thumbnails. Most YouTubers blend both depending on video type."},
    {"q":"Does AI generate clickable thumbnails?","a":"AI generates visually appealing thumbnails fast but does not understand what drives clicks for your specific audience. CTR optimization still requires A/B testing, audience-specific framing, and iteration. AI compresses the design step, not the strategy step."},
    {"q":"How do we A/B test thumbnails?","a":"YouTube native A/B testing (available 2024+) for channels with 1000+ subscribers; TubeBuddy and VidIQ extensions for older channels. Test 2-3 variants per video; the lift between best and worst is typically 15-30% on CTR."}
  ]'::jsonb, 'design', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 26. ai-for-explainer-videos
(
  'ai-for-explainer-videos', 'AI for Explainer Videos', '🎬',
  ARRAY['design','code-ai'], ARRAY['heygen','synthesia','runway','pika','d-id'], 3,
  'Explainer videos used to cost $5K and take 3 weeks; AI video platforms now ship a 60-second explainer in 30 minutes. HeyGen and Synthesia generate AI-avatar talking-head videos in 100+ languages; Runway and Pika handle scene-based generative video; D-ID animates static photos into talking videos. The win is replacing slow scriptwriter-to-storyboard-to-shoot loops with prompt-to-render workflows.',
  'Selection prioritized: avatar quality and lip-sync accuracy, script-to-video automation, language coverage, and brand-template control.',
  '[
    {"q":"HeyGen vs Synthesia?","a":"HeyGen ships faster avatars with stronger consumer-grade UX; Synthesia has deeper enterprise features (custom-trained avatars, SAML SSO, dedicated support). Marketing teams pick HeyGen; enterprise L&D departments pick Synthesia."},
    {"q":"Can AI avatars replace real video?","a":"For internal training, product onboarding, and L10n localization, yes with 80-90% audience acceptance. For brand storytelling and customer-facing marketing, real human video still outperforms because authenticity drives trust. Hybrid workflows are common."},
    {"q":"How long does an AI explainer take?","a":"Script: 15-30 minutes. Avatar render: 5-15 minutes per minute of video. Editing and finalization: 15-30 minutes. Total: 45-90 minutes for a 60-second explainer once your avatar and brand template are set up."}
  ]'::jsonb, 'design', 'intermediate', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DATA-ANALYTICS (3) ===

-- 27. ai-for-data-storytelling
(
  'ai-for-data-storytelling', 'AI for Data Storytelling', '📈',
  ARRAY['analytics'], ARRAY['deepnote','formula-bot','julius-ai','rows','akkio'], 3,
  'Data storytelling is the bridge between a SQL result and an executive decision, and AI now compresses the analysis-to-narrative cycle from 4 hours to 30 minutes. Julius AI and Akkio generate narrative explanations from raw datasets; Deepnote and Rows blend notebooks with AI-driven chart and commentary generation; Formula Bot translates plain-language questions into formulas and visualizations.',
  'We weighted: narrative-quality from raw data, chart-generation aesthetics, share-link and embed depth, and integration with BI and warehouse tools.',
  '[
    {"q":"Julius vs Akkio?","a":"Julius is conversational-AI-first for ad-hoc analysis with strong chart generation; Akkio is AutoML-first for predictive analytics with narrative output. Analysts doing one-off exploration pick Julius; teams operationalizing predictions pick Akkio."},
    {"q":"How accurate are AI-generated insights?","a":"For descriptive statistics and trend identification, 95%+ accurate when the data is clean. For causal claims (X drove Y), AI tools overstate confidence; always verify causal narratives with proper analysis or human judgment."},
    {"q":"Can AI build dashboards?","a":"Yes for first-draft dashboards from a prompt; the dashboards typically need 30-60% manual refinement to match production-quality requirements. Tools like Rows and Deepnote ship clean first drafts; final polish and governance still require human work."}
  ]'::jsonb, 'data-analytics', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 28. ai-for-product-analytics
(
  'ai-for-product-analytics', 'AI for Product Analytics', '📱',
  ARRAY['analytics'], ARRAY['plausible','segment','pendo','userpilot','amplitude'], 3,
  'Product analytics used to mean staring at funnels and hoping to spot the drop-off. AI-augmented platforms now auto-detect anomalies, suggest experiment ideas from usage patterns, and generate cohort insights without manual SQL. Amplitude and Heap lead enterprise product analytics; Pendo and Userpilot blend analytics with in-product experience; Sprig and Segment focus on event collection and survey integration; Plausible offers privacy-first lightweight analytics.',
  'Selection prioritized: anomaly-detection accuracy, cohort-builder UX, AI insight quality, and SDK and CDP integration depth.',
  '[
    {"q":"Amplitude vs Mixpanel?","a":"Amplitude has stronger out-of-the-box ML insights and predictive modeling; Mixpanel has cleaner UX for ad-hoc cohort analysis and tighter Snowflake integration. Both are enterprise-ready; the choice often comes down to existing data-stack fit."},
    {"q":"Pendo vs Amplitude?","a":"Pendo bundles product analytics with in-app guides and feedback; Amplitude is analytics-only with deeper ML and behavioral prediction. Companies wanting one tool for analytics-and-onboarding pick Pendo; analytics-focused teams pick Amplitude."},
    {"q":"How much event volume can AI handle?","a":"Modern platforms scale to billions of events per month with AI insights computed daily or hourly. Latency on AI-derived metrics is typically 1-24 hours, not real-time. Real-time alerting on anomalies is still rule-based, not AI-driven."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 29. ai-for-revenue-analytics
(
  'ai-for-revenue-analytics', 'AI for Revenue Analytics', '💰',
  ARRAY['analytics'], ARRAY['chartmogul','tableau','looker','baremetrics'], 3,
  'Revenue analytics tracks MRR, ARR, churn, and expansion in real time so finance and growth teams can act faster than monthly reports allow. ChartMogul and Baremetrics are SaaS-revenue-specific platforms with deep Stripe and HubSpot integration; Tableau and Looker handle broader BI workflows including revenue analytics with custom dashboards. The AI layer surfaces anomalies and forecasts MRR growth.',
  'We weighted: SaaS-revenue-metric depth, integration with billing and CRM, AI forecast accuracy, and dashboard and alert flexibility.',
  '[
    {"q":"ChartMogul vs Baremetrics?","a":"ChartMogul has stronger international currency and tax handling plus deeper segmentation; Baremetrics ships faster with cleaner UX for SMB SaaS companies. Stripe-only SMB SaaS picks Baremetrics; multi-payment-processor or international companies pick ChartMogul."},
    {"q":"How accurate are MRR forecasts?","a":"Short-term (next 30-90 days): 90%+ accurate when historical data is 12+ months and churn patterns are stable. Long-term (12+ months): less reliable due to product changes, market shifts, and competitive dynamics. Use forecasts as planning aids, not commitments."},
    {"q":"What revenue metrics matter most?","a":"Net Revenue Retention (NRR) above 110% predicts SaaS valuation more than any other single metric; gross MRR growth, magic number for sales efficiency, and CAC payback under 18 months round out the top 4."}
  ]'::jsonb, 'data-analytics', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DEV (1) ===

-- 30. ai-for-jupyter-notebooks
(
  'ai-for-jupyter-notebooks', 'AI for Jupyter Notebooks', '📓',
  ARRAY['code-ai','analytics'], ARRAY['deepnote','julius-ai','akkio'], 3,
  'Jupyter notebooks remain the lingua franca of data science, but vanilla Jupyter lacks collaboration, AI assistance, and production deployment. AI-powered notebook platforms now write code from prompts, suggest charts from data, and ship notebooks as scheduled production jobs. Deepnote leads modern collaborative notebooks; Julius AI ships chat-first notebook workflows; Akkio adds AutoML-driven prediction notebooks for less-technical analysts.',
  'Selection prioritized: code-generation quality from prompts, collaboration depth, scheduling and production-deployment options, and integration with warehouse and BI.',
  '[
    {"q":"Deepnote vs Hex?","a":"Deepnote ships faster collaboration UX with strong AI chat-to-code; Hex has deeper SQL and BI workflow features for analytics teams. Data scientists doing exploration pick Deepnote; analytics engineers picking notebooks for BI pick Hex."},
    {"q":"Can AI write production-quality notebook code?","a":"For exploration and prototyping, yes with 70-80% usable output. For production scheduled jobs, AI-generated code still needs human review for error handling, parameter validation, and resource limits. Treat AI as a fast first draft, not a code-review-skip."},
    {"q":"Julius AI vs ChatGPT for notebooks?","a":"Julius is purpose-built for data analysis with chart generation and dataset uploads; ChatGPT Code Interpreter handles similar tasks but requires more prompting overhead. Analysts working with files daily pick Julius for the workflow speed."}
  ]'::jsonb, 'dev', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === PRODUCTIVITY (1) ===

-- 31. ai-for-meeting-followups
(
  'ai-for-meeting-followups', 'AI for Meeting Followups', '✉️',
  ARRAY['meeting-ai'], ARRAY['fathom','gong-io','grain','avoma','fireflies-ai'], 3,
  'Meeting followups are the unglamorous work that closes deals and clears action items, and AI meeting platforms now generate them automatically: summary, action items, decisions, and a draft email back to attendees within minutes of the meeting ending. Fathom, Grain, Fireflies, and Avoma all auto-generate followup drafts; Gong layers deal-specific intelligence on top for enterprise sales teams. The win is removing the post-meeting cognitive tax.',
  'Selection prioritized: summary accuracy, action-item extraction quality, draft-email tone, and integration with email, CRM, and project management.',
  '[
    {"q":"Fathom vs Fireflies for followups?","a":"Fathom has cleaner free-tier offering and faster followup-draft generation for individual users; Fireflies has stronger team-wide search and integration breadth. Solo professionals pick Fathom; teams over 20 picks Fireflies."},
    {"q":"Are AI followups good enough to send as-is?","a":"For internal team meetings, yes with light review. For external sales or customer meetings, always edit before sending: AI misses context-specific tone, relationship history, and follow-on commitments that require human judgment."},
    {"q":"Can AI extract action items reliably?","a":"For explicit action items where someone names an owner and a deadline, 90%+ accurate. For implicit action items (someone agreed without explicit ownership), 60-70% accurate. Always review the action-item list against your own meeting notes for high-stakes meetings."}
  ]'::jsonb, 'productivity', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === RESEARCH (1) ===

-- 32. ai-for-research-questions
(
  'ai-for-research-questions', 'AI for Research Questions', '❓',
  ARRAY['research'], ARRAY['dovetail','maze','typeform','sprig','lookback'], 3,
  'A weak research question produces weak insights regardless of methodology, and AI research platforms now help framers test, refine, and validate questions before fielding. Dovetail and Lookback specialize in qualitative research with question-bank suggestions; Maze and Sprig blend quantitative survey-design AI with research workflow; Typeform handles broader survey use cases with conversational question framing.',
  'We weighted: question-bank quality, bias-detection in question wording, survey-flow logic, and integration with analysis and synthesis tools.',
  '[
    {"q":"How do we know a research question is good?","a":"3 signs: it is specific enough that two researchers would agree on what counts as an answer; it is open-ended enough that respondents would say something other than yes or no; it is actionable enough that the answer would change a product or business decision."},
    {"q":"Dovetail vs Maze for research?","a":"Dovetail is qualitative-research-first with strong synthesis from interview transcripts; Maze is quantitative-prototype-test-first with usability metrics. UX research teams blend both: Maze for usability tests, Dovetail for interview synthesis."},
    {"q":"Can AI flag biased questions?","a":"Yes for surface-level biases (leading wording, double-barreled questions, jargon). Deeper biases (cultural assumptions, framing effects) still require human reviewer judgment. Use AI as a first-pass filter, not a replacement for review."}
  ]'::jsonb, 'research', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === FINANCE (2) ===

-- 33. ai-for-financial-statements
(
  'ai-for-financial-statements', 'AI for Financial Statements', '📑',
  ARRAY['finance'], ARRAY['pilot','bench','docyt','zeni'], 3,
  'Generating accurate financial statements monthly is the difference between knowing your business and guessing. AI bookkeeping platforms now auto-categorize transactions, reconcile accounts, and produce GAAP-compliant income statements, balance sheets, and cash-flow reports without a full-time controller. Pilot and Bench bundle AI categorization with human bookkeepers; Zeni and Docyt focus on AI-first books with on-demand human review.',
  'Selection prioritized: GAAP accuracy, multi-entity support, integration with banking and payroll, and human-review escalation depth.',
  '[
    {"q":"Pilot vs Bench?","a":"Pilot targets venture-backed startups with multi-entity, R&D capitalization, and SaaS-revenue-recognition support; Bench is SMB-first with simpler bookkeeping for service businesses. Companies under $5M revenue pick Bench; venture-backed or multi-entity pick Pilot."},
    {"q":"Are AI-generated financials audit-ready?","a":"For early-stage companies, yes with light reviewer touch-up. For Series B+ or audit-required companies, AI-generated books still need controller-level review and adjustments. The compression is in transaction categorization, not in audit readiness."},
    {"q":"How fast can we close the books?","a":"AI-driven workflows compress month-end close from 10-15 days to 3-7 days for SMB; Series B+ companies typically close in 5-10 days with AI plus dedicated finance staff. The bottleneck is rarely the books themselves; it is accruals and revenue recognition."}
  ]'::jsonb, 'finance', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 34. ai-for-month-end-close
(
  'ai-for-month-end-close', 'AI for Month-End Close', '🗓️',
  ARRAY['finance'], ARRAY['pilot','bench','vic-ai','docyt','zeni'], 3,
  'Month-end close is the finance process that determines whether leadership gets numbers in 5 days or 15. AI tools now auto-match invoices to POs, flag accruals before reporting cycles, and reconcile bank and credit-card statements without manual ticking and tying. Pilot and Bench bundle AI close with human bookkeepers; Vic.ai focuses on AP-driven close acceleration; Docyt and Zeni ship AI-first close workflows for SMB and mid-market.',
  'We weighted: AP automation depth, bank-reconciliation accuracy, accrual flagging quality, and integration with general ledger and ERP.',
  '[
    {"q":"What slows down month-end close?","a":"3 things: late vendor invoices that miss the cutoff, manual reconciliation of bank and credit-card statements, and accrual judgment calls that require human review. AI compresses the second; the first and third still require process and human work."},
    {"q":"Vic.ai vs Stampli for close?","a":"Vic.ai uses AI to auto-code AP invoices end-to-end with 90%+ accuracy after training; Stampli focuses on collaboration and approval workflow with lighter AI. Companies optimizing for AP automation pick Vic.ai; companies optimizing for approval consensus pick Stampli."},
    {"q":"Can AI close the books faster than humans?","a":"For transaction categorization and reconciliation, yes by 3-5x. For period-end accruals, deferred revenue, and inter-entity eliminations, AI is faster but still requires controller review. Mature finance teams compress close from 10-15 days to 3-5 days."}
  ]'::jsonb, 'finance', 'intermediate', 720,
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
