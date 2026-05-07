-- Phase 3 batch 2 of Task Taxonomy initiative (S122)
-- 44 mid-tail tasks pushing 234 -> 278 tasks (Phase 3 progress 56% of 500-target).
-- Coverage: finance (+4), customer-success (+3), hr-recruiting (+4), ops (+4),
-- support (+3), sales (+4), marketing (+4), writing (+3), design (+3),
-- data-analytics (+3), dev (+3), productivity (+2), research (+4).
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Gate A 45/45 PASS, Gate B 44/45 PASS (web-scraping dropped: apify/browse-ai missing).
-- Defensive on apostrophes (S121 lesson): no quoted speech or contractions in JSON values.
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === FINANCE (4) ===

-- 1. ai-for-tax-compliance
(
  'ai-for-tax-compliance', 'AI for Tax Compliance', '🧾',
  ARRAY['finance'], ARRAY['pilot','bench','docyt','zeni','vic-ai'], 3,
  'Tax compliance for SaaS companies in 2026 spans state nexus, R&D credits, sales tax economic thresholds, and 1099 collection - all of which AI bookkeeping platforms now automate end to end. Pilot leads venture-backed startup tax with multi-state filing and R&D credit prep; Bench handles SMB federal and state tax with bookkeeper review; Docyt and Zeni focus on AI-first tax workflows for ecommerce and SMB. The shift is from quarterly scramble to continuous compliance.',
  'We weighted: multi-state nexus tracking, R&D credit calculation accuracy, 1099 collection automation, and integration with payroll and banking.',
  '[
    {"q":"Pilot vs Bench for tax?","a":"Pilot ships venture-backed-startup-grade tax with R&D credits, multi-state nexus, and Series A-ready audit trail; Bench targets service SMBs with simpler federal-state filing. Companies under 5M revenue with simple structures pick Bench; venture-backed companies pick Pilot."},
    {"q":"Can AI catch state nexus issues?","a":"Yes for economic nexus (revenue thresholds per state) and physical nexus (employee or office). Modern platforms track sales by state daily and alert when thresholds approach. Edge cases like marketplace facilitator rules still need CPA review."},
    {"q":"How do AI platforms handle R&D credits?","a":"They categorize qualifying expenses (engineering payroll, contractor fees) automatically based on payroll metadata and surface a credit estimate quarterly. Final filing requires CPA validation and Form 6765 documentation, which most platforms also assist with."}
  ]'::jsonb, 'finance', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-audit-prep
(
  'ai-for-audit-prep', 'AI for Audit Prep', '📋',
  ARRAY['finance'], ARRAY['pilot','bench','docyt','zeni'], 3,
  'Audit prep used to mean 6 weeks of finance team chaos pulling supporting documentation. AI bookkeeping platforms now ship audit-ready books year-round: every transaction documented, GAAP-mapped, and queryable in seconds. Pilot leads startup audit prep with multi-entity and revenue-recognition support; Bench handles SMB audit-readiness with bookkeeper-review of every transaction; Docyt and Zeni automate document collection alongside categorization.',
  'Selection prioritized: GAAP compliance, audit-trail completeness, supporting-document automation, and integration with audit-firm portals.',
  '[
    {"q":"What does audit-ready actually mean?","a":"3 things: every transaction has source documentation attached (receipt, invoice, contract); books map to GAAP standards (proper accrual accounting, revenue recognition); change history is preserved (who edited what and when). AI platforms automate the first 2; the third is platform-architecture."},
    {"q":"Pilot vs Bench for audit prep?","a":"Pilot is tier-A for venture-backed Series B+ companies preparing for first audit, with multi-entity and ASC 606 revenue recognition support; Bench fits SMBs preparing for due-diligence-style review rather than full audit. Most Series A-stage companies pick Pilot."},
    {"q":"How long should audit prep take?","a":"With AI-driven year-round documentation, 1-2 weeks for a clean Series B audit; 3-6 weeks if books were not maintained continuously. The compression comes from continuous documentation, not from any audit-week sprint."}
  ]'::jsonb, 'finance', 'advanced', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-cfo-services
(
  'ai-for-cfo-services', 'AI for CFO Services', '🎯',
  ARRAY['finance'], ARRAY['pilot','bench','docyt','zeni'], 3,
  'Fractional CFO services are how most companies under 50M revenue access strategic finance without a full-time hire. AI-powered platforms now bundle bookkeeping, tax, financial planning, and board-deck preparation alongside human CFO advisory. Pilot pairs AI bookkeeping with optional CFO services; Bench includes finance advisory in higher tiers; Docyt and Zeni offer AI-first finance with on-demand human advisory layered on top.',
  'We weighted: CFO-advisor experience and availability, financial-planning automation depth, board-deck and investor-update generation, and ERP integration.',
  '[
    {"q":"When do we need a fractional CFO vs full-time?","a":"Series A through late B (10-30 employees, 1-10M revenue) is the fractional sweet spot. Below that, AI bookkeeping plus founder oversight is enough; above that, in-house CFO compensates fast through deal sourcing, banker relationships, and team building."},
    {"q":"What can AI handle vs what needs human CFO?","a":"AI handles: bookkeeping, transaction categorization, basic forecasting, board-deck data assembly. Human CFO handles: capital strategy, banker negotiations, hiring decisions, board narrative. The split lets the human focus on judgment work."},
    {"q":"Pilot CFO vs hiring directly?","a":"Pilot CFO services run 10-25K monthly with structured deliverables; direct fractional CFO contractors run 5-15K monthly but require sourcing, vetting, and onboarding. Companies wanting plug-and-play pick Pilot; companies wanting deep relationship pick a direct hire."}
  ]'::jsonb, 'finance', 'advanced', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-receipt-tracking
(
  'ai-for-receipt-tracking', 'AI for Receipt Tracking', '🧾',
  ARRAY['finance'], ARRAY['ramp','brex','airbase'], 3,
  'Receipt tracking was the single worst part of expense reports for a decade, and AI corporate-card platforms have made it nearly invisible. Ramp and Brex auto-match receipts to card transactions in real time; Airbase adds approval workflow and policy enforcement on top. The shift is from monthly receipt-collection emails to receipt-required-or-card-frozen automation that runs in the background.',
  'Selection prioritized: OCR accuracy, real-time matching speed, mobile-app receipt capture UX, and IRS-compliance audit trail.',
  '[
    {"q":"How accurate is AI receipt matching?","a":"For standard merchant receipts (clear vendor name, amount, date), 95%+ accuracy via OCR plus card-transaction context. Handwritten or partial receipts drop to 70-80%; cards capture and prompt the user for missing data when accuracy is low."},
    {"q":"What about receipts under $75 IRS threshold?","a":"IRS does not require receipts under $75 for most expenses, but most companies require them anyway for audit trail and policy enforcement. AI platforms enforce this at the policy layer with override capability for known low-value categories."},
    {"q":"Ramp vs Brex for receipt tracking?","a":"Both ship excellent OCR and matching; differences are in adjacent features. Ramp has stronger spend controls and approval flows for SMB; Brex has stronger international coverage and travel rewards. Pick on broader fit, not on receipt tracking alone."}
  ]'::jsonb, 'finance', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === CUSTOMER-SUCCESS (3) ===

-- 5. ai-for-csm-productivity
(
  'ai-for-csm-productivity', 'AI for CSM Productivity', '⚡',
  ARRAY['customer-service'], ARRAY['vitally','planhat','gainsight','catalyst','totango'], 3,
  'Customer Success Managers spend up to 40% of their week on data-pull, meeting prep, and CRM updates rather than customer conversations. AI-augmented CSM platforms now automate the data layer: usage rollups, account briefs, action items from calls, and CRM sync without manual entry. Vitally and Catalyst lead Slack-native CSM productivity for product-led SaaS; Gainsight and Planhat target enterprise CSM workflow; Totango focuses on usage-driven account management.',
  'We weighted: data-pull automation, account-brief quality, CRM-sync depth, and integration with product analytics and meeting tools.',
  '[
    {"q":"How much time can AI save a CSM?","a":"10-15 hours per week is the typical lift after 30 days. The biggest wins are: account-brief generation (90 minutes saved per week), action-item extraction from calls (60-90 minutes), and usage-data pull (60 minutes). Net effect is 1.5-2x more customer-facing time."},
    {"q":"Vitally vs Gainsight for CSM productivity?","a":"Vitally is faster to deploy with stronger Slack-native UX and product-led-SaaS workflows; Gainsight has deeper enterprise features (orchestration, journey mapping, CDP integration). Companies under 200 customers default to Vitally; enterprise SaaS picks Gainsight."},
    {"q":"Does AI replace the CSM relationship?","a":"No. AI removes the data-prep and admin work; the CSM relationship is the asset that drives renewals and expansion. Companies that use AI to scale CSMs from 30 accounts to 60 each retain the same renewal rates with half the headcount."}
  ]'::jsonb, 'customer-success', 'intermediate', 320,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 6. ai-for-success-plans
(
  'ai-for-success-plans', 'AI for Success Plans', '📌',
  ARRAY['customer-service'], ARRAY['vitally','gainsight','planhat','churnzero','totango'], 3,
  'A success plan is the joint document between CSM and customer that defines what value looks like for that account and how to measure progress toward it. AI-augmented CSM platforms now auto-generate success-plan templates from account context, suggest milestones from product-usage benchmarks, and prompt CSMs when milestones are at risk. Vitally and Gainsight lead the success-plan automation category; Planhat and ChurnZero ship lighter success-plan workflows for SMB; Totango focuses on outcome-tracking dashboards.',
  'Selection prioritized: template-generation quality, milestone-tracking automation, customer-facing share-link UX, and integration with product analytics.',
  '[
    {"q":"What goes in a strong success plan?","a":"3 things: defined business outcomes the customer is trying to achieve (revenue, cost-savings, time-savings); measurable milestones with dates and owners; risks and mitigations. Anything beyond that becomes shelfware."},
    {"q":"How often should success plans be updated?","a":"Quarterly review at minimum, with monthly milestone tracking. AI platforms surface progress against milestones automatically; CSMs spend the meeting on strategic conversation rather than data review."},
    {"q":"Should we share success plans with customers?","a":"Yes for transparency and joint accountability. Tools like Gainsight and Vitally ship customer-facing share links; reading-only access is the default and works for most enterprise relationships. Co-editing is rare and usually creates misalignment."}
  ]'::jsonb, 'customer-success', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-onboarding-emails
(
  'ai-for-onboarding-emails', 'AI for Onboarding Emails', '📨',
  ARRAY['customer-service','marketing'], ARRAY['intercom','hubspot','klaviyo','activecampaign'], 3,
  'New-user onboarding emails determine whether a signup becomes an activated user or a churned trial. AI-powered email platforms now segment by onboarding-stage behavior, draft personalized progress nudges, and trigger contextual help when users stall on a specific step. Intercom leads in-app and email onboarding for SaaS; HubSpot and ActiveCampaign blend onboarding emails with broader marketing automation; Klaviyo targets ecommerce-specific onboarding flows.',
  'We weighted: behavior-trigger depth, personalization quality, in-app and email channel coordination, and analytics on onboarding funnel.',
  '[
    {"q":"How many onboarding emails should we send?","a":"5-7 across the first 14 days for SaaS; 3-5 across the first 7 days for ecommerce. Each email should focus on one action and one value moment. Beyond 7 emails the open rate drops sharply and unsubscribe rates spike."},
    {"q":"Intercom vs HubSpot for SaaS onboarding?","a":"Intercom integrates in-app messaging with email onboarding more tightly and ships better behavior triggers for product-led SaaS; HubSpot is broader marketing automation with onboarding as one workflow. Product-led SaaS picks Intercom; sales-led SaaS picks HubSpot."},
    {"q":"Should onboarding emails personalize beyond first name?","a":"Yes when the data is clean. Reference the use case the user signed up for (from signup form or first-event data); reference progress so far (steps completed); reference the team or company size if collected. Pure first-name swap underperforms generic templates."}
  ]'::jsonb, 'customer-success', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === HR-RECRUITING (4) ===

-- 8. ai-for-employee-recognition
(
  'ai-for-employee-recognition', 'AI for Employee Recognition', '🏆',
  ARRAY['hr'], ARRAY['lattice','culture-amp','15five'], 3,
  'Employee recognition done well is a top-3 retention driver; done poorly it becomes annual-spot-bonus theater. AI-augmented platforms now prompt managers when team members ship measurable wins, suggest peer-recognition moments from Slack and project channels, and aggregate recognition patterns to flag inequitable distribution. Lattice integrates recognition into performance cycles; Culture Amp ships recognition alongside engagement surveys; 15Five blends recognition into weekly check-ins.',
  'Selection prioritized: prompt-quality for managers, peer-recognition workflow, equity-tracking depth, and integration with Slack and Teams.',
  '[
    {"q":"Lattice vs Bonusly for recognition?","a":"Lattice integrates recognition with performance reviews and goal cycles; Bonusly is a focused points-and-rewards platform with higher gamification. Companies wanting recognition tied to performance pick Lattice; companies wanting points-based peer-to-peer pick Bonusly."},
    {"q":"How often should managers recognize?","a":"Weekly is the sweet spot for direct-team recognition; monthly for cross-team. AI prompts managers when measurable wins ship; the friction reduction lifts recognition frequency 3-5x over manual habit alone."},
    {"q":"Does AI catch inequitable recognition?","a":"Yes via aggregate analytics: who gets recognized, by whom, how often. Tools surface patterns where minority-group employees receive 30-50% less recognition and prompt managers to balance. The detection is more reliable than self-audit but does not replace policy."}
  ]'::jsonb, 'hr-recruiting', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 9. ai-for-internal-mobility
(
  'ai-for-internal-mobility', 'AI for Internal Mobility', '🔀',
  ARRAY['hr'], ARRAY['lattice','rippling','eightfold','beamery'], 3,
  'Internal mobility (employees moving to new roles within the company) is 2-3x cheaper than external hiring and has higher retention outcomes, yet most companies execute it poorly. AI talent platforms now match employee skills against open roles, surface lateral and upward opportunities employees would not see in standard postings, and prompt managers when team members are at flight risk. Eightfold and Beamery lead AI talent intelligence; Lattice and Rippling integrate mobility into broader HRIS workflows.',
  'We weighted: skill-matching accuracy, open-role surfacing UX, manager-flight-risk alerts, and integration with ATS and HRIS.',
  '[
    {"q":"Eightfold vs Beamery?","a":"Eightfold is the deepest AI talent platform with skill-graph at the core, used at enterprise scale (10K+ employees); Beamery focuses on talent acquisition with lighter internal mobility. Pure internal mobility at enterprise picks Eightfold; broader talent CRM picks Beamery."},
    {"q":"How does AI match employees to roles?","a":"Skills, work history, project participation, and learning history get vectorized into a skill profile; open roles get vectorized similarly; matching is cosine-similarity ranked. Top-10 matches are usually 70-85% relevant; humans refine from there."},
    {"q":"Does internal mobility really improve retention?","a":"Yes. Employees who make an internal move are 2-3x less likely to leave in the next 12 months than those who do not. The compounding effect on retention is significant: companies running structured internal mobility programs see 5-10 point retention lift."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-career-pathing
(
  'ai-for-career-pathing', 'AI for Career Pathing', '🪜',
  ARRAY['hr'], ARRAY['lattice','culture-amp','15five','bamboohr'], 3,
  'Career pathing is the missing layer between performance reviews and retention: employees who see a future at the company stay 2-3x longer. AI-augmented HRIS platforms now generate role-progression maps from skill graphs, suggest learning paths to close gaps, and surface stretch projects employees can take to demonstrate readiness. Lattice and Culture Amp lead career-pathing inside performance platforms; 15Five and BambooHR ship lighter pathing tied to development conversations.',
  'Selection prioritized: role-progression-map quality, learning-path generation, stretch-project surfacing, and integration with performance reviews.',
  '[
    {"q":"How granular should career paths be?","a":"3 levels of granularity work: current role and the next 1-2 roles up; lateral moves to adjacent functions; long-term destination roles 3-5 years out. Beyond that, paths become aspirational rather than actionable."},
    {"q":"Lattice vs Culture Amp for career pathing?","a":"Lattice has cleaner role-progression UX integrated with performance reviews; Culture Amp ties pathing to engagement surveys and development conversations. Performance-cycle-led companies pick Lattice; development-led companies pick Culture Amp."},
    {"q":"Should employees own their career path?","a":"Yes with manager support. Best practice: employee drafts the path, manager provides feedback and stretch-project access, HR provides learning-path resources. Tools should support all 3 personas in one workflow."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 11. ai-for-job-offers
(
  'ai-for-job-offers', 'AI for Job Offers', '🎁',
  ARRAY['hr'], ARRAY['ashby','greenhouse','lever','rippling'], 3,
  'Job offer generation used to be a 30-minute manual exercise per candidate involving comp benchmarks, equity grants, and offer-letter drafting. AI-augmented ATS platforms now auto-fill offers from the candidate record, suggest comp benchmarks against market data, generate equity grants per the cap table, and route approvals in parallel. Ashby and Greenhouse lead modern ATS offer-flow; Lever ships offer workflow alongside its CRM-style ATS; Rippling bundles offers into broader HRIS for post-accept onboarding handoff.',
  'We weighted: offer-letter automation depth, comp-benchmark integration, equity-grant accuracy, and parallel-approval workflow.',
  '[
    {"q":"Ashby vs Greenhouse for offers?","a":"Ashby has cleaner offer-flow UX with built-in comp benchmarks and analytics; Greenhouse has deeper integration ecosystem and enterprise scale. Mid-market companies under 500 employees pick Ashby; enterprise picks Greenhouse."},
    {"q":"How accurate are AI comp benchmarks?","a":"For standard roles in major markets, 90%+ accurate within +/- 10% of actual market median. Edge cases: niche roles, smaller markets, or specialty skills require human comp-team validation. Always benchmark against multiple sources for senior roles."},
    {"q":"Should AI generate offer letters fully?","a":"For standard offers (full-time W2, standard equity), yes with light review. For executive, contractor, or international offers, AI drafts a starting point that needs comp-team and legal review. Edge cases scale with seniority."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === OPS (4) ===

-- 12. ai-for-business-intelligence
(
  'ai-for-business-intelligence', 'AI for Business Intelligence', '📊',
  ARRAY['analytics'], ARRAY['metabase','tableau','rows','akkio','looker'], 3,
  'Business intelligence used to mean SQL-trained analysts gatekeeping the data warehouse. AI-augmented BI platforms now let any operator ask plain-language questions and get back charts, dashboards, and narrative insights without writing a line of SQL. Tableau and Looker lead enterprise BI with AI-augmented natural-language query; Metabase and Mode target startup-friendly BI with AI assist; Rows and Akkio ship spreadsheet-and-AutoML-driven BI for non-technical operators.',
  'Selection prioritized: natural-language query accuracy, chart-generation aesthetics, dashboard-sharing UX, and integration with warehouse and BI tools.',
  '[
    {"q":"Tableau vs Looker for BI?","a":"Tableau has deeper visualization library and broader chart-type support; Looker is stronger at semantic-layer modeling and dashboard governance. Visualization-led BI picks Tableau; semantic-layer-and-governance BI picks Looker."},
    {"q":"How accurate is plain-language SQL generation?","a":"For standard queries on well-modeled data, 80-90% first-shot accuracy. Accuracy degrades on complex joins, ambiguous column names, or sparse data. Treat AI-generated SQL as a starting point that needs analyst review for production use."},
    {"q":"Metabase vs Tableau for SMB?","a":"Metabase is open-source-friendly with cleaner SMB UX and lower TCO; Tableau is enterprise-grade with deeper features but heavier deployment. SMB and startup teams pick Metabase; mid-market and enterprise pick Tableau."}
  ]'::jsonb, 'ops', 'intermediate', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 13. ai-for-runbooks
(
  'ai-for-runbooks', 'AI for Runbooks', '📕',
  ARRAY['productivity','documentation'], ARRAY['document360','notion-ai','slab','coda','guru'], 3,
  'Runbooks document the step-by-step procedures that keep operations running: incident response, deployment rollouts, customer-onboarding handoffs. AI-augmented documentation platforms now generate runbook drafts from past incidents, suggest updates when source content drifts, and surface which runbooks executed during incidents for continuous improvement. Document360 and GitBook lead structured runbook publishing; Notion AI and Coda blend runbooks with broader workspace; Slab and Guru target internal-handbook and SOP use cases.',
  'We weighted: runbook-template quality, version control, change-detection alerts, and integration with incident-management tools.',
  '[
    {"q":"How detailed should runbooks be?","a":"Each step should pass the 3am test: a sleepy on-call engineer can execute it without context. Code commands, screenshots, expected outcomes, and rollback steps. Anything more abstract becomes shelfware during real incidents."},
    {"q":"Notion vs Document360 for runbooks?","a":"Notion is faster to start with flexible structure; Document360 has cleaner versioning, change tracking, and publish workflow for runbooks shared across teams or with customers. Internal runbooks use Notion; customer-facing or compliance-heavy runbooks use Document360."},
    {"q":"Can AI keep runbooks current?","a":"AI flags stale runbooks by detecting source-of-truth changes (deploy scripts, infra config, on-call rotations) but human review is still required before publishing updates. Treat AI as a stale-detection layer, not a self-updating wiki."}
  ]'::jsonb, 'ops', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-reporting-automation
(
  'ai-for-reporting-automation', 'AI for Reporting Automation', '📑',
  ARRAY['analytics','automation'], ARRAY['rows','julius-ai','akkio','formula-bot','deepnote'], 3,
  'Recurring reports (weekly metrics, monthly board updates, quarterly business reviews) consume disproportionate ops time when generated manually. AI-augmented platforms now schedule, generate, and distribute reports with AI-written commentary and chart annotations on top of raw numbers. Rows ships spreadsheet-driven scheduled reports with AI commentary; Julius AI generates narrative-rich reports from data uploads; Deepnote handles notebook-driven scheduled reports; Akkio and Formula Bot focus on AutoML and formula-driven automation.',
  'Selection prioritized: scheduling depth, AI-commentary quality, chart-annotation aesthetics, and distribution channel breadth (email, Slack, embed).',
  '[
    {"q":"What reports benefit most from AI automation?","a":"Recurring reports with stable structure: weekly KPI dashboards, monthly board metrics, weekly team summaries. Anything generated more than 4 times per year is automation-worthy. One-off reports rarely justify the setup time."},
    {"q":"Rows vs Deepnote for reporting?","a":"Rows is spreadsheet-native and faster for non-technical operators; Deepnote is notebook-native and stronger for analyst-heavy workflows with code-driven transformations. Operators pick Rows; analysts pick Deepnote."},
    {"q":"Can AI write report commentary?","a":"For descriptive commentary (this metric went up X%, this segment outperformed), yes with high accuracy. For causal claims and strategic recommendations, AI overstates confidence; always edit before sending to executives or boards."}
  ]'::jsonb, 'ops', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 15. ai-for-change-management
(
  'ai-for-change-management', 'AI for Change Management', '🔄',
  ARRAY['productivity','documentation'], ARRAY['notion-ai','slab','monday','asana','coda'], 3,
  'Change management is the discipline of moving organizations through process, tool, or strategy shifts without breaking output. AI-augmented platforms now generate change-impact assessments, draft communication plans, and track adoption metrics across teams. Notion AI and Coda blend change documentation with project workflow; Asana and Monday handle change-management projects with timelines and stakeholder tracking; Slab fits internal-comms and process documentation.',
  'We weighted: communication-plan automation, stakeholder-tracking depth, adoption-metric integration, and template-library quality for common change types.',
  '[
    {"q":"What is the biggest change-management mistake?","a":"Underinvesting in middle-manager enablement. Top-down comms reach 60-70% of employees; the rest hear from their direct manager. If managers are not equipped to answer questions, adoption stalls regardless of executive narrative."},
    {"q":"How long should change initiatives take?","a":"For tool migrations: 30-60 days for adoption; 90-120 days for behavior change. For process changes: 60-90 days for adoption; 6-12 months for behavior. Compressing timelines below these usually creates change fatigue and reversion."},
    {"q":"Can AI track adoption automatically?","a":"For tool changes, yes via SaaS usage analytics. For behavior changes, partially via survey tracking and process-completion rates. Adoption metrics should triangulate quantitative usage with qualitative survey feedback for accuracy."}
  ]'::jsonb, 'ops', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SUPPORT (3) ===

-- 16. ai-for-csat-surveys
(
  'ai-for-csat-surveys', 'AI for CSAT Surveys', '😊',
  ARRAY['customer-service','research'], ARRAY['typeform','sprig','maze','dovetail'], 3,
  'CSAT surveys at the right moment outperform monthly NPS pulses by 3-5x for actionable insight. AI-augmented survey platforms now trigger CSAT surveys at the right behavioral moment, analyze open-text responses for theme and sentiment, and route detractors to recovery flows automatically. Typeform leads conversational survey UX; Sprig and Maze ship behavior-triggered in-product surveys; Dovetail focuses on qualitative analysis of CSAT open-text responses.',
  'Selection prioritized: behavior-trigger depth, response-rate optimization, AI sentiment and theme analysis, and integration with helpdesk for recovery flows.',
  '[
    {"q":"When should CSAT fire?","a":"After a defining interaction: ticket resolution, onboarding milestone, support call completion. Within 1-24 hours of the event for highest response rate. Generic monthly CSAT pulses underperform event-triggered by 2-3x on response and 3-5x on actionable signal."},
    {"q":"What is a good CSAT score?","a":"For SaaS support: 85+ is excellent, 75-84 is good, 65-74 is concerning, below 65 is action-required. Industry benchmarks vary by category. Trend over time matters more than absolute number."},
    {"q":"Sprig vs Typeform for CSAT?","a":"Sprig is in-product behavior-triggered with deep AI analysis; Typeform is conversational and works across email, web, and embed. In-product SaaS surveys pick Sprig; broader cross-channel surveys pick Typeform."}
  ]'::jsonb, 'support', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 17. ai-for-canned-responses
(
  'ai-for-canned-responses', 'AI for Canned Responses', '💾',
  ARRAY['customer-service'], ARRAY['intercom','front-app','liveagent','zoho-desk','freshchat'], 3,
  'Canned responses (saved replies for common questions) are the foundational productivity layer of every support team. AI-augmented helpdesk platforms now suggest the right canned response per ticket from past resolutions, auto-personalize generic templates with customer context, and surface gaps where canned responses should exist but do not. Intercom and Front lead modern shared-inbox AI canned responses; Zoho Desk and Freshchat target SMB and mid-market support; LiveAgent fits broader multi-channel support.',
  'Selection prioritized: AI-suggestion accuracy, personalization depth, library-organization UX, and integration with knowledge bases.',
  '[
    {"q":"How many canned responses should we have?","a":"30-100 for most support teams. Below 30, agents are reinventing replies; above 100, agents cannot find the right one. Tools auto-suggest from a smaller curated set ranked by ticket-context match."},
    {"q":"How do we keep canned responses fresh?","a":"Monthly review: archive responses with under 5 uses per month; update responses where product changed; add new responses from emerging ticket clusters. AI surfaces all 3 patterns automatically."},
    {"q":"Intercom vs Front for canned responses?","a":"Intercom integrates canned responses with messaging and bot flows; Front is shared-inbox-native with stronger team-collaboration around responses. Product-led-SaaS support picks Intercom; collaborative inbox-style support picks Front."}
  ]'::jsonb, 'support', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 18. ai-for-customer-conversations
(
  'ai-for-customer-conversations', 'AI for Customer Conversations', '💬',
  ARRAY['customer-service'], ARRAY['intercom','front-app','gorgias','crisp','helpscout'], 3,
  'Customer conversations span email, chat, social, and SMS, and unifying them in one inbox with AI assist is the difference between scaling support and drowning in channels. Intercom leads omnichannel conversation AI for SaaS; Front handles shared-inbox-style email-first support; Gorgias targets ecommerce conversations across channels; Crisp and Help Scout fit SMB and mid-market with cleaner UX and lighter AI.',
  'We weighted: channel breadth, AI-suggested-reply quality, conversation-routing depth, and reporting on agent and conversation metrics.',
  '[
    {"q":"Intercom vs Front for conversations?","a":"Intercom is messaging-first with bot flows and in-product chat; Front is email-first with shared-inbox collaboration around external conversations. SaaS picks Intercom; agency or ops-heavy companies pick Front."},
    {"q":"How does AI route conversations?","a":"By topic detection (billing, technical, sales), priority signals (VIP customer, urgent keywords), and capacity (which agent is least busy or most-skilled). Modern platforms hit 85-90% routing accuracy after 30 days of training."},
    {"q":"Should AI auto-reply to customer conversations?","a":"For tier-1 questions answered in the knowledge base, yes with confidence-threshold gates. For tier-2 and 3, AI drafts replies that agents review and send. Always preserve human-in-the-loop for high-stakes conversations like cancellations or escalations."}
  ]'::jsonb, 'support', 'beginner', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SALES (4) ===

-- 19. ai-for-account-research
(
  'ai-for-account-research', 'AI for Account Research', '🔬',
  ARRAY['crm-sales'], ARRAY['lavender','clay','reply-io'], 3,
  'Account research is the work that turns a cold list into a warm prospect: company size, recent funding, hiring patterns, tech stack, and decision-maker movements. AI-powered platforms now run multi-source enrichment on every target account, surface buying signals from public data, and generate research briefs ready for first-touch outreach. Clay leads enrichment-and-orchestration; Lavender personalizes outreach with AI-driven research; Reply.io blends research with multi-channel cadence.',
  'Selection prioritized: enrichment-source breadth, buying-signal accuracy, research-brief automation, and CRM and sequence-tool integration.',
  '[
    {"q":"What signals matter most for account research?","a":"3 high-signal categories: recent funding (last 90 days), hiring spikes in target departments (last 60 days), and tech-stack changes that map to your product. Generic firmographics (employee count, industry) are baseline but rarely move conversations alone."},
    {"q":"Clay vs Apollo for account research?","a":"Clay is multi-source enrichment with orchestration; Apollo is database-first with proprietary contact data. Sophisticated SDR teams use both: Apollo for raw lists, Clay for enrichment and signal scoring."},
    {"q":"How do we measure research ROI?","a":"Reply rate on personalized outreach vs generic. Best-in-class reply rate lift is 1.5-2.5x when research surfaces real signals. If lift is below 1.3x, the research is not surfacing actionable signals; review the enrichment sources."}
  ]'::jsonb, 'sales', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 20. ai-for-sales-emails
(
  'ai-for-sales-emails', 'AI for Sales Emails', '📧',
  ARRAY['crm-sales','writing-ai'], ARRAY['lavender','lemlist','copy-ai','jasper','reply-io','smartlead'], 3,
  'Sales emails determine pipeline more than any other single rep activity, and AI now lifts reply rates 1.5-2x over generic templates when prompted with real account research. Lavender leads AI-coached sales emails with deliverability scoring; Lemlist and Smartlead run high-deliverability cold outreach; Copy.ai and Jasper generate sales-email drafts as part of broader content workflow; Reply.io handles multi-channel cadence with AI personalization.',
  'We weighted: AI-coaching quality, deliverability-protection features, multi-channel sequencing, and integration with CRM and prospecting databases.',
  '[
    {"q":"Lavender vs Lemlist?","a":"Lavender focuses on AI-coaching email quality before send (tone, length, deliverability score); Lemlist focuses on multi-channel deliverability and warmup for high-volume cold outreach. AEs writing personalized emails pick Lavender; SDR teams running volume cadences pick Lemlist."},
    {"q":"What is a good sales-email reply rate?","a":"Cold email: 3-7% reply rate is solid, 8-12% is excellent, above 12% is elite. Reply rate depends heavily on list quality (5x lift from clean targeting) and personalization (1.5-2x lift from research-driven). Volume alone hits diminishing returns fast."},
    {"q":"Should AI generate the full email?","a":"For first-draft acceleration, yes. For final send, edit the AI draft to match your voice and add prospect-specific framing. Pure AI-generated emails sent at scale damage sender reputation and reply rates."}
  ]'::jsonb, 'sales', 'intermediate', 2900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 21. ai-for-deal-progression
(
  'ai-for-deal-progression', 'AI for Deal Progression', '📈',
  ARRAY['crm-sales','meeting-ai'], ARRAY['gong-io','modjo','avoma','salesforce-einstein'], 3,
  'Deal progression is the cycle of identifying what is blocking a deal and removing it; AI revenue-intelligence platforms now do half the work by surfacing risk signals, missing decision-maker access, and stalled-deal patterns automatically. Gong leads enterprise revenue intelligence with deepest deal-progression analytics; Modjo and Avoma ship mid-market alternatives with strong call-analysis; Salesforce Einstein layers AI on top of CRM data for forecast and progression intelligence.',
  'Selection prioritized: deal-risk-detection accuracy, missing-decision-maker alerts, forecast-confidence scoring, and CRM and meeting-tool integration.',
  '[
    {"q":"What signals predict a deal will slip?","a":"3 strongest signals: 14+ days since last meaningful customer interaction, no engagement from a senior decision-maker (VP+ on customer side), and missed milestone (no champion identified, no security review started). AI surfaces all 3 automatically."},
    {"q":"Gong vs Salesforce Einstein for progression?","a":"Gong derives signals from call-and-email content (what happened); Einstein derives signals from CRM activity data (what was logged). Both are complementary - many enterprise revops teams use both. Pure call-driven intelligence picks Gong."},
    {"q":"Can AI replace the deal-review meeting?","a":"It compresses it from 60 minutes to 20 minutes. AI surfaces the deal-risk dashboard automatically; the meeting becomes targeted intervention on the riskiest deals rather than a roll-up of every deal in the pipeline."}
  ]'::jsonb, 'sales', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 22. ai-for-revenue-intelligence
(
  'ai-for-revenue-intelligence', 'AI for Revenue Intelligence', '💎',
  ARRAY['crm-sales','analytics'], ARRAY['gong-io','modjo','clari','outreach'], 3,
  'Revenue intelligence is the discipline of using data from CRM, calls, emails, and product usage to forecast revenue and identify deal risk before either becomes obvious. Gong leads the category with deepest call-and-email intelligence; Clari focuses on forecast accuracy and pipeline analytics; Modjo serves European markets with strong call-intelligence; Outreach blends revenue intelligence with sales-engagement workflow.',
  'We weighted: forecast-accuracy lift over manual baseline, call and email intelligence depth, pipeline-risk scoring, and integration with CRM and meeting tools.',
  '[
    {"q":"What is the ROI of revenue intelligence?","a":"Top-quartile teams see 5-15% lift in forecast accuracy and 10-20% lift in win rate after 90 days. ROI compounds because better forecasts inform hiring and capital decisions, and better win rates compound through compensation and confidence."},
    {"q":"Gong vs Clari?","a":"Gong is conversation-data-first (call transcripts, emails); Clari is forecast-data-first (CRM activity, deal-stage progression). Many enterprise revops teams use both. Mid-market typically picks one - Gong for conversation-heavy sales motion, Clari for activity-heavy."},
    {"q":"How long does deployment take?","a":"For Gong: 30-45 days to first-value insights, 90 days to behavior change in reps. Clari: similar 30-90 day cycle. The bottleneck is rarely tool deployment; it is sales-leader buy-in to act on AI signals consistently."}
  ]'::jsonb, 'sales', 'advanced', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === MARKETING (4) ===

-- 23. ai-for-marketing-funnels
(
  'ai-for-marketing-funnels', 'AI for Marketing Funnels', '🔻',
  ARRAY['marketing'], ARRAY['hubspot','klaviyo','intercom','activecampaign'], 3,
  'Marketing funnels span 5-7 stages from awareness through purchase, and AI-augmented platforms now optimize each stage with behavior-triggered content, predicted next-best-action per visitor, and multi-touch attribution that connects top-of-funnel ads to bottom-of-funnel revenue. HubSpot leads enterprise B2B funnels; Klaviyo targets ecommerce funnels with deep Shopify integration; Intercom blends in-app messaging with funnel automation; ActiveCampaign serves SMB with broad automation flexibility.',
  'Selection prioritized: stage-segmentation depth, attribution-model breadth, AI-personalization quality, and integration with CRM and analytics.',
  '[
    {"q":"HubSpot vs ActiveCampaign for funnels?","a":"HubSpot bundles CRM, marketing automation, and content management with deep enterprise reporting; ActiveCampaign is faster and cheaper with stronger automation flexibility for SMB. Mid-market and enterprise pick HubSpot; SMB under 100 employees picks ActiveCampaign."},
    {"q":"What attribution model should we use?","a":"For SMB: position-based (40% first-touch, 40% last-touch, 20% middle). For enterprise B2B with long cycles: data-driven attribution from a marketing-attribution platform. First-touch and last-touch alone undervalue middle-funnel content."},
    {"q":"How long does funnel optimization take?","a":"30 days to first-value (clean tracking, baseline metrics); 90 days to meaningful lift (10-20% conversion improvement); 12+ months to fully-optimized funnel. Most lift comes from fixing leaks in the worst-performing stage rather than uniform improvement."}
  ]'::jsonb, 'marketing', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 24. ai-for-customer-stories
(
  'ai-for-customer-stories', 'AI for Customer Stories', '📖',
  ARRAY['marketing','writing-ai'], ARRAY['jasper','copy-ai','frase','writesonic'], 3,
  'Customer stories (case studies, testimonials, win-stories) are the highest-converting content for B2B SaaS and the most painful to produce. AI writing platforms now draft customer stories from interview transcripts, structure them around proven story frameworks, and adapt the same source material into multiple formats (long-form, social posts, sales decks). Jasper and Copy.ai lead enterprise content workflows; Frase blends SEO-optimized story drafting; Writesonic targets faster turnaround for SMB.',
  'We weighted: story-framework support, transcript-to-draft accuracy, multi-format repurposing, and brand-voice consistency across stories.',
  '[
    {"q":"What is the best customer story framework?","a":"Problem-Solution-Outcome with quantified metrics. 1 paragraph on the customer problem, 1-2 paragraphs on the solution they implemented, 1 paragraph on outcomes with specific numbers. Anything longer becomes corporate-speak."},
    {"q":"How many customer stories do we need?","a":"5-10 covering top use cases and customer segments. Beyond 10, returns diminish unless they are paired with vertical landing pages. Quality of the top 3 matters more than count of all 10."},
    {"q":"Can AI conduct customer interviews?","a":"For structured intake interviews (form-driven), yes. For deep-narrative interviews requiring follow-up and emotional intelligence, no - human interviewers still outperform. Use AI for first-draft synthesis from human-conducted interviews."}
  ]'::jsonb, 'marketing', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 25. ai-for-newsletter-writing
(
  'ai-for-newsletter-writing', 'AI for Newsletter Writing', '📰',
  ARRAY['writing-ai','marketing'], ARRAY['beehiiv','jasper','substack','copy-ai'], 3,
  'Newsletter writing at consistent quality is one of the hardest disciplines in content marketing because it compounds slowly and demands weekly output. AI writing platforms now draft newsletter sections, suggest subject lines tested against open-rate data, and repurpose long-form content into newsletter format. Beehiiv leads creator-newsletter platforms with built-in growth tools; Jasper and Copy.ai handle newsletter drafting as part of broader content workflow; Substack focuses on creator and journalist newsletters.',
  'Selection prioritized: newsletter-template quality, subject-line generation, growth-tool integration, and analytics on open and click rates.',
  '[
    {"q":"Beehiiv vs Substack?","a":"Beehiiv has stronger built-in growth tools (referral programs, recommendations, web magnet) and better analytics; Substack has stronger writer brand and discovery network. Creators optimizing for growth pick Beehiiv; creators optimizing for brand and discovery pick Substack."},
    {"q":"How long should a newsletter be?","a":"Depends on cadence. Daily: 200-500 words. Weekly: 800-1500 words. Monthly: 2000-3500 words. Open rates correlate with consistency more than length. Skipping a week hurts more than going short."},
    {"q":"Can AI write the whole newsletter?","a":"For roundup or curation newsletters, yes with light human editing. For opinion or essay newsletters, AI drafts a starting point that needs substantial human voice editing. Subscribers detect pure AI writing fast and unsubscribe."}
  ]'::jsonb, 'marketing', 'beginner', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 26. ai-for-product-launches
(
  'ai-for-product-launches', 'AI for Product Launches', '🚀',
  ARRAY['marketing'], ARRAY['beehiiv','hubspot','klaviyo','activecampaign','mailchimp'], 3,
  'Product launches require coordinating email, social, blog, and sales enablement on the same day with consistent messaging across channels. AI marketing platforms now draft launch-day content packages (email blast, social posts, blog announcement, sales talking points) from a single product brief and schedule across channels. HubSpot bundles launch workflow with CRM and content; Klaviyo targets ecommerce product launches; ActiveCampaign and Mailchimp serve SMB launches; Beehiiv handles newsletter-driven launches.',
  'We weighted: cross-channel content generation, scheduling depth, sales-enablement asset support, and analytics on launch-day performance.',
  '[
    {"q":"How early should we plan a launch?","a":"For major launches: 6-8 weeks of preparation. For minor launches: 2-3 weeks. Below 2 weeks, sales enablement and content quality degrade. Above 8 weeks, market timing or competitive moves often force replan."},
    {"q":"What content do we need on launch day?","a":"Minimum kit: email to existing list, social posts (Twitter, LinkedIn), blog announcement, in-product banner, FAQ for support team, and sales talking points. AI generates first drafts of all 6 from the launch brief."},
    {"q":"How do we measure launch success?","a":"3 horizons: launch day (signups, social shares, press mentions), week 1 (activation, qualified leads), month 1 (revenue impact, retention of new users). Most launches over-index on day 1 metrics and under-measure week-1-and-beyond."}
  ]'::jsonb, 'marketing', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === WRITING (3) ===

-- 27. ai-for-resumes
(
  'ai-for-resumes', 'AI for Resumes', '📄',
  ARRAY['writing-ai'], ARRAY['grammarly','jasper','copy-ai','writesonic','rytr'], 3,
  'Resume writing is now AI-augmented end to end: bullet rewrites with quantified impact, tone matching to target role, and ATS-keyword optimization. Grammarly bundles resume rewriting with broader writing assistance; Jasper and Copy.ai handle resume drafts as part of content workflows; Writesonic and Rytr target faster turnaround for SMB and individuals. The shift is from generic templates to role-and-company-specific resume tuning.',
  'Selection prioritized: ATS-keyword optimization, bullet-rewrite quality, tone-matching accuracy, and template library coverage.',
  '[
    {"q":"How important are ATS keywords?","a":"Critical for large companies using applicant-tracking systems that filter resumes by keyword match. Aim for 60-80% keyword overlap with the job description without keyword stuffing. AI tools surface gaps automatically."},
    {"q":"Should bullets quantify everything?","a":"Top 60-70% of bullets should have a number (revenue, percentage, count, time-saved). The remaining 30-40% can be qualitative. Pure quantification reads robotic; pure qualitative reads vague. AI tools suggest quantification candidates from work-history context."},
    {"q":"Are AI-generated resumes detectable?","a":"By recruiters: usually no, especially after light human editing. By ATS: never, since ATS scans for keywords and structure. Always edit the AI draft to match your voice and add specific accomplishments AI cannot invent."}
  ]'::jsonb, 'writing', 'beginner', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 28. ai-for-bullet-points
(
  'ai-for-bullet-points', 'AI for Bullet Points', '•',
  ARRAY['writing-ai'], ARRAY['grammarly','jasper','copy-ai','wordtune','quillbot'], 3,
  'Bullet points are the workhorse format of slide decks, executive summaries, and resumes - and writing them tightly takes time. AI writing platforms now compress sentences to crisp bullets, suggest parallel structure across a list, and surface vague verbs that should be replaced with specific actions. Grammarly catches structural issues; Jasper and Copy.ai handle bullet drafting as part of broader content workflow; Wordtune and Quillbot rewrite paragraphs into clean bullet form.',
  'We weighted: sentence-to-bullet compression quality, parallel-structure detection, vague-verb flagging, and integration with editors and presentation tools.',
  '[
    {"q":"What makes a strong bullet point?","a":"3 traits: starts with a strong verb (delivered, shipped, reduced), includes a specific number or named outcome, fits one line on a 16:9 slide. Anything that violates all 3 is decorative rather than communicative."},
    {"q":"How long should bullets be?","a":"6-12 words for slides; 12-20 words for documents. Longer than 20 words is a paragraph disguised as a bullet. AI tools flag bullets exceeding length thresholds automatically."},
    {"q":"Should bullets have parallel structure?","a":"Yes within a list. All start with verbs, or all start with nouns, but not mixed. Parallel structure compounds readability; broken structure creates cognitive load. AI tools detect and flag parallel-structure breaks."}
  ]'::jsonb, 'writing', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 29. ai-for-amazon-listings
(
  'ai-for-amazon-listings', 'AI for Amazon Listings', '🛒',
  ARRAY['writing-ai'], ARRAY['jasper','copy-ai','writesonic','rytr','anyword'], 3,
  'Amazon product listings live or die on title, bullets, description, and backend keywords - and AI writing platforms now optimize all 4 for Amazon search and conversion. Jasper and Copy.ai lead enterprise ecommerce content; Writesonic and Rytr target SMB sellers with faster turnaround; Anyword adds predictive performance scoring on top of generated listings. The compression is from 30-60 minutes per listing to 5-10 minutes.',
  'Selection prioritized: Amazon-specific template support, A9-keyword optimization, conversion-prediction scoring, and bulk-generation capacity for large catalogs.',
  '[
    {"q":"What matters most in an Amazon listing?","a":"Title (first 80 characters drive both search and click), bullets (5 of them, benefit-first not feature-first), main image (white background, fills 85% of frame), and backend keywords (alternate spellings, related queries). A+ content multiplies conversion."},
    {"q":"Can AI predict Amazon performance?","a":"Tools like Anyword score generated listings against historical-performance data with moderate accuracy. Treat scores as directional rather than predictive. Real performance depends on price, reviews, image quality, and competitor positioning - none of which the listing copy alone determines."},
    {"q":"How often should we refresh listings?","a":"Quarterly for top sellers (top 20% by revenue); annually for long-tail. Refresh triggers: review-content shifts (new pain point or benefit emerging), competitor listing changes, or A9 algorithm updates announced by Amazon."}
  ]'::jsonb, 'writing', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (3) ===

-- 30. ai-for-product-photos
(
  'ai-for-product-photos', 'AI for Product Photos', '📸',
  ARRAY['design'], ARRAY['midjourney','flux','photoroom','remove-bg','picsart'], 3,
  'Product photography used to mean a $200-1000 studio shoot per SKU; AI tools now generate brand-consistent product photos in minutes. Photoroom and Remove.bg handle background removal and replacement at scale; Midjourney and Flux generate lifestyle product shots from prompts; Picsart adds editing on top. The shift is from per-product photoshoot to template-driven AI workflows for catalogs of 100+ SKUs.',
  'We weighted: background-removal accuracy, lifestyle-shot quality, batch-processing capacity, and brand-template enforcement.',
  '[
    {"q":"Photoroom vs Remove.bg?","a":"Photoroom bundles background removal with replacement, templates, and batch processing for ecommerce; Remove.bg is purpose-built for background removal with strong API access. Single-product workflow uses Remove.bg; multi-product catalog workflow uses Photoroom."},
    {"q":"Can AI generate product shots from scratch?","a":"For lifestyle-context shots (product on a kitchen counter, in a garden, on a desk), yes with Midjourney or Flux. For product-only catalog shots requiring exact SKU fidelity, no - real product photography or 3D rendering still wins."},
    {"q":"What about hero shots for ecommerce?","a":"Real photography for hero (top of listing); AI-generated for secondary lifestyle and context shots. The hybrid balances cost and authenticity. Pure AI-generated hero shots damage trust on premium products."}
  ]'::jsonb, 'design', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 31. ai-for-stock-photos
(
  'ai-for-stock-photos', 'AI for Stock Photos', '🖼️',
  ARRAY['design'], ARRAY['midjourney','flux','leonardo-ai','ideogram'], 3,
  'Stock photo subscriptions cost $300-1000 annually and rarely deliver the exact image needed. AI image generators now produce custom stock-style photography in seconds at a fraction of the cost. Midjourney leads on visual quality and style consistency; Flux ships top-tier photorealism; Leonardo AI offers fine-tuned models for specific styles; Ideogram excels at typography-heavy compositions. The shift is from search-and-license to prompt-and-generate workflows.',
  'Selection prioritized: photorealism quality, style-consistency across iterations, commercial-use licensing, and bulk-generation pricing.',
  '[
    {"q":"Are AI stock photos commercially safe?","a":"Generally yes for tools with explicit commercial-use licenses (Midjourney paid tiers, Flux paid, Leonardo paid). Always verify the platform terms; some restrict commercial use on free tiers. For images depicting recognizable people or trademarks, copyright risk is unsettled in 2026."},
    {"q":"Midjourney vs Flux for stock photos?","a":"Midjourney has stronger artistic-style range and brand-consistency via style references; Flux beats Midjourney on photorealism with people and rendering text correctly inside images. Lifestyle stock picks Midjourney; photoreal stock picks Flux."},
    {"q":"How many credits does a stock photo cost?","a":"Midjourney standard plan: ~30 cents per image after subscription. Flux paid: 2-5 cents per image. Leonardo: 1-3 cents. All are 5-50x cheaper than per-image stock licensing for high-volume use cases."}
  ]'::jsonb, 'design', 'beginner', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 32. ai-for-social-banners
(
  'ai-for-social-banners', 'AI for Social Banners', '🏞️',
  ARRAY['design','social-media-ai'], ARRAY['midjourney','leonardo-ai','photoroom','picsart'], 3,
  'Social banners (LinkedIn cover, Twitter header, Facebook page banner) drive first-impression credibility and need refreshing every quarter to stay current. AI design tools now generate brand-consistent banners in 60 seconds and resize them for every platform automatically. Canva is the SMB default with template-driven banner workflow; Photoroom and Picsart handle banner editing with brand-template enforcement; Midjourney and Leonardo AI generate raw artwork for designer compositing.',
  'We weighted: template library quality, multi-platform export sizing, brand-template enforcement, and AI-generated background and accent quality.',
  '[
    {"q":"What size should social banners be?","a":"LinkedIn cover: 1584x396. Twitter/X header: 1500x500. Facebook page cover: 820x312. Tools auto-resize from a single canvas to all platforms; verify safe zones for profile-photo overlap on each platform."},
    {"q":"How often should we refresh banners?","a":"Quarterly for active brand-building accounts; annually for static profiles. Refresh triggers: new product launch, seasonal campaign, brand-refresh, or major company milestone. Static banners signal a stale account."},
    {"q":"Canva vs Photoroom for social banners?","a":"Canva has the deepest template library and team-collaboration; Photoroom is faster for single-banner editing with stronger AI background generation. SMB and team picks Canva; solo creators pick Photoroom."}
  ]'::jsonb, 'design', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DATA-ANALYTICS (3) ===

-- 33. ai-for-trend-analysis
(
  'ai-for-trend-analysis', 'AI for Trend Analysis', '📉',
  ARRAY['analytics'], ARRAY['julius-ai','akkio','formula-bot','rows','deepnote'], 3,
  'Trend analysis turns raw time-series into directional insight: revenue is decelerating, churn is rising, support volume is shifting category. AI analytics platforms now spot trends across millions of rows in seconds, generate narrative explanations, and forecast forward 30-90 days. Julius AI ships conversational trend analysis with chart generation; Akkio adds AutoML predictions on top of trends; Formula Bot translates plain-language trend questions into spreadsheet formulas; Rows and Deepnote handle notebook-driven trend analysis.',
  'Selection prioritized: trend-detection accuracy, narrative-explanation quality, forecast-confidence scoring, and integration with warehouse and BI.',
  '[
    {"q":"What kinds of trends should we track?","a":"3 categories: leading indicators (signup velocity, demo requests, NPS), lagging metrics (revenue, churn, expansion), and adjacent signals (support volume, feature adoption, competitor moves). Most companies over-index on lagging and miss leading indicators."},
    {"q":"How accurate are AI trend forecasts?","a":"Short-term (30-90 days): 80-95% accurate when historical data is 12+ months and patterns are stable. Long-term (12+ months): less reliable. Use forecasts as planning aids, not commitments."},
    {"q":"Julius vs Akkio for trends?","a":"Julius is conversational analysis with strong chart generation for ad-hoc trend exploration; Akkio is AutoML-driven for production-grade trend prediction. Analysts doing exploration pick Julius; teams operationalizing trend forecasts pick Akkio."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 34. ai-for-spreadsheet-formulas
(
  'ai-for-spreadsheet-formulas', 'AI for Spreadsheet Formulas', '📐',
  ARRAY['analytics','productivity'], ARRAY['formula-bot','julius-ai','rows','akkio'], 3,
  'Excel and Google Sheets formulas remain a productivity blocker for non-power-users: nested IFs, VLOOKUP variations, and array formulas eat hours weekly. AI formula assistants now translate plain-language requests into working formulas, debug broken formulas with explanations, and suggest cleaner alternatives. Formula Bot leads dedicated formula generation; Julius AI handles spreadsheet analysis with formula support; Rows ships AI-native spreadsheets with formula-by-prompt; Akkio adds AutoML on spreadsheet data.',
  'We weighted: formula-generation accuracy, debug-explanation quality, formula-library coverage (Excel, Sheets, Notion), and team-collaboration features.',
  '[
    {"q":"How accurate is plain-language formula generation?","a":"For standard formulas (SUMIFS, VLOOKUP, INDEX-MATCH), 90%+ first-shot accuracy. For complex array formulas or volatile-function chains, 70-80% accuracy with prompt iteration. Always test the generated formula on edge cases before relying on it."},
    {"q":"Formula Bot vs Rows?","a":"Formula Bot is a focused tool inside Excel and Sheets via plugin; Rows is a complete AI-native spreadsheet replacement with formulas as one feature. Power users staying in Excel pick Formula Bot; teams open to switching spreadsheets pick Rows."},
    {"q":"Can AI replace VLOOKUP entirely?","a":"For lookups, INDEX-MATCH and XLOOKUP outperform VLOOKUP in flexibility. AI tools default to XLOOKUP in modern Excel and Sheets, with INDEX-MATCH fallback for older versions. The choice is automatic."}
  ]'::jsonb, 'data-analytics', 'beginner', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 35. ai-for-funnel-analysis
(
  'ai-for-funnel-analysis', 'AI for Funnel Analysis', '🪣',
  ARRAY['analytics'], ARRAY['amplitude','heap','pendo','sprig','segment'], 3,
  'Funnel analysis identifies which step in a multi-step user journey is losing the most users so product teams can prioritize fixes. AI-augmented product analytics platforms now auto-detect funnel anomalies, segment drop-off by user property, and suggest experiment ideas to lift conversion. Amplitude and Heap lead enterprise product analytics with deep funnel intelligence; Pendo blends funnel analysis with in-product guides; Sprig adds survey integration to investigate why users drop off; Segment focuses on event collection feeding all of the above.',
  'Selection prioritized: funnel-builder UX, anomaly-detection accuracy, drop-off segmentation, and integration with experimentation tools.',
  '[
    {"q":"What conversion rate is good for SaaS funnels?","a":"Activation funnel (signup to key action): 30-50% is solid. Trial-to-paid: 15-25% for self-serve, 30-40% for sales-assisted. Free-to-paid for freemium: 2-5% is typical. Industry benchmarks vary; trend over time matters more than absolute number."},
    {"q":"Amplitude vs Heap?","a":"Amplitude has stronger out-of-the-box ML and behavioral predictions; Heap has cleaner auto-capture (no manual event instrumentation needed). Engineering-heavy teams pick Amplitude for control; ops-heavy teams pick Heap for setup speed."},
    {"q":"How granular should funnel steps be?","a":"3-7 steps for most funnels. Below 3 misses drop-offs; above 7 fragments the data and dilutes statistical significance per step. Each step should represent a meaningful user decision rather than every UI interaction."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DEV (3) ===

-- 36. ai-for-code-comments
(
  'ai-for-code-comments', 'AI for Code Comments', '💭',
  ARRAY['code-ai'], ARRAY['cursor','aider','codeium','copilot-microsoft','tabnine'], 3,
  'Code comments improve maintainability when they explain WHY non-obvious code exists, but writing them takes discipline most engineers skip. AI code assistants now generate comments inline as engineers ship code, focusing on intent and context rather than restating what the code does. Cursor and GitHub Copilot lead AI code assistants with strong comment generation; Aider focuses on terminal-driven AI coding with comment support; Codeium and Tabnine target lighter-weight AI completion with comment generation.',
  'We weighted: comment-quality (intent vs restatement), inline-suggestion timing, IDE integration, and language coverage.',
  '[
    {"q":"What makes a strong code comment?","a":"Explains WHY, not WHAT. The code already shows what it does; a comment should explain non-obvious context (a workaround for a specific bug, a hidden invariant, a decision rationale). Comments restating what the code does add noise rather than signal."},
    {"q":"Cursor vs Copilot for comments?","a":"Cursor has stronger context-aware comment generation that sees the full file or repository; Copilot generates from local cursor context. Repository-wide comment consistency picks Cursor; per-line lightweight comments pick Copilot."},
    {"q":"Should every function have a comment?","a":"No. Well-named functions and obvious code do not need comments. Comments belong on: hidden constraints, subtle invariants, workarounds for specific bugs, and behavior that would surprise a reader. Comment density is not a quality signal."}
  ]'::jsonb, 'dev', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 37. ai-for-react-components
(
  'ai-for-react-components', 'AI for React Components', '⚛️',
  ARRAY['code-ai','design'], ARRAY['lovable','vercel-v0','bolt','uizard','relume'], 3,
  'Building React components from scratch is the slowest part of frontend work, and AI component generators now ship production-quality React from a prompt or a screenshot. Vercel V0 leads with React-and-shadcn ecosystem alignment; Lovable and Bolt generate full-app React from prompts; Uizard converts mockups to React; Relume targets Webflow-and-React component generation. The shift is from per-component coding to prompt-driven scaffolding.',
  'Selection prioritized: code-quality of generated React, framework-and-library compatibility (Tailwind, shadcn, Material UI), prompt-iteration UX, and export-and-deploy options.',
  '[
    {"q":"V0 vs Lovable?","a":"V0 generates clean shadcn-and-Tailwind components for integration into existing Next.js apps; Lovable generates full-app scaffolds end-to-end with backend wired. Senior devs picking from generated components pick V0; non-devs prototyping full apps pick Lovable."},
    {"q":"Is generated React production-ready?","a":"For prototypes and internal tools, yes with light review. For production customer-facing apps, AI-generated React needs senior-dev review for accessibility, performance, and edge-case handling. Treat AI as a fast first draft."},
    {"q":"Can AI iterate on generated components?","a":"Yes with prompt refinement. V0 and Lovable preserve component context across prompts; Bolt regenerates whole files which can disrupt iteration. Iteration speed favors V0 for component-level work."}
  ]'::jsonb, 'dev', 'intermediate', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 38. ai-for-mobile-app-design
(
  'ai-for-mobile-app-design', 'AI for Mobile App Design', '📱',
  ARRAY['design','code-ai'], ARRAY['lovable','vercel-v0','bolt','uizard','galileo-ai'], 3,
  'Mobile app design used to require Figma plus a designer plus 2-3 weeks of iteration; AI app builders now generate iOS and Android-quality designs from prompts in minutes. Uizard and Galileo AI lead prompt-to-mobile-design generation; Lovable and Bolt handle full-app mobile-friendly React Native and PWA generation; Vercel V0 ships responsive React components that work across mobile and desktop.',
  'We weighted: mobile-pattern fidelity (iOS HIG and Material), prompt-iteration UX, code-export options (React Native, Swift, Kotlin), and design-system support.',
  '[
    {"q":"Uizard vs Galileo AI?","a":"Uizard has cleaner iteration UX with stronger prompt-to-iOS-and-Android workflow; Galileo AI ships higher-fidelity native-pattern compliance. Mockup-to-design picks Uizard; high-fidelity native picks Galileo."},
    {"q":"Can AI generate native iOS code?","a":"For prototype-quality SwiftUI, yes with tools like Galileo and Bolt. For production Swift code, AI accelerates first draft but Apple-platform expertise (HIG compliance, performance, App Store guidelines) still requires human iOS engineer review."},
    {"q":"Should we use React Native or native?","a":"For most consumer apps in 2026, React Native or Flutter is the productivity-vs-performance sweet spot. Native (Swift, Kotlin) wins for high-performance gaming, AR, or platform-specific features. AI tools generate React Native more reliably than native today."}
  ]'::jsonb, 'dev', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === PRODUCTIVITY (2) ===

-- 39. ai-for-todo-lists
(
  'ai-for-todo-lists', 'AI for Todo Lists', '✅',
  ARRAY['productivity'], ARRAY['linear','todoist','notion-ai','asana','clickup'], 3,
  'Todo lists in 2026 are AI-augmented: tasks auto-prioritize by due date and dependency, time-block themselves into the calendar, and surface stale items before they rot. Linear leads engineering-team task management with AI prioritization; Todoist and Asana serve broader knowledge-work teams; Notion AI blends todo lists with broader docs and database workflow; ClickUp targets all-in-one productivity for SMB.',
  'Selection prioritized: prioritization quality, calendar-integration depth, recurring-task support, and team-collaboration features.',
  '[
    {"q":"Todoist vs Asana for todo lists?","a":"Todoist is personal-and-small-team-first with cleaner UX and faster capture; Asana is team-and-project-first with deeper structure for cross-functional work. Solo and small-team picks Todoist; cross-functional team picks Asana."},
    {"q":"Should todos integrate with the calendar?","a":"Yes for time-blocked work. Tools like Reclaim and Motion auto-block tasks into the calendar based on priority and deadline. The downside: rigid calendar blocking creates anxiety when interrupted. Pick based on personal style preference."},
    {"q":"How do we keep todo lists from becoming overwhelming?","a":"Weekly review (delete stale items, defer low-priority), 3-5 daily MITs (most important tasks), and time-boxing 30-60 minutes per task. AI tools surface stale items and suggest deferral candidates automatically."}
  ]'::jsonb, 'productivity', 'beginner', 2900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 40. ai-for-personal-assistants
(
  'ai-for-personal-assistants', 'AI for Personal Assistants', '🤖',
  ARRAY['productivity'], ARRAY['claude','chatgpt','perplexity','gemini','poe'], 3,
  'AI personal assistants in 2026 handle most of what executive assistants used to do: drafting emails, summarizing inbox, researching topics, scheduling meetings via integrations. Claude leads on long-context tasks and reasoning; ChatGPT covers broadest use-case range with the largest plugin ecosystem; Perplexity owns research-grade question-answering with citations; Gemini integrates with Google Workspace; Poe aggregates multiple models in one interface.',
  'We weighted: reasoning quality on multi-step tasks, integration depth (calendar, email, files), citation accuracy for research, and pricing for daily-use volume.',
  '[
    {"q":"Claude vs ChatGPT for daily assistant work?","a":"Claude has stronger long-context reasoning and writing quality on multi-paragraph drafts; ChatGPT has broader plugin ecosystem and broader factual knowledge. Writing-heavy and research-heavy work picks Claude; tool-integration-heavy work picks ChatGPT."},
    {"q":"Can AI replace an executive assistant?","a":"For 70-80% of EA tasks (drafting, research, calendar coordination, email triage), yes. The remaining 20-30% requires judgment around relationships, sensitive communications, and ad-hoc problem solving where AI struggles. Hybrid AI-plus-fractional-EA is the modern stack."},
    {"q":"How much do personal assistants cost?","a":"Claude Pro: 20 USD/mo. ChatGPT Plus: 20 USD/mo. Perplexity Pro: 20 USD/mo. Gemini Advanced: 20 USD/mo. Poe: 20 USD/mo aggregated. Heavy users running multiple models stack 40-60 USD/mo across two-three platforms; still 50-100x cheaper than human EA at 4-8K USD/mo."}
  ]'::jsonb, 'productivity', 'beginner', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === RESEARCH (4) ===

-- 41. ai-for-survey-design
(
  'ai-for-survey-design', 'AI for Survey Design', '📋',
  ARRAY['research'], ARRAY['dovetail','maze','typeform','sprig','lookback'], 3,
  'Survey design quality determines whether the data collected is signal or noise, and AI research platforms now help framers test wording, flow, and bias before fielding. Dovetail and Lookback specialize in qualitative research with question-bank suggestions; Maze and Sprig blend quantitative survey design with research workflow; Typeform handles broader survey use cases with AI-assisted question framing.',
  'Selection prioritized: question-library quality, bias-detection depth, branching-logic flexibility, and integration with analysis and synthesis.',
  '[
    {"q":"How long should a survey be?","a":"5-7 questions for quick pulse; 10-15 for moderate research; 20-30 for in-depth. Beyond 30 questions, completion rates drop sharply (below 30%). Length should be proportional to incentive and audience tolerance."},
    {"q":"Can AI flag biased questions?","a":"Yes for surface-level biases (leading wording, double-barreled questions, jargon). Deeper biases (cultural assumptions, framing effects) still require human reviewer judgment. Use AI as a first-pass filter."},
    {"q":"Maze vs Typeform?","a":"Maze is product-research-and-prototype-test-first with usability metrics; Typeform is conversational-survey-first with broader use-case support. Product researchers pick Maze; broader survey use cases pick Typeform."}
  ]'::jsonb, 'research', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 42. ai-for-user-interviews
(
  'ai-for-user-interviews', 'AI for User Interviews', '🎙️',
  ARRAY['research'], ARRAY['dovetail','lookback','respondent','dscout','userlytics'], 3,
  'User interviews are the highest-quality research method when executed well, and AI tools now handle the time-consuming parts: recruitment, scheduling, transcription, and synthesis. Respondent and dScout lead participant recruitment with vetted panels; Lookback and Userlytics ship interview-recording and analysis; Dovetail dominates synthesis from interview transcripts. The compression is from 8 hours per interview (recruit-conduct-transcribe-analyze) to 2-3 hours.',
  'We weighted: participant-quality of recruited pool, transcription accuracy, AI-synthesis quality, and integration with analysis tools.',
  '[
    {"q":"How many interviews do we need?","a":"5-7 interviews to surface 80% of patterns in a target segment; 10-12 to reach saturation. Above 12, returns diminish unless you split into segments. Generative research benefits from more interviews; evaluative research can run with fewer."},
    {"q":"Respondent vs dScout?","a":"Respondent has stronger B2B-and-niche-professional recruitment; dScout has stronger consumer-and-mobile recruitment with diary-study tools. B2B research picks Respondent; consumer research picks dScout."},
    {"q":"Can AI synthesize interviews?","a":"For pattern-detection across transcripts, yes with high accuracy. For nuanced narrative threads, AI synthesis underperforms experienced researchers. Use AI to surface candidate themes faster, then have a human researcher refine the final narrative."}
  ]'::jsonb, 'research', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 43. ai-for-paper-summaries
(
  'ai-for-paper-summaries', 'AI for Paper Summaries', '📜',
  ARRAY['research'], ARRAY['perplexity','humata','jasper','julius-ai','copy-ai'], 3,
  'Academic and industry papers consume hours per session for researchers tracking developments. AI summarization tools now distill 30-page papers into 1-page summaries with key findings, methodology critique, and citation context. Perplexity excels at research-grade Q-and-A across multiple papers; Humata focuses on document-level chat over uploaded PDFs; Julius AI handles paper-with-data analysis; Jasper and Copy.ai treat paper summarization as one of many content workflows.',
  'Selection prioritized: summary fidelity to source, citation-handling accuracy, multi-paper comparison, and PDF and academic-database integration.',
  '[
    {"q":"How accurate are AI paper summaries?","a":"For descriptive summaries (what the paper claims, methodology), 90%+ accurate. For critical summaries (limitations, contradictions, generalizability), AI underperforms human academic readers. Always read the original abstract and conclusion before relying on AI summary alone."},
    {"q":"Perplexity vs Humata for papers?","a":"Perplexity is breadth-first across the open web with strong citation tracking; Humata is depth-first within uploaded documents with stronger document-Q-and-A. Researchers exploring topics pick Perplexity; researchers analyzing specific papers pick Humata."},
    {"q":"Can AI replace lit-review?","a":"It compresses lit-review from weeks to days, but cannot replace it. AI surfaces candidate papers and themes; human researchers still need to read, critique, and synthesize for academic rigor. Treat AI as research acceleration, not research replacement."}
  ]'::jsonb, 'research', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 44. ai-for-academic-citations
(
  'ai-for-academic-citations', 'AI for Academic Citations', '📚',
  ARRAY['research'], ARRAY['perplexity','humata','jasper','julius-ai'], 3,
  'Academic citation management is foundational for credible research output, and AI tools now generate citations in any format, verify them against source databases, and flag fabricated or hallucinated references. Perplexity ships native citation alongside answers with source links; Humata cites within uploaded documents; Julius AI cites data sources used in analysis; Jasper bundles citation generation into broader writing workflow.',
  'We weighted: citation-format coverage (APA, MLA, Chicago, IEEE), source-verification accuracy, hallucination-detection, and integration with reference managers.',
  '[
    {"q":"Do AI tools hallucinate citations?","a":"Less common in 2026 than in 2023 due to retrieval-augmented generation, but still possible. Always verify the cited paper exists by clicking through the source link or searching the title in Google Scholar. Tools with native citation (Perplexity, Humata) hallucinate less than pure-generation tools."},
    {"q":"Perplexity vs traditional reference managers?","a":"Perplexity is faster for in-line citation during research-and-writing; reference managers (Zotero, Mendeley) are better for long-term collection management. Hybrid: use Perplexity for active research, export to Zotero for long-term storage."},
    {"q":"What citation format should we use?","a":"APA for psychology and social sciences; MLA for humanities; Chicago for history; IEEE for engineering and computer science. Default to journal-specific guidelines if publishing. AI tools auto-format across all 4 styles from the same source."}
  ]'::jsonb, 'research', 'intermediate', 880,
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
