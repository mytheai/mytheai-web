-- tools-batch-7.sql
-- 10 new tools: Presentations, AI Aggregators, Meeting, Social, Documentation
-- Run in Supabase SQL Editor

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

(
  'tome',
  'Tome',
  'AI-native presentation and storytelling tool built for narrative content',
  E'Tome is an AI-powered presentation platform built specifically for narrative storytelling rather than traditional slide-by-slide structure. Unlike PowerPoint or Google Slides, Tome generates fluid, page-based documents that blend text, AI-generated images, embedded web content, and data visualisations into a cohesive narrative. The AI generates complete presentations from a text brief — including image selection, layout decisions, and written content — making it significantly faster than building slides from scratch. The output is a shareable web link rather than a downloadable file, which means presentations are always up to date and accessible without software.\n\nTome is popular among founders presenting to investors, sales teams creating one-pagers, and marketing professionals who want beautifully designed narrative content without a designer. The AI image generation is built in and applies automatically to complement the written content. The collaborative features allow team members to comment and edit in real time. The free plan includes unlimited AI-generated content. The Pro plan at $8 per month adds custom branding, analytics showing who viewed your presentation and for how long, and removes Tome branding from shared links.',
  'https://www.google.com/s2/favicons?domain=tome.app&sz=64',
  'https://tome.app',
  'https://tome.app',
  ARRAY['productivity', 'content'],
  'freemium', true, 8,
  4.4, 980, false, true, false,
  ARRAY['Generates complete narrative presentations from a brief', 'Built-in AI image generation included', 'Shareable web link — always current, no file downloads', 'Viewer analytics on Pro plan'],
  ARRAY['Less suited to traditional slide-format corporate presentations', 'Less control over precise layout than PowerPoint', 'Branding on all free-tier shared links'],
  ARRAY['Investor pitches and startup storytelling', 'Sales one-pagers and proposal narratives', 'Marketing reports and campaign recaps', 'Thought leadership and content presentations']
),

(
  'poe',
  'Poe',
  'Access ChatGPT, Claude, Gemini, and 100+ AI models in one app',
  E'Poe is an AI model aggregator built by Quora that gives users access to over 100 AI models — including ChatGPT (GPT-4o), Claude, Gemini, Llama, Mistral, and many others — through a single subscription. Instead of paying separately for ChatGPT Plus, Claude Pro, and Gemini Advanced, Poe provides access to all of them through one interface with a unified credit system. Users can compare outputs across models for the same prompt, switch models mid-conversation, and create custom AI bots built on any underlying model with system prompts and knowledge bases.\n\nPoe is particularly useful for power users who want to experiment with different models for different tasks — using Claude for writing, GPT-4o for coding, and Perplexity-style search models for research — without managing multiple subscriptions and interfaces. The bot creation feature has generated a large ecosystem of community-built specialised assistants. The free tier provides limited daily access to most models. The Poe subscription at $19.99 per month provides high message limits across all supported models including the most capable frontier models from every major provider.',
  'https://www.google.com/s2/favicons?domain=poe.com&sz=64',
  'https://poe.com',
  'https://poe.com',
  ARRAY['ai-assistant'],
  'freemium', true, 20,
  4.3, 1560, false, false, false,
  ARRAY['Access 100+ AI models including GPT-4o, Claude, and Gemini in one app', 'Custom bot creation with system prompts and knowledge bases', 'Compare model outputs side by side', 'One subscription replaces multiple individual model subscriptions'],
  ARRAY['Credit system can be confusing — different models cost different amounts', 'Interface less polished than dedicated apps like Claude or ChatGPT', 'Best models still require paid subscription'],
  ARRAY['Comparing AI model outputs for research and writing tasks', 'Power users who need multiple frontier models regularly', 'Discovering specialised community-built AI assistants', 'Evaluating which AI model best fits a specific use case']
),

(
  'tldv',
  'tl;dv',
  'AI meeting recorder that timestamps, transcribes, and clips your calls',
  E'tl;dv is an AI meeting recorder and intelligence tool that captures, transcribes, and summarises video calls on Zoom, Google Meet, and Microsoft Teams. Every meeting is automatically timestamped, making it easy to navigate recordings and jump to specific moments — speaker changes, decisions, and action items are all tagged. The AI generates a structured summary immediately after the meeting ends, and users can clip specific moments from the transcript to share with team members who did not attend. Integration with Notion, Slack, Salesforce, and HubSpot means meeting highlights can be pushed directly into the tools where teams work without manual copy-pasting.\n\ntl;dv differentiates from alternatives like Fathom by its reporting features: cross-meeting insights show patterns across multiple calls — recurring topics, common objections in sales calls, frequently mentioned competitor names — giving managers and revenue teams intelligence that goes beyond individual meeting summaries. The free plan is generous, supporting unlimited recordings and AI summaries with up to three AI reports per month. The Pro plan at $18 per user per month adds unlimited AI reports, CRM integration, and custom automation triggers for post-meeting workflows.',
  'https://www.google.com/s2/favicons?domain=tldv.io&sz=64',
  'https://tldv.io',
  'https://tldv.io',
  ARRAY['productivity'],
  'freemium', true, 18,
  4.5, 1340, false, false, false,
  ARRAY['Unlimited recordings and summaries on the free plan', 'Cross-meeting insights and pattern detection', 'Clip and share specific moments from transcripts', 'Direct integration with Notion, Slack, Salesforce, HubSpot'],
  ARRAY['Advanced CRM integration on paid plan only', 'Cross-meeting reports limited on free tier', 'Bot joining calls may feel intrusive to some participants'],
  ARRAY['Sales teams tracking objections and competitor mentions across calls', 'Capturing decisions and action items from meetings automatically', 'Sharing meeting highlights with team members who missed the call', 'Revenue operations teams building cross-call intelligence']
),

(
  'scribe',
  'Scribe',
  'Automatically generate step-by-step how-to guides from any workflow',
  E'Scribe is a documentation automation tool that captures any process you perform on your screen and automatically generates a formatted step-by-step guide — with screenshots, annotations, and written instructions — without any manual documentation effort. Users install the Scribe browser extension or desktop app, click Record, complete the process they want to document, and stop recording. Scribe produces a shareable, editable guide in seconds that covers every click, input, and navigation step with annotated screenshots matching each action.\n\nScribe is widely adopted by operations teams, customer success departments, and HR teams who need to create and maintain large libraries of process documentation. Onboarding new employees, building customer help centre articles, and creating standard operating procedures all become significantly faster when the documentation writes itself from the actual workflow. Guides can be embedded in Notion, Confluence, and other knowledge bases, or shared as standalone links. The free plan supports unlimited guides with Scribe branding. The Pro plan at $23 per user per month removes branding, adds custom branding, enables team collaboration features, and unlocks advanced editing and export options.',
  'https://www.google.com/s2/favicons?domain=scribehow.com&sz=64',
  'https://scribehow.com',
  'https://scribehow.com',
  ARRAY['productivity'],
  'freemium', true, 23,
  4.6, 1780, false, false, false,
  ARRAY['Generates step-by-step guides automatically from screen recording', 'Annotated screenshots for every action — no manual capture needed', 'Embeds directly into Notion, Confluence, and knowledge bases', 'Dramatically faster than manual documentation'],
  ARRAY['Scribe branding on all free-plan guides', 'Works best for click-based workflows — less suited to conversational processes', 'Pro plan required for team features and custom branding'],
  ARRAY['Creating employee onboarding documentation automatically', 'Building help centre articles from support workflows', 'Documenting SOPs for operations and customer success teams', 'Capturing software tutorials and training materials']
),

(
  'character-ai',
  'Character.ai',
  'Create and chat with AI characters for entertainment, learning, and roleplay',
  E'Character.ai is a platform for creating and interacting with AI characters — fictional personas, historical figures, celebrities, original creations — in open-ended conversation. Each character has a distinct personality, backstory, and conversational style that the AI maintains consistently throughout the interaction. Users can explore existing characters created by the community or build their own characters with custom personalities and knowledge. The platform has a particularly strong following among younger users for entertainment, creative writing assistance, and informal language practice.\n\nCharacter.ai is distinct from productivity-focused AI tools in its emphasis on character consistency and emotional engagement. The platform''s creator tools allow detailed character configuration including personality traits, example dialogue, and scenario framing. Teachers use it for historical figure simulations; writers use it for character development and dialogue testing; language learners use it for low-stakes conversation practice. The free plan provides access to most characters with occasional wait times during peak hours. Character.ai Plus at $9.99 per month removes wait times, enables priority access to newer models, and unlocks advanced character customisation features.',
  'https://www.google.com/s2/favicons?domain=character.ai&sz=64',
  'https://character.ai',
  'https://character.ai',
  ARRAY['ai-assistant'],
  'freemium', true, 10,
  4.2, 4200, false, false, false,
  ARRAY['Thousands of community-created characters to explore', 'Strong character consistency across long conversations', 'Creator tools for custom character building', 'Free plan with broad access to the character library'],
  ARRAY['Not suited for factual research or professional tasks', 'Content moderation limits some character scenarios', 'AI quality inconsistent across different character creators'],
  ARRAY['Creative writing and character development for fiction writers', 'Casual language learning and conversation practice', 'Historical figure simulations for education', 'Entertainment and interactive storytelling']
),

(
  'stable-diffusion',
  'Stable Diffusion',
  'Open-source AI image generation model for unlimited local use',
  E'Stable Diffusion is an open-source text-to-image AI model that can be run locally on a personal computer with a compatible GPU, giving users unlimited image generation with no subscription fees, API costs, or content restrictions. Unlike hosted tools such as Midjourney or DALL-E, Stable Diffusion gives users complete control over the model, allowing fine-tuning on custom datasets, installation of community-created model checkpoints, and use of ControlNet for precise compositional control. The model is the foundation for thousands of community-built specialised models covering specific artistic styles, character types, photography simulations, and product design.\n\nFor technical users and power users who want maximum control and customisation over AI image generation, Stable Diffusion is unmatched. The active community has built extensive tools including Automatic1111, ComfyUI, and Forge for running the model, alongside thousands of plugins for specific workflows. The trade-off is a significant setup barrier: installation requires technical comfort, a capable GPU, and ongoing maintenance as models and tools update. Hosted versions of Stable Diffusion are available through platforms like Stability AI DreamStudio, providing the base model without local setup at a pay-per-use rate. The open-source model itself is free to download and run.',
  'https://www.google.com/s2/favicons?domain=stability.ai&sz=64',
  'https://stability.ai',
  'https://stability.ai',
  ARRAY['image-ai'],
  'free', true, 0,
  4.3, 2800, false, false, false,
  ARRAY['Completely free to run locally with no usage limits', 'Full control over model weights, fine-tuning, and customisation', 'Thousands of community models for specific styles and use cases', 'No content restrictions when self-hosted'],
  ARRAY['Requires a capable GPU and technical setup to run locally', 'Steeper learning curve than hosted image generators', 'Ongoing maintenance required as ecosystem tools update'],
  ARRAY['Unlimited image generation without API costs for developers', 'Fine-tuning on proprietary datasets for brand-specific imagery', 'Research and experimentation with AI image generation models', 'Advanced users wanting maximum control over the generation process']
),

(
  'hugging-face',
  'Hugging Face',
  'The open-source AI platform for sharing, discovering, and running ML models',
  E'Hugging Face is the central hub of the open-source AI ecosystem, hosting over 500,000 models, 100,000 datasets, and tens of thousands of AI applications (Spaces) that developers can use, fork, and deploy. It functions simultaneously as a model repository (GitHub for AI), a dataset repository, a code hosting platform for ML applications, and a deployment infrastructure for serving AI models at scale. Hugging Face''s Transformers library is the most widely used Python library for working with large language models, and the platform is where most open-source AI models — Llama, Mistral, Stable Diffusion variants, Whisper, and thousands more — are officially distributed.\n\nFor developers building AI applications, Hugging Face is often the starting point: find a suitable base model, evaluate it against benchmarks, and deploy it via the Inference API or a dedicated Endpoint without managing infrastructure. The platform is free for public repositories and models. The Pro subscription at $9 per month adds private repositories and higher Inference API usage limits. Enterprise Hub plans for teams provide private infrastructure, role-based access, and SLA-backed deployment for production AI systems. For the AI developer community, Hugging Face is as fundamental as GitHub is to software development.',
  'https://www.google.com/s2/favicons?domain=huggingface.co&sz=64',
  'https://huggingface.co',
  'https://huggingface.co',
  ARRAY['code-ai', 'research'],
  'freemium', true, 9,
  4.6, 2100, false, false, false,
  ARRAY['Central repository for 500,000+ open-source models and datasets', 'Transformers library is the standard for working with LLMs in Python', 'Inference API for running models without infrastructure management', 'Free for public models and community use'],
  ARRAY['Enterprise features require significant budget', 'Technical knowledge required to use effectively', 'Model quality varies enormously across community contributions'],
  ARRAY['Discovering and evaluating open-source AI models for projects', 'Deploying models via Inference API without self-hosting', 'Sharing fine-tuned models with the community', 'Benchmarking and comparing model performance before production use']
),

(
  'buffer',
  'Buffer',
  'Social media scheduling and analytics with AI-assisted content creation',
  E'Buffer is a social media management platform that helps individuals and small teams plan, schedule, and analyse content across Instagram, Facebook, X (Twitter), LinkedIn, TikTok, Pinterest, and YouTube. The scheduling interface is straightforward and visual — content can be added to a queue that automatically posts at optimal times, or scheduled to specific time slots. Buffer''s AI assistant generates post drafts and caption variations from a brief, suggests hashtags, and can rewrite content for different platforms and audiences, reducing the time spent adapting the same content across channels.\n\nBuffer is positioned as the clean, user-friendly alternative to enterprise tools like Hootsuite, with pricing and interface complexity appropriate for creators, freelancers, startups, and small marketing teams. The analytics dashboard shows engagement rates, click-through rates, and follower growth at the post level, giving enough data to identify what performs without the complexity of enterprise analytics platforms. The free plan supports up to three social channels with limited scheduling per channel. The Essentials plan at $6 per channel per month removes scheduling limits and unlocks the analytics suite. Teams can manage multiple channels and clients on the Team plan with collaboration and approval workflows.',
  'https://www.google.com/s2/favicons?domain=buffer.com&sz=64',
  'https://buffer.com',
  'https://buffer.com',
  ARRAY['content', 'productivity'],
  'freemium', true, 6,
  4.2, 2400, false, false, false,
  ARRAY['Supports all major social platforms including TikTok and YouTube', 'AI post drafting and platform-specific caption adaptation', 'Clean, simple interface appropriate for small teams', 'Free plan covers three channels for basic scheduling'],
  ARRAY['Analytics less deep than enterprise tools', 'Free plan limited to 10 scheduled posts per channel', 'Less suited to high-volume agency workflows with many clients'],
  ARRAY['Solo creators and small teams scheduling consistent social content', 'Adapting content across platforms with AI-assisted rewrites', 'Tracking which social posts drive the most engagement', 'Freelancers managing multiple client social accounts']
),

(
  'tidio',
  'Tidio',
  'AI customer service chatbot and live chat for e-commerce websites',
  E'Tidio is a customer service platform that combines live chat, AI chatbot automation, and email marketing in a single tool designed for e-commerce and small business websites. Its Lyro AI chatbot handles customer enquiries automatically — answering product questions, tracking orders, processing returns, and resolving common support issues without human intervention. Lyro learns from existing support content and can handle up to 70% of routine customer enquiries automatically, reducing the volume that reaches human agents. The handoff to a live agent is smooth when queries exceed the chatbot''s capability.\n\nTidio integrates natively with Shopify, WooCommerce, and BigCommerce, connecting to order data so the AI can answer "Where is my order?" questions accurately. The visitor intelligence features show which pages a customer viewed before starting a chat, enabling agents to personalise the conversation with context. Installation is a single script tag — no developer involvement required after initial setup. The free plan supports 50 live chat conversations per month and a limited number of Lyro AI responses. The Lyro AI plan starts at $29 per month for higher automated conversation volumes. The Growth plan at $59 per month adds email marketing, advanced analytics, and higher live chat capacity.',
  'https://www.google.com/s2/favicons?domain=tidio.com&sz=64',
  'https://tidio.com',
  'https://tidio.com',
  ARRAY['productivity'],
  'freemium', true, 29,
  4.3, 1890, false, false, false,
  ARRAY['Lyro AI handles up to 70% of routine enquiries automatically', 'Native Shopify, WooCommerce, and BigCommerce integration', 'Order tracking and return processing via AI chat', 'Single-script installation — no developer required'],
  ARRAY['Lyro AI response limits require paid plan for meaningful volume', 'Email marketing features less powerful than dedicated tools', 'Analytics less granular than enterprise customer service platforms'],
  ARRAY['E-commerce stores automating common customer support questions', 'Shopify merchants reducing support ticket volume', 'Small businesses adding 24/7 AI chat without hiring agents', 'Handling order status and return queries at scale']
),

(
  'adobe-acrobat-ai',
  'Adobe Acrobat AI',
  'AI Assistant built into Acrobat for summarising and querying PDF documents',
  E'Adobe Acrobat AI Assistant is an AI feature integrated directly into Adobe Acrobat that allows users to ask questions about, summarise, and extract information from PDF documents in natural language. Uploaded PDFs become queryable: ask "What are the key terms of this contract?", "Summarise the executive summary", or "What does section 4.2 say about liability?" and the AI returns an accurate, cited response. This transforms static PDF documents into interactive information sources without requiring manual reading of the entire document. Citations link back to the exact passage in the original PDF for verification.\n\nAcrobat AI Assistant works across any PDF content — legal contracts, research papers, financial reports, technical manuals, and government documents — making it particularly valuable for professionals who regularly work with long or complex PDF files. The feature integrates into existing Acrobat workflows without learning a new application. Microsoft 365 and Google Drive connections allow querying documents stored in those platforms directly from Acrobat. The AI Assistant is included in Acrobat Standard and Pro subscriptions (starting at $14.99/month and $23.99/month respectively) alongside existing PDF editing, signing, and collaboration features.',
  'https://www.google.com/s2/favicons?domain=adobe.com&sz=64',
  'https://adobe.com/acrobat/ai-assistant.html',
  'https://adobe.com/acrobat',
  ARRAY['productivity', 'research'],
  'paid', false, 15,
  4.3, 1200, false, false, false,
  ARRAY['Integrated directly into Acrobat — no new app to learn', 'Cited answers link back to source passages in the PDF', 'Works with any PDF content including scanned documents', 'Connects to Microsoft 365 and Google Drive'],
  ARRAY['Requires an Acrobat subscription — no standalone free version', 'Best for PDF specifically — not a general document AI tool', 'AI responses may miss nuance in highly technical or legal content'],
  ARRAY['Reviewing and summarising long legal contracts', 'Extracting key information from research papers and reports', 'Answering questions from technical manuals and compliance documents', 'Processing financial statements and regulatory filings quickly']
)

ON CONFLICT (slug) DO NOTHING;
