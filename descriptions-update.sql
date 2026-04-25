-- Session 12: Long-form descriptions for top 10 tools by rating
-- Run in Supabase SQL Editor
-- All descriptions are plain prose (no markdown) — rendered in a <p> tag

UPDATE tools SET description = 'Claude is an AI assistant built by Anthropic with a focus on safety, honesty, and reliability. Unlike many AI systems, Claude is designed from the ground up to be helpful without being deceptive, and to acknowledge uncertainty rather than confidently fabricate answers.

The most distinctive aspect of Claude is its context window. With support for up to 200,000 tokens in Claude 3.5, it can read entire codebases, long legal documents, or full books in a single conversation — making it uniquely suited for tasks that require deep comprehension of large amounts of text. Competing models frequently lose track of details buried in long documents; Claude maintains coherence throughout.

Claude excels at nuanced writing tasks. Whether you need a first draft that sounds like you, a technical explanation aimed at a non-expert audience, or a carefully worded email that strikes the right tone, Claude produces output that feels considered rather than generic. It also performs strongly on analysis tasks — summarising research papers, identifying gaps in arguments, and synthesising information from multiple sources.

For developers, Claude offers a well-documented API via Anthropic and integrates with tools like Cursor, Slack, and dozens of third-party platforms. It handles code generation across most major languages competently, though GitHub Copilot remains the specialist choice for inline IDE completion.

Claude is the right choice for professionals who write, research, or analyse text at volume — consultants, journalists, legal teams, academics, and senior individual contributors who need a reliable thinking partner rather than just a text generator. The free tier via Claude.ai gives you meaningful access to Claude 3.5 Sonnet at no cost.'
WHERE slug = 'claude';

UPDATE tools SET description = 'ChatGPT is the AI assistant that introduced conversational AI to mainstream audiences. Launched by OpenAI in late 2022, it became the fastest consumer product to reach 100 million users and has since grown into a platform used by individuals, enterprises, and developers worldwide.

GPT-4o, the model powering the current ChatGPT experience, handles text, images, audio, and code in a single multimodal interface. You can photograph a handwritten equation and ask for a step-by-step solution, upload a chart and get a business interpretation, or speak to ChatGPT and receive a natural voice response — all without switching tools or modes.

For everyday knowledge work, ChatGPT is fast, reliable, and broadly capable. It drafts emails, summarises meetings, writes code snippets, explains complex topics in plain language, and helps with research across virtually any domain. The quality of its responses is consistently good rather than exceptional — it rarely makes catastrophic errors, but it also rarely produces the kind of deep, considered output you might get from a more specialised tool or a slower, more careful model.

ChatGPT Plus subscribers get access to GPT-4o, persistent memory that remembers facts between conversations, custom GPTs built by the community for specific use cases, and tools like DALL-E 3 for image generation and Advanced Data Analysis for working with spreadsheets and datasets.

The free tier is generous enough for casual use but imposes rate limits that become noticeable quickly. ChatGPT is best suited to users who want one tool that handles everything adequately — rather than specialists who need one thing done exceptionally well.'
WHERE slug = 'chatgpt';

UPDATE tools SET description = 'GitHub Copilot is the AI pair programmer built into the development workflow of millions of engineers. Developed by GitHub in partnership with OpenAI, Copilot sits inside your code editor and suggests completions — single lines, entire functions, test cases, and documentation — as you type.

The core value of Copilot is speed without context switching. Instead of stopping to look up a syntax pattern, search Stack Overflow, or ask a separate AI chat window, Copilot surfaces suggestions inline, based on the file you are editing and the broader context of your project. Experienced engineers report that it meaningfully reduces the friction of writing boilerplate and repetitive code, freeing mental bandwidth for architectural decisions and problem-solving.

Copilot Chat, available inside VS Code and JetBrains IDEs, extends the experience beyond autocomplete. You can explain a function, generate unit tests for a specific code block, ask why a particular approach might fail, or get a plain-language summary of what a complex function does. Copilot Workspace takes this further by letting you describe a task in natural language and generating a full implementation plan with diffs across multiple files.

Beyond individual productivity, GitHub has positioned Copilot as an enterprise tool. Copilot Business and Copilot Enterprise offer policy controls, IP indemnification, and integration with an organisation-specific codebase so the model can reference internal APIs and conventions.

Copilot is best suited to working software engineers who spend meaningful time in an IDE. Students and junior developers benefit from the learning-by-example effect; senior engineers appreciate the acceleration on routine tasks. It is not a substitute for understanding what you are building — but as a productivity layer on top of genuine skill, it is one of the most impactful AI investments a developer can make.'
WHERE slug = 'github-copilot';

UPDATE tools SET description = 'Midjourney is the image generation model that set the aesthetic standard for AI art. While other generators produce competent results, Midjourney consistently produces images that feel composed, atmospheric, and intentional — closer to the output of a skilled photographer or concept artist than a pattern-matched interpolation of training data.

The model is accessed through a Discord bot, which remains the primary interface despite being unconventional by modern software standards. Users type a prompt, optionally specify an aspect ratio and style parameters, and receive four image options within roughly a minute. Variations and upscaling are handled with simple button clicks. A web interface is also available for subscribers who prefer working outside Discord.

Midjourney v6 introduced significant improvements to prompt adherence, text rendering within images, and photorealism. The model now handles complex scenes with multiple subjects more reliably, and its treatment of human faces has become convincingly accurate at standard resolutions. For commercial work requiring a realistic aesthetic — product visualisation, concept art, editorial illustration, architectural renders — v6 results are frequently production-ready with minimal post-processing.

The subscription tiers are structured around GPU time rather than image count, which can feel opaque but is ultimately fair for heavy users. The Basic plan at $10 per month provides around 200 image generations; Pro at $60 per month offers unlimited relaxed generations and access to stealth mode for keeping work private.

Midjourney is the right tool for creative professionals — designers, art directors, game developers, filmmakers, and marketers — who need high-quality imagery at speed and do not have the budget or time to commission original illustration for every project.'
WHERE slug = 'midjourney';

UPDATE tools SET description = 'Perplexity is an AI-powered search engine that answers questions with cited sources rather than a list of links. It combines the real-time retrieval of a search engine with the conversational interface of an AI assistant, producing answers that are both current and accountable.

The core experience is simple: you type a question in natural language, and Perplexity retrieves relevant web sources, synthesises them into a direct answer, and shows you exactly which sources were used. Every factual claim is numbered and linked, so you can verify the answer or explore the source material in seconds. This makes it significantly more trustworthy than a pure language model for time-sensitive or factual queries, where models without retrieval are prone to confident hallucination.

Perplexity handles follow-up questions naturally, maintaining the thread of a conversation so you can refine your research without starting over. It also supports file uploads — you can paste a document, PDF, or URL and ask questions about it — and it remembers your interests to personalise the depth and framing of answers over time.

Perplexity Pro unlocks access to more powerful models (including GPT-4o and Claude 3.5) for complex queries, and adds a higher limit on file uploads and advanced search modes. The free tier is generous for everyday research needs.

Perplexity is best suited to anyone who uses search as a research tool rather than a navigation tool — analysts, journalists, students, and curious professionals who regularly need accurate, verifiable answers to non-trivial questions. It replaces the workflow of opening ten browser tabs and manually synthesising what you find.'
WHERE slug = 'perplexity';

UPDATE tools SET description = 'Gemini is Google DeepMind''s flagship AI model, available directly through Google products and via the Gemini app. As Google''s most capable AI system, Gemini is deeply integrated into the tools billions of people already use — Gmail, Google Docs, Google Search, and the Google Workspace suite — making it the AI assistant with the lowest adoption barrier for anyone in the Google ecosystem.

The Gemini 1.5 Pro model offers a 1 million token context window, the largest available in a consumer product at launch. This means you can load an entire book, a feature-length film transcript, or an hour of meeting audio into a single conversation and ask questions across all of it. For knowledge workers managing large volumes of information, this capability is transformative.

Gemini is multimodal by design. It processes text, images, audio, video, and code within the same model architecture, rather than routing different input types through specialised systems. In practice this means you can share a photo of a whiteboard diagram and ask for a structured summary, or upload a short video clip and request a chapter breakdown — without switching tools or APIs.

In Google Workspace, Gemini appears as a sidebar assistant in Docs, Sheets, Gmail, and Slides. It can draft emails based on a brief prompt, summarise long email threads, generate formulas in Sheets, and create presentation outlines from rough notes. For organisations already paying for Google Workspace Business or Enterprise plans, Gemini is included — making it effectively free to deploy across a team.

Gemini Advanced, available via the Google One AI Premium subscription at $19.99 per month, provides access to the most capable Gemini Ultra model and priority access to new features.'
WHERE slug = 'gemini';

UPDATE tools SET description = 'Notion AI is the artificial intelligence layer built directly into Notion, the popular all-in-one workspace used by millions of teams for notes, wikis, project management, and documentation. Unlike standalone AI tools, Notion AI has full context of everything you have written in your workspace — your meeting notes, project briefs, product specs, and team documentation — and can work across all of it without copy-pasting into a separate window.

The most powerful use of Notion AI is autofill. You can create a property in a database — say, a "Status Summary" column — and have Notion AI automatically generate a one-sentence summary of each project based on the page content. Applied across a project tracker with dozens of active items, this feature alone can save hours of manual status reporting per week.

Notion AI also handles the full range of writing assistance you would expect: drafting new content from a prompt, rewriting existing text to be clearer or more concise, translating content into other languages, generating action items from meeting notes, and explaining complex content in simpler terms. The quality of the output is broadly good, though it uses OpenAI models under the hood and does not offer the same depth of reasoning as Claude or GPT-4o on complex analytical tasks.

For teams that live in Notion, the integration value is substantial. Your AI assistant knows the terminology in your product wiki, the format of your meeting notes, and the structure of your project pages — so its output fits your existing content rather than requiring heavy editing to match your style.

Notion AI is an add-on at $10 per member per month on top of the base Notion plan. It is most valuable for teams that use Notion as their primary documentation and knowledge management system.'
WHERE slug = 'notion-ai';

UPDATE tools SET description = 'Cursor is a code editor built from the ground up for AI-assisted development. While tools like GitHub Copilot add AI features to existing editors like VS Code, Cursor is a fork of VS Code where AI is the central design principle — every interaction, from file navigation to code review, is built around the assumption that you are working with an AI collaborator.

The flagship feature of Cursor is its Composer mode. Rather than accepting or rejecting individual line suggestions, Composer lets you describe a multi-step task in natural language — "add authentication to these routes and update the corresponding tests" — and Cursor applies coordinated edits across multiple files simultaneously. It understands your entire codebase context, not just the file you have open, so the changes it proposes are consistent with your existing patterns and naming conventions.

Cursor''s chat interface is deeply integrated into the editor. You can highlight a block of code, press a keyboard shortcut, and ask a question about it without leaving the file. The model can see your current file, your terminal output, recent errors, and the broader codebase structure — so answers are grounded in your actual code rather than generic patterns.

The editor supports all major programming languages and inherits VS Code''s extension ecosystem, meaning you can bring your existing plugins, themes, and keyboard shortcuts without reconfiguring your workflow. The transition from VS Code is designed to be frictionless.

Cursor Pro at $20 per month provides unlimited fast requests using Claude 3.5 Sonnet or GPT-4o and a generous allowance of slow requests. For professional developers who spend most of their day in an editor, it is one of the highest-leverage AI investments available — users consistently report 20 to 40 percent increases in output on coding tasks.'
WHERE slug = 'cursor';

UPDATE tools SET description = 'ElevenLabs is the leading AI voice synthesis platform, used by studios, publishers, game developers, and content creators to generate natural-sounding speech from text. Founded in 2022, it quickly established itself as the quality benchmark in the field — the model produces voices that are difficult to distinguish from professional human narration at normal listening speeds.

The platform offers two primary capabilities. Text-to-speech converts written content into audio using a library of pre-built voices, each with customisable parameters for stability, clarity, and style exaggeration. Voice cloning lets you upload a sample of your own voice — or a licensed voice you have rights to — and generate new audio in that voice. The cloning quality is genuinely remarkable: with a clean two-minute sample, the output captures accent, cadence, and tonal character with high accuracy.

ElevenLabs supports 29 languages for synthesis, making it a practical choice for localising audio content without recording separate sessions in each language. The model handles punctuation-driven pacing, emphasis, and emotional inflection reasonably well, though highly expressive or emotionally complex content still benefits from post-production editing.

The platform is used heavily for audiobook production, podcast narration, video voiceovers, e-learning content, and accessibility features in apps and games. Game studios use it to generate NPC dialogue at scale; publishers use it to produce audiobook editions without scheduling studio time; corporate teams use it for training videos and product demonstrations.

The free tier provides 10,000 characters per month — enough to evaluate quality and build integrations. Creator and Pro plans start at $5 and $22 per month respectively, offering higher character limits and access to the more advanced voice models.'
WHERE slug = 'elevenlabs';

UPDATE tools SET description = 'Runway is a creative AI platform built specifically for video generation, editing, and visual effects — positioned at the intersection of professional film production tools and generative AI. It is used by filmmakers, music video directors, advertising agencies, and content studios who need AI-generated video that meets professional quality standards rather than casual social media benchmarks.

The platform''s Gen-3 Alpha model is its most capable video generation system. Given a text prompt or an image as a reference frame, Gen-3 produces video clips of up to 10 seconds with coherent motion, consistent subject identity across frames, and cinematic-quality rendering. The results are not perfect — AI video still struggles with complex physical interactions and multi-subject scenes — but for establishing shots, product visualisations, abstract sequences, and stylised content, Gen-3 is production-ready.

Beyond generation, Runway offers a suite of video editing tools powered by AI. Background removal works on moving subjects in real time. Inpainting lets you mask and replace sections of a video frame by frame. Motion Brush allows you to draw regions of a frame and specify what kind of movement should be applied. These tools reduce work that previously required expensive VFX compositing software and skilled operators to something achievable by a single creative professional.

Runway is subscription-based. The Standard plan at $15 per month provides 625 credits, with additional credits available for purchase. Professional users on the Pro plan ($35 per month) get 2,250 credits and access to the highest-quality generation modes.

For creative professionals working in video — particularly those producing short-form content at speed or exploring experimental visual aesthetics — Runway represents the current state of the art in accessible AI video production.'
WHERE slug = 'runway';
