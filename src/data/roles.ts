// Role-first hub data. Each role has rich editorial content beyond the underlying top10 list.
// Used by /roles hub and /roles/[slug] detail pages.

export interface RoleFAQ {
  q: string
  a: string
}

export interface RoleWorkflowStep {
  title: string
  body: string
}

export interface RoleBudgetTier {
  label: string
  monthly: string
  notes: string
}

export interface Role {
  slug: string
  emoji: string
  title: string
  desc: string
  intro: string
  longIntro: string
  topListSlug: string
  primaryToolSlugs: string[]
  workflow: RoleWorkflowStep[]
  budget: RoleBudgetTier[]
  faqs: RoleFAQ[]
  relatedUseCaseLists: { slug: string; label: string }[]
}

export const ROLES: Role[] = [
  {
    slug: 'developer',
    emoji: '💻',
    title: 'Developer',
    desc: 'Coding copilots, AI agents, code review',
    intro: 'AI tools that help engineers ship faster: in-IDE pair programming, autonomous agents, and code review automation.',
    longIntro: 'Engineers in 2026 ship code measurably faster with AI assistance, but the tooling layer changes every quarter. The picks below favor production reliability over flashy demos: tools you can adopt this week and trust on a real codebase. Most developers run a Cursor- or Windsurf-class IDE plus a terminal CLI like Aider or Claude Code, and add a UI generator like v0 for frontend work.',
    topListSlug: 'best-code-ai-tools',
    primaryToolSlugs: ['cursor', 'windsurf', 'v0', 'aider', 'bolt', 'replit'],
    workflow: [
      { title: 'Pick your IDE base', body: 'Start with Cursor or Windsurf as your daily IDE. Both fork VS Code, both ship Claude Sonnet by default. Cursor wins on plugin compatibility, Windsurf wins on autonomous agent (Cascade) and free tier.' },
      { title: 'Add a terminal pair programmer', body: 'For backend, infra, and refactor work, layer Aider in your terminal. Aider commits each AI change with a clean git message - the most disciplined git workflow in the category. BYO API key (DeepSeek API costs cents per session).' },
      { title: 'Use a UI specialist for frontend bursts', body: 'When you need a landing page or marketing section in five minutes, v0 produces production React + Tailwind code with shadcn/ui. Paste output into your repo, integrate with Cursor.' },
      { title: 'Treat agents as research, not engineers', body: 'Manus, CrewAI, and LangFlow can run unattended research and prototyping tasks. They are not yet reliable enough to merge to main without human review - use them to draft, not to ship.' },
    ],
    budget: [
      { label: 'Free tier (learning, side projects)', monthly: '$0', notes: 'Aider + DeepSeek API ($1-3/month at hobby use), Cursor free tier (50 fast completions), v0 free tier' },
      { label: 'Solo professional', monthly: '$20-25', notes: 'Cursor Pro $20/mo OR Windsurf Pro $15/mo. Add v0 free or $20/mo for steady UI work.' },
      { label: 'Team of 5-20', monthly: '$100-300', notes: 'Cursor Business $40/seat/mo or Windsurf Teams. Add Linear or GitHub Projects for issue tracking; agents stay individual-tier.' },
    ],
    faqs: [
      { q: 'Cursor or Windsurf - which should I start with in 2026?', a: 'Cursor for largest community + plugin compatibility. Windsurf for the most autonomous agent (Cascade) and a more generous free tier. If you have not picked yet, start with Cursor - migrating to Windsurf later takes one afternoon.' },
      { q: 'Is GitHub Copilot still relevant?', a: 'Yes for enterprise teams already standardized on GitHub Enterprise + Copilot Business. For individuals and small teams in 2026, Cursor and Windsurf produce visibly better suggestions because they default to Claude Sonnet, while Copilot defaults to a smaller in-house model. Copilot remains the safer pick where compliance and central admin matter.' },
      { q: 'Do I need a separate AI agent tool like Manus or CrewAI?', a: 'Not for daily coding. Agents shine for research, multi-source analysis, and autonomous prototyping - tasks that run while you work on something else. They are not yet a replacement for a human-in-the-loop coding workflow.' },
      { q: 'Which model is best for code in 2026?', a: 'Claude Sonnet for instruction-following and long-context refactors. DeepSeek-R1 for math-heavy and algorithmic work at low API cost. GPT-5 for broad library knowledge. Most IDEs let you switch per task.' },
      { q: 'Are local models (Ollama, LM Studio) viable for daily dev work?', a: 'For autocomplete on small codebases, yes. For agent-style multi-file refactoring, frontier hosted models are still meaningfully better. The gap is closing - revisit every 6 months.' },
    ],
    relatedUseCaseLists: [
      { slug: 'best-code-ai-tools', label: 'Best AI Coding Tools' },
      { slug: 'best-ai-app-builders', label: 'Best AI App Builders' },
      { slug: 'best-ai-agent-tools', label: 'Best AI Agent Tools' },
    ],
  },
  {
    slug: 'marketer',
    emoji: '📣',
    title: 'Marketer',
    desc: 'Content, campaigns, SEO, ads',
    intro: 'Tools for content production, SEO research, social campaigns, and email automation. Built for performance teams.',
    longIntro: 'Marketing teams in 2026 use AI across the full funnel: content production, SEO research, ad creative, social scheduling, and email personalization. The picks below are battle-tested across mid-market and SMB stacks. Most marketers anchor on Jasper or Copy.ai for content, Surfer SEO for ranking, ChatGPT or Claude for ad copy, and a workflow tool like Zapier or n8n to glue them together.',
    topListSlug: 'best-ai-tools-for-marketers',
    primaryToolSlugs: ['jasper', 'surfer-seo', 'copy-ai', 'beehiiv', 'lavender', 'n8n'],
    workflow: [
      { title: 'Pick a content writer', body: 'Jasper for marketing teams of 3+ with a defined brand voice (tone training is best in category). Copy.ai for solo marketers who want broader workflow features (sales-enablement, outbound). Both pair with a copy editor like Grammarly.' },
      { title: 'Anchor SEO on Surfer or Clearscope', body: 'Surfer SEO is the indie/SMB choice (gentler pricing, better content scoring UX). Clearscope is the agency standard. Either pairs with Ahrefs or Semrush for keyword research.' },
      { title: 'Add an email platform', body: 'Beehiiv for newsletters and creator-led brands. Klaviyo for ecommerce email + SMS. Mailchimp for SMBs prioritizing built-in CRM. Lavender for outbound prospecting email.' },
      { title: 'Wire it together', body: 'n8n (open-source) or Zapier (most integrations) handles the connecting tissue: trigger Jasper drafts from Notion briefs, push posts to Buffer, sync leads from forms to your CRM.' },
    ],
    budget: [
      { label: 'Solo creator / freelancer', monthly: '$50-100', notes: 'Jasper Creator ($39/mo) + Surfer Essential ($79/mo) + Beehiiv free or $39/mo for paid newsletter' },
      { label: 'In-house team of 3-10', monthly: '$300-700', notes: 'Jasper Teams + Surfer Advanced + Klaviyo + Zapier Professional + ad-creative tools (Adobe Firefly, Midjourney)' },
      { label: 'Agency (multi-client)', monthly: '$1500+', notes: 'Add Clearscope (agency standard), Ahrefs Standard ($129/mo), Semrush Pro, multi-seat Klaviyo, Lavender for outbound team' },
    ],
    faqs: [
      { q: 'Jasper or Copy.ai for content?', a: 'Jasper for teams who care about consistent brand voice and produce 50+ pieces/month. Copy.ai for solo marketers and GTM teams who need writing plus outbound workflow automation. Quality on raw long-form is similar; team features differ.' },
      { q: 'Do I need both Surfer and Ahrefs?', a: 'Yes if you do SEO seriously. Surfer optimizes individual content pieces; Ahrefs tells you what to write about. Ahrefs is the strategy layer, Surfer is the production layer. They do not overlap.' },
      { q: 'Which AI image tool for ad creative?', a: 'Midjourney for hero visuals and brand-quality imagery. Adobe Firefly for commercially safe assets and tight Photoshop integration. Ideogram for typography-heavy ads. Most teams use Midjourney + Firefly together.' },
      { q: 'Is ChatGPT enough or do I need a marketing-specific tool?', a: 'ChatGPT is great for ad-hoc writing tasks (subject lines, ad copy variations, brainstorming). Marketing-specific tools win when you need brand voice training, SEO scoring, multi-piece campaign workflow, or team review. Most pros use both.' },
      { q: 'Beehiiv vs Mailchimp for newsletters?', a: 'Beehiiv for creator-led brands prioritizing growth, monetization (ads, paid newsletters), and modern UX. Mailchimp for SMBs who need a built-in CRM and broader marketing automation. Klaviyo dominates ecommerce.' },
    ],
    relatedUseCaseLists: [
      { slug: 'best-ai-seo-tools', label: 'Best AI SEO Tools' },
      { slug: 'best-ai-writing-tools', label: 'Best AI Writing Tools' },
      { slug: 'best-ai-email-marketing-tools', label: 'Best AI Email Marketing Tools' },
      { slug: 'best-ai-social-media-tools', label: 'Best AI Social Media Tools' },
    ],
  },
  {
    slug: 'creator',
    emoji: '✍️',
    title: 'Content Creator',
    desc: 'Video, audio, writing, thumbnails',
    intro: 'Tools for creators who ship to YouTube, TikTok, podcasts, and newsletters. Video editing, voice cloning, thumbnail generators.',
    longIntro: 'Content creators in 2026 lean on AI across video editing, audio post, thumbnails, and short-form ideation. The picks below assume a solo creator or small studio shipping 1-3 pieces per week. Most creators anchor on Descript for podcast/video editing, ElevenLabs for voice, Midjourney or Recraft for thumbnails, and a writing tool like Jasper or ChatGPT for scripts and titles.',
    topListSlug: 'best-ai-tools-for-content-creators',
    primaryToolSlugs: ['descript', 'elevenlabs', 'runway', 'midjourney', 'suno', 'jasper'],
    workflow: [
      { title: 'Pick your video/audio editor', body: 'Descript is the default for podcasters and YouTubers because of transcript-based editing (you edit the text, the audio/video updates). For more advanced motion graphics, layer in Runway or CapCut.' },
      { title: 'Add voice and music AI', body: 'ElevenLabs for voiceover, voice cloning, and dubbing. Suno for original music tracks (royalty-free, owned). Both produce broadcast-ready output in seconds.' },
      { title: 'Generate thumbnails and key art', body: 'Midjourney for stylized thumbnails, hero visuals, and brand-quality imagery. Recraft for icon-and-illustration work. Adobe Firefly when you need commercial-safety guarantees.' },
      { title: 'Write scripts and titles with AI', body: 'Jasper or Copy.ai for long-form scripts. ChatGPT for title brainstorming, hook ideation, and rapid iteration. Pair with Descript transcripts to repurpose video into newsletter or LinkedIn post.' },
    ],
    budget: [
      { label: 'Hobbyist (free tier mostly)', monthly: '$0-30', notes: 'Descript free + ElevenLabs free (10K chars/mo) + Midjourney trial + ChatGPT free' },
      { label: 'Solo creator producing weekly', monthly: '$60-120', notes: 'Descript Creator ($16/mo) + ElevenLabs Creator ($22/mo) + Midjourney Standard ($30/mo) + Suno ($10/mo)' },
      { label: 'Multi-channel creator / studio', monthly: '$200-400', notes: 'Add Runway Standard ($35/mo) for video gen, Adobe Firefly for safe commercial imagery, Jasper for content workflow' },
    ],
    faqs: [
      { q: 'Descript or CapCut for video editing?', a: 'Descript for transcript-based editing (podcast + dialogue-heavy YouTube). CapCut for short-form vertical video (TikTok, Reels, Shorts) where motion graphics and effects matter more than dialogue editing.' },
      { q: 'Can I clone my own voice with ElevenLabs?', a: 'Yes - the Voice Cloning feature in ElevenLabs Pro and above lets you train on a 60-second sample. Quality is broadcast-ready for narration. Multilingual cloning (your voice in 32 languages) is the fastest-growing use case.' },
      { q: 'Is Suno music actually safe to use commercially?', a: 'Yes for Suno Pro and above - the license includes commercial use including monetized YouTube, podcasts, and ads. Free tier output is non-commercial only. Read the license carefully if your platform has strict music compliance.' },
      { q: 'Midjourney vs DALL-E vs Flux for thumbnails?', a: 'Midjourney for stylized hero imagery (still the gold standard). Flux for fast iteration and prompt-following accuracy. DALL-E in ChatGPT Plus for casual ad-hoc generation. Most creators use Midjourney as primary.' },
      { q: 'How do I avoid the "AI-generated" look in thumbnails?', a: 'Three patterns: (1) use Midjourney "--style raw" for less stylized output, (2) generate a base then edit in Photoshop, (3) use Recraft or Adobe Firefly which lean less aesthetic by default. Or shoot real photos and use AI for backgrounds only.' },
    ],
    relatedUseCaseLists: [
      { slug: 'best-ai-video-tools', label: 'Best AI Video Tools' },
      { slug: 'best-ai-voice-tools', label: 'Best AI Voice Tools' },
      { slug: 'best-ai-image-generators', label: 'Best AI Image Generators' },
      { slug: 'best-ai-music-tools', label: 'Best AI Music Tools' },
    ],
  },
  {
    slug: 'designer',
    emoji: '🎨',
    title: 'Designer',
    desc: 'UI, branding, image generation',
    intro: 'AI tools for product designers and visual creators: image generation, Figma plugins, brand systems, AI mockups.',
    longIntro: 'Designers in 2026 work alongside AI rather than being replaced by it. The picks below favor workflow integration over standalone wow-factor: tools that fit into a Figma + Photoshop + Midjourney stack. Most product designers use Figma plugins for AI-assisted layout, Midjourney or Recraft for image generation, and a UI generator like v0 for code handoff.',
    topListSlug: 'best-ai-design-tools',
    primaryToolSlugs: ['midjourney', 'recraft-ai', 'v0', 'adobe-firefly', 'leonardo-ai', 'krea-ai'],
    workflow: [
      { title: 'Image generation as moodboarding', body: 'Midjourney for mood and direction exploration. Generate 30 references in an hour to align stakeholders before opening Figma. Adobe Firefly for commercial-safety when client work requires guaranteed licensing.' },
      { title: 'Component-level UI generation', body: 'v0 generates production React + Tailwind components from prompts. Use it to scaffold pages then design-pass in Figma. The AI is faster than starting from blank; humans still own the visual system.' },
      { title: 'Image editing and variation', body: 'Recraft for icons, illustrations, and brand-consistent visual systems. Krea for real-time generation that follows live sketches. Adobe Firefly inside Photoshop for inpainting and edit workflows.' },
      { title: 'Design handoff and code', body: 'When designs need to ship as code, use v0 (React + Tailwind), Figma Make, or Cursor with reference screenshots. Component libraries like shadcn/ui shorten the gap between mockup and shipped UI dramatically.' },
    ],
    budget: [
      { label: 'Student / hobbyist', monthly: '$10-30', notes: 'Midjourney Basic ($10/mo) + Adobe Firefly free + Krea free + v0 free' },
      { label: 'Freelance / solo designer', monthly: '$70-150', notes: 'Midjourney Standard ($30/mo) + Adobe Creative Cloud + Recraft Pro + Figma Pro' },
      { label: 'In-house team', monthly: '$300+', notes: 'Add Figma Org ($75/seat), v0 Pro for design-to-code, multi-seat Adobe CC, agency-tier Midjourney' },
    ],
    faqs: [
      { q: 'Will AI replace designers?', a: 'Not in 2026 - it raises the floor for non-designers and the ceiling for designers. Pros who integrate AI ship 2-3x faster on early-stage work; the differentiation moves up to taste, brand systems, and complex interaction design where AI still struggles.' },
      { q: 'Midjourney or Recraft for icon design?', a: 'Recraft is purpose-built for icon and illustration work - vectorizable output, brand-consistent style across many icons. Midjourney is better for stylized hero images and individual showcase visuals. Use Recraft if you need 50 consistent icons.' },
      { q: 'Can v0 replace Figma?', a: 'No. v0 generates React code from prompts; Figma is where design systems, components, and stakeholder reviews live. v0 is a tool that produces shippable UI quickly; Figma is the canvas where designers think.' },
      { q: 'Is Adobe Firefly worth it over Midjourney?', a: 'Yes if commercial safety matters - Firefly is trained on licensed/owned imagery only and Adobe indemnifies enterprise customers against IP claims. For mood boards and personal work, Midjourney quality wins. For client deliverables, Firefly is the safer pick.' },
      { q: 'Which tool for AI mockups (real product screens)?', a: 'v0 for code-ready React UI. Figma Make for in-Figma generation. Galileo for full-screen mockups. Most teams use v0 for marketing-site UI and Figma Make for app screens.' },
    ],
    relatedUseCaseLists: [
      { slug: 'best-ai-design-tools', label: 'Best AI Design Tools' },
      { slug: 'best-ai-image-generators', label: 'Best AI Image Generators' },
      { slug: 'best-figma-ai-plugins', label: 'Best Figma AI Plugins' },
    ],
  },
  {
    slug: 'founder',
    emoji: '🚀',
    title: 'Founder',
    desc: 'Build, ship, grow faster',
    intro: 'The AI stack for early-stage founders: no-code builders, customer research, growth automation, lean ops.',
    longIntro: 'Early-stage founders in 2026 use AI to compress their team. A solo founder with the right stack ships what a team of three did in 2022. The picks below favor tools with strong free tiers, fast time-to-value, and broad utility - not specialized enterprise software. Most founders anchor on a coding tool (Cursor or Bolt), a writing tool (ChatGPT or Claude), and a workflow automation tool (n8n or Zapier).',
    topListSlug: 'best-ai-tools-for-startups',
    primaryToolSlugs: ['cursor', 'bolt', 'claude', 'chatgpt', 'n8n', 'notion-ai'],
    workflow: [
      { title: 'Build the product', body: 'Cursor for full-stack code with editor-native AI. Bolt or v0 for non-technical founders shipping landing pages and prototypes without writing code. Replit for browser-based building.' },
      { title: 'Talk to customers', body: 'ChatGPT or Claude for synthesizing customer interviews. Manus or Perplexity for competitive research. Tally + Notion for surveys and notes - cheap, fast, integrate with everything.' },
      { title: 'Run growth experiments', body: 'Beehiiv for newsletter audience-building. Lavender for cold outbound. Posthog (free for early-stage) for product analytics. Surfer SEO once you start ranking.' },
      { title: 'Automate the back office', body: 'n8n (free, self-hosted) or Zapier handles the connecting tissue. Notion AI for company wiki. Mercury or Brex for finance ops. Pilot or Bench for outsourced bookkeeping when revenue justifies.' },
    ],
    budget: [
      { label: 'Pre-revenue', monthly: '$0-50', notes: 'Cursor free + Claude free + ChatGPT free + n8n self-hosted + Notion free + Beehiiv free' },
      { label: 'Post-revenue (under $10K MRR)', monthly: '$100-300', notes: 'Cursor Pro + ChatGPT Plus + Claude Pro + Notion AI + Zapier Pro + Beehiiv Grow + Lavender' },
      { label: 'Series A team (10-20)', monthly: '$1500+', notes: 'Add team seats, Linear, Mercury Raise, agency-tier marketing tools, dedicated CRM (HubSpot or Folk)' },
    ],
    faqs: [
      { q: 'Should I use Cursor or Bolt as a non-technical founder?', a: 'Bolt for true zero-code builders - you describe an app, Bolt builds it. Cursor for founders willing to learn just enough code to read what AI generates and review. Bolt is faster to ship; Cursor produces code you can hand to an engineer later.' },
      { q: 'Claude or ChatGPT for founder work?', a: 'Both, used for different tasks. Claude for long-context document work (board decks, term sheets, customer interview synthesis). ChatGPT for ad-hoc tasks, custom GPTs, and the agent ecosystem. Most founders subscribe to both at $20/mo each.' },
      { q: 'When is a CRM worth it?', a: 'Once you have 50+ active prospects or close 5+ deals/month manually. Folk for relationship-led sales, HubSpot for funnel-driven sales. Notion or a spreadsheet works fine before that.' },
      { q: 'Is n8n really better than Zapier?', a: 'For technical founders, yes - n8n is open-source, self-hostable, no per-task billing, and the visual builder is more powerful. For non-technical founders, Zapier wins because the integration library is bigger and the onboarding is gentler.' },
      { q: 'How do I budget AI tools as a pre-revenue founder?', a: 'Free tiers genuinely cover most early-stage needs. Stack: Cursor free + Claude/ChatGPT free + n8n self-hosted + Notion free + Beehiiv free. Pay only when revenue justifies. Most founders over-spend on tools in pre-revenue.' },
    ],
    relatedUseCaseLists: [
      { slug: 'best-ai-app-builders', label: 'Best AI App Builders' },
      { slug: 'best-no-code-ai-tools', label: 'Best No-Code AI Tools' },
      { slug: 'best-ai-tools-for-small-businesses', label: 'Best AI for Small Businesses' },
    ],
  },
  {
    slug: 'student',
    emoji: '🎓',
    title: 'Student',
    desc: 'Research, study, writing',
    intro: 'Free and freemium AI tools for students: study assistants, research summarizers, math solvers, citation helpers.',
    longIntro: 'Students in 2026 use AI as a study partner, not a homework shortcut. The picks below favor tools with strong free tiers and educational discounts. Most students anchor on ChatGPT (free) for general help, NotebookLM for research synthesis, and a writing assistant like Grammarly for editing. Math and science students add Photomath and Wolfram-style solvers.',
    topListSlug: 'best-ai-tools-for-students',
    primaryToolSlugs: ['chatgpt', 'notebooklm', 'perplexity', 'photomath', 'grammarly', 'genspark'],
    workflow: [
      { title: 'Research and synthesis', body: 'NotebookLM (free) for summarizing 10-20 source PDFs into structured study notes. Perplexity or Genspark for cited answers when you need to verify a fact. ChatGPT for explanation when you do not understand a concept.' },
      { title: 'Writing essays and reports', body: 'Claude or ChatGPT for first drafts and outlines. Grammarly for editing pass. Quillbot for paraphrasing. Be careful: most universities have AI policies - read yours before using AI on graded work.' },
      { title: 'Math and science', body: 'Photomath for step-by-step math solutions (snap a problem). Wolfram Alpha for advanced math, science, and data. ChatGPT for code (Python, R) and stats explanations.' },
      { title: 'Note-taking and study', body: 'Notion AI for class notes and project tracking. Anki for spaced repetition. Otter for lecture transcription if recording is allowed. Most under-rated tool: PDF-to-podcast in NotebookLM for audio review.' },
    ],
    budget: [
      { label: 'Free tier (most students)', monthly: '$0', notes: 'ChatGPT free + Claude free + NotebookLM free + Perplexity free + Photomath free + Grammarly free' },
      { label: 'Power user', monthly: '$10-25', notes: 'Notion AI ($10/mo with student discount) + ChatGPT Plus ($20/mo) for fewer rate limits' },
      { label: 'Grad student / researcher', monthly: '$30-60', notes: 'Add Claude Pro ($20/mo) for long-context paper analysis, Perplexity Pro ($20/mo) for unlimited research, optional Grammarly Premium' },
    ],
    faqs: [
      { q: 'Is using ChatGPT for homework cheating?', a: 'Depends on your university policy. Most allow AI for brainstorming, research, and editing - many forbid AI-generated final text submitted as your own. Read your specific course and program policies. When in doubt, ask the instructor.' },
      { q: 'Best free AI tool for studying?', a: 'NotebookLM. Upload up to 50 source PDFs (textbook chapters, lecture notes, research papers), it synthesizes them into structured Q&A and audio overviews. Genuinely useful for exam prep on dense material.' },
      { q: 'Photomath - does it actually teach math or just give answers?', a: 'It shows step-by-step solutions which is genuinely educational if you read each step. Used as a "answer machine" it short-circuits learning. Treat it like a tutor: do the problem, then check.' },
      { q: 'Can I detect AI-written text and is it worth worrying about?', a: 'Most "AI detectors" produce high false-positive rates and are unreliable. Your professor likely cannot prove text is AI-written, but they often can tell when writing does not match your usual style. The risk is reputational, not technical.' },
      { q: 'Should I pay for ChatGPT Plus as a student?', a: 'Only if free-tier rate limits actually slow you down (heavy daily user). For most students, free ChatGPT plus free Claude alternates handles 95% of need. Spend money on Notion AI, Anki upgrades, or coffee instead.' },
    ],
    relatedUseCaseLists: [
      { slug: 'best-ai-research-tools', label: 'Best AI Research Tools' },
      { slug: 'best-ai-writing-tools', label: 'Best AI Writing Tools' },
      { slug: 'best-free-ai-tools', label: 'Best Free AI Tools' },
    ],
  },
  {
    slug: 'sales',
    emoji: '💼',
    title: 'Sales',
    desc: 'Outreach, CRM, deal intelligence',
    intro: 'AI for revenue teams: prospecting automation, conversation intelligence, deal scoring, CRM enrichment.',
    longIntro: 'Sales teams in 2026 use AI to compress the BDR-to-AE-to-CSM pipeline. The picks below favor tools with measurable revenue impact: prospecting time saved, demo-to-close lift, deal coaching. Most reps anchor on Lavender for outbound email, Apollo for prospecting data, Gong or Clari for call intelligence, and a CRM (Salesforce, HubSpot, or Folk).',
    topListSlug: 'best-ai-sales-tools',
    primaryToolSlugs: ['salesforce-einstein', 'hubspot', 'apollo', 'gong', 'clari', 'lavender'],
    workflow: [
      { title: 'Prospect with intent data', body: 'Apollo for B2B contact data and intent signals. Smartlead or Amplemarket for outbound sequence orchestration. Avoid spray-and-pray - tier prospects by fit + intent and personalize the top 20%.' },
      { title: 'Personalize at scale', body: 'Lavender writes and scores cold emails per prospect using LinkedIn + company data. Best ROI tool for outbound BDRs in 2026 - $29/mo and adds 10-20% reply lift consistently.' },
      { title: 'Run smarter calls', body: 'Gong for enterprise teams (call recording, deal coaching, deal intelligence). Chorus for ZoomInfo-stack teams. Clari for forecasting and pipeline visibility. Reps who review their own calls weekly close at higher rates.' },
      { title: 'Close with CRM hygiene', body: 'Salesforce Einstein for enterprise ($150+/seat). HubSpot for growing teams ($45-180/seat). Folk for relationship-led sales (founder-led, agency, consultancy). Pick CRM by team size + sales motion.' },
    ],
    budget: [
      { label: 'Solo founder selling', monthly: '$0-100', notes: 'Folk free or HubSpot free + Apollo free + Lavender Starter free + manual outbound' },
      { label: 'BDR / AE individual contributor', monthly: '$100-300', notes: 'Apollo Basic + Lavender Pro + ChatGPT for research + access to team CRM (paid by employer)' },
      { label: 'Team of 5-50 reps', monthly: '$500-2000/seat/year fully loaded', notes: 'Salesforce or HubSpot Pro + Gong + Apollo Team + outbound platform + Outreach.io for sequencing' },
    ],
    faqs: [
      { q: 'Salesforce Einstein vs HubSpot AI?', a: 'Salesforce Einstein for enterprise teams already on Salesforce - the AI is layered on top of mature workflow infrastructure. HubSpot AI for growing teams who value ease-of-use and faster setup. HubSpot wins on UX, Salesforce on customization depth.' },
      { q: 'Is Lavender actually worth $29/mo?', a: 'Yes for active outbound BDRs. The score-as-you-write feedback loop teaches better cold email writing within weeks, and reply-rate lift is measurable. Skip it for AEs who do little prospecting.' },
      { q: 'Apollo vs ZoomInfo for prospecting?', a: 'Apollo for SMB and mid-market budgets - cheaper, modern UI, growing data quality. ZoomInfo for enterprise data depth at premium price. Apollo + LinkedIn Sales Navigator covers most teams up to ~$50M ARR.' },
      { q: 'Gong vs Chorus vs Clari?', a: 'Gong is the standalone leader. Chorus is now part of ZoomInfo - good if you want a bundled stack. Clari emphasizes forecasting more than call coaching. Most sales orgs evaluate Gong first.' },
      { q: 'How do I avoid burning my domain with cold email?', a: 'Use a separate outbound domain (e.g., trythismytheai.com instead of mytheai.com). Warm it for 4 weeks before mass send. Keep volume under 50 per inbox per day. Tools like Smartlead and Instantly handle warm-up automation.' },
    ],
    relatedUseCaseLists: [
      { slug: 'best-ai-crm-tools', label: 'Best AI CRM Tools' },
      { slug: 'best-ai-sales-tools', label: 'Best AI Sales Tools' },
      { slug: 'best-sales-call-intelligence-tools', label: 'Best Sales Call Intelligence' },
    ],
  },
  {
    slug: 'support',
    emoji: '🎧',
    title: 'Customer Support',
    desc: 'Tickets, chat, knowledge bases',
    intro: 'AI agents and copilots that deflect tickets, summarize conversations, and surface knowledge for support teams.',
    longIntro: 'Support teams in 2026 use AI primarily for ticket deflection (autonomous AI agents) and agent assist (sit-alongside copilots). The picks below favor tools that integrate with major helpdesk platforms (Zendesk, Intercom, Front, Salesforce Service Cloud). Most teams anchor on an AI agent (Intercom Fin, Ada, Decagon) plus a knowledge base + a CSAT measurement layer.',
    topListSlug: 'best-ai-customer-service-tools',
    primaryToolSlugs: ['intercom-fin', 'ada-ai', 'decagon-ai', 'moveworks', 'yellow-ai'],
    workflow: [
      { title: 'Pick an AI agent platform', body: 'Intercom Fin for teams already on Intercom (cleanest integration). Ada for cross-platform deployments and Salesforce shops. Decagon for AI-first companies who want depth over integration breadth. Moveworks for IT helpdesk specifically.' },
      { title: 'Train on your knowledge base', body: 'AI agents are only as good as the docs they read. Audit your help center quarterly: deduplicate, mark outdated, track which articles answer most tickets. Glean and Notion AI help for internal-team knowledge.' },
      { title: 'Layer agent assist for human reps', body: 'Tools like Yellow.ai and Intercom Fin AI Copilot suggest replies in the agent inbox. The lift on average handle time is real (15-25%); the catch is escalation logic must be tuned to avoid AI dead-ends.' },
      { title: 'Measure deflection + CSAT', body: 'Track resolution-by-AI rate, escalation rate, and CSAT delta on AI-resolved tickets vs human-resolved. The KPI that matters: AI-resolved CSAT must stay within 5% of human-resolved or you are damaging brand on cost savings.' },
    ],
    budget: [
      { label: 'Small team (<5 agents)', monthly: '$300-800', notes: 'Intercom Fin Lite or Ada Starter + helpdesk seats. AI agents typically priced per resolution ($0.99-$2 each).' },
      { label: 'Mid-market team (10-50 agents)', monthly: '$3,000-15,000', notes: 'Full Intercom Fin Pro + Glean for internal knowledge + agent assist tooling. Per-resolution pricing scales with volume.' },
      { label: 'Enterprise', monthly: 'Custom $50K+/yr', notes: 'Salesforce Service Cloud Einstein + Ada or Moveworks + Gong for QA + custom integrations' },
    ],
    faqs: [
      { q: 'Intercom Fin vs Ada vs Decagon?', a: 'Intercom Fin for cleanest deployment if you are already on Intercom - drops in with minimal config. Ada for multi-channel (web, voice, SMS, WhatsApp) and Salesforce shops. Decagon for teams who want the most-capable AI with willingness to do more setup.' },
      { q: 'How much can AI actually deflect?', a: 'Realistic: 30-60% of inbound tickets for transactional support (account, billing, FAQ). Lower for complex technical or relationship-led support. Vendor claims of 80%+ are usually narrow-scoped pilots, not steady state.' },
      { q: 'Will AI replace support reps?', a: 'It replaces tier-1 mostly - the simple, repeatable, transactional tickets. Tier-2 and tier-3 (complex troubleshooting, retention conversations, account management) still need humans and grow as a share of total ticket volume after AI deflection.' },
      { q: 'Per-resolution vs flat-fee pricing - which is better?', a: 'Per-resolution aligns vendor incentives with your savings (they win when you win). Flat-fee is predictable for budget. For most teams, per-resolution at $0.99-$2 is cheaper at typical volumes - run the math on your monthly ticket count.' },
      { q: 'How do I keep AI from giving wrong answers?', a: 'Strict scope: only let AI answer from your verified knowledge base, not from general LLM knowledge. Set escalation thresholds (confidence < 80% = human handoff). Audit a sample of AI-resolved tickets weekly. Never let AI quote pricing or refund policy without human review.' },
    ],
    relatedUseCaseLists: [
      { slug: 'best-ai-customer-service-tools', label: 'Best AI Customer Service' },
      { slug: 'best-ai-knowledge-management-tools', label: 'Best AI Knowledge Management' },
      { slug: 'best-ai-chatbots', label: 'Best AI Chatbots' },
    ],
  },
]

export function getRole(slug: string): Role | null {
  return ROLES.find(r => r.slug === slug) ?? null
}
