-- tools-batch-5.sql
-- 10 new tools: Video Creation, SEO Writing, Analytics, Productivity, Enterprise AI
-- Run in Supabase SQL Editor

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

(
  'luma-ai',
  'Luma AI',
  'Cinematic AI video generation with Dream Machine',
  E'Luma AI is the company behind Dream Machine, a text-to-video and image-to-video generation model that produces cinematic, physically realistic clips from detailed text prompts. Dream Machine is particularly strong at smooth camera movements, realistic lighting, and coherent motion over longer clip durations. The tool has attracted professional filmmakers, advertising agencies, and content studios who need high-quality motion graphics and concept visualisations at a fraction of traditional production costs. The quality ceiling for complex cinematographic prompts is among the highest currently available, making it a genuine tool for professionals rather than just a novelty.\n\nLuma AI also offers an API for developers building video generation into applications and workflows, and an iOS app for on-the-go creation. Pricing is credit-based: the free tier provides a small monthly allowance sufficient for evaluation, and paid plans start at approximately $10 per month with higher credit limits and faster generation queues. Luma regularly releases updated model versions with each iteration improving temporal consistency, prompt adherence, and overall visual quality. For creators who need cinematic-quality AI video, Dream Machine consistently ranks alongside Kling and Runway as a top-tier option.',
  'https://www.google.com/s2/favicons?domain=lumalabs.ai&sz=64',
  'https://lumalabs.ai',
  'https://lumalabs.ai',
  ARRAY['video-ai'],
  'freemium', true, 10,
  4.6, 1420, false, true, false,
  ARRAY['Cinematic quality with realistic physics and lighting', 'iOS app for mobile generation', 'API access for developers', 'Regular model updates improving quality continuously'],
  ARRAY['Credit-based pricing depletes quickly on longer clips', 'Queue wait times on free plan during peak hours', 'Prompt crafting requires practice for best results'],
  ARRAY['Concept visualisation and pre-production storyboarding', 'Short-form advertising and campaign content', 'Product demonstrations and visual explainers', 'Film and music video creative development']
),

(
  'invideo-ai',
  'InVideo AI',
  'Turn a script or idea into a fully produced marketing video in minutes',
  E'InVideo AI is a text-to-video platform that turns scripts, ideas, and article URLs into fully produced marketing videos with stock footage, voiceover, captions, and background music generated automatically. The workflow is built for teams who need a high volume of video content without production expertise: input a topic or paste a script, select a video style and target platform (YouTube, Instagram, TikTok, LinkedIn), and InVideo AI assembles a complete draft within minutes. The AI selects relevant stock clips, generates a voiceover in one of dozens of available voices, adds on-screen captions, and applies transitions and pacing suited to the chosen format.\n\nVideos are fully editable after the initial generation, allowing users to swap footage clips, adjust the voiceover script, change music, and fine-tune timing. This combination of automation and editability makes InVideo AI the preferred tool for social media managers, content agencies, and digital marketers who treat video as a high-volume content type rather than a production-intensive project. The free plan includes InVideo branding and limited exports per month. The Business plan at $25 per month removes branding, unlocks HD exports, and provides access to an expanded stock media library for more varied and professional output.',
  'https://www.google.com/s2/favicons?domain=invideo.io&sz=64',
  'https://invideo.io',
  'https://invideo.io',
  ARRAY['video-ai', 'content'],
  'freemium', true, 25,
  4.3, 1680, false, false, false,
  ARRAY['Full video assembly from a single text prompt or script', 'Dozens of AI voiceover options with natural delivery', 'Supports TikTok, YouTube, Instagram, and LinkedIn formats', 'Fully editable output for fine-tuning after generation'],
  ARRAY['Stock footage quality varies across clips', 'InVideo branding on free plan', 'Complex custom animations not supported'],
  ARRAY['Social media video content at scale', 'Explainer and product marketing videos', 'Repurposing blog posts into video format', 'YouTube Shorts and Reels content production']
),

(
  'opus-clip',
  'Opus Clip',
  'AI video repurposing that turns long videos into viral short clips',
  E'Opus Clip is an AI-powered video repurposing tool that takes long-form content — webinars, podcasts, interviews, YouTube videos — and automatically identifies the most engaging moments to clip, resize, and caption as short-form social content for TikTok, Instagram Reels, and YouTube Shorts. The AI analyses speech patterns and content signals to select clips with strong hooks and natural endings, ranked by a predicted virality score. Each clip is automatically resized for vertical formats, subtitles are burned in with animated styling, and the speaker is kept in frame throughout using an intelligent auto-reframe system.\n\nWhere manual clip selection and captioning of a one-hour video typically takes several hours of editing, Opus Clip processes the same material in minutes and delivers a set of ready-to-publish short clips. This makes it the most widely adopted tool for creators and marketing teams who produce long-form content but need a strong presence on short-form platforms. The free tier allows a limited number of monthly clips with Opus Clip branding. The Pro plan at $19 per month significantly increases the monthly clip allowance, removes branding, and unlocks higher quality processing and additional social platform integrations.',
  'https://www.google.com/s2/favicons?domain=opus.pro&sz=64',
  'https://opus.pro',
  'https://opus.pro',
  ARRAY['video-ai', 'content'],
  'freemium', true, 19,
  4.5, 1890, false, true, false,
  ARRAY['Automated clip selection ranked by predicted virality', 'Intelligent auto-reframe keeps speaker centred in vertical format', 'Animated captions burned in automatically', 'Processes a one-hour video in minutes'],
  ARRAY['Clip quality varies for non-English content', 'Branding on free tier clips', 'Virality score is a prediction, not a guarantee'],
  ARRAY['Repurposing podcasts and webinars into social clips', 'YouTube to TikTok and Reels content adaptation', 'Conference talk and panel discussion clipping', 'Marketing team content amplification workflows']
),

(
  'beautiful-ai',
  'Beautiful.ai',
  'Smart presentation software that designs slides automatically as you type',
  E'Beautiful.ai is an AI-powered presentation platform that automates slide design by applying formatting rules in real time as content is added. Unlike traditional presentation tools where the designer manually positions every element, Beautiful.ai''s Smart Slide technology reads the structure of the content and automatically chooses appropriate layouts, adjusts spacing, and balances visual hierarchy. Adding a bullet point triggers an immediate layout rebalance; switching from three items to five rearranges the slide to accommodate the change cleanly. The result is presentations that look professionally designed regardless of the user''s design background.\n\nThe platform includes over 60 slide templates covering common presentation structures — timelines, process flows, org charts, data visualisations, team grids — that automatically adapt their layout to the content added. AI text generation assists with drafting slide content directly within the editor. Teams can establish shared brand kits with approved fonts, colours, and logo placements that apply automatically across all presentations. Beautiful.ai is popular among sales teams, consultants, and managers who create frequent presentations and want consistent output without design overhead. The Pro plan is $12 per month, and the Team plan adds brand controls, shared template libraries, and real-time collaboration for presentation-heavy organisations.',
  'https://www.google.com/s2/favicons?domain=beautiful.ai&sz=64',
  'https://beautiful.ai',
  'https://beautiful.ai',
  ARRAY['productivity', 'content'],
  'paid', false, 12,
  4.3, 760, false, false, false,
  ARRAY['Smart Slide technology auto-formats content as you type', 'Brand kit enforcement across all team presentations', '60+ smart templates for common business structures', 'AI text generation for slide content drafting'],
  ARRAY['No free plan — paid only from day one', 'Less flexible than PowerPoint for highly customised layouts', 'Animation options more limited than traditional tools'],
  ARRAY['Sales proposals and pitch decks that need consistent branding', 'Consulting and agency client presentations', 'Regular internal reporting and company updates', 'Teams replacing PowerPoint for faster slide creation']
),

(
  'rytr',
  'Rytr',
  'Affordable AI writing assistant for short-form content and copy',
  E'Rytr is an AI writing assistant focused on affordability and breadth of use cases for short-form content. It covers over 40 content types — blog post outlines and introductions, social media captions, email subject lines, product descriptions, ad copy, YouTube descriptions, and more — through a template-based interface where users select a use case, fill in brief context, and generate multiple output variants to choose from. The output quality is solid for short-form copy, and the tone selector with over 20 preset tones gives marketers and copywriters control over voice without rewriting the entire prompt.\n\nRytr positions itself as the most cost-effective AI writing tool available: the Unlimited plan at $9 per month removes all character limits for monthly generation, making it far cheaper than Jasper or Copy.ai for comparable short-form use cases. The free tier supports up to 10,000 characters per month, sufficient for occasional use. Rytr does not include a standalone document editor or brand voice training, but for focused short-form output at scale — product descriptions, social captions, email subject lines — its price-to-output ratio is difficult to beat. It is the practical choice for freelancers, small businesses, and solo content creators who need a reliable writing assistant without an enterprise budget.',
  'https://www.google.com/s2/favicons?domain=rytr.me&sz=64',
  'https://rytr.me',
  'https://rytr.me',
  ARRAY['writing-ai'],
  'freemium', true, 9,
  4.2, 1340, false, false, false,
  ARRAY['Unlimited plan at just $9 per month', '40+ content use case templates', '20+ tone options for voice control', 'Free tier available with 10,000 characters per month'],
  ARRAY['No long-form document editor', 'No brand voice training or memory', 'Output quality lags behind Jasper for complex content'],
  ARRAY['Product descriptions for e-commerce at scale', 'Social media captions across platforms', 'Email subject line testing and copywriting', 'Ad copy variations for paid campaigns']
),

(
  'frase',
  'Frase',
  'AI SEO content briefs and writing tool built for organic search',
  E'Frase is an AI-powered SEO content platform that combines content briefing, competitive research, and AI writing into a single workflow. The briefing engine analyses the top-ranking pages for any target keyword and extracts the topics, questions, headings, and entities they cover, compiling a comprehensive outline that gives writers a clear blueprint for outperforming existing content. The AI writing assistant then helps draft content around this brief, ensuring coverage of the key topics that search engines reward without requiring manual research across dozens of competing pages.\n\nWhere general-purpose AI writers like Jasper or Copy.ai are stronger for marketing copy and brand voice, Frase is specifically built for SEO-driven content production. The scoring system shows how well a draft covers the identified topics compared to competitors, guiding writers toward more comprehensive content before publishing. Teams using Frase typically reduce content research time significantly per article while improving the consistency of topic coverage across a site. The Solo plan starts at $15 per month for one user and five documents per month. The Basic plan at $45 per month is more practical for teams producing consistent content volume, with unlimited documents and AI writing credits included.',
  'https://www.google.com/s2/favicons?domain=frase.io&sz=64',
  'https://frase.io',
  'https://frase.io',
  ARRAY['writing-ai', 'seo'],
  'paid', false, 15,
  4.3, 980, false, false, false,
  ARRAY['SERP-based content briefs from top-ranking competitors', 'Topic coverage scoring guides writing toward better rankings', 'Combines research, outline, and AI writing in one tool', 'Strong for teams producing consistent SEO content volume'],
  ARRAY['No free plan — Solo plan starts at $15 per month', 'Less suited to brand voice or creative copywriting', 'Document limits on lower-tier plans constrain output volume'],
  ARRAY['SEO blog post research and outlining', 'Competitive content gap analysis', 'Writing articles optimised for target keywords', 'Content audit and improvement of existing pages']
),

(
  'riverside',
  'Riverside',
  'Studio-quality remote podcast and video recording with AI editing',
  E'Riverside is a professional podcast and video interview recording platform designed for remote recordings that need broadcast quality. Where tools like Zoom capture a compressed mixed feed, Riverside records each participant''s audio and video locally at full quality and uploads them separately after the session, eliminating the quality degradation that comes from internet instability during the call. The result is individual studio-quality tracks for every participant that give editors full control in post-production. The platform supports recordings up to 4K video and 48kHz WAV audio, matching the technical standards of professional podcast studios.\n\nBeyond recording, Riverside includes an AI-powered editor that transcribes recordings, removes filler words, and generates highlight clips and social-ready audiograms automatically. The Magic Clips feature identifies strong moments from longer recordings and formats them for short-form platforms. This combination of high-quality recording and AI-assisted editing makes Riverside popular among professional podcasters, media companies, and B2B content teams who conduct interviews at scale. The free plan supports two hours of recording per month. The Standard plan at $15 per month increases the recording allowance and unlocks the full AI editing feature set including automatic transcription, filler word removal, and clip generation.',
  'https://www.google.com/s2/favicons?domain=riverside.fm&sz=64',
  'https://riverside.fm',
  'https://riverside.fm',
  ARRAY['voice-ai', 'content'],
  'freemium', true, 15,
  4.6, 1120, false, false, false,
  ARRAY['Local recording preserves studio-quality audio regardless of internet', 'Separate tracks per participant for full post-production control', 'AI filler word removal and clip generation built in', 'Supports 4K video and 48kHz WAV audio quality'],
  ARRAY['Local recording requires upload time after session ends', 'Free plan limited to two hours per month', 'AI editor less powerful than standalone tools like Descript'],
  ARRAY['Remote podcast interviews with professional audio quality', 'B2B thought leadership and executive interview content', 'Video interview series for YouTube and LinkedIn', 'Webinar recording with speaker separation for editing']
),

(
  'cohere',
  'Cohere',
  'Enterprise-grade large language models and embeddings via API',
  E'Cohere is an enterprise AI platform offering large language models, text embedding, and reranking capabilities via API for developers and businesses building AI-powered applications. Unlike consumer-facing AI tools, Cohere is designed for technical teams integrating AI into production systems — customer support automation, semantic search, document summarisation, classification, and retrieval-augmented generation. The platform''s Command models are optimised for enterprise use cases including long-document processing and following precise instructions reliably at scale. Cohere''s Embed models are widely used for building semantic search systems where documents are matched to queries by meaning rather than keyword overlap.\n\nCohere''s primary advantage over alternatives like OpenAI''s API is its focus on enterprise security and deployment flexibility: models can be deployed on-premises, in a private cloud, or via Cohere''s managed cloud, meeting data sovereignty requirements that prevent organisations from sending sensitive documents to shared public API endpoints. This makes it well-positioned for legal, healthcare, and financial services companies that need enterprise AI capabilities with data privacy controls that consumer platforms do not offer. A free trial tier is available for development and testing. Production API usage is priced per token with volume discounts for enterprise customers.',
  'https://www.google.com/s2/favicons?domain=cohere.com&sz=64',
  'https://cohere.com',
  'https://cohere.com',
  ARRAY['code-ai'],
  'freemium', true, 0,
  4.3, 640, false, false, false,
  ARRAY['On-premises and private cloud deployment options', 'Strong semantic search with Embed models', 'Command models optimised for enterprise instructions', 'Free trial tier for development and evaluation'],
  ARRAY['Primarily a developer API — not suitable for non-technical users', 'Less consumer-facing documentation than OpenAI', 'Smaller developer community and third-party integration ecosystem'],
  ARRAY['Building semantic search across internal document libraries', 'Customer support automation with RAG pipelines', 'Document classification and extraction at enterprise scale', 'Private LLM deployment for regulated industries']
),

(
  'captions-ai',
  'Captions',
  'AI captions and video editing for creators who record to camera',
  E'Captions is an AI-powered video creation and editing app designed for content creators who produce talking-head video for social media. The core feature is automatic subtitle generation that transcribes speech, applies animated captions in styles optimised for viewer retention, and syncs them precisely to the speaker''s delivery. Research consistently shows that captioned videos retain viewers significantly longer on platforms like TikTok, Instagram Reels, and YouTube Shorts, where a large percentage of viewers watch without sound. Captions supports over 28 languages for transcription and translation, allowing creators to produce localised content from a single recording.\n\nBeyond subtitles, Captions includes an AI editor that removes filler words and awkward pauses from recordings in one click, suggests cuts for better pacing, and adds B-roll imagery to illustrate key talking points. The Eye Contact Correction feature adjusts the speaker''s gaze to maintain direct eye contact with the camera even when reading from notes — a subtle but meaningful improvement for professional-looking content. The free plan includes basic captioning and limited exports. The Pro plan at $19 per month unlocks the full feature set including filler word removal, B-roll suggestions, eye contact correction, and unlimited HD exports.',
  'https://www.google.com/s2/favicons?domain=captions.ai&sz=64',
  'https://captions.ai',
  'https://captions.ai',
  ARRAY['video-ai', 'content'],
  'freemium', true, 19,
  4.5, 1560, false, true, false,
  ARRAY['Eye Contact Correction keeps speaker looking into camera', 'One-click filler word and pause removal', '28+ language support for captions and translation', 'Animated caption styles optimised for social retention'],
  ARRAY['Primarily for talking-head video — limited for other formats', 'Advanced features locked behind Pro plan', 'Eye Contact Correction not perfect on every recording'],
  ARRAY['TikTok, Reels, and Shorts with high viewer retention', 'Multilingual content for international audiences', 'Polishing talking-head videos quickly before posting', 'Educational and tutorial video captioning']
),

(
  'julius-ai',
  'Julius',
  'Chat with your data — AI analysis of spreadsheets and datasets',
  E'Julius is an AI data analyst that allows users to upload datasets in CSV, Excel, or Google Sheets format and analyse them through natural language conversation. Instead of writing formulas, SQL queries, or Python scripts, users describe what they want to know — show month-over-month growth, identify which customer segments have the highest churn, create a scatter plot of revenue against acquisition cost — and Julius generates the analysis, visualisation, or summary immediately. It supports complex statistical operations, regression analysis, and data cleaning tasks, making advanced data analysis accessible without deep technical skills.\n\nJulius can also write and execute Python or R code when more sophisticated analysis is required, and users can see and modify the underlying code if they prefer a more technical approach. This makes it useful for both non-technical business analysts who want fast answers and data professionals who want to accelerate exploratory analysis without writing boilerplate. Charts and tables can be exported for use in presentations and reports. The free plan allows a limited number of messages per day. The Pro plan at $20 per month removes message limits, enables larger dataset uploads, and supports more complex multi-step analyses with priority processing for faster results.',
  'https://www.google.com/s2/favicons?domain=julius.ai&sz=64',
  'https://julius.ai',
  'https://julius.ai',
  ARRAY['analytics', 'research'],
  'freemium', true, 20,
  4.4, 870, false, true, false,
  ARRAY['Natural language queries replace formulas and SQL', 'Generates and executes Python and R code transparently', 'Works with CSV, Excel, and Google Sheets directly', 'Charts and tables exportable for reports and presentations'],
  ARRAY['Message limits on free plan restrict daily use', 'Less suitable for very large datasets requiring database tools', 'Not a replacement for BI tools on complex ongoing reporting'],
  ARRAY['Business analysts exploring sales and revenue data', 'Marketing teams analysing campaign performance metrics', 'Researchers conducting statistical analysis on survey data', 'Founders tracking key metrics without a data engineer']
)

ON CONFLICT (slug) DO NOTHING;
