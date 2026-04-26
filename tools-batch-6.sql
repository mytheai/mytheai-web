-- tools-batch-6.sql
-- 10 new tools: App Building, Translation, Email Marketing, Social, Web Building
-- Run in Supabase SQL Editor

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

(
  'lovable',
  'Lovable',
  'Build full-stack web apps from a text description — no code required',
  E'Lovable is an AI app builder that lets anyone create full-stack web applications from a conversational description without writing a single line of code. Built on React, TypeScript, and Supabase, Lovable generates production-ready applications — not just prototypes — from natural language prompts. Users describe what they want to build, Lovable generates the codebase, and subsequent messages refine, add features, or fix issues conversationally. The platform handles database schema, authentication, and UI simultaneously, making it capable of producing complete SaaS-like applications rather than simple landing pages.\n\nLovable has attracted non-technical founders validating product ideas and developers who want to scaffold complex applications faster. Every project has a live URL for immediate sharing, and projects can be exported as standard code for hosting anywhere or continued development by engineers. GitHub integration means generated code can be version-controlled and treated like any other codebase. The free tier is generous for small projects; the Pro plan at $20 per month raises the monthly token limit for building more complex or feature-rich applications.',
  'https://www.google.com/s2/favicons?domain=lovable.dev&sz=64',
  'https://lovable.dev',
  'https://lovable.dev',
  ARRAY['code-ai'],
  'freemium', true, 20,
  4.6, 1780, false, true, true,
  ARRAY['Full-stack apps including database and auth from a text prompt', 'GitHub integration for version control and continued development', 'Production-ready React and TypeScript output', 'Live URL generated immediately for sharing and testing'],
  ARRAY['Token limits on free plan constrain complex builds', 'AI-generated code may need review for edge cases', 'Complex business logic can require significant iteration'],
  ARRAY['MVP and prototype validation for non-technical founders', 'Internal tools and admin dashboards without an engineer', 'Rapid feature prototyping to validate before full development', 'SaaS application scaffolding to accelerate engineering']
),

(
  'deepl',
  'DeepL',
  'AI translation with the most natural-sounding output for European and Asian languages',
  E'DeepL is an AI translation tool that produces the most natural-sounding translations from European and East Asian languages available today. Where general-purpose translation tools are fast and broadly capable, DeepL is preferred by professional translators, content teams, and global businesses for languages where nuance and idiomatic accuracy matter most. Controlled studies consistently rank DeepL above competitors for German, French, Spanish, Polish, Japanese, and Chinese in terms of fluency and accuracy on complex sentences. The document translation tool processes Word, PowerPoint, and PDF files while preserving the original formatting and layout precisely.\n\nDeepL Write is a companion tool that refines and improves writing in English and German, functioning as a grammar and style assistant. The combination of translation and writing improvement makes DeepL useful beyond translation alone — for non-native English writers who want to improve written quality. The free plan supports translations up to 500,000 characters per month via the web interface. DeepL Pro starts at $8.74 per month and adds unlimited text translation, document processing, and API access for integrating DeepL into content pipelines. Businesses needing to localise large volumes of content use the API to automate translation at scale.',
  'https://www.google.com/s2/favicons?domain=deepl.com&sz=64',
  'https://deepl.com',
  'https://deepl.com',
  ARRAY['writing-ai'],
  'freemium', true, 9,
  4.7, 3400, false, false, false,
  ARRAY['Highest naturalness ratings for European and East Asian languages', 'Document translation preserves original formatting exactly', 'DeepL Write improves grammar and style in English and German', 'API available for workflow automation and content pipeline integration'],
  ARRAY['Fewer supported languages than Google Translate for rare languages', 'Advanced features require paid plan', 'Less strong for informal or highly colloquial content'],
  ARRAY['Localising marketing content and product documentation', 'Translating contracts and business documents accurately', 'Non-native English writers improving written quality', 'Automating multilingual content production via API']
),

(
  'typefully',
  'Typefully',
  'AI social content and scheduling for Twitter/X and LinkedIn',
  E'Typefully is an AI-powered writing and scheduling tool built specifically for Twitter/X and LinkedIn. Unlike broad social media management platforms, Typefully is designed for creators, founders, and professionals who want to build a personal brand with high-quality written content. The AI drafting assistant generates post ideas, complete thread outlines, and individual posts from a brief description, while the revise feature rewrites drafts in different tones without starting from scratch. The writing environment is distraction-free and optimised for the character counts and thread formats native to Twitter and LinkedIn.\n\nTypefully''s scheduling system posts content at optimal engagement times based on each account''s historical performance data, and analytics show which posts drive the most follower growth and engagement. The inspiration feed surfaces viral content in any topic area for reference without users having to scroll. Collaboration features let team members and ghostwriters draft and approve content before scheduling. The free plan covers basic scheduling for one account. The Creator plan at $12.50 per month adds unlimited scheduling, AI drafting credits, analytics, and multi-account support for professionals managing content across multiple profiles.',
  'https://www.google.com/s2/favicons?domain=typefully.com&sz=64',
  'https://typefully.com',
  'https://typefully.com',
  ARRAY['content', 'writing-ai'],
  'freemium', true, 13,
  4.4, 870, false, false, false,
  ARRAY['Purpose-built for Twitter/X and LinkedIn — not a generic tool', 'Optimal send-time scheduling based on historical engagement data', 'AI drafting and revision for posts and threads', 'Ghostwriter collaboration and approval workflow'],
  ARRAY['Limited to Twitter/X and LinkedIn — no Instagram or TikTok', 'AI drafts require editing to sound authentic', 'Analytics depth less than dedicated analytics tools'],
  ARRAY['Building a personal brand on Twitter/X and LinkedIn', 'Founders and executives maintaining a consistent posting cadence', 'Content teams managing multiple professional profiles', 'Ghostwriters drafting and scheduling client social content']
),

(
  'klaviyo',
  'Klaviyo',
  'AI-powered email and SMS marketing platform for e-commerce',
  E'Klaviyo is an email and SMS marketing platform built for e-commerce businesses, with AI features that personalise campaigns and automate customer lifecycle messaging at scale. Where general email marketing tools treat all subscribers the same, Klaviyo''s segmentation engine divides lists by purchase history, browsing behaviour, product preferences, and predicted lifetime value, enabling campaigns that reach the right customer at the right moment. AI predictive analytics forecast which customers are likely to churn, which are likely to make a repeat purchase, and what the optimal send time is for each individual subscriber.\n\nKlaviyo integrates natively with Shopify, WooCommerce, and BigCommerce, pulling real-time purchase and browse data to trigger automated flows: abandoned cart recovery, post-purchase follow-ups, win-back sequences, and welcome series. The AI generates subject line suggestions, product recommendation blocks based on individual purchase history, and A/B test variants for continuous improvement. The free plan supports up to 500 contacts and 500 monthly email sends. Paid plans start at $45 per month for 1,500 contacts, scaling with list size. For e-commerce businesses serious about email as a revenue channel, Klaviyo is the industry standard platform.',
  'https://www.google.com/s2/favicons?domain=klaviyo.com&sz=64',
  'https://klaviyo.com',
  'https://klaviyo.com',
  ARRAY['productivity'],
  'freemium', true, 45,
  4.5, 2100, false, false, false,
  ARRAY['Deep native integration with Shopify, WooCommerce, and BigCommerce', 'AI predictive analytics for churn and purchase likelihood', 'Automated flows triggered by real-time purchase and browse behaviour', 'Free plan for up to 500 contacts'],
  ARRAY['Pricing scales steeply with list size', 'Steeper setup learning curve than simpler email tools', 'Best value only for e-commerce — less suited to B2B or SaaS'],
  ARRAY['Abandoned cart recovery automations', 'Post-purchase upsell and cross-sell sequences', 'Win-back campaigns for lapsed customers', 'Revenue-focused email marketing for Shopify stores']
),

(
  'webflow',
  'Webflow',
  'Visual web development platform for design-led teams and agencies',
  E'Webflow is a visual web development platform that lets designers and marketers build production-ready websites without writing code, while giving developers the ability to export clean HTML, CSS, and JavaScript. Unlike website builders that generate bloated code or limit design freedom, Webflow produces hand-crafted-quality code through a visual interface, giving full control over layout, animations, interactions, and CMS content without compromising output quality. AI features introduced in 2024 generate page sections from text descriptions, suggest layout improvements, and draft CMS content, making initial page creation significantly faster.\n\nWebflow''s CMS allows non-technical team members to update content through a familiar editing interface while designers control the template and structure. E-commerce, membership sites, and complex multi-page marketing sites are all within scope, and the hosting infrastructure handles performance optimisation automatically. Webflow is the preferred platform for design-led companies, agencies, and marketing teams that want full creative control without ongoing developer dependency. The free tier is available for prototyping and learning. The Basic plan starts at $14 per month for simple sites, with CMS and Business plans at $23 and $39 per month for sites with more complex content needs.',
  'https://www.google.com/s2/favicons?domain=webflow.com&sz=64',
  'https://webflow.com',
  'https://webflow.com',
  ARRAY['productivity', 'content'],
  'freemium', true, 14,
  4.4, 1560, false, false, false,
  ARRAY['Production-quality code output from a visual editor', 'Full CMS for non-technical content management', 'AI page generation from text descriptions', 'No developer dependency for design changes'],
  ARRAY['Steeper learning curve than Squarespace or Wix', 'E-commerce features less mature than dedicated platforms', 'Can become expensive with hosting and CMS plans combined'],
  ARRAY['Agency and design studio client websites', 'Marketing landing pages requiring precise design control', 'SaaS and startup marketing sites', 'Replacing developer-dependent WordPress sites']
),

(
  'beehiiv',
  'Beehiiv',
  'Newsletter platform built for audience growth and monetisation',
  E'Beehiiv is a newsletter publishing platform that combines writing tools, subscriber management, monetisation features, and AI assistance in a platform designed by former Morning Brew team members who understood newsletter economics from the inside. The AI writing tools help creators draft, refine, and reformat content faster, with tone adjustment, subject line generation, and content expansion built into the editor. Unlike Substack, Beehiiv gives creators full ownership of their subscriber list, custom domain and branding control, and access to analytics that show subscriber-level engagement and growth attribution by referral source.\n\nThe platform''s growth features are its strongest differentiator: a referral program lets subscribers earn rewards for sharing, a recommendation network lets newsletters cross-promote to aligned audiences, and the ad network connects creators with brands for sponsored placements. Monetisation tools include paid subscriptions, premium content tiers, and the integrated ad network, giving creators multiple revenue streams within a single platform. Beehiiv is free for newsletters up to 2,500 subscribers with no revenue share taken. The Scale plan at $42 per month is needed for creators who want automations, advanced analytics, and access to the referral and monetisation tools at scale.',
  'https://www.google.com/s2/favicons?domain=beehiiv.com&sz=64',
  'https://beehiiv.com',
  'https://beehiiv.com',
  ARRAY['content', 'writing-ai'],
  'freemium', true, 42,
  4.6, 1230, false, true, false,
  ARRAY['Free for up to 2,500 subscribers with no revenue share', 'Built-in referral program and cross-promotion network', 'Multiple monetisation options: subscriptions, ads, premium tiers', 'Full subscriber list ownership with data export'],
  ARRAY['Scale plan needed for most growth tools', 'Ad network requires minimum audience size to be effective', 'Less established than Substack in terms of discovery'],
  ARRAY['Creator newsletters building an independent audience', 'Brand newsletters as a direct marketing channel', 'Monetising niche expertise through paid subscriptions', 'Content businesses replacing Substack for better economics']
),

(
  'activecampaign',
  'ActiveCampaign',
  'Email marketing automation and CRM for growing businesses',
  E'ActiveCampaign is an email marketing and CRM platform that combines automation, customer relationship management, and AI-driven personalisation in a single tool. Its automation builder is among the most powerful available — marketers can design complex sequences that trigger based on email opens, link clicks, form submissions, purchase behaviour, and CRM data, creating highly personalised customer journeys. AI features predict the best send time for each subscriber, generate email subject lines and content variations, and score leads based on engagement signals to help sales teams prioritise follow-up.\n\nActiveCampaign is positioned between simple email marketing tools and full enterprise CRM systems. It is the preferred choice for B2B companies with longer sales cycles, coaching and education businesses with complex nurture sequences, and e-commerce businesses that need tight integration between marketing automation and CRM data. The platform integrates with over 900 tools and supports deep Shopify and WooCommerce connections. Paid plans start at $15 per month for the Starter tier with up to 1,000 contacts and basic automation, scaling to $49 per month and beyond for teams that need CRM features, predictive sending, and advanced reporting.',
  'https://www.google.com/s2/favicons?domain=activecampaign.com&sz=64',
  'https://activecampaign.com',
  'https://activecampaign.com',
  ARRAY['productivity'],
  'paid', false, 15,
  4.3, 1890, false, false, false,
  ARRAY['Most powerful visual automation builder available', 'AI predictive sending and lead scoring', 'Deep CRM integration alongside email marketing', 'Integrates with 900+ tools'],
  ARRAY['No free plan — paid from the first subscriber', 'Steeper learning curve than simpler email tools', 'Pricing increases significantly with contact list growth'],
  ARRAY['Complex multi-step email nurture sequences for B2B sales', 'Coaching and course businesses with conditional automation paths', 'E-commerce lifecycle marketing with CRM data', 'Lead scoring and sales pipeline management for small teams']
),

(
  'grok',
  'Grok',
  'xAI''s conversational AI with real-time access to X data and current events',
  E'Grok is xAI''s conversational AI assistant available through X (formerly Twitter) and as a standalone application. Built by Elon Musk''s AI company, Grok differentiates itself with real-time access to X''s data stream, making it well-suited for questions about current events, trending topics, and breaking news where other AI assistants are limited by training data cutoffs. Grok 3, released in early 2025, significantly improved reasoning capabilities and coding performance, bringing it into direct competition with top-tier models from OpenAI and Anthropic on standard benchmarks.\n\nGrok''s design allows it to engage more directly with a wider range of topics than some competing AI assistants, which applies more conservative content filters. The image generation model, Aurora, is integrated into Grok for visual content creation. Access to Grok is included with X Premium subscriptions at $8 per month, making it the most affordable path to a frontier-tier AI model for users already paying for X Premium. The standalone Grok app offers access without an X subscription. For users who want real-time information grounding and a strong reasoning model, Grok is a compelling alternative to ChatGPT and Claude.',
  'https://www.google.com/s2/favicons?domain=x.ai&sz=64',
  'https://grok.com',
  'https://grok.com',
  ARRAY['ai-assistant'],
  'freemium', true, 8,
  4.2, 1100, false, true, false,
  ARRAY['Real-time access to X data for current events and trending topics', 'Included with X Premium — low incremental cost', 'Grok 3 competitive on reasoning and coding benchmarks', 'Built-in image generation via Aurora model'],
  ARRAY['Best features tied to X Premium subscription', 'Smaller app ecosystem than ChatGPT or Claude', 'Less established developer API compared to OpenAI'],
  ARRAY['Research on current events and breaking news', 'Reasoning and analysis tasks as a ChatGPT alternative', 'Image generation alongside conversational AI', 'Users already subscribed to X Premium seeking an AI assistant']
),

(
  'photoroom',
  'PhotoRoom',
  'AI photo editing and background removal for product photography',
  E'PhotoRoom is an AI photo editing application specialised in product photography and background removal for e-commerce, social media, and marketing use cases. Its core feature — instant background removal — produces clean, precise cutouts from product photos taken in any environment, eliminating the need for professional photography setups or manual editing. The AI handles complex edges including hair, fur, and transparent objects accurately, achieving results that would require significant skill and time to accomplish manually in Photoshop. The batch processing feature applies background removal and replacement to hundreds of product images simultaneously, making it practical for large e-commerce catalogues.\n\nPhotoRoom generates professional product photos by replacing removed backgrounds with solid colours, gradients, or contextual AI-generated scenes appropriate for the product type. The AI Studio feature generates marketing-quality lifestyle images from a product photo and a text description, enabling businesses to produce diverse product imagery without expensive photoshoots. The tool is popular with Etsy sellers, Amazon merchants, social media marketers, and anyone producing high volumes of product images. The free plan includes basic background removal. The Pro plan at $9.99 per month adds HD exports, batch processing, AI image generation, and removal of the PhotoRoom watermark.',
  'https://www.google.com/s2/favicons?domain=photoroom.com&sz=64',
  'https://photoroom.com',
  'https://photoroom.com',
  ARRAY['image-ai'],
  'freemium', true, 10,
  4.5, 2340, false, false, false,
  ARRAY['Accurate background removal including hair, fur, and transparent objects', 'Batch processing for large product catalogues', 'AI Studio generates lifestyle imagery from product photos', 'Pro plan at $9.99 per month — highly affordable'],
  ARRAY['Pro plan required for batch processing and HD exports', 'AI lifestyle scene generation can look artificial on complex products', 'Less capable for editorial or creative photography editing'],
  ARRAY['E-commerce product photography for Shopify and Amazon listings', 'Social media product shots without a studio setup', 'Batch processing catalogue images for seasonal refreshes', 'Marketing teams producing diverse product imagery quickly']
),

(
  'dify',
  'Dify',
  'Open-source platform for building and deploying LLM-powered applications',
  E'Dify is an open-source platform for building, deploying, and monitoring LLM-powered applications without deep machine learning expertise. It provides a visual workflow builder where developers and product teams can chain AI models, prompt templates, retrieval systems, and API tools into custom AI applications — chatbots, document processors, customer support agents, and content generators — without writing the underlying infrastructure from scratch. Dify supports multiple AI providers (OpenAI, Anthropic, Mistral, local models) behind a unified interface, making it straightforward to swap models or add fallbacks without rewriting application logic.\n\nThe platform includes built-in RAG capabilities for grounding AI responses in proprietary documents or databases, agent tooling for connecting AI to external APIs and services, and observability features for monitoring model performance and costs in production. Dify can be self-hosted for complete data privacy control, or used via the managed cloud service. The open-source nature makes it popular with developers and enterprises who need customisable AI infrastructure without vendor lock-in. The Community Edition is free to self-host with no usage limits. The Professional managed cloud plan starts at $59 per month for teams who prefer managed infrastructure with priority support.',
  'https://www.google.com/s2/favicons?domain=dify.ai&sz=64',
  'https://dify.ai',
  'https://dify.ai',
  ARRAY['code-ai'],
  'freemium', true, 59,
  4.5, 980, false, true, false,
  ARRAY['Open-source with full self-hosting option for data privacy', 'Visual workflow builder for non-ML engineers', 'Built-in RAG for grounding AI in proprietary documents', 'Supports 30+ AI model providers including local models'],
  ARRAY['Self-hosting requires server infrastructure and DevOps knowledge', 'Managed cloud plan starts at $59 per month', 'Steeper setup than no-code AI tools for non-developers'],
  ARRAY['Building internal AI chatbots on company documents', 'Customer support automation with RAG pipelines', 'Custom LLM application development without infrastructure overhead', 'Enterprises needing private AI deployment with data sovereignty']
)

ON CONFLICT (slug) DO NOTHING;
