-- tools-batch-16.sql
-- 10 new tools: wordware, cline, firecrawl, hailuo, veo, flux, adobe-lightroom-ai, shorts-ai, venice-ai, trae
-- DB: ~182 -> ~192 after running
-- Pattern: ON CONFLICT (slug) DO NOTHING (idempotent)
-- Run in Supabase SQL Editor

INSERT INTO tools (
  slug, name, tagline, description,
  website_url, logo_url, affiliate_url,
  pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count,
  tags, pros, cons, use_cases,
  featured, trending, editor_pick
) VALUES

(
  'wordware',
  'Wordware',
  'Build AI agents with plain English, no code required',
  'Wordware is a no-code AI agent builder that lets teams create, deploy, and iterate on AI workflows using natural language. Instead of writing Python or JSON-based prompts, you describe what you want the agent to do in plain English, and Wordware handles the execution logic, tool calling, and output formatting. It is designed for product teams, operators, and technical founders who want to ship AI features quickly without deep engineering resources.

The platform supports building multi-step agents that can browse the web, call APIs, run code, and chain reasoning steps together. Teams at startups and enterprises use Wordware to automate research tasks, customer support flows, data enrichment pipelines, and content generation workflows. The visual builder shows each step of the agent''s reasoning, making it easier to debug and improve prompts over time. Wordware connects to popular tools via integrations and webhooks, and agents can be deployed as API endpoints or embedded into existing products. Pricing is usage-based with a free tier for development.',
  'https://wordware.ai', NULL, 'https://wordware.ai',
  'freemium', true, NULL,
  4.4, 180,
  ARRAY['code-ai', 'productivity'],
  ARRAY['No-code agent building with natural language', 'Multi-step agents with web browsing and API calls', 'Visual debugger shows agent reasoning step-by-step', 'Deploys agents as API endpoints instantly'],
  ARRAY['Less control than code-based frameworks for complex logic', 'Newer platform with smaller ecosystem', 'Free tier limits may require upgrade quickly'],
  ARRAY['Automate research and data enrichment workflows', 'Build customer support agents without engineering', 'Create internal AI tools for non-technical teams'],
  false, true, false
),

(
  'cline',
  'Cline',
  'Open-source AI coding agent that works inside VS Code',
  'Cline is an open-source AI coding agent that runs directly inside Visual Studio Code and can autonomously write code, run terminal commands, browse the web, and edit files to complete complex software engineering tasks. Unlike GitHub Copilot or Cursor which primarily provide suggestions, Cline takes a more agentic approach - you describe a task and Cline plans and executes the steps needed to complete it, showing you each action before it runs for approval.

Cline supports multiple AI providers including Anthropic Claude, OpenAI GPT-4o, and local models via Ollama, giving developers control over which model backs the agent. It can read and write any file in your project, execute shell commands, install packages, and even open a browser to test running applications. The open-source nature means active community development and no vendor lock-in. Cline is particularly popular among developers who want agentic code assistance without switching IDEs or paying for a managed product. Because it uses bring-your-own API keys, cost depends entirely on model usage - there is no separate Cline subscription fee.',
  'https://cline.bot', NULL, 'https://cline.bot',
  'free', true, NULL,
  4.5, 620,
  ARRAY['code-ai'],
  ARRAY['Fully open-source with no subscription cost', 'Agentic task execution with human-in-the-loop approval', 'Supports multiple AI providers including local models', 'Runs natively in VS Code without switching tools'],
  ARRAY['Requires API keys from AI providers - costs accrue per use', 'Less polished UX than commercial alternatives', 'Agentic execution can make mistakes that require manual rollback'],
  ARRAY['Complete multi-file coding tasks end-to-end', 'Automate repetitive development tasks like test writing', 'Debug complex issues with autonomous investigation'],
  false, true, false
),

(
  'firecrawl',
  'Firecrawl',
  'Turn websites into clean data for AI applications',
  'Firecrawl is a web scraping and crawling API designed specifically for feeding structured data into AI applications and LLM pipelines. It converts any website or web page into clean markdown or structured JSON that can be consumed directly by language models, embeddings pipelines, or RAG systems. Unlike traditional scrapers that return raw HTML requiring additional parsing, Firecrawl extracts meaningful content and removes navigation, ads, and boilerplate automatically.

The API supports single-page scraping, full site crawling with configurable depth limits, and batch URL processing. It handles JavaScript-rendered pages, respects robots.txt, manages rate limiting, and includes proxy rotation for reliable data collection at scale. Firecrawl is used by AI engineers building knowledge bases, competitive intelligence tools, research assistants, and data enrichment pipelines. The developer-focused documentation and SDKs for Python, JavaScript, and Go make integration straightforward. A free tier provides limited scraping credits, with paid plans scaling from $16 per month for higher volume. For teams building AI products that need reliable, LLM-ready web data, Firecrawl significantly reduces the engineering effort required.',
  'https://firecrawl.dev', NULL, 'https://firecrawl.dev',
  'freemium', true, 16,
  4.5, 390,
  ARRAY['code-ai', 'research'],
  ARRAY['Returns clean markdown ready for LLM consumption', 'Handles JavaScript-rendered pages reliably', 'Batch crawling with configurable depth and rate limits', 'SDKs for Python, JavaScript, and Go'],
  ARRAY['Free tier credits are limited for production use', 'Not designed for scraping highly dynamic single-page apps', 'Costs scale with volume - high-crawl workloads can get expensive'],
  ARRAY['Build knowledge bases from web content for RAG systems', 'Automate competitive intelligence data collection', 'Feed structured website data into AI enrichment pipelines'],
  false, true, false
),

(
  'hailuo',
  'Hailuo AI',
  'High-quality AI video generation from MiniMax',
  'Hailuo AI is a video generation platform developed by MiniMax that produces cinematic-quality short videos from text prompts or image inputs. It has gained significant attention for its realistic motion, coherent scene composition, and ability to maintain subject consistency across frames - areas where many competing video generators still struggle. Hailuo supports text-to-video, image-to-video, and video extension features, making it a versatile tool for content creators, marketing teams, and filmmakers experimenting with AI-assisted production.

The platform offers a web interface that requires no technical setup - you write a prompt, configure the style and motion settings, and receive a generated video clip within minutes. Output quality is competitive with Runway and Kling at a lower price point, which has driven rapid adoption among creators who need high-quality video without the budget for premium tools. Hailuo offers a free daily generation quota and paid plans for higher volume and longer clips. For social media creators, agencies, and marketing teams producing short-form video content at scale, Hailuo represents strong value relative to its output quality.',
  'https://hailuoai.video', NULL, 'https://hailuoai.video',
  'freemium', true, NULL,
  4.3, 310,
  ARRAY['video-ai'],
  ARRAY['Competitive video quality with realistic motion', 'Supports text-to-video and image-to-video modes', 'Free daily generation quota for regular use', 'Fast generation times compared to some alternatives'],
  ARRAY['Limited clip length on free and lower-tier plans', 'Less community and template library than established tools', 'Style control less granular than Runway or Kling'],
  ARRAY['Generate short-form social media video content', 'Create product demo or promotional video clips', 'Experiment with AI video for creative direction and storyboarding'],
  false, true, false
),

(
  'veo',
  'Veo',
  'Google DeepMind''s AI video generation model',
  'Veo is Google DeepMind''s video generation model, designed to create high-definition video clips from text prompts and image inputs. It produces videos at 1080p resolution with accurate interpretation of cinematic language - prompts specifying camera angles, lighting conditions, and visual styles are rendered with a level of fidelity that reflects the scale of training data and compute behind the model. Veo is integrated into Google products including YouTube Shorts creation tools and is available to developers via Google Cloud.

The model is notable for its ability to maintain consistency across longer video sequences and handle complex prompt instructions involving multiple subjects, actions, and environmental details simultaneously. Veo is positioned for professional use - filmmakers, advertising agencies, and large content teams who need controllable, high-quality output. Access is currently available through Google Labs, the VideoFX experimental product, and the Vertex AI API for enterprise customers. Pricing is usage-based through Google Cloud, with pricing per second of generated video. As Google continues to roll out Veo more broadly, it is expected to become a central part of the Google Workspace and YouTube creator ecosystem.',
  'https://deepmind.google/technologies/veo', NULL, 'https://deepmind.google/technologies/veo',
  'freemium', true, NULL,
  4.4, 250,
  ARRAY['video-ai'],
  ARRAY['1080p output with accurate cinematic prompt interpretation', 'Backed by Google DeepMind research and infrastructure', 'Integrates with Google Cloud and YouTube ecosystem', 'Strong consistency across longer video sequences'],
  ARRAY['Access still limited - not available to all users globally', 'Enterprise pricing through Google Cloud can be expensive', 'Less community-driven than independent platforms'],
  ARRAY['Generate professional video content for advertising and marketing', 'Create YouTube Shorts and social media video clips', 'Prototype film concepts and visual storyboards with AI'],
  false, false, false
),

(
  'flux',
  'Flux',
  'State-of-the-art open image generation model by Black Forest Labs',
  'Flux is a family of image generation models developed by Black Forest Labs, the team behind Stable Diffusion. Released in 2024, Flux models represent a significant quality improvement over previous generations - producing images with better text rendering, more accurate anatomy, improved prompt adherence, and more photorealistic output than Stable Diffusion or earlier SDXL models. The models are available in multiple variants: Flux.1 Schnell (fast, permissive license), Flux.1 Dev (higher quality, non-commercial), and Flux.1 Pro (highest quality, API-only).

Flux is accessible through the Black Forest Labs API, through platforms like Replicate and fal.ai, and through local inference tools for users with capable hardware. Because the core models are open-weight, Flux has been rapidly adopted by the developer community and is available as a generation backend in many third-party applications and ComfyUI workflows. For commercial use, the Flux.1 Pro API provides the best output quality with usage-based pricing. For developers building image generation features into applications, Flux offers a meaningful quality upgrade over older models while remaining accessible through standard APIs.',
  'https://blackforestlabs.ai', NULL, 'https://blackforestlabs.ai',
  'freemium', true, NULL,
  4.6, 480,
  ARRAY['image-ai'],
  ARRAY['State-of-the-art image quality with better text and anatomy rendering', 'Open-weight models available for local deployment', 'Multiple tiers for different quality and licensing needs', 'Strong community adoption with ComfyUI and other tools'],
  ARRAY['Pro model is API-only with usage costs', 'Local deployment requires capable GPU hardware', 'Non-commercial restrictions on Dev model'],
  ARRAY['Generate high-quality product and commercial images via API', 'Build image generation features into web and mobile applications', 'Create artwork, illustrations, and concept visuals locally'],
  false, true, false
),

(
  'adobe-lightroom-ai',
  'Adobe Lightroom AI',
  'Professional photo editing with AI-powered adjustments',
  'Adobe Lightroom is the professional standard for photo editing and management, and its AI features have transformed what is possible in a non-destructive editing workflow. The AI Masking tools can isolate specific elements in a photo - sky, subject, background, objects - with a single click and apply targeted adjustments to each area independently. Denoise AI removes grain from high-ISO images while preserving sharpness. Generative Remove erases unwanted objects from backgrounds using Firefly-powered content-aware fill. These features alone save professional photographers hours of manual masking work per shoot.

Lightroom is available as part of the Adobe Creative Cloud Photography plan, which includes both Lightroom and Photoshop for $9.99 per month. The mobile app is included and syncs edits across devices, making it practical for photographers who edit on the go. The AI-powered features are updated regularly as Adobe integrates new Firefly model capabilities into the editing workflow. For photographers, content creators, and visual brands who shoot with a camera and need professional-grade editing tools, Lightroom remains the most complete AI-assisted photo editing environment available.',
  'https://lightroom.adobe.com', NULL, 'https://lightroom.adobe.com',
  'paid', false, 9.99,
  4.7, 890,
  ARRAY['image-ai', 'design'],
  ARRAY['Industry-standard RAW file editing with non-destructive workflow', 'AI Masking isolates sky, subject, objects in one click', 'Generative Remove erases objects with Firefly-powered fill', 'Cross-device sync between desktop and mobile apps'],
  ARRAY['No free tier - requires Creative Cloud subscription', 'AI features require internet connection even for local files', 'Learning curve for photographers new to Lightroom''s panel system'],
  ARRAY['Edit professional photography with AI-assisted masking and adjustments', 'Remove unwanted objects from photos using generative AI', 'Manage and organize large photo libraries with smart categorization'],
  false, false, false
),

(
  'shorts-ai',
  'Shorts AI',
  'Turn long videos into viral short clips automatically',
  'Shorts AI is a video repurposing tool that automatically converts long-form videos into short, engaging clips optimized for TikTok, Instagram Reels, and YouTube Shorts. The AI analyzes the source video to identify the most engaging moments, trims them into standalone clips, reformats the aspect ratio for vertical playback, and adds animated captions styled for social media. The result is a batch of ready-to-post short-form clips produced from a single long video in minutes.

The platform is designed for content creators, podcasters, and marketing teams who produce long-form video content and want to extend its reach without spending hours in a video editor. Shorts AI supports YouTube URL imports, direct video uploads, and batch processing for multiple videos simultaneously. Caption styling options include several preset looks popular on TikTok, and the AI prioritizes clips based on estimated engagement potential. Pricing starts at approximately $19 per month for a creator plan, with higher tiers for agencies and teams processing larger volumes. For creators whose growth strategy depends on short-form content, Shorts AI reduces the time cost of repurposing to a fraction of manual editing.',
  'https://shortsai.app', NULL, 'https://shortsai.app',
  'freemium', true, 19,
  4.2, 210,
  ARRAY['video-ai'],
  ARRAY['Automatic clip selection based on engagement potential', 'Animated captions in popular TikTok and Reels styles', 'Batch processing for multiple videos at once', 'Direct YouTube URL import - no manual download needed'],
  ARRAY['Less control over clip selection than manual editing', 'Occasional errors in clip boundary selection on complex content', 'Fewer advanced features than Opus Clip or Klap'],
  ARRAY['Repurpose podcast episodes into social media shorts', 'Turn webinar recordings into shareable clip libraries', 'Create TikTok and Reels content from YouTube videos automatically'],
  false, false, false
),

(
  'venice-ai',
  'Venice AI',
  'Private AI assistant that never logs your conversations',
  'Venice AI is a privacy-first AI assistant and image generation platform that runs AI models without storing user conversations, training on user data, or sharing information with third parties. Unlike mainstream AI tools that log interactions for model improvement, Venice processes conversations without retention - your prompts and responses are not saved after the session ends. This makes it appealing for professionals, journalists, and privacy-conscious users who want AI assistance without leaving a data trail.

Venice provides access to powerful open-source models including Llama 3, Mistral, and image generation models, all processed on infrastructure that the company claims does not log user data. The interface is similar to ChatGPT with a chat history stored locally in your browser rather than on Venice servers. Image generation is included in the paid plan. Venice positions itself as an alternative for users who find the privacy policies of OpenAI, Anthropic, and Google to be insufficient for their professional or personal needs. A free tier offers limited daily messages, while the Pro plan at $12.99 per month removes limits and adds image generation. For users who prioritize confidentiality in their AI interactions, Venice offers a credible and functional alternative to mainstream providers.',
  'https://venice.ai', NULL, 'https://venice.ai',
  'freemium', true, 12.99,
  4.2, 190,
  ARRAY['ai-assistants'],
  ARRAY['No conversation logging or data retention after session', 'Access to powerful open-source models including Llama 3', 'Image generation included in paid plan', 'Local browser-based chat history instead of server storage'],
  ARRAY['Smaller model selection than mainstream providers', 'Less capable than GPT-4o or Claude for complex reasoning tasks', 'Privacy claims require trusting the company''s technical implementation'],
  ARRAY['Discuss sensitive business or legal topics without data retention risk', 'Generate confidential documents and analysis without cloud logging', 'Access AI assistance for privacy-sensitive research and writing'],
  false, false, false
),

(
  'trae',
  'Trae',
  'AI-native IDE from ByteDance for faster software development',
  'Trae is an AI-native integrated development environment developed by ByteDance, the company behind TikTok. It is designed as a complete code editor with deep AI integration built into the core experience rather than added as a plugin. Trae includes an AI chat panel for code explanation and debugging, inline code completion, an autonomous agent mode for executing multi-step coding tasks, and a Builder mode for generating entire project structures from a description. The editor is built on a VS Code-compatible base, so existing VS Code extensions and keyboard shortcuts work without modification.

Trae supports Claude and GPT-4o as backend models with a generous free usage allowance that includes access to frontier models at no cost - a significant differentiator from Cursor and Windsurf which charge for premium model access. The agent mode can read and write files, run terminal commands, and iterate on code autonomously, similar to Cursor''s Composer or Cline. Trae is newer than established alternatives and its ecosystem is smaller, but the free access to strong models makes it an attractive option for developers who want agentic coding assistance without a monthly subscription. Available on macOS and Windows.',
  'https://trae.ai', NULL, 'https://trae.ai',
  'freemium', true, NULL,
  4.3, 340,
  ARRAY['code-ai'],
  ARRAY['Free access to Claude and GPT-4o with generous usage limits', 'VS Code-compatible - existing extensions work immediately', 'Autonomous agent mode for multi-step coding tasks', 'Built-in Builder mode for project scaffolding from descriptions'],
  ARRAY['Newer platform with smaller community and fewer resources', 'Agent mode less mature than Cursor Composer', 'Less established trust than competitors with longer track records'],
  ARRAY['Write and debug code with AI assistance in a complete IDE', 'Use autonomous agent to complete multi-file coding tasks', 'Scaffold new projects with AI-generated structure and boilerplate'],
  false, true, false
)

ON CONFLICT (slug) DO NOTHING;
