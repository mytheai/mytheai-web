-- tools-batch-25.sql
-- AI Customer Support & Helpdesk tools (10 tools)
-- DB: ~272 tools → ~282 tools
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

-- 1. Zendesk
(
  'zendesk', 'Zendesk', 'Customer service platform trusted by 100,000+ businesses',
  'Zendesk is the leading customer service and support platform, used by companies from early-stage startups to global enterprises. It centralises support across email, chat, phone, social media, and self-service into a single unified workspace. Support agents work from one interface with full conversation history, customer context, and suggested responses. Zendesk AI (built on large language models) automatically triages incoming tickets, suggests responses to agents, summarises long threads, and routes cases to the right team. Its Help Center builder lets teams create a knowledge base that deflects common questions before they reach an agent. For teams running high-volume support, Zendesk Answer Bot handles repetitive queries automatically. The platform scales from a five-person startup to a 10,000-seat enterprise operation. Integrations cover Salesforce, Shopify, Slack, JIRA, and hundreds of other tools via the Zendesk marketplace.',
  'https://www.google.com/s2/favicons?domain=zendesk.com&sz=64',
  'https://zendesk.com', 'https://zendesk.com',
  ARRAY['customer-support', 'helpdesk', 'customer-service', 'ticketing'],
  'paid', false, 55.00,
  4.4, 8900, false, false, false,
  ARRAY['Unified multi-channel support inbox', 'Zendesk AI for triage and response suggestions', 'Extensive integration marketplace', 'Enterprise-grade permissions and reporting'],
  ARRAY['Expensive at scale per agent', 'Complex setup for smaller teams', 'Can feel bloated if you only need basic ticketing'],
  ARRAY['Running multi-channel customer support for a SaaS product', 'Building a self-service knowledge base to reduce ticket volume', 'Scaling a support team with AI-assisted workflows']
),

-- 2. Freshdesk
(
  'freshdesk', 'Freshdesk', 'AI-powered helpdesk for teams of all sizes',
  'Freshdesk is a cloud-based customer support platform by Freshworks, known for its clean interface, fast setup, and generous free plan. It brings email, chat, phone, and social media support into a shared inbox where agents collaborate on tickets, set priorities, and track SLAs. Freshdesk Freddy AI handles three layers of support automation: Freddy Self Service deflects tickets with an AI-powered bot, Freddy Copilot assists agents with response suggestions and summaries in real time, and Freddy Insights provides analytics and anomaly detection for support leaders. The platform includes a built-in knowledge base, community forum builder, and robust automation rules for routing and escalation. Freshdesk integrates with Shopify, Slack, JIRA, HubSpot, and the broader Freshworks suite (Freshchat for live chat, Freshsales for CRM). The free plan supports unlimited agents for basic email and social ticketing, making it the most accessible starting point in this category.',
  'https://www.google.com/s2/favicons?domain=freshdesk.com&sz=64',
  'https://freshdesk.com', 'https://freshdesk.com',
  ARRAY['customer-support', 'helpdesk', 'ai-assistant', 'ticketing'],
  'freemium', true, 0.00,
  4.4, 6200, false, false, false,
  ARRAY['Generous free plan for unlimited agents', 'Freddy AI across self-service, agent assist, and analytics', 'Fast setup with intuitive interface', 'Good Shopify and e-commerce integrations'],
  ARRAY['Advanced AI features require higher-tier plans', 'Reporting depth less than Zendesk on base plans', 'Some integrations limited to paid tiers'],
  ARRAY['SMB teams setting up customer support for the first time', 'E-commerce businesses managing order and return queries', 'Teams wanting AI-assisted support without enterprise pricing']
),

-- 3. Help Scout
(
  'helpscout', 'Help Scout', 'Customer support platform built for human-first service',
  'Help Scout is a customer support platform designed around the principle that support should feel personal, not transactional. The shared inbox looks and works like email, which means agents do not need training and customers never feel they are talking to a ticket system. Help Scout includes Docs for building a self-service knowledge base, Beacon for embedding live chat and self-service on your website, and Messages for sending targeted in-app messages. Help Scout AI adds response drafting, conversation summarisation, and a tool to instantly surface relevant Docs articles while an agent is writing. The platform is deliberately less complex than Zendesk or Freshdesk - there are no ticket IDs shown to customers, no complex routing rules, no bloated admin interface. This simplicity is a feature for product and SaaS teams who want support to feel like an extension of their product, not a separate system. Integrations include Shopify, HubSpot, Salesforce, Slack, and JIRA.',
  'https://www.google.com/s2/favicons?domain=helpscout.com&sz=64',
  'https://helpscout.com', 'https://helpscout.com',
  ARRAY['customer-support', 'helpdesk', 'customer-service', 'ai-assistant'],
  'paid', false, 50.00,
  4.6, 2800, false, false, false,
  ARRAY['Email-like interface that feels natural to agents and customers', 'AI-powered response drafting and summarisation', 'Docs and Beacon for self-service and in-app support', 'No ticket numbers shown to customers - more human experience'],
  ARRAY['No free plan', 'Less customisable workflows than Zendesk', 'Better for SMBs than large enterprise teams'],
  ARRAY['SaaS companies wanting support that feels like a product extension', 'Teams replacing generic email inboxes with a shared support inbox', 'Small support teams that need a clean tool they can adopt in a day']
),

-- 4. Gorgias
(
  'gorgias', 'Gorgias', 'Customer support helpdesk built for e-commerce',
  'Gorgias is a helpdesk built specifically for e-commerce brands running on Shopify, WooCommerce, BigCommerce, or Magento. Where generic helpdesks treat all customer messages the same, Gorgias pulls order data, shipment status, and purchase history directly into the support ticket - so agents can see and take action on orders without switching tabs. Common support actions like issuing refunds, editing orders, or applying discount codes can be triggered directly from within a ticket. Gorgias Automate uses AI and rules to handle repetitive inquiries (order status, return policy questions, discount code requests) without agent involvement, often resolving 30-40% of tickets automatically. Its revenue statistics dashboard shows the direct revenue impact of support conversations - a metric traditional helpdesks do not track. For DTC and e-commerce brands managing high volumes of post-purchase support, Gorgias reduces handle time more than any general-purpose platform.',
  'https://www.google.com/s2/favicons?domain=gorgias.com&sz=64',
  'https://gorgias.com', 'https://gorgias.com',
  ARRAY['customer-support', 'helpdesk', 'ecommerce', 'customer-service'],
  'paid', false, 10.00,
  4.6, 1900, false, false, false,
  ARRAY['Deep Shopify integration with order actions inside tickets', 'AI automation handles 30-40% of tickets without agents', 'Revenue-from-support tracking', 'Purpose-built for e-commerce workflows'],
  ARRAY['Not suitable for non-e-commerce use cases', 'Pricing scales with ticket volume rather than seats', 'Limited for complex B2B support needs'],
  ARRAY['Shopify brands handling high post-purchase support volume', 'DTC brands wanting to measure support revenue impact', 'E-commerce teams looking to automate repetitive order queries']
),

-- 5. Drift
(
  'drift', 'Drift', 'Conversational marketing and sales platform with AI',
  'Drift is a conversational AI platform used by B2B companies to engage website visitors, qualify leads, and route prospects to the right sales rep - automatically and in real time. Drift Bionic Bots (AI-powered chatbots) handle the top of the funnel: answering common questions, qualifying visitors by company size or intent signals, booking meetings directly on sales rep calendars, and routing high-value leads to live chat with a human. The platform integrates with Salesforce, HubSpot, Marketo, and 6sense for account-based marketing workflows. Drift also includes Drift Video for personalised video messaging in conversations and Drift Prospector for identifying high-intent accounts visiting your site. It is more sales-focused than customer-support-focused - the primary goal is pipeline generation rather than ticket resolution. Now part of Salesloft, Drift is increasingly integrated with that platform for enterprise GTM teams.',
  'https://www.google.com/s2/favicons?domain=drift.com&sz=64',
  'https://drift.com', 'https://drift.com',
  ARRAY['customer-support', 'sales', 'ai-assistant', 'marketing'],
  'paid', false, 2500.00,
  4.2, 2100, false, false, false,
  ARRAY['AI bots qualify and route leads automatically', 'Real-time chat routing to sales reps', 'Deep CRM and MAP integrations', 'Meeting booking directly in the chat flow'],
  ARRAY['Enterprise pricing puts it out of reach for SMBs', 'Primarily a sales tool - not a customer support helpdesk', 'Complex setup for non-technical marketing teams'],
  ARRAY['B2B SaaS companies converting website visitors into pipeline', 'Revenue teams automating lead qualification and routing', 'Enterprise GTM teams integrating chat with ABM campaigns']
),

-- 6. Front
(
  'front-app', 'Front', 'Customer operations platform for high-touch support teams',
  'Front is a shared inbox and customer operations platform that combines the familiarity of email with the power of a helpdesk. Unlike traditional ticketing systems, Front preserves the email format for both agents and customers - making it feel personal rather than transactional. Teams collaborate on emails through internal comments, shared drafts, and @mentions, all without the customer seeing the behind-the-scenes coordination. Front AI generates response drafts, suggests relevant knowledge base articles, summarises long email threads, and automates routing rules. It supports multiple channels - email, SMS, WhatsApp, live chat, social media - in one unified inbox. Front is particularly popular with customer success and account management teams who handle high-value, ongoing client relationships rather than high-volume commodity support. Its analytics surface team performance, SLA adherence, and customer sentiment trends.',
  'https://www.google.com/s2/favicons?domain=front.com&sz=64',
  'https://front.com', 'https://front.com',
  ARRAY['customer-support', 'helpdesk', 'customer-service', 'ai-assistant'],
  'paid', false, 19.00,
  4.5, 2400, false, false, false,
  ARRAY['Familiar email interface agents actually enjoy using', 'Internal collaboration without customers seeing coordination', 'Front AI for draft generation and thread summarisation', 'Strong for high-touch customer success workflows'],
  ARRAY['More expensive than basic helpdesks', 'Not ideal for very high ticket volume operations', 'Can be over-engineered for small teams needing simple shared inbox'],
  ARRAY['Customer success teams managing enterprise account relationships', 'Operations teams routing multi-channel communications', 'Support teams who want the helpdesk power without the ticket-number feel']
),

-- 7. Crisp
(
  'crisp', 'Crisp', 'Customer messaging platform with live chat and shared inbox',
  'Crisp is a customer messaging platform that consolidates live chat, email, WhatsApp, Instagram, Messenger, and Telegram into a single shared inbox. It is designed for small and medium businesses that want multi-channel support without the complexity or cost of enterprise platforms. Crisp includes a chatbot builder for automating responses, a knowledge base builder, CRM features for tracking customer data, and a status page tool for communicating service incidents. Crisp AI can generate message replies from previous support conversations, suggest knowledge base articles during chats, and help with chatbot flow creation. The free plan supports two agents with core live chat and inbox features - the most generous free tier in this category. Crisp is particularly popular with SaaS startups and digital businesses that need live chat plus email support in a single tool without splitting workflows across multiple platforms.',
  'https://www.google.com/s2/favicons?domain=crisp.chat&sz=64',
  'https://crisp.chat', 'https://crisp.chat',
  ARRAY['customer-support', 'live-chat', 'customer-service', 'ai-assistant'],
  'freemium', true, 0.00,
  4.4, 1600, false, false, false,
  ARRAY['Generous free plan for two agents', 'Multi-channel inbox in one tool', 'Chatbot builder included', 'Great for SaaS and digital-first businesses'],
  ARRAY['Less powerful than Zendesk or Freshdesk for complex workflows', 'Analytics less detailed on lower plans', 'Chatbot builder has limited AI compared to dedicated platforms'],
  ARRAY['SaaS startups adding live chat and email support in one tool', 'Small teams who need multi-channel support without enterprise cost', 'Product teams wanting a simple chatbot for first-line deflection']
),

-- 8. Zoho Desk
(
  'zoho-desk', 'Zoho Desk', 'AI-powered helpdesk from the Zoho ecosystem',
  'Zoho Desk is the customer support platform within the Zoho ecosystem, integrating natively with Zoho CRM, Zoho Analytics, Zoho Books, and 30+ other Zoho apps. It supports email, phone, chat, social media, and web forms in a multi-channel inbox. Zia - Zoho''s AI assistant - handles sentiment analysis on incoming tickets, automatic tagging and routing, response suggestions, and anomaly detection in support metrics. The platform includes a knowledge base with AI-powered article suggestions, a chatbot builder, SLA management, and a Blueprint workflow builder for automating complex multi-step support processes. For companies already using Zoho CRM or other Zoho products, Zoho Desk is the natural support layer - agents see full customer context from CRM directly in the ticket. For teams outside the Zoho ecosystem, it competes well on price and features against Freshdesk.',
  'https://www.google.com/s2/favicons?domain=zoho.com&sz=64',
  'https://zoho.com/desk', 'https://zoho.com/desk',
  ARRAY['customer-support', 'helpdesk', 'customer-service', 'ai-assistant'],
  'freemium', true, 0.00,
  4.3, 3100, false, false, false,
  ARRAY['Deep integration with Zoho CRM and broader Zoho suite', 'Zia AI for sentiment analysis, routing, and suggestions', 'Blueprint for visual workflow automation', 'Competitive pricing with generous free tier'],
  ARRAY['Best value inside the Zoho ecosystem - less compelling standalone', 'Interface can feel dated compared to newer platforms', 'Advanced reporting requires Zoho Analytics add-on'],
  ARRAY['Companies already using Zoho CRM wanting unified support and sales', 'SMBs needing a full helpdesk at startup-friendly pricing', 'Teams wanting AI triage and routing without enterprise costs']
),

-- 9. LiveAgent
(
  'liveagent', 'LiveAgent', 'All-in-one customer support with built-in call center',
  'LiveAgent is a multi-channel customer support platform that stands out for including a full call center (VoIP calling) alongside its helpdesk, live chat, and social media support - all in one subscription. It supports email, live chat, phone calls, video calls, WhatsApp, Instagram, Facebook, Twitter, and Viber in a single unified inbox. LiveAgent''s live chat is one of the fastest in the industry with sub-0.5 second average response times. Its gamification features - agent leaderboards, badges, and performance rewards - help support teams maintain motivation. The platform includes a knowledge base builder, customer portal, and AI-powered response suggestions. LiveAgent is popular with e-commerce businesses and SaaS companies that need phone support alongside chat and email, without the cost of a separate call center solution.',
  'https://www.google.com/s2/favicons?domain=liveagent.com&sz=64',
  'https://liveagent.com', 'https://liveagent.com',
  ARRAY['customer-support', 'helpdesk', 'live-chat', 'customer-service'],
  'freemium', true, 0.00,
  4.5, 1800, false, false, false,
  ARRAY['Built-in call center with VoIP at no extra cost', 'Widest channel coverage in this category', 'Fastest live chat response time', 'Gamification for agent motivation'],
  ARRAY['Interface design feels less modern than Zendesk or Front', 'AI features less sophisticated than dedicated AI platforms', 'Can be overwhelming to configure initially'],
  ARRAY['SMBs needing phone support bundled with helpdesk', 'E-commerce teams handling multi-channel customer contact', 'Support teams wanting gamification to drive agent performance']
),

-- 10. Gladly
(
  'gladly', 'Gladly', 'AI-native customer service platform built around people, not tickets',
  'Gladly is an AI-native customer service platform that takes a fundamentally different approach to support: instead of organising around tickets, it organises around people. Every customer has a single lifetime conversation timeline across all channels - email, chat, SMS, voice, and social - giving agents complete context without searching across systems. Gladly Sidekick is an AI agent that handles common customer requests end-to-end without human involvement: order lookups, returns, account changes, and FAQs. When a case requires human escalation, Sidekick passes the full context to a Gladly Hero (the term for human agents) who can see everything that happened. The platform is designed for consumer brands - particularly retail, fashion, and direct-to-consumer - with customers like Ralph Lauren, Warby Parker, and JOANN using it. The people-centric model means agents spend less time on context-gathering and more time on resolution.',
  'https://www.google.com/s2/favicons?domain=gladly.com&sz=64',
  'https://gladly.com', 'https://gladly.com',
  ARRAY['customer-support', 'ai-assistant', 'customer-service', 'helpdesk'],
  'paid', false, 0.00,
  4.6, 820, false, false, false,
  ARRAY['People-centric model with lifetime conversation history', 'Gladly Sidekick AI resolves common requests end-to-end', 'Single timeline across all channels per customer', 'Designed for high-touch consumer brand support'],
  ARRAY['Enterprise pricing - custom quotes only', 'Built for consumer/DTC brands - less suited to B2B SaaS', 'Smaller integration marketplace than Zendesk'],
  ARRAY['DTC and retail brands wanting AI-first customer service', 'Consumer companies reducing agent handle time with AI resolution', 'Brands prioritising customer lifetime relationship over ticket metrics']
)

ON CONFLICT (slug) DO NOTHING;
