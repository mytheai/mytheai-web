-- tools-batch-8.sql
-- 10 new tools: mailchimp, hootsuite, meta-ai, anyword, wordtune, hyperwrite, replicate, together-ai, typeform, streamlit
-- DB: 103 → 113 after running
-- Safe to re-run (ON CONFLICT DO NOTHING)

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
VALUES

(
  'mailchimp',
  'Mailchimp',
  'Email marketing platform with AI-powered content and send-time optimisation',
  'Mailchimp is the world''s largest email marketing platform, used by over 12 million businesses to send newsletters, automated campaigns, and transactional emails. Its AI tools have matured significantly: the Content Optimizer suggests improvements to subject lines and body copy, predicted send times automatically choose the best moment to reach each subscriber, and the AI-assisted campaign builder generates email copy from a brief description of your goals.

For small businesses and creators, Mailchimp''s free plan supports up to 500 contacts and 1,000 monthly sends — enough to run a legitimate email marketing operation before committing to a paid plan. The segmentation and automation features let you build customer journeys that trigger on behaviour: purchases, page visits, or subscription milestones. The template library covers every use case from product announcements to drip sequences, and the analytics dashboard shows open rates, click-through rates, and revenue attribution clearly. While tools like Klaviyo have overtaken Mailchimp for e-commerce-heavy use cases, Mailchimp remains the most accessible starting point for businesses running their first email campaigns.',
  'https://www.google.com/s2/favicons?domain=mailchimp.com&sz=64',
  'https://mailchimp.com',
  'https://mailchimp.com',
  ARRAY['content', 'productivity'],
  'freemium',
  true,
  13,
  4.2,
  2800,
  false,
  false,
  false,
  ARRAY['Generous free plan (500 contacts)', 'AI send-time optimisation', 'Large template library', 'Built-in landing page builder'],
  ARRAY['Gets expensive as list grows', 'E-commerce features behind Klaviyo', 'Automation UX can be complex'],
  ARRAY['Small business newsletters', 'Product launch campaigns', 'Customer onboarding sequences']
),

(
  'hootsuite',
  'Hootsuite',
  'Social media management platform with AI content generation and scheduling',
  'Hootsuite is a social media management platform that lets teams schedule, publish, monitor, and analyse content across every major social platform — Twitter/X, Instagram, LinkedIn, Facebook, TikTok, Pinterest, and YouTube — from a single dashboard. The AI writing tool, OwlyWriter AI, generates social media captions, post ideas, and hashtag suggestions from a brief prompt, dramatically reducing the time spent on content creation.

For marketing teams managing multiple accounts or brands, Hootsuite''s scheduling calendar, approval workflows, and team permission system turn social media from a reactive task into a planned editorial operation. The social listening features track brand mentions, competitor activity, and trending conversations in real time, making it useful for monitoring reputation and identifying engagement opportunities. The analytics suite aggregates performance data across all platforms and generates PDF reports suitable for client or executive presentations. Hootsuite is the platform of choice for mid-market and enterprise marketing teams who need governance (approvals, brand consistency, legal review) alongside publishing capabilities. Smaller teams and solo creators often prefer Buffer or Later for simplicity and price.',
  'https://www.google.com/s2/favicons?domain=hootsuite.com&sz=64',
  'https://hootsuite.com',
  'https://hootsuite.com',
  ARRAY['content', 'productivity'],
  'paid',
  false,
  99,
  4.1,
  1900,
  false,
  false,
  false,
  ARRAY['Manages all platforms in one dashboard', 'OwlyWriter AI for content generation', 'Team approval workflows', 'Comprehensive analytics reporting'],
  ARRAY['No free plan (only 30-day trial)', 'Expensive for small teams', 'Interface can feel dated'],
  ARRAY['Agency social media management', 'Enterprise brand monitoring', 'Multi-account scheduling']
),

(
  'meta-ai',
  'Meta AI',
  'Meta''s AI assistant integrated across WhatsApp, Instagram, Facebook, and Messenger',
  'Meta AI is Meta''s conversational AI assistant, powered by the Llama 4 model family and available directly inside WhatsApp, Instagram, Facebook, and Messenger — as well as through a standalone web interface. The integration into WhatsApp alone gives it access to one of the largest user bases of any AI assistant: users can ask questions, generate images, summarise conversations, and get recommendations without leaving apps they already use daily.

Meta AI is free with no usage limits for core features, which distinguishes it from most AI assistants that require paid subscriptions for their best models. The image generation capability (powered by Imagine with Meta AI) is built directly into group chats and feeds, letting users generate images mid-conversation. In terms of reasoning quality, Llama 4 is competitive with GPT-4o and Claude 3.5 on most benchmarks, and Meta''s open-source release strategy means the underlying model can also be self-hosted or fine-tuned by developers. For individuals already using Meta''s social platforms and who want AI assistance without additional subscriptions, Meta AI is the most frictionless option available in 2026.',
  'https://www.google.com/s2/favicons?domain=meta.ai&sz=64',
  'https://meta.ai',
  'https://meta.ai',
  ARRAY['ai-assistant'],
  'free',
  true,
  0,
  4.3,
  1200,
  false,
  true,
  false,
  ARRAY['Completely free, no limits', 'Integrated into WhatsApp and Instagram', 'Built-in image generation', 'Llama 4 competitive with top models'],
  ARRAY['Privacy concerns with Meta data', 'Less capable than Claude or GPT-4o for complex tasks', 'Limited context window'],
  ARRAY['Quick questions in WhatsApp', 'Image generation in social chats', 'Free alternative to ChatGPT Plus']
),

(
  'anyword',
  'Anyword',
  'AI copywriting platform with predictive performance scores for marketing teams',
  'Anyword is an AI copywriting platform built specifically for marketing teams, with a feature that distinguishes it from generic writing tools: predictive performance scores. Every piece of copy — ad headline, email subject line, landing page header — receives a score predicting how it will perform with a defined target audience before it is published. This lets marketing teams optimise copy based on predicted outcomes rather than guesswork or A/B testing alone.

The platform covers every marketing copywriting format: Facebook and Google ads, email subject lines, landing page copy, product descriptions, blog intros, and social media captions. The Brand Voice feature learns from existing marketing materials to ensure AI-generated copy stays on-brand and consistent with established tone and messaging guidelines. For e-commerce and performance marketing teams who run large volumes of ad copy and need to maintain quality at scale, Anyword''s scoring system is the primary differentiator. It is significantly more expensive than generic AI writing tools like Rytr or Writesonic, which makes it best suited for teams where copywriting directly drives measurable revenue. Companies that have run thousands of ad variations will find the performance data behind Anyword''s predictions particularly valuable.',
  'https://www.google.com/s2/favicons?domain=anyword.com&sz=64',
  'https://anyword.com',
  'https://anyword.com',
  ARRAY['writing-ai', 'seo'],
  'paid',
  false,
  39,
  4.2,
  780,
  false,
  false,
  false,
  ARRAY['Predictive performance scores for copy', 'Brand Voice consistency enforcement', 'Ad copy optimisation across platforms', 'Data-backed copy suggestions'],
  ARRAY['No free tier', 'Expensive compared to alternatives', 'Scoring accuracy varies by niche'],
  ARRAY['Performance marketing copy at scale', 'E-commerce product descriptions', 'Ad headline testing and optimisation']
),

(
  'wordtune',
  'Wordtune',
  'AI writing assistant for rewriting, condensing, and improving existing text',
  'Wordtune is an AI writing assistant that focuses on improving and rewriting existing text rather than generating it from scratch. The core workflow is: paste or type a sentence or paragraph, and Wordtune offers multiple rewrites — varying tone (casual, formal), length (shorter, longer), and style — alongside suggestions to fix grammar, improve clarity, and adjust formality. This makes it particularly useful for non-native English speakers who write competent drafts but want native-level polish, and for professionals who write well but want to write faster.

The Spices feature generates contextual additions to existing text: examples, statistics, counterarguments, and quotes that can be inserted mid-document to add depth without starting from a blank page. Wordtune Read summarises long documents, articles, and PDFs into key points — useful for research workflows where speed of extraction matters more than reading every word. The browser extension works across Gmail, LinkedIn, Notion, Twitter, and most web-based writing environments, making it accessible wherever writing happens without requiring a separate app. For students, professionals, and anyone who spends significant time writing and editing, Wordtune''s rewrite-focused approach is more practical day-to-day than tools that generate long-form content from a brief.',
  'https://www.google.com/s2/favicons?domain=wordtune.com&sz=64',
  'https://wordtune.com',
  'https://wordtune.com',
  ARRAY['writing-ai'],
  'freemium',
  true,
  14,
  4.3,
  950,
  false,
  false,
  false,
  ARRAY['Excellent rewrite and polish suggestions', 'Works across all web apps via extension', 'Condensing and expanding text', 'Document summarisation'],
  ARRAY['Less suited for long-form generation', 'Free plan limited to 10 rewrites/day', 'Not as strong as Grammarly for grammar'],
  ARRAY['Polishing professional emails', 'Improving drafts written by non-native speakers', 'Summarising research documents']
),

(
  'hyperwrite',
  'HyperWrite',
  'AI writing assistant and autonomous agent for research and document creation',
  'HyperWrite is an AI writing and agent tool that sits in a browser extension, making it available in any web-based writing environment — Google Docs, Gmail, LinkedIn, any form or editor. The writing assistance covers completion, rephrasing, and drafting, but HyperWrite''s differentiating feature is the AutoPilot agent: it can perform research tasks autonomously — browsing the web, filling out forms, navigating websites, and gathering information — without requiring the user to stay in the loop for each step.

For research-heavy writing workflows where the bottleneck is information gathering rather than writing itself, HyperWrite''s agent capability compresses multiple steps into a single request. The TypeAhead feature provides inline completions as you type — similar to GitHub Copilot but for natural language writing — offering the next sentence or paragraph before you''ve finished the current one. HyperWrite''s Personas feature lets users define different writing styles for different contexts: a professional persona for business writing, a casual persona for social media. The free tier is functional, though heavy users will encounter rate limits quickly. It is better suited as a day-to-day writing companion than a long-form content creation tool.',
  'https://www.google.com/s2/favicons?domain=hyperwriteai.com&sz=64',
  'https://hyperwriteai.com',
  'https://hyperwriteai.com',
  ARRAY['writing-ai'],
  'freemium',
  true,
  20,
  4.1,
  540,
  false,
  false,
  false,
  ARRAY['Browser extension works everywhere', 'AutoPilot agent for research tasks', 'Inline TypeAhead completions', 'Multiple writing personas'],
  ARRAY['Agent features can be inconsistent', 'Free plan has low rate limits', 'Less polished than Wordtune for editing'],
  ARRAY['Research-driven content writing', 'Automated form filling and data gathering', 'Everyday writing assistance across apps']
),

(
  'replicate',
  'Replicate',
  'Run open-source AI models via API with no infrastructure setup required',
  'Replicate is a cloud platform that makes it trivially easy to run any open-source AI model via API — image generation (Stable Diffusion, Flux, SDXL), language models (Llama, Mistral), audio (Whisper, MusicGen), video (AnimateDiff), and hundreds of community-contributed models — without managing servers, GPUs, or deployment infrastructure. The developer experience is designed around simplicity: generate an API token, call the API with your inputs, receive outputs. Replicate handles GPU provisioning, scaling, and model serving automatically.

For developers building AI-powered applications, Replicate solves a genuine infrastructure problem: the gap between "I want to use this model" and "I have a production API endpoint serving this model" typically requires significant DevOps work. Replicate eliminates that entirely. The pricing is pay-per-use based on compute time, which makes it cost-effective for applications with variable or low traffic compared to running dedicated GPU instances. The model library is one of the most comprehensive available — when a new research model is published, it typically appears on Replicate within days of release. For teams who want to experiment with or productionise any open-source AI model without infrastructure work, Replicate is the fastest path from model to API.',
  'https://www.google.com/s2/favicons?domain=replicate.com&sz=64',
  'https://replicate.com',
  'https://replicate.com',
  ARRAY['code-ai'],
  'freemium',
  true,
  0,
  4.5,
  820,
  false,
  true,
  false,
  ARRAY['Run any open-source model via API', 'No GPU infrastructure required', 'Pay-per-use pricing', 'Largest community model library'],
  ARRAY['Cold starts for low-traffic models', 'Can get expensive at scale vs self-hosting', 'No SLA for free tier'],
  ARRAY['Prototyping with AI models quickly', 'Production APIs for image or audio generation', 'Comparing multiple open-source models']
),

(
  'together-ai',
  'Together AI',
  'Fast, cheap inference API for open-source LLMs including Llama and Mixtral',
  'Together AI is a cloud inference platform focused on open-source large language models, offering fast and cost-competitive API access to Llama 3, Mixtral, Mistral, Code Llama, and dozens of other models. For developers building LLM-powered applications who want the control of open-source models without managing GPU infrastructure, Together AI''s inference API provides the performance and reliability of a commercial API at a significantly lower cost than OpenAI or Anthropic — often 10-20x cheaper per token for equivalent capability models.

The platform supports both serverless and dedicated endpoints. Serverless is appropriate for development and moderate production traffic; dedicated endpoints provide reserved compute for latency-sensitive production applications. Together AI is particularly valued in the developer community for its low latency on Llama 3 70B and Mixtral 8x7B — competitive with much larger proprietary models for coding and instruction-following tasks at a fraction of the price. The platform also supports fine-tuning: organisations can upload proprietary datasets to fine-tune base models on Together AI''s infrastructure and deploy the result as a private API endpoint. For AI engineering teams who prioritise cost efficiency and model control over the convenience of frontier proprietary models, Together AI is the standard alternative to the OpenAI API.',
  'https://www.google.com/s2/favicons?domain=together.ai&sz=64',
  'https://together.ai',
  'https://together.ai',
  ARRAY['code-ai'],
  'freemium',
  true,
  0,
  4.4,
  680,
  false,
  true,
  false,
  ARRAY['Very cheap open-source model inference', 'Low latency on Llama and Mixtral', 'Fine-tuning on custom datasets', 'Serverless and dedicated endpoints'],
  ARRAY['No frontier proprietary models', 'Smaller ecosystem than OpenAI', 'Fine-tuning requires larger budgets'],
  ARRAY['Cost-efficient LLM API for production apps', 'Fine-tuning on proprietary data', 'Alternative to OpenAI API for open-source models']
),

(
  'typeform',
  'Typeform',
  'Conversational form and survey builder with AI-generated questions',
  'Typeform is a form and survey builder built around a conversational, one-question-at-a-time interface that consistently produces significantly higher completion rates than traditional grid-based surveys. The AI features added in 2024-2026 allow users to generate an entire survey from a brief description of their goal — "I want to understand why customers churn" generates a ready-to-publish survey with appropriate question types, logic, and progressions.

The form experience is designed for response quality: by showing one question at a time and using conditional logic to skip irrelevant questions, Typeform respondents complete more questions with more thoughtful answers than equivalent surveys in Google Forms or SurveyMonkey. The integration library connects Typeform responses to CRM platforms (HubSpot, Salesforce), email tools (Mailchimp), and automation platforms (Zapier, Make), making it straightforward to trigger workflows from form submissions. Typeform is the standard tool for user research interviews, NPS surveys, lead qualification, and event registration where response quality matters more than response volume. For high-volume market research at scale, tools like SurveyMonkey may be more cost-effective, but for quality-over-quantity research, Typeform''s completion rates justify the premium.',
  'https://www.google.com/s2/favicons?domain=typeform.com&sz=64',
  'https://typeform.com',
  'https://typeform.com',
  ARRAY['productivity'],
  'freemium',
  true,
  25,
  4.4,
  1650,
  false,
  false,
  false,
  ARRAY['Higher completion rates than traditional forms', 'AI-generated survey from a description', 'Conditional logic for personalised flows', 'Rich integration library'],
  ARRAY['Free plan limited to 10 questions', 'Expensive for high response volumes', 'No native data analysis beyond basic stats'],
  ARRAY['User research and NPS surveys', 'Lead qualification forms', 'Event registration and feedback collection']
),

(
  'streamlit',
  'Streamlit',
  'Python framework for building and sharing AI and data science web apps',
  'Streamlit is an open-source Python framework that lets data scientists and ML engineers turn Python scripts into interactive web applications in hours rather than weeks. The core concept is radical simplicity: write a Python script using Streamlit''s components — charts, sliders, text inputs, dataframes — and running it creates a shareable web app with no HTML, CSS, JavaScript, or backend knowledge required. For AI and data science teams who need to share model results, demonstrate prototypes, or build internal tools, Streamlit eliminates the frontend development bottleneck entirely.

The Streamlit Community Cloud (free hosting) lets users deploy apps directly from a GitHub repository with a single click — no infrastructure configuration, no server management. Apps are immediately accessible via URL and can be shared with stakeholders who have no Python environment. The framework has become the standard tool for sharing ML model demos, data exploration dashboards, and AI research prototypes in the data science community. In 2025-2026, Streamlit is commonly used alongside LLM frameworks like LangChain and Dify to build quick interfaces for AI-powered applications. For teams building production web applications, Streamlit is a prototype tool rather than an end product, but for internal tools and demos, its speed advantage over traditional web development is decisive.',
  'https://www.google.com/s2/favicons?domain=streamlit.io&sz=64',
  'https://streamlit.io',
  'https://streamlit.io',
  ARRAY['code-ai'],
  'free',
  true,
  0,
  4.5,
  1420,
  false,
  false,
  false,
  ARRAY['Build web apps from Python with no frontend', 'Free hosting on Community Cloud', 'Huge component and plugin ecosystem', 'Standard for ML model demos'],
  ARRAY['Not for production-grade web apps', 'Performance limits with large datasets', 'UI customisation is limited'],
  ARRAY['Sharing ML model demos with stakeholders', 'Internal data exploration dashboards', 'Rapid AI prototype development']
)

ON CONFLICT (slug) DO NOTHING;
