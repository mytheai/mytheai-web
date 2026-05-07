-- Phase 2 batch 2 of Task Taxonomy initiative (S118)
-- 42 mid-tail tasks targeting underserved verticals: finance (+4), hr-recruiting (+3),
-- customer-success (+4), sales (+4), marketing (+5), dev (+3), data-analytics (+2),
-- research (+3), productivity (+3), support (+3), writing (+4), design (+2).
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Phase 2 progress: 94 -> 136 tasks (68% of 200-target).
-- Gate A 42/42 PASS, Gate B 42/42 PASS (100% hit rate). All picked_slugs verified.
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === FINANCE (4) ===

-- 1. ai-for-financial-reporting
(
  'ai-for-financial-reporting', 'AI for Financial Reporting', '📊',
  ARRAY['finance'], ARRAY['ramp','pilot','bench','zeni','baremetrics'], 3,
  'Financial reporting used to mean a spreadsheet jockey rebuilding the same P&L every month-end. AI financial reporting tools now sync general-ledger data, generate variance commentary, and surface anomalies before the controller asks. Pilot and Bench lead full-stack bookkeeping plus reporting for sub-Series-B startups; Zeni adds AI-native classification; Ramp and Baremetrics cover real-time spend and SaaS-revenue dashboards respectively.',
  'We weighted: general-ledger sync depth, variance commentary quality, audit trail for compliance, and pricing fit for sub-50-headcount teams.',
  '[
    {"q":"Pilot vs Bench for early-stage startups?","a":"Pilot is fractional-CFO bundled with bookkeeping - higher cost, deeper service. Bench is bookkeeping-only with simpler reporting. Pre-seed to seed: Bench. Series A and beyond: Pilot."},
    {"q":"Can AI reports replace a CFO?","a":"For monthly close and management reports, yes - AI tools generate the same artifacts a junior controller would. Strategic finance work (fundraising, M&A, board narrative) still needs a human."},
    {"q":"Are AI-generated financial reports audit-ready?","a":"For internal management reports, yes. For external audit (Big 4), the underlying ledger must be reconciled by a qualified accountant - AI assists but does not certify. Most tools maintain audit-trail logs that satisfy reviewers."}
  ]'::jsonb, 'finance', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-accounts-payable
(
  'ai-for-accounts-payable', 'AI for Accounts Payable', '💳',
  ARRAY['finance'], ARRAY['ramp','tipalti','stampli','airbase','vic-ai'], 3,
  'Accounts payable used to drown in invoice PDFs, three-way matches, and approval routing. AI AP tools extract invoice data with 98%+ accuracy, route approvals to the right manager, and pay vendors in one click. Tipalti and Stampli are AP specialists with the deepest workflow customization; Vic.ai pioneered AI-native invoice coding; Ramp and Airbase bundle AP into broader spend platforms for tighter card-and-bill control.',
  'Selection focused on: invoice OCR accuracy, three-way match automation, approval routing flexibility, and integration with NetSuite/QuickBooks/Xero.',
  '[
    {"q":"Tipalti vs Stampli?","a":"Tipalti is global-payments-first with strong cross-border tax compliance. Stampli is approval-workflow-first with the cleanest UX for AP clerks. Global vendor base: Tipalti. Domestic-heavy with complex approvals: Stampli."},
    {"q":"How accurate is AI invoice extraction?","a":"Top tools hit 95-98% on standard invoices, drop to 85-90% on handwritten or low-quality scans. Always require human review on amounts above a threshold ($1k or $10k depending on risk tolerance)."},
    {"q":"Can these tools replace an AP clerk?","a":"For 80% of straight-through invoices, yes. The remaining 20% (disputes, exceptions, vendor onboarding, audit prep) still needs a human. Most teams reduce AP headcount or redeploy AP staff to procurement work."}
  ]'::jsonb, 'finance', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-tax-preparation
(
  'ai-for-tax-preparation', 'AI for Tax Preparation', '🧾',
  ARRAY['finance'], ARRAY['pilot','bench','docyt','zeni'], 3,
  'Small-business tax prep is brutal: 1099 reconciliation, sales-tax nexus, R&D credits, and K-1 distributions all need clean books before a CPA touches the return. AI tax prep tools handle the bookkeeping cleanup that makes tax filing fast (and cheap) - some bundle a tax CPA into the package. Pilot and Bench both offer tax-add-ons for their bookkeeping clients; Zeni is AI-native with year-round tax-ready books; Docyt automates document collection across vendors.',
  'We weighted: tax-document collection coverage, multi-state nexus handling, CPA-review bundling, and pricing transparency.',
  '[
    {"q":"Will AI replace my CPA?","a":"Not yet - the IRS still requires a licensed preparer signature on most filings, and judgment calls (R&D credit qualification, tax-loss harvesting strategy) need a human. AI handles the cleanup work that makes the CPA fast."},
    {"q":"Pilot Tax vs Bench Tax?","a":"Pilot Tax is bundled with Pilot Bookkeeping for a single integrated experience. Bench has a separate Bench Tax product. If you are already on one of these for bookkeeping, stay; if shopping fresh, Pilot has the cleaner end-to-end flow."},
    {"q":"Is AI safe for sensitive tax data?","a":"Top tools are SOC 2 Type II certified and encrypt at rest. Risk surfaces during data extraction; verify the tool uses regional data centers if you have GDPR/CCPA scope. For high-net-worth or complex returns, stay with a boutique CPA firm regardless."}
  ]'::jsonb, 'finance', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-budgeting
(
  'ai-for-budgeting', 'AI for Budgeting', '💰',
  ARRAY['finance'], ARRAY['ramp','brex','airbase','baremetrics'], 3,
  'Budgeting used to mean a quarterly spreadsheet handed to managers who ignored it until the variance hit. AI budgeting tools enforce real-time spend caps, route over-budget approvals automatically, and surface forecast variance before month-end close. Ramp and Brex lead corporate-card-plus-budget platforms with native enforcement; Airbase adds AP plus reimbursement coverage; Baremetrics handles SaaS-revenue side of the budget vs actuals story.',
  'Selection focused on: real-time vs lagging spend enforcement, budget-by-team granularity, vendor-renewal alerting, and accountant-friendly export to NetSuite/QuickBooks.',
  '[
    {"q":"Ramp vs Brex for budgeting?","a":"Ramp is more aggressive on automated savings and vendor consolidation suggestions. Brex has stronger startup-tier rewards and Treasury management. For pure spend control: Ramp. For startups holding cash + spending: Brex."},
    {"q":"Can a budget tool replace FP&A?","a":"For tactical monthly variance and category-level enforcement, yes. Strategic FP&A (scenario modeling, hiring plan tied to revenue) still needs Mosaic/Cube/Datarails or a human FP&A lead."},
    {"q":"How early should a startup adopt one of these?","a":"Day one of the first corporate card is the right time - $0 onboarding cost on Ramp/Brex makes the upgrade cheaper than reconciling personal cards later. The pain point that triggers most adoption is reaching 10+ employees with shared spend."}
  ]'::jsonb, 'finance', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === HR-RECRUITING (3) ===

-- 5. ai-for-payroll
(
  'ai-for-payroll', 'AI for Payroll', '🏦',
  ARRAY['hr'], ARRAY['rippling','gusto','bamboohr'], 3,
  'Payroll is one of those workflows where one error costs a Friday and an angry employee email. AI payroll tools auto-classify wages, file taxes in 50 states, and reconcile benefits deductions before the run executes. Rippling unified payroll plus IT plus benefits in one record; Gusto leads ease-of-use for sub-50-employee teams; BambooHR pairs payroll with HR records and performance.',
  'We weighted: multi-state tax filing coverage, benefits-deduction reconciliation, contractor (1099) plus employee (W-2) handling, and audit-trail quality.',
  '[
    {"q":"Rippling vs Gusto for a 20-person startup?","a":"Gusto is faster to set up and cheaper for pure payroll. Rippling becomes worth it when you also want IT provisioning, equipment shipping, and global hires unified in the same employee record. Pure payroll: Gusto. Operations + payroll: Rippling."},
    {"q":"Is AI accurate enough for tax filing?","a":"Top-tier providers have automated 50-state filing with low error rates - sub-1% on standard wages. Errors concentrate on edge cases (multi-state employees, equity compensation, international contractors). All providers indemnify their tax filings."},
    {"q":"BambooHR vs Rippling for HR-first companies?","a":"BambooHR is HR-first and adds payroll as a module. Rippling is workflow-first and adds HR records as a layer. For HR teams that own the platform: BambooHR. For ops teams that own the platform: Rippling."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 6. ai-for-employee-onboarding
(
  'ai-for-employee-onboarding', 'AI for Employee Onboarding', '🎓',
  ARRAY['hr'], ARRAY['lattice','culture-amp','rippling','bamboohr'], 3,
  'Day-one onboarding makes or breaks 90-day retention - and most companies still rely on a Notion checklist that nobody finishes. AI onboarding tools auto-provision laptop, accounts, training, and 30/60/90 check-ins from a single new-hire trigger. Rippling leads end-to-end provisioning across IT plus HR; Lattice and Culture Amp anchor the people-side check-ins and goal alignment; BambooHR bundles onboarding into a broader HR record.',
  'Selection focused on: laptop and account provisioning automation, custom onboarding checklist, manager 1:1 templates, and 30/60/90 day pulse surveys.',
  '[
    {"q":"What does AI actually automate in onboarding?","a":"Account creation across Gmail/Slack/Notion/etc., laptop shipping triggers, training module assignment, manager-1:1 scheduling, and pulse-survey delivery. The human work is the welcome lunch and culture transmission."},
    {"q":"Lattice vs Culture Amp?","a":"Lattice has stronger goals/OKR linkage and lighter-weight check-ins. Culture Amp leads engagement survey depth and DEI analytics. For OKR-driven cultures: Lattice. For survey-and-development cultures: Culture Amp."},
    {"q":"How long should automated onboarding run?","a":"30 days for transactional (accounts, training), 90 days for cultural (manager 1:1s, pulse surveys), 6+ months for goal-setting. Most tools cover all three timelines from one new-hire record."}
  ]'::jsonb, 'hr-recruiting', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-performance-reviews
(
  'ai-for-performance-reviews', 'AI for Performance Reviews', '⭐',
  ARRAY['hr'], ARRAY['lattice','culture-amp','15five'], 3,
  'Performance reviews stuck in the SHRM-template era hit cycle fatigue and end up corrupted by recency bias. AI performance review tools collect continuous feedback, draft narrative reviews from check-in notes, and flag manager-bias patterns before calibration. Lattice and 15Five lead lightweight continuous-performance with goal alignment; Culture Amp adds the deepest people-analytics and DEI-bias auditing layer.',
  'We weighted: continuous-feedback capture vs annual review draft, calibration tooling, manager-bias detection, and integration with HRIS.',
  '[
    {"q":"Lattice vs 15Five?","a":"15Five is lighter-weight and check-in focused with strong manager 1:1 templates. Lattice has deeper performance-and-goals integration. Pure people-side: 15Five. Performance-and-OKRs combined: Lattice."},
    {"q":"Can AI write the narrative for me?","a":"Yes - top tools synthesize 6+ months of check-in notes plus peer feedback into a 200-word review draft. Manager edits the tone and adds judgment. Saves 60-90 minutes per direct report at cycle time."},
    {"q":"Will AI catch reviewer bias?","a":"Culture Amp and Lattice flag known patterns (recency, halo, language disparity by demographic). Effectiveness depends on having enough reviews to detect statistical patterns - first-cycle teams will not see useful bias data yet."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === MARKETING / MARKETING-OPS (5) ===

-- 8. ai-for-survey-creation
(
  'ai-for-survey-creation', 'AI for Survey Creation', '📋',
  ARRAY['research','productivity'], ARRAY['typeform','sprig','dovetail','maze','lookback'], 3,
  'Most surveys bury the question, suffer from low response rates, and produce data nobody analyzes. AI survey tools draft non-leading questions from a research goal, optimize length for completion rate, and synthesize open-text responses on submit. Typeform leads consumer-grade conversational surveys; Sprig handles in-product micro-surveys with auto-segmentation; Dovetail, Maze, and Lookback cover deeper qualitative research with AI synthesis.',
  'Selection focused on: question quality from goal prompt, completion-rate optimization, integration with product analytics, and AI synthesis of open responses.',
  '[
    {"q":"Typeform vs Sprig?","a":"Typeform is consumer-survey first with strong design polish - best for one-time research. Sprig is in-product micro-survey first - best for continuous user research. They solve different jobs; many companies use both."},
    {"q":"How long should a survey be?","a":"3-5 questions for in-product surveys (target 60-80% completion), 8-12 for end-of-onboarding NPS (target 30-40%), 15-25 for annual user research (10-20%). AI tools warn when length pushes drop-off."},
    {"q":"Can AI write unbiased questions?","a":"For surface-level bias (loaded language, double-barreled questions), yes. For domain-specific bias (asking sensitive demographics, regulatory phrasing), have a human researcher review. Top tools flag the obvious problems automatically."}
  ]'::jsonb, 'data-analytics', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 9. ai-for-brand-voice
(
  'ai-for-brand-voice', 'AI for Brand Voice', '🎙️',
  ARRAY['writing-ai'], ARRAY['jasper','hypotenuse-ai','copy-ai','writesonic','anyword'], 3,
  'Brand voice is the difference between content that sounds like your brand and content that sounds like ChatGPT defaults. AI brand voice tools train on your existing copy and enforce consistency across writers, agencies, and AI drafts. Jasper leads enterprise brand-voice with multi-tone profile training; Anyword adds engagement scoring tuned per voice; Copy.ai, Writesonic, and Hypotenuse.ai cover mid-market with simpler voice presets.',
  'We weighted: voice training data depth, multi-tone profile support (e.g. blog vs social), output consistency across writers, and brand-asset library integration.',
  '[
    {"q":"How much copy do I need to train a brand voice?","a":"Top tools want 5-10 high-quality examples (1500+ words total) to lock tone. With less, voices drift toward category defaults. With more, training plateaus around 30-50 examples."},
    {"q":"Jasper vs Anyword for brand voice?","a":"Jasper has the deepest voice training (multi-profile, asset library, knowledge base). Anyword scores variants per voice for landing-page conversion. Brand-led teams: Jasper. Performance-led teams: Anyword."},
    {"q":"Will trained AI replace my agency?","a":"For routine production (social posts, newsletter, blog drafts), yes - the time saved pays for the agency wedge. For strategy and high-stakes brand work (campaign concepts, voice evolution), agencies still earn their fee."}
  ]'::jsonb, 'marketing', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-content-strategy
(
  'ai-for-content-strategy', 'AI for Content Strategy', '🗺️',
  ARRAY['seo-marketing','writing-ai'], ARRAY['surfer-seo','jasper','copy-ai','frase','scalenut'], 3,
  'Content strategy used to mean a content marketer building a 12-month editorial calendar from gut feel and a competitor scrape. AI content strategy tools mine search intent, cluster topics by pillar, and forecast traffic potential before a single brief is written. Surfer SEO and Frase lead topical-cluster research with SERP analysis; Scalenut adds workflow from cluster to draft; Jasper and Copy.ai cover the brief-to-draft handoff.',
  'Selection focused on: topical clustering quality, search-intent classification, traffic forecast accuracy, and brief-to-draft workflow integration.',
  '[
    {"q":"Surfer vs Frase for clusters?","a":"Surfer has a tighter SERP-analysis loop and stronger on-page optimization layer. Frase has cleaner cluster visualization and faster brief generation. SEO depth: Surfer. Speed-to-brief: Frase."},
    {"q":"Can AI forecast traffic accurately?","a":"Within ±30% for established sites with 12-month historical data. For new sites, forecasts are aspirational - treat as relative ranking of opportunities, not absolute targets."},
    {"q":"How granular should clusters be?","a":"Start with 3-5 pillar topics, then break each into 8-15 cluster pages. Going deeper than 20 cluster pages per pillar usually means you should split into a new pillar - AI tools warn when clusters drift apart semantically."}
  ]'::jsonb, 'marketing', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 11. ai-for-event-marketing
(
  'ai-for-event-marketing', 'AI for Event Marketing', '🎟️',
  ARRAY['email-marketing'], ARRAY['mailerlite','hubspot','klaviyo','activecampaign'], 3,
  'Event marketing lives on segmented invitation lists, perfectly timed reminders, and post-event follow-ups that feel personal at scale. AI event tools auto-segment by past attendance, predict RSVP-to-attend rate, and personalize follow-up emails based on session attendance. HubSpot and ActiveCampaign lead full-stack marketing automation with event modules; Klaviyo dominates e-commerce events; MailerLite covers small-team event campaigns at the lowest entry cost.',
  'We weighted: event-list segmentation depth, RSVP-to-attend forecasting, post-event follow-up personalization, and webinar-platform integration.',
  '[
    {"q":"HubSpot vs ActiveCampaign for events?","a":"HubSpot has the deepest CRM-event linkage with attribution back to revenue. ActiveCampaign has stronger automation logic per attendee path. Sales-event ROI: HubSpot. Marketing-event nurture: ActiveCampaign."},
    {"q":"How much can I personalize at scale?","a":"At 1,000-attendee events, 3-5 segments are practical (registered/attended/no-show, plus product interest). At 10,000+, 10-15 segments become ROI-positive. Below 100 attendees, manual outreach beats automation."},
    {"q":"Klaviyo for non-ecommerce events?","a":"Klaviyo is e-commerce-first; the SMS plus email orchestration works for B2C events but lacks B2B sales-handoff features. For B2B SaaS events, HubSpot or Marketo is a better fit despite higher cost."}
  ]'::jsonb, 'marketing', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 12. ai-for-influencer-marketing
(
  'ai-for-influencer-marketing', 'AI for Influencer Marketing', '🌟',
  ARRAY['social-media'], ARRAY['agorapulse','contentstudio','creatoriq','hypefury','taplio'], 3,
  'Influencer marketing is one part discovery, one part outreach, two parts measurement - and the unprofitable third was always measurement. AI influencer tools rank creators by audience-fit score, automate brief delivery, and attribute conversions back to specific posts. CreatorIQ leads enterprise influencer relationship management; Agorapulse and ContentStudio bundle influencer plus social calendar for mid-market; Hypefury and Taplio cover X plus LinkedIn personal-creator partnerships.',
  'Selection focused on: audience-fit scoring quality, automated outreach plus brief workflow, conversion attribution, and platform coverage breadth.',
  '[
    {"q":"CreatorIQ vs ContentStudio?","a":"CreatorIQ is enterprise (Series C+) with deep CRM-style influencer relationship tracking. ContentStudio is mid-market influencer plus social-publishing combined. Pure enterprise programs: CreatorIQ. Mid-market with shared social ops: ContentStudio."},
    {"q":"How much budget per influencer?","a":"Micro (10-50K followers): $100-1k per post. Mid (50-500K): $1-10k. Macro (500K-5M): $10-100k+. AI tools forecast engagement and conversion to right-size budget per creator before outreach."},
    {"q":"Can AI predict creator fraud?","a":"Top tools detect bot-follower patterns (sudden spikes, geographic mismatch, low engagement-rate ratio). Sophisticated fraud (bought engagement, view bots) sometimes slips through - require minimum-90-day creator history before greenlighting partnerships."}
  ]'::jsonb, 'marketing', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === CUSTOMER-SUCCESS (4) ===

-- 13. ai-for-account-management
(
  'ai-for-account-management', 'AI for Account Management', '🤝',
  ARRAY['customer-service'], ARRAY['vitally','gainsight','planhat','custify','totango'], 3,
  'Account management at scale means one CSM owning 50+ accounts and missing the early signals on every other one. AI account management tools surface health-score changes, suggest next-best-action playbooks, and draft renewal-conversation talking points from product-usage data. Gainsight leads enterprise CS with the deepest analytics; Vitally and Planhat are modern alternatives with cleaner UX; Custify and Totango cover mid-market with strong out-of-box workflows.',
  'We weighted: health-score signal depth, playbook automation, renewal-conversation prep, and integration with Salesforce/HubSpot.',
  '[
    {"q":"Gainsight vs Vitally?","a":"Gainsight has the deepest enterprise feature set (advanced reporting, Series-X-level integrations) but a steeper learning curve. Vitally has 80% of the features at 40% of the cost with cleaner UX. Series C+: Gainsight. Series A-B: Vitally."},
    {"q":"How many accounts can one CSM handle with AI?","a":"Pre-AI baseline is 25-50 accounts. With AI scoring + automated playbooks: 75-125. Above 125, automation degrades - account managers become reactive instead of strategic."},
    {"q":"Can AI predict churn early?","a":"For product-usage-based churn (logins drop, key features unused), yes - 60-90 days warning is realistic. For relationship-driven churn (executive sponsor leaves), AI is weaker; supplement with manual relationship mapping."}
  ]'::jsonb, 'customer-success', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-renewal-management
(
  'ai-for-renewal-management', 'AI for Renewal Management', '🔄',
  ARRAY['customer-service'], ARRAY['vitally','gainsight','churnzero','totango'], 3,
  'Renewal management is the highest-leverage single workflow in B2B SaaS - and it gets neglected because CSMs are busy fighting fires. AI renewal tools forecast renewal probability 90-180 days out, draft renewal proposals from usage data, and surface upsell opportunities before the renewal call. Gainsight and ChurnZero lead enterprise renewal forecasting; Vitally and Totango cover mid-market with simpler workflows.',
  'Selection focused on: renewal-probability forecast horizon, automated renewal-proposal generation, upsell-opportunity surfacing, and pricing for sub-$10M ARR teams.',
  '[
    {"q":"How accurate are renewal forecasts?","a":"For accounts with 12+ months of product-usage data, top tools hit 80-85% accuracy 90 days out. For new accounts (<6 months), accuracy drops to coin-flip. Baseline: usage data is necessary but not sufficient."},
    {"q":"ChurnZero vs Gainsight?","a":"ChurnZero is renewal-and-onboarding focused with lighter feature surface area. Gainsight covers full CS lifecycle with renewal as one workflow. Renewal-led GTM: ChurnZero. Full lifecycle CS: Gainsight."},
    {"q":"Can AI close renewals without a CSM?","a":"For low-touch SMB accounts under $20k ARR, automated renewal flows close 60-80%. For mid-market and enterprise, AI prepares the conversation but a human CSM still closes."}
  ]'::jsonb, 'customer-success', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 15. ai-for-customer-segmentation
(
  'ai-for-customer-segmentation', 'AI for Customer Segmentation', '🎯',
  ARRAY['email-marketing','crm-sales'], ARRAY['hubspot','klaviyo','intercom','salesforce-einstein','activecampaign'], 3,
  'Customer segmentation moved from quarterly RFM-batch jobs to real-time AI clustering on behavior, spend, and intent. AI segmentation tools auto-discover micro-segments, predict propensity per segment, and route the right message to the right cluster without a marketer hand-mapping rules. HubSpot and Salesforce Einstein lead enterprise CRM-driven segmentation; Klaviyo dominates e-commerce predictive segmentation; Intercom and ActiveCampaign cover product-led and lifecycle segmentation respectively.',
  'We weighted: real-time vs batch segmentation, predictive scoring per segment, automation routing per cluster, and platform breadth.',
  '[
    {"q":"How many segments should I run?","a":"For under 10k contacts: 3-5 active segments. 10-100k: 8-15. 100k+: 20-50. Beyond 50, automation breaks down and segments converge - AI tools warn when segments overlap above 70% behaviorally."},
    {"q":"Klaviyo vs HubSpot for ecommerce?","a":"Klaviyo is e-commerce native with deeper Shopify integration and predictive customer-lifetime-value modeling. HubSpot covers e-commerce + B2B unified with better CRM. Pure DTC: Klaviyo. Mixed B2B + DTC: HubSpot."},
    {"q":"Can AI find segments I have not thought of?","a":"Yes - top tools surface micro-segments invisible to manual rule-building (e.g., abandoned-cart-Tuesday-evening cohort with 3x conversion rate). Validate that surfaced segments are actionable before building automations on top."}
  ]'::jsonb, 'marketing', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 16. ai-for-nps-tracking
(
  'ai-for-nps-tracking', 'AI for NPS Tracking', '📈',
  ARRAY['research'], ARRAY['dovetail','maze','typeform','sprig'], 3,
  'NPS at most companies is a quarterly score nobody acts on - mostly because the qualitative "why" gets lost in a spreadsheet. AI NPS tools synthesize free-text responses into themes, route detractor feedback to the right team, and trend sentiment across cohorts in real time. Sprig leads in-product NPS with auto-segmentation; Dovetail handles deeper synthesis on free-text; Maze and Typeform cover survey-driven NPS with strong design.',
  'Selection focused on: free-text theme extraction, detractor-routing workflows, cohort trending, and integration with product-analytics tools.',
  '[
    {"q":"How often should I run NPS?","a":"Quarterly for relationship NPS (overall brand), continuous in-product for transactional NPS (post-feature, post-onboarding). Top tools handle both signals separately - do not collapse into one score."},
    {"q":"Sprig vs Dovetail?","a":"Sprig is built for in-product micro-surveys with strong segmentation. Dovetail is built for qualitative research synthesis. Continuous NPS: Sprig. Deep dive on detractor responses: Dovetail."},
    {"q":"Is NPS still the right metric?","a":"For tracking trend over time, yes. For predicting individual churn or revenue, NPS underperforms behavior-based metrics (DAU, feature adoption). Use NPS as one signal among many - not the north star."}
  ]'::jsonb, 'customer-success', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 17. ai-for-customer-health-scores
(
  'ai-for-customer-health-scores', 'AI for Customer Health Scores', '❤️‍🩹',
  ARRAY['customer-service'], ARRAY['vitally','gainsight','planhat','catalyst','totango'], 3,
  'Customer health scores were once a marketing term for "spreadsheet color coded by feel". AI health-score tools blend product usage, support volume, and engagement signals into a real-time score that actually correlates with renewal. Gainsight and Vitally lead in score-model flexibility; Planhat and Catalyst offer simpler out-of-box scoring; Totango covers mid-market with stronger automation triggered off scores.',
  'We weighted: signal-source breadth (product usage + support + engagement), model customization depth, score-trend explainability, and automation hooks per score change.',
  '[
    {"q":"How accurate are AI health scores?","a":"For product-usage-driven SaaS, 70-80% predictive of renewal at 90 days. Accuracy drops for low-touch products with sparse usage signal. Pair with manual relationship-health field for low-data accounts."},
    {"q":"Vitally vs Catalyst?","a":"Vitally has stronger Salesforce-native CS workflows and more polished UX. Catalyst is lighter-weight with faster setup. Salesforce shop: Vitally. Standalone CS team: Catalyst."},
    {"q":"Should I share the score with the customer?","a":"Generally no - sharing scores creates gaming and conversation-derailing debates. Use scores internally to prioritize CSM attention; share specific actionable insights (usage of feature X is below your peer cohort) instead."}
  ]'::jsonb, 'customer-success', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SALES (4) ===

-- 18. ai-for-sales-forecasting
(
  'ai-for-sales-forecasting', 'AI for Sales Forecasting', '🔮',
  ARRAY['crm-sales'], ARRAY['gong-io','close-crm','hubspot','salesforce-einstein','clari'], 3,
  'Sales forecasting accuracy averaged 47% pre-AI - barely better than coin flip. AI sales forecasting tools score deals by call sentiment, email reply rates, and stage velocity to lift accuracy past 80%. Gong and Clari lead conversation-and-pipeline AI for enterprise; Salesforce Einstein covers Salesforce-native shops; HubSpot and Close offer accessible forecasting for SMB-to-mid-market.',
  'Selection focused on: deal-scoring signal breadth (calls, emails, CRM activity), forecast-accuracy benchmark, manager-roll-up flexibility, and CRM-source-of-truth fit.',
  '[
    {"q":"Gong vs Clari?","a":"Gong is conversation-AI first with forecast as a derivative. Clari is forecast-and-pipeline-management first with conversation AI as one signal. Conversation-led GTM: Gong. Pipeline-led GTM: Clari."},
    {"q":"Will AI replace the rep call-down?","a":"For mid-market deal review, yes - reps spend less time updating CRM. For complex enterprise deals, the manager call-down still adds judgment AI cannot replicate. Hybrid is the modern default."},
    {"q":"Salesforce Einstein vs Gong?","a":"Einstein is bundled with Salesforce - lower friction for Salesforce-native teams. Gong is a separate spend ($1500+/seat/year) with deeper conversation analysis. Existing Salesforce shop: try Einstein first. Conversation-rich GTM: add Gong."}
  ]'::jsonb, 'sales', 'intermediate', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 19. ai-for-deal-summaries
(
  'ai-for-deal-summaries', 'AI for Deal Summaries', '📝',
  ARRAY['meeting-tools','crm-sales'], ARRAY['fathom','gong-io','avoma','modjo','sembly-ai'], 3,
  'Deal summaries used to mean a rep typing meeting notes into Salesforce on Friday afternoon if at all. AI deal summary tools auto-record sales calls, extract decisions and next steps, and push structured updates to the CRM in seconds. Gong and Modjo lead enterprise revenue intelligence; Fathom and Avoma cover mid-market with stronger free tiers; Sembly.ai handles multi-language with fast summary turnaround.',
  'We weighted: meeting-platform coverage (Zoom/Meet/Teams), CRM auto-update reliability, action-item extraction quality, and pricing for sub-50-rep teams.',
  '[
    {"q":"Fathom vs Gong for SMB sales?","a":"Fathom is free for one user with strong basics - perfect for 1-5 rep teams. Gong starts at $1500+/seat/year and pays off at 10+ reps with revenue intelligence. Under 5 reps: Fathom. Over 10 reps: Gong."},
    {"q":"Are AI summaries accurate enough for legal record?","a":"For internal CRM record, yes. For legal-record purposes (NDA acknowledgment, contract terms discussed), keep the recording itself plus the AI summary - the recording is the source of truth."},
    {"q":"Modjo vs Avoma?","a":"Modjo is European-headquartered with stronger GDPR positioning and multi-language depth. Avoma is US-heavy with stronger Zapier-and-CRM integration. EU-focused GTM: Modjo. US/global: Avoma."}
  ]'::jsonb, 'sales', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 20. ai-for-sales-coaching
(
  'ai-for-sales-coaching', 'AI for Sales Coaching', '🏋️',
  ARRAY['crm-sales'], ARRAY['gong-io','lavender','avoma','modjo'], 3,
  'Sales coaching used to mean a manager listening to one call per rep per quarter. AI sales coaching tools score every call against a scorecard, surface coaching moments, and suggest specific phrases to practice based on objection patterns. Gong leads enterprise call-scoring; Lavender focuses email coaching with real-time feedback; Avoma and Modjo cover full meeting-coaching workflows for mid-market.',
  'Selection focused on: coaching-scorecard customization, call-moment auto-tagging, real-time feedback (vs after-the-fact), and email-coaching coverage.',
  '[
    {"q":"Gong vs Lavender?","a":"Different jobs. Gong scores meetings (Zoom calls). Lavender scores emails (cold-and-followup outreach). Most modern teams stack both - Gong for calls, Lavender for inbox."},
    {"q":"Can AI replace a sales manager?","a":"For tactical coaching (use better discovery questions, fewer filler words), yes. For strategic coaching (deal strategy, career development, team morale), AI is a tool the manager uses - not a replacement."},
    {"q":"How fast does coaching pay back?","a":"Top performers see 5-10% lift in win rate within one quarter when coaching adoption is consistent. Bottom performers can see 20-30% lift but need more reps - sustainable adoption matters more than tool choice."}
  ]'::jsonb, 'sales', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 21. ai-for-cpq
(
  'ai-for-cpq', 'AI for CPQ (Configure Price Quote)', '💼',
  ARRAY['crm-sales'], ARRAY['pandadoc','qwilr','loopio','dealhub','proposify'], 3,
  'CPQ workflows historically forced reps into 2-day quote-prep cycles with legal review on every line item. AI CPQ tools auto-generate quotes from product catalog, route discount approvals based on margin rules, and produce interactive proposals customers can sign in-page. PandaDoc and Proposify lead mid-market quote-and-proposal workflows; Qwilr makes the proposal interactive plus video; DealHub and Loopio cover RFP-heavy enterprise sales.',
  'We weighted: quote-template flexibility, discount-approval routing, e-signature integration, and proposal-engagement analytics (open, view, time-on-page).',
  '[
    {"q":"PandaDoc vs Qwilr?","a":"PandaDoc is forms-and-contracts heavy with strong legal-review workflows. Qwilr is interactive-proposal heavy with web-based engagement analytics. B2B SaaS quotes: PandaDoc. B2B services pitches: Qwilr."},
    {"q":"How much can CPQ cut quote cycle time?","a":"From days to minutes for catalog products. Custom-engineered quotes still take a day plus engineering review - but AI handles the proposal-document side, freeing engineering for the technical answer."},
    {"q":"Loopio for non-RFP teams?","a":"Loopio is RFP-response-first; over-engineered for teams that send 1-5 proposals per quarter. For non-RFP-heavy teams, PandaDoc or Proposify fit better. RFP volume above 20/quarter: Loopio earns its premium."}
  ]'::jsonb, 'sales', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DEV (3) ===

-- 22. ai-for-test-generation
(
  'ai-for-test-generation', 'AI for Test Generation', '🧪',
  ARRAY['code-ai'], ARRAY['claude','cursor','cline','supermaven','copilot-microsoft'], 3,
  'Test generation eats 30% of dev cycles for shops with serious coverage targets. AI test tools read function signatures, suggest unit test cases, and scaffold integration tests in seconds. Claude leads in handling complex edge cases through reasoning; Cursor and Cline integrate test generation into the IDE flow; Copilot and Supermaven autocomplete tests as you write production code.',
  'Selection focused on: edge-case discovery quality, mock-and-fixture generation, test-framework coverage (Jest/Pytest/Go-test), and IDE workflow integration.',
  '[
    {"q":"Claude vs Cursor for test generation?","a":"Claude excels when explaining test rationale and discovering non-obvious edge cases via dialogue. Cursor wins when generating tests inline next to the code being tested. Discovery: Claude. Inline workflow: Cursor."},
    {"q":"Will AI tests catch real bugs?","a":"For surface-level bugs (null handling, off-by-one), yes. For semantic bugs (wrong business logic), AI generates tests that confirm the buggy behavior - human review of test intent still matters."},
    {"q":"Cline vs Copilot for tests?","a":"Cline is agent-mode with multi-file awareness - great for setting up new test suites end-to-end. Copilot is autocomplete-mode - faster for adding one test to an existing suite. New project: Cline. Mature codebase: Copilot."}
  ]'::jsonb, 'dev', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 23. ai-for-documentation
(
  'ai-for-documentation', 'AI for Documentation', '📚',
  ARRAY['code-ai','writing-ai'], ARRAY['claude','document360','notion-ai','gitbook','copilot-microsoft'], 3,
  'Documentation drift is the silent killer of dev velocity - new hires hit walls because the wiki is six months stale. AI documentation tools generate docstrings from code, draft how-to guides from changelog, and flag stale pages when underlying code changes. Claude and Copilot lead code-doc generation; GitBook and Document360 are documentation-platform-first with AI editing; Notion AI bundles docs into the broader workspace.',
  'We weighted: code-to-doc generation depth, stale-doc detection, search quality on the published docs site, and integration with PR review flow.',
  '[
    {"q":"GitBook vs Document360?","a":"GitBook is dev-doc-first with strong Markdown plus Git workflow. Document360 is product-doc-first with stronger versioning and access control. API/SDK docs: GitBook. Customer-facing product docs: Document360."},
    {"q":"Should I let AI write all docs?","a":"For reference docs (API, function signatures, changelog), yes - drift detection alone justifies the tool. For conceptual docs (architecture overview, why we built it this way), human writing still produces sharper output."},
    {"q":"How does AI know when docs go stale?","a":"It compares doc references (function names, API paths) against current code. When a function is renamed or removed and the doc still references it, the page is flagged. Rename-tracking accuracy is the key differentiator."}
  ]'::jsonb, 'dev', 'intermediate', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 24. ai-for-pair-programming
(
  'ai-for-pair-programming', 'AI for Pair Programming', '👥',
  ARRAY['code-ai'], ARRAY['claude','cursor','cline','supermaven','copilot-microsoft'], 3,
  'Pair programming with another human is the fastest way to learn unfamiliar code - and the rarest practice in remote dev teams. AI pair programming tools think out loud, suggest alternatives, and explain unfamiliar code paths in real time. Cursor and Cline lead agentic pair-programming with multi-file context; Claude excels at deep architectural pairing through dialogue; Copilot and Supermaven are autocomplete-style pairs that keep typing flow intact.',
  'Selection focused on: multi-file context awareness, dialogue-vs-autocomplete style, model-selection flexibility (Claude/GPT/local), and IDE coverage breadth.',
  '[
    {"q":"Cursor vs Cline?","a":"Cursor is editor-first with deep IDE integration and tight UX. Cline is more agentic - reads broadly across the codebase and takes multi-step actions. Day-to-day pairing: Cursor. Big refactors: Cline."},
    {"q":"Is AI pairing better than human pairing?","a":"For tactical work (writing a function, debugging a stack trace), AI is faster and always available. For mentorship and team-context transfer, human pairing wins - AI does not know your team is shipping in 2 weeks."},
    {"q":"Should solo devs use this?","a":"Solo devs benefit most from AI pairing - it replaces the team senior who would catch silly mistakes and suggest design improvements. The marginal value is highest when nobody else is reviewing your code."}
  ]'::jsonb, 'dev', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DATA-ANALYTICS (2) ===

-- 25. ai-for-bi-reports
(
  'ai-for-bi-reports', 'AI for BI Reports', '📉',
  ARRAY['analytics'], ARRAY['metabase','tableau','julius-ai','rows','looker'], 3,
  'BI reports stuck in 2018 require an analyst to translate every executive question into SQL plus chart config. AI BI tools take plain-English questions and return charts on warehouse data, complete with explanation of methodology. Tableau and Looker lead enterprise governed BI; Metabase covers open-source self-host; Julius.ai is conversational-analysis-first; Rows is the AI-native spreadsheet alternative for ad-hoc reporting.',
  'We weighted: natural-language to chart accuracy, semantic-layer integration, sharing-and-embedding flexibility, and pricing for sub-Series-B teams.',
  '[
    {"q":"Tableau vs Metabase?","a":"Tableau is enterprise-tier with deepest viz library - $70+/user/month. Metabase is open-source self-host or $85/month for the cloud starter - 80% of startup needs covered. Pre-Series-C: Metabase. Series C+: Tableau."},
    {"q":"Looker vs Tableau?","a":"Looker (Google) is semantic-layer-first with stronger governed reporting. Tableau is viz-first with more flexible ad-hoc analysis. Governed enterprise reporting: Looker. Mixed governed + ad-hoc: Tableau."},
    {"q":"Julius vs traditional BI?","a":"Different jobs. Julius is conversational ad-hoc analysis on data you upload or connect. Tableau/Looker/Metabase are governed dashboards shared across teams. Stack both - Julius for one-off questions, traditional BI for shared dashboards."}
  ]'::jsonb, 'data-analytics', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 26. ai-for-survey-analysis
(
  'ai-for-survey-analysis', 'AI for Survey Analysis', '🔬',
  ARRAY['research'], ARRAY['dovetail','maze','sprig','lookback'], 3,
  'Survey analysis used to mean a researcher hand-coding 500 open-text responses over a weekend. AI survey analysis tools cluster open-text responses into themes, surface representative quotes, and quantify theme frequency in minutes. Dovetail leads research-repository workflow with deepest synthesis; Maze handles unmoderated user testing plus survey synthesis; Sprig covers in-product surveys; Lookback adds recorded-session analysis.',
  'Selection focused on: theme-clustering quality, representative-quote extraction, sentiment scoring per theme, and integration with research-repo or product-analytics tools.',
  '[
    {"q":"Dovetail vs Maze?","a":"Dovetail is research-synthesis-first - best for analyzing many sources (interviews, surveys, support tickets). Maze is unmoderated-testing-first - best for prototype tests with built-in survey. Research repository: Dovetail. Continuous testing: Maze."},
    {"q":"Will AI miss nuance in open-text?","a":"For frequency and major themes, AI is reliable. For nuance (sarcasm, cultural context, sensitive topics), AI underperforms - have a researcher review the top 10% of edge-case responses manually."},
    {"q":"Can AI replace user researchers?","a":"For tactical synthesis (theming, quote extraction), yes. For strategic research design and stakeholder communication, researchers still own the work - AI is a synthesis accelerator, not a replacement."}
  ]'::jsonb, 'data-analytics', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === RESEARCH (3) ===

-- 27. ai-for-market-research
(
  'ai-for-market-research', 'AI for Market Research', '🌐',
  ARRAY['research'], ARRAY['perplexity','elicit','scispace','consensus','julius-ai'], 3,
  'Market research used to mean two weeks of analyst time pulling reports from a half dozen subscriptions. AI market research tools synthesize public data, analyst reports, and product reviews into a coherent landscape map in under an hour. Perplexity leads general web-research synthesis with citations; Elicit and Consensus focus on academic-and-research-paper depth; SciSpace handles scientific-literature reviews; Julius.ai covers numerical-analysis layer on top.',
  'We weighted: source breadth (web, academic, news), citation transparency, contradicting-source surfacing, and synthesis quality vs raw search.',
  '[
    {"q":"Perplexity vs Elicit?","a":"Perplexity is broad web research with strong general synthesis. Elicit is academic-and-paper-focused with stronger evidence ranking. Business landscape research: Perplexity. Evidence-based deep dives: Elicit."},
    {"q":"Can AI replace a research analyst?","a":"For first-draft landscape maps and competitor scans, yes - a generalist can produce analyst-quality first drafts in 2 hours. For strategic interpretation and original primary research, analysts still earn the seat."},
    {"q":"How do I trust AI research?","a":"Always verify cited sources directly - top tools surface inline citations. Cross-check key claims against 2-3 independent sources before betting strategy on any single AI synthesis."}
  ]'::jsonb, 'research', 'intermediate', 2900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 28. ai-for-competitive-analysis
(
  'ai-for-competitive-analysis', 'AI for Competitive Analysis', '⚔️',
  ARRAY['research'], ARRAY['claude','perplexity','elicit','julius-ai'], 3,
  'Competitive analysis used to mean a PM scrolling competitor changelogs every Friday and forgetting to share with the team. AI competitive analysis tools track competitor product launches, pricing changes, and review sentiment continuously. Claude excels at structured competitive frameworks via dialogue; Perplexity provides real-time web monitoring with citations; Elicit handles deeper market-research synthesis; Julius.ai layers numerical comparison on competitor data.',
  'Selection focused on: monitoring breadth (changelog, pricing, reviews, social), framework templates (Porter, SWOT, JTBD), citation transparency, and update frequency.',
  '[
    {"q":"How often should I run competitive analysis?","a":"Quarterly deep-dive plus weekly skim of major competitor moves. AI tools make weekly skims realistic - the deep quarterly review is still worth a researcher and 2-3 days of focused time."},
    {"q":"Claude vs Perplexity?","a":"Claude is structured-thinking-first - great for building frameworks (positioning maps, JTBD analysis). Perplexity is real-time-search-first - great for the what-changed-this-week updates. Use both: Claude for synthesis, Perplexity for surveillance."},
    {"q":"Will competitors detect my AI research?","a":"Web research is invisible - competitors do not see your Perplexity searches. Direct product probing (signing up, scraping) leaves footprints; use anonymized accounts and respect ToS."}
  ]'::jsonb, 'research', 'intermediate', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 29. ai-for-data-collection
(
  'ai-for-data-collection', 'AI for Data Collection', '📥',
  ARRAY['research'], ARRAY['dovetail','maze','typeform','sprig'], 3,
  'Data collection in user research used to start with a Google Form and end with a CSV nobody analyzed. AI data collection tools generate question scaffolds from research goals, optimize for completion rate, and route incoming data into a research repository ready for synthesis. Typeform leads consumer-grade survey design; Sprig covers in-product micro-data collection; Dovetail and Maze pair collection with downstream synthesis.',
  'We weighted: question-generation from goal, completion-rate optimization, data-routing into research repo, and integration with downstream analysis tools.',
  '[
    {"q":"Typeform vs Dovetail for collection?","a":"Typeform is collection-only - great for one-time research surveys. Dovetail collects plus synthesizes into a research repository. One-off survey: Typeform. Continuous research program: Dovetail."},
    {"q":"How do I prevent biased data collection?","a":"AI tools flag leading questions, double-barreled wording, and demographic gaps in respondent pool. Manual review still catches domain-specific bias (regulatory phrasing, sensitive cultural context). Use both."},
    {"q":"Sprig for B2B research?","a":"Sprig is product-survey-first; works for in-app B2B research where users are already logged in. For external B2B research (prospects, churned customers), Typeform plus email distribution fits better."}
  ]'::jsonb, 'research', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === PRODUCTIVITY / OPS (3) ===

-- 30. ai-for-standup-summaries
(
  'ai-for-standup-summaries', 'AI for Standup Summaries', '☕',
  ARRAY['meeting-tools','productivity'], ARRAY['fathom','notion-ai','fireflies-ai','sembly-ai','otter-ai'], 3,
  'Standup summaries used to mean someone scribbling in Slack while half the team typed "lgtm" without reading. AI standup tools record the meeting, extract individual updates, and post a structured digest to Slack within minutes of the call ending. Fathom and Fireflies.ai lead with strong free tiers; Sembly.ai handles multi-language teams; Notion AI integrates standup summaries directly into project pages; Otter.ai is the long-running general-purpose option.',
  'Selection focused on: Slack/Teams digest formatting, action-item extraction per person, multi-language coverage, and free-tier limits.',
  '[
    {"q":"Do I still need a live standup if AI summarizes?","a":"For distributed teams, async standup notes plus AI summary often beats a 15-minute live call. For tightly coupled teams under deadline, the live call still adds urgency. Hybrid is the modern default."},
    {"q":"Fathom vs Fireflies?","a":"Fathom has the cleanest free tier (1 user, unlimited recording). Fireflies has stronger team features and Zapier integration in mid-tier. Solo PM: Fathom. Team-owned tooling: Fireflies."},
    {"q":"Is standup recording weird for the team?","a":"After 1-2 weeks, no - the productivity gain (no taking notes, no missed action items) outweighs awareness of recording. Always disclose recording at meeting start - non-negotiable."}
  ]'::jsonb, 'productivity', 'beginner', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 31. ai-for-project-status-reports
(
  'ai-for-project-status-reports', 'AI for Project Status Reports', '📌',
  ARRAY['project-management'], ARRAY['linear','notion-ai','monday','asana','clickup'], 3,
  'Status reports are the tax PMs pay for stakeholder visibility - 4-8 hours every Friday writing what already happened. AI status report tools generate the executive summary from ticket movements, slip flags, and on-time metrics. Linear leads engineering-team status with native milestone summaries; Notion AI generates narrative from project pages; Monday, Asana, and ClickUp cover broader project-management workflows with status-report features.',
  'We weighted: ticket-to-summary accuracy, RAG (red-amber-green) scoring quality, stakeholder-distribution flexibility, and integration with engineering tools (GitHub, Jira).',
  '[
    {"q":"Linear vs Notion AI for engineering status?","a":"Linear is engineering-native with deep ticket-to-status pipeline. Notion AI is narrative-first with broader cross-team status synthesis. Pure engineering team: Linear. Cross-functional projects: Notion AI."},
    {"q":"Monday vs Asana vs ClickUp?","a":"Monday is visual-board-first with strongest cross-team views. Asana has cleanest task management for scaling teams. ClickUp tries to do everything in one tool. Visual stakeholder reporting: Monday. Scaling project management: Asana. All-in-one preference: ClickUp."},
    {"q":"Will AI catch project slips early?","a":"For ticket-velocity-driven slips (sprint not finishing on time), yes. For scope-creep slips (silent feature additions), AI is weaker - PM judgment still matters. AI handles the on-track-per-ticket question; humans handle whether we are doing the right work."}
  ]'::jsonb, 'productivity', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 32. ai-for-personal-knowledge
(
  'ai-for-personal-knowledge', 'AI for Personal Knowledge Management', '🧠',
  ARRAY['note-taking'], ARRAY['notion-ai','readwise','reflect','tana','mem-ai'], 3,
  'Personal knowledge management broke down because nobody re-reads notes. AI PKM tools surface relevant notes when you start writing on a topic, summarize highlights, and weave forgotten ideas into current work. Mem.ai and Reflect lead AI-native PKM with proactive surfacing; Tana adds structured-tags-plus-AI; Notion AI brings PKM into the broader workspace; Readwise unifies reading-highlight capture across Kindle, Twitter, and articles.',
  'Selection focused on: proactive note-surfacing quality, search beyond exact-match, capture-from-read coverage, and integration with reading apps.',
  '[
    {"q":"Mem.ai vs Reflect?","a":"Mem is collaborative-team-friendly with calendar integration. Reflect is solo-first with stronger end-to-end encryption. Solo with privacy concerns: Reflect. Team-shared knowledge: Mem."},
    {"q":"Readwise vs Notion AI?","a":"Different jobs. Readwise captures highlights from Kindle/Twitter/articles. Notion AI surfaces and synthesizes existing notes. Stack both - Readwise for capture, Notion AI for retrieval."},
    {"q":"Will AI replace Roam/Obsidian?","a":"For users who want pure linking and graph view, no - Roam and Obsidian remain best-in-class. For users who want AI to surface forgotten notes proactively, Mem and Reflect have leapfrogged. Different philosophies; both valid."}
  ]'::jsonb, 'productivity', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === E-COMMERCE (2) ===

-- 33. ai-for-product-listings
(
  'ai-for-product-listings', 'AI for Product Listings', '🏷️',
  ARRAY['writing-ai','ecommerce'], ARRAY['jasper','hypotenuse-ai','copy-ai','writesonic','anyword'], 3,
  'Product listings at scale (1,000+ SKUs) drown merchandising teams - and the bad ones fail to rank or convert. AI product listing tools generate titles, bullets, and descriptions optimized for marketplace SEO and on-site conversion. Jasper and Anyword lead with engagement scoring per variant; Hypotenuse.ai is e-commerce-listing specialist with bulk processing; Copy.ai and Writesonic cover mid-volume catalogs with template flexibility.',
  'We weighted: bulk-listing throughput, marketplace-keyword integration (Amazon, Shopify, Etsy), variant testing, and brand-voice consistency at scale.',
  '[
    {"q":"How many listings can AI handle per day?","a":"Bulk-mode tools process 1,000-10,000 SKUs in a day with one human reviewer for QA. Quality starts to degrade past 10k unless the SKU set is highly templated. Plan one merch reviewer per 500-1,000 listings."},
    {"q":"Jasper vs Hypotenuse for ecommerce?","a":"Jasper is multi-purpose with stronger brand-voice training - good for premium DTC. Hypotenuse is e-commerce-specialist with deeper SKU-attribute understanding. Premium DTC: Jasper. High-volume marketplace: Hypotenuse."},
    {"q":"Will AI listings rank on Amazon?","a":"Yes if keyword-research-driven. Amazon ranks based on relevance to search query plus conversion - both improve with AI-optimized listings vs manually written. Always include a human review step on hero SKUs."}
  ]'::jsonb, 'writing', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 34. ai-for-shopify
(
  'ai-for-shopify', 'AI for Shopify', '🛍️',
  ARRAY['ecommerce'], ARRAY['gorgias','omnisend','klaviyo','shopify-magic'], 3,
  'Shopify stores hit AI workflow at three places: customer support, email/SMS marketing, and merchandising. AI Shopify tools tie into the Shopify Admin and customer database to automate replies, segment buyers, and write product copy at scale. Shopify Magic is native and free; Gorgias leads e-commerce support with deep Shopify integration; Klaviyo and Omnisend lead Shopify-native email-and-SMS marketing.',
  'Selection focused on: Shopify-native integration depth, customer-data sync quality, automation breadth (support/marketing/merchandising), and pricing for sub-$1M GMV stores.',
  '[
    {"q":"Klaviyo vs Omnisend?","a":"Klaviyo has the deeper feature set and stronger predictive segmentation - the default for $1M+ GMV stores. Omnisend is cheaper and simpler - the better fit for sub-$500k GMV. Inflection point is around $500k-1M GMV."},
    {"q":"Gorgias vs Shopify Inbox?","a":"Shopify Inbox is free and bundled - works for sub-50-tickets/day stores. Gorgias is paid with deeper macro automation and AI replies - earns its premium past 50 tickets/day. Volume threshold is the deciding factor."},
    {"q":"Is Shopify Magic enough?","a":"For ad-hoc product copy and basic image work, yes - it is free and built into Admin. For volume listing generation or brand-voice consistency, dedicated tools (Jasper, Hypotenuse) handle the workload better."}
  ]'::jsonb, 'marketing', 'intermediate', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SUPPORT (3) ===

-- 35. ai-for-customer-routing
(
  'ai-for-customer-routing', 'AI for Customer Routing', '🚦',
  ARRAY['customer-service'], ARRAY['gladly','front-app','intercom','freshdesk','zendesk'], 3,
  'Customer routing used to be a static "billing goes here, technical goes there" rule that broke down with multi-issue tickets. AI customer routing tools classify intent, predict urgency, and route to the right agent (or bot) based on past resolution patterns. Zendesk and Freshdesk lead enterprise routing with deep AI rules; Intercom adds product-led routing with customer-context awareness; Front and Gladly cover team-inbox-style routing for support-plus-sales blends.',
  'We weighted: intent-classification accuracy, urgency prediction, agent-skill matching, and routing audit-trail for QA.',
  '[
    {"q":"Zendesk vs Intercom?","a":"Zendesk is helpdesk-first with stronger ticketing depth and broader integrations. Intercom is messenger-first with stronger product-context routing (which feature, which paywall). Helpdesk-led: Zendesk. Product-led: Intercom."},
    {"q":"How accurate is AI routing?","a":"For top-3-intent classification (billing, technical, sales), 90-95%. For long-tail intents (specific feature questions), 70-80%. Always allow agents to manually re-route - the AI is a starting point, not gospel."},
    {"q":"Front vs Gladly?","a":"Front is shared-inbox-first - great for sales-and-support blended teams. Gladly is voice-of-customer-first with stronger conversation history across channels. Mixed sales/support: Front. Pure support with voice: Gladly."}
  ]'::jsonb, 'support', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 36. ai-for-feedback-categorization
(
  'ai-for-feedback-categorization', 'AI for Feedback Categorization', '🗃️',
  ARRAY['research','customer-service'], ARRAY['dovetail','maze','typeform','sprig'], 3,
  'Customer feedback piles up faster than anyone can read - support tickets, NPS open-text, app store reviews, sales call notes. AI feedback categorization tools cluster feedback into themes, surface emerging issues before they spike, and quantify theme weight by revenue or customer tier. Dovetail leads in cross-source synthesis; Sprig handles in-product feedback continuously; Maze and Typeform cover survey-driven feedback with auto-clustering.',
  'Selection focused on: cross-source synthesis (tickets + surveys + calls), emerging-theme detection, theme weighting by customer value, and integration with PM tools.',
  '[
    {"q":"How does AI find emerging themes?","a":"Top tools detect rising-frequency clusters (a theme moving from <2% to >5% of feedback in 30 days flags as emerging). Useful for catching new feature requests or regression bugs before they go viral."},
    {"q":"Dovetail vs Sprig?","a":"Dovetail synthesizes across many sources - great for quarterly research review. Sprig captures continuous in-product feedback with auto-clustering - great for weekly product loops. Different time horizons; many teams stack both."},
    {"q":"Can AI categorize feedback in any language?","a":"Top tools handle 20-50 languages competently. Mid-tier tools default to English-strong with weaker non-English. For multi-language SaaS or global products, verify language coverage in the trial."}
  ]'::jsonb, 'support', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 37. ai-for-live-chat
(
  'ai-for-live-chat', 'AI for Live Chat', '💬',
  ARRAY['customer-service'], ARRAY['gladly','intercom','tidio','drift','freshchat'], 3,
  'Live chat moved from human-only to AI-assisted to AI-first in three years. AI live chat tools handle 60-80% of inbound queries autonomously, hand off to humans on complex issues, and learn from resolved tickets nightly. Intercom and Drift lead enterprise messenger-plus-AI; Tidio and Freshchat cover SMB with stronger free tiers; Gladly differentiates with voice-and-chat unification.',
  'We weighted: AI-resolution rate without human handoff, fallback handoff smoothness, multi-channel coverage (web/SMS/WhatsApp), and pricing scale curve.',
  '[
    {"q":"Intercom vs Drift?","a":"Intercom is product-led-growth heavy with deeper user-context integration. Drift is sales-led with stronger ABM and meeting-booking workflows. PLG SaaS: Intercom. Enterprise sales: Drift."},
    {"q":"What resolution rate is realistic?","a":"For mature implementations on common queries, 60-80% AI resolution without escalation. New deployments start at 30-40% and improve over 6-12 months as the model trains on team responses. Treat published vendor numbers as ceilings, not floors."},
    {"q":"Tidio vs Freshchat for SMB?","a":"Tidio has the cleanest free tier (50 conversations/month) and faster setup. Freshchat is part of the Freshworks suite - better fit if also using Freshdesk for tickets. Standalone: Tidio. Freshworks shop: Freshchat."}
  ]'::jsonb, 'support', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === WRITING (3) ===

-- 38. ai-for-bios
(
  'ai-for-bios', 'AI for Bios', '👤',
  ARRAY['writing-ai'], ARRAY['jasper','copy-ai','writesonic','anyword'], 3,
  'Personal and company bios are the highest-leverage 200 words on the internet - and most are bad because writing them is awkward. AI bio tools convert a resume or company-deck into multiple bio lengths (LinkedIn, speaker bio, byline, About page) tuned for tone and audience. Jasper leads with strongest tone control and length variants; Copy.ai and Writesonic cover mid-market with template breadth; Anyword scores variants for engagement on landing pages.',
  'Selection focused on: length-variant generation (50/150/300 words), tone control (formal vs warm vs witty), platform-specific templates (LinkedIn vs speaker bio), and source-input flexibility.',
  '[
    {"q":"How long should a bio be?","a":"50 words for Twitter/X, 150 words for LinkedIn About, 300 words for speaker bio, 500+ for company About page. Top tools generate all four from one source paragraph."},
    {"q":"Will AI bios sound generic?","a":"Default templates often do. The fix is providing distinctive raw material - specific accomplishments, unusual hobbies, contrarian opinions. AI amplifies what you give it; generic input produces generic output."},
    {"q":"Jasper vs Copy.ai for bios?","a":"Jasper has stronger brand-voice training - useful when bio appears across many touchpoints. Copy.ai has more bio-specific templates out-of-box. One-off bio: Copy.ai. Brand-consistent bio across surfaces: Jasper."}
  ]'::jsonb, 'writing', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 39. ai-for-podcast-scripts
(
  'ai-for-podcast-scripts', 'AI for Podcast Scripts', '🎤',
  ARRAY['writing-ai','voice-audio'], ARRAY['riverside','descript','jasper','copy-ai','podcastle'], 3,
  'Podcast scripts swing between two failure modes - over-scripted (sounds robotic) or under-scripted (rambles for 90 minutes). AI podcast script tools draft outlines, suggest hook variants for the cold open, and generate show notes from the recording in minutes. Descript and Riverside lead AI-powered podcast production; Podcastle adds AI voice and background music; Jasper and Copy.ai cover the script-and-show-notes writing layer.',
  'We weighted: cold-open hook quality, outline structure (vs full script), show-notes generation from recording, and pricing for solo vs team podcasts.',
  '[
    {"q":"Should I fully script my podcast?","a":"Most successful indie shows use a detailed outline (10-20 bullet points) plus scripted cold-open and segment transitions - not a full word-for-word script. AI tools default to this hybrid."},
    {"q":"Descript vs Riverside?","a":"Descript is editing-first with strong text-based audio editing. Riverside is recording-first with industry-leading remote-recording quality. If you record solo and edit heavy: Descript. If you record interviews remotely: Riverside."},
    {"q":"Can AI generate show notes that drive search traffic?","a":"Yes - top tools extract timestamps, key quotes, guest bio, and SEO-friendly summary in minutes. Always sanity-check guest names and quoted statistics manually before publishing."}
  ]'::jsonb, 'writing', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 40. ai-for-youtube-scripts
(
  'ai-for-youtube-scripts', 'AI for YouTube Scripts', '🎬',
  ARRAY['writing-ai','video-ai'], ARRAY['descript','opus-clip','jasper','copy-ai'], 3,
  'YouTube rewards retention - and retention is set by hook, pacing, and pattern interrupts that are hard to design from gut feel. AI YouTube script tools generate hook variants tuned for the first 30 seconds, suggest pattern-interrupt cues, and convert long-form scripts into shorts-ready clips. Descript leads with text-to-video editing plus script integration; Opus Clip extracts viral shorts from long-form; Jasper and Copy.ai cover the script-writing layer.',
  'Selection focused on: hook quality for first-30-second retention, pacing analysis, shorts/clip extraction, and integration with YouTube Studio analytics.',
  '[
    {"q":"How long should a YouTube hook be?","a":"7-15 seconds is the modern attention threshold. AI tools test 5-10 hook variants per script and forecast retention based on past channel performance. Test the top 2-3 in actual uploads."},
    {"q":"Opus Clip vs Descript for shorts?","a":"Opus Clip is shorts-extraction-specialist with auto-captions and viral-moment detection. Descript handles full long-form editing plus shorts as a side feature. Pure shorts strategy: Opus Clip. Long-form-plus-shorts: Descript."},
    {"q":"Can AI write script for the algorithm?","a":"It writes for retention, which the algorithm rewards. Direct algorithm hacks (manipulative thumbnails, clickbait titles) work short-term but hurt channel health long-term. AI optimization is most useful for honest retention - not gaming."}
  ]'::jsonb, 'writing', 'intermediate', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (2) ===

-- 41. ai-for-style-guides
(
  'ai-for-style-guides', 'AI for Style Guides', '🎨',
  ARRAY['design','writing-ai'], ARRAY['claude','jasper','copy-ai','anyword'], 3,
  'Brand style guides used to live in a 60-page PDF nobody read past page 8. AI style guide tools train on existing brand assets, enforce voice and tone consistency on every draft, and surface violations in real time on Slack or Google Docs. Jasper leads with deepest brand-voice profile training and asset-library integration; Claude excels at custom-rule enforcement through constitution-style prompts; Copy.ai and Anyword cover mid-market with simpler voice presets.',
  'We weighted: voice training depth, real-time-violation detection, multi-tone profile support, and integration with writing surfaces (Slack, Docs, Notion).',
  '[
    {"q":"Jasper vs Claude for style enforcement?","a":"Jasper has out-of-the-box brand-voice training UI - faster setup. Claude has more flexible custom-rule enforcement via prompts - better for unusual style needs. Standard B2B SaaS: Jasper. Highly bespoke voice: Claude."},
    {"q":"Will AI catch style violations in real time?","a":"For tone drift and forbidden words, yes - browser extensions and Slack bots flag violations on every draft. Subtle violations (rhythm, voice consistency over a long doc) still need a senior writer review."},
    {"q":"How often should the style guide update?","a":"Quarterly is the sustainable cadence. AI tools surface emerging patterns (new product names, new competitor mentions) so the guide does not drift. Going slower than quarterly means new writers learn old rules."}
  ]'::jsonb, 'design', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 42. ai-for-graphic-design
(
  'ai-for-graphic-design', 'AI for Graphic Design', '🎭',
  ARRAY['design','image-ai'], ARRAY['canva','picsart','photoroom','remove-bg'], 3,
  'Graphic design used to require a professional designer for every social post, ad creative, and product photo. AI graphic design tools handle background removal, layout templates, and brand-consistent variants in seconds for non-designers. Canva leads consumer-and-SMB design with deep AI-feature breadth; Picsart and Photoroom focus on photo editing and product imagery; Remove.bg is the specialized background-removal layer many other tools build on.',
  'Selection focused on: template breadth, background removal quality, brand-kit enforcement, and pricing for non-professional users.',
  '[
    {"q":"Canva vs professional design tools?","a":"For 80% of marketing and social design, Canva is sufficient and 10x faster. For brand-system work, packaging design, or complex compositing, dedicated tools (Figma, Photoshop) still earn the seat. Different jobs."},
    {"q":"Photoroom vs Picsart?","a":"Photoroom is product-photography first with strongest e-commerce templates. Picsart is broader photo editing with stronger consumer features. DTC product photos: Photoroom. Social media editing: Picsart."},
    {"q":"Will AI replace designers?","a":"For volume production work, mostly yes. For strategy, brand identity, and complex problem-solving, designers are more valuable than ever - AI raises the floor and the ceiling. Designer + AI tools = best output."}
  ]'::jsonb, 'design', 'beginner', 4400,
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
