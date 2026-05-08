-- Phase 3 batch 9 of Task Taxonomy initiative (S131)
-- 13 mid-tail tasks pushing 493 -> 506 tasks (Phase 3 100% + 6 over-target).
-- Spread plan: dev 37 -> 38 (+1) and 12 other categories 38 -> 39 (+1 each).
-- Target post-batch: ALL 13 categories at 38-39, span 1 (or span 0 if dev gets +2).
-- Actual delivery: span 1 (dev=38, 12 categories=39).
-- Tier-A editorial cadence (3-sentence intro + 1-sentence methodology + 3 FAQs).
-- Defensive: no apostrophes, no contractions, no em-dashes, no quoted speech in JSON.
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- === CUSTOMER-SUCCESS (1) ===

-- 1. ai-for-customer-onboarding-checklists
(
  'ai-for-customer-onboarding-checklists', 'AI for Customer Onboarding Checklists', '✅',
  ARRAY['customer-success','customer-service'], ARRAY['vitally','gainsight','pendo','userpilot','planhat'], 3,
  'Customer onboarding checklists turn the fuzzy goal of getting users to first value into a sequence of concrete milestones tracked per account, per role, and per cohort. AI-augmented platforms now generate per-segment checklists from product analytics, surface stuck steps before a CSM notices the slowdown, and score account health based on checklist completion velocity. Vitally and Planhat lead modern PLG-friendly onboarding with strong checklist primitives; Gainsight pioneered enterprise-grade success plans; Pendo and Userpilot pair in-app guides with checklist tracking inside the product itself.',
  'Selection prioritized: per-segment checklist generation, stuck-step detection, in-app vs CSM-led delivery balance, and integration with product analytics plus customer 360 systems.',
  '[
    {"q":"What goes on a customer onboarding checklist?","a":"5 standard steps: (1) account setup and team invite, (2) connect the first integration that proves data flow, (3) complete the first key workflow end-to-end, (4) hit the first quantified value moment such as a report run or a ticket resolved, (5) schedule a 30-day check-in. Mature programs add segment-specific milestones so the checklist matches the actual user journey rather than a generic average."},
    {"q":"How does AI personalize the checklist?","a":"3 signals drive personalization: firmographic data sets the baseline checklist by industry and company size, first-session behavior signals which path to recommend based on which features the user touches, and the stated goal from the signup form locks in intent. The platform then serves a checklist that matches the user not the average. Done well this lifts checklist completion rate by 20 to 40 percent over a single static checklist."},
    {"q":"When does a checklist help vs hurt?","a":"Checklists help when the product has a clear path to value and the user can self-serve most steps. Checklists hurt when the path is ambiguous and requires consultative onboarding, or when the steps feel like busywork because a 12-step list for a simple SaaS feels patronizing. Best practice: 5 to 7 steps maximum per stage, each step under 5 minutes to complete, and a clear value framing for why each step matters."}
  ]'::jsonb, 'customer-success', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DATA-ANALYTICS (1) ===

-- 2. ai-for-revenue-dashboards
(
  'ai-for-revenue-dashboards', 'AI for Revenue Dashboards', '📊',
  ARRAY['data-analytics','analytics'], ARRAY['metabase','tableau','julius-ai','looker'], 3,
  'Revenue dashboards aggregate ARR, MRR, churn, expansion, and pipeline coverage into one view that finance, sales, and CS leaders consult weekly to decide where to invest the next dollar. AI-augmented BI platforms now generate the underlying SQL from a plain-language question, suggest follow-up cuts based on the metric the executive just viewed, and flag anomalies in pipeline coverage before the quarter slips. Metabase and Looker dominate self-serve BI for revenue teams; Tableau leads enterprise visualization with mature governance; Julius AI brings conversational analytics to spreadsheet-grade datasets.',
  'We weighted: SQL-from-natural-language accuracy on revenue schemas, anomaly-detection on pipeline coverage, drill-down conversation flow, and integration with CRM and billing systems.',
  '[
    {"q":"What metrics belong on a revenue dashboard?","a":"7 core metrics for a SaaS revenue dashboard: ARR or MRR with month-over-month delta, net new ARR split by new logo and expansion, gross and net revenue retention, pipeline coverage by stage and quarter, win rate by segment, average sales cycle, and CAC payback period. Mature dashboards layer in cohort retention curves and revenue concentration so the leadership team sees both top-line and risk in one screen."},
    {"q":"How does AI speed up dashboard work?","a":"3 ways: (1) plain-language to SQL turns a question like show pipeline coverage by quarter into a working query in under 10 seconds, (2) anomaly detection flags weeks where pipeline coverage drops below 3x without a manual alert rule, (3) auto-suggested follow-up cuts surface what the leader probably wants next based on the metric just viewed. Together these cut dashboard setup time by 50 to 70 percent."},
    {"q":"How accurate is AI-generated SQL on revenue data?","a":"Accuracy depends on schema clarity. Well-modeled warehouses with clear naming and dimensional models hit 80 to 90 percent first-shot accuracy on common revenue queries. Messy schemas with snake_case mixed with camelCase and ambiguous join keys drop to 40 to 60 percent. Best practice: model the warehouse with semantic layer tools first, then layer the AI on top so it queries clean abstractions not raw tables."}
  ]'::jsonb, 'data-analytics', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DESIGN (1) ===

-- 3. ai-for-ad-creatives
(
  'ai-for-ad-creatives', 'AI for Ad Creatives', '🎨',
  ARRAY['design','image-ai'], ARRAY['canva-ai','recraft-ai','ideogram','magnific','photoroom'], 3,
  'Ad creatives drive paid social and display performance more than any other lever once targeting is set, and modern marketing teams test 10 to 50 variants per campaign to find the winners. AI-augmented design platforms now generate hundreds of on-brand variants from a single prompt, swap product hero images into branded templates without manual cutout work, and upscale low-resolution source assets to platform-spec resolutions. Canva AI leads accessible drag-and-drop creative production at scale; Recraft and Ideogram excel at brand-consistent illustrations and typography; Magnific handles upscaling for print and high-res display; PhotoRoom dominates background removal and product photography for ecommerce.',
  'Selection prioritized: brand-consistency controls across variant generation, platform-spec output sizing, background-removal quality, and team-collaboration features for ad ops review.',
  '[
    {"q":"How many ad creative variants should I test?","a":"For paid social campaigns with budget above 5000 USD per month, test 10 to 20 variants per campaign across 2 to 3 angles (problem-first, social proof, product-feature). Below that budget, 5 to 8 variants is enough because statistical significance takes weeks to reach. AI generation makes the upper end practical because the variant cost drops from 50 USD per ad in agency fees to under 5 USD in tool spend."},
    {"q":"How does AI keep creatives on-brand?","a":"3 controls: (1) brand kits lock colors, fonts, and logo placement so generated variants stay in the visual system, (2) reference image conditioning forces new outputs to match the style of approved past creatives, (3) automated review flags variants that drift outside brand guidelines before they ship to ad platforms. Mature teams pair AI generation with a 2-minute human review per batch rather than letting variants auto-publish."},
    {"q":"What about copyright and AI-generated imagery?","a":"Use models with commercial-safe licenses (Adobe Firefly, Recraft, Canva AI all offer commercial use on paid tiers). Avoid generating brand mascots, celebrity likenesses, or copyrighted characters. Document the source and prompt for each shipped variant so the legal trail is clean. For high-stakes brand campaigns, prefer AI-assisted edits to human-shot or licensed-stock photography over fully synthetic hero imagery."}
  ]'::jsonb, 'design', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === DEV (1) ===

-- 4. ai-for-code-review
(
  'ai-for-code-review', 'AI for Code Review', '🔍',
  ARRAY['code-ai','dev'], ARRAY['cursor','aider','continue-dev'], 3,
  'Code review catches bugs, enforces style, and spreads knowledge across the team but consumes 10 to 30 percent of senior engineer time on busy repos. AI-augmented review tools now flag obvious issues before a human opens the PR, suggest fixes inline, and summarize complex diffs so the human reviewer focuses on architecture not nits. Cursor leads agentic IDE-side review with strong context awareness across the repo; Aider runs review and edit cycles directly from the terminal; Continue-dev offers an open-source IDE assistant with configurable model backends so teams can run review on local or self-hosted models for sensitive code.',
  'Selection prioritized: false-positive rate on lint-style issues, multi-file context handling, fix-suggestion quality, and ability to run on private repos with self-hosted or local models.',
  '[
    {"q":"What can AI review reliably catch?","a":"5 categories with high accuracy: lint and style violations, common bug patterns such as off-by-one and null-deref, missing test coverage on changed lines, security antipatterns such as hardcoded secrets or SQL injection, and dead code in the diff. Lower accuracy on architectural critiques and business-logic correctness because both require team context the model rarely has."},
    {"q":"Should AI review replace human review?","a":"No. AI review handles the mechanical layer (style, common bugs, missing tests) and frees human reviewers to focus on architecture, business-logic correctness, and knowledge transfer. Best practice: AI runs first as a precheck, surfaces a summary plus suggested fixes, then a human reviewer signs off on the architectural and business decisions. Most teams keep human review as the final gate for merge."},
    {"q":"How does AI review handle large diffs?","a":"3 strategies: (1) hierarchical summarization where the model summarizes each file then summarizes the file summaries into a PR-level digest, (2) selective deep-dive on files with the highest bug-likelihood scores, (3) reviewer-question answering where the human asks targeted questions about specific files rather than reading the whole diff. This makes 1000-line diffs tractable in 5 to 10 minutes vs the hour a fully manual read takes."}
  ]'::jsonb, 'dev', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === FINANCE (1) ===

-- 5. ai-for-invoice-management
(
  'ai-for-invoice-management', 'AI for Invoice Management', '🧾',
  ARRAY['finance','automation'], ARRAY['ramp','brex','tipalti','stampli','airbase'], 3,
  'Invoice management covers the AP cycle from receipt of a vendor invoice through approval routing, exception handling, payment scheduling, and reconciliation back to the GL. AI-augmented platforms now extract line items and tax codes from PDF and image invoices with 95-plus percent accuracy, route approvals based on amount and cost-center policy, and flag duplicate or fraudulent invoices before payment. Ramp and Brex bundle invoice automation with corporate card and expense workflows for high-growth startups; Tipalti dominates global mass payouts with multi-entity tax handling; Stampli pairs invoice OCR with collaborative approval threading; Airbase unifies invoice, card, and reimbursement spend in one ledger.',
  'We weighted: OCR accuracy on messy vendor PDFs, approval-routing flexibility, duplicate-detection precision, and integration with NetSuite or QuickBooks plus banking rails.',
  '[
    {"q":"What does AI actually automate in AP?","a":"5 manual steps collapse: (1) line-item extraction from PDF and image invoices replaces typing into the AP module, (2) GL-code suggestion based on vendor history replaces lookup-and-paste, (3) PO matching surfaces 3-way match exceptions instead of manual reconciliation, (4) approval routing fires the right approver chain by amount and cost center, (5) duplicate detection flags repeat invoices before payment. End-to-end this cuts AP cycle time by 50 to 70 percent and reduces processing cost per invoice from 15 USD to under 5 USD."},
    {"q":"How accurate is AI invoice extraction?","a":"Modern systems hit 95 to 98 percent line-item accuracy on standard vendor invoices once 100-plus invoices per vendor have trained the per-vendor template. New vendors run at 80 to 90 percent first-month accuracy with a learning curve. Best practice: configure the system to require human confirmation on the first 3 invoices per new vendor, then drop to exception-only review once the model has trained on the format."},
    {"q":"How does AI catch invoice fraud?","a":"4 fraud patterns get flagged: (1) duplicate invoice numbers across vendors, (2) amounts just under the human-approval threshold (a 4990 USD invoice when policy requires VP approval at 5000), (3) new vendors created shortly before invoice receipt with no PO history, (4) bank account changes on existing vendors that match phishing patterns. The system holds suspect invoices for human review rather than auto-approving."}
  ]'::jsonb, 'finance', 'intermediate', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === HR-RECRUITING (1) ===

-- 6. ai-for-employee-benefits
(
  'ai-for-employee-benefits', 'AI for Employee Benefits', '🏥',
  ARRAY['hr'], ARRAY['lattice','rippling','gusto','bamboohr','hibob'], 3,
  'Employee benefits administration covers health insurance, retirement, equity, time off, wellness stipends, and the open-enrollment cycle that consumes 100-plus HR hours every year at mid-size companies. AI-augmented HRIS platforms now answer benefits questions in plain language from policy docs, recommend plans based on family situation and historical usage, and surface enrollment exceptions before the deadline closes. Rippling and Gusto bundle benefits with payroll and HRIS in unified employee records; BambooHR and Hibob serve mid-market with strong self-service portals; Lattice pairs benefits visibility with performance and engagement workflows so managers see total comp context.',
  'Selection prioritized: benefits-question answering accuracy, plan-recommendation logic, open-enrollment exception detection, and payroll plus carrier integration depth.',
  '[
    {"q":"What benefits questions can AI answer reliably?","a":"4 high-accuracy categories: plan summary and coverage details from carrier SBC documents, dollar amounts for premiums and deductibles by plan, enrollment deadlines and life-event triggers that allow mid-year changes, and PTO balance plus carryover policy by employee type. Lower accuracy on edge cases such as out-of-network claim disputes or COBRA continuation rules where the answer depends on specific carrier and state regulations."},
    {"q":"How does AI help open-enrollment season?","a":"3 levers reduce the HR-team load: (1) plan-recommendation chat where employees describe their situation (single, married plus 2 kids, planning surgery) and the model suggests plan tiers ranked by total expected cost, (2) document Q-and-A so employees self-serve plan-doc questions instead of emailing HR, (3) exception alerts that flag employees who have not enrolled by week 2 of the 4-week window so HR can nudge before deadline. Together these cut the HR support ticket volume during enrollment by 40 to 60 percent."},
    {"q":"What about privacy with AI on benefits data?","a":"Benefits data includes PHI under HIPAA and family health context that is among the most sensitive employee data. 3 controls matter: (1) self-hosted or BAA-covered AI providers (most major vendors offer HIPAA BAAs on enterprise tiers), (2) data minimization where the model sees only the policy docs and the question, never the broader employee health record, (3) audit logs of every benefits Q-and-A so HR can spot inappropriate queries. Avoid consumer chatbots for any PHI-touching workflow."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === MARKETING (1) ===

-- 7. ai-for-event-promotion
(
  'ai-for-event-promotion', 'AI for Event Promotion', '🎪',
  ARRAY['marketing','email-marketing'], ARRAY['mailerlite','hubspot','omnisend','klaviyo','activecampaign'], 3,
  'Event promotion drives registrations and attendance for webinars, conferences, product launches, and field events through coordinated email, social, paid, and partner outreach over a 4 to 8 week pre-event window. AI-augmented marketing automation platforms now segment lists by likelihood to attend based on past engagement, generate subject-line variants tuned per audience, and time send windows by individual recipient open patterns. HubSpot leads B2B event marketing with mature CRM-tied workflows; Klaviyo and Omnisend dominate B2C ecommerce events with rich product-tied segmentation; ActiveCampaign and MailerLite serve SMB marketers with strong automation builders at lower price points.',
  'We weighted: registration-prediction accuracy by segment, subject-line variant testing depth, optimal-send-time per recipient, and integration with event platforms (Zoom, Hopin, Splash, Eventbrite).',
  '[
    {"q":"What is a realistic registration funnel for a webinar?","a":"Standard B2B SaaS benchmarks: 25 to 35 percent of opens click the registration link from a warm list, 50 to 70 percent of clicks complete registration, 30 to 50 percent of registrants attend live, and 25 to 40 percent watch the recording in the 7 days after. So 1000 promoted contacts becomes 250 opens, 75 clicks, 50 registrants, 20 to 25 live attendees, plus 8 to 12 recording views. Plan top-of-funnel volume backwards from the live-attendance target."},
    {"q":"How does AI lift event attendance?","a":"3 levers: (1) audience scoring predicts likelihood to attend so the team focuses paid promotion on segments with 30-plus percent expected attendance instead of broad blasts, (2) per-recipient send-time optimization lifts open rates by 10 to 25 percent over batch sends at one time of day, (3) reminder cadence personalization sends 1 reminder to high-engagement registrants and 3 to low-engagement ones. Together these lift live attendance by 15 to 30 percent on the same registered base."},
    {"q":"How do I measure event promotion ROI?","a":"3 metrics matter beyond attendance: cost per qualified attendee (paid spend plus tooling spend divided by attendees who match ICP), pipeline sourced (opportunities created within 30 days where the event was first or middle touch), and influenced revenue (closed-won deals where the event appears in the buying-committee touch history). Track these in the marketing automation platform tied to the CRM, not in the event platform alone."}
  ]'::jsonb, 'marketing', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === OPS (1) ===

-- 8. ai-for-vendor-scorecards
(
  'ai-for-vendor-scorecards', 'AI for Vendor Scorecards', '🛡️',
  ARRAY['ops'], ARRAY['vanta','drata','ironclad','aikido-security','secureframe'], 3,
  'Vendor scorecards rate third-party suppliers on security posture, contract terms, financial stability, and operational reliability so procurement and legal can decide which vendors to keep, expand, or replace. AI-augmented platforms now ingest SOC 2 reports plus security questionnaires automatically, score risk per vendor against a customizable rubric, and surface posture changes such as expired certifications before they breach the contract. Vanta and Drata lead automated security questionnaire and trust-center workflows; Secureframe pairs compliance automation with vendor risk management; Aikido-Security focuses on continuous security posture; Ironclad layers contract intelligence so legal can spot scorecard-relevant terms in the underlying agreements.',
  'Selection prioritized: SOC 2 plus questionnaire ingestion accuracy, scorecard customization depth, posture-change alerting timeliness, and integration with procurement and contract management systems.',
  '[
    {"q":"What goes on a vendor scorecard?","a":"5 standard dimensions: security posture (SOC 2 status, ISO 27001, penetration test recency), data privacy (subprocessor list, GDPR DPA in place, data residency), financial stability (years operating, last funding, burn signals from public sources), operational reliability (uptime SLA, historical incident frequency, status-page transparency), and contract terms (auto-renewal clause, termination notice period, liability cap). Each gets a score 1 to 5 with weighted overall."},
    {"q":"How does AI speed up vendor reviews?","a":"3 levers: (1) automated questionnaire ingestion parses SOC 2 reports and SIG questionnaires into structured fields rather than analysts reading 80-page PDFs, (2) posture-change alerts flag when a vendor certification expires or a new subprocessor appears so the scorecard stays current without a quarterly manual refresh, (3) similar-vendor comparison surfaces alternates ranked by scorecard fit when a vendor drops below threshold. Together these cut vendor-review time from 4 hours per vendor to under 30 minutes."},
    {"q":"How often should scorecards refresh?","a":"3 cadences depending on tier: critical vendors (those with PHI, payment data, or core production access) refresh quarterly with a full re-scoring; important vendors refresh semi-annually; routine vendors refresh annually or on contract renewal. Continuous monitoring (posture-change alerts) supplements but does not replace the periodic full review because some signals (financial health, contract terms) only update on cadence not in real time."}
  ]'::jsonb, 'ops', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === PRODUCTIVITY (1) ===

-- 9. ai-for-reading-summaries
(
  'ai-for-reading-summaries', 'AI for Reading Summaries', '📚',
  ARRAY['productivity','note-taking'], ARRAY['notion-ai','readwise','humata','mem-ai','chatpdf'], 3,
  'Reading summaries condense long-form content (books, research papers, industry reports, newsletters, and saved articles) into the 5 to 10 percent of words that carry the actionable insight. AI-augmented reading tools now generate per-chapter summaries with key quotes, surface the highlights from a reading list as a weekly digest, and answer specific questions about the source so the reader does not need to re-read the full document. Readwise pioneered the spaced-repetition reading workflow with strong highlight import; Notion AI and Mem AI bundle reading summaries with the broader knowledge base; Humata and ChatPDF specialize in PDF Q-and-A for research and document-heavy work.',
  'Selection prioritized: summary fidelity to source on long documents, highlight-import breadth across Kindle and web, question-answering accuracy with citation, and integration with note-taking and PKM systems.',
  '[
    {"q":"How accurate are AI book and article summaries?","a":"Quality varies by source length and structure. Well-structured nonfiction with clear chapters summarizes accurately at 90-plus percent fidelity to the original argument. Fiction, philosophy, and densely argued long-form (think The Sequences or 800-page treatises) lose nuance and cross-chapter connections. Best practice: use AI for the framework and key quotes, then read the chapters that hit your active question rather than relying on summary alone for important sources."},
    {"q":"How does AI handle question-answering on long PDFs?","a":"Modern tools chunk the document, embed each chunk, and at query time retrieve the 5 to 10 most relevant chunks before the language model writes the answer with citations to specific pages. Accuracy is high (85-plus percent on factual questions with clear answers in the source) and lower on inferential questions that require synthesizing across chapters. Tools that show citation pages let the reader verify the answer in 30 seconds rather than trusting blind."},
    {"q":"What workflow fits AI reading summaries best?","a":"3 patterns work: (1) skim-with-AI before deciding whether to deep-read where AI summary plus 5-minute scan replaces the 2-hour first read, (2) post-read consolidation where AI surfaces the highlights and quotes you saved into a note ready for review, (3) targeted Q-and-A on saved sources when a current project raises a specific question and the answer is buried in something you read 6 months ago. Combine all 3 for compound returns on reading time."}
  ]'::jsonb, 'productivity', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === RESEARCH (1) ===

-- 10. ai-for-interview-transcripts
(
  'ai-for-interview-transcripts', 'AI for Interview Transcripts', '🎙️',
  ARRAY['research','meeting-ai'], ARRAY['dovetail','descript','grain','fireflies-ai','otter-ai'], 3,
  'Interview transcripts capture the verbatim record of user interviews, expert calls, customer discovery sessions, and qualitative research so the team can revisit what people actually said rather than relying on note-taker memory. AI-augmented transcription platforms now achieve 95-plus percent word accuracy on clear audio, label speakers automatically, and tag themes across a corpus of dozens of interviews so insights surface beyond any single conversation. Otter and Fireflies dominate quick meeting-style transcription with strong real-time capture; Descript pairs transcription with editable audio and video for content workflows; Grain focuses on coachable highlights from sales and CS calls; Dovetail closes the loop by pairing transcripts with theme-tagging and insight repositories purpose-built for research teams.',
  'We weighted: word-error-rate on real-world audio, speaker-diarization accuracy, theme-tagging across multi-interview corpora, and integration with research repositories and CRM.',
  '[
    {"q":"How accurate is AI transcription in 2026?","a":"On clear audio with native speakers, top platforms hit 95 to 98 percent word accuracy. Accuracy drops on heavy accents (90 to 95 percent), speaker overlap (85 to 92 percent), industry jargon and proper nouns (sometimes below 90 percent on niche terms), and noisy recordings. Best practice: record with dedicated mics for each speaker rather than one room mic, name the speakers in the platform after the first session, and accept that 5 to 30 minutes of light cleanup per hour of audio is normal."},
    {"q":"How does AI tag themes across interviews?","a":"Modern research platforms cluster transcript excerpts by semantic similarity then surface clusters as candidate themes such as pricing-confusion or onboarding-friction. The researcher reviews the clusters, merges duplicates, splits over-broad themes, and labels each. The output is a theme-tagged corpus where the researcher can pull every quote about pricing across 20 interviews in seconds rather than re-reading transcripts. Mature tools also score theme prevalence by participant segment so the team sees which pains hit which user type."},
    {"q":"What about consent and confidentiality?","a":"3 controls matter: (1) get explicit recording consent at the start of every call and document it in the recording itself, (2) configure retention so transcripts auto-delete after the analysis window (90 to 180 days for most research), (3) restrict access to the transcript repository by role and by project so a stranger cannot scrape competitive intelligence. Avoid consumer transcription apps for any session covering trade secrets, salary discussions, or regulated user data."}
  ]'::jsonb, 'research', 'intermediate', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SALES (1) ===

-- 11. ai-for-quote-generation
(
  'ai-for-quote-generation', 'AI for Quote Generation', '📝',
  ARRAY['sales','crm-sales'], ARRAY['pandadoc','qwilr','dealhub','proposify','better-proposals'], 3,
  'Quote generation turns a discovery conversation into a priced, branded proposal that the buyer can sign within minutes rather than the days a manual back-and-forth takes. AI-augmented CPQ and proposal platforms now assemble pricing tables from product configuration rules, generate executive summaries from CRM context, and detect approval-required scenarios such as discount thresholds before the proposal goes out. PandaDoc dominates SMB and mid-market with the broadest template library and signature workflow; Qwilr leads on visual interactive proposals with embedded pricing toggles; DealHub serves enterprise with deep CPQ logic; Proposify and Better Proposals serve agencies and SMB sales teams with streamlined builders.',
  'Selection prioritized: pricing-rule depth (volume, tier, bundle, regional), proposal personalization from CRM context, e-signature workflow speed, and integration with CRM and billing systems.',
  '[
    {"q":"What is the difference between CPQ and proposal software?","a":"CPQ (configure-price-quote) handles the pricing math: product configuration, discount rules, approval routing, and ERP integration. Proposal software handles the buyer-facing document: design, narrative sections, e-signature, and engagement tracking. Many platforms now bundle both. Enterprise sales typically need standalone CPQ tied to ERP plus a proposal layer; SMB sales work fine with bundled tools where one platform does both modestly."},
    {"q":"How does AI speed up proposal creation?","a":"4 levers: (1) auto-fill pricing tables from CRM opportunity data so the rep does not retype the configured product, (2) generate executive-summary text from past similar deals plus this opportunity context, (3) detect non-standard terms such as deep discounts or unusual payment terms and route to approval before sending, (4) suggest add-ons based on similar customer purchases. Together these cut proposal turnaround from 2 to 4 days to under 2 hours."},
    {"q":"How do I keep AI-generated proposals on-brand?","a":"3 controls: (1) lock master templates so brand colors, fonts, and required sections cannot be edited per proposal, (2) maintain a clauses library so legal-approved language gets reused rather than regenerated each time, (3) review the first 5 AI-assisted proposals per rep so coaching catches voice drift early. Mature teams treat AI as the first draft generator and the rep as the editor not the typist."}
  ]'::jsonb, 'sales', 'intermediate', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === SUPPORT (1) ===

-- 12. ai-for-ticket-tagging
(
  'ai-for-ticket-tagging', 'AI for Ticket Tagging', '🏷️',
  ARRAY['customer-service'], ARRAY['gorgias','gladly','intercom','zoho-desk','forethought'], 3,
  'Ticket tagging classifies incoming support tickets by topic, severity, product area, and intent so the team can route to the right agent, measure category trends, and feed product about recurring pains. AI-augmented helpdesk platforms now auto-tag tickets at intake from ticket text and customer history with 85-plus percent accuracy, suggest macros based on the predicted intent, and surface tag-trend reports the support manager can act on weekly. Intercom and Gorgias dominate ecommerce and SaaS support with strong AI tagging baked into the workspace; Gladly and Zoho Desk serve mid-market and enterprise with omnichannel tagging across email, chat, voice, and social; Forethought specializes in deflection and tagging as a layer on top of existing helpdesks.',
  'Selection prioritized: tag-prediction accuracy on first message, customizable taxonomy depth, tag-trend reporting, and helpdesk integration breadth (Zendesk, Salesforce Service Cloud, Freshdesk).',
  '[
    {"q":"Why does ticket tagging matter?","a":"3 outcomes depend on good tags: (1) routing accuracy where billing tickets reach billing specialists not generalists, (2) trend reporting where the manager sees that pricing-confusion tickets jumped 40 percent last week so product can investigate, (3) macro suggestions where the agent gets a starting reply pre-populated based on the predicted intent. Without tags, support runs reactively per ticket and never compounds learnings into product or process improvements."},
    {"q":"How accurate is AI auto-tagging?","a":"Modern platforms hit 85 to 92 percent accuracy on top-level topic tags after 1000 to 5000 tagged historical tickets train the per-team model. Accuracy drops on multi-topic tickets where one ticket spans 2 to 3 categories, and on novel issue types the model has not seen. Best practice: keep the tag taxonomy under 30 top-level categories with 3 to 5 subcategories each, review 5 to 10 percent of auto-tagged tickets weekly, and retrain quarterly as the product changes."},
    {"q":"How should I structure a ticket tag taxonomy?","a":"3 layers work: (1) intent (question, bug, billing, feature-request), (2) product area (billing-portal, mobile-app, integrations, dashboard), (3) severity (sev-1 outage, sev-2 degraded, sev-3 routine). Avoid free-text tags because they fragment within weeks; use a controlled vocabulary the AI can predict reliably and the manager can report on. Audit the taxonomy every 2 quarters to retire dead tags and split overcrowded categories."}
  ]'::jsonb, 'support', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- === WRITING (1) ===

-- 13. ai-for-product-changelogs
(
  'ai-for-product-changelogs', 'AI for Product Changelogs', '📋',
  ARRAY['writing-ai','documentation'], ARRAY['document360','notion-ai','gitbook','slab','guru'], 3,
  'Product changelogs publish what shipped, what changed, and what was deprecated so users, customer success, and sales stay current on product reality without back-channeling to engineering. AI-augmented documentation platforms now draft changelog entries from PR titles and commit messages, group related changes into thematic releases, and tailor the same changelog into 3 audiences (developer, end-user, internal). Document360 leads dedicated knowledge-base and changelog publishing with strong release-notes templates; Notion AI bundles changelogs into the broader product wiki; GitBook serves developer-facing docs and changelogs; Slab and Guru cover internal release notes for CS and sales enablement.',
  'Selection prioritized: PR-to-changelog draft quality, audience-rewrite (developer vs end-user vs internal) capability, release grouping logic, and integration with GitHub or Linear for source-of-truth linking.',
  '[
    {"q":"What goes in a good product changelog entry?","a":"4 elements per release: (1) what changed in plain language (not a copy-paste of the PR title), (2) why it matters to the user (the user-visible benefit not the implementation detail), (3) any required user action (migration steps, settings to flip, deprecated APIs), (4) link to deeper docs or the underlying PR for users who want detail. Group entries by feature area and tag them by release type (feature, fix, breaking, security)."},
    {"q":"How does AI draft changelog entries?","a":"3 inputs feed the draft: (1) merged PR titles plus descriptions tell the model what shipped, (2) issue or ticket links provide the user-visible context, (3) past changelog entries set the voice and structure. The model drafts a first version per audience (developer, end-user, internal CS); the writer edits in 5 to 15 minutes per release rather than the 1 to 2 hours a from-scratch write takes. Best practice: keep the writer as final editor not just approver because raw AI output lacks the brand voice and selective omission a human applies."},
    {"q":"How often should product changelogs publish?","a":"3 cadences fit different products: (1) continuous (every shipped change appears within 24 hours) for B2B SaaS where users ask what is new constantly, (2) weekly digest where Friday roundups summarize the week for users who do not want a firehose, (3) monthly themed releases for enterprise products where customers want predictable upgrade windows. Hybrid is common: continuous internal log plus weekly external digest plus monthly executive summary."}
  ]'::jsonb, 'writing', 'beginner', 390,
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

-- Verify
SELECT category, COUNT(*) FROM tasks WHERE status='published' GROUP BY category ORDER BY category;
