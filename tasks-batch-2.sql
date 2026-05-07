-- Phase 1 batch 2 of Task Taxonomy initiative (S113)
-- 17 head-term tasks. Each picked_slugs verified to exist in catalog
-- (run scripts/verify-batch-2-candidates.mjs to re-verify).
-- Source: editorial brainstorm + tool catalog use_cases mining (Option B
-- per S113: GSC creds not yet configured, so deferred GSC-only sourcing).
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- 1. ai-for-social-media-posts
(
  'ai-for-social-media-posts',
  'AI for Social Media Posts',
  '📱',
  ARRAY['social-media', 'writing-ai', 'marketing'],
  ARRAY['contentstudio', 'jasper', 'copy-ai', 'predis-ai', 'taplio'],
  3,
  'Posting once a day across LinkedIn, X, Instagram, and TikTok eats hours that small teams do not have. AI social tools draft, schedule, and adapt one core idea into platform-native posts - hashtags, hooks, image sizes, all handled. ContentStudio leads for full multi-channel scheduling with AI built in. Jasper and Copy.ai win when the bottleneck is copy, not scheduling. Predis.ai goes furthest on auto-generated visuals from a single prompt. Taplio is the LinkedIn-only specialist that consistently beats general tools on personal-brand engagement.',
  'We weighed five signals: (1) Channel coverage - LinkedIn plus at least three of X, IG, TikTok, FB, Threads. (2) AI quality on hooks and first lines, not just generic body copy. (3) Calendar and queue UX for scheduling 30+ posts ahead. (4) Image and short-video generation built in vs requires Canva round-trip. (5) Pricing transparency for teams above 1 seat.',
  '[
    {"q":"Will AI-written posts hurt my reach on LinkedIn or X?","a":"Algorithms do not penalize AI authorship directly - they penalize generic, low-engagement content. Posts written or polished with AI rank fine if they hook, deliver, and prompt comments. Watch dwell time and reply rate, not the tool used to draft."},
    {"q":"Can one tool actually replace Buffer plus Jasper?","a":"ContentStudio and Predis.ai bundle scheduling and generation. If you already love Buffer or Hootsuite for queueing, a copy-only tool like Jasper is the cleaner add. Avoid stacking two scheduling tools."},
    {"q":"Are AI image posts as good as a real designer?","a":"For brand identity work, no. For everyday post graphics - quote cards, simple carousels, stat callouts - Predis.ai and ContentStudio output is good enough at scale. Designer work still wins for launches and ad creative."},
    {"q":"What is the cheapest way to start?","a":"Copy.ai free tier handles a few posts weekly. ContentStudio starts under $30/mo with full scheduling. Avoid annual contracts before you confirm one core platform actually moves your metrics."}
  ]'::jsonb,
  'marketing',
  'beginner',
  1900,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 2. ai-for-product-descriptions
(
  'ai-for-product-descriptions',
  'AI for Product Descriptions',
  '🛍️',
  ARRAY['writing-ai', 'e-commerce'],
  ARRAY['jasper', 'hypotenuse-ai', 'copy-ai', 'writesonic', 'anyword'],
  3,
  'A 5,000-SKU catalog needs 5,000 descriptions that convert - and rewriting them by hand is the fastest path to burnout in any ecommerce team. AI product description tools ingest title, attributes, and category, then output benefit-led copy that matches your brand voice and surfaces SEO keywords. Jasper leads for brand-voice consistency across thousands of SKUs. Hypotenuse.ai is purpose-built for ecommerce with bulk PIM workflows. Copy.ai and Writesonic suit smaller catalogs and budget-tier needs. Anyword wins when you also need predictive performance scores on each variant.',
  'Selection focused on: (1) Bulk import from Shopify, BigCommerce, or CSV - not one SKU at a time. (2) Brand voice memory that survives across batches without manual re-prompting. (3) Output structure - title, bullet points, long-form, meta description in one pass. (4) Multilingual support for global stores. (5) Cost per SKU at typical mid-market volume (1k-10k products).',
  '[
    {"q":"Can these write descriptions Google will index well?","a":"Yes - all five emit clean, indexable copy. The risk is generic templates repeated across thousands of SKUs. Vary structure with seed keywords, brand voice, and product attributes to keep each unique."},
    {"q":"Will Shopify or Amazon flag AI-generated text?","a":"Neither platform has a rule against AI authorship. Amazon does flag duplicate or low-quality copy regardless of source - test sample SKUs before bulk-publishing 1,000 at once."},
    {"q":"What about my unique brand voice?","a":"Jasper and Anyword learn voice from a few seed examples. Hypotenuse trains on your existing product catalog directly. Plan a 10-SKU calibration round before bulk runs."},
    {"q":"Do I still need a copywriter?","a":"For hero products and category pages, yes. For long-tail SKUs that drive 80% of catalog volume, AI plus a 30-second human review beats writing each from scratch."}
  ]'::jsonb,
  'writing',
  'beginner',
  1600,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 3. ai-for-email-newsletters
(
  'ai-for-email-newsletters',
  'AI for Email Newsletters',
  '💌',
  ARRAY['writing-ai', 'marketing'],
  ARRAY['mailerlite', 'beehiiv', 'omnisend', 'klaviyo', 'copy-ai'],
  3,
  'Newsletter writing fights two problems at once: subject lines that get opened, and body copy that earns the next click instead of the unsubscribe. AI-assisted newsletter platforms now ship subject-line variants, segment-aware personalization, and full-draft generation tuned to email - not generic blog copy. MailerLite and Beehiiv lead for creator newsletters and small lists. Omnisend and Klaviyo dominate ecommerce with revenue-attributed AI flows. Copy.ai is the standalone copy engine when your sender platform is bare-bones.',
  'Five signals drove the picks: (1) AI subject-line generator with predicted open rate, not just one suggestion. (2) Segment-aware personalization beyond first-name merge tags. (3) Native deliverability infrastructure - DKIM, SPF, warm-up. (4) Revenue tracking for ecommerce flows. (5) Free tier limits that work for a real newsletter, not just a teaser list.',
  '[
    {"q":"Does AI subject-line generation actually lift open rates?","a":"On lists above 5k subscribers, A/B-tested AI subject lines lift opens 5-15% on average vs founder gut. Below 5k, statistical noise dominates - test variants, but do not over-optimize early."},
    {"q":"Beehiiv vs Substack for AI features?","a":"Beehiiv ships AI subject-line and post-generation natively at all paid tiers. Substack is text-and-discovery first - no AI assist. Pick by which one has the audience you want, then layer Copy.ai if Substack."},
    {"q":"How do Klaviyo AI flows differ from Mailchimp?","a":"Klaviyo AI flows are tuned to ecommerce - it knows your Shopify customer LTV, predicts churn, and times sends per recipient. Mailchimp AI is more general. For a Shopify store, Klaviyo is rarely the wrong call."},
    {"q":"Will AI-generated newsletters trigger spam filters?","a":"Not from authorship - filters care about sender reputation, list hygiene, and engagement. AI-written copy passes spam tests when the rest of your stack is clean."}
  ]'::jsonb,
  'marketing',
  'beginner',
  880,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 4. ai-for-seo-content
(
  'ai-for-seo-content',
  'AI for SEO Content',
  '🔍',
  ARRAY['seo-marketing', 'writing-ai'],
  ARRAY['surfer-seo', 'jasper', 'frase', 'neuronwriter', 'scalenut'],
  3,
  'Ranking on Google in 2026 is not a keyword-density game - it is a topical-coverage game played against the top 10 results that already rank. AI SEO content tools scan the live SERP, extract entities, headings, and questions Google rewards, then guide you (or auto-write) content that closes the topical gaps. Surfer SEO leads on NLP-driven optimization scores. Jasper bundles SEO with brand voice and full-draft generation. Frase and NeuronWriter are budget-friendly with strong SERP analysis. Scalenut is the AI-first newcomer that ships outline-to-publish in one workflow.',
  'We weighted: (1) Live SERP scrape depth - top 10, top 30, or just one page? (2) NLP topic coverage scoring against ranking pages. (3) Editor UX - inline guidance vs separate dashboards. (4) Question and PAA mining for FAQ schema. (5) Workflow integration with Google Docs, WordPress, and CMS publishing.',
  '[
    {"q":"Will Google penalize content optimized with these tools?","a":"No - Google rewards helpful, comprehensive content. Penalties hit thin spam, not SEO-optimized work. The risk is over-optimization that reads like keyword salad - keep humans in the editing loop."},
    {"q":"Surfer SEO vs Frase - which one?","a":"Surfer wins on NLP score depth and team workflows. Frase wins on price and is faster for solo bloggers. Both ship SERP-driven outlines - try free trials on the same target keyword to compare output."},
    {"q":"Can AI write the full post that ranks?","a":"It can draft 80% - facts, structure, FAQ. The 20% that wins ranking is original POV, real examples, and recent data. Plan AI for first draft, human for differentiation."},
    {"q":"What about EEAT and AI Overviews?","a":"Add author bios, link to verifiable sources, include first-hand testing or data. Google ranks pages that demonstrate experience - not pages that merely cover the topic. Tools above suggest depth; humans supply the proof."}
  ]'::jsonb,
  'marketing',
  'intermediate',
  2900,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 5. ai-for-headlines
(
  'ai-for-headlines',
  'AI for Headlines',
  '📰',
  ARRAY['writing-ai', 'marketing'],
  ARRAY['jasper', 'copy-ai', 'writesonic', 'anyword'],
  3,
  'A great headline does 80% of the conversion work - whether it is the H1 of a landing page, the subject line of an email, or the first three words of an ad. AI headline tools generate dozens of variants tuned to a goal (clicks, opens, signups), then often rank by predicted performance so you ship the strongest. Jasper and Copy.ai are the most flexible across blog, ad, and email use cases. Writesonic is the budget pick with strong template variety. Anyword stands out by predicting click-through rate per variant before you even launch.',
  'Selection criteria: (1) Variety - does it generate 10+ distinct angles, not five rephrasings? (2) Format coverage - blog H1, ad headline, email subject, YouTube title. (3) Predicted-performance scoring tied to historical click-through data. (4) Brand voice memory across sessions. (5) Fast iteration UX - many variants in seconds, not three at a time.',
  '[
    {"q":"How is this different from just asking ChatGPT?","a":"ChatGPT generates headlines; these tools rank them. Anyword in particular shows predicted click-through rate per variant - the difference between guessing and choosing the best."},
    {"q":"Do AI headlines work for clickbait or only for news?","a":"They work across formats, but quality follows your prompt. Feed the tool the audience, the promise, and the angle - not just the topic. Generic prompts produce generic clickbait."},
    {"q":"Can I copy a headline a competitor used and rephrase it?","a":"Generate variants from your unique angle, not from a competitor reference. Headlines built on your specific data or POV outperform borrowed templates over time."},
    {"q":"Best workflow for testing headlines?","a":"Generate 20 variants, pick the 4 most distinct, A/B test on a small audience, scale the winner. Avoid testing 12 variants at once - statistical significance becomes painfully slow."}
  ]'::jsonb,
  'writing',
  'beginner',
  590,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 6. ai-for-video-editing
(
  'ai-for-video-editing',
  'AI for Video Editing',
  '🎬',
  ARRAY['video-ai'],
  ARRAY['descript', 'capcut', 'runway', 'opus-clip', 'veed-io'],
  3,
  'Editing video used to mean a Premiere license, a fast machine, and an afternoon to cut a 90-second clip. AI editors flip that model: edit by editing the transcript, auto-remove filler words, and generate vertical cuts for shorts in minutes. Descript leads for podcasters and creators who want text-based editing. CapCut dominates short-form social with free-tier templates. Runway is the creative suite with full generative video tools. Opus Clip is the specialist for repurposing long videos into TikTok and Reels cuts. Veed.io is the browser-based all-rounder for non-technical teams.',
  'Five weighted signals: (1) AI feature depth - transcript edit, filler removal, auto-captions, generative effects. (2) Output formats - 16:9, 9:16, 1:1 in one project. (3) Browser vs desktop - speed and collaboration tradeoff. (4) Free tier usefulness vs watermark or export limits. (5) Render speed for 10+ minute source files.',
  '[
    {"q":"Descript vs CapCut - which one for me?","a":"Descript if you edit podcasts, talking-head video, or long-form content via transcript. CapCut if you ship short-form social daily. They overlap at the edges; pick by primary workflow."},
    {"q":"Can Opus Clip really pick the best moments automatically?","a":"On talking-head content, it is surprisingly good - it surfaces 5-10 candidate clips with virality scores. Always review before publishing. AI clips fail on subtle setups, callbacks, or emotional beats."},
    {"q":"Is Runway worth it for non-creative teams?","a":"Probably not. Runway shines for creators using generative video, motion brush, and image-to-video effects. For straight cuts and corporate content, Descript or Veed are simpler and cheaper."},
    {"q":"What about Adobe Premiere with AI features?","a":"Premiere ships AI-assisted editing, but the learning curve and license cost outweigh AI tools above for short-form, podcast, or social use cases. Premiere wins when you need full creative control on cinematic work."}
  ]'::jsonb,
  'design',
  'intermediate',
  4400,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 7. ai-for-video-subtitles
(
  'ai-for-video-subtitles',
  'AI for Video Subtitles',
  '💬',
  ARRAY['video-ai'],
  ARRAY['descript', 'captions-ai', 'veed-io', 'submagic', 'kapwing'],
  3,
  'Subtitles are no longer a nice-to-have: 85% of social video is watched on mute, and accessibility laws across the EU and US mandate them on public content. AI subtitle tools transcribe audio, time-sync to frames, and style captions for vertical short-form in seconds. Descript handles polished long-form with editable transcript. Captions.ai and Submagic lead the styled-caption market for TikTok and Reels. Veed.io and Kapwing are the all-in-one browser editors with native subtitle workflows.',
  'Picks weighted by: (1) Transcription accuracy across accents and noisy audio. (2) Auto-timing precision (no caption appearing 2 seconds late). (3) Style options for short-form - emoji bursts, word-by-word reveal, brand colors. (4) Batch processing for high-volume creators. (5) Multi-language support and SRT/VTT export.',
  '[
    {"q":"How accurate is AI transcription on heavy accents?","a":"Top tools hit 95%+ on clear US/UK English, dropping to 85-90% on heavier accents or two speakers overlapping. Always review before publishing - one wrong word in a 30-second clip kills credibility."},
    {"q":"Submagic vs Captions.ai - what is the difference?","a":"Both target short-form social. Submagic ships more aggressive emoji and animated styles out of the box. Captions.ai has better speaker tracking and longer-form edit tools. Free trials on the same clip clarify quickly."},
    {"q":"Can I just use YouTube auto-captions for free?","a":"For YouTube long-form, yes - they are surprisingly accurate. For TikTok, Reels, and Shorts, native YouTube captions do not export styled. Tools above generate burned-in captions that match short-form aesthetics."},
    {"q":"Does AI subtitle work in languages other than English?","a":"Descript, Veed, and Kapwing support 30+ languages with varying accuracy. Spanish, French, German, Portuguese are excellent. Mandarin, Arabic, Hindi are improving but still need human review."}
  ]'::jsonb,
  'design',
  'beginner',
  880,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 8. ai-for-talking-avatars
(
  'ai-for-talking-avatars',
  'AI for Talking Avatars',
  '🗣️',
  ARRAY['video-ai'],
  ARRAY['heygen', 'synthesia', 'd-id', 'colossyan'],
  3,
  'Recording the same training video, support explainer, or product demo in 12 languages used to require a studio, voice actors, and weeks of edit time. AI talking-avatar platforms now generate photorealistic on-camera presenters from a script - in any of 100+ languages, in minutes. HeyGen leads for product and marketing video with strong avatar realism. Synthesia is the enterprise-trusted standard for L&D and training. D-ID specializes in animating any photo or branded character. Colossyan focuses on workplace learning with conversation flows.',
  'Selection signals: (1) Avatar realism - lip-sync precision and facial expression naturalness. (2) Language and voice library breadth (100+ languages is the bar). (3) Custom avatar creation from your real footage. (4) API access for programmatic use cases. (5) Pricing per minute of finished video, not just per seat.',
  '[
    {"q":"Are these avatars indistinguishable from real video?","a":"In a small thumbnail, often yes. In full-screen close-up, viewers spot the uncanny edge - especially around the mouth in fast speech. Use avatars for content where authenticity is not the core trust signal."},
    {"q":"Can I create an avatar of myself?","a":"HeyGen, Synthesia, and D-ID all offer custom avatars from a few minutes of recorded footage. Cost ranges from $99 to enterprise. Plan a careful recording session - poor source footage produces poor avatars."},
    {"q":"What about voice cloning for the avatar?","a":"HeyGen and ElevenLabs (often paired) let you clone your voice. Synthesia provides preset stock voices and supports custom clones at higher tiers. Always disclose AI-generated likeness in regulated industries."},
    {"q":"Is this allowed in regulated industries like healthcare or finance?","a":"With disclosure and review, yes - many compliance teams have approved Synthesia for internal training. Customer-facing financial advice or medical claims need stricter scrutiny - check with legal before publishing externally."}
  ]'::jsonb,
  'design',
  'intermediate',
  1300,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 9. ai-for-podcast-editing
(
  'ai-for-podcast-editing',
  'AI for Podcast Editing',
  '🎙️',
  ARRAY['voice-audio'],
  ARRAY['descript', 'riverside', 'podcastle'],
  3,
  'Podcast post-production used to be the silent killer of new shows: 90 minutes of raw audio became 6 hours of edits, mixing, and chapter markers before publish. AI podcast editors flip that ratio - clean filler words, balance levels, generate transcripts and chapters automatically. Descript leads with text-based editing where you delete a sentence by deleting a transcript line. Riverside doubles as a remote-recording studio with separate-tracks-per-guest. Podcastle is the all-in-one for solo creators on a budget.',
  'Weighted signals: (1) Filler-word removal accuracy (um, uh, like) without cutting real speech. (2) Audio enhancement - studio-quality from a USB mic. (3) Multi-track recording for remote guests at full quality. (4) Auto-generated show notes, chapters, and transcripts. (5) Export to MP3, WAV, plus video for YouTube and social.',
  '[
    {"q":"Will AI editing make my podcast sound robotic?","a":"Aggressive filler removal can - leave 10-15% of natural pauses and ums in for human cadence. Tools above all let you tune aggressiveness. Always listen to a 30-second sample before bulk-applying."},
    {"q":"Descript vs Adobe Audition for podcasts?","a":"Descript wins on speed and AI features - the transcript-edit workflow is unmatched for talking shows. Audition wins for music, sound design, and complex multi-track productions."},
    {"q":"How do AI tools handle multiple speakers and crosstalk?","a":"Riverside records each speaker on a separate track at the source - that is the safest path for clean editing. Tools that work post-recording (Descript, Podcastle) struggle when speakers overlap on a shared track."},
    {"q":"Can I edit a 2-hour episode in under an hour now?","a":"Yes - filler-word pass, level balance, chapter markers, and show notes generation cuts hours to maybe 30-45 minutes for a typical interview show. The creative cut (best moments, narrative arc) still needs human judgement."}
  ]'::jsonb,
  'design',
  'intermediate',
  1000,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 10. ai-for-debugging
(
  'ai-for-debugging',
  'AI for Debugging',
  '🐛',
  ARRAY['code-ai'],
  ARRAY['claude', 'cursor', 'copilot-microsoft', 'tabnine'],
  3,
  'Debugging is where AI coding assistants finally earn their license fee - not in autocomplete, but in reading 800-line stack traces, spotting the off-by-one, and explaining the regression in plain English. The best AI debuggers ingest the failing test, the error, and the source - then point to the line that matters. Claude excels at long-context debugging where the bug spans multiple files. Cursor pairs an editor-native AI with the entire repo context. GitHub Copilot is the IDE-integrated default for most teams. Tabnine offers privacy-first and on-prem options for regulated environments.',
  'Five signals drove the picks: (1) Long-context reasoning - can it read your whole repo, not just one file? (2) Stack trace parsing accuracy. (3) Editor integration depth (VS Code, JetBrains, Vim). (4) Privacy posture - does code ever leave your machine? (5) Latency on real-world debug requests.',
  '[
    {"q":"Should I use Claude or Cursor for debugging?","a":"Claude direct chat for one-off debugging where you can paste the error and code. Cursor for ongoing work where the bug touches multiple files and you want the AI to navigate the repo with you."},
    {"q":"Will Copilot leak my proprietary code?","a":"GitHub Copilot Business and Enterprise do not retain code for model training and offer IP indemnification. Free Copilot does retain prompts. For sensitive repos, Tabnine on-prem or Codeium Enterprise are alternatives."},
    {"q":"Is AI debugging trustworthy for production fixes?","a":"For diagnosis, yes. For autonomous fix-and-deploy, no - always run tests, code review, and a staging deploy before production. AI is fastest as a force multiplier on a senior engineer, not a replacement."},
    {"q":"What about Sentry or Rollbar plus AI?","a":"Sentry has shipped AI-powered issue summaries that pair well with Claude or Copilot for root-cause analysis. The combination - error monitoring that surfaces the issue, AI that proposes the fix - is the emerging best practice."}
  ]'::jsonb,
  'dev',
  'intermediate',
  720,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 11. ai-for-keyword-research
(
  'ai-for-keyword-research',
  'AI for Keyword Research',
  '🔑',
  ARRAY['seo-marketing'],
  ARRAY['surfer-seo', 'keyword-insights', 'frase', 'neuronwriter', 'scalenut'],
  3,
  'Picking the right keyword used to mean staring at Ahrefs and guessing which terms balance volume, difficulty, and intent. AI keyword tools cluster thousands of queries by intent, surface low-competition pockets your competitors missed, and tie each keyword back to a content brief. Surfer SEO leads for SERP-driven research at scale. Keyword Insights specializes in clustering at the SERP level - which queries should live on one page vs separate pages. Frase, NeuronWriter, and Scalenut bundle keyword research with content briefs in one workflow.',
  'Five weighted signals: (1) Search-intent classification accuracy. (2) Clustering at scale - 5,000+ queries grouped by SERP overlap. (3) Difficulty score realism vs Ahrefs and Semrush benchmarks. (4) Question and PAA mining for FAQ schema. (5) Output format - exportable briefs, not just CSV dumps.',
  '[
    {"q":"Can these tools replace Ahrefs or Semrush?","a":"Not fully - Ahrefs and Semrush still own the largest backlink and domain databases. Use them as the index, then layer Keyword Insights or Surfer for clustering and brief generation. Each does what the other does worse."},
    {"q":"How accurate is AI search-intent labeling?","a":"For clear informational/commercial/transactional splits, 90%+ accurate. For nuanced cases (informational that converts well), human review still wins. Treat AI labels as starting hypothesis, not truth."},
    {"q":"What does keyword clustering actually save me?","a":"Hours of manual SERP review. A 5,000-keyword cluster job takes minutes vs days by hand. The output - which keywords share top-3 URLs - tells you exactly which queries belong on one page."},
    {"q":"Best workflow for a new content site?","a":"Pull 1,000-3,000 seed keywords from Ahrefs. Cluster with Keyword Insights to find your topical pillars. Pick 5-10 pillars to target first. Surfer or Frase generates the briefs. Ship 10-20 articles per pillar before pivoting."}
  ]'::jsonb,
  'marketing',
  'intermediate',
  2400,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 12. ai-for-ad-copy
(
  'ai-for-ad-copy',
  'AI for Ad Copy',
  '📢',
  ARRAY['writing-ai', 'marketing'],
  ARRAY['jasper', 'copy-ai', 'anyword'],
  3,
  'Ad copy lives in a brutal feedback loop: you ship a hook, Meta or Google rewards it with cheap clicks or punishes it with $40 CPCs - and you have 48 hours to figure out which. AI ad copy tools generate dozens of variants tuned to each platform (Meta, Google, LinkedIn, TikTok), often with predicted performance scores so you spend the test budget on the strongest. Jasper leads for full campaign workflows with brand voice. Copy.ai is the budget-friendly generalist that nails the basics. Anyword is the specialist that predicts CTR per variant and tracks performance back into the model.',
  'Selection criteria: (1) Platform-specific output - Meta primary text vs Google Headlines vs LinkedIn body. (2) Predicted performance scoring with feedback from real ad data. (3) Brand voice consistency across 50+ variants. (4) A/B testing workflow integration. (5) Compliance scanning - flagging restricted phrases for finance, health, crypto.',
  '[
    {"q":"How is AI ad copy different from AI blog copy?","a":"Ad copy is shorter, hooks in 5-7 words, and lives or dies on click-through rate - blog copy is comprehensive, structured for SEO, and converts via long-form trust building. Different prompts, different tools, different success metrics."},
    {"q":"Will Meta or Google penalize AI-written ads?","a":"Neither platform restricts AI authorship. Both penalize generic, low-relevance creative regardless of source. The win is generating 30 variants and shipping the 3 humans review-pass - not letting AI auto-publish."},
    {"q":"Anyword vs Jasper for paid ads?","a":"Anyword if you run paid heavily and want predictive scoring on every variant. Jasper if you blend ads with broader content marketing and want one tool. Anyword pulls ahead on raw ad ROAS work."},
    {"q":"Is AI ad copy compliance-safe for regulated industries?","a":"Healthcare, finance, crypto, and supplements need extra review - tools above flag obvious issues but cannot replace legal and compliance sign-off. Build a human approval gate before any paid ad ships."}
  ]'::jsonb,
  'marketing',
  'intermediate',
  1600,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 13. ai-for-research-papers
(
  'ai-for-research-papers',
  'AI for Research Papers',
  '📚',
  ARRAY['research'],
  ARRAY['perplexity', 'elicit', 'scispace', 'consensus'],
  3,
  'Reading 30 papers to write a literature review used to be a week of careful note-taking. AI research tools now extract methods, findings, and limitations from PDFs, surface citation networks, and answer questions across 200M+ academic papers in seconds. Perplexity excels at general research with citation-grounded answers. Elicit is the specialist for systematic reviews and finding the right papers fast. SciSpace (Typeset) parses PDFs into structured summaries and answers questions about specific sections. Consensus crowdsources research conclusions across studies on a single question.',
  'Five signals: (1) Citation accuracy - does it actually link to the cited paper, or hallucinate refs? (2) PDF parsing depth - tables, figures, methods extraction. (3) Coverage of paywalled vs open-access content. (4) Question-answering grounded in retrieved content, not generic LLM output. (5) Export to citation managers (Zotero, Mendeley) and reference formats (APA, BibTeX).',
  '[
    {"q":"Can these replace Google Scholar?","a":"Not for discovery breadth - Scholar still indexes the most. But for synthesis (extracting findings across 20 papers) and quality-check (consensus across studies), tools above add what Scholar lacks."},
    {"q":"Is Perplexity reliable for academic citations?","a":"Better than ChatGPT, but still verify every citation by clicking through to the source. Perplexity hallucinations on academic refs have dropped sharply in 2025-26 but are not zero."},
    {"q":"What about hallucinated references?","a":"Elicit and SciSpace ground answers in retrieved papers from indexed databases - low hallucination risk. Perplexity grounds in web sources that include academic content. Consensus only ranks across studies it has found, not invents studies."},
    {"q":"Best workflow for a literature review?","a":"Start with Elicit to find 50-100 candidate papers. Use Consensus to check whether the field agrees or disagrees on key questions. Use SciSpace to extract structured summaries. Final read of top 10-15 papers in full - AI cannot replace deep engagement with the most important sources."}
  ]'::jsonb,
  'research',
  'intermediate',
  1300,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 14. ai-for-data-analysis
(
  'ai-for-data-analysis',
  'AI for Data Analysis',
  '📊',
  ARRAY['data-analytics'],
  ARRAY['julius-ai', 'deepnote', 'akkio', 'polymer', 'formula-bot'],
  3,
  'Asking a CSV "why did churn spike in March" used to require SQL skills, a BI dashboard, and a quiet hour to think. AI data analysis tools turn the same question into an English query - and return charts, statistical tests, and plain-language explanations. Julius AI and Deepnote lead for power users who want code + chat. Akkio is the no-code predictive specialist for marketers. Polymer (Polymer Search) shines on visual exploration of business datasets. Formula Bot is the budget pick for spreadsheet-bound teams.',
  'Five weighted signals: (1) Natural-language query accuracy across joins, aggregations, time windows. (2) Visualization quality auto-generated from the query intent. (3) Statistical depth - is it just SQL, or actual hypothesis testing? (4) Data source connectors - CSV, Sheets, Snowflake, BigQuery. (5) Privacy posture for sensitive business data.',
  '[
    {"q":"Can AI replace a data analyst?","a":"For ad-hoc business questions on clean data, often yes. For pipeline engineering, dashboard architecture, and stakeholder management, no. AI shifts analyst time toward higher-value work, not zero."},
    {"q":"Julius AI vs ChatGPT Code Interpreter?","a":"Julius is purpose-built for data work - faster on large CSVs, cleaner chart output, persistent project files. Code Interpreter is great for one-off questions but loses context across sessions. Pick Julius if data is your daily workflow."},
    {"q":"Are these safe for confidential business data?","a":"Vendors offer different postures. Deepnote and Julius offer enterprise tiers with data isolation. Free tiers usually train on prompts. For regulated data, on-prem or VPC-deployed options are the safer path."},
    {"q":"Will AI hallucinate statistics?","a":"It can generate plausible-but-wrong numbers if the underlying data is messy or the question is ambiguous. Always verify key numbers by re-running the calculation manually or in a second tool. Trust AI for direction, verify for decisions."}
  ]'::jsonb,
  'data-analytics',
  'intermediate',
  5400,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 15. ai-for-note-taking
(
  'ai-for-note-taking',
  'AI for Note Taking',
  '🧠',
  ARRAY['productivity'],
  ARRAY['notion-ai', 'mem-ai', 'reflect', 'otter-ai', 'fathom'],
  3,
  'Taking notes used to mean a static doc that you re-read once before forgetting. AI note-taking tools turn the same notes into a searchable knowledge graph that suggests connections, drafts summaries, and surfaces what you wrote six months ago when it is suddenly relevant. Notion AI is the default for teams already on Notion. Mem.ai and Reflect lead for personal knowledge graphs with strong AI surfacing. Otter.ai owns voice-to-text for meetings. Fathom is the meeting-specific specialist with auto-generated summaries.',
  'Selection criteria: (1) AI surfacing quality - relevant past notes during writing, not random suggestions. (2) Voice-to-text accuracy for meetings and dictated notes. (3) Linking and graph structure - how easily ideas connect over time. (4) Mobile + web parity. (5) Pricing model and free tier usefulness.',
  '[
    {"q":"Notion vs Mem.ai for personal use?","a":"Notion if you also build pages, projects, databases. Mem.ai if your workflow is purely capture-and-retrieve - it surfaces past notes more aggressively in your writing flow. Different opinions, both correct for different users."},
    {"q":"Can AI summarize my entire notebook?","a":"Notion AI and Mem can summarize across collections. Reflect supports broad search-and-synthesize. Quality depends on how structured your notes are. Garbage in, garbage out applies."},
    {"q":"Is Otter just for meetings?","a":"Mostly yes - it shines on real-time meeting transcription and summary. For desk notes, AI search, or long-form thinking, Notion AI or Mem are better fits. Pair Otter with one of those for a complete stack."},
    {"q":"What about privacy of my notes in AI training?","a":"Notion, Mem, and Reflect commit to not training on user data on paid tiers. Free tiers vary - read each privacy policy. For sensitive personal or medical notes, paid plans plus E2E-friendly tools are the safer path."}
  ]'::jsonb,
  'productivity',
  'beginner',
  2900,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 16. ai-for-chatbots
(
  'ai-for-chatbots',
  'AI for Chatbots',
  '🤖',
  ARRAY['ai-assistants', 'customer-service'],
  ARRAY['intercom', 'drift', 'ada-ai', 'tidio'],
  3,
  'Chatbots in 2026 are not the rule-based scripts that frustrated everyone in 2018 - they are LLM-powered agents that read your knowledge base, understand intent, and hand off to humans only when stuck. Intercom Fin and Drift lead for B2B with deep CRM context. Ada specializes in enterprise scale and multi-language deployments. Tidio is the budget-friendly pick for ecommerce stores under 10k tickets per month. Each ships an autonomous agent that deflects 30-50% of common questions when the knowledge base is clean.',
  'Five signals shaped the picks: (1) Autonomous deflection rate on real ticket volume, not benchmarks. (2) Knowledge base ingestion - Notion, Help Scout, websites, PDFs. (3) Handoff quality - context preserved when escalating to humans. (4) Channel coverage - web, WhatsApp, Instagram, SMS, in-app. (5) Pricing model - resolution-based vs seat-based vs hybrid.',
  '[
    {"q":"Will AI chatbots replace my support team?","a":"Not in 2026. Top deflection rates are 40-50% on common questions - the other half still need humans for nuance, escalation, and edge cases. AI shifts the team from tier-1 repetition to tier-2 problem solving."},
    {"q":"Intercom Fin vs Drift - which one?","a":"Intercom Fin if you also use Intercom for live chat - the integration is seamless. Drift if you lead with sales conversations and want chatbot + meeting booking + revenue attribution in one stack. Both are strong choices for SaaS."},
    {"q":"How clean does my knowledge base need to be?","a":"Cleaner than you think. AI agents only know what your KB tells them - outdated articles, conflicting policies, or thin pages produce wrong answers. Plan a 1-2 week KB cleanup before deploying any AI chatbot."},
    {"q":"What does this cost at typical mid-market scale?","a":"Intercom Fin charges per resolution ($0.99-$1.50 typical). Drift seat-based starting low four-figures monthly. Ada is enterprise-priced. Tidio starts under $30/mo. Match pricing model to your ticket pattern - resolution-based punishes spiky volume."}
  ]'::jsonb,
  'customer-success',
  'intermediate',
  8100,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 17. ai-for-presentations
(
  'ai-for-presentations',
  'AI for Presentations',
  '🎯',
  ARRAY['productivity', 'design'],
  ARRAY['gamma-app', 'beautiful-ai', 'pitch', 'visme', 'slidebean'],
  3,
  'Building a slide deck used to mean two hours fighting Google Slides and another hour finding stock images that did not look like stock images. AI presentation tools generate full decks from a one-line prompt - slides, layout, images, even speaker notes - then let you refine the result. Gamma App leads with its document-deck hybrid format. Beautiful.ai applies design rules so every slide stays visually consistent. Pitch is the team-collaboration champion with strong real-time editing. Visme covers a broader design surface (decks plus infographics plus social). Slidebean is purpose-built for pitch decks with investor-ready templates.',
  'Selection criteria: (1) Quality of one-prompt-to-deck generation. (2) Design consistency without manual fixing slide by slide. (3) Image generation or stock library that does not look generic. (4) Export to PPTX and PDF for offline use. (5) Speaker notes and presenter mode quality.',
  '[
    {"q":"Will AI-generated decks look like AI-generated decks?","a":"They used to. Gamma and Beautiful.ai are now near-indistinguishable from designer-led decks for internal and even external pitches. Polish always helps - 10 minutes of human refinement closes the last gap."},
    {"q":"Gamma vs Beautiful.ai - which one?","a":"Gamma if you want a doc-deck hybrid, easy editing, and modern fluid layouts. Beautiful.ai if you want strict design rules that prevent slides from going off-brand. Both are excellent - try free trials on the same content."},
    {"q":"Can I export to PowerPoint or Google Slides?","a":"All five export to PPTX. PDF is universal. Pitch and Visme also offer share-by-link experiences that often beat traditional file sharing. For investor decks, PDF still wins for compatibility."},
    {"q":"Best for a pitch deck specifically?","a":"Slidebean for investor-ready templates and structure. Pitch for team-collaborated decks. Gamma for fast iteration on a thesis. Avoid generic templates that scream startup-101 - investors see them daily."}
  ]'::jsonb,
  'productivity',
  'beginner',
  4400,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
)

ON CONFLICT (slug) DO UPDATE SET
  title                 = EXCLUDED.title,
  emoji                 = EXCLUDED.emoji,
  primary_tags          = EXCLUDED.primary_tags,
  picked_slugs          = EXCLUDED.picked_slugs,
  fallback_min          = EXCLUDED.fallback_min,
  intro                 = EXCLUDED.intro,
  methodology           = EXCLUDED.methodology,
  faqs                  = EXCLUDED.faqs,
  category              = EXCLUDED.category,
  difficulty            = EXCLUDED.difficulty,
  monthly_search_volume = EXCLUDED.monthly_search_volume,
  related_top10_slugs   = EXCLUDED.related_top10_slugs,
  related_use_case_slug = EXCLUDED.related_use_case_slug,
  related_blog_slugs    = EXCLUDED.related_blog_slugs,
  status                = EXCLUDED.status;

-- Verification
SELECT slug, title, status, array_length(picked_slugs, 1) AS pick_count, monthly_search_volume
FROM tasks
WHERE slug LIKE 'ai-for-%'
ORDER BY monthly_search_volume DESC NULLS LAST;
