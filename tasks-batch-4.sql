-- Phase 1 batch 4 of Task Taxonomy initiative (S115)
-- 11 head-term tasks. Each picked_slugs verified via scripts/verify-batch-4-candidates.mjs.
-- Phase 1 progress: 42 -> 53 tasks (106% of 50-target - EXCEEDS Phase 1 commitment).
-- Source: backup queue (8) + fresh broadening ideas (3 supplemental).
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- 1. ai-for-image-generation
(
  'ai-for-image-generation',
  'AI for Image Generation',
  '🎨',
  ARRAY['image-ai'],
  ARRAY['midjourney', 'flux', 'leonardo-ai', 'ideogram', 'stable-diffusion'],
  3,
  'Text-to-image quality crossed the photorealism threshold in 2024 and the new battle is control: typography, brand consistency, and editable composition. Midjourney still leads on raw aesthetic for hero art and mood boards. FLUX from Black Forest Labs is the new open-weights contender that beats Midjourney on photo realism in blind tests. Leonardo.ai and Ideogram cover the production workflow with brand assets, typography, and team management. Stable Diffusion remains the open-source workhorse for anyone running their own pipeline.',
  'We weighted: (1) Image quality on faces, hands, and typography (the hard cases). (2) Style consistency across a 20-image campaign. (3) Editing controls - inpainting, outpainting, layered composition. (4) Prompt-to-render speed for iteration loops. (5) Commercial license clarity at the output level (training data is a separate question).',
  '[
    {"q":"Midjourney vs FLUX in 2026?","a":"Midjourney wins on stylized aesthetic and brand-friendly defaults. FLUX wins on photorealism, prompt adherence, and self-host options. Most studios use both - Midjourney for moodboards, FLUX for hero shots."},
    {"q":"Can I use AI images commercially?","a":"All five permit commercial use of outputs, but training data lawsuits are ongoing. For risk-averse production (ad campaigns, packaging), check each tool indemnity clause and consider Adobe Firefly which offers explicit indemnification."},
    {"q":"Leonardo vs Ideogram for design teams?","a":"Leonardo has stronger asset-management and team workflows. Ideogram leads on typography (the only one that consistently renders readable in-image text). Pick Ideogram if your work needs rendered words; Leonardo otherwise."},
    {"q":"Is Stable Diffusion still relevant?","a":"For anyone running their own infrastructure - yes, SD plus ComfyUI or Automatic1111 gives total control and zero per-image cost. For non-technical users, hosted tools remove an entire category of pain."}
  ]'::jsonb,
  'design', 'beginner', 9900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-transcription
(
  'ai-for-transcription',
  'AI for Transcription',
  '🎙️',
  ARRAY['voice-audio', 'productivity'],
  ARRAY['descript', 'fireflies-ai', 'otter-ai', 'notta', 'tactiq'],
  3,
  'Manual transcription died around 2022 - the question now is which AI transcription tool fits your workflow without extra steps. Descript leads as the audio-and-video editor where transcription is one feature among many - edit text, video edits. Fireflies.ai is the meeting-recording specialist with deep CRM integration. Otter.ai remains the standalone live-transcription default with the most generous free tier. Notta covers global teams with strong multilingual transcription. Tactiq is the lightweight Chrome-extension layer over Google Meet and Zoom.',
  'Selection focused on: (1) Word error rate on accented English, technical jargon, and noisy audio. (2) Speaker diarization (who said what) accuracy at 4+ speakers. (3) Edit-the-text-edits-the-audio workflows (Descript flagship). (4) Native integration with Zoom, Google Meet, Teams without separate bot. (5) Pricing for daily users - hours-per-month limits often quietly cap value.',
  '[
    {"q":"Descript vs Otter for podcasters?","a":"Descript wins for podcasters - text-based audio editing is a category-defining workflow. Otter is for live note-taking, not editing. Every podcaster who tries Descript moves over within a season."},
    {"q":"Fireflies vs tl;dv vs Fathom?","a":"Fireflies has the deepest CRM integration (Salesforce, HubSpot logging). Fathom (separate task page) is free unlimited 1:1 with cleaner UX. tl;dv is between them. For sales teams, Fireflies; for solo professionals, Fathom."},
    {"q":"How accurate is multilingual?","a":"English is best across all five (95%+ on clean audio). Notta and Otter handle 30+ languages reasonably; technical accuracy drops outside top-10 languages. Verify samples on your specific accents before committing."},
    {"q":"Will AI transcription replace stenographers?","a":"For court-grade verbatim transcripts, no - human stenographers still set the legal standard. For everyday meetings, podcasts, and interviews, AI is good enough and 100x cheaper."}
  ]'::jsonb,
  'productivity', 'beginner', 5400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-marketing-automation
(
  'ai-for-marketing-automation',
  'AI for Marketing Automation',
  '🚀',
  ARRAY['marketing', 'email-marketing'],
  ARRAY['hubspot', 'klaviyo', 'activecampaign'],
  3,
  'Marketing automation in 2026 is no longer just trigger-action email - AI now decides who gets which message, when, and through which channel based on real-time behavior. HubSpot leads as the all-in-one CRM-plus-marketing platform with AI baked into every workflow. Klaviyo dominates ecommerce with Shopify-native AI flows tied to customer LTV. ActiveCampaign is the SMB-friendly automation specialist that punches above its price tier with strong AI segmentation.',
  'We weighted: (1) AI segment generation - does it find audiences you would not have thought of? (2) Send-time and channel optimization per recipient. (3) Native CRM and revenue attribution (not bolted-on). (4) Multi-channel - email, SMS, push, in-app in one workflow. (5) Pricing scaling - per-contact pricing breaks badly for some teams above 50k contacts.',
  '[
    {"q":"HubSpot vs Klaviyo for ecommerce?","a":"Klaviyo - it is purpose-built for Shopify with revenue-attribution AI flows that HubSpot does not match. HubSpot wins for B2B SaaS with complex deal pipelines."},
    {"q":"ActiveCampaign vs Mailchimp in 2026?","a":"ActiveCampaign has materially stronger automation, AI segmentation, and CRM features. Mailchimp is simpler for newsletter-only senders. For any team beyond pure newsletter, ActiveCampaign wins."},
    {"q":"Does AI actually lift conversion?","a":"AI send-time optimization lifts opens 5-15%. AI subject-line optimization lifts opens 5-10%. AI segment generation lifts revenue per send 10-25% on lists above 10k subscribers. Compounded, these are real numbers."},
    {"q":"What about Marketo or Eloqua?","a":"Both are enterprise-grade platforms (5,000+ contacts, dedicated team). For teams below that scale they are overkill - ActiveCampaign or HubSpot fits 95% of mid-market needs at half the price."}
  ]'::jsonb,
  'marketing', 'intermediate', 4400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-blog-writing
(
  'ai-for-blog-writing',
  'AI for Blog Writing',
  '✍️',
  ARRAY['writing-ai'],
  ARRAY['jasper', 'copy-ai', 'writesonic', 'scalenut', 'anyword'],
  3,
  'Writing a 2,000-word blog post used to take 4-6 hours of research, drafting, and editing. AI blog writing tools compress that to 60-90 minutes by handling outline, first draft, and SEO optimization while leaving the editorial voice to you. Jasper leads on brand voice consistency across long-form. Copy.ai is the entry-level pick with a generous free tier. Writesonic and Scalenut bundle SEO research into the writing workflow. Anyword adds predictive performance scoring per paragraph for conversion-focused content.',
  'Selection focused on: (1) Long-form quality at 1,500+ words without going off-topic. (2) Brand voice memory across multiple posts in the same series. (3) SEO integration - keyword research and on-page optimization in one pass. (4) Outline generation that matches what actually ranks. (5) Editorial workflow - revisions, fact-checking prompts, and human handoff steps.',
  '[
    {"q":"Will AI-written blogs hurt my SEO?","a":"No - Google ranks helpful, accurate content regardless of authorship. AI penalty risk comes from generic, low-effort, fact-thin content. Add real expertise, examples, and proof to AI drafts before publishing."},
    {"q":"Jasper vs ChatGPT for blogs?","a":"Jasper has brand-voice persistence across posts, SEO integration, and team workflows that ChatGPT lacks. ChatGPT is more flexible per-prompt and free at the entry tier. For pro content teams, Jasper; for solo writers, ChatGPT plus Surfer SEO is enough."},
    {"q":"Scalenut vs Surfer SEO for blog ranking?","a":"Scalenut bundles AI writing with SEO scoring in one workflow. Surfer is SEO-only and pairs with any AI writer. For all-in-one, Scalenut; for best-of-breed flexibility, Surfer plus Jasper or Copy.ai."},
    {"q":"How much human editing does AI need?","a":"Plan 30-50% of total time for human editing - fact-checking, voice tightening, examples, and originality. AI cuts the writing-from-scratch tax; it does not eliminate editorial work."}
  ]'::jsonb,
  'writing', 'beginner', 3600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 5. ai-for-image-editing
(
  'ai-for-image-editing',
  'AI for Image Editing',
  '🖼️',
  ARRAY['image-ai'],
  ARRAY['runway', 'photoroom', 'picsart', 'magnific', 'remove-bg'],
  3,
  'Image editing in 2026 is no longer Photoshop-or-bust - AI tools now handle background removal, upscaling, object removal, and style transfer in seconds without a 600-page manual. Runway leads on creative AI editing with industry-grade video and image tools. PhotoRoom is the ecommerce specialist for product shots and bulk batch edits. Picsart is the consumer-friendly all-rounder with strong mobile UX. Magnific is the new upscaling king with photorealistic detail enhancement. Remove.bg remains the simple-but-essential one-trick utility for clean cutouts.',
  'We weighted: (1) Background removal accuracy on hair, glass, and complex edges. (2) Upscaling quality at 4x and 8x without artifacting. (3) Generative fill and object removal believability. (4) Bulk processing for ecommerce catalogs. (5) Free tier - per-image limits that quietly throttle real workflows.',
  '[
    {"q":"PhotoRoom vs Adobe Firefly for ecommerce?","a":"PhotoRoom is purpose-built for product shots with bulk and brand templates. Firefly is broader but slower for high-volume ecommerce workflows. For 100+ SKUs/month, PhotoRoom; for occasional creative work, Firefly."},
    {"q":"Magnific vs Topaz Photo AI for upscaling?","a":"Magnific produces more photorealistic detail at high upscale ratios but can hallucinate. Topaz is more conservative and predictable. For artistic enhancement, Magnific; for archival restoration, Topaz."},
    {"q":"Is Remove.bg still needed when Photoshop has Object Selection?","a":"For one-off use, Photoshop is fine. For batch (50+ images), browser-based Remove.bg is faster and more consistent. For ecommerce, PhotoRoom replaces both with stronger workflow."},
    {"q":"Can these replace a designer?","a":"For repetitive utility work (background removal, upscaling, simple touch-ups), yes - and most designers welcome that. For creative composition, brand identity, and judgment calls, the tools augment but do not replace skilled humans."}
  ]'::jsonb,
  'design', 'beginner', 3600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 6. ai-for-voice-assistants
(
  'ai-for-voice-assistants',
  'AI for Voice Assistants',
  '🗣️',
  ARRAY['voice-audio', 'ai-assistants'],
  ARRAY['vapi', 'bland-ai', 'voiceflow'],
  3,
  'Voice AI moved from skill-toy to production in 2024-2025 - latency dropped under 800ms, voice quality crossed the uncanny threshold, and tool-use let agents handle real workflows. Vapi leads as the developer platform for building voice agents with any LLM and any voice. Bland.ai is the all-in-one alternative with built-in phone number provisioning and CRM integration. Voiceflow is the design-first conversational AI platform for non-developers.',
  'Selection focused on: (1) End-to-end latency on real phone calls, not lab demos. (2) Voice quality and barge-in handling for natural turn-taking. (3) Tool-use reliability - calendar booking, CRM updates, payment processing. (4) Telephony integration (SIP, Twilio, native PSTN). (5) Pricing per-minute - the difference between $0.05 and $0.15/min compounds fast at scale.',
  '[
    {"q":"Vapi vs Bland.ai for cold-call automation?","a":"Vapi gives more developer control and broader LLM choice. Bland.ai bundles phone numbers and is faster to ship for non-technical teams. Both are credible; pick Vapi if you have a dev team, Bland if you do not."},
    {"q":"Voiceflow vs ChatGPT voice mode?","a":"Different products. Voiceflow is for building deployable voice agents (call centers, IVR, in-app). ChatGPT voice is a personal assistant. For business voice automation, Voiceflow or Vapi - not ChatGPT."},
    {"q":"Will voice AI replace call-center agents?","a":"For tier-1 work (FAQ, status checks, order tracking) - yes, already happens. For empathy-heavy and ambiguous cases, AI escalates. Realistic 2026 outcome is hybrid: AI handles 40-60% of call volume, humans handle the rest with better tools."},
    {"q":"How much does it cost per call?","a":"Voice-out plus voice-in plus LLM costs land around $0.10-0.30/minute depending on stack. A 5-minute service call is $0.50-1.50 vs $5-15 for a human agent. The economics work above 1,000 calls/month."}
  ]'::jsonb,
  'dev', 'advanced', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-customer-onboarding
(
  'ai-for-customer-onboarding',
  'AI for Customer Onboarding',
  '🎯',
  ARRAY['ai-assistants', 'productivity'],
  ARRAY['userpilot', 'pendo', 'intercom'],
  3,
  'New users churn fastest in the first 7 days - and the team that ships the cleanest onboarding wins activation. AI customer onboarding tools personalize tours, surface help at the right moment, and adapt the path based on user behavior in real time. Userpilot leads on no-code in-app onboarding flows with strong AI personalization. Pendo bundles onboarding with product analytics for data-driven iteration. Intercom adds a chat-and-AI-bot layer that catches drop-off before it happens.',
  'We weighted: (1) No-code editor for product, marketing, and CS teams to ship without engineering. (2) AI personalization - does the path adapt by role, plan, or behavior? (3) Analytics to measure activation lift, not just completion rate. (4) Integration with product event streams (Segment, Amplitude). (5) Pricing for SaaS at 10k MAU - per-MAU pricing scales fast.',
  '[
    {"q":"Userpilot vs Pendo - which is right for me?","a":"Userpilot is more affordable and faster to ship for SMB and mid-market SaaS. Pendo is enterprise-grade with stronger analytics and roadmapping. For sub-50-person SaaS teams, Userpilot; for enterprise, Pendo."},
    {"q":"Is Intercom enough for onboarding?","a":"For chat-based onboarding (welcome bot, FAQ deflection), yes - Intercom is purpose-built for this. For interactive product tours and guided flows, you still need Userpilot or Pendo layered on top."},
    {"q":"Does AI personalization actually lift activation?","a":"Yes - segment-aware paths lift 7-day activation 15-30% in published case studies. The lift comes from showing role-relevant features first, not from AI per se. AI just makes segmentation tractable."},
    {"q":"Can my engineering team build this in-house?","a":"Yes, but a basic onboarding tour costs 4-6 engineering weeks plus ongoing maintenance. Userpilot ships the same in 2-3 days for marketing or CS team. Make-vs-buy clearly favors buy below Series C."}
  ]'::jsonb,
  'customer-success', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 8. ai-for-sql-generation
(
  'ai-for-sql-generation',
  'AI for SQL Generation',
  '🔧',
  ARRAY['code-ai', 'data-analytics'],
  ARRAY['julius-ai', 'formula-bot', 'akkio', 'seek-ai', 'outerbase'],
  3,
  'Text-to-SQL crossed the production reliability threshold in 2025 - business users now ask plain-English questions and get correct queries against real warehouses. Julius.ai leads on conversational data analysis with strong dialect handling. Formula Bot covers spreadsheet-meets-SQL for analysts living in Sheets and Excel. Akkio adds predictive ML on top of SQL queries for forecasting. Seek.ai and Outerbase are the SQL-native query builders with AI assist for engineering and data teams.',
  'Selection focused on: (1) SQL accuracy on complex schemas (10+ tables, joins, window functions). (2) Dialect support (Postgres, BigQuery, Snowflake, MySQL, SQLite). (3) Visualization output - charts and pivot tables on top of generated queries. (4) Schema auto-discovery - does it understand your warehouse without manual DDL? (5) Self-host or VPC deploy for sensitive data.',
  '[
    {"q":"Julius vs ChatGPT Code Interpreter for SQL?","a":"Julius is purpose-built for analytical workflows with persistent sessions and clearer chart output. Code Interpreter is more flexible for one-off ad-hoc analysis. For daily analyst use, Julius; for occasional, ChatGPT."},
    {"q":"Will SQL fluency become obsolete?","a":"For ad-hoc analysis - increasingly yes. For data engineering, query optimization, schema design, governance - no. SQL fluency shifts from typing to architecture."},
    {"q":"How does Seek.ai differ from Looker?","a":"Looker is a full BI platform with semantic layer (LookML). Seek is a leaner SQL-and-chart layer with AI query generation. Seek wins for fast self-service; Looker for governed enterprise reporting."},
    {"q":"Can AI handle PII safely?","a":"All five include access controls and most support row-level security. AI does not magically respect PII rules - your warehouse permissions still gate access. Layer governance accordingly."}
  ]'::jsonb,
  'data-analytics', 'intermediate', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 9. ai-for-prototyping
(
  'ai-for-prototyping',
  'AI for Prototyping',
  '⚡',
  ARRAY['design', 'code-ai'],
  ARRAY['v0', 'uizard', 'galileo-ai', 'visily', 'relume'],
  3,
  'Prototyping went from days-of-Figma to minutes-of-prompting in 2024-2025. v0 by Vercel leads as the React-and-Tailwind generator that ships production-ready components. Uizard converts hand-drawn sketches to clickable mockups in seconds. Galileo AI generates editable Figma designs from text prompts. Visily handles wireframes for non-designers and PMs. Relume builds full Webflow-ready component libraries from sitemaps.',
  'We weighted: (1) Output quality - generated UI looks production-grade, not toy. (2) Editability - can a designer take it to Figma and finish? (3) Code export quality (React, Vue, raw HTML, Webflow). (4) Speed from prompt to clickable prototype. (5) Pricing for design teams of 3-10 with daily use.',
  '[
    {"q":"v0 vs Cursor for prototyping?","a":"v0 ships ready-to-render React components. Cursor is a coding IDE with AI agent. For UI-first prototypes, v0; for full app builds, Cursor. They stack well together."},
    {"q":"Uizard vs Figma AI?","a":"Uizard converts sketches and wireframes faster. Figma AI is integrated into the design tool you already use. For quick concept validation, Uizard; for ongoing design work, Figma AI."},
    {"q":"Can AI replace UX designers?","a":"For fast first drafts and component generation - yes, AI is faster. For research, judgment, accessibility, and brand cohesion, designers still own the work. The role shifts toward orchestration and review."},
    {"q":"Galileo vs Visily for non-designers?","a":"Visily is gentler with templates and wireframe-first UX. Galileo outputs higher-fidelity Figma files. PMs and founders typically prefer Visily; designers prefer Galileo."}
  ]'::jsonb,
  'design', 'intermediate', 1600,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-product-research
(
  'ai-for-product-research',
  'AI for Product Research',
  '🔎',
  ARRAY['research'],
  ARRAY['dovetail', 'maze', 'sprig', 'typeform', 'lookback'],
  3,
  'Product research used to mean Friday night reading 200 user interview transcripts. AI product research tools cluster, theme, and surface the top signals across studies in minutes. Dovetail leads as the research repository where insights from many studies live searchable across years. Maze handles unmoderated usability testing with AI session analysis. Sprig is the in-product survey specialist for SaaS feedback loops. Typeform covers the broader survey collection layer. Lookback is the moderated user-interview platform with AI transcript analysis.',
  'Selection focused on: (1) Cross-study search - can I find that one quote from three years ago? (2) AI clustering quality across long-text feedback. (3) In-product targeting (Sprig flagship) vs email-only. (4) Video and session-replay analysis depth. (5) Integration with product event streams for behavior-plus-feedback joins.',
  '[
    {"q":"Dovetail vs Notion for research repo?","a":"Dovetail is purpose-built with tagging, AI clustering, and stakeholder views. Notion is general but lacks research-specific UX. For 5+ studies in flight, Dovetail saves 5-10 hours per week vs Notion."},
    {"q":"Maze vs UserTesting?","a":"Maze is unmoderated, fast, and cheaper - good for prototype testing and quick validations. UserTesting (not in our top 5) is moderated, slower, and pricier - good for deep qual sessions."},
    {"q":"Do I need both Sprig and Typeform?","a":"If you only do email surveys, Typeform alone. If you have a SaaS product, Sprig in-product surveys catch users in context where Typeform email surveys see 5-10x lower response rates."},
    {"q":"Can AI replace a UX researcher?","a":"For volume triage (clustering 1,000 quotes, surfacing themes) - yes, AI saves days. For nuanced interpretation, follow-up question design, and stakeholder synthesis, real researchers still win. AI is the accelerant."}
  ]'::jsonb,
  'research', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 11. ai-for-content-repurposing
(
  'ai-for-content-repurposing',
  'AI for Content Repurposing',
  '♻️',
  ARRAY['video-ai', 'social-media'],
  ARRAY['descript', 'opus-clip', 'castmagic', 'swell-ai', 'repurpose-io'],
  3,
  'A 60-minute podcast contains 30+ social posts, 10 short-form clips, a blog summary, and a newsletter draft. AI content repurposing tools turn one long-form asset into a full week of derivative content automatically. Descript leads as the audio-and-video editor with built-in repurposing flows. Opus Clip is the short-form clip generator that picks viral moments from long videos. Castmagic transforms podcast audio into 30+ written assets in one pass. Swell AI handles the podcast-to-blog pipeline. Repurpose.io covers the cross-platform distribution layer.',
  'We weighted: (1) Quality of generated derivatives - usable as-is vs requires heavy editing. (2) Source-format breadth (audio, video, webinar, blog, transcript). (3) Platform coverage for distribution (TikTok, IG Reels, YouTube Shorts, X, LinkedIn). (4) Brand voice consistency across derivatives. (5) Pricing per long-form asset processed.',
  '[
    {"q":"Opus Clip vs Descript for podcast clips?","a":"Opus Clip is purpose-built for finding viral moments and auto-generating captioned shorts. Descript gives more editorial control but takes longer. For volume, Opus; for craft, Descript."},
    {"q":"Castmagic vs Swell AI for podcast-to-blog?","a":"Castmagic outputs more asset types (30+ formats including social, blog, newsletter, show notes). Swell AI is more focused on long-form blog quality. For volume, Castmagic; for SEO blogs specifically, Swell."},
    {"q":"Will AI clips actually go viral?","a":"AI catches the right moments roughly 60% of the time - the other 40% need human judgment. Treat AI output as a shortlist of candidates, not a publish-and-forget pipeline."},
    {"q":"Repurpose.io vs Buffer?","a":"Repurpose.io specializes in cross-posting and format conversion (vertical video to square, etc.). Buffer is a general scheduler. For podcast-and-video creators, Repurpose; for general scheduling, Buffer."}
  ]'::jsonb,
  'productivity', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
)

ON CONFLICT (slug) DO UPDATE SET
  title = EXCLUDED.title,
  emoji = EXCLUDED.emoji,
  primary_tags = EXCLUDED.primary_tags,
  picked_slugs = EXCLUDED.picked_slugs,
  fallback_min = EXCLUDED.fallback_min,
  intro = EXCLUDED.intro,
  methodology = EXCLUDED.methodology,
  faqs = EXCLUDED.faqs,
  category = EXCLUDED.category,
  difficulty = EXCLUDED.difficulty,
  monthly_search_volume = EXCLUDED.monthly_search_volume,
  related_top10_slugs = EXCLUDED.related_top10_slugs,
  related_use_case_slug = EXCLUDED.related_use_case_slug,
  related_blog_slugs = EXCLUDED.related_blog_slugs,
  status = EXCLUDED.status,
  updated_at = NOW();
