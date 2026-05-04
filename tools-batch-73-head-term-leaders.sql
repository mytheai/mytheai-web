-- Phase 5 (S87e): Add 10 missing head-term leaders.
-- These are tools with high consumer search demand that were absent from DB.
-- All verified operational + brand recognition + recent product activity per CLAUDE.md Quality Bar.

INSERT INTO tools (
  slug, name, tagline, description, logo_url, website_url, affiliate_url,
  pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count,
  featured, trending, editor_pick, tags, pros, cons, use_cases
) VALUES

-- 1. DeepSeek - Chinese open-weight LLM, viral 2025 with R1 reasoning model
('deepseek', 'DeepSeek', 'Open-weight reasoning LLM that matches frontier models at a fraction of the cost.',
'DeepSeek is the Chinese AI lab whose R1 model went viral in early 2025 by demonstrating reasoning capabilities competitive with GPT-4-class models while being open-weight and dramatically cheaper to run. The chat interface (chat.deepseek.com) gives free unlimited access to DeepSeek-V3 and R1, and the API costs roughly 1/30th of OpenAI for equivalent quality on math, coding, and structured reasoning tasks. For developers who need an OpenAI-compatible API at hobbyist budget, DeepSeek is the practical choice. The trade-off: it is a Chinese model, so political topics related to China are filtered, and enterprise teams in regulated industries may have data-residency concerns. For everyone else, it is the free reasoning model to try first in 2026.',
'', 'https://chat.deepseek.com', 'https://chat.deepseek.com',
'freemium', true, 0, 4.7, 0,
true, true, false,
ARRAY['ai-assistants','code-ai'],
ARRAY['Open-weight (downloadable models)','Reasoning quality competitive with frontier paid models','Free unlimited chat at chat.deepseek.com','API priced at fraction of OpenAI rates','Strong on math and code'],
ARRAY['Political content filtering for China-related topics','Chinese-jurisdiction data handling concerns for some enterprises','Smaller context window than Claude','English-language nuance occasionally weaker than GPT-4 family'],
ARRAY['Reasoning-heavy tasks at hobbyist budget','Self-hosting an open model','Coding assistant alternative to ChatGPT','Math problem solving','Cost-sensitive API workloads']),

-- 2. v0 by Vercel - UI generation from natural language, dominant for React/Tailwind
('v0', 'v0', 'Generate React + Tailwind UI from a text prompt. Vercel-built, ships to production.',
'v0 is Vercel''s text-to-UI tool that became the default way indie devs and product designers ship landing pages and prototypes in 2025-2026. You describe the screen ("dashboard with a sidebar, recent activity feed, and a chart") and v0 returns clean React + Tailwind code using shadcn/ui components by default. Each generation has variants you can iterate on, and one click pushes the project live to a Vercel preview URL. v0 is opinionated: it produces idiomatic Next.js + Tailwind code, not framework-agnostic markup. If your stack matches, it is the fastest path from idea to deployed UI. If you use Vue, Svelte, or non-Tailwind styling, v0 is the wrong tool. Free tier covers light usage; premium ($20/month) lifts the credit cap and unlocks GitHub sync.',
'', 'https://v0.dev', 'https://v0.dev',
'freemium', true, 20, 4.6, 0,
true, true, false,
ARRAY['code-ai','design'],
ARRAY['Best-in-class React + Tailwind output','Direct deploy to Vercel preview URL','Iterates with variants and chat-style refinement','Uses shadcn/ui components - production-ready code','Strong design taste out of the box'],
ARRAY['Locked to React + Tailwind + Next.js stack','Vue/Svelte/Angular users get nothing','Backend logic is minimal - frontend only','Premium needed beyond casual use','Code can require manual cleanup for complex apps'],
ARRAY['Landing pages and marketing site sections','Internal tool dashboards (React shops)','Rapid UI prototyping for stakeholder review','Component library exploration','Hackathon and side-project frontends']),

-- 3. Luma Dream Machine - text-to-video and image-to-video leader
('luma-dream-machine', 'Luma Dream Machine', 'Text-to-video and image-to-video generator with cinematic motion quality.',
'Luma Dream Machine is the video generation product from Luma Labs that became a Runway-class competitor in 2025. The strength is motion: camera moves (dolly, orbit, pan) and physical-world dynamics (cloth, water, particles) feel grounded compared to the over-stylized output of earlier video AI. You give it a prompt or a still image and get a 5-10 second clip in 720p or 1080p. Pricing is credit-based; the free tier covers a few clips per month, paid plans start at $9.99 for 30 generations. Vs Runway: Luma is faster and cheaper for short clips with simple motion; Runway Gen-3 is better for narrative scenes that need character consistency across multiple cuts. For one-shot social videos and image animations, Luma is now the default pick.',
'', 'https://lumalabs.ai/dream-machine', 'https://lumalabs.ai/dream-machine',
'freemium', true, 9.99, 4.5, 0,
true, true, false,
ARRAY['video-ai'],
ARRAY['Cinematic motion quality - camera moves feel grounded','Image-to-video produces convincing animation from a still','Faster generation than Runway Gen-3','Lower price point ($9.99 entry vs Runway $15)','Free tier for casual creators'],
ARRAY['No character consistency across multiple clips (Runway wins)','Output capped at 5-10 second clips','Generations sometimes ignore detailed prompts','Audio not included (silent video)','API access still gated for many teams'],
ARRAY['Animating still photos for social media','Short text-to-video clips for ads or shorts','Mood reels and B-roll for video editors','Concept visualization for storyboards','Image-to-motion on product photography']),

-- 4. Qwen - Alibaba's open-weight LLM family, top non-Western model
('qwen', 'Qwen', 'Alibaba''s open-weight LLM family - frontier-class quality, free to download and run.',
'Qwen (Tongyi Qianwen) is Alibaba''s LLM family that emerged in 2024-2025 as the most consistently-released open-weight competitor to Llama. Qwen3 frontier models match Claude 3.5 and GPT-4 on benchmarks, and the smaller Qwen3 variants (7B, 14B, 32B) run on consumer GPUs while still beating Llama 3 of similar size on multilingual and code tasks. The free chat interface (chat.qwen.ai) is direct from Alibaba; the models themselves are downloadable from Hugging Face under an Apache-2.0-style license for research and commercial use up to scale limits. For developers building self-hosted AI products in 2026, Qwen and DeepSeek are the two open-weight families worth evaluating first.',
'', 'https://chat.qwen.ai', 'https://chat.qwen.ai',
'freemium', true, 0, 4.5, 0,
false, true, false,
ARRAY['ai-assistants','code-ai'],
ARRAY['Frontier-class open-weight models (Qwen3)','Strong multilingual support including non-English Asian languages','Smaller variants run on consumer hardware','Free unlimited chat at chat.qwen.ai','Apache-2.0 commercial-use license at most scales'],
ARRAY['Chinese-jurisdiction model with content filters on sensitive topics','Documentation primarily in Chinese for advanced features','Tool-use and function-calling polish behind GPT-4','Smaller ecosystem than Llama for fine-tuning recipes'],
ARRAY['Self-hosted LLM deployment','Multilingual customer-facing apps','Code generation alternative to ChatGPT','Research benchmarking','Cost-sensitive AI products at scale']),

-- 5. Manus - viral autonomous agent platform 2025
('manus', 'Manus', 'Autonomous AI agent that browses, codes, and completes multi-step tasks unattended.',
'Manus is the autonomous agent platform from Butterfly Effect AI that went viral in March 2025 by demoing a single AI completing complex multi-hour tasks - building full apps, running market research, drafting investment memos - without human-in-the-loop guidance. Unlike Devin (code-only) or general assistants (single-turn), Manus is task-completion-first: you give it a goal, it spawns its own subtasks, browses the web, executes code, and reports back with a finished deliverable. The waitlist gating made it scarce in 2025; access is now broader in 2026 with paid tiers. Reality vs hype: Manus is genuinely useful for research and report-style tasks; weaker on tasks requiring real-time human judgment or proprietary tools. Treat it as a research analyst that runs while you sleep.',
'', 'https://manus.im', 'https://manus.im',
'paid', false, 19, 4.3, 0,
false, true, false,
ARRAY['ai-assistants','automation'],
ARRAY['Autonomous task completion - runs unattended for hours','Strong at research, market analysis, report generation','Browses real websites and synthesizes findings','Code execution sandbox for data analysis tasks','Natural language goal specification (no workflow modeling)'],
ARRAY['Expensive vs single-turn assistants - $19+/month entry','Hallucinates on tasks requiring real-time judgment','Cannot connect to your private SaaS tools by default','Slower than expected on simple tasks','Limited transparency into intermediate decisions'],
ARRAY['Market research and competitive analysis','Long-form report generation','Multi-source investment due diligence','Deep web research synthesis','Background tasks while you focus on other work']),

-- 6. Genspark - AI search engine with multi-source synthesis
('genspark', 'Genspark', 'AI search engine that synthesizes a custom answer page from multiple sources per query.',
'Genspark generates a custom "Sparkpage" for every query - a synthesized answer with cited sources, related media, and follow-up suggestions - rather than returning a links list. Vs Perplexity, the differentiator is multi-modal output (Genspark embeds video, images, and dynamic widgets in answers when relevant) and fewer obvious hallucinations on cited claims. The free tier covers a generous daily quota of standard searches; paid (about $20/month) unlocks deeper synthesis modes and faster generation. For users who want one tool to replace Google + Wikipedia + first-pass research, Genspark is a credible option that overtook some Perplexity use cases through 2025. Quality on follow-up Q&A is still slightly behind Perplexity Pro; cite-checking discipline is similar.',
'', 'https://www.genspark.ai', 'https://www.genspark.ai',
'freemium', true, 19.99, 4.4, 0,
false, true, false,
ARRAY['ai-assistants','research'],
ARRAY['Custom synthesized answer page with cited sources per query','Multi-modal results - embeds video and images contextually','Generous free tier vs Perplexity','Visualization widgets generated for data queries','Fewer hallucinations on cited factual claims'],
ARRAY['Slower per-query than Perplexity due to synthesis depth','Follow-up Q&A polish slightly behind Perplexity Pro','UI denser - more to scan per answer','Fewer integrations and APIs than Perplexity','Brand awareness still building outside power-user circles'],
ARRAY['Replacing Google search for in-depth research questions','Topic exploration with multi-modal context','Quick fact-checking with cited sources','Travel, product, and how-to research','First-pass discovery before deep dives']),

-- 7. LangFlow - visual builder for LangChain-style AI workflows
('langflow', 'LangFlow', 'Visual no-code builder for LangChain-style agent and RAG workflows.',
'LangFlow is the open-source visual builder for AI agent and RAG (retrieval-augmented generation) workflows that became the default starting point for non-engineers prototyping LangChain pipelines. You drag-and-drop nodes (LLM, prompt template, vector store, tool, memory) onto a canvas, wire them together, and the platform handles orchestration. Compare to alternatives: vs Flowise, LangFlow has tighter LangChain compatibility and a better component library; vs n8n, LangFlow is purpose-built for AI agents (n8n is general workflow automation). Free open-source self-hosted; managed cloud (DataStax-acquired) offers $20+ tiers with hosted vector DB. Best for teams who want LangChain''s ecosystem without writing the orchestration code by hand.',
'', 'https://www.langflow.org', 'https://www.langflow.org',
'freemium', true, 0, 4.4, 0,
false, true, false,
ARRAY['automation','code-ai'],
ARRAY['Open-source self-hostable - full control','Tight LangChain compatibility - export to Python easily','Strong component library covering LLMs, vector stores, tools','Fast prototype-to-deployment loop','DataStax acquisition brings managed cloud + Astra DB'],
ARRAY['Component library leans toward LangChain idioms (lock-in)','Cloud version pricing creeps up at scale','Visual canvas hits complexity wall at 30+ nodes','Documentation lag behind LangChain core releases'],
ARRAY['RAG application prototyping','AI agent workflow modeling','Internal tool prototypes mixing LLMs + APIs','Knowledge base chatbots','Hand-off from prototype to engineer-built production system']),

-- 8. CrewAI - multi-agent framework for role-based agents
('crewai', 'CrewAI', 'Multi-agent framework that lets you define a "crew" of role-specific AI agents that collaborate.',
'CrewAI is the Python framework for building multi-agent systems that became the default 2024-2026 alternative to LangGraph for role-based agent orchestration. You define each agent (researcher, writer, fact-checker, editor) with a role, goal, and tools, then assemble them into a "Crew" that coordinates on a task. The framework handles message passing, task delegation, and result aggregation. Vs AutoGen (Microsoft): CrewAI is more opinionated and easier to start; AutoGen is more flexible but has steeper setup. Vs LangGraph: CrewAI prioritizes role-based composition; LangGraph emphasizes state-machine control flow. Free open-source; CrewAI Enterprise offers managed deployment + monitoring at custom pricing. The right starting point for teams new to multi-agent.',
'', 'https://www.crewai.com', 'https://www.crewai.com',
'freemium', true, 0, 4.5, 0,
false, true, false,
ARRAY['automation','code-ai'],
ARRAY['Cleanest API for multi-agent role definition','Strong Python ecosystem integration','Active community and growing template library','Open-source MIT license','CrewAI Enterprise for monitored production deployment'],
ARRAY['Python-only - no JS/TS port yet','Debugging multi-agent loops can be opaque','Enterprise pricing not transparent','Less flexible than LangGraph for non-role-based topologies','Memory and state management still maturing'],
ARRAY['Multi-agent research workflows','Content production pipelines (research + write + edit)','Customer support agent teams','Code generation with code-review agent','Task automation requiring specialist roles']),

-- 9. Glif - viral generative platform with shareable AI mini-apps
('glif', 'Glif', 'Build, share, and run AI mini-apps - chain models like LEGO blocks.',
'Glif is the playful generative platform where users compose chains of LLMs, image models, and audio models into shareable "glifs" - small AI mini-apps that anyone can run from the URL. Glifs went viral in 2024-2025 as the de-facto way to share creative AI experiments (meme generators, image-to-character-design, voice-cloned Shakespeare sonnet writers, etc) without writing code. Free to use most public glifs; premium credits ($9.99+) unlock heavier models like Flux Pro and Runway. Vs Replicate: Glif is consumer-creative, Replicate is developer-API; vs Hugging Face Spaces: Glif chains multiple models, Spaces hosts single models. Best for creative tinkerers and people who want to try cutting-edge model combinations without setup.',
'', 'https://glif.app', 'https://glif.app',
'freemium', true, 9.99, 4.4, 0,
false, true, false,
ARRAY['image-ai','automation'],
ARRAY['Shareable AI mini-apps - link and run, no install','Chain multiple model types in one workflow','Active creative community sharing templates','Frontier image and video models accessible at low cost','Drag-drop visual builder - no code required'],
ARRAY['Public glifs visible to community by default (privacy implication)','Heavy use blows through free credits fast','Output deterministic across runs is hard to enforce','API for embedding glifs in your own product still maturing'],
ARRAY['Creative AI experimentation','Meme generators and viral templates','Image transformation pipelines','Mini-tool prototyping for non-developers','Sharing AI workflows with friends or community']),

-- 10. Aider - terminal-based AI pair programmer with git integration
('aider', 'Aider', 'AI pair programmer for the terminal - edits multiple files with full git workflow.',
'Aider is the open-source terminal-based AI coding assistant that became the second-most-downloaded coding tool on GitHub for developers who prefer terminal + editor over IDE-integrated tools like Cursor. You point Aider at your repo, name files for it to edit, and converse via chat - it makes edits, commits each change to git automatically with descriptive messages, and runs tests if you ask. Compatible with Claude, GPT-4, DeepSeek, and local Ollama models. Vs Cursor: Aider is faster for back-end work in vim/emacs/CLI shops, slower for visual front-end work where Cursor wins. Vs Continue (in-IDE): Aider has tighter git semantics and better multi-file edits. Free open-source, BYO API key.',
'', 'https://aider.chat', 'https://aider.chat',
'free', true, 0, 4.6, 0,
false, true, false,
ARRAY['code-ai'],
ARRAY['Native git workflow - every change becomes a clean commit','BYO API - works with Claude, GPT-4, DeepSeek, local Ollama','Strong multi-file refactoring','Fast in terminal-native dev workflows','Free open-source, MIT license'],
ARRAY['No GUI - learning curve for non-terminal devs','Visual front-end work weaker than Cursor or v0','API costs add up at heavy use (BYO model)','Less polished for non-Python/JS stacks','Plugin ecosystem smaller than Cursor extensions'],
ARRAY['Terminal-native development workflows','Multi-file refactoring with auto-commits','BYO model setups (Claude, DeepSeek, local Llama)','Backend, infrastructure, and CLI work','Cost-conscious developers preferring API metering'])

ON CONFLICT (slug) DO NOTHING;

-- Set tier-1 leaders trending + featured (alongside Phase 1 reset values)
UPDATE tools SET trending = true, featured = true
WHERE slug IN ('deepseek','v0','luma-dream-machine');

UPDATE tools SET trending = true
WHERE slug IN ('qwen','manus','genspark','crewai','aider','langflow','glif');
