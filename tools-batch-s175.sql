-- S175 Mode B catalog expansion: 4 strong missing slugs to unlock peer-double potential.
-- Each pick passed S86 Tool Selection Quality Bar (Gate 1 operational HEAD probe + Gate 2 importance + Gate 3 catalog fit).
-- Peer-double targets confirmed live in catalog (calendly->cal-com, customer-io->mailchimp/klaviyo,
-- roam-research->anytype/tana, scite->elicit/consensus).
-- Idempotency: ON CONFLICT (slug) DO NOTHING. Safe to re-run.

INSERT INTO tools (
  slug, name, tagline, description, logo_url, website_url, affiliate_url,
  pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count,
  featured, trending, editor_pick, tags, pros, cons, use_cases, integrations,
  pricing_verified_at
) VALUES

-- 1. Calendly - market-leading scheduling tool, peer-double for cal-com S164
('calendly', 'Calendly', 'Polished scheduling automation used by sales teams, recruiters, and consultants.',
'Calendly is the scheduling link tool that defined the category since 2013. You share a personalized URL, others pick a slot from your live availability, and calendar invites with video conferencing links auto-create on Google Calendar, Outlook, or iCloud. The polish around availability rules, routing forms, round-robin assignment, group events, and payment collection via Stripe is what separates it from open-source alternatives like Cal.com. Free tier covers a single event type plus core calendar sync. Paid tiers run 10 to 20 USD per seat per month and unlock multiple event types, custom branding, advanced routing logic, team scheduling, and Salesforce or HubSpot CRM sync. For a non-technical sales rep, recruiter, or consultant who wants the cleanest scheduling experience without self-hosting, Calendly stays the default choice in 2026.',
'', 'https://calendly.com', 'https://calendly.com',
'freemium', true, 10, 4.7, 2300,
false, false, false,
ARRAY['productivity', 'ai-assistants'],
ARRAY['Market-leading polish on the booking flow', 'Deep calendar integrations with Google, Outlook, and iCloud', 'Payment collection built in via Stripe', 'Enterprise SSO and SAML on top tiers', 'Mobile apps for iOS and Android'],
ARRAY['Per-seat pricing escalates fast for larger teams', 'Closed-source lock-in vs Cal.com self-host option', 'Advanced routing logic gated behind the Teams plan', 'Custom branding starts at the Standard tier only'],
ARRAY['Sales discovery calls with prospects', 'Recruiter screening interviews', 'Consultant office hours and client check-ins', 'Customer onboarding kickoff meetings', 'Internal team round-robin support shifts'],
ARRAY['google', 'calendar', 'slack', 'zapier', 'salesforce', 'hubspot', 'microsoft-365', 'intercom', 'gmail', 'stripe'],
'2026-05-17 00:00:00+00'),

-- 2. Customer.io - lifecycle messaging for B2B SaaS, peer-double for mailchimp/klaviyo S164
('customer-io', 'Customer.io', 'Lifecycle messaging platform built around product events, used by SaaS leaders.',
'Customer.io is the lifecycle marketing automation platform that SaaS companies like Notion, Linear, Loom, and Calendly use when they outgrow Mailchimp consumer features and want event-data-driven campaigns instead. The core idea is that messages trigger on product behavior, not just on email lists. You stream events from your app (signup, feature used, plan upgraded, trial ending) and the visual Journeys workflow builder fires email, in-app message, push notification, or SMS based on segment rules and time delays. Real-time data warehouse sync with Snowflake or BigQuery means marketers and product analysts work off the same numbers. Pricing starts at 100 USD per month on the Essentials tier (5,000 profiles) and scales by profile count and channel volume. For a B2B SaaS founder who needs onboarding, churn, and product-led growth flows in one tool, Customer.io is the standard pick in 2026.',
'', 'https://customer.io', 'https://customer.io',
'paid', false, 100, 4.5, 900,
false, false, false,
ARRAY['automation', 'crm-sales'],
ARRAY['Event-data-driven triggers (not just email list segmentation)', 'Multi-channel from one workflow: email, in-app, push, SMS', 'Visual Journeys builder is genuinely usable by non-engineers', 'Real-time data warehouse sync with Snowflake and BigQuery', 'Used by best-in-class SaaS teams (Notion, Linear, Loom)'],
ARRAY['Higher entry price (100 USD/month) vs Mailchimp or Klaviyo free tiers', 'Learning curve steeper than basic email marketing tools', 'B2C and ecommerce features less mature than Klaviyo', 'Setup requires engineering time to stream product events'],
ARRAY['SaaS onboarding flows triggered by user actions', 'Churn-prevention campaigns based on dropping product usage', 'Product-led growth nurture for self-serve trials', 'In-app messaging tied to feature adoption', 'Behavioral segmentation across the customer lifecycle'],
ARRAY['shopify', 'segment', 'salesforce', 'slack', 'zapier', 'hubspot', 'stripe'],
'2026-05-17 00:00:00+00'),

-- 3. Roam Research - networked-thought notes pioneer, peer-double for anytype/tana
('roam-research', 'Roam Research', 'The bidirectional-linked notes app that started the second-brain movement.',
'Roam Research is the networked-thought notes tool that popularized bidirectional linking and the broader second-brain movement in 2020 and 2021. Every note becomes a node in your personal knowledge graph: you write double-bracket wikilinks to other notes, the backlinks panel shows every place this note is referenced, and block references let you embed any individual block from any page without copy-paste duplication. The daily notes page is the default starting point each day, so journaling and atomic capture happen in one stream. Roam has a cult following among researchers, academic writers, lifelong learners, and founders who build deep knowledge graphs over years. The tradeoff in 2026 is steep: web-only with no native desktop app, no full offline mode, history of outages in 2021 and 2022, and the rise of Obsidian (free + local-first) and Logseq (open-source) cut into the customer base. Pricing is 15 USD per month or 165 USD per year, no free tier, just a 31-day trial.',
'', 'https://roamresearch.com', 'https://roamresearch.com',
'paid', false, 15, 4.3, 650,
false, false, false,
ARRAY['productivity'],
ARRAY['Bidirectional linking is genuinely powerful for cumulative research', 'Block references compose ideas atomically without copy-paste', 'Daily notes structure encourages consistent capture habit', 'Query language surfaces unexpected connections in your graph', 'Large Roamcult community shares workflows and templates'],
ARRAY['Web-only with no native desktop or full offline mode', 'Price tag of 15 USD/month with no free tier and a 31-day trial only', 'History of outages in 2021 and 2022 hurt the trust signal', 'Steep learning curve relative to Obsidian or Notion', 'Obsidian (free, local-first) and Logseq surpassed Roam on shipping velocity'],
ARRAY['Academic literature review with linked citations', 'Long-running research notebooks for writers and researchers', 'Daily journaling with automatic backlink-driven recall', 'Personal knowledge management for consultants and founders', 'Building structured second-brain workflows over years'],
ARRAY['google', 'zapier'],
'2026-05-17 00:00:00+00'),

-- 4. scite - smart citations for evidence-based research, peer-double for elicit/consensus S172
('scite', 'scite',
'Smart citations that classify whether papers support, contradict, or mention each other.',
'scite is the research AI tool that classifies every citation between scientific papers as supporting, contradicting, or just mentioning the cited claim. The flagship Smart Citations index covers more than 1.2 billion citations across 35 million papers, so for any paper you can see at a glance how the field has actually responded to its conclusions, not just how often it has been cited. The Assistant feature layers a GPT-style chat over the full-text paper corpus, letting you ask grounded questions like "what does the recent literature say about adolescent SSRI safety" and get answers with inline source links and contradiction flags. scite was a Y Combinator startup acquired by Research Solutions in 2023 and continues to ship steadily. Pricing is freemium: free tier with limited Assistant queries, Pro at 20 USD per month, plus institutional and team plans. For literature reviews where understanding agreement vs disagreement across studies matters more than raw citation counts, scite is the differentiated pick vs Elicit (literature review AI) and Consensus (Q&A across papers).',
'', 'https://scite.ai', 'https://scite.ai',
'freemium', true, 20, 4.4, 250,
false, false, false,
ARRAY['research', 'ai-assistants'],
ARRAY['Only tool that classifies citations as support, dispute, or mention', '1.2 billion-plus smart citations across 35 million papers', 'Assistant feature chats over full-text paper corpus with inline sources', 'Institutional access via Shibboleth and OpenAthens single sign-on', 'Custom dashboards for tracking citations to your own work or topic'],
ARRAY['Free tier severely limited (small Assistant query cap)', 'Assistant slower than Elicit or Consensus on long literature review tasks', 'Smaller paper corpus than Google Scholar', '20 USD/month pricing is niche vs free Scholar alternatives', 'Some classifications still benefit from manual review'],
ARRAY['Literature review with contradiction detection across studies', 'Fact-checking scientific claims for journalism and policy', 'Evidence-based medicine and clinical decision support', 'Dissertation citation hygiene and gap analysis', 'Systematic review prep for academic research teams'],
ARRAY['google', 'zapier'],
'2026-05-17 00:00:00+00')

ON CONFLICT (slug) DO NOTHING;

-- Post-INSERT verification: confirm 4 new slugs landed
SELECT slug, name, rating, review_count, pricing_type
FROM tools
WHERE slug IN ('calendly', 'customer-io', 'roam-research', 'scite')
ORDER BY slug;
