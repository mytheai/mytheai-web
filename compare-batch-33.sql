-- compare-batch-33.sql
-- 5 comparison pairs: AI customer support tools (theme matches batch-33)
-- All pairs use tools confirmed in DB
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: chatwoot-vs-freshchat
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'chatwoot-vs-freshchat',
  'chatwoot',
  'freshchat',
  'Chatwoot vs Freshchat is the open-source self-hosted support platform against the AI-powered messaging product inside the Freshworks ecosystem. Chatwoot consolidates email, live chat, social media, WhatsApp, and SMS into a single agent inbox with full data ownership for teams that self-host, or a competitive cloud pricing model for those who prefer managed hosting. Freshchat is a messaging-first support tool with Freddy AI handling Tier-1 conversations autonomously, routing intelligently, and escalating to agents with full context. Freshchat integrates natively with Freshdesk, Freshsales, and Freshservice, making it the natural choice for teams already inside the Freshworks ecosystem. Chatwoot wins on data control, pricing at scale with self-hosting, and open-source flexibility. Freshchat wins on AI automation depth, native ecosystem integration, and the operational confidence of a proven commercial product backed by a large vendor. The decision typically comes down to infrastructure philosophy: teams that want full ownership and are comfortable managing their own instance will favour Chatwoot, while teams that want managed AI-powered support with minimal setup will favour Freshchat.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'chatwoot-vs-freshchat', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('AI automation and autonomous resolution', 3, 5, 'Freshchat''s Freddy AI handles Tier-1 conversations autonomously, detects intent, routes automatically, and escalates with full context. Chatwoot''s AI features include response suggestions and conversation summarisation but do not offer the same level of autonomous resolution.'),
  ('Data ownership and self-hosting', 5, 1, 'Chatwoot can be fully self-hosted on any infrastructure, giving teams complete data ownership and the ability to customise the platform. Freshchat is a cloud-only SaaS product with no self-hosting option.'),
  ('Pricing at scale', 5, 3, 'Chatwoot self-hosted has no per-seat cost beyond infrastructure. The hosted Chatwoot Cloud plan is competitive. Freshchat''s AI features require higher-tier plans, and costs scale with seat count. For teams over 30 agents, self-hosted Chatwoot can be dramatically cheaper.'),
  ('Freshworks ecosystem integration', 1, 5, 'Freshchat integrates natively with Freshdesk (ticketing), Freshsales (CRM), and Freshservice (IT support) as part of a unified product suite. Chatwoot has its own integration library but does not offer the same native Freshworks ecosystem depth.'),
  ('Multi-channel support coverage', 4, 4, 'Both platforms support email, live chat, WhatsApp, and social media channels. Chatwoot supports a broader range of social and messaging channels. Freshchat focuses more on web chat, mobile, and messaging apps. Coverage is comparable for most use cases.'),
  ('Chatbot builder and no-code automation', 3, 4, 'Freshchat includes a no-code bot builder for creating automated conversation flows without engineering involvement. Chatwoot supports automation rules and basic workflows but the bot building experience requires more technical setup.'),
  ('Setup and time to value', 3, 5, 'Freshchat is up and running in minutes with no infrastructure management. Chatwoot self-hosting requires server setup and maintenance. Chatwoot Cloud reduces this barrier but Freshchat remains faster to start for most teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatwoot-vs-freshchat')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'chatwoot-vs-freshchat');

-- Pair 2: kustomer-vs-gorgias
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'kustomer-vs-gorgias',
  'kustomer',
  'gorgias',
  'Kustomer vs Gorgias is the enterprise AI CRM against the e-commerce-specialised helpdesk - a comparison that is essentially a choice of depth versus fit. Both platforms are designed for high-volume support operations in commerce-oriented businesses, but they approach the problem differently. Kustomer organises all customer data and interaction history into a unified customer timeline, acquired by Meta in 2023, with deep omnichannel messaging capabilities, AI-powered intent detection, and sophisticated routing. It is built for enterprise teams running complex, multi-team support operations across many channels. Gorgias is purpose-built for Shopify merchants: every ticket shows the customer''s order history, cart contents, and recent interactions. The most common support actions (issue refunds, cancel orders, update addresses) can be done directly from the ticket without switching tabs. The AI features focus on e-commerce-specific resolution: automating order status queries, returns, and shipping questions. For DTC e-commerce brands on Shopify and similar platforms, Gorgias wins on speed, e-commerce context, and platform fit. For enterprise teams with complex omnichannel requirements that extend beyond e-commerce, Kustomer provides greater flexibility and depth.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'kustomer-vs-gorgias', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('E-commerce platform integration depth', 3, 5, 'Gorgias integrates with Shopify, BigCommerce, Magento, and WooCommerce at a native level - agents see order history, cart status, and can execute order actions directly from the ticket. Kustomer integrates with Shopify and Recharge but the e-commerce actions are less native than Gorgias.'),
  ('Customer timeline and unified data view', 5, 3, 'Kustomer''s unified customer timeline aggregates all interactions, purchases, and touchpoints into a single profile view. Gorgias shows order history within the ticket but is not designed as a full CRM with a complete customer timeline.'),
  ('AI automation for support resolution', 4, 4, 'Kustomer''s AI handles intent detection, routing, and response suggestions across all channels. Gorgias''s AI automation is optimised specifically for e-commerce queries - order status, returns, shipping - and automates these high-frequency cases at high accuracy. Both deliver strong automation for their target use cases.'),
  ('Omnichannel messaging coverage', 5, 3, 'Kustomer supports voice, email, chat, WhatsApp, SMS, social media, and messaging apps with unified routing. Gorgias focuses on the channels most relevant to e-commerce: email, chat, Instagram, Facebook, and SMS. Coverage is sufficient for most DTC brands.'),
  ('Pricing accessibility for SMB teams', 3, 4, 'Gorgias pricing is based on ticket volume rather than seat count, which works well for e-commerce brands with variable support load. Kustomer starts at $89/user/month, making it expensive for smaller teams. Gorgias is more accessible for DTC brands under 50-agent headcount.'),
  ('Enterprise scalability and compliance', 5, 3, 'Kustomer is designed for large enterprise support operations with sophisticated routing, multi-team workflows, and enterprise security. Gorgias scales well within e-commerce contexts but is less suited to complex enterprise-level governance requirements.'),
  ('Reporting and support analytics', 4, 4, 'Both platforms offer solid reporting on agent performance, resolution time, and channel volume. Kustomer''s cross-channel reporting is more sophisticated for multi-team operations. Gorgias''s revenue-per-ticket and conversion tracking are uniquely valuable for e-commerce.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'kustomer-vs-gorgias')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'kustomer-vs-gorgias');

-- Pair 3: plain-vs-helpscout
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'plain-vs-helpscout',
  'plain',
  'helpscout',
  'Plain vs Help Scout compares two helpdesks that both reject the heavyweight complexity of Zendesk and Freshdesk, but have arrived at different points on the spectrum. Help Scout is a human-first support platform used by thousands of SaaS companies and startups: a clean shared inbox, a knowledge base builder, live chat, and AI-assisted responses in a polished package. It is the most common choice for growing SaaS businesses that want professional support tooling without enterprise complexity. Plain takes a more radical position: it is built from first principles for developer-facing and engineering-led businesses. Support is organised around the customer rather than the ticket, with a full timeline of interactions pulled from GitHub, Stripe, and Segment. The Slack integration routes issues from developer community channels directly into Plain without a separate ticketing layer. Plain is intentionally narrow in scope - it does not try to be a CRM or a marketing tool. For B2B SaaS and developer tool companies where support is genuinely an extension of the product team, Plain provides an approach that Help Scout cannot match. For everything else - consumer apps, e-commerce, and teams that want a reliable, broad-feature helpdesk - Help Scout is the safer choice.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'plain-vs-helpscout', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Developer tool integrations (GitHub, Stripe, Segment)', 5, 2, 'Plain integrates natively with GitHub (issues, PRs), Stripe (subscription data), and Segment (user events), surfacing full customer context inside every support thread. Help Scout has integrations with Stripe and some developer tools but the depth of developer-facing context is not comparable.'),
  ('Shared inbox and team workflow features', 3, 5, 'Help Scout''s shared inbox is one of the most polished in the category - with canned responses, tags, collision detection, and detailed reporting. Plain''s inbox is clean but newer and less feature-complete for teams with complex routing and workflow requirements.'),
  ('Knowledge base and self-service', 2, 5, 'Help Scout Docs is a mature knowledge base builder with a clean public-facing portal, AI-powered article suggestions, and SEO-optimised output. Plain does not include a knowledge base builder - it is focused on reactive support, not proactive self-service.'),
  ('Slack-native routing for developer communities', 5, 1, 'Plain''s Slack integration routes messages from developer community Slack workspaces directly into the support inbox without requiring customers to leave Slack. Help Scout does not offer equivalent Slack-native routing for incoming support.'),
  ('AI-assisted responses and automation', 3, 4, 'Help Scout''s AI drafts replies, summarises long threads, and suggests relevant knowledge base articles. Plain includes thread summarisation and AI-suggested responses but the AI feature set is less mature than Help Scout''s.'),
  ('Setup and time to value', 4, 5, 'Help Scout is one of the fastest helpdesks to set up - teams are routing tickets within an hour. Plain requires setting up API integrations to surface meaningful customer context, which adds setup time for non-technical teams.'),
  ('Pricing for small teams', 3, 4, 'Help Scout starts at $20/user/month with a generous free trial. Plain offers a free tier for small teams but lacks Help Scout''s breadth of features at comparable price points. For teams under 5 agents, Help Scout typically delivers more at similar cost.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'plain-vs-helpscout')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'plain-vs-helpscout');

-- Pair 4: sprinklr-vs-hootsuite
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'sprinklr-vs-hootsuite',
  'sprinklr',
  'hootsuite',
  'Sprinklr vs Hootsuite compares the enterprise unified CX platform against the leading social media management suite - a comparison that is partly about feature overlap and partly about whether an organisation needs social media management or a unified customer experience intelligence platform. Hootsuite is the go-to social media management tool for marketing teams: scheduling, publishing, monitoring, analytics, and team workflows across all major social networks in a single dashboard. It is a known, trusted, and widely adopted tool with a large partner and integration ecosystem. Sprinklr is a different category of product. It consolidates social media management, customer service, marketing, advertising, and research into a single AI-powered platform used by over 1,000 global enterprises. Sprinklr is not competing with Hootsuite for the typical marketing team - it is competing for the budget of large organisations that currently use multiple specialist platforms and want to consolidate. For mid-market and enterprise teams whose customer service, social marketing, and brand research currently run on separate tools with separate contracts and separate data silos, Sprinklr makes a compelling consolidation case. For marketing teams that primarily need social publishing, monitoring, and analytics, Hootsuite delivers what is needed at a fraction of Sprinklr''s cost and implementation complexity.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sprinklr-vs-hootsuite', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Social publishing and scheduling', 4, 5, 'Hootsuite''s publishing and scheduling tools are mature, reliable, and support all major platforms with a clean team approval workflow. Sprinklr''s publishing is powerful and enterprise-grade but more complex to set up. Hootsuite wins for teams that primarily need publishing workflows.'),
  ('Customer service and social care', 5, 2, 'Sprinklr unifies social customer service with its core CX platform - routing social mentions and DMs to service agents alongside other channels. Hootsuite has customer care workflows but they are add-on features rather than a core product capability.'),
  ('AI capabilities across the platform', 5, 3, 'Sprinklr AI+ automates content generation, case routing, response suggestions, and sentiment analysis across 35+ channels. Hootsuite''s AI features include content ideas, auto-scheduling optimisation, and basic sentiment monitoring, but are less extensive.'),
  ('Enterprise security and governance', 5, 3, 'Sprinklr is built for enterprises with strict compliance requirements: SOC 2, GDPR, custom data residency, role-based permissions, and audit logging across all activity. Hootsuite has enterprise plans with SSO and basic compliance features, but less depth than Sprinklr.'),
  ('Pricing and accessibility', 1, 4, 'Sprinklr pricing starts at $199/seat/month and scales to custom enterprise contracts - inaccessible for most SMB and mid-market teams. Hootsuite is significantly more affordable and offers plans that work for teams of 5 to 500+.'),
  ('Analytics and brand intelligence', 5, 4, 'Sprinklr''s research and listening tools aggregate data across social, news, forums, and review sites for brand intelligence at an enterprise level. Hootsuite Analytics is solid for social performance measurement but does not match Sprinklr''s breadth of data sources.'),
  ('Implementation complexity and time to value', 2, 5, 'Hootsuite teams are publishing within days. Sprinklr implementations require a dedicated onboarding process, often with professional services involvement, and can take weeks to months to configure for complex enterprise use cases.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sprinklr-vs-hootsuite')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sprinklr-vs-hootsuite');

-- Pair 5: forethought-vs-intercom
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'forethought-vs-intercom',
  'forethought',
  'intercom',
  'Forethought vs Intercom is a fundamentally different kind of comparison: Forethought is an AI automation layer that sits on top of existing helpdesks (Zendesk, Salesforce, ServiceNow), while Intercom is a complete customer communications platform that includes its own messenger, inbox, knowledge base, and AI agent. Teams choosing between them are making a decision about platform strategy as much as features. Forethought is for teams already invested in an enterprise helpdesk who want to add generative AI automation on top without migrating. Its Solve product handles Tier-1 queries autonomously, Triage classifies and routes incoming tickets intelligently, and Assist surfaces relevant knowledge for agents handling complex issues. There is no platform migration required. Intercom is for teams that want a single platform for all customer communications - from initial website engagement and onboarding to support, retention, and proactive messaging. Fin AI, Intercom''s AI agent, handles support queries autonomously across all channels. The combined platform is particularly powerful for product-led growth companies where the same tool manages sales chat, product onboarding, and customer support. Teams that are deeply embedded in Zendesk or Salesforce and want to enhance without migrating should evaluate Forethought. Teams that are building or rebuilding their customer communications stack from scratch should give Intercom serious consideration.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'forethought-vs-intercom', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('AI autonomous resolution of Tier-1 queries', 5, 5, 'Both platforms deliver strong AI-powered autonomous resolution. Forethought Solve uses generative AI trained on the support knowledge base to resolve common queries without agents. Intercom Fin AI does the same within its native messenger and across connected channels. The resolution quality is comparable - the difference is deployment architecture.'),
  ('Integration with existing helpdesks (Zendesk, Salesforce)', 5, 2, 'Forethought is designed specifically as a layer on top of Zendesk, Salesforce, and ServiceNow - it enhances the existing helpdesk without replacing it. Intercom has integrations with Zendesk and Salesforce but is designed to be the primary customer communications platform, not an enhancement layer.'),
  ('Complete customer communications platform', 2, 5, 'Intercom provides a complete platform: in-product messenger, proactive messaging, product tours, help centre, AI agent, and shared inbox in one. Forethought is an AI layer for support - it does not provide a messenger, knowledge base, or proactive outreach capability.'),
  ('Knowledge gap analysis and content intelligence', 4, 3, 'Forethought''s Discover module analyses unresolved tickets to identify which topics the knowledge base does not cover well - enabling content teams to fill gaps proactively. Intercom surfaces topic trends and unresolved queries but the systematic gap analysis capability is less developed.'),
  ('Product-led growth and in-product messaging', 1, 5, 'Intercom is a dominant platform for product-led growth companies that use in-product messaging for onboarding, feature adoption, and retention campaigns. Forethought is a support-focused tool and does not provide in-product messaging or proactive outreach capabilities.'),
  ('Pricing transparency and accessibility', 2, 3, 'Neither platform publishes accessible pricing. Forethought requires custom enterprise pricing. Intercom publishes starting prices but advanced AI features require higher-tier plans. Both are positioned as enterprise or growth-stage products rather than SMB tools.'),
  ('Time to deploy AI automation', 4, 3, 'Forethought can be deployed on top of an existing Zendesk or Salesforce instance relatively quickly - the AI trains on existing knowledge base content. Intercom requires a fuller platform implementation if replacing an existing support tool, which adds deployment time.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'forethought-vs-intercom')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'forethought-vs-intercom');
