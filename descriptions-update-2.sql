-- Session 13: Descriptions Batch A — 20 high-traffic tools
-- Run in Supabase SQL Editor after descriptions-update.sql (Session 12)
-- Plain prose, no markdown. Paragraphs separated by \n\n (rendered as multiple <p> tags)

UPDATE tools SET description = 'Grammarly is the AI writing assistant used by more than 30 million people and 70,000 teams worldwide. It runs as a browser extension, desktop app, and keyboard on mobile — checking your writing across Gmail, Google Docs, Slack, LinkedIn, Word, and virtually every other platform where you type.

The core product is a real-time grammar and spell checker, but Grammarly has evolved well beyond that. Its AI now rewrites entire sentences for clarity, suggests vocabulary upgrades, adjusts the tone of your writing to match a given context, and flags when something reads as too formal, too casual, or potentially offensive to a specific audience. The business plan extends this with a brand tone feature — so everyone on a team writes with a consistent voice.

Grammarly Business includes a plagiarism detector, writing analytics across the team, and style guide enforcement. For organisations producing a lot of external content — proposals, support emails, marketing copy, legal documents — the consistency and quality lift across the team is meaningful.

The free plan covers basic grammar and spelling corrections and is useful on its own. Grammarly Premium at $12 per month (billed annually) unlocks the full rewriting, tone detection, and style suggestions. Grammarly Business is priced per seat starting at $15 per member per month, with volume discounts for larger teams.

Grammarly is best suited to professionals who write in English and want to ship polished, error-free text faster — without a dedicated editor reviewing their work.'
WHERE slug = 'grammarly';

UPDATE tools SET description = 'Canva AI is the suite of artificial intelligence features built into Canva, the graphic design platform used by more than 170 million people. Rather than a standalone product, Canva AI extends the existing Canva editor with generative capabilities — making it the fastest path to AI-assisted design for anyone already in the Canva ecosystem.

The headline feature is Magic Studio, which bundles several AI tools into a single design assistant. Magic Design generates complete layouts from a text prompt or an uploaded photo. Magic Write drafts copy for presentations, social media captions, or marketing materials directly inside the design canvas. Magic Edit lets you select any region of an image and replace or transform it using a text prompt — without needing to leave Canva and open a separate image editor.

Background Remover, previously a premium feature, is now powered by AI and available with one click. Translate automatically converts text in a design into any of 100+ languages, which is particularly useful for teams running campaigns across multiple markets.

For teams that produce a lot of branded content — social posts, presentations, reports, ads — Canva AI significantly reduces the per-asset production time. Designers use it to generate first drafts and variations at speed; non-designers use it to produce professional-looking work without design training.

Canva AI features are available on the Pro plan at $15 per month per person, the Teams plan at $10 per person per month (minimum 3 users), and are partially available on the free tier. All plans include access to Canva''s template library and asset editor.'
WHERE slug = 'canva-ai';

UPDATE tools SET description = 'Adobe Firefly is Adobe''s family of generative AI models, built specifically for creative and commercial use. Unlike general-purpose image generators, Firefly is trained exclusively on licensed content — Adobe Stock images, openly licensed material, and public domain work — which means output is designed to be safe for commercial use without the copyright uncertainty that surrounds other models.

The primary interface is the Firefly web application, where you can generate images from text prompts, create text effects, recolour vector graphics, and generate backgrounds from a text description. The quality is competitive with leading generators, particularly for product photography, editorial illustration, and abstract creative concepts.

What makes Firefly distinct is its deep integration into the Adobe Creative Cloud suite. In Photoshop, the Generative Fill feature lets you select any area of a canvas and generate new content that seamlessly matches the surrounding image — lighting, texture, and perspective are handled automatically. In Illustrator, Generative Recolour remaps an entire vector file to a new colour palette from a text description. In Premiere Pro, generative tools extend video clips and fill gaps in footage.

For creative professionals already working in Adobe software, Firefly is the most frictionless AI integration available — it appears directly inside the tools they already use, rather than requiring a separate workflow.

Firefly generative credits are included in all Adobe Creative Cloud plans. Individual Creative Cloud plans start at $59.99 per month. Firefly is also available as a standalone web app with a free tier offering 25 generative credits per month.'
WHERE slug = 'adobe-firefly';

UPDATE tools SET description = 'Jasper is an AI writing platform built for marketing teams and content operations at scale. Where general-purpose AI assistants write well but require careful prompting, Jasper is purpose-built for marketing workflows — with templates, brand voice training, and campaign-level content management designed into the product from the start.

The brand voice feature is Jasper''s most important differentiator. You feed Jasper samples of your existing content — blog posts, email campaigns, social copy — and it learns your tone, vocabulary, and stylistic preferences. From that point on, every piece of content it generates matches your voice rather than defaulting to a generic AI register. For teams managing multiple brands or products, you can store multiple voice profiles and switch between them.

Jasper''s template library covers more than 80 content types: long-form blog posts, Google and Facebook ad copy, product descriptions, email subject lines, YouTube scripts, and more. The campaign workflow lets you create related assets — a blog post, three email variations, and five social captions — all briefed once and generated with consistent messaging.

The platform integrates with Surfer SEO for on-page optimisation, and with Google Docs and Chrome for writing assistance outside of Jasper itself.

Jasper is priced for teams: the Creator plan starts at $49 per month for individual marketers, while Pro at $69 per month adds brand voice training and collaboration features. Business plans with custom pricing are available for larger organisations. Jasper is best suited to marketing teams producing content at volume who need consistent quality and on-brand output without heavy editing overhead.'
WHERE slug = 'jasper';

UPDATE tools SET description = 'Copy.ai is an AI writing tool focused on go-to-market content — the emails, landing pages, ad copy, product descriptions, and sales sequences that drive revenue. It is used by sales development representatives, growth marketers, and small business owners who need professional marketing copy produced quickly without a dedicated copywriter.

The platform is built around workflows rather than blank prompts. You select a content type — cold email sequence, product description, LinkedIn post, value proposition — and Copy.ai guides you through providing the right inputs. The output is formatted and ready to use, rather than requiring you to structure raw AI output yourself. This makes it significantly faster to use than general-purpose assistants for standard marketing tasks.

Copy.ai''s GTM AI Platform, aimed at sales teams, generates personalised cold email sequences at scale — pulling company and prospect data to customise messaging for each recipient. For SDR teams sending hundreds of outbound emails per week, this reduces the per-email writing time from minutes to seconds.

The free plan includes 2,000 words per month and access to most templates — sufficient for occasional use. Pro at $49 per month removes word limits and adds workflow automation features. Teams plans with collaboration and admin controls are available from $249 per month.

Copy.ai is the right choice for sales and marketing professionals who need a tool optimised specifically for commercial copy, rather than a general writing assistant they need to adapt to their use case.'
WHERE slug = 'copy-ai';

UPDATE tools SET description = 'Writesonic is an AI writing platform that covers the full content production stack — long-form articles, landing pages, ad copy, product descriptions, and an AI chatbot — in a single subscription. It is positioned as a direct alternative to Jasper for content teams that want more features at a lower price point.

The platform''s standout feature is Chatsonic, its AI assistant built on GPT-4 with real-time web search. Unlike base ChatGPT, Chatsonic can retrieve current information — today''s news, live pricing, recent product launches — making it useful for content that needs to be timely rather than based solely on training data. It also generates images via DALL-E 3 within the chat interface.

For SEO-focused content, Writesonic integrates keyword research and on-page optimisation guidance into the article writing flow. You enter a topic and target keywords, and the platform generates an outline, then a full article structured around those terms. A built-in brand voice feature, similar to Jasper''s, lets you train the model on your existing content.

Article Forge, Writesonic''s bulk content generation feature, can produce multiple articles from a keyword list automatically — useful for programmatic SEO or large content operations.

Pricing starts at $20 per month for the Small Team plan (including 200,000 words and Chatsonic access), with higher tiers for larger usage volumes. An unlimited plan at $99 per month covers enterprise-scale content needs.

Writesonic is best suited to SEO-focused content teams and digital agencies that need a capable, cost-effective alternative to more expensive platforms.'
WHERE slug = 'writesonic';

UPDATE tools SET description = 'SEMrush is the most comprehensive digital marketing intelligence platform available, used by more than 10 million marketing professionals globally. It combines SEO research, paid search analysis, content marketing tools, social media management, and competitive intelligence into a single platform — making it the default tool of choice for in-house SEO teams and digital agencies.

The platform''s keyword database covers more than 25 billion keywords across 142 geographic databases, making its search volume and difficulty estimates among the most reliable available. The Site Audit tool crawls your website and produces a prioritised list of technical SEO issues — missing tags, broken links, page speed problems, Core Web Vitals failures — with clear explanations of why each issue matters and how to fix it.

Competitive research is where SEMrush is particularly powerful. Organic Research shows you every keyword a competitor ranks for, their estimated traffic, and which pages drive the most visits. Traffic Analytics estimates monthly visits and engagement metrics for any domain — useful for benchmarking your own performance and identifying gaps.

The Keyword Magic Tool generates thousands of keyword variations from a seed term, filtered by search intent, difficulty, and volume — giving content and SEO teams a data-driven brief for every piece they produce.

SEMrush pricing starts at $139.95 per month for the Pro plan (suitable for freelancers and small teams), $249.95 per month for Guru (which adds historical data and content marketing tools), and $499.95 per month for Business. Annual billing reduces each tier by approximately 17%. The platform is best suited to organisations that take search seriously as a growth channel and need data-driven decisions rather than intuition.'
WHERE slug = 'semrush';

UPDATE tools SET description = 'Ahrefs is the SEO toolset trusted by many of the world''s leading digital marketing teams. Built around the largest backlink index available — updating with new links every 15–30 minutes — Ahrefs is the definitive tool for link building research, competitive SEO analysis, and content strategy.

The Site Explorer is Ahrefs'' core product. Enter any domain or URL and it returns a complete picture: referring domains, backlink profile, organic keyword rankings, estimated monthly traffic, and top-performing pages by traffic and backlinks. For competitive research, this is faster and more detailed than any other tool available — you can see exactly what is driving a competitor''s growth and reverse-engineer their strategy.

The Keywords Explorer covers more than 10 search engines and 170 countries, with search volume estimates, keyword difficulty scores, and traffic potential calculations. The Traffic Potential metric — which estimates how much traffic the top-ranking page receives across all the keywords it ranks for, not just the target keyword — is a uniquely practical measure of content opportunity.

Content Explorer searches Ahrefs'' index of more than 13 billion web pages to find the most-linked and most-trafficked content on any topic. For content strategists looking for proven angles and formats, this is the fastest way to understand what works in a given space.

The Site Audit tool handles technical SEO crawling, identifying issues across page speed, structured data, internal linking, and content quality.

Ahrefs pricing starts at $129 per month for Lite, $249 for Standard, and $449 for Advanced. Unlike SEMrush, Ahrefs does not currently offer a free trial — but a $7 7-day trial is available. It is best suited to SEO teams and link-building specialists for whom backlink intelligence is a core workflow.'
WHERE slug = 'ahrefs';

UPDATE tools SET description = 'Zapier is the automation platform that connects more than 7,000 web applications without requiring any code. It is used by operations teams, marketing departments, and small businesses to eliminate repetitive manual work — moving data between tools, triggering actions based on events, and maintaining workflows that run automatically in the background.

The core concept is the Zap: a workflow with a trigger (something that happens in one app) and one or more actions (things that happen automatically in other apps as a result). A simple example: when a new lead fills out a Typeform, Zapier automatically creates a row in Google Sheets, adds the contact to HubSpot, and sends a welcome email via Mailchimp — all without human intervention.

Zapier''s breadth of integrations is its primary advantage. With 7,000+ connected apps covering virtually every category of business software — CRM, email, project management, e-commerce, payments, communication — it is the most likely tool to connect whatever combination of software a given team uses.

Zapier AI adds a conversational interface where you describe the workflow you want in plain language and Zapier builds the Zap structure for you. This significantly lowers the configuration barrier for non-technical users.

Multi-step Zaps, filters, conditional logic, and paths — which allow a single trigger to branch into different actions based on conditions — are available on paid plans. The free plan is limited to single-step Zaps and 100 tasks per month.

Pricing starts at $29.99 per month for the Starter plan (750 tasks, multi-step Zaps) and scales to $73.50 for Professional (2,000 tasks). Zapier is best suited to teams who want automation without development resources — particularly operations, revenue, and marketing teams managing multiple tools.'
WHERE slug = 'zapier';

UPDATE tools SET description = 'Make (formerly Integromat) is a visual automation platform that lets you build complex, multi-step workflows by connecting applications through a drag-and-drop interface. It occupies the space between Zapier (simpler, broader) and custom code (more powerful, but requires engineering resources) — offering significantly more logic and data transformation capability than Zapier at a lower price point.

The visual builder is Make''s defining feature. Workflows — called scenarios — are displayed as a flowchart of connected modules, making it easy to see and understand the full logic of a complex automation at a glance. This visual representation makes debugging faster and documentation easier compared to the list-based interface that most automation tools use.

Make supports iteration, aggregation, error handling, and custom data mapping within the builder — capabilities that Zapier reserves for higher tiers or does not offer at all. You can loop through arrays of data, aggregate multiple inputs into a single output, branch into parallel paths, and handle errors gracefully without writing any code.

The platform integrates with more than 1,800 applications, covering the core business software categories. For more specialised integrations, Make supports HTTP requests and webhooks, which means it can connect to any API-capable service.

Make pricing is based on operations (each module execution in a scenario counts as one operation). The free plan includes 1,000 operations per month. The Core plan at $10.59 per month provides 10,000 operations; Pro at $18.82 per month adds priority support and advanced features. Make is best suited to technically-minded users who want more automation power than Zapier offers but are not ready to write and maintain custom code.'
WHERE slug = 'make';

UPDATE tools SET description = 'Leonardo AI is an image generation platform built specifically for game developers, concept artists, and creative professionals who need high-volume, stylistically consistent visual assets. While general-purpose tools like Midjourney prioritise aesthetic quality on individual generations, Leonardo is designed for production workflows where you need to generate hundreds of assets that look like they belong to the same visual universe.

The platform''s key differentiator is model training. You can upload a set of reference images — character sheets, environment concepts, UI elements — and train a custom model that generates new images in that exact style. For game studios building a consistent visual language, this capability reduces the per-asset iteration time dramatically and ensures stylistic coherence across an entire project.

Leonardo offers both its own proprietary models and access to a selection of community-trained models across art styles: photorealism, anime, concept art, pixel art, 3D renders, and more. The model selection is deeper than most platforms, which matters when you need a specific aesthetic rather than a general-purpose output.

The platform also includes Canvas, a web-based image editor for inpainting, outpainting, and compositing — letting you extend or modify generated images without switching to a separate application.

The free plan provides 150 tokens daily (roughly 30–50 image generations depending on settings). Paid plans start at $12 per month for Artisan (8,500 tokens monthly), with higher tiers for larger production volumes. Leonardo is best suited to game developers, illustrators, and creative teams who need stylistically consistent images at volume rather than one-off high-quality generations.'
WHERE slug = 'leonardo-ai';

UPDATE tools SET description = 'HeyGen is an AI video generation platform that creates professional-looking talking-head videos from text — without cameras, studios, or actors. It is used by marketing teams, corporate trainers, content creators, and global enterprises to produce video content at a fraction of the traditional cost and turnaround time.

The core workflow is simple: you select an AI avatar (from HeyGen''s library of 100+ diverse presenters), type or paste your script, choose a language and voice, and HeyGen renders a video of the avatar presenting your content. The result is a polished presenter-style video that would traditionally require booking a location, hiring a presenter, and spending a day in production.

HeyGen''s voice cloning and avatar personalisation features set it apart from simpler alternatives. You can create a custom avatar from a short video of yourself — so all videos are presented by your likeness, not a stock character. Voice cloning captures your tone and cadence from a brief audio sample. The combination means your video presence can be scaled without ongoing recording sessions.

Video translation is a significant use case: HeyGen can translate an existing video into more than 40 languages and lip-sync the avatar to the translated audio. For companies expanding internationally, this eliminates the cost and logistics of re-recording in each market.

The Free plan allows 1 minute of video per month. Creator at $29 per month provides 15 minutes of video with access to custom avatars. Team plans start at $89 per month. HeyGen is best suited to marketing, HR, and learning teams that produce regular video content and want to scale output without proportional increases in production cost.'
WHERE slug = 'heygen';

UPDATE tools SET description = 'Descript is an audio and video editing platform built around a transcript rather than a traditional timeline. You record or import your media, Descript transcribes it automatically, and then you edit the video by editing the text — deleting a word from the transcript removes the corresponding clip from the video. For podcast producers, video creators, and anyone who spends time cutting talking-head footage, this is one of the most significant workflow improvements in video editing in the past decade.

Overdub is Descript''s AI voice cloning feature. After training on a sample of your voice, Overdub lets you fix audio errors by typing the correction — Descript generates the replacement audio in your voice and inserts it seamlessly. For podcasters correcting stumbles or content creators fixing mistakes after the fact, this eliminates the need for re-recording sessions.

The AI Filler Word Removal feature detects and removes every instance of "um," "uh," "like," and similar filler words from a recording with a single click. Combined with automatic silence removal, this can cut 20–30% of the edit time from a typical podcast or interview recording.

Descript''s Screen Recorder captures your screen and webcam simultaneously, making it straightforward to produce tutorial and walkthrough content without additional software. The platform is fully collaborative — multiple editors can work on the same project simultaneously, with version history and comments.

The free plan is generous for personal use. Creator at $24 per month and Pro at $40 per month unlock Overdub, higher export quality, and more AI features. Descript is best suited to podcast producers, YouTubers, course creators, and corporate content teams.'
WHERE slug = 'descript';

UPDATE tools SET description = 'Replit is a cloud-based development environment that runs entirely in the browser — no local installation, no dependency management, no environment configuration. You open a URL, choose a programming language or framework, and start coding within seconds. It is used by students learning to code, educators running programming courses, and developers who want to prototype ideas quickly without setting up a local environment.

The platform supports more than 50 programming languages and includes pre-configured templates for web development, data science, game development, and APIs. Every project (called a Repl) gets its own dedicated container with persistent storage, a URL for sharing, and built-in deployment to Replit''s hosting infrastructure.

Replit AI (formerly Ghostwriter) is the integrated coding assistant. It offers code completion inline, a chat interface for explaining code and answering questions, and an AI debugger that identifies errors and suggests fixes without leaving the editor. For learners especially, having an AI assistant that understands the context of the project open in the editor is more effective than asking a separate chat window.

Multiplayer mode lets multiple users edit the same Repl simultaneously, with live cursor tracking and integrated chat — making it useful for pair programming, teaching sessions, and collaborative prototyping.

Deployments are handled directly from Replit with custom domain support and automatic scaling. For small projects and APIs, this eliminates the need for a separate hosting provider.

The free plan is suitable for learning and personal projects. The Core plan at $20 per month adds more compute resources, private Repls, and expanded AI features. Replit is best suited to learners, educators, and developers who prioritise speed of iteration over the control of a local development environment.'
WHERE slug = 'replit';

UPDATE tools SET description = 'Tabnine is an AI code completion tool that runs across all major IDEs — VS Code, JetBrains, Vim, Neovim, Eclipse, and more — with a focus on privacy, security, and enterprise compliance. While GitHub Copilot is the most prominent competitor, Tabnine differentiates primarily on its ability to run models locally (without sending code to external servers) and on its enterprise-grade data privacy guarantees.

Tabnine''s completion engine suggests code at the line, function, and block level as you type, drawing context from the current file and related files in the project. The suggestions are generally fast and accurate for standard patterns, particularly in JavaScript, TypeScript, Python, Java, and Kotlin.

The enterprise-critical differentiator is the local model option. Tabnine can run a smaller model entirely on your machine — no internet connection required, no code leaving the network perimeter. For organisations in regulated industries (finance, healthcare, government) where code cannot be sent to third-party cloud services, this is often a hard requirement that Copilot cannot meet.

Tabnine also offers a private cloud deployment option for teams that need the performance of a larger model but with data residency guarantees — the model runs in the organisation''s own cloud environment.

The free plan offers basic single-line completions with the smaller model. Tabnine Pro at $12 per month per user enables the more powerful cloud model with multi-line completions. Enterprise pricing is custom and includes the local and private cloud deployment options.

Tabnine is best suited to developer teams in security-sensitive environments where code privacy is a non-negotiable requirement, or to individual developers who prefer an IDE-native assistant over a chat-first interface.'
WHERE slug = 'tabnine';

UPDATE tools SET description = 'Surfer SEO is an on-page SEO optimisation tool that analyses the top-ranking pages for a given keyword and tells you precisely what your content needs to do to rank. It measures content length, keyword density, heading structure, NLP entities, and more than 500 other on-page signals — then gives you a real-time content score as you write.

The Content Editor is the core product. You enter your target keyword, Surfer analyses the top 10–20 results, and generates a live brief: suggested word count, recommended headings, required keywords and their ideal frequency, and NLP terms that high-ranking pages share. As you write or edit content in the editor, your content score updates in real time — turning SEO optimisation from guesswork into a measurable process.

The Keyword Research tool identifies clusters of semantically related keywords that can be targeted by a single piece of content, which is more efficient than writing separate articles for each term. The Topical Map feature generates a complete content strategy for a niche, identifying the clusters of articles you need to establish authority in a topic area.

Surfer AI, the platform''s AI writing feature, can generate a complete draft article optimised to the target keyword''s requirements — ready to edit rather than starting from a blank page.

The Audit tool analyses existing pages on your site and identifies specific changes — add this keyword, extend this section, fix these headings — to improve rankings without a full rewrite.

Surfer SEO pricing starts at $99 per month for Essential (30 articles), $219 for Scale (100 articles). It is best suited to content teams and SEO agencies who produce regular blog content and want a data-driven process for on-page optimisation.'
WHERE slug = 'surfer-seo';

UPDATE tools SET description = 'Figma is the browser-based design and prototyping tool that has become the industry standard for product design teams. It replaced desktop applications like Sketch for most professional design work by making real-time collaboration native — multiple designers can work on the same file simultaneously, product managers can comment directly on designs, and developers can inspect the code values of any element without a handoff document.

The core canvas handles everything from low-fidelity wireframes to pixel-perfect UI components and interactive prototypes. Components — reusable design elements with overridable properties — make large design systems manageable and keep design consistent across a product. Auto Layout handles responsive behaviour, so a button component automatically adjusts its width to match its label without manual resizing.

Variables, introduced in 2023, allow designers to store and apply design tokens — colours, spacing values, typography scales — in a way that maps directly to how developers implement them. This has significantly reduced the friction at the design-to-code handoff.

FigJam, Figma''s companion product, is a whiteboarding tool for brainstorming, planning, and diagramming. It is included in most Figma plans and is commonly used for user journey mapping, retrospectives, and product planning sessions.

Dev Mode gives developers a dedicated view of designs with code snippets in CSS, iOS, and Android — and integrates with VS Code so developers can inspect designs without leaving their editor.

Figma''s free Starter plan supports up to 3 design files — enough to evaluate the tool. The Professional plan is $15 per editor per month, and the Organisation plan at $45 per editor per month adds design system management features. Figma is essential for any team building a digital product.'
WHERE slug = 'figma';

UPDATE tools SET description = 'Framer is a web design and publishing platform that lets designers build production-ready websites without writing code. It occupies the space between traditional design tools like Figma (output: design files) and web development (output: code) — Framer''s output is a live, deployed website with CMS, animations, and interactions built in.

The canvas works like a design tool: you place elements visually, control typography and spacing precisely, and see exactly what the published site will look like as you design. Unlike traditional design tools, there is no handoff step — the design is the site. Components can be made interactive with transitions, scroll animations, and conditional states, all configured visually.

Framer''s CMS handles dynamic content: blog posts, product listings, team member profiles, case studies. You define the content structure, build the layout once, and Framer generates individual pages for each CMS item automatically. For marketing sites that need a blog or portfolio section, this eliminates the need for a separate CMS integration.

The component system supports React overrides — advanced users can write custom code components that behave like design components on the canvas. This makes Framer suitable for sites that need complex interactions or data fetching beyond what the visual tools support.

Framer AI can generate entire page sections from a text prompt — a hero section, pricing table, or feature grid — which designers then edit to match their visual system.

The free plan publishes to a Framer subdomain. Paid plans start at $10 per month for the Mini plan (custom domain, 1 site) and scale with the number of sites and CMS items. Framer is best suited to designers, indie founders, and marketing teams who want full visual control over a site without managing code or infrastructure.'
WHERE slug = 'framer';

UPDATE tools SET description = 'Linear is the project management tool built specifically for software development teams who find Jira too slow and Trello too simple. It is used by engineering teams at companies including Vercel, Notion, and Raycast, and has built a loyal following by prioritising speed and simplicity over feature breadth.

Every interaction in Linear is designed to be fast. The keyboard-driven interface means experienced users rarely need to touch the mouse — issues can be created, assigned, prioritised, and moved between states with keyboard shortcuts. The application loads and responds instantly, with no spinners or lag between actions. For engineers and product managers who live in their project management tool, this performance difference is noticeable every day.

Linear''s data model is opinionated. Work is organised into Teams, Projects, and Cycles (two-week sprints by default). Issues have a small number of well-defined states and priority levels. The structure is simple enough that most teams are set up and productive within an hour, compared to the configuration overhead of Jira.

GitHub, GitLab, and Figma integrations are first-class. Linking a pull request to a Linear issue automatically moves the issue through states as the PR is reviewed and merged. Figma designs attached to issues are previewed inline. For teams whose workflow moves between code, design, and tickets, these integrations reduce context switching significantly.

Linear''s API is well-documented and fast, making it popular for teams that build internal tooling on top of their project management data.

The free plan supports up to 250 issues — suitable for small teams. Standard is $8 per user per month, Plus is $14, and custom Enterprise pricing is available. Linear is best suited to software engineering teams who want a tool that respects their time.'
WHERE slug = 'linear';

UPDATE tools SET description = 'Synthesia is an AI video generation platform for creating presenter-style videos at scale, without cameras or recording equipment. It is used primarily by corporate training, HR, and marketing teams who need to produce regular video content — onboarding videos, product updates, compliance training, internal communications — faster and more cost-effectively than traditional video production allows.

The workflow is text-in, video-out. You write a script, select an AI avatar from Synthesia''s library of more than 230 diverse presenters, choose a language and voice, and the platform renders a talking-head video of the avatar presenting your content. The full process typically takes less than 15 minutes for a standard 3–5 minute video, compared to a full day of production for the equivalent filmed content.

Synthesia supports more than 130 languages with natural-sounding AI voices — making it the most practical tool for organisations that need to localise video content across multiple markets. The same video can be translated and re-rendered in a new language from the editor, with the avatar''s lip movements updated to match.

Custom AI avatars let organisations create a digital twin of a real presenter — a company spokesperson, CEO, or training facilitator — from a short video recording. All future videos are then presented by the real person''s likeness, without requiring them to re-record.

The platform includes a template library, screen recording integration, and a media library for backgrounds and assets.

Synthesia pricing starts at $29 per month for the Starter plan (10 video credits), with Creator at $89 per month for higher volume. Enterprise plans with custom avatars and SSO are available on request. Synthesia is best suited to L&D, HR, and internal communications teams replacing expensive video production workflows.'
WHERE slug = 'synthesia';
