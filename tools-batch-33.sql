-- tools-batch-33.sql
-- 10 AI customer success and support operations tools
-- Target: DB ~352 -> ~362 tools
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

INSERT INTO tools (
  slug, name, tagline, description, logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick, pros, cons, use_cases
) VALUES

('chatwoot',
 'Chatwoot',
 'Open-source customer support platform for modern teams',
 'Chatwoot is an open-source customer support platform that consolidates conversations from email, live chat, social media, WhatsApp, and SMS into a single agent inbox. It is a self-hostable alternative to Intercom and Zendesk that gives teams full data ownership and the ability to customise the platform to their exact workflow. The AI features include AI-powered response suggestions, conversation summarisation, and automated labelling and routing. Chatwoot supports team inboxes, canned responses, conversation assignments, and detailed reporting. The hosted cloud version removes the infrastructure burden while still offering competitive pricing versus enterprise helpdesks. For engineering-led companies that want a full-featured support platform without vendor lock-in or per-seat pricing at scale, Chatwoot is one of the most compelling open-source options available. The active community contributes integrations and improvements regularly.',
 'https://www.google.com/s2/favicons?domain=chatwoot.com&sz=64',
 'https://chatwoot.com', 'https://go.mytheai.com/chatwoot',
 ARRAY['customer-support', 'team-collaboration', 'productivity'],
 'freemium', true, 0.00,
 4.2, 634, false, false, false,
 ARRAY['Open-source with self-hosting for full data control', 'Consolidates all support channels into one inbox', 'Active community with regular updates and integrations'],
 ARRAY['Self-hosting requires technical infrastructure setup', 'AI features less developed than closed-source competitors', 'Smaller integration library than Zendesk or Freshdesk'],
 ARRAY['Multi-channel support inbox for growing teams', 'Self-hosted customer support for privacy-conscious organisations', 'Open-source alternative to expensive enterprise helpdesks']
),

('kustomer',
 'Kustomer',
 'AI-powered CRM platform for high-volume customer service',
 'Kustomer is a customer service CRM platform designed for high-volume support operations. Unlike traditional ticketing systems that treat each support interaction as an isolated ticket, Kustomer organises all customer data and conversation history into a unified customer timeline - giving agents complete context before they reply. The AI features include automated intent detection, intelligent routing, conversation summaries, and AI-suggested responses. Kustomer was acquired by Meta in 2023 and has deepened its omnichannel capabilities particularly around messaging channels. The platform is built for e-commerce, retail, and consumer tech teams that handle thousands of interactions per day and need to balance automation with personalised service. Kustomer integrates with Shopify, Recharge, Klaviyo, and major logistics providers, making it a natural fit for DTC brands managing post-purchase support at scale.',
 'https://www.google.com/s2/favicons?domain=kustomer.com&sz=64',
 'https://kustomer.com', 'https://go.mytheai.com/kustomer',
 ARRAY['customer-support', 'operations', 'ai-assistants'],
 'paid', false, 89.00,
 4.2, 478, false, false, false,
 ARRAY['Unified customer timeline gives agents full context', 'Strong omnichannel messaging including WhatsApp and SMS', 'Deep e-commerce integrations for DTC support operations'],
 ARRAY['Premium pricing makes it expensive for smaller teams', 'Implementation complexity requires dedicated setup time', 'Overkill for teams with low support volume'],
 ARRAY['High-volume e-commerce customer service operations', 'DTC brands managing post-purchase support at scale', 'Omnichannel support with unified customer data']
),

('re-amaze',
 'Re:amaze',
 'Helpdesk and live chat designed for e-commerce brands',
 'Re:amaze is a customer support platform built specifically for e-commerce and online businesses. It combines live chat, email, SMS, social media, and push notifications in a single helpdesk, with deep integrations into Shopify, BigCommerce, WooCommerce, and other e-commerce platforms. Agents can see the customer order history, cart status, and previous interactions directly inside the conversation view without switching tabs. The AI features include a chatbot builder for handling common e-commerce questions (order status, returns, shipping), AI-generated response suggestions, and automated workflow routing. Re:amaze is positioned as an accessible alternative to Gorgias for e-commerce teams - offering similar e-commerce context within the support interface at a competitive price point. The canned response library and satisfaction survey tools are well-designed for teams that need quick deployment without a lengthy implementation process.',
 'https://www.google.com/s2/favicons?domain=reamaze.com&sz=64',
 'https://reamaze.com', 'https://go.mytheai.com/re-amaze',
 ARRAY['customer-support', 'operations', 'productivity'],
 'paid', false, 29.00,
 4.1, 389, false, false, false,
 ARRAY['E-commerce context (orders, cart) visible inside every conversation', 'Accessible pricing compared to Gorgias for similar features', 'Chatbot builder handles common order questions automatically'],
 ARRAY['Less powerful AI than enterprise competitors', 'Integration depth with non-e-commerce tools is limited', 'Reporting features less advanced than Zendesk or Freshdesk'],
 ARRAY['E-commerce brand customer support operations', 'Shopify and WooCommerce store helpdesk', 'Small to mid-size DTC team live chat and email support']
),

('dixa',
 'Dixa',
 'Conversational customer service platform for modern support teams',
 'Dixa is a customer service platform that treats every support interaction as a conversation rather than a ticket. The platform unifies voice, email, chat, and messaging channels into a single agent interface, with intelligent routing that matches incoming conversations to the right agent based on skills, availability, and customer priority. The AI capabilities include Dixa Mim, an AI assistant that suggests responses, summarises conversation history, and automates resolution of routine enquiries. Dixa also includes a native knowledge base that integrates with AI to surface relevant articles automatically. The platform is particularly strong on voice - the built-in phone system is a genuine alternative to separate telephony tools. Dixa targets mid-market and enterprise customer service teams that need to consolidate channels, automate intelligently, and measure performance with detailed analytics. The platform is popular in Nordic markets and growing across Europe.',
 'https://www.google.com/s2/favicons?domain=dixa.com&sz=64',
 'https://dixa.com', 'https://go.mytheai.com/dixa',
 ARRAY['customer-support', 'operations', 'voice-audio'],
 'paid', false, 49.00,
 4.2, 312, false, false, false,
 ARRAY['Built-in voice telephony removes need for separate phone system', 'AI Mim assistant handles routine resolutions automatically', 'Intelligent skills-based routing improves first-contact resolution'],
 ARRAY['Higher starting price than SMB-focused alternatives', 'Implementation requires dedicated onboarding time', 'Less established in North American markets than Zendesk or Intercom'],
 ARRAY['Unified omnichannel support with built-in telephony', 'Mid-market teams consolidating voice, email, and chat', 'AI-automated customer service with skills-based routing']
),

('freshchat',
 'Freshchat',
 'AI-powered messaging support for customer-first teams',
 'Freshchat is the messaging and live chat product within the Freshworks suite, designed to handle customer conversations across web, mobile, WhatsApp, Instagram, Telegram, and email in a unified interface. The AI features include Freddy AI, which handles Tier-1 support conversations autonomously, suggests responses for agents, auto-routes based on intent, and escalates to human agents when needed. Freshchat integrates natively with Freshdesk (ticketing), Freshsales (CRM), and Freshservice (IT support), making it a natural choice for teams already in the Freshworks ecosystem. The bot builder allows no-code chatbot creation for common support flows. For teams that want messaging-first support with AI automation at a price point below enterprise alternatives, Freshchat delivers a strong feature set. The free plan supports up to 10 agents, making it accessible for small teams to start without commitment.',
 'https://www.google.com/s2/favicons?domain=freshchat.com&sz=64',
 'https://freshchat.com', 'https://go.mytheai.com/freshchat',
 ARRAY['customer-support', 'ai-assistants', 'productivity'],
 'freemium', true, 15.00,
 4.1, 567, false, false, false,
 ARRAY['Freddy AI handles Tier-1 support autonomously', 'Native integration with Freshdesk, Freshsales, and Freshservice', 'Generous free plan for up to 10 agents'],
 ARRAY['AI features require higher-tier plans to unlock fully', 'Less powerful than Intercom for product-led growth use cases', 'Freshworks ecosystem lock-in if using multiple products'],
 ARRAY['Messaging-first customer support with AI automation', 'Teams already using Freshworks products', 'Multi-channel chat support across web, mobile, and social']
),

('sprinklr',
 'Sprinklr',
 'Unified customer experience management for enterprise teams',
 'Sprinklr is an enterprise CX management platform that consolidates social media management, customer service, marketing, and research into a single unified platform. The AI capabilities are extensive: Sprinklr AI+ uses generative AI to automate case routing, suggest agent responses, summarise long conversations, generate social content, and power self-service chatbots. The platform supports over 35 digital channels including all major social networks, messaging apps, and traditional email and voice. Sprinklr is one of the few platforms that genuinely unifies customer-facing marketing and customer service data, giving enterprises a complete view of customer sentiment across owned, earned, and support channels. The platform is used by over 1,000 global enterprises including Microsoft, Coca-Cola, and Samsung. The implementation complexity and price point reflect the enterprise positioning.',
 'https://www.google.com/s2/favicons?domain=sprinklr.com&sz=64',
 'https://sprinklr.com', 'https://go.mytheai.com/sprinklr',
 ARRAY['customer-support', 'seo-marketing', 'operations'],
 'paid', false, 199.00,
 4.1, 892, false, false, false,
 ARRAY['Unifies marketing, support, and research in one enterprise platform', 'AI+ automates routing, responses, and content across 35+ channels', 'Enterprise-grade security, compliance, and data governance'],
 ARRAY['Significant implementation complexity and onboarding time', 'Enterprise pricing makes it inaccessible for SMBs', 'Feature breadth can create complexity for focused use cases'],
 ARRAY['Enterprise omnichannel customer experience management', 'Social media customer service at global scale', 'Unified brand and support operations for large organisations']
),

('forethought',
 'Forethought',
 'AI resolution platform that automates Tier-1 customer support',
 'Forethought is an AI platform specifically designed to automate Tier-1 customer support resolution. Unlike general-purpose helpdesk tools, Forethought is built as an AI layer that sits on top of existing support infrastructure (Zendesk, Salesforce, ServiceNow) and handles routine enquiries autonomously. The core product, Solve, uses generative AI to understand customer intent and resolve common questions without agent involvement. Triage automatically classifies and routes incoming cases to the right team. Assist surfaces relevant knowledge base articles and suggested responses for agents handling more complex issues. Discover analyses unresolved cases to identify knowledge gaps. For support teams already using enterprise helpdesks, Forethought adds a meaningful automation layer without requiring a platform migration. Teams using Forethought report significant reductions in first-response time and agent handle time for standard support categories.',
 'https://www.google.com/s2/favicons?domain=forethought.ai&sz=64',
 'https://forethought.ai', 'https://go.mytheai.com/forethought',
 ARRAY['customer-support', 'ai-assistants', 'operations'],
 'paid', false, 0.00,
 4.3, 287, false, false, false,
 ARRAY['AI automation layer works with existing helpdesks (Zendesk, Salesforce)', 'Generative AI resolves Tier-1 queries without agent involvement', 'Discover module identifies knowledge gaps from unresolved tickets'],
 ARRAY['Custom enterprise pricing - no public starting price', 'Requires existing helpdesk - not a standalone tool', 'ROI depends on sufficient support volume to justify implementation'],
 ARRAY['Automating Tier-1 resolution on top of existing helpdesks', 'Reducing agent handle time for high-volume support teams', 'Knowledge gap analysis to improve support content']
),

('capacity',
 'Capacity',
 'AI-powered support automation platform for the entire helpdesk',
 'Capacity is an AI support automation platform that connects to existing helpdesk tools, knowledge bases, and CRM systems to power a self-service chatbot that resolves questions across the full employee and customer support spectrum. The platform uses AI to suggest answers drawn from Zendesk, Salesforce, SharePoint, Confluence, and other connected sources - reducing ticket volume by handling routine enquiries at the front door. Capacity is used by both customer-facing support teams and internal IT/HR teams that need to deflect repetitive requests at scale. The workflow automation layer (Helpdesk AI) routes what the bot cannot resolve to the right human team with full conversation context attached. The platform has a particularly strong presence in financial services, healthcare, and insurance - sectors with high support volume and strict compliance requirements around data handling.',
 'https://www.google.com/s2/favicons?domain=capacity.com&sz=64',
 'https://capacity.com', 'https://go.mytheai.com/capacity',
 ARRAY['customer-support', 'ai-assistants', 'productivity'],
 'paid', false, 0.00,
 4.1, 234, false, false, false,
 ARRAY['Connects to existing knowledge bases and helpdesks without migration', 'Reduces ticket volume by deflecting routine queries at the front door', 'Strong compliance and security posture for regulated industries'],
 ARRAY['Enterprise pricing with no public entry-level cost', 'ROI depends on integration quality with existing systems', 'Chatbot response quality depends on knowledge base completeness'],
 ARRAY['Customer and employee support ticket deflection at scale', 'AI self-service for regulated industries (finance, healthcare)', 'Connecting existing knowledge bases to a unified AI assistant']
),

('plain',
 'Plain',
 'Modern customer support tool built for engineering-led companies',
 'Plain is a customer support tool designed from first principles for developer-facing businesses and engineering-led companies. Where traditional helpdesks are built around the agent inbox, Plain is built around the customer - every interaction with a specific company or user is organised into a single timeline with full context from connected data sources (GitHub, Stripe, Segment). The AI features include thread summarisation, AI-suggested responses, and automated triage. Plain integrates directly with APIs and developer tools, allowing support to be embedded inside product workflows rather than siloed in a separate helpdesk tool. The Slack integration routes incoming issues from developer community channels without requiring a separate ticketing layer. Plain is intentionally focused - it does not try to be a CRM or marketing tool. For B2B SaaS and developer tool companies that want support to feel like a natural product extension rather than a separate department, Plain provides an approach that generic helpdesks cannot match.',
 'https://www.google.com/s2/favicons?domain=plain.com&sz=64',
 'https://plain.com', 'https://go.mytheai.com/plain',
 ARRAY['customer-support', 'productivity', 'coding-tools'],
 'freemium', true, 16.00,
 4.3, 198, false, false, false,
 ARRAY['Customer-first timeline gives complete context across all touchpoints', 'Deep developer tool integrations (GitHub, Stripe, Segment)', 'Slack-native routing for developer community support'],
 ARRAY['Focused scope - not suitable for high-volume B2C support', 'Newer product with smaller integration library than established tools', 'Less suitable for non-technical support team workflows'],
 ARRAY['Developer-facing B2B SaaS customer support', 'Engineering-led companies integrating support into product workflows', 'Small support teams needing full customer context without a heavy helpdesk']
),

('groove',
 'Groove',
 'Simple helpdesk software for growing businesses',
 'Groove is a helpdesk designed for growing businesses that need more structure than email but do not need the complexity of enterprise support platforms. The shared inbox organises email support from multiple addresses into a single team view with assignment, tagging, and private notes. The AI features include AI response drafting, conversation summaries, and smart reply suggestions. Groove includes a knowledge base builder for self-service, customer satisfaction ratings, and reporting on response time and volume. Groove positions itself as the helpdesk for businesses that have outgrown managing support through a shared Gmail account - the setup is fast, the interface is clean, and the learning curve is minimal. For SaaS companies and professional services teams in the 5-50 employee range that need basic support structure without a lengthy implementation, Groove provides a practical starting point at an accessible price.',
 'https://www.google.com/s2/favicons?domain=groovehq.com&sz=64',
 'https://groovehq.com', 'https://go.mytheai.com/groove',
 ARRAY['customer-support', 'productivity', 'operations'],
 'paid', false, 16.00,
 4.0, 543, false, false, false,
 ARRAY['Simple setup - teams can start in under an hour', 'AI response drafting and smart reply suggestions built in', 'Clean interface with low learning curve for non-technical support staff'],
 ARRAY['Limited AI depth compared to enterprise competitors', 'Fewer integrations than Zendesk or Freshdesk', 'Reporting is basic compared to more established helpdesks'],
 ARRAY['SMB email support organisation from shared inbox to structured helpdesk', 'SaaS teams outgrowing Gmail for customer support', 'Simple customer support setup without enterprise implementation complexity']
)

ON CONFLICT (slug) DO NOTHING;
