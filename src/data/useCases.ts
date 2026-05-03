// High-intent use-case landing pages.
// Each entry maps to a Supabase tag query for the top tools in that use case
// and renders programmatic content with Person author attribution.

export interface UseCase {
  slug: string
  title: string                     // "Best AI to {action}"
  shortAction: string               // "write blog posts" - used in copy
  emoji: string
  primaryTag: string                // tag to filter Supabase tools by
  secondaryTags?: string[]          // fallback if primary returns too few
  intro: string                     // ~120 words
  whatToLookFor: string             // ~100 words
  faqs: { q: string; a: string }[]  // 4 per use case
}

export const USE_CASES: UseCase[] = [
  {
    slug: 'write-blog-posts',
    title: 'Best AI to Write Blog Posts',
    shortAction: 'write blog posts',
    emoji: '📝',
    primaryTag: 'writing-ai',
    intro: 'Writing high-quality blog posts is the most common AI use case in 2026. The leaders fall into two camps: frontier general LLMs that write everything well (ChatGPT, Claude, Gemini), and content-specialised tools that bring brand voice training, SEO mode, and team templates to the workflow (Jasper, Copy.ai, Sudowrite). For a single writer producing 1-5 posts per month, a frontier LLM at $20/mo covers everything. For a content team producing 20+ pieces with consistent brand voice, the specialised tools earn their per-seat premium.',
    whatToLookFor: 'Brand voice training (does the tool maintain your style across long content), SEO mode (does it score drafts against ranking targets), output quality on long-form (most tools do well in 200 words and worse in 2000), pricing per seat at your team size, and integration with your CMS (WordPress, Webflow, Ghost). The single biggest mistake is paying enterprise prices for solo use; the second is using a frontier LLM for 50-piece content campaigns where templates and brand voice would save real time.',
    faqs: [
      { q: 'Can ChatGPT write blog posts as well as Jasper?', a: 'Yes for one-off posts; no for sustained brand-consistent content. Jasper Brand Voice training and team templates accelerate consistency and speed across 20+ pieces. For under 5 posts a month, ChatGPT plus a good prompt covers it.' },
      { q: 'Should I use AI to write the whole post or just outline and edit?', a: 'Most experienced writers use AI for research, outlining, and editing rather than full generation. The output quality of "write me a 1500-word post on X" remains noticeably worse than "research X and outline it for me, then I write".' },
      { q: 'Will Google penalise AI-written content?', a: 'Not for being AI-written specifically. Google penalises low-quality, unhelpful content regardless of source. AI content that adds genuine value, has accurate facts, and serves real reader intent ranks fine. AI content that is shallow, regurgitated, or factually wrong does not.' },
      { q: 'What about plagiarism and originality?', a: 'AI content rarely matches verbatim text from training data, but it can paraphrase widely-published claims that other sites also paraphrase. Use Originality.ai or similar to verify, especially for academic or commercial-publishing contexts where the bar is higher.' },
    ],
  },
  {
    slug: 'summarize-meetings',
    title: 'Best AI to Summarize Meetings',
    shortAction: 'summarize meetings',
    emoji: '📋',
    primaryTag: 'meeting-intelligence',
    secondaryTags: ['productivity'],
    intro: 'Meeting summarisation is the highest-ROI AI use case for knowledge workers in 2026. Tools record your Zoom or Google Meet, transcribe in real time, and produce action items, summaries, and CRM-bound notes within seconds of the call ending. Fathom leads the free tier with unlimited recordings; Otter is the broader transcription veteran; Fireflies, Avoma, and Read AI compete on team analytics; Grain wins on sales coaching. For individual use Fathom Free is the practical default.',
    whatToLookFor: 'Free-tier limits (most useful tools cap recording minutes or summary count), summary quality on action items (where most tools still hallucinate), CRM integration if you are in sales (Salesforce/HubSpot push-back is essential), language support if multi-region, and team analytics if managing meeting load across an org. Watch for tools that lock summaries behind paywalls after a generous trial - the per-minute pricing model is a trap for sustained use.',
    faqs: [
      { q: 'Is Fathom really free forever?', a: 'Yes, the free tier is unlimited recordings with unlimited AI summaries on the major platforms. Premium ($19/user/mo) adds team features and CRM integrations. The free tier is unusual in this category and is what drives Fathom adoption.' },
      { q: 'Which integrates best with Salesforce?', a: 'Fathom and Avoma have the cleanest Salesforce push-back of meeting notes and action items. Gong is the deeper revenue-intelligence tool but priced for enterprise. Otter integration is solid for transcripts but lighter on action items.' },
      { q: 'Can I trust the summaries for action items?', a: 'Mostly yes, but verify before relying on them. Hallucination on action items happens (assigning tasks to wrong person, inventing deadlines). Treat AI action items as draft notes, review before sharing, and edit obvious errors.' },
      { q: 'Should I just use Otter or Read AI instead?', a: 'Otter is broader (live captions, AI chat over transcripts) but feels older and pricier than Fathom. Read AI specialises in cross-meeting analytics. Fathom is the popular default for focused meeting notes; Read AI fits if engagement scoring matters.' },
    ],
  },
  {
    slug: 'generate-images',
    title: 'Best AI to Generate Images',
    shortAction: 'generate images',
    emoji: '🎨',
    primaryTag: 'image-ai',
    intro: 'AI image generation in 2026 is mature: photorealism is good enough for production work, prompt adherence is reliable, and the tools cost $10-30/mo for unlimited generation. Midjourney remains the aesthetic leader. Flux 1.1 Pro (via Fal, Replicate, or Recraft) is the photorealism specialist. Ideogram is unbeatable for text-in-image. Stable Diffusion via Leonardo or Stability API gives developers fine-tune and API control. For non-designers, Canva AI and Adobe Firefly bring image generation inside familiar editors.',
    whatToLookFor: 'Output quality on the style you actually need (Midjourney for stylised, Flux for photorealism, Ideogram for text), commercial-use rights (most paid tiers are fine; check before using free output for paid client work), API access if integrating into a product (Stability and Replicate are developer-first), and editor integration if you produce design assets in Photoshop or Canva. Expect to use 2-3 tools rather than one for serious design work.',
    faqs: [
      { q: 'Which has the best photorealism in 2026?', a: 'Flux 1.1 Pro by a meaningful margin, especially on humans, hands, and complex scenes. Midjourney v6 closed the gap on stylised but Flux is still ahead on raw photorealistic detail. Stable Diffusion 3.5 is competitive in self-hosted contexts.' },
      { q: 'Can I use AI images commercially?', a: 'On paid tiers of Midjourney, Adobe Firefly, Ideogram, Recraft, Leonardo, and Canva AI, yes - commercial use is included. Free tiers vary; check the specific terms. Adobe Firefly makes the strongest commercial-safety claim because of its training data sourcing.' },
      { q: 'Does Midjourney have an API?', a: 'No official API. Third-party services scrape and resell access at higher cost and lower reliability. For programmatic image generation, use Flux via Replicate or Fal, Stable Diffusion via Replicate or Stability API, or DALL-E via OpenAI.' },
      { q: 'Which is cheapest?', a: 'Free tiers exist on Ideogram, Leonardo, Stable Diffusion via Mage, and others. Cheapest serious paid tier: Ideogram Plus at $8/mo. For production volume, calculate cost per image - Stability API at ~$0.04/image often beats subscription tiers if you generate < 200 images/mo.' },
    ],
  },
  {
    slug: 'code-faster',
    title: 'Best AI to Code Faster',
    shortAction: 'code faster',
    emoji: '⚡',
    primaryTag: 'code-ai',
    intro: 'AI coding tools are the most-adopted productivity category among engineers in 2026. The two leaders are Cursor (full VS Code fork with the deepest AI integration, $20/mo Pro) and GitHub Copilot ($10/mo individual, deep autocomplete plus Copilot Workspace). Codeium is the strong free alternative. Devin and Lindy lead the autonomous-agent angle. Lovable, Bolt.new, and Replit Agent compete for spec-to-app workflows. For daily engineering on existing codebases, pick Cursor or Copilot; for spec-to-prototype, pick Bolt or Lovable.',
    whatToLookFor: 'Inline autocomplete quality (test on your stack before paying), agent / Composer mode for multi-file edits, IDE coverage (VS Code, JetBrains, Vim/Neovim), context window depth (matters for monorepos), and pricing at team scale (Cursor Business is $40/seat vs Copilot Business at $19/seat). For large codebases, context handling is the differentiator. For solo work, frontline autocomplete quality dominates.',
    faqs: [
      { q: 'Cursor or Copilot in 2026?', a: 'Cursor for the deepest AI workflow (agent, Composer, multi-file refactor). Copilot for tight VS Code or JetBrains integration plus the GitHub ecosystem. Many engineers run both: Copilot for inline autocomplete, Cursor for big tasks.' },
      { q: 'Is Codeium really free for individuals?', a: 'Yes, the free tier covers unlimited single-line completions, 100 chat messages a month, and full IDE plugin support. Pro removes the chat cap. The free tier is genuinely usable for daily work.' },
      { q: 'Can I trust AI-generated code in production?', a: 'For the same reasons you trust junior-engineer code: review carefully, test before merging, and watch for confident-sounding nonsense. AI generates code that looks right and is sometimes subtly wrong, especially on edge cases. Treat it as a fast junior, not a senior.' },
      { q: 'Which is best for non-developers building apps?', a: 'Lovable, Bolt.new, or Replit Agent. These tools generate working applications from natural-language specs and are aimed at users who cannot read or write code fluently. For learners, Replit is the most forgiving.' },
    ],
  },
  {
    slug: 'edit-videos',
    title: 'Best AI to Edit Videos',
    shortAction: 'edit videos',
    emoji: '🎬',
    primaryTag: 'video-ai',
    intro: 'AI video editing in 2026 covers two distinct workflows: long-to-short clip generation (Opus Clip, Klap, Captions) for repurposing podcasts and webinars into TikTok or Reel-friendly clips, and AI video generation (Runway, Pika, Luma, Hailuo, Kling) for creating original video from text or images. For end-to-end editing including transcription, multi-track, and AI features, Descript leads. For talking-head avatar videos, HeyGen and Synthesia dominate. Pricing ranges from free tiers up to $50/mo for serious creator plans.',
    whatToLookFor: 'Output format alignment with your distribution channel (vertical for short-form, 16:9 for YouTube, square for IG), caption quality and stylisation (a major UX differentiator), AI-generated content rights (most paid tiers are fine, free tiers may impose watermarks), audio quality for noise reduction and dubbing, and integration with your existing editor if you finish in DaVinci or Premiere.',
    faqs: [
      { q: 'Which is best for repurposing long content into short clips?', a: 'Opus Clip leads on viral-moment detection. Klap is a simpler alternative at the same price. Captions covers broader AI-first video editing. Most podcasters in 2026 default to Opus Clip.' },
      { q: 'Can AI generate full videos from prompts?', a: 'Yes for short clips (5-60 seconds). Runway, Pika, Luma, Hailuo, and Kling all produce usable text-to-video output. For longer narrative video, generation is still piecemeal; you generate clips and edit them together.' },
      { q: 'Should I use Descript for podcast editing?', a: 'Yes, Descript is the leader for podcast and audio-driven video editing. The text-based editor (edit transcript, audio cuts) is unique and covers podcasts plus YouTube videos efficiently.' },
      { q: 'Which is best for avatar talking-head video?', a: 'HeyGen for broad creator and SMB use; Synthesia for enterprise corporate training; Colossyan for multi-language L&D content. Pick by use case - HeyGen is the popular default.' },
    ],
  },
  {
    slug: 'transcribe-audio',
    title: 'Best AI to Transcribe Audio',
    shortAction: 'transcribe audio',
    emoji: '🎙️',
    primaryTag: 'voice-audio',
    intro: 'AI transcription in 2026 is essentially solved on English audio - accuracy on clean recordings is 95%+ with major tools. The differentiation is workflow integration (meetings, podcasts, mobile voice notes), language coverage, and pricing model. Otter is the broad veteran; Notta covers 104 languages including strong non-English; Tactiq runs as a Chrome extension on Meet/Zoom; Whisper API (OpenAI) gives developers $0.006/minute pricing for programmatic use; Descript turns transcripts into editable text-based audio.',
    whatToLookFor: 'Free-tier minute caps (most generous: Otter 300 min/mo, Notta 120 min/mo), language support if you have non-English audio, mobile app quality if recording on the phone, real-time vs upload-only (real-time costs more in compute), and CRM or note-tool integration if your transcripts feed downstream workflows.',
    faqs: [
      { q: 'Which has the best accuracy?', a: 'Whisper Large v3 (OpenAI) and Deepgram Nova-2 lead on raw accuracy benchmarks in 2026. For consumer apps using these models under the hood (Otter, Notta, Tactiq), accuracy is similar. Differences come from speaker identification and post-processing more than raw transcription.' },
      { q: 'Should I use Whisper API directly?', a: 'For programmatic transcription at volume, yes. Whisper API is ~$0.006/minute, far cheaper than consumer subscriptions. For UI-driven workflows (meetings, podcasts), use a tool that wraps Whisper or equivalent.' },
      { q: 'Can transcription handle multiple speakers?', a: 'Yes, with caveats. Speaker diarisation is good when recordings have clean per-speaker audio (each speaker on a separate track). On a single-mic recording with overlapping speech, accuracy drops. Most consumer tools handle 2-3 speakers well; 4+ speakers degrade noticeably.' },
      { q: 'What about non-English languages?', a: 'Notta covers 104 languages with strong accuracy on major European, Asian, and Arabic. Otter is English-only. Whisper API handles 50+ languages well but quality varies by language - Dutch, Korean, Hebrew often have higher error rates than Spanish or French.' },
    ],
  },
  {
    slug: 'build-websites',
    title: 'Best AI to Build Websites',
    shortAction: 'build websites',
    emoji: '🌐',
    primaryTag: 'no-code',
    secondaryTags: ['web-builder'],
    intro: 'AI website builders changed the game in 2024-2025 and in 2026 they cover most small-to-medium websites without traditional development. Lovable and Bolt.new lead the AI-app-from-prompt category (you describe the site and it builds working code). Framer and Webflow added strong AI-assist on top of polished visual builders. Wix and Squarespace integrated AI design generators for templates. For brochure sites, Framer or Webflow with AI assist; for full-stack apps, Lovable or Bolt.new; for non-designers, Wix or Squarespace ADI.',
    whatToLookFor: 'Output type (static HTML brochure vs dynamic app with database), hosting model (built-in vs export to your own host), customisation depth (some AI builders trap you in their visual editor; export options matter for long-term flexibility), pricing at scale (custom domains and hosting can balloon), and integration with your existing stack.',
    faqs: [
      { q: 'Can I build a real production website with AI?', a: 'Yes for most use cases under 1M monthly visitors with standard CMS needs. The output from Lovable, Bolt.new, Framer, and Webflow is usable as-is. For high-traffic, custom-feature, or compliance-heavy sites, AI gets you 70% there but custom development finishes the job.' },
      { q: 'Which is best for non-developers?', a: 'Wix and Squarespace ADI for simple brochure sites with no learning curve. Lovable for SaaS-style apps where you want hands-off AI to write the code. Framer for designers who want a polished visual editor with AI assist.' },
      { q: 'Will my AI-built site rank on Google?', a: 'Yes if the underlying HTML is clean and the content is good. Modern AI builders (Lovable, Framer, Webflow) produce SEO-clean output. Older site-builder generations had issues with generated HTML; the current state is fine.' },
      { q: 'Can I export the code from these tools?', a: 'Lovable and Bolt.new export to GitHub repos as standard React/Next.js code that you can take to any host. Framer and Webflow keep code on their platform but have export options at higher tiers. Wix and Squarespace are typically not exportable.' },
    ],
  },
  {
    slug: 'automate-workflows',
    title: 'Best AI to Automate Workflows',
    shortAction: 'automate workflows',
    emoji: '🔗',
    primaryTag: 'automation',
    intro: 'Workflow automation tools connect apps and run scheduled or trigger-based actions, optionally with AI steps inside the flow. Zapier remains the broad leader with 7K+ apps and the easiest UX. Make is the visual-flow alternative at lower cost. n8n is the open-source self-hostable option. Pipedream is developer-first with code steps. Activepieces is a younger open-source alternative. For non-technical users, Zapier; for cost-sensitive teams, Make or self-hosted n8n; for engineers, Pipedream or n8n.',
    whatToLookFor: 'App catalogue (Zapier 7K+ vs Make 2K+ vs n8n 400+), pricing model (per-task vs per-execution vs per-seat), AI step support (most leading tools added native AI nodes in 2024-2025), self-host option if data privacy matters, and code-step support if you need flexibility beyond pre-built actions.',
    faqs: [
      { q: 'Zapier or Make for SMB?', a: 'Zapier for the easiest UX and broadest app coverage. Make for visual-flow control and cheaper per-task pricing at higher volumes. Most non-technical users default to Zapier; technical users often prefer Make or n8n for the cost.' },
      { q: 'Should I self-host n8n?', a: 'Yes if data privacy or cost are top concerns. Self-hosted n8n is essentially unlimited (you pay only your own compute). The trade-off is operational overhead - you maintain the deployment. For most SMBs, n8n Cloud at $20/mo is the practical pick.' },
      { q: 'How do AI steps work in workflows?', a: 'Most automation tools added OpenAI / Anthropic / Google Gemini nodes that you can drop into a flow. Use them for content generation, classification, summarisation, or extraction inside a multi-step automation. Cost per AI call is usage-based on top of the workflow tool subscription.' },
      { q: 'Can I replace Zapier with ChatGPT?', a: 'No. ChatGPT does not connect to your apps and trigger actions on schedule or events. ChatGPT plus Zapier is a common combination - Zapier handles connections and timing, ChatGPT handles AI-driven steps inside the workflow.' },
    ],
  },
  {
    slug: 'translate-content',
    title: 'Best AI to Translate Content',
    shortAction: 'translate content',
    emoji: '🌍',
    primaryTag: 'translation',
    intro: 'AI translation in 2026 produces near-human quality on European languages and is closing fast on Asian and African ones. DeepL leads on European-language nuance. ChatGPT and Claude are competitive general translators with the advantage of context understanding. Crowdin and Lokalise are localisation platforms for software teams. Lilt and Unbabel pair AI with human reviewers for enterprise quality. For one-off translation, ChatGPT or DeepL are sufficient. For ongoing software localisation, Crowdin or Lokalise. For high-stakes enterprise content, Lilt or Unbabel.',
    whatToLookFor: 'Language pair quality (Spanish, French, German, Portuguese, and Italian are all near-human; Arabic, Korean, Hebrew, and minority languages vary), context awareness (does it preserve product names, brand voice, formatting), localisation features if you ship software (string keys, plural rules, RTL support), and human-review option for content that matters legally or commercially.',
    faqs: [
      { q: 'DeepL or ChatGPT for translation?', a: 'DeepL for European languages where idiomatic nuance matters; ChatGPT or Claude when context across long content matters more than per-sentence polish. For software localisation strings, DeepL has cleaner output. For document translation, frontier LLMs win on context preservation.' },
      { q: 'How accurate is AI translation in 2026?', a: 'On clean prose in major language pairs, near-human accuracy. On legal contracts, idiomatic dialogue, or culturally-loaded content, AI still produces visible errors. For high-stakes content, hybrid AI-plus-human review (Lilt, Unbabel) reduces error rate to under 1%.' },
      { q: 'Which is best for software localisation?', a: 'Crowdin and Lokalise are the leaders. Both integrate with GitHub, Figma, and developer workflows; both support string keys, plural rules, and RTL languages. Crowdin is broader; Lokalise has cleaner API. Pick by team workflow.' },
      { q: 'Can I use Google Translate professionally?', a: 'For internal communication and rough understanding, yes. For published or customer-facing content, results lag behind DeepL noticeably on European languages and behind frontier LLMs on context-sensitive content. Most professional workflows have moved away from Google Translate as primary.' },
    ],
  },
  {
    slug: 'design-graphics',
    title: 'Best AI to Design Graphics',
    shortAction: 'design graphics',
    emoji: '🎯',
    primaryTag: 'design',
    intro: 'AI graphic design tools handle social posts, ads, infographics, presentations, and brand assets. Canva AI is the all-in-one for non-designers. Adobe Firefly inside Photoshop, Illustrator, and Express is for designers already in Creative Cloud. Recraft adds AI vector output and brand styles. Galileo AI generates UI designs from prompts. Visily and Uizard target wireframing. For SMB marketing assets, Canva AI; for serious design work, Adobe Firefly; for vector and brand assets, Recraft.',
    whatToLookFor: 'Output type alignment (raster vs vector, social vs print), brand consistency features (Canva Brand Kit, Recraft Brand Styles), template library breadth and quality, integration with your existing design tools (Figma plugin, Photoshop integration), and commercial-use rights on AI generations.',
    faqs: [
      { q: 'Canva AI or Adobe Firefly?', a: 'Canva AI for non-designers and SMB marketing assets - the editor is approachable and templates do the heavy lifting. Firefly for designers in Creative Cloud who want AI inside Photoshop and Illustrator. They serve different audiences; many teams use both.' },
      { q: 'Can AI replace a designer?', a: 'For routine design (social posts, blog graphics, presentation slides), mostly yes. For brand systems, complex print, illustration, and motion design, no. AI is a force multiplier for designers, not a replacement at the high end.' },
      { q: 'Is AI design output commercially safe?', a: 'On paid tiers of Canva, Adobe Firefly, Midjourney, Recraft, and similar, yes - commercial use is included. Adobe Firefly makes the strongest claim (commercially-safe training data). Free tiers and beta features sometimes exclude commercial rights; check before using output for paid client work.' },
      { q: 'Which is best for UI design?', a: 'Galileo AI and Uizard generate UI screens from prompts. Visily focuses on wireframes. For production UI design, you still finish in Figma; the AI tools accelerate ideation rather than replace the design process.' },
    ],
  },
  {
    slug: 'handle-customer-support',
    title: 'Best AI to Handle Customer Support',
    shortAction: 'handle customer support',
    emoji: '💬',
    primaryTag: 'customer-service',
    intro: 'AI customer support tools span deflection (answer common questions before a human is involved), augmentation (suggest replies to agents), and full automation (handle entire conversations). Intercom Fin is the leader on AI deflection priced per resolution. Zendesk and Freshdesk integrated AI agents into their platforms. Ada AI and Decagon target AI-first deployment. Forethought, Ultimate, and Yellow.ai compete on conversational AI. For SaaS support, Intercom Fin; for enterprise omnichannel, Zendesk; for deeply custom AI agents, Ada or Decagon.',
    whatToLookFor: 'Pricing model (per-resolution like Fin vs per-seat like Zendesk), accuracy on your knowledge base (test with your real KB before signing), integration with your existing helpdesk (Intercom-native vs Zendesk-native), language support if global, and analytics on deflection rate so you can prove ROI.',
    faqs: [
      { q: 'Is AI deflection actually worth it?', a: 'For high-volume support orgs, yes. Fin deflects 50%+ of common queries on a well-maintained knowledge base, which translates to real seat savings. For low-volume support, the per-resolution pricing is worse than just adding humans.' },
      { q: 'Which has the highest deflection rate?', a: 'Intercom Fin in independent benchmarks consistently leads, especially when paired with a well-organised KB. Ada and Decagon are competitive in custom enterprise deployments. The biggest determinant is KB quality, not the AI.' },
      { q: 'Will AI agents misanswer customer questions?', a: 'Sometimes, yes. Hallucination on specific product details still happens. Treat AI deflection as a triage layer - clear escalation paths to humans, sentiment monitoring, and review of AI-handled conversations are essential. Most leading tools handle escalation cleanly.' },
      { q: 'Should I use ChatGPT instead?', a: 'No, ChatGPT is not built for support workflows. Customer support tools need ticket management, SLAs, integrations, multilingual handling, and human escalation. ChatGPT is a model, not a platform. Use a purpose-built support tool that may run on top of GPT-4o under the hood.' },
    ],
  },
  {
    slug: 'analyze-data',
    title: 'Best AI to Analyze Data',
    shortAction: 'analyze data',
    emoji: '📊',
    primaryTag: 'analytics',
    intro: 'AI data analysis tools span natural-language SQL (text-to-SQL), automated insight generation, and visualisation. Julius AI and Hex are leaders for natural-language data exploration. Akkio and Pecan specialise in predictive AI. Outerbase and Seek AI focus on SQL natural-language interfaces. ChatGPT Code Interpreter is genuinely strong for ad-hoc analysis on uploaded files. For analysts familiar with SQL, Julius or Outerbase. For business users, Akkio or Hex AI. For one-off CSV analysis, ChatGPT.',
    whatToLookFor: 'Data source connections (some connect to warehouses, others limit to CSV upload), output type (notebooks, dashboards, predictions, charts), natural-language SQL accuracy on your schema (test before paying), pricing model (per-seat vs per-query), and exportability of charts and insights to your existing BI stack.',
    faqs: [
      { q: 'Can I trust AI-generated SQL?', a: 'For simple aggregations and filters, yes. For multi-table joins, complex window functions, and edge cases, verify before running on production. Most leading tools (Julius, Outerbase) show the SQL alongside the result so you can audit. Treat AI-generated SQL like junior-engineer SQL: usually right, sometimes subtly wrong.' },
      { q: 'Is ChatGPT Code Interpreter enough for ad-hoc analysis?', a: 'For analysing uploaded CSV files (under 100MB), yes - it handles statistics, charting, and natural-language queries cleanly. For data warehouse-scale analysis, you need a tool that connects to your warehouse (Hex, Julius, Mode).' },
      { q: 'Which is best for non-technical users?', a: 'Akkio and Pecan for predictive analytics on business data. Hex AI for exploration with natural-language plus visualisation. Julius for the cleanest text-to-chart UX. Most non-technical users do best with Hex or Julius for exploration.' },
      { q: 'Will AI replace my data analyst?', a: 'No, but it changes the role. AI handles ad-hoc and self-service analysis well, freeing analysts for deeper investigation, modelling, and stakeholder alignment. The analyst job in 2026 is more strategic and less SQL-typing-heavy than in 2022.' },
    ],
  },
]

export const USE_CASE_SLUGS = USE_CASES.map(u => u.slug)

export function getUseCase(slug: string): UseCase | null {
  return USE_CASES.find(u => u.slug === slug) ?? null
}
