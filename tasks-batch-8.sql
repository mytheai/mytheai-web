-- Phase 2 batch 4 of Task Taxonomy initiative (S120)
-- 23 mid-tail tasks targeting 200-task Phase 2 milestone: finance (+3), customer-success (+2),
-- hr-recruiting (+2), ops (+3), support (+2), data-analytics (+2), research (+1), design (+1),
-- dev (+2), sales (+1), marketing (+1), writing (+2), productivity (+1).
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Phase 2 progress: 177 -> 200 tasks (PHASE 2 TARGET HIT).
-- Gate A 23/23 PASS, Gate B 23/23 PASS. All picked_slugs verified in tools catalog.
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === FINANCE (3) ===

-- 1. ai-for-finance-automation
(
  'ai-for-finance-automation', 'AI for Finance Automation', '⚙️',
  ARRAY['finance'], ARRAY['ramp','brex','tipalti','bench','airbase'], 3,
  'Finance automation in 2026 is no longer about spreadsheets and macros - it is about AI agents that close books, route invoices, and reconcile accounts overnight. Ramp and Brex bundle card spend with auto-categorization and instant reimbursement; Tipalti owns global AP and tax-form collection; Bench layers a human bookkeeper on top of AI categorization for SMBs without an in-house finance hire; Airbase consolidates the entire procure-to-pay flow.',
  'We weighted: depth of finance workflow coverage (AP, AR, expenses, books), AI categorization accuracy, multi-entity support, and integration with NetSuite and QuickBooks.',
  '[
    {"q":"Ramp vs Brex for finance automation?","a":"Ramp leads on spend controls, bill pay, and free corporate cards with AI-powered policy enforcement; Brex has stronger international coverage, premium rewards, and a venture-debt offering. Domestic startups under 200 employees default to Ramp; globally distributed teams with travel-heavy spend lean Brex."},
    {"q":"Do we still need a bookkeeper?","a":"Yes, but the role shifts from data entry to review and judgment. AI categorizes 90-95% of transactions automatically; the remaining edge cases (deferred revenue, capitalized R&D) still need human classification. Bench bundles the bookkeeper plus AI for SMBs that do not want the hire."},
    {"q":"Can AI close the books faster?","a":"Tools like Vic.ai and Stampli compress month-end close from 10 days to 3-5 by auto-matching invoices to POs and flagging accruals in real time rather than at month-end. The compression depends on integration cleanliness with your GL."}
  ]'::jsonb, 'finance', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-corporate-cards
(
  'ai-for-corporate-cards', 'AI for Corporate Cards', '💳',
  ARRAY['finance'], ARRAY['ramp','brex','airbase'], 3,
  'Corporate cards used to be a Stripe-issued plastic with manual receipt collection at month-end. AI-powered corporate cards now enforce policy in real time, auto-match receipts to charges, and flag duplicate or out-of-policy spend before reimbursement. Ramp and Brex are the two market leaders with free issuance and AI-driven controls; Airbase adds bill-pay and approval workflows on top.',
  'Selection prioritized: real-time policy enforcement, AI receipt matching accuracy, free vs paid tier scope, and depth of approval-routing logic.',
  '[
    {"q":"Are Ramp and Brex really free?","a":"The card and basic spend controls are free. Both monetize via interchange fees and add-on modules (Ramp Bill Pay, Brex Travel). Most companies under 100 employees never hit a paid plan."},
    {"q":"How does AI receipt matching work?","a":"OCR extracts merchant, amount, and date from a receipt photo; the AI matches against the open card transaction within seconds. Match accuracy is 95%+ on standard receipts; handwritten or partial receipts still need human verification."},
    {"q":"Best for international teams?","a":"Brex has stronger non-USD coverage and FX rates; Airbase supports multi-currency reimbursements. Ramp is US-first with limited international card support, though wire-based bill pay covers global vendors."}
  ]'::jsonb, 'finance', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-vendor-payments
(
  'ai-for-vendor-payments', 'AI for Vendor Payments', '💸',
  ARRAY['finance'], ARRAY['tipalti','airbase','stampli','ramp','brex'], 3,
  'Paying 200 vendors monthly used to mean 200 manual ACH or wire entries, 200 W-9 collections, and 200 chances for fraud. AI vendor payments centralize global AP into a single approval flow with auto-collected tax forms, fraud screening, and multi-currency rails. Tipalti is the global AP standard; Airbase and Stampli compete in mid-market; Ramp and Brex bundle bill pay into card platforms.',
  'We weighted: global payment rail coverage, tax-form auto-collection (W-9, W-8BEN), AI invoice extraction accuracy, and fraud-screening depth.',
  '[
    {"q":"Tipalti vs Airbase for AP?","a":"Tipalti leads on global complexity (190+ countries, 120+ currencies, OFAC screening); Airbase wins on US-domestic ease-of-use and tighter card integration. International contractor-heavy teams pick Tipalti; US-mid-market default to Airbase."},
    {"q":"How does AI prevent vendor fraud?","a":"Tools flag bank-account changes, duplicate invoices, and abnormal payment patterns. AI also catches the now-common social-engineering scam where a vendor email asks finance to update wire details to a fraudulent account."},
    {"q":"What about 1099 and W-9 season?","a":"Tipalti, Stampli, and Airbase all auto-collect W-9 and W-8BEN at vendor onboarding and generate 1099-NEC at year-end. This eliminates the late-January scramble that used to consume finance teams for two weeks."}
  ]'::jsonb, 'finance', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === CUSTOMER-SUCCESS (2) ===

-- 4. ai-for-quarterly-business-reviews
(
  'ai-for-quarterly-business-reviews', 'AI for Quarterly Business Reviews', '📊',
  ARRAY['customer-service'], ARRAY['gainsight','planhat','vitally','totango','catalyst'], 3,
  'Quarterly business reviews used to mean a CSM cobbling slides from product analytics, support tickets, and CRM notes the night before the meeting. AI-powered QBR tools auto-generate the slide deck from health-score data, expansion signals, and feature-adoption telemetry. Gainsight and Planhat lead enterprise; Vitally and Catalyst serve mid-market; Totango and ChurnZero target high-volume long-tail accounts.',
  'Selection weighted: auto-slide generation quality, integration depth with product telemetry and CRM, expansion-signal detection, and customer-facing portal polish.',
  '[
    {"q":"Gainsight vs Planhat for QBR?","a":"Gainsight has the broader enterprise ecosystem (more integrations, deeper customization) but a steeper learning curve; Planhat has cleaner UX and faster implementation. 500+ accounts: Gainsight. Under 500 with limited ops bandwidth: Planhat."},
    {"q":"Can AI write the QBR narrative?","a":"Yes for pattern-driven content (usage trends, ROI calc, renewal risk); no for nuanced relationship context. The AI surfaces the data and drafts copy; the CSM owns the strategic recommendation and customer-specific framing."},
    {"q":"How often should we run automated QBRs?","a":"Quarterly is the legacy cadence but most teams now do monthly health reviews automated and quarterly deep-dives manual. The automation surfaces problems early so QBRs become strategic rather than diagnostic."}
  ]'::jsonb, 'customer-success', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 5. ai-for-customer-journey-mapping
(
  'ai-for-customer-journey-mapping', 'AI for Customer Journey Mapping', '🗺️',
  ARRAY['customer-service'], ARRAY['gainsight','planhat','vitally','custify','akita'], 3,
  'Customer journey mapping used to be a Miro board built once at an offsite and never updated. AI customer journey mapping pulls real product, support, and revenue data to surface where customers actually drop off, expand, or escalate. Gainsight, Planhat, and Vitally lead in journey orchestration with embedded product analytics; Custify and Akita serve early-stage CS teams that need quick wins.',
  'We weighted: data-source breadth (product + support + CRM), journey-stage automation, intervention-trigger flexibility, and CSM-facing dashboard usability.',
  '[
    {"q":"Difference vs traditional journey mapping?","a":"Traditional mapping is a snapshot built from interviews and assumptions. AI journey mapping is continuous and observation-based, updating in real time as customers move through stages and as the underlying product evolves."},
    {"q":"How granular should stages be?","a":"Most teams start with 5-7 stages (lead, onboarding, adoption, value-realization, advocacy, renewal, churn-risk) and add sub-stages as the data reveals friction. More than 12 top-level stages signals over-engineering."},
    {"q":"Best for B2B SaaS with long cycles?","a":"Gainsight and Planhat both handle 12-18 month enterprise journeys with multi-stakeholder mapping. Custify and Akita are better for shorter SMB cycles where journey velocity matters more than depth."}
  ]'::jsonb, 'customer-success', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === HR-RECRUITING (2) ===

-- 6. ai-for-resume-screening
(
  'ai-for-resume-screening', 'AI for Resume Screening', '📄',
  ARRAY['hr'], ARRAY['ashby','greenhouse','lever','bamboohr','eightfold'], 3,
  'Resume screening at 500 applications per role used to mean recruiters skimming for keywords in 7 seconds per resume. AI resume screening tools score resumes against job criteria, surface diverse candidate pools, and flag bias-prone language in job descriptions before posting. Ashby, Greenhouse, and Lever lead enterprise ATS with embedded AI; BambooHR serves SMBs; Eightfold offers a deeper talent-graph layer for fortune-500 scale.',
  'We weighted: scoring accuracy on technical roles, EEOC and EU AI Act compliance, structured-interview integration, and time-to-shortlist on bulk applications.',
  '[
    {"q":"Is AI resume screening legal?","a":"Yes if the tool is bias-tested and provides explainable scoring. NYC, Illinois, and the EU AI Act all require disclosure when AI is used in hiring decisions. Ashby, Greenhouse, and Eightfold all provide compliance documentation; check your jurisdiction."},
    {"q":"Ashby vs Greenhouse for AI screening?","a":"Ashby has cleaner reporting, structured-interview defaults, and better small-team UX; Greenhouse has the deeper enterprise integration ecosystem and more mature AI scorecard. Series A to C: Ashby. Series D and beyond: Greenhouse."},
    {"q":"Will AI replace recruiters?","a":"AI replaces the screening triage and scheduling logistics, not the candidate-experience and offer-negotiation work. Recruiters who use AI well now manage 3x more reqs; recruiters who do not are getting squeezed out of the role."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-candidate-sourcing
(
  'ai-for-candidate-sourcing', 'AI for Candidate Sourcing', '🎯',
  ARRAY['hr'], ARRAY['ashby','goodtime','metaview','greenhouse','lever'], 3,
  'Candidate sourcing was 80% LinkedIn keyword search and 20% boolean wizardry until AI changed the floor. AI sourcing tools now generate semantic matches across LinkedIn, GitHub, and proprietary databases, then auto-personalize outreach based on candidate background. Ashby, Greenhouse, and Lever embed sourcing into the ATS; Beamery and Eightfold provide standalone talent CRMs; Metaview adds AI interview intelligence to feed sourcing decisions.',
  'Selection prioritized: passive-candidate database depth, semantic-match accuracy on niche skills, outreach personalization quality, and ATS-integration cleanliness.',
  '[
    {"q":"Best tool for technical sourcing?","a":"Eightfold and Beamery have the deepest talent graphs for engineering roles via GitHub and Stack Overflow signal mining. Greenhouse and Lever both offer LinkedIn Recruiter integrations that cover the broader senior-IC market well."},
    {"q":"How personalized can outreach be?","a":"AI generates first-draft messages from candidate profile + role + company-tone signals; recruiters review and send. Reply rates run 3-5x cold spam baseline when the personalization touches a recent project, paper, or talk. Generic templates still underperform."},
    {"q":"Diversity sourcing concerns?","a":"AI surface-level pattern-matching can entrench bias if trained on past-hiring data. Eightfold and Beamery both publish bias audits and offer slate-balancing features that surface qualified candidates outside historical pipelines."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === OPS (3) ===

-- 8. ai-for-ops-automation
(
  'ai-for-ops-automation', 'AI for Operations Automation', '🔄',
  ARRAY['automation','productivity'], ARRAY['n8n','zapier','make','workato','tray-io'], 3,
  'Operations automation in 2026 means AI agents that not only move data between systems but also make routing decisions based on context. n8n leads the open-source self-hosted segment; Zapier owns the no-code SMB market; Make and Tray.io serve mid-market with visual flow builders; Workato dominates enterprise iPaaS with deep AI orchestration. Integrately and Albato offer cheaper alternatives for smaller teams.',
  'Selection focused on: AI step quality, app-integration breadth, error-handling depth, and pricing scale at high task volumes.',
  '[
    {"q":"n8n vs Zapier for ops?","a":"n8n is open-source self-hosted with no per-task fees and code escape hatches; Zapier is closed-source SaaS with the broadest app catalog (7,000+) and the easiest no-code UX. Engineering-led teams pick n8n; ops-led teams pick Zapier."},
    {"q":"When does iPaaS pay off?","a":"Once a company runs more than 10 critical workflows across 4+ systems, dedicated iPaaS like Workato or Tray.io reduces failure rate and centralized error monitoring. Below that threshold, Zapier or Make plus a custom Python script handles the load fine."},
    {"q":"Can AI write the workflow?","a":"Zapier AI Actions, Make AI agents, and n8n LangChain nodes can draft workflows from natural-language prompts. Drafts are 70-80% complete out of the box; the last mile is auth, error-handling, and edge-case testing that still needs human review."}
  ]'::jsonb, 'ops', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 9. ai-for-document-workflow
(
  'ai-for-document-workflow', 'AI for Document Workflow', '📑',
  ARRAY['productivity'], ARRAY['pandadoc','docusign-ai','ironclad','adobe-sign','contractbook'], 3,
  'Document workflow used to be a chain of email attachments with version-naming chaos like Final_v3_REAL_FINAL.docx. AI document workflow tools route, sign, redline, and store contracts within a single platform with full audit trails. PandaDoc and DocuSign lead e-signature plus pipeline; Ironclad and Juro own contract lifecycle for legal teams; Adobe Sign leans on Adobe ecosystem; Contractbook and Oneflow serve cleaner mid-market UX.',
  'We weighted: AI redlining quality, template-library depth, e-signature legal coverage (eIDAS, ESIGN), and integration with Salesforce and HubSpot.',
  '[
    {"q":"PandaDoc vs DocuSign for sales?","a":"PandaDoc has tighter sales pipeline integration, in-doc payment collection, and analytics on prospect engagement; DocuSign has the broader brand recognition and deeper enterprise compliance. Sales-led teams pick PandaDoc; legal-led teams pick DocuSign."},
    {"q":"Best CLM for legal teams?","a":"Ironclad has the broadest playbook automation and AI redlining; Juro has the cleaner UX and faster onboarding; Contractbook serves the European market with strong eIDAS compliance. Series B+ legal teams default to Ironclad."},
    {"q":"Can AI redline a contract?","a":"Tools like Ironclad AI and Spellbook draft redlines based on company playbooks and prior contract patterns. Redlines hit 80%+ acceptance from counterparty-counsel on standard NDAs and MSAs; complex M&A still needs senior counsel review."}
  ]'::jsonb, 'ops', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-rfp-management
(
  'ai-for-rfp-management', 'AI for RFP Management', '📨',
  ARRAY['productivity'], ARRAY['pandadoc','qwilr','loopio','dealhub','better-proposals'], 3,
  'RFP responses for B2B SaaS deals used to mean a sales engineer copy-pasting answers from a 2-year-old Google Doc into 80 questions over a weekend. AI RFP management tools maintain a continuously updated answer library, suggest the best response from past wins, and route stakeholder review automatically. Loopio leads dedicated RFP automation; PandaDoc and Qwilr layer it into proposal platforms; DealHub adds CPQ; Better Proposals serves SMB freelancers.',
  'Selection weighted: answer-library auto-suggest accuracy, multi-author review flow, integration with Salesforce and HubSpot, and exportable formats (Word, PDF, Excel).',
  '[
    {"q":"Loopio vs PandaDoc for RFP?","a":"Loopio is purpose-built for RFP and security-questionnaire workflow with a deep answer library; PandaDoc is a broader proposal platform with lighter RFP features. Enterprise teams answering 50+ RFPs per quarter pick Loopio; SMB sales teams default to PandaDoc."},
    {"q":"How accurate is AI auto-answer?","a":"AI surfaces the best historical answer with 85-90% accuracy on standard security and compliance questions; product-feature questions often need fresh review since features evolve fast. Auto-answer saves the 60-70% of time on the long tail of repetitive questions."},
    {"q":"Best for security questionnaires?","a":"Loopio dominates SOC 2 and ISO 27001 questionnaire automation; some teams pair it with Vanta or Drata to pull live compliance attestations directly into the RFP response."}
  ]'::jsonb, 'ops', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SUPPORT (2) ===

-- 11. ai-for-conversation-summaries
(
  'ai-for-conversation-summaries', 'AI for Conversation Summaries', '🗣️',
  ARRAY['meeting-ai','customer-service'], ARRAY['gong-io','modjo','fireflies-ai','otter-ai','avoma'], 3,
  'Conversation summaries solve the problem of CSMs and support agents losing 30 minutes per call on note-taking instead of customer attention. AI conversation tools transcribe, summarize, and extract action items with timestamps in real time. Gong and Modjo target revenue-team conversations with deep CRM sync; Fireflies and Otter own the meeting-notes general-purpose segment; Avoma and Sembly add agenda-template intelligence for structured calls.',
  'We weighted: transcription accuracy across accents, summary structure quality, action-item extraction reliability, and CRM integration depth.',
  '[
    {"q":"Gong vs Fireflies for support?","a":"Gong is built for revenue teams with deep deal-coaching analytics; Fireflies is general-purpose meeting AI that fits support and CS use cases too. Pure support-call ops with no sales overlap pick Fireflies; CS teams that share calls with revenue pick Gong."},
    {"q":"How accurate are summaries?","a":"On clear English audio, summaries hit 92-95% accuracy on action items and 85-90% on nuanced sentiment. Heavy accents, multi-speaker overlap, and technical jargon all degrade quality; manual review of high-stakes calls remains a good practice."},
    {"q":"Can AI tag conversations by intent?","a":"Yes - tools auto-classify calls into categories like demo, pricing question, escalation, or churn risk. The classification feeds CRM workflows so the right next-step playbook fires without a CSM having to manually log the call."}
  ]'::jsonb, 'support', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 12. ai-for-support-analytics
(
  'ai-for-support-analytics', 'AI for Support Analytics', '📈',
  ARRAY['customer-service','analytics'], ARRAY['intercom','zoho-desk','front-app','groove','freshchat'], 3,
  'Support analytics used to mean a weekly CSV export from Zendesk that the manager turned into a slide that nobody read. AI support analytics surfaces ticket-deflection opportunities, agent-performance outliers, and sentiment trends in real time inside the helpdesk itself. Intercom and Front lead AI-native helpdesks with embedded analytics; Zoho Desk and Freshchat serve SMB; Groove and LiveAgent target lean teams with cost-conscious pricing.',
  'Selection prioritized: real-time dashboard quality, ticket-deflection signal accuracy, agent-coaching insight depth, and integration with CSAT and NPS surveys.',
  '[
    {"q":"Intercom vs Zendesk for analytics?","a":"Intercom now leads on AI deflection analytics and Fin agent performance reporting; Zendesk has the broader enterprise ecosystem and deeper historical reporting. Modern AI-first teams pick Intercom; teams with legacy Zendesk depth tend to stay."},
    {"q":"How is ticket deflection measured?","a":"Tools track the ratio of customer questions resolved by AI or self-service vs escalated to a human. Best-in-class deflection is now 30-50% on FAQ-heavy categories; complex or sensitive issues still need human-first response."},
    {"q":"What about agent coaching?","a":"AI surfaces calls or tickets that scored low on customer sentiment or resolution speed and routes them to manager review. The coaching loop closes when the AI tracks improvement on the same metric over the next 30 days."}
  ]'::jsonb, 'support', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DATA-ANALYTICS (2) ===

-- 13. ai-for-data-modeling
(
  'ai-for-data-modeling', 'AI for Data Modeling', '🧮',
  ARRAY['analytics'], ARRAY['rows','deepnote','julius-ai','akkio','formula-bot'], 3,
  'Data modeling used to be the analyst writing 200-line SQL queries to join CRM, billing, and product tables into a usable revenue cube. AI data modeling tools now generate the joins, suggest aggregations, and surface anomalies from natural-language prompts. Rows and Deepnote lead the spreadsheet-native segment with AI-assisted formulas; Julius AI and Akkio serve no-code analysts; Formula Bot, Hal9, Seek AI add prompt-to-SQL on top of existing warehouses.',
  'We weighted: prompt-to-SQL accuracy on real schemas, multi-table join handling, integration with Snowflake and BigQuery, and explainability of AI-generated models.',
  '[
    {"q":"Rows vs Deepnote for modeling?","a":"Rows is a spreadsheet-first interface with AI formulas and live data connections; Deepnote is a notebook-first interface with Python plus AI assist. Spreadsheet-native analysts prefer Rows; SQL or Python-fluent teams prefer Deepnote."},
    {"q":"Can AI replace dbt?","a":"Not yet. AI tools generate one-off models well but lack dbt''s testing, lineage, and version control depth that production data teams need. Most teams use AI to draft initial dbt models that engineers review and refactor."},
    {"q":"Best for non-technical PM?","a":"Julius AI and Akkio both handle natural-language prompts against uploaded CSVs without any SQL. Formula Bot and Seek AI work directly against connected warehouses for live data with the same prompt simplicity."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-customer-analytics
(
  'ai-for-customer-analytics', 'AI for Customer Analytics', '👥',
  ARRAY['analytics'], ARRAY['chartmogul','baremetrics','segment','plausible','formula-bot'], 3,
  'Customer analytics for SaaS businesses comes down to three questions: who is paying, who is churning, and why. AI customer analytics tools surface cohort retention, expansion patterns, and churn-risk signals from billing, product, and support data. ChartMogul and Baremetrics own subscription metrics; Segment is the data-pipeline standard; Plausible offers privacy-first web analytics; Formula Bot and Akkio add prompt-driven analysis on warehouse data.',
  'Selection focused on: subscription-metric accuracy (MRR, churn, LTV), cohort segmentation flexibility, integration with Stripe and Chargebee, and AI-driven insight depth.',
  '[
    {"q":"ChartMogul vs Baremetrics?","a":"ChartMogul has deeper enterprise reporting and audit-grade MRR accuracy; Baremetrics has cleaner UX and faster setup for SMB. Series B+ teams that present metrics to investors monthly pick ChartMogul; pre-Series A teams default to Baremetrics."},
    {"q":"Why use Segment with these tools?","a":"Segment captures product events from web/mobile and pipes them into all destination tools at once - you write the tracking once and it flows to ChartMogul, Mixpanel, Plausible, and your warehouse simultaneously. Saves 80% of analytics-eng time over building per-tool integrations."},
    {"q":"Best for privacy compliance?","a":"Plausible is GDPR-compliant by default with no cookies and no PII; ChartMogul offers EU data residency. Cookie-banner avoidance for EU traffic plus MRR analytics is the Plausible plus ChartMogul stack."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === RESEARCH (1) ===

-- 15. ai-for-research-synthesis
(
  'ai-for-research-synthesis', 'AI for Research Synthesis', '🔬',
  ARRAY['research'], ARRAY['dovetail','maze','sprig','lookback','respondent'], 3,
  'Research synthesis used to mean a UX researcher tagging interview transcripts in a spreadsheet for two weeks before writing a single insight. AI research synthesis tools auto-cluster transcript themes, surface representative quotes, and generate first-draft executive summaries. Dovetail leads dedicated UX-research repos with AI tagging; Maze layers it on usability-test data; Sprig and Lookback pull from in-product surveys and session recordings; Respondent and Dscout cover panel recruiting plus diary studies.',
  'We weighted: AI tagging accuracy on long transcripts, theme-cluster quality, multi-session synthesis depth, and integration with Figma and product analytics.',
  '[
    {"q":"Dovetail vs Maze for synthesis?","a":"Dovetail is a research repository for raw interviews and longitudinal studies; Maze is a usability-testing platform that synthesizes test sessions. Generative research workflow: Dovetail. Concept-validation workflow: Maze. Many teams run both."},
    {"q":"How accurate is AI theme-clustering?","a":"On well-transcribed interviews, clustering hits 80-85% theme accuracy; researchers still review and refine before publishing insights. The accuracy lift over manual tagging is the 70% time savings, not 100% replacement."},
    {"q":"Can AI write the research report?","a":"Tools generate first-draft summaries, top-quotes, and recommendation structure; researchers refine the strategic narrative. The draft saves the synthesis-to-deck time from 3 days to 4 hours but the framing still belongs to the human."}
  ]'::jsonb, 'research', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (1) ===

-- 16. ai-for-website-design
(
  'ai-for-website-design', 'AI for Website Design', '🌐',
  ARRAY['design','code-ai'], ARRAY['framer','lovable','vercel-v0','bolt','uizard'], 3,
  'Website design in 2026 has fully merged with code generation - the line between Figma mockup and shipped landing page is now a single AI prompt. Framer leads no-code AI website builders with publishable hosting; Lovable, Vercel v0, and Bolt generate full-stack React sites from prompts; Uizard, Visily, Galileo AI focus on AI-assisted UI exploration and handoff to developers. Relume sits between as a Framer/Webflow component-library generator.',
  'Selection prioritized: prompt-to-publish quality, design-system fidelity, hosting and deployment integration, and ease of editing the AI output.',
  '[
    {"q":"Framer vs Lovable for marketing sites?","a":"Framer is purpose-built for marketing sites with managed hosting, CMS, and a strong design canvas; Lovable generates full React apps and is overkill for static marketing pages. Marketing pages with light interactivity: Framer. Apps with login or data: Lovable."},
    {"q":"Will AI replace web designers?","a":"AI replaces the wireframing-to-prototype phase but not strategy, brand, or conversion-optimization work. Designers who use AI now ship 5-10x faster and focus on the parts that actually move metrics. Designers who do not are seeing roles consolidated."},
    {"q":"How customizable is AI output?","a":"Framer and Vercel v0 outputs are fully editable in their respective canvases or as raw code; Lovable and Bolt let you fork the generated React project to GitHub. Uizard and Visily output Figma-friendly mockups for downstream handoff."}
  ]'::jsonb, 'design', 'intermediate', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DEV (2) ===

-- 17. ai-for-llm-orchestration
(
  'ai-for-llm-orchestration', 'AI for LLM Orchestration', '🎼',
  ARRAY['code-ai','automation'], ARRAY['dify','flowise','langflow','langsmith','together-ai'], 3,
  'LLM orchestration is the layer between an app and the underlying foundation models that handles routing, retries, prompt caching, and multi-step chains. Dify, Flowise, and Langflow lead visual no-code orchestration; LangSmith adds observability and eval; Together AI offers a unified inference endpoint across 100+ open models; CrewAI focuses on multi-agent orchestration patterns.',
  'We weighted: visual flow quality, multi-model routing flexibility, observability depth, and pricing scale at high token volumes.',
  '[
    {"q":"Dify vs Langflow?","a":"Dify is an end-to-end LLM-app platform with hosted deployment and team workspaces; Langflow is a Python-first visual canvas closer to LangChain. Product teams building user-facing AI features pick Dify; engineering teams prototyping pipelines pick Langflow."},
    {"q":"Why use LangSmith?","a":"LangSmith is the observability and evaluation layer above orchestration - it traces every prompt, output, and tool call so you can debug regressions and run eval suites. Most production LLM apps end up using both an orchestrator (Dify/Langflow) and LangSmith on top."},
    {"q":"Self-hosted vs cloud?","a":"Dify, Flowise, and Langflow all offer self-hosted Docker deployments for data-sensitive teams; cloud is faster to start. Healthcare, finance, and EU-data-residency teams default to self-hosted; consumer and SMB default to cloud."}
  ]'::jsonb, 'dev', 'advanced', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 18. ai-for-ai-agents
(
  'ai-for-ai-agents', 'AI for Building AI Agents', '🤖',
  ARRAY['code-ai','automation'], ARRAY['crewai','dify','langflow','agentops','wordware'], 3,
  'AI agents are the 2026 architecture pattern where multiple LLM calls coordinate to complete multi-step tasks autonomously. CrewAI leads the multi-agent role-based pattern with strong Python ergonomics; Dify and Langflow offer visual no-code agent builders; AgentOps adds observability and replay; Wordware lets product teams ship agent prototypes without engineering. Devin and Cline focus specifically on autonomous coding agents.',
  'Selection prioritized: agent-pattern flexibility (single-agent, crew, hierarchical), tool-use depth, observability and debugging quality, and shipping-to-production maturity.',
  '[
    {"q":"CrewAI vs Langflow for agents?","a":"CrewAI is a Python framework with a role-based crew pattern; Langflow is a visual canvas with broader LLM-orchestration scope. Production agents in code: CrewAI. Prototyping agents visually: Langflow. Many teams build with CrewAI after prototyping in Langflow."},
    {"q":"How autonomous can agents be?","a":"For narrow well-bounded tasks (research, data extraction, code review on small modules) agents complete jobs end-to-end. For open-ended tasks they still drift, hallucinate, or loop. Production deployments universally include human-in-the-loop checkpoints on high-stakes actions."},
    {"q":"Best agent for coding?","a":"Devin and Cline are the two production-ready autonomous coding agents in 2026. Devin tackles longer multi-file refactors; Cline (open-source) sits in VS Code with tighter human oversight. Cursor and Copilot are not agents but copilots - different paradigm."}
  ]'::jsonb, 'dev', 'advanced', 5400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SALES (1) ===

-- 19. ai-for-discovery-calls
(
  'ai-for-discovery-calls', 'AI for Discovery Calls', '🔍',
  ARRAY['meeting-ai','crm-sales'], ARRAY['gong-io','modjo','avoma','fireflies-ai','fathom'], 3,
  'Discovery calls are the highest-leverage 30 minutes in B2B sales - the difference between a closed deal and a stalled pipeline often traces back to the questions asked here. AI discovery-call tools transcribe, score, and benchmark calls against winning patterns to coach reps in real time. Gong leads enterprise revenue intelligence with the deepest call analytics; Modjo, Avoma, and Sembly serve mid-market; Fireflies and Fathom cover SMB and individual sellers.',
  'We weighted: real-time coaching quality (next-best-question prompts), competitor and objection auto-flagging, integration with Salesforce and HubSpot, and post-call action-item routing.',
  '[
    {"q":"Gong vs Fireflies for discovery?","a":"Gong is built for revenue teams with deal-coaching, deal-risk forecasting, and tight CRM sync; Fireflies is general-purpose meeting AI that covers discovery calls but lacks deal-specific analytics. Sales-led orgs of 20+ reps pick Gong; smaller teams or individual sellers pick Fireflies."},
    {"q":"Can AI score a discovery call?","a":"Tools score against frameworks like MEDDIC or BANT and flag missed sections (e.g., no economic-buyer identified, no decision criteria captured). Scores correlate to win-rate at 70-80% predictive accuracy on calibrated benchmarks - useful coaching signal, not a deal-killer."},
    {"q":"Real-time coaching during the call?","a":"Modjo, Gong, and Avoma offer real-time prompts that surface battle cards or recommended next questions while the call is happening. Adoption is mixed - top reps find it distracting, newer reps lean on it heavily during the first 90 days."}
  ]'::jsonb, 'sales', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === MARKETING (1) ===

-- 20. ai-for-content-distribution
(
  'ai-for-content-distribution', 'AI for Content Distribution', '📡',
  ARRAY['social-media-ai'], ARRAY['hootsuite','publer','planable','contentstudio','sprinklr'], 3,
  'Content distribution is the often-skipped phase between writing a great post and anyone actually reading it. AI content distribution tools auto-format for each channel, schedule across platforms, and learn the optimal time-to-post per audience segment. Hootsuite and Sprinklr serve enterprise multi-channel scale; Publer, Planable, and ContentStudio target SMB and agencies; Agorapulse, Loomly, and Vista Social fill the cost-effective mid-market niche.',
  'Selection prioritized: channel coverage breadth, AI repurpose quality (LinkedIn vs Twitter vs Instagram), team approval workflow depth, and analytics depth on performance per channel.',
  '[
    {"q":"Hootsuite vs Buffer for distribution?","a":"Hootsuite has the deeper analytics, social listening, and team-approval workflows but heavier UI; Buffer has the cleaner UX for solo creators and small teams. Multi-channel agencies and brand teams default to Hootsuite; founder-led startups default to Buffer or Publer."},
    {"q":"Best for repurposing?","a":"Publer, Planable, and ContentStudio all auto-resize and reformat a single post for LinkedIn, Twitter, Instagram, Facebook, and TikTok with platform-specific tweaks. The AI handles aspect ratios and CTA placement; the human still owns voice and angle."},
    {"q":"How important is timing optimization?","a":"AI-driven post timing lifts engagement 15-30% over fixed-schedule posting on most accounts. The lift is bigger on B2B LinkedIn (where audience timezones matter) and smaller on B2C Instagram where algorithm-driven feeds reduce timing dependence."}
  ]'::jsonb, 'marketing', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === WRITING (2) ===

-- 21. ai-for-creative-writing
(
  'ai-for-creative-writing', 'AI for Creative Writing', '✍️',
  ARRAY['writing-ai'], ARRAY['sudowrite','jasper','copy-ai','writesonic','novelai'], 3,
  'Creative writing with AI is no longer the cliche of generic fantasy openings - the 2026 generation of tools handles voice, plot pacing, and character continuity over book-length manuscripts. Sudowrite leads fiction-focused AI with story-bible support; NovelAI offers uncensored fiction-tuned models; Jasper, Copy.ai, and Writesonic serve broader creative-marketing use cases with tone presets and brand-voice training.',
  'We weighted: voice-consistency over long passages, plot-development quality, story-bible feature depth, and pricing scale at heavy daily writing volume.',
  '[
    {"q":"Sudowrite vs Jasper for fiction?","a":"Sudowrite is purpose-built for novel writing with story-bible, character cards, and the famous Plot Twist tool; Jasper is a marketing-first writing tool that handles fiction reasonably but lacks novel-specific features. Serious fiction writers default to Sudowrite."},
    {"q":"Can AI write a whole novel?","a":"Not unaided. AI excels at first-draft scenes, brainstorming plot turns, and overcoming writer''s block; the strategic arc, character depth, and final polish still require the human writer. Most published AI-assisted novels report 30-50% AI co-writing, not 100%."},
    {"q":"Voice consistency tips?","a":"Train a brand voice or character voice in Jasper or Copy.ai with 5-10 sample passages before the long writing session; for fiction, Sudowrite''s story-bible holds character-voice notes that the AI references on every generation."}
  ]'::jsonb, 'writing', 'beginner', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 22. ai-for-email-subject-lines
(
  'ai-for-email-subject-lines', 'AI for Email Subject Lines', '📧',
  ARRAY['writing-ai'], ARRAY['jasper','copy-ai','anyword','writesonic','frase'], 3,
  'Email subject lines decide 70% of open rates - the difference between 12% and 35% open is one good line that fits the recipient context. AI subject-line tools generate variations, predict open rates, and run A/B tests across send segments. Jasper, Copy.ai, and Writesonic offer general subject-line generation with tone controls; Anyword adds predictive performance scoring; Frase ties subject lines into broader content workflows.',
  'Selection focused on: variation quality and diversity, predictive open-rate scoring accuracy, A/B-test integration with Mailchimp and Klaviyo, and personalization depth (first-name, segment).',
  '[
    {"q":"Anyword vs Jasper for subject lines?","a":"Anyword has predictive scoring trained on industry-specific email data; Jasper has broader writing capabilities but lighter prediction. Email-marketing-heavy teams pick Anyword; teams that need broad copy beyond email pick Jasper."},
    {"q":"How much does AI lift open rates?","a":"On well-segmented lists, AI-generated subject lines lift open rate 8-15% over manual writing on average - bigger gains for cold outbound, smaller for warm transactional. The lift fades if the AI is fed a generic prompt - audience-specific context still wins."},
    {"q":"Tone vs personalization tradeoff?","a":"Personalization (first name, recent purchase) lifts opens 10-20%; tone-match (formal vs casual to match audience) lifts another 5-10%. Combining both consistently beats either alone, which is why AI tools that handle both at scale outperform manual writing on volume."}
  ]'::jsonb, 'writing', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === PRODUCTIVITY (1) ===

-- 23. ai-for-task-management
(
  'ai-for-task-management', 'AI for Task Management', '✅',
  ARRAY['productivity'], ARRAY['asana','monday','clickup','linear','notion-ai'], 3,
  'Task management in 2026 has moved past the basic Kanban board - AI now drafts tasks from meeting transcripts, suggests assignees based on workload, and flags missed deadlines before they slip. Asana and Monday lead enterprise project management with deep AI assist; ClickUp markets the all-in-one positioning; Linear targets engineering teams with the cleanest issue-tracker UX; Notion AI bundles tasks into the broader knowledge-base workspace.',
  'We weighted: AI task-creation quality from natural language, dependency and timeline auto-management, integration with Slack and calendar, and pricing scale at team size.',
  '[
    {"q":"Linear vs Asana for tasks?","a":"Linear is engineering-first with sub-second performance, opinionated workflow, and deep GitHub integration; Asana is broader project management for cross-functional teams. Pure engineering ops: Linear. Cross-functional projects with marketing, ops, and engineering: Asana."},
    {"q":"Can AI auto-create tasks from meetings?","a":"Yes - Asana, Monday, and ClickUp all integrate with Fireflies, Otter, and Gong to extract action items from transcripts and create assigned tasks automatically. Accuracy is 80-90% on clearly stated commitments; vague references still need human triage."},
    {"q":"Best for solo founders?","a":"Notion AI bundles tasks into the same workspace as docs and databases; Linear is overkill for solo work but fits well as the team grows past 3-5. Todoist and ClickUp also serve solo-to-small-team well at zero or low cost."}
  ]'::jsonb, 'productivity', 'beginner', 3600,
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
