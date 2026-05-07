-- Phase 0 of Task Taxonomy initiative (S112)
-- 5 demo tasks fully editorial. Each picked_slugs verified to exist in catalog
-- (run scripts/check-task-mappability.mjs to re-verify).
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- 1. ai-for-cold-emails
(
  'ai-for-cold-emails',
  'AI for Cold Emails',
  '✉️',
  ARRAY['crm-sales', 'seo-marketing', 'ai-assistants'],
  ARRAY['lavender', 'lemlist', 'smartlead', 'reply-io'],
  3,
  'Cold email outreach lives or dies on three things: deliverability, personalization at scale, and reply rate. The right AI tool turns generic blasts into one-to-one threads that actually book meetings - while keeping you off spam blocklists. We tested four cold-email AI platforms in real outbound campaigns. Lavender wins for solo SDRs who write inside Gmail. Lemlist wins for small teams running multi-channel sequences. Smartlead and Reply.io scale to enterprise volume with tighter deliverability controls.',
  'We weighted four signals when ranking these tools: (1) AI personalization quality - does the suggested rewrite actually match the prospect, or does it just paraphrase the original? (2) Deliverability infrastructure - inbox rotation, warm-up, spam-pattern detection. (3) CRM sync - does it round-trip with HubSpot or Salesforce, or is it a silo? (4) Pricing transparency - how the free tier compares to paid for actual sending volume.',
  '[
    {"q":"Are cold email AI tools allowed under GDPR and CAN-SPAM?","a":"They can be, but only if you handle consent and unsubscribe correctly. The tool itself does not exempt you - you still need a legitimate basis (B2B legitimate interest in EU, opt-out compliance in US), accurate sender info, and one-click unsubscribe in every send."},
    {"q":"Can free tiers actually send cold emails at scale?","a":"No. Free tiers from Lavender (Chrome extension only) and Lemlist (10 sends/mo) are for testing, not production. Plan for $39-79/seat/mo once you commit to outbound."},
    {"q":"Will AI-generated cold emails get me banned?","a":"AI authorship is not the issue - bad personalization, bad lists, and bad deliverability hygiene are. Tools like Lavender score readability and risk flags before send to keep you in the inbox."},
    {"q":"What is the difference between Lavender and Lemlist?","a":"Lavender is a writing copilot that grades your email in real time inside Gmail/Outlook - it does not send. Lemlist is a full sequencing platform with AI personalization, multi-channel steps, and warm-up baked in."}
  ]'::jsonb,
  'sales',
  'beginner',
  2400,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 2. ai-for-meeting-summaries
(
  'ai-for-meeting-summaries',
  'AI for Meeting Summaries',
  '📝',
  ARRAY['meeting-tools', 'voice-audio', 'productivity'],
  ARRAY['fathom', 'fireflies-ai', 'otter-ai', 'grain', 'sembly-ai'],
  3,
  'Sitting through a meeting is one thing. Re-watching it to find the one decision that actually matters is another. AI meeting summarizers join Zoom, Google Meet, or Teams, transcribe in real time, and ship a structured recap with action items, decisions, and a searchable timeline - usually before you finish your coffee. Fathom leads for a generous free plan and clean UI. Fireflies and Otter dominate at team scale with deep CRM and Slack integrations. Grain wins for sales teams that need clip-and-share moments. Sembly fits multilingual teams.',
  'Selection focused on five signals specific to this task: (1) Transcription accuracy on accented and overlapping speech. (2) Summary quality - does it surface real decisions or just regurgitate filler? (3) Native integrations with Slack, Notion, Salesforce, HubSpot. (4) Pricing model - per-host vs per-meeting vs unlimited. (5) Free tier limits that are genuinely useful, not just teasers.',
  '[
    {"q":"Do these tools work with Zoom, Google Meet, AND Microsoft Teams?","a":"Fathom, Fireflies, Otter, and Sembly all support the big three. Grain is Zoom-first; Teams/Meet support is newer and slightly less polished."},
    {"q":"What about privacy and consent?","a":"All five offer notification banners that announce recording. Some jurisdictions (EU, California, two-party consent US states) require explicit verbal consent at the start. Configure auto-notification in settings before deploying team-wide."},
    {"q":"Will my IT team approve these?","a":"Fireflies, Otter, and Sembly have SOC 2 Type II reports and support SSO. Fathom and Grain are working toward parity. Ask for the latest report before procurement."},
    {"q":"Is the free plan enough for a solo founder?","a":"Yes - Fathom unlimited free for individuals is the strongest free tier in this category. Fireflies and Otter free tiers cap minutes per month."}
  ]'::jsonb,
  'productivity',
  'beginner',
  3300,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 3. ai-for-blog-outlines
(
  'ai-for-blog-outlines',
  'AI for Blog Outlines',
  '📋',
  ARRAY['writing-ai', 'seo-marketing'],
  ARRAY['surfer-seo', 'jasper', 'frase', 'neuronwriter', 'copy-ai'],
  3,
  'A blog post that ranks starts with an outline that matches search intent - not a brain dump that sprawls into seven sub-topics nobody searches for. AI outline tools take a target keyword, scan the top-ranking pages, and propose a structure built from the headings, questions, and entities Google already rewards. Surfer SEO leads for serious SEO teams with NLP-driven outlines. Jasper wins for marketing teams that need outline + draft + brand voice in one tool. Frase and NeuronWriter compete on price and SERP-driven research. Copy.ai is the budget pick for solo creators.',
  'We ranked on four signals tuned to outline quality, not full-draft generation: (1) SERP analysis depth - how thoroughly the tool studies the top 10 results. (2) Heading suggestions - does it propose the H2/H3 hierarchy or just give you a list of topics? (3) Question and entity extraction from People Also Ask and AI Overviews. (4) Price-per-outline at typical solo or small-team usage.',
  '[
    {"q":"Is using AI for outlines considered cheating in Google''s eyes?","a":"No. Google''s spam policy targets unhelpful auto-generated content at scale, not AI-assisted research or structuring. Outline tools that synthesize SERP data are squarely in the helpful-AI zone."},
    {"q":"Can I just paste the keyword into ChatGPT instead?","a":"You can, but ChatGPT alone does not see the live SERP. Surfer, Frase, and NeuronWriter pull current top-10 page structures - that is the entire moat for outline quality."},
    {"q":"What is the difference between Surfer SEO and Jasper?","a":"Surfer is SEO-first - its outlines are ranked by topical coverage and NLP density. Jasper is marketing-first - its outlines are integrated with brand voice, draft generation, and team collaboration. Pick by which workflow you value more."},
    {"q":"Do these tools also write the full post?","a":"All five do, but outline mode is what they excel at. The full draft step still needs human editing for facts, voice, and originality."}
  ]'::jsonb,
  'writing',
  'beginner',
  1900,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 4. ai-for-invoice-ocr
(
  'ai-for-invoice-ocr',
  'AI for Invoice OCR and AP Automation',
  '🧾',
  ARRAY['finance', 'productivity'],
  ARRAY['stampli', 'tipalti', 'vic-ai', 'ramp', 'docyt'],
  3,
  'Invoice processing is the unglamorous backbone of finance ops. Manual data entry, three-way matching, GL coding, and approval routing eats hours every week - and one transposed digit becomes a duplicate payment. AI OCR plus accounts-payable automation reads invoices end-to-end, codes them, routes for approval, and posts to your ERP. Stampli wins on collaboration UX. Tipalti leads for global multi-currency payouts. Vic.ai pushes furthest on autonomous coding accuracy. Ramp bundles AP into a corporate-card platform that is free at base tier. Docyt suits service businesses with high transaction volume.',
  'We weighed: (1) OCR accuracy on messy real-world invoices (handwritten notes, tables, multi-page). (2) Auto-coding to GL accounts using historical patterns. (3) ERP integrations - QuickBooks, NetSuite, Sage Intacct, Microsoft Dynamics. (4) Approval workflow flexibility - escalation rules, mobile approvals, audit trail. (5) Total cost including transaction fees, not just per-seat pricing.',
  '[
    {"q":"How accurate is AI OCR on real invoices today?","a":"Top tools hit 95-98% header accuracy and 90%+ on line items for clean PDFs. Handwritten or photographed invoices drop accuracy by 10-15%. Plan for an exception queue, not zero-touch processing."},
    {"q":"Will this work with QuickBooks Online?","a":"Stampli, Vic.ai, and Docyt all integrate natively. Tipalti supports QBO too. Ramp''s AP module syncs to QBO and Xero. Verify the integration covers your specific GL coding edge cases."},
    {"q":"What does this actually cost?","a":"Stampli starts mid-three-figures per month. Tipalti includes per-payment fees on top of platform fees. Ramp''s AP module is free at the base tier (revenue from card interchange and FX margin). Vic.ai is enterprise-priced - expect a sales conversation."},
    {"q":"Is this overkill for a 10-person company?","a":"Yes, often. Below ~50 invoices per month, manual processing in QuickBooks plus a receipt-capture tool like Hubdoc or Dext is usually cheaper. Reassess at 100+ invoices monthly or when AP becomes a bottleneck."}
  ]'::jsonb,
  'finance',
  'intermediate',
  720,
  ARRAY[]::text[],
  NULL,
  ARRAY[]::text[],
  'published'
),

-- 5. ai-for-customer-support
(
  'ai-for-customer-support',
  'AI for Customer Support',
  '🎧',
  ARRAY['customer-service', 'ai-assistants'],
  ARRAY['intercom', 'gorgias', 'gladly', 'forethought', 'freshchat'],
  3,
  'Modern customer support is a deflection problem. Most tickets are repeat questions that an AI agent can answer instantly - if it has the right knowledge base and clean handoff to a human when stuck. The five tools below ship AI-first support: live chat plus an autonomous bot trained on your help center. Intercom''s Fin agent leads in deflection rate and is the de-facto choice for B2B SaaS. Gorgias dominates Shopify and Klaviyo-stack ecommerce. Gladly is the premium pick for high-touch consumer brands. Forethought specializes in deflecting complex tickets via routing. Freshchat is the budget Intercom alternative for smaller teams.',
  'Weighting reflects what matters to support leaders today: (1) Autonomous AI agent quality - measured by deflection rate (% of tickets solved without a human). (2) Knowledge-base ingestion - how easily the agent indexes Notion, Help Scout articles, internal wikis. (3) Handoff to human - graceful, context-preserving, with conversation history. (4) Channel coverage - email, web chat, WhatsApp, Instagram, SMS. (5) Pricing model - resolution-based vs seat-based vs hybrid.',
  '[
    {"q":"What is a realistic deflection rate on day one?","a":"Industry benchmark is 25-45% on common questions if your knowledge base is clean. Vendors marketing 70%+ usually count assisted-resolution alongside fully-autonomous - read the fine print."},
    {"q":"Is Fin (Intercom) better than Gorgias for ecommerce?","a":"Gorgias is purpose-built for Shopify with native order-context surfacing - that alone is decisive for ecom teams. Fin wins for SaaS where the question is about product behavior, not order status."},
    {"q":"Will the AI hallucinate answers about refunds or warranties?","a":"It can, and that is the highest risk. Set strict scope (only answer from approved KB articles), and route any policy/refund question to a human by default. Test with adversarial questions before going live."},
    {"q":"Resolution-based pricing - good or bad for me?","a":"Good if your AI deflection rate is solid (30%+) and your ticket volume is predictable. Bad if you have spiky volume or low deflection - costs become unpredictable. Get a 30-day pilot with a usage cap before signing annual."}
  ]'::jsonb,
  'support',
  'intermediate',
  4800,
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
