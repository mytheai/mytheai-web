-- tools-batch-15.sql
-- 10 new tools: humata, play-ht, wellsaid, lmstudio, kittl, looka, popai, picsart, uizard, stability-ai
-- DB: ~172 -> ~182
-- Run in Supabase SQL Editor
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count,
  featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

(
  'humata',
  'Humata AI',
  'Chat with your documents and PDFs using AI',
  'Humata AI lets you upload PDFs and documents and ask questions about them in plain language. Instead of reading through a 50-page research paper manually, you can ask Humata to summarize the key findings, extract specific data points, or explain complex sections in accessible terms. It supports multiple file uploads at once, making it useful for comparing documents or synthesizing information from several sources simultaneously.

For teams, Humata provides a shared document workspace where members can query uploaded files together. Legal teams use it to review contracts quickly. Researchers use it to accelerate literature reviews. Students use it to absorb academic papers faster than reading end to end. The free plan allows limited document uploads per month, and paid plans unlock higher page limits, faster processing, and team collaboration features.',
  NULL,
  'https://www.humata.ai',
  'https://www.humata.ai',
  ARRAY['research', 'productivity'],
  'freemium',
  true,
  9.99,
  4.5,
  890,
  false, false, false,
  ARRAY[
    'Accurate answers grounded in your actual documents, not hallucinated',
    'Multi-file upload lets you query across several documents at once',
    'Highlights the exact source passage for every answer it gives',
    'Free plan is generous enough for occasional research use'
  ],
  ARRAY[
    'Page limits on free and lower-paid tiers can be restrictive for large documents',
    'Slower processing for very large PDFs compared to desktop-native tools',
    'No offline mode - requires internet connection for all document queries'
  ],
  ARRAY[
    'Summarizing long research papers and academic literature quickly',
    'Reviewing and comparing legal contracts without reading every clause',
    'Extracting specific data points from financial reports or technical documentation'
  ]
),

(
  'play-ht',
  'Play.ht',
  'AI voice generator with 900+ realistic voices in 142 languages',
  'Play.ht is an AI voice generation platform with over 900 voices across 142 languages. You paste text, choose a voice, and download a realistic audio file in seconds. The platform goes beyond basic text-to-speech, letting you fine-tune speech rate, pitch, pauses, and emphasis to match the tone and context of your content. The Ultra Realistic voices (PlayHT 2.0) are difficult to distinguish from a professional voice actor in most listening environments.

Content creators use Play.ht for podcast intros, YouTube voiceovers, and online course narration. Businesses use it for IVR phone systems, product demo videos, and internal training content. The pay-per-use pricing model makes it affordable for occasional use, and subscription plans unlock unlimited character generation. The API gives developers a straightforward path to integrating voice generation into applications, chatbots, and automated workflows.',
  NULL,
  'https://play.ht',
  'https://play.ht',
  ARRAY['voice-audio'],
  'freemium',
  true,
  31.20,
  4.4,
  1240,
  false, false, false,
  ARRAY[
    'Over 900 voices across 142 languages - the widest selection of any AI voice tool',
    'PlayHT 2.0 Ultra Realistic voices are nearly indistinguishable from human recording',
    'Fine-grained control over pace, pitch, pauses, and emphasis within the same generation',
    'REST API with SDKs for Node.js, Python, and other popular languages'
  ],
  ARRAY[
    'Higher-tier subscription required to access the best Ultra Realistic voices',
    'Voice cloning (custom voice creation) requires separate pricing',
    'Output quality can vary depending on the complexity of the input text'
  ],
  ARRAY[
    'Creating voiceovers for YouTube videos, courses, and marketing content',
    'Building IVR systems and automated phone response trees',
    'Generating podcast introductions and audio versions of written articles'
  ]
),

(
  'wellsaid',
  'WellSaid Labs',
  'Enterprise AI voice for professional narration and content',
  'WellSaid Labs is an enterprise AI voice platform focused on consistent, studio-grade narration for professional content. Rather than offering hundreds of generic voices, WellSaid develops a curated set of AI voices optimized for clarity and sustained professionalism across long recordings. Each voice sounds consistent from the first sentence to the last, which matters for e-learning courses, product demonstrations, and corporate training content where quality cannot vary.

The platform integrates directly with authoring tools like Articulate Rise and Adobe Captivate, making it practical for instructional designers without requiring additional technical steps. Organizations in healthcare, finance, and enterprise training prefer WellSaid because the voices maintain a professional tone consistently and the platform offers custom voice development for brands that need a proprietary voice identity. The result is narration that sounds produced rather than generated.',
  NULL,
  'https://wellsaidlabs.com',
  'https://wellsaidlabs.com',
  ARRAY['voice-audio'],
  'paid',
  false,
  44.00,
  4.5,
  670,
  false, false, false,
  ARRAY[
    'Studio-grade voice consistency across long recordings without quality drift',
    'Native integration with Articulate Rise, Adobe Captivate, and other authoring tools',
    'Custom voice development available for brands that need proprietary voice identity',
    'Voices are specifically optimized for professional narration, not casual speech'
  ],
  ARRAY[
    'No free tier - paid plans only with no trial without a sales conversation',
    'Smaller voice selection than competitors (intentional, but limiting for some use cases)',
    'Primarily optimized for narration - less suitable for conversational or expressive audio'
  ],
  ARRAY[
    'Narrating e-learning courses and corporate training modules at scale',
    'Creating professional product demo videos without hiring a voice actor',
    'Building a consistent brand voice across all audio content'
  ]
),

(
  'lmstudio',
  'LM Studio',
  'Run local AI language models on your computer with no internet required',
  'LM Studio lets you download and run large language models directly on your Mac, Windows, or Linux machine. No internet connection required, no API costs, and no data leaving your computer. You browse a library of open-source models including Llama 3, Mistral, Phi, Gemma, and others, download the one that fits your hardware, and run a local chat interface in minutes. Models run entirely on your CPU or GPU with no cloud dependency.

For developers and researchers, LM Studio also provides a local OpenAI-compatible API endpoint, which means any application built on the OpenAI SDK can point to your local LM Studio instance instead of the cloud. This is practical for building and testing prototypes without API costs, processing sensitive documents without sending data to third parties, and developing AI features offline. The interface is approachable enough for non-developers while offering advanced configuration options for those who need them.',
  NULL,
  'https://lmstudio.ai',
  'https://lmstudio.ai',
  ARRAY['ai-assistants', 'code-ai'],
  'free',
  true,
  NULL,
  4.7,
  2100,
  false, true, false,
  ARRAY[
    'Completely free with no usage limits or API costs for local model inference',
    'Full privacy - no data leaves your machine, suitable for sensitive documents',
    'Local OpenAI-compatible API works with any existing OpenAI SDK integration',
    'Wide model library including Llama 3, Mistral, Phi, Gemma, and community fine-tunes'
  ],
  ARRAY[
    'Requires capable hardware - larger models need significant RAM and GPU memory',
    'Slower inference than cloud APIs for users without dedicated GPU hardware',
    'Models must be downloaded individually and can be several gigabytes each'
  ],
  ARRAY[
    'Running AI models locally without internet access or API subscriptions',
    'Processing sensitive documents or private data without sending to cloud providers',
    'Developing and testing AI applications locally before connecting to a cloud API'
  ]
),

(
  'kittl',
  'Kittl',
  'AI-powered graphic design platform for professional-looking visuals',
  'Kittl is an AI-powered graphic design platform built for creating professional-looking designs without formal design training. It specializes in text effects, vintage graphics, and illustration-style designs that would take hours in Illustrator but can be completed in minutes on Kittl. The AI can generate custom graphics from a text prompt, suggest design improvements, and automatically resize designs for different output formats and platforms.

T-shirt designers, print-on-demand sellers, social media creators, and small business owners make up Kittl''s core audience, but the tool works for any brand that needs consistent visual content without a dedicated design team. The template library is organized by industry and visual style, and the AI assists at every stage from concept to final export. The free plan allows a limited number of downloads per month, and the Pro plan unlocks unlimited exports, higher resolution files, and commercial usage rights for all generated content.',
  NULL,
  'https://www.kittl.com',
  'https://www.kittl.com',
  ARRAY['design', 'image-ai'],
  'freemium',
  true,
  10.00,
  4.5,
  1560,
  false, false, false,
  ARRAY[
    'Specialized in text effects and vintage illustration styles that general tools handle poorly',
    'Large template library organized by industry and visual style',
    'AI generates complete graphic compositions from text prompts, not just individual elements',
    'Automatic resizing for different platforms saves significant production time'
  ],
  ARRAY[
    'Less suitable for photography editing or UI/UX design - focused on graphic illustration',
    'Free plan restricts downloads, which limits usefulness for high-volume production',
    'Steeper learning curve than Canva for users unfamiliar with design software concepts'
  ],
  ARRAY[
    'Designing T-shirt graphics and print-on-demand products for e-commerce',
    'Creating consistent social media visual content across multiple platforms',
    'Building brand illustration kits and visual identity assets'
  ]
),

(
  'looka',
  'Looka',
  'AI logo maker and brand identity designer for small businesses',
  'Looka is an AI-powered logo maker and brand identity builder for businesses that need professional branding without hiring a designer. You enter your company name and industry, select design preferences from curated visual examples, and Looka generates dozens of logo options. From there, you refine the chosen logo through a drag-and-drop editor - adjusting fonts, colors, layouts, and icons until the design matches your vision exactly.

Beyond the logo itself, Looka generates a complete brand kit including business cards, letterhead, email signatures, and social media graphics all using your new logo and color palette. For early-stage startups, freelancers, and small businesses that need a professional brand identity without a significant design budget, Looka compresses what could be weeks of designer time into a single afternoon. Final logo files in PNG, SVG, and PDF formats are delivered after purchase.',
  NULL,
  'https://looka.com',
  'https://looka.com',
  ARRAY['design', 'image-ai'],
  'paid',
  false,
  20.00,
  4.3,
  2340,
  false, false, false,
  ARRAY[
    'Complete brand kit generated alongside the logo - not just a standalone graphic',
    'SVG files included, giving you scalable vector output suitable for print',
    'Extensive customization through drag-and-drop editor after initial AI generation',
    'No subscription required - pay once for the files you need'
  ],
  ARRAY[
    'No free tier - you must purchase before downloading final logo files',
    'AI-generated logos may resemble others using similar style inputs',
    'Limited to logo and brand identity work - not a general design platform'
  ],
  ARRAY[
    'Creating a professional logo and brand identity for a new business quickly',
    'Generating a complete set of branded assets for a product launch',
    'Refreshing an outdated logo with AI-assisted redesign options'
  ]
),

(
  'popai',
  'PopAI',
  'AI assistant combining chat, PDF reading, image generation, and presentations',
  'PopAI is a multipurpose AI assistant that combines document reading, AI chat, image generation, and presentation creation in a single interface. Upload a PDF, research paper, or spreadsheet and ask PopAI questions about its content. Switch to the writing assistant to draft emails, reports, or marketing copy. Use the image generation feature to create visuals. Build a presentation from a topic description without leaving the platform.

The appeal of PopAI is breadth rather than depth - it covers the most common AI assistant use cases without requiring multiple subscriptions. Students use it to summarize academic papers and assist with research. Professionals use it to draft reports and review documents. The free plan includes generous daily limits across all features, and paid plans remove those limits and add priority processing. For users who want one tool rather than five separate subscriptions, PopAI is a practical starting point that does each task competently.',
  NULL,
  'https://www.popai.pro',
  'https://www.popai.pro',
  ARRAY['ai-assistants', 'productivity'],
  'freemium',
  true,
  9.99,
  4.3,
  1870,
  false, false, false,
  ARRAY[
    'Covers AI chat, PDF reading, image generation, and presentations in one subscription',
    'Free plan is generous with daily usage across all features',
    'PDF reading includes citation of exact source passages for each answer',
    'Presentation builder generates complete slide decks from a topic or outline'
  ],
  ARRAY[
    'Each individual feature is less powerful than dedicated specialist tools',
    'Image generation quality is behind Midjourney and Adobe Firefly',
    'Interface can feel cluttered when switching between different tool modes'
  ],
  ARRAY[
    'Summarizing and asking questions about research papers and academic content',
    'Drafting professional documents and reports without switching between applications',
    'Creating quick presentations for meetings when a polished deck is not required'
  ]
),

(
  'picsart',
  'Picsart AI',
  'AI photo editor and design tool for creators and social media teams',
  'Picsart is a mobile-first AI photo editor and design platform used by over 150 million people globally. The AI-powered features include background removal, object removal, style transfer, image upscaling, automatic photo enhancement, and an AI image generator that creates new visuals from text prompts. For social media creators, Picsart combines photo editing and graphic design into a single application without requiring desktop software.

The desktop version expands on mobile capabilities with templates, stickers, and a full design canvas for creating social graphics, product mockups, and promotional materials. Marketing teams use Picsart for high-volume social content production. Influencers use it for aesthetic consistency and photo enhancement across their feeds. Small businesses use it for product mockups and campaign graphics. The free plan covers basic editing, while the Pro plan unlocks AI features without daily limits and provides access to a premium asset library.',
  NULL,
  'https://picsart.com',
  'https://picsart.com',
  ARRAY['image-ai', 'design'],
  'freemium',
  true,
  5.00,
  4.2,
  4200,
  false, false, false,
  ARRAY[
    'Best-in-class mobile experience - full photo editing and design on smartphone',
    'AI background removal, object removal, and upscaling in a single app',
    'Large community with tutorials and shared templates for popular content formats',
    'Affordable Pro plan compared to desktop alternatives'
  ],
  ARRAY[
    'Desktop version feels secondary to the mobile experience - some features mobile-only',
    'AI image generation quality is not competitive with dedicated image generation tools',
    'Free plan has significant watermarking on exports'
  ],
  ARRAY[
    'Editing and enhancing photos for social media profiles and content feeds',
    'Creating marketing graphics and product mockups without desktop design software',
    'Building consistent visual aesthetic for brand social media accounts'
  ]
),

(
  'uizard',
  'Uizard',
  'Turn sketches and text descriptions into wireframes and prototypes with AI',
  'Uizard is an AI-powered UI design tool that converts rough sketches, screenshots, and plain-language descriptions into editable wireframes and clickable prototypes. Take a photo of a hand-drawn sketch and Uizard converts it into a clean digital wireframe. Describe an app screen in plain text and Uizard generates a layout to match. The tool is designed for product managers, founders, and early-stage product teams who need to visualize and validate ideas quickly without deep expertise in professional design tools.

Beyond generation, Uizard provides a prototyping environment where teams can link screens together, add interactions, and test user flows before investing in production design. For client presentations, hackathons, and early product validation, Uizard gets a product concept into a clickable prototype faster than any alternative. Non-technical stakeholders can participate directly by commenting on prototype screens, which speeds up feedback cycles before designs reach a developer.',
  NULL,
  'https://uizard.io',
  'https://uizard.io',
  ARRAY['design', 'productivity'],
  'freemium',
  true,
  12.00,
  4.4,
  980,
  false, false, false,
  ARRAY[
    'Converts hand-drawn sketches into digital wireframes - unique capability among design tools',
    'AI generates complete screen layouts from plain-language descriptions',
    'Accessible to non-designers - no design tool expertise required',
    'Clickable prototypes can be shared with stakeholders without additional software'
  ],
  ARRAY[
    'Output quality not suitable for final production designs - a prototyping tool, not a delivery tool',
    'Limited component library compared to Figma for teams with established design systems',
    'AI layout generation works best for standard app patterns, struggles with complex custom layouts'
  ],
  ARRAY[
    'Rapidly prototyping app concepts for client presentations and investor demos',
    'Converting whiteboard sketches into shareable digital wireframes during workshops',
    'Validating product ideas with clickable prototypes before committing to full design'
  ]
),

(
  'stability-ai',
  'Stability AI',
  'Open-source AI image generation models and developer API for custom applications',
  'Stability AI is the company behind Stable Diffusion, one of the most widely used open-source AI image generation models. Through DreamStudio (their consumer web interface) and the Stability AI API, developers and creators can generate high-quality images using models that are also available to download and run locally. Unlike Midjourney, which only operates through a closed platform, Stable Diffusion models can be self-hosted, fine-tuned on custom datasets, and integrated into proprietary applications without usage restrictions.

For developers building AI-powered products, the Stability AI API provides access to image generation, image editing (inpainting and outpainting), video generation, and 3D model creation at competitive per-image pricing with no subscription required. For creators, DreamStudio offers a web interface for text-to-image generation, style transfers, and image modifications. The open-source nature of Stable Diffusion has produced a large ecosystem of community tools - including ComfyUI and Automatic1111 - that extend the models with custom workflows and fine-tuned styles.',
  NULL,
  'https://stability.ai',
  'https://stability.ai',
  ARRAY['image-ai'],
  'freemium',
  true,
  NULL,
  4.3,
  1890,
  false, false, false,
  ARRAY[
    'Underlying Stable Diffusion models are fully open-source and can be self-hosted',
    'API supports image generation, editing, video, and 3D model creation in one platform',
    'Pay-per-use API pricing with no subscription commitment required',
    'Massive community ecosystem with custom fine-tuned models for nearly every visual style'
  ],
  ARRAY[
    'Output quality on standard settings is behind Midjourney for artistic and photorealistic images',
    'Getting best results requires more prompt engineering skill than consumer-facing tools',
    'DreamStudio consumer interface is less polished than dedicated image generation platforms'
  ],
  ARRAY[
    'Building custom AI image generation features into products and applications via API',
    'Fine-tuning models on proprietary image datasets for specific brand or style requirements',
    'Generating high volumes of images at scale with pay-per-use pricing'
  ]
)

ON CONFLICT (slug) DO NOTHING;
