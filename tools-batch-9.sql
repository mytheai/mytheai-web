-- tools-batch-9.sql
-- 10 new tools: udio, langchain, pinecone, adobe-photoshop, you-com, pi, vapi, krea-ai, magnific, microsoft-365-copilot
-- DB: 113 → 123 after running
-- Safe to re-run (ON CONFLICT DO NOTHING)

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

(
  'udio',
  'Udio',
  'AI music generation platform that creates full songs from text prompts',
  E'Udio is an AI music generation platform that produces complete, radio-quality songs from text descriptions — including vocals, instrumentals, and lyrics — in seconds. Enter a genre, mood, tempo, and lyrical themes, and Udio generates a finished track ready to download and use. The audio quality is notably high compared to earlier music generation tools: the vocals are coherent, the arrangements are musical, and the output sounds like a produced recording rather than a rough demo.\n\nUdio is one of the two leading AI music generators in 2026 alongside Suno, and the two are closely competitive on output quality. Udio tends to be preferred for its instrumental arrangements and genre accuracy; Suno for its vocal character and lyric coherence. For content creators, video producers, game developers, and marketers who need royalty-free background music without licensing costs, both tools are transformative — a task that previously cost hundreds of dollars and days of coordination with a composer now takes thirty seconds. The free plan generates a limited number of tracks per month. Pro plans remove the limits and add commercial licensing. The legal status of AI music training is still evolving, so teams with strict IP requirements should review Udio\'s licensing terms before using output commercially.',
  'https://www.google.com/s2/favicons?domain=udio.com&sz=64',
  'https://udio.com',
  'https://udio.com',
  ARRAY['voice-ai', 'content'],
  'freemium', true, 10,
  4.4, 720, false, true, false,
  ARRAY['Radio-quality full song output', 'Strong instrumental arrangement quality', 'Genre and mood accuracy', 'Commercial license available on paid plans'],
  ARRAY['IP and training data legal uncertainty', 'Free tier limited track count', 'Less vocal coherence than Suno on some genres'],
  ARRAY['Royalty-free background music for video content', 'Prototype music for game development', 'Custom jingles and brand audio']
),

(
  'langchain',
  'LangChain',
  'Open-source framework for building LLM-powered applications and agents',
  E'LangChain is the most widely adopted open-source framework for building applications powered by large language models. It provides abstractions for the most common LLM application patterns — RAG (retrieval augmented generation), multi-step chains, tool-using agents, memory systems, and structured output parsing — so developers don\'t need to build these components from scratch every time.\n\nThe framework connects LLMs (OpenAI, Anthropic, Mistral, local models) with external data sources (vector databases, APIs, SQL databases, file systems) through a standardised interface. This is the core value: rather than writing custom integration code for every model and data source combination, LangChain provides pre-built connectors and composable building blocks. LangSmith (the companion observability platform) adds tracing, evaluation, and debugging for LLM applications in production — essential for teams moving from prototype to reliability. LangGraph extends the framework for complex multi-agent workflows with state management and cyclical execution. In 2026, LangChain remains the default starting point for Python developers building RAG pipelines, AI assistants, document Q&A systems, and agent workflows, despite increasing competition from lighter alternatives like LlamaIndex and the growing adoption of framework-native agent features from Anthropic and OpenAI.',
  'https://www.google.com/s2/favicons?domain=langchain.com&sz=64',
  'https://langchain.com',
  'https://langchain.com',
  ARRAY['code-ai'],
  'freemium', true, 0,
  4.4, 1850, false, false, false,
  ARRAY['Most comprehensive LLM application framework', 'Huge ecosystem of integrations', 'LangSmith for production observability', 'LangGraph for complex agent workflows'],
  ARRAY['Steep learning curve for beginners', 'Can be over-engineered for simple tasks', 'Abstraction sometimes hides underlying model behaviour'],
  ARRAY['Building RAG pipelines over proprietary documents', 'Multi-step AI agent workflows', 'Connecting LLMs to databases and APIs']
),

(
  'pinecone',
  'Pinecone',
  'Managed vector database for AI applications requiring semantic search',
  E'Pinecone is a managed vector database service designed specifically for AI applications that need to store and search high-dimensional embeddings at scale. In the architecture of most RAG (retrieval augmented generation) systems — where an AI assistant needs to find relevant documents before generating an answer — a vector database is the retrieval layer, and Pinecone is the most widely used managed option.\n\nThe core value proposition is that Pinecone handles all the infrastructure complexity of running a vector database: indexing, replication, scaling, and query performance. Developers connect their embedding model (OpenAI, Cohere, or any model that produces vector embeddings), push vectors to Pinecone, and query them with semantic similarity searches that return the most relevant documents for any input. The serverless tier (introduced in 2024) made Pinecone significantly more accessible for smaller applications — no reserved capacity required, cost scales with actual query volume. For production AI applications where retrieval quality and latency directly affect user experience, Pinecone\'s performance benchmarks and dedicated infrastructure are its primary advantages over self-hosted alternatives like Chroma or Weaviate. Teams building internal AI search, customer support AI, or document Q&A systems at any meaningful scale typically evaluate Pinecone as the primary managed option.',
  'https://www.google.com/s2/favicons?domain=pinecone.io&sz=64',
  'https://pinecone.io',
  'https://pinecone.io',
  ARRAY['code-ai'],
  'freemium', true, 0,
  4.5, 980, false, false, true,
  ARRAY['Managed infrastructure — no DevOps required', 'Serverless tier scales to zero cost', 'Low latency semantic search at scale', 'Strong integrations with LangChain and LlamaIndex'],
  ARRAY['Can get expensive at very high query volumes', 'Self-hosted alternatives are free for small scale', 'Vendor lock-in risk for core infrastructure'],
  ARRAY['RAG retrieval layer for AI assistants', 'Semantic search over large document collections', 'Recommendation systems using embedding similarity']
),

(
  'adobe-photoshop',
  'Adobe Photoshop',
  'Industry-standard photo editing software with AI Generative Fill and Remove',
  E'Adobe Photoshop is the industry-standard image editing application, used by professional photographers, designers, and retouchers worldwide. In 2024-2026, Adobe integrated its Firefly AI models directly into Photoshop, adding capabilities that fundamentally changed what non-destructive editing can accomplish: Generative Fill adds, removes, or replaces any selected area of an image with AI-generated content that matches the surrounding scene. Remove Object eliminates unwanted elements with context-aware fill that often produces cleaner results than the previous Content-Aware fill. Generative Expand extends images beyond their original borders — adding content that matches the original photograph\'s perspective, lighting, and style.\n\nFor professional image editing that requires precision, layer control, and the full history of non-destructive editing that no AI tool replicates, Photoshop remains without peer. The AI features accelerate specific tasks — background removal, object replacement, image extension — that previously required skilled manual work. Unlike standalone AI image generators (Midjourney, Stable Diffusion), Photoshop\'s AI operates within the context of a real photograph, making it useful for commercial photography, product imagery, and editorial work where starting from a real asset is the requirement. Photoshop is available as part of Adobe Creative Cloud (Photography plan from $9.99/month, full Creative Cloud from $54.99/month).',
  'https://www.google.com/s2/favicons?domain=adobe.com&sz=64',
  'https://adobe.com/products/photoshop',
  'https://adobe.com/products/photoshop',
  ARRAY['image-ai'],
  'paid', false, 10,
  4.6, 4200, false, false, false,
  ARRAY['Generative Fill for AI-powered in-image editing', 'Industry standard with unmatched precision tools', 'AI trained on licensed content (commercial safe)', 'Non-destructive layer editing with full history'],
  ARRAY['Paid subscription required', 'Steep learning curve for new users', 'Heavy desktop application, not browser-based'],
  ARRAY['Professional product and commercial photography editing', 'Removing or replacing objects in real photos', 'Extending and compositing images for advertising']
),

(
  'you-com',
  'You.com',
  'AI-powered search engine with personalised results and integrated AI chat',
  E'You.com is an AI-powered search engine that combines traditional web search results with integrated AI chat, letting users search, summarise, and ask follow-up questions in a single interface. Unlike Google Search, which returns links, You.com summarises web content directly in the search results and allows conversational follow-up queries — closer to the Perplexity experience than traditional search.\n\nYou.com\'s differentiation is personalisation: users can configure which sources and apps appear in their search results — prioritising specific news sources, code repositories, or social platforms — and the AI adapts to individual preferences over time. The YouWrite and YouImagine tools add AI writing and image generation directly within the search interface, making You.com an all-in-one information and creation tool rather than a pure search engine. The free plan is generous with no query limits on standard search and a daily limit on AI features. For users who find Perplexity\'s research focus too narrow and Google too link-heavy, You.com occupies a middle position: AI-assisted search with personalisation and creation tools. The platform has grown significantly since its 2022 launch and is one of the few credible alternatives to Google and Perplexity for AI-enhanced web search.',
  'https://www.google.com/s2/favicons?domain=you.com&sz=64',
  'https://you.com',
  'https://you.com',
  ARRAY['ai-assistant', 'research'],
  'freemium', true, 20,
  4.2, 860, false, false, false,
  ARRAY['AI summarisation built into search results', 'Highly customisable source preferences', 'Includes writing and image generation tools', 'No query limits on free plan'],
  ARRAY['Less research-focused than Perplexity', 'AI results quality varies by topic', 'Less brand recognition than Google or Perplexity'],
  ARRAY['AI-enhanced everyday web search', 'Personalised news and research aggregation', 'Combined search and content creation workflow']
),

(
  'pi',
  'Pi',
  'Personal AI assistant designed for conversation, reflection, and daily support',
  E'Pi (Personal Intelligence) is an AI assistant created by Inflection AI, designed with a distinctly different goal from productivity-focused tools like ChatGPT or Claude: it is built for conversation, emotional support, and personal reflection rather than task completion. The tone is warm, curious, and non-transactional — Pi asks questions, listens to context before responding, and engages in extended back-and-forth dialogue more naturally than most AI assistants.\n\nFor users who want an AI they can talk to about personal challenges, think through decisions with, or simply have a genuine conversation with, Pi\'s character and conversational design is superior to tools built primarily for information retrieval or content generation. The voice mode is notably natural — Pi\'s voice conversations are among the most realistic AI voice interactions available. Pi is available on iOS, Android, and web, and the free plan has no meaningful limitations. In 2024, Microsoft acquired a significant portion of Inflection\'s team (including its founders), but Pi continues to operate as a standalone product. For users who have tried ChatGPT and found it feels transactional, Pi\'s conversational approach offers a meaningfully different experience. It is not the right tool for writing assistance, coding, or research — but for personal conversation and reflection, it is the most thoughtfully designed option available.',
  'https://www.google.com/s2/favicons?domain=pi.ai&sz=64',
  'https://pi.ai',
  'https://pi.ai',
  ARRAY['ai-assistant'],
  'free', true, 0,
  4.3, 1100, false, false, false,
  ARRAY['Most natural conversational AI experience', 'Excellent voice mode', 'Designed for personal reflection and support', 'Generous free plan with no hard limits'],
  ARRAY['Not designed for task or productivity use', 'Less capable than Claude or ChatGPT for research', 'Uncertain roadmap after Inflection founders left'],
  ARRAY['Personal conversation and reflection', 'Thinking through decisions conversationally', 'Daily emotional check-ins and journaling']
),

(
  'vapi',
  'Vapi',
  'Voice AI platform for building conversational phone and voice agents',
  E'Vapi is a developer platform for building AI-powered voice agents — automated phone systems, customer support bots, sales callers, and scheduling assistants — that sound natural enough to hold real phone conversations. The platform handles the technical stack that makes voice AI production-ready: telephony integration (Twilio, phone number provisioning), real-time speech-to-text, LLM inference, text-to-speech (ElevenLabs, Deepgram, or other voices), and low-latency response coordination that keeps conversations from feeling robotic.\n\nFor businesses that handle large volumes of inbound or outbound calls — appointment scheduling, lead qualification, customer support, surveys, reminders — Vapi enables automation that previously required either expensive call centre operations or clunky IVR systems. The developer API allows full customisation: custom system prompts, tool calling (the agent can look up appointments, update CRM records, trigger workflows), interruption handling, and call recording. Pre-built templates for common use cases (appointment booking, FAQ handling, lead qualification) reduce the setup time for standard applications. Pricing is based on per-minute usage, which makes it cost-effective for variable call volumes. Vapi is primarily a developer tool — the setup requires API integration — but the documentation is strong and the community is active. For non-technical teams, managed alternatives exist but at higher cost.',
  'https://www.google.com/s2/favicons?domain=vapi.ai&sz=64',
  'https://vapi.ai',
  'https://vapi.ai',
  ARRAY['voice-ai', 'code-ai'],
  'freemium', true, 0,
  4.4, 620, false, true, false,
  ARRAY['Production-ready voice AI with low latency', 'Full customisation via API', 'Pay-per-minute pricing scales with usage', 'Handles telephony, STT, LLM, and TTS in one platform'],
  ARRAY['Requires developer setup', 'Can get expensive at high call volumes', 'Voice quality depends on chosen TTS provider'],
  ARRAY['Automated appointment scheduling via phone', 'AI-powered inbound customer support', 'Outbound lead qualification calls']
),

(
  'krea-ai',
  'Krea AI',
  'Real-time AI image and video generation with enhanced creative control',
  E'Krea AI is an AI creative platform focused on real-time image generation and video enhancement, with a distinctly different workflow from text-to-image tools like Midjourney or Stable Diffusion. Krea\'s real-time generation canvas shows results updating live as you adjust prompts, sketch elements, or move reference images — making the creative process more iterative and visual than the prompt-then-wait pattern of most image generators.\n\nThe AI Enhancer is Krea\'s most distinctive feature: it takes any image — including low-quality or rough sketches — and generates a high-detail, photorealistic or stylised version that preserves the original composition and structure. For artists and designers who sketch concepts by hand or in simple tools and want to quickly visualise how they might look as finished renders, Krea\'s enhancement workflow is faster than any alternative. The video generation features apply similar real-time enhancement to video content, adding detail and style to existing footage. Krea supports a range of underlying models and allows users to train custom LoRA models on their own visual style or brand assets — a feature that distinguishes it from more closed platforms. The free tier includes limited generations; paid plans unlock faster processing and higher resolution outputs. For visual artists, game concept designers, and creative professionals who want more control over the AI generation process than Midjourney allows, Krea offers a meaningfully different creative workflow.',
  'https://www.google.com/s2/favicons?domain=krea.ai&sz=64',
  'https://krea.ai',
  'https://krea.ai',
  ARRAY['image-ai', 'video-ai'],
  'freemium', true, 24,
  4.4, 580, false, true, false,
  ARRAY['Real-time generation canvas with live preview', 'AI Enhancer for upscaling and detailing any image', 'Custom LoRA training on brand assets', 'Iterative creative workflow vs prompt-and-wait'],
  ARRAY['Less community and preset library than Midjourney', 'Real-time features require fast hardware', 'Free tier is fairly limited'],
  ARRAY['Concept art and visual development', 'Enhancing sketches to finished renders', 'Brand-consistent image generation with custom LoRA']
),

(
  'magnific',
  'Magnific AI',
  'AI image upscaler that adds detail and texture during upscaling',
  E'Magnific AI is an AI-powered image upscaler that goes significantly beyond traditional upscaling tools: it doesn\'t just increase resolution, it adds new detail, texture, and realism during the upscaling process. A 512x512 pixel AI-generated image upscaled with Magnific to 4K doesn\'t just get larger — it gains skin texture, fabric detail, environmental texture, and realistic material properties that weren\'t present in the original. The "Creativity" and "HDR" sliders let users control how much new detail the AI adds versus preserving the original image faithfully.\n\nFor photographers and visual artists who generate images with Midjourney, Stable Diffusion, or similar tools and want to produce print-quality or commercial-resolution output, Magnific removes the resolution bottleneck. The same enhancement applies to real photographs: product photos, portraits, and architectural images can be upscaled and enhanced beyond what the camera originally captured. The face enhancement mode specifically improves facial detail and realism in AI-generated portraits. Magnific is a specialist tool rather than an all-in-one platform — it does one thing (upscale with AI-generated detail) and does it better than any alternative. The subscription pricing starts at around $39/month for the basic plan, which includes a monthly credit allocation. For professionals selling print, licensing imagery commercially, or producing large-format digital content, Magnific pays for itself quickly.',
  'https://www.google.com/s2/favicons?domain=magnific.ai&sz=64',
  'https://magnific.ai',
  'https://magnific.ai',
  ARRAY['image-ai'],
  'paid', false, 39,
  4.5, 760, false, true, false,
  ARRAY['Adds new detail during upscaling (not just resize)', 'Produces print-quality output from AI images', 'Face enhancement for portrait realism', 'Adjustable creativity level for detail generation'],
  ARRAY['No free tier', 'Overkill for casual use', 'Can over-generate detail if creativity is too high'],
  ARRAY['Upscaling AI-generated images to print resolution', 'Enhancing product photos for commercial use', 'Preparing large-format digital assets']
),

(
  'microsoft-365-copilot',
  'Microsoft 365 Copilot',
  'AI assistant integrated across Word, Excel, PowerPoint, Outlook, and Teams',
  E'Microsoft 365 Copilot is Microsoft\'s enterprise AI assistant, embedded directly into the Office applications that most knowledge workers use daily: Word, Excel, PowerPoint, Outlook, and Teams. Unlike standalone AI tools that require context-switching, Copilot works inside the documents and emails you are already editing. In Word, it drafts, rewrites, and summarises documents. In Excel, it generates formulas, creates charts, and analyses data trends from natural language queries. In PowerPoint, it builds presentation decks from a brief or a Word document. In Outlook, it summarises email threads and drafts responses. In Teams, it summarises meetings in real time.\n\nThe Microsoft Graph integration is the defining advantage: Copilot has access to your organisation\'s emails, documents, calendar, and Teams conversations — so it can draft a project update that references actual documents in your SharePoint, summarise a meeting using the actual transcript, or answer questions about your company\'s internal data. This context-aware capability is what distinguishes Microsoft 365 Copilot from using ChatGPT separately. The limitation is cost and enterprise requirement: Copilot requires an existing Microsoft 365 Business or Enterprise subscription plus an add-on of $30 per user per month. For large organisations already standardised on Microsoft 365, this is the highest-leverage AI deployment because it requires no workflow change — the AI comes to users in tools they already use every day.',
  'https://www.google.com/s2/favicons?domain=microsoft.com&sz=64',
  'https://microsoft.com/microsoft-365/copilot',
  'https://microsoft.com/microsoft-365/copilot',
  ARRAY['productivity', 'ai-assistant'],
  'paid', false, 30,
  4.3, 2100, false, false, false,
  ARRAY['Embedded in Word, Excel, PowerPoint, Outlook, Teams', 'Microsoft Graph access to org documents and emails', 'No workflow change required for existing M365 users', 'Meeting summarisation in Teams with real transcript'],
  ARRAY['$30/user/month add-on on top of M365 subscription', 'Enterprise/Business license required', 'Quality varies significantly by application'],
  ARRAY['Drafting documents and presentations from briefs', 'Analysing data in Excel with natural language', 'Summarising long email threads and Teams meetings']
)

ON CONFLICT (slug) DO NOTHING;
