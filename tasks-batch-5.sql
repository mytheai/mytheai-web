-- Phase 2 batch 1 of Task Taxonomy initiative (S116)
-- 41 mid-tail tasks. Tier-A editorial cadence (3-sentence intro + 1-sentence
-- methodology + 3 FAQs per plan §6). All picked_slugs verified in catalog
-- (run scripts/verify-batch-5-candidates.mjs to re-verify).
-- Phase 2 progress: 53 -> 94 tasks (47% of 200-target).
-- HR-recruiting category opens (job-postings + recruiting) - 13 of 13 covered.
-- Idempotent: ON CONFLICT DO UPDATE; safe to re-run.

INSERT INTO tasks (
  slug, title, emoji, primary_tags, picked_slugs, fallback_min,
  intro, methodology, faqs, category, difficulty, monthly_search_volume,
  related_top10_slugs, related_use_case_slug, related_blog_slugs, status
) VALUES

-- 1. ai-for-cover-letters
(
  'ai-for-cover-letters', 'AI for Cover Letters', '📨',
  ARRAY['writing-ai'], ARRAY['grammarly','jasper','copy-ai','quillbot','writesonic'], 3,
  'A custom cover letter still beats a generic one in 2026 - it just no longer requires 90 minutes of staring at a blank page. AI cover letter tools take a job description plus your resume and output a tailored opening, body, and close in under two minutes. Grammarly leads with the writing-suite all-rounder; Jasper and Copy.ai are stronger for tone control; QuillBot adds paraphrasing for multiple variants per role.',
  'We weighted: tone matching to industry (formal vs casual), keyword pickup from the job description, length control (250-350 words), and free tier limits.',
  '[
    {"q":"Will employers detect AI-written cover letters?","a":"Detection tools are unreliable; what employers actually catch is generic, off-brand, or off-topic copy. AI plus 5-minute personal edit beats a rushed human-written letter."},
    {"q":"Should I use one template across many applications?","a":"No - rewrite the opening and middle for each role. AI makes per-role customization fast enough that a generic template is no longer worth the time saved."},
    {"q":"Grammarly vs Jasper for cover letters?","a":"Grammarly polishes what you write. Jasper drafts from scratch. For your first AI-assisted application, start with Grammarly; for volume (10+ applications), Jasper saves more time."}
  ]'::jsonb, 'writing', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 2. ai-for-press-releases
(
  'ai-for-press-releases', 'AI for Press Releases', '📰',
  ARRAY['writing-ai'], ARRAY['jasper','copy-ai','writesonic','anyword','scalenut'], 3,
  'Press releases live or die on the first paragraph - and most fail because the writer buries the news under boilerplate. AI press release tools enforce the inverted-pyramid structure (lead, quote, body, boilerplate) and tune copy for journalist scanability. Jasper and Copy.ai ship strong press release templates; Anyword adds engagement scoring; Scalenut bundles SEO so the release ranks for the brand-name search after distribution.',
  'Selection focused on: PR-specific templates (vs generic blog), quote and stat handling, boilerplate generation, and headline variants for A/B testing.',
  '[
    {"q":"Do journalists ignore AI-written press releases?","a":"They ignore boring releases regardless of authorship. AI helps with structure and clarity; the news angle still has to be real and worth covering."},
    {"q":"Can I publish AI press releases on PR Newswire?","a":"Yes - distribution platforms do not check for AI authorship. Verify facts, quotes, and statistics manually before submitting; AI hallucinates numbers."},
    {"q":"How long should a press release be?","a":"400-600 words is the sweet spot - long enough to cover the angle, short enough that journalists actually read past the lead. AI tools default close to this; trust the suggestion."}
  ]'::jsonb, 'writing', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 3. ai-for-case-studies
(
  'ai-for-case-studies', 'AI for Case Studies', '📈',
  ARRAY['writing-ai'], ARRAY['jasper','copy-ai','writesonic','anyword','scalenut'], 3,
  'A great B2B case study tells the customer-problem-solution-result arc with specific numbers and a memorable quote. AI case study tools take an interview transcript or notes and structure them into a 800-1500 word narrative ready for design polish. Jasper leads on structured long-form; Anyword scores variants for landing-page conversion; Scalenut layers SEO so the case study earns organic traffic for vertical-specific buyer intent.',
  'We weighted: narrative structure (challenge to solution to outcome), quote integration, metric callouts, and SEO-friendly headlines.',
  '[
    {"q":"How long should a case study be?","a":"800-1500 words for the full version, plus a 150-word executive summary for the landing-page card. AI tools can generate both from one source transcript."},
    {"q":"Will customers approve AI-written case studies?","a":"Send the AI draft for customer review like any case study. Approval friction comes from inaccurate quotes or numbers, not authorship - verify both manually."},
    {"q":"Jasper vs Scalenut for case studies?","a":"Jasper for the narrative draft, Scalenut for SEO optimization on the published version. Many teams use both - draft in Jasper, optimize for ranking in Scalenut."}
  ]'::jsonb, 'writing', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 4. ai-for-tweets
(
  'ai-for-tweets', 'AI for Tweets', '🐦',
  ARRAY['writing-ai','social-media'], ARRAY['jasper','typefully','copy-ai','hypefury','taplio'], 3,
  'Twitter/X rewards specific hooks in the first 7 words and rewards repackaged content over original drafts. AI tweet tools generate hooks, thread structures, and quote-tweet variants from a single seed idea or long-form source. Typefully and Hypefury are the X-native specialists with strong analytics; Jasper and Copy.ai handle multi-platform; Taplio bundles X plus LinkedIn for personal-brand operators.',
  'Selection focused on: hook quality in first 280 chars, thread generation from articles, scheduling integration, and engagement analytics.',
  '[
    {"q":"Will AI tweets actually go viral?","a":"AI helps with structure and hook variety, not virality. The viral spike comes from real insight, contrarian opinion, or perfect timing - things the tool cannot fake."},
    {"q":"Typefully vs Hypefury?","a":"Typefully has cleaner UX and better thread tools. Hypefury has stronger automation (auto-retweets, evergreen rotation). Typefully for craft, Hypefury for growth automation."},
    {"q":"Are AI threads penalized by the algorithm?","a":"X does not detect AI authorship directly. Threads are penalized when engagement is low (no replies, no reposts). Quality matters; tool used to draft does not."}
  ]'::jsonb, 'writing', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 5. ai-for-linkedin-posts
(
  'ai-for-linkedin-posts', 'AI for LinkedIn Posts', '💼',
  ARRAY['writing-ai','social-media'], ARRAY['taplio','jasper','copy-ai','hypefury','typefully'], 3,
  'LinkedIn rewards two specific patterns - story-driven personal posts and contrarian-take thought leadership - both of which AI tools have learned to draft well. Taplio leads as the LinkedIn-only specialist with engagement scoring tuned to the algorithm; Jasper and Copy.ai handle multi-platform; Hypefury and Typefully cover X-plus-LinkedIn cross-posting.',
  'We weighted: hook quality (first 3 lines decide truncation), comment-bait closing questions, formatting that survives mobile, and post-engagement scoring.',
  '[
    {"q":"Does LinkedIn penalize AI-written posts?","a":"No, the algorithm does not detect authorship. It penalizes low engagement, link spam, and shallow takes. AI-generated posts that earn comments and dwell time rank fine."},
    {"q":"Taplio vs ContentStudio for LinkedIn?","a":"Taplio is LinkedIn-only with deeper algorithm tuning. ContentStudio covers all platforms with calendar UX. For pure LinkedIn personal-brand operators, Taplio wins."},
    {"q":"How often should I post on LinkedIn?","a":"3-5 times per week is the sustainable cadence. AI tools make daily posting feasible but engagement quality drops past 5/week without genuine substance behind each post."}
  ]'::jsonb, 'writing', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 6. ai-for-instagram-captions
(
  'ai-for-instagram-captions', 'AI for Instagram Captions', '📸',
  ARRAY['writing-ai','social-media'], ARRAY['jasper','copy-ai','predis-ai','writesonic','anyword'], 3,
  'Instagram captions decide whether someone reads past the first line or scrolls past the post entirely. AI caption tools generate hooks, story arcs, and hashtag sets tuned to your niche from a single image or topic prompt. Jasper and Copy.ai handle the writing layer; Predis.ai bundles caption generation with image creation for full post production; Writesonic and Anyword cover budget-tier needs.',
  'We weighted: caption length (110 char hook + body + CTA), hashtag relevance, emoji handling, and image-to-caption pipelines for visual-first content.',
  '[
    {"q":"How many hashtags should I use in 2026?","a":"3-5 hyper-relevant hashtags beat 30 generic ones. AI tools default to 5-8; trim aggressively to your niche before posting."},
    {"q":"Predis.ai vs Canva for Instagram?","a":"Predis.ai generates caption plus image from one prompt. Canva is design-first and pairs with separate AI captioning. For volume, Predis; for design-led brands, Canva."},
    {"q":"Will AI captions trigger spam detection?","a":"Instagram does not flag AI authorship. It flags identical captions across multiple posts, which AI tools sometimes generate - vary openings and CTAs."}
  ]'::jsonb, 'writing', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 7. ai-for-meta-descriptions
(
  'ai-for-meta-descriptions', 'AI for Meta Descriptions', '🏷️',
  ARRAY['writing-ai','seo-marketing'], ARRAY['surfer-seo','jasper','frase','neuronwriter','scalenut'], 3,
  'Meta descriptions are the 155-character pitch that decides whether your search result wins the click - and rewriting 500 of them by hand is the kind of task AI was made for. Surfer SEO leads on bulk meta description optimization tied to SERP analysis. Jasper handles brand-voice consistency; Frase and NeuronWriter add competitive intelligence; Scalenut runs the full SEO content workflow including meta tags.',
  'Selection focused on: bulk processing (200+ pages at once), keyword inclusion without stuffing, brand voice consistency, and CTR-tested patterns from real SERP data.',
  '[
    {"q":"Will Google rewrite my meta description anyway?","a":"Google rewrites about 70% of meta descriptions when the page query does not match the static description. Optimize anyway - the 30% that survive are typically your highest-volume queries."},
    {"q":"Surfer vs Jasper for meta descriptions?","a":"Surfer is SEO-tuned with keyword and SERP analysis. Jasper is brand-voice-tuned. Surfer for ranking, Jasper for consistency across a marketing site."},
    {"q":"How long should meta descriptions be?","a":"150-160 characters fits Google desktop SERPs; mobile cuts at 120. Front-load the key benefit and primary keyword in the first 120 chars."}
  ]'::jsonb, 'writing', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 8. ai-for-tagline-generation
(
  'ai-for-tagline-generation', 'AI for Tagline Generation', '💡',
  ARRAY['writing-ai'], ARRAY['jasper','hypotenuse-ai','copy-ai','writesonic','anyword'], 3,
  'A great tagline compresses a brand promise into 5-8 words that survive memory and design constraints. AI tagline tools generate 30-50 candidates per run from a brand brief, then rank by clarity, distinctiveness, and emotional resonance. Jasper and Copy.ai are the broad-spectrum picks; Hypotenuse.ai is ecommerce-tuned; Writesonic and Anyword cover budget needs with strong variant generation.',
  'We weighted: brevity (5-8 words), distinctiveness check vs competitors, emotional resonance, and brand voice consistency across follow-on copy.',
  '[
    {"q":"Will AI taglines feel generic?","a":"First-pass AI output is generic. The fix is iterative refinement - run 30 candidates, pick the 3 best, prompt for variations of those, then human-edit the winner."},
    {"q":"Can I trademark an AI-generated tagline?","a":"USPTO has begun rejecting purely AI-generated marks; substantial human creative contribution is required. Use AI for ideation, human edit for the final, document the human authorship trail."},
    {"q":"Jasper vs Copy.ai for taglines?","a":"Jasper has stronger brand-voice memory across runs. Copy.ai has a more generous free tier. Both are credible; pick by which your team already uses."}
  ]'::jsonb, 'writing', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 9. ai-for-email-replies
(
  'ai-for-email-replies', 'AI for Email Replies', '📧',
  ARRAY['writing-ai'], ARRAY['grammarly','notion-ai','lavender','jasper','copy-ai'], 3,
  'Inbox triage is the silent productivity tax - and AI email reply tools now draft contextual responses in 2 seconds instead of 2 minutes. Grammarly leads on inline reply suggestions across Gmail, Outlook, and Slack. Notion AI handles long-form replies inside Notion mail. Lavender is sales-specific with reply-rate scoring. Jasper and Copy.ai cover broader writing workflows.',
  'Selection focused on: inline reply UX (no app-switching), tone control (formal vs casual), context awareness from full email thread, and free tier limits for daily volume.',
  '[
    {"q":"Will my recipient detect AI replies?","a":"For routine work emails, no - and they do not care. For relationship-critical replies (apologies, condolences, sensitive negotiations), write your own and use AI only for grammar polish."},
    {"q":"Lavender vs Grammarly?","a":"Lavender is sales-tuned with reply-rate prediction. Grammarly is general writing assistance. For sales reps, Lavender; for everyone else, Grammarly."},
    {"q":"Does Gmail have built-in AI reply now?","a":"Yes - Gmail Smart Reply offers 3 short canned options. Third-party tools handle longer, contextualized replies that Smart Reply does not."}
  ]'::jsonb, 'writing', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 10. ai-for-property-descriptions
(
  'ai-for-property-descriptions', 'AI for Property Descriptions', '🏠',
  ARRAY['writing-ai'], ARRAY['jasper','hypotenuse-ai','copy-ai','writesonic','anyword'], 3,
  'Real estate listings live or die on the description - and writing 50 of them per agent per month burns hours. AI property description tools take MLS attributes (beds, baths, square feet, features) and output benefit-led copy that highlights lifestyle, not just specs. Jasper leads on brand voice; Hypotenuse.ai is built for ecommerce-style bulk descriptions; Copy.ai and Writesonic cover broader needs.',
  'We weighted: MLS attribute parsing, benefit framing (lifestyle over specs), neighborhood and amenity callouts, and word count discipline (200-400 words).',
  '[
    {"q":"Will MLS systems flag AI-written descriptions?","a":"No - MLS rules govern accuracy and disclosure, not authorship. Verify every spec, square footage, and zoning claim manually; AI hallucinates numbers."},
    {"q":"Can AI replace a copywriter for luxury listings?","a":"For mid-market and entry-level, AI plus 5-minute agent edit is better than rushed human copy. For luxury and historic properties, professional copywriters still win on emotional storytelling."},
    {"q":"How long should a description be?","a":"200-400 words is the sweet spot - long enough to evoke lifestyle, short enough that buyers actually read past the first paragraph. AI tools default close to this."}
  ]'::jsonb, 'writing', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 11. ai-for-job-postings
(
  'ai-for-job-postings', 'AI for Job Postings', '💼',
  ARRAY['writing-ai'], ARRAY['jasper','copy-ai','writesonic','anyword'], 3,
  'A great job posting attracts the right candidates and repels the wrong ones - and most companies still publish boring requirements lists that do neither. AI job posting tools generate role-specific copy with inclusive language, growth framing, and team voice from a few seed inputs. Jasper leads on long-form structure; Copy.ai is the entry-level pick; Writesonic and Anyword handle budget and conversion-focused needs.',
  'We weighted: inclusive language scoring, EEOC compliance hints, role-specific framing (junior vs senior), and benefits/perks structuring.',
  '[
    {"q":"Will AI job postings introduce bias?","a":"AI can amplify training-data bias - watch for gendered language, age signals, and ableist phrasing. Pair AI output with a bias-checking tool like Textio for high-stakes roles."},
    {"q":"How long should a job posting be?","a":"400-700 words is the sweet spot. Longer postings see drop-off; shorter ones lack the substance qualified candidates need. AI tools default close to this."},
    {"q":"Can AI write the requirements section?","a":"Yes for standard roles. For specialized senior positions, hiring managers should hand-write the must-have requirements; AI generates the nice-to-have, benefits, and culture sections."}
  ]'::jsonb, 'hr-recruiting', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 12. ai-for-pitch-decks
(
  'ai-for-pitch-decks', 'AI for Pitch Decks', '🎤',
  ARRAY['design'], ARRAY['gamma-app','visme','slidebean','beautiful-ai','decktopus'], 3,
  'A founder spends 40-60 hours on the seed deck and another 20 on the Series A version - and most of that time is fighting design tools, not crafting the pitch. AI pitch deck tools generate the full 10-12 slide structure with copy, layout, and visuals from a 1-page brief. Gamma leads on AI-native deck generation with editable output. Beautiful.ai and Slidebean ship templated approaches; Visme covers broader design needs; Decktopus is the lightweight quick-deck pick.',
  'Selection focused on: end-to-end generation from a text brief, narrative structure (problem to solution to ask), brand consistency across slides, and editable output for round-by-round iteration.',
  '[
    {"q":"Gamma vs Beautiful.ai for fundraising?","a":"Gamma generates the full deck from a brief in minutes. Beautiful.ai shines once you know your structure but want polished design. For seed-round speed, Gamma; for refined Series A, Beautiful.ai."},
    {"q":"Can I export AI decks to Keynote or PowerPoint?","a":"Yes - all five export to PPTX. Some formatting drifts on import; plan for 30-60 minutes of cleanup if your final delivery is in Keynote or PowerPoint."},
    {"q":"Do investors care that the deck was AI-generated?","a":"They care that the narrative is sharp and the numbers are real. AI-helped design is invisible if the content lands; the meeting fails if the content is weak regardless of design."}
  ]'::jsonb, 'design', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 13. ai-for-mockup-generation
(
  'ai-for-mockup-generation', 'AI for Mockup Generation', '🖥️',
  ARRAY['design','code-ai'], ARRAY['v0','uizard','relume','galileo-ai','visily'], 3,
  'Mockups went from days-of-Figma to minutes-of-prompting - and the design-to-code handoff is now a single workflow. v0 by Vercel leads as the React-and-Tailwind generator that ships production-ready components. Uizard converts hand-drawn sketches to clickable mockups; Relume builds Webflow-ready libraries; Galileo AI generates editable Figma designs from text; Visily handles wireframes for non-designers.',
  'We weighted: output quality (production-grade vs toy), editability in Figma or code, framework support (React, Vue, Webflow), and speed from prompt to mockup.',
  '[
    {"q":"v0 vs Figma AI?","a":"v0 outputs ready-to-render React components. Figma AI lives inside the design tool you already use. For developer-led prototyping, v0; for designer-led work, Figma AI."},
    {"q":"Will AI mockups replace UI designers?","a":"For fast first drafts and component generation, AI is faster. For research, judgment, and brand cohesion, designers still own the work. The role shifts toward orchestration, not extinction."},
    {"q":"Can AI mockups handle responsive design?","a":"v0 and Galileo output responsive React/HTML by default. Uizard and Visily focus on flat mockups; responsive is a manual edit. Pick by whether you need final responsive code or just a clickable concept."}
  ]'::jsonb, 'design', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 14. ai-for-music-generation
(
  'ai-for-music-generation', 'AI for Music Generation', '🎵',
  ARRAY['voice-audio'], ARRAY['suno','udio','soundraw','mubert'], 3,
  'Generative music crossed the listenable threshold in 2024 with Suno and Udio - and the use cases for podcasts, video soundtracks, and brand audio have multiplied since. Suno leads on lyric-driven full-song generation. Udio matches Suno on quality with stronger genre control. Soundraw is the royalty-free background music specialist for content creators. Mubert generates adaptive ambient soundscapes for streaming and apps.',
  'Selection focused on: output quality at full song length, genre and mood control, royalty-free commercial license, and stem export for editing.',
  '[
    {"q":"Suno vs Udio - which is better?","a":"Both produce listenable full songs. Suno is more accessible with stronger lyric handling. Udio gives slightly more production control. Most creators try both and pick by gut for their style."},
    {"q":"Can I commercially release AI music?","a":"All four permit commercial use of outputs. The legal landscape on training data is unsettled; for high-stakes commercial use (TV, film, ads), check current platform terms before release."},
    {"q":"Will Spotify accept AI-generated music?","a":"Yes for now. Some distributors (DistroKid, CD Baby) require disclosure; Spotify itself does not block AI tracks but has hinted at policy changes. Disclose to the distributor."}
  ]'::jsonb, 'design', 'beginner', 5400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 15. ai-for-pdf-summarization
(
  'ai-for-pdf-summarization', 'AI for PDF Summarization', '📄',
  ARRAY['productivity'], ARRAY['perplexity','notion-ai','readwise','humata','chatpdf'], 3,
  'A 60-page report or a 20-page research paper rarely deserves a full read - but it does deserve the 5 key claims and the one chart that matters. AI PDF summarization tools extract structure, key points, and answer questions across long documents in seconds. Perplexity leads on broad research and citation; Notion AI is in-context for users who already work in Notion; Readwise compounds learning across your library; Humata and ChatPDF specialize in PDF chat workflows.',
  'We weighted: accuracy on technical content, table and chart extraction, multi-document Q&A, and source citation back to the original PDF.',
  '[
    {"q":"Will AI hallucinate facts from PDFs?","a":"Yes, occasionally - especially on numbers and quotes. Always verify critical claims against the source. Tools with citation features (Perplexity, Humata) make verification fast."},
    {"q":"Humata vs ChatPDF?","a":"Humata is more polished for academic and legal PDFs with stronger citation. ChatPDF is the simple, fast pick for one-off documents. For daily research, Humata; for occasional, ChatPDF."},
    {"q":"Can I summarize 100 PDFs at once?","a":"Yes - all five support batch upload or library mode. Quality on individual document Q&A drops slightly with batch context; for high-stakes analysis, process critical documents one at a time."}
  ]'::jsonb, 'productivity', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 16. ai-for-meeting-agendas
(
  'ai-for-meeting-agendas', 'AI for Meeting Agendas', '📋',
  ARRAY['meeting-ai','productivity'], ARRAY['fathom','notion-ai','avoma','fireflies-ai','sembly-ai'], 3,
  'A clear agenda is the difference between a 30-minute working session and a 60-minute group ramble. AI meeting agenda tools generate role-specific agendas from prior meeting context, recent decisions, and open action items. Fathom leads with auto-generated pre-meeting briefs; Notion AI is in-context for teams that document in Notion; Avoma and Fireflies bundle agenda with full meeting intelligence; Sembly handles cross-functional agendas across departments.',
  'Selection focused on: pulling context from prior meetings, role and topic structuring, time-box suggestions, and integration with calendar invites.',
  '[
    {"q":"Should I share the AI agenda with attendees?","a":"Yes - and tweak it before sending. Auto-generated agendas catch 80% of context but miss the unspoken priority. A 2-minute human review prevents the off-target agenda."},
    {"q":"Does Fathom generate agendas automatically?","a":"Yes - Fathom builds a brief 5-10 minutes before the call from prior meeting notes and CRM data. Most users review and tweak before the call starts."},
    {"q":"Will AI agendas work for executive meetings?","a":"For recurring 1:1s and team standups, yes. For board meetings and sensitive strategy sessions, hand-written agendas still set the right tone - executives notice tooling shortcuts."}
  ]'::jsonb, 'productivity', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 17. ai-for-action-items
(
  'ai-for-action-items', 'AI for Action Items', '✅',
  ARRAY['meeting-ai'], ARRAY['fathom','avoma','fireflies-ai','otter-ai','sembly-ai'], 3,
  'Action items decided in meetings are the most-lost work in a team - and AI meeting tools now extract them automatically with owner, due date, and context. Fathom leads on free-tier action item extraction with strong accuracy. Avoma bundles action items with deal intelligence for sales. Fireflies syncs items to project tools natively. Otter is the broad-spectrum standalone. Sembly handles cross-functional teams.',
  'We weighted: action item extraction accuracy, owner attribution, due-date inference, and integration with Asana, Linear, Jira, ClickUp.',
  '[
    {"q":"How accurate is AI action item extraction?","a":"On clear English meetings with explicit verbal commitments, 80-90% accuracy. Drops with overlapping speakers or vague language. Always review the list post-meeting before treating it as a source of truth."},
    {"q":"Can AI assign action items to the right person?","a":"For meetings with a clear participant list, yes - tools attribute by speaker. For ambiguous cases (third-party attendees, group commitments), expect manual cleanup."},
    {"q":"Fathom vs Otter for action items?","a":"Fathom is more accurate on action item extraction with cleaner free tier. Otter has broader meeting note features. For pure action item capture, Fathom; for full transcripts, Otter."}
  ]'::jsonb, 'productivity', 'beginner', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 18. ai-for-meeting-minutes
(
  'ai-for-meeting-minutes', 'AI for Meeting Minutes', '📝',
  ARRAY['meeting-ai'], ARRAY['fathom','notion-ai','avoma','fireflies-ai','otter-ai'], 3,
  'Detailed meeting minutes are a compliance and continuity necessity for boards, councils, and regulated teams - and writing them by hand burns hours per week. AI meeting minute tools transcribe, structure, and extract decisions, attendees, and votes automatically. Fathom and Otter lead on transcript-plus-minutes; Notion AI integrates into team workspaces; Avoma and Fireflies bundle minutes with deal intelligence and CRM logging.',
  'Selection focused on: transcript accuracy, decision and vote extraction, attendee tracking, and template support for board/council formal minutes.',
  '[
    {"q":"Are AI meeting minutes legally compliant?","a":"For internal team minutes, yes - everywhere. For board minutes and regulated bodies, AI is acceptable as a draft but requires a human signer and explicit approval workflow per your jurisdiction."},
    {"q":"How accurate are AI minutes?","a":"95%+ accuracy on transcript with clean audio. Minutes-quality structuring (decisions, motions, votes) requires post-meeting human review. AI saves drafting time, not review time."},
    {"q":"Notion AI vs Otter for minutes?","a":"Otter records and transcribes during the meeting; Notion AI summarizes a pasted transcript. For real-time, Otter; for post-hoc structuring, Notion AI. Many teams stack both."}
  ]'::jsonb, 'productivity', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 19. ai-for-calendar-management
(
  'ai-for-calendar-management', 'AI for Calendar Management', '📅',
  ARRAY['productivity'], ARRAY['cal-com','reclaim-ai','motion'], 3,
  'Smart calendar management is no longer just scheduling - it is dynamic protection of focus time, automatic rescheduling on priority shifts, and travel-aware time-zone handling. Cal.com is the open-source booking layer with strong AI routing. Reclaim.ai is the Google Calendar overlay for habit and 1:1 defense. Motion goes furthest with AI-driven daily planning that rebuilds your day every time priorities shift.',
  'We weighted: auto-rescheduling logic, focus-time defense, native Google and Outlook integration, and pricing for individuals and small teams.',
  '[
    {"q":"Motion vs Reclaim - which is right for me?","a":"Motion rebuilds the entire day when priorities shift - good for founders and consultants. Reclaim is lighter and more defensive - good for ICs who want focus time protected without a full daily reset."},
    {"q":"Cal.com vs Calendly?","a":"Cal.com is open-source with stronger AI routing and self-host options. Calendly is more polished out of the box. For teams that value openness or self-hosting, Cal.com; for plug-and-play, Calendly."},
    {"q":"Can these handle travel time zones?","a":"Reclaim and Motion auto-detect time zone changes. Cal.com requires manual update. For frequent travel, Reclaim or Motion."}
  ]'::jsonb, 'productivity', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 20. ai-for-journaling
(
  'ai-for-journaling', 'AI for Journaling', '📓',
  ARRAY['productivity'], ARRAY['notion-ai','reflect','mem-ai'], 3,
  'A journaling habit beats a productivity system every time - and AI journaling tools now turn raw entries into searchable, themed insights across years. Notion AI extends the all-in-one workspace to journaling with smart prompts. Reflect is the privacy-first second brain with strong daily-note workflows. Mem.ai is the AI-native note-taking app where past entries auto-surface relevant to current writing.',
  'Selection focused on: search across years of entries, AI prompt quality for daily writing, privacy and end-to-end encryption, and connection between notes (auto-linking, themes).',
  '[
    {"q":"Reflect vs Mem.ai for daily journaling?","a":"Reflect has stronger privacy posture and cleaner daily-note UX. Mem.ai has more aggressive auto-linking. For private personal journaling, Reflect; for connected idea capture, Mem.ai."},
    {"q":"Will AI read my private journal?","a":"All three permit AI features only on entries you opt into. Cloud sync means the company has technical access; encryption-at-rest does not equal end-to-end privacy. Read each terms-of-service before sharing sensitive content."},
    {"q":"Can I export my journal if I switch tools?","a":"Yes - all three export to Markdown. Format quality varies; expect 1-2 hours of cleanup if migrating between platforms with thousands of entries."}
  ]'::jsonb, 'productivity', 'beginner', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 21. ai-for-code-explanation
(
  'ai-for-code-explanation', 'AI for Code Explanation', '🔎',
  ARRAY['code-ai'], ARRAY['claude','cursor','codeium','copilot-microsoft','tabnine'], 3,
  'Reading unfamiliar code is the hardest dev task - and AI code explanation tools now translate dense logic into plain-English summaries with line-by-line breakdowns. Claude leads as the standalone chat AI with strong code reasoning across long files. Cursor and GitHub Copilot embed explanation directly in the IDE. Codeium and Tabnine are the privacy-friendly alternatives with self-host options.',
  'We weighted: explanation quality on long files (500+ lines), language coverage, IDE integration, and privacy posture for enterprise codebases.',
  '[
    {"q":"Claude vs Cursor for code explanation?","a":"Claude is stronger at long-context reasoning across files. Cursor explains code in IDE without app-switching. For deep architecture review, Claude; for line-by-line walkthroughs in your editor, Cursor."},
    {"q":"Can AI explain legacy code accurately?","a":"For mainstream languages and well-named code, 85-95%. For niche languages (COBOL, RPG), domain-specific abbreviations, and tribal-knowledge naming, AI guesses incorrectly - verify against runtime behavior."},
    {"q":"Will AI explanations leak source code?","a":"Cloud tools (Cursor, Copilot, Claude) send code to vendor servers. Tabnine and Codeium offer self-host. For regulated or proprietary codebases, self-host or skip cloud AI."}
  ]'::jsonb, 'dev', 'beginner', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 22. ai-for-code-refactoring
(
  'ai-for-code-refactoring', 'AI for Code Refactoring', '🔧',
  ARRAY['code-ai'], ARRAY['claude','cursor','codeium','copilot-microsoft','tabnine'], 3,
  'Refactoring used to be a confidence game - rename one function, hope nothing else broke. AI refactoring tools now propose multi-file edits with type-safe rewrites and a preview diff before commit. Cursor leads with the strongest agent mode for cross-file refactors. Claude is the chat-driven alternative that explains the why before suggesting the how. Copilot, Codeium, and Tabnine handle line-level rewrites in-IDE.',
  'Selection focused on: multi-file agent mode, type-safety preservation, test coverage suggestions, and rollback or diff-preview UX.',
  '[
    {"q":"Will AI refactoring break my tests?","a":"Cursor and Claude explicitly run or simulate tests before suggesting changes. Copilot and Codeium are line-level - higher chance of subtle bugs. For high-coverage codebases, Cursor or Claude. For low-coverage, write tests first."},
    {"q":"Cursor vs Claude for refactoring?","a":"Cursor is in-IDE with multi-file agent edits. Claude is browser/desktop chat with stronger explanations. For shipping changes, Cursor; for understanding tradeoffs first, Claude."},
    {"q":"Can AI refactor across languages?","a":"For mainstream pairs (TS-to-JS, Python-to-Go), yes with caveats. For niche or legacy migrations (COBOL-to-Java), AI is a starting draft; expect 50-70% rework. Treat as productivity boost, not magic."}
  ]'::jsonb, 'dev', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 23. ai-for-regex
(
  'ai-for-regex', 'AI for Regex', '🧩',
  ARRAY['code-ai'], ARRAY['claude','cursor','formula-bot','copilot-microsoft'], 3,
  'Regex is the code that everyone writes and nobody understands two weeks later. AI regex tools take a plain-English description plus a few examples and output the pattern with explanation and test cases. Claude excels at complex regex with explanation. Cursor generates regex inline in code. Formula Bot is the spreadsheet-friendly regex generator. GitHub Copilot handles inline regex in the IDE.',
  'We weighted: pattern correctness on complex cases (lookbehind, named groups, Unicode), explanation quality, language flavor support (PCRE, ECMAScript, RE2), and test case generation.',
  '[
    {"q":"Will AI handle complex regex like email validation?","a":"For common patterns (email, URL, phone), AI gives correct first answers. For RFC-strict cases, AI still misses edge cases - test against real data before shipping."},
    {"q":"Claude vs Copilot for regex?","a":"Claude explains the pattern step-by-step which compounds learning. Copilot generates inline without leaving the IDE. For one-off, Copilot; for understanding plus generation, Claude."},
    {"q":"Can AI generate regex for log parsing?","a":"Yes - paste a sample log line plus desired extraction targets. Claude in particular handles named-group extraction reliably for log analysis."}
  ]'::jsonb, 'dev', 'beginner', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 24. ai-for-database-queries
(
  'ai-for-database-queries', 'AI for Database Queries', '🗄️',
  ARRAY['code-ai','data-analytics'], ARRAY['julius-ai','seek-ai','outerbase','formula-bot','akkio'], 3,
  'Text-to-SQL crossed production reliability in 2025 - non-technical users now query real warehouses by asking plain-English questions. Julius.ai leads on conversational data analysis with strong dialect handling. Seek.ai and Outerbase are SQL-native with AI assist for engineers and analysts. Formula Bot covers spreadsheet-meets-SQL. Akkio adds predictive ML on top of generated queries.',
  'Selection focused on: SQL accuracy on complex schemas, dialect support (Postgres, BigQuery, Snowflake, MySQL), self-host options for sensitive data, and visualization output beyond raw query results.',
  '[
    {"q":"Will AI break my production database?","a":"All five default to read-only or sandboxed access. For write queries, explicit dual-confirmation is required. Set permission scopes correctly and treat AI like any junior analyst with prod credentials."},
    {"q":"Julius vs Seek.ai?","a":"Julius is the analyst-friendly chat workflow. Seek.ai is engineer-friendly with semantic-layer governance. For business users, Julius; for data teams, Seek."},
    {"q":"Can AI query 50-table schemas accurately?","a":"With clean column names and documented foreign keys, yes - 80-90% accuracy. With cryptic abbreviations and undocumented joins, AI guesses wrong. Document your schema before relying on AI for ad-hoc queries."}
  ]'::jsonb, 'dev', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 25. ai-for-clinical-notes
(
  'ai-for-clinical-notes', 'AI for Clinical Notes', '🩺',
  ARRAY['ai-assistants'], ARRAY['heidi-health','freed-ai','abridge','ambience-healthcare','suki-ai'], 3,
  'Clinical documentation is a leading driver of physician burnout - and ambient AI scribes now reduce notes time from 2 hours daily to 15 minutes. Heidi Health leads internationally with strong specialty coverage. Freed.ai is the popular US scribe with broad EHR integration. Abridge is the enterprise health-system pick with deep Epic and Oracle Health integration. Ambience Healthcare and Suki.ai cover the full ambulatory and inpatient spectrum.',
  'We weighted: specialty coverage (primary care vs surgery vs psychiatry), EHR integration depth, HIPAA and SOC 2 compliance, and physician-acceptance UX (review and edit speed).',
  '[
    {"q":"Are AI scribes HIPAA compliant?","a":"All five have HIPAA-compliant offerings with BAA available. Verify the specific tier you buy includes BAA - free or basic plans sometimes do not. Audit data retention and PHI handling per your covered-entity policy."},
    {"q":"Heidi vs Freed for solo practice?","a":"Freed is more polished for US solo practice. Heidi has broader international and specialty coverage. For a US PCP, Freed; for international or specialty, Heidi."},
    {"q":"Will AI replace medical scribes?","a":"For volume work (high-throughput primary care), yes - and is already happening. For complex specialty cases, AI scribes augment rather than replace. The role shifts toward review and exception handling."}
  ]'::jsonb, 'productivity', 'advanced', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 26. ai-for-medical-scribes
(
  'ai-for-medical-scribes', 'AI for Medical Scribes', '👩‍⚕️',
  ARRAY['ai-assistants'], ARRAY['freed-ai','abridge','heidi-health','suki-ai','ambience-healthcare'], 3,
  'Ambient AI medical scribes listen to the patient encounter and generate the SOAP note plus billing codes in real time - and acceptance has crossed the early-majority threshold in 2025. Freed.ai leads US private practice with strong UX. Abridge is the health-system enterprise pick deeply integrated with Epic. Heidi Health serves international and specialty markets. Suki.ai and Ambience Healthcare round out the field with strong inpatient coverage.',
  'Selection focused on: ambient (no manual recording start) vs push-to-talk, SOAP note structure quality, billing code suggestion accuracy, and EHR write-back integration.',
  '[
    {"q":"Will an AI scribe slow my visits?","a":"Initially yes - 1-2 weeks of acclimation while you and the patient adjust. After acclimation, most physicians report 30-60 min saved per day with similar visit length."},
    {"q":"Abridge vs Freed for hospitals?","a":"Abridge is the enterprise hospital pick with deeper EHR integration and security posture. Freed is private-practice-friendly. For health systems, Abridge; for solo or small group, Freed."},
    {"q":"Do patients react negatively to AI scribes?","a":"Most do not - the recorder is non-intrusive. Disclose at visit start (legal in most jurisdictions, courteous always) and offer to disable. Refusal rates are typically under 5%."}
  ]'::jsonb, 'productivity', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 27. ai-for-contract-drafting
(
  'ai-for-contract-drafting', 'AI for Contract Drafting', '📜',
  ARRAY['writing-ai'], ARRAY['ironclad','harvey-ai','draftwise','spellbook-ai','contractbook'], 3,
  'Contract drafting in 2026 splits between general-purpose AI for first drafts and legal-specific platforms for production legal work. Ironclad leads enterprise contract lifecycle with native AI drafting. Harvey AI is the law-firm-grade legal AI for sophisticated drafting. DraftWise and Spellbook focus on transactional contracts with playbook automation. Contractbook covers SMB-friendly contract management with templates.',
  'We weighted: legal-grade quality (vs generic LLM), playbook and clause-library integration, redline and review workflow, and security posture for privileged content.',
  '[
    {"q":"Harvey vs Spellbook?","a":"Harvey is law-firm-grade with broader legal reasoning. Spellbook is in-Word with stronger playbook automation for repeatable contracts. For litigation and complex M&A, Harvey; for transactional volume, Spellbook."},
    {"q":"Can I trust AI to draft my contracts?","a":"For first drafts of standard agreements (NDA, MSA, employment), yes - human review still required. For novel or high-stakes contracts, AI is a research aid; human counsel drafts and signs."},
    {"q":"Ironclad vs Contractbook?","a":"Ironclad is enterprise CLM with deep Salesforce integration. Contractbook is SMB-friendly with cleaner templates. For 100+ employee orgs, Ironclad; for under 50, Contractbook."}
  ]'::jsonb, 'ops', 'advanced', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 28. ai-for-contract-review
(
  'ai-for-contract-review', 'AI for Contract Review', '⚖️',
  ARRAY['writing-ai'], ARRAY['ironclad','harvey-ai','draftwise','spellbook-ai','zuva'], 3,
  'Reviewing a 30-page MSA used to take 2-3 hours of clause-by-clause comparison against your playbook. AI contract review tools surface redlines, missing clauses, and risk flags in minutes. Ironclad leads enterprise CLM with AI redlining. Harvey AI handles complex bespoke review for law firms. DraftWise, Spellbook, and Zuva specialize in transactional review with strong playbook adherence.',
  'Selection focused on: redline accuracy against playbook, missing-clause detection, risk scoring, and integration with Word and CLM systems.',
  '[
    {"q":"Will AI catch clause omissions?","a":"For playbook-driven review, yes - tools flag missing standard clauses reliably. For novel risks not in the playbook, AI is no substitute for experienced counsel."},
    {"q":"Spellbook vs Zuva?","a":"Spellbook is in-Word with broader contract type support. Zuva specializes in due-diligence review with stronger metadata extraction. For transactional, Spellbook; for M&A diligence, Zuva."},
    {"q":"Is AI contract review billable?","a":"Many firms now bill the review work but pass time savings to clients - net hours billed drops, hourly rate stays. Discuss billing model transparency with clients before adopting."}
  ]'::jsonb, 'ops', 'advanced', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 29. ai-for-legal-research
(
  'ai-for-legal-research', 'AI for Legal Research', '📚',
  ARRAY['research'], ARRAY['perplexity','harvey-ai','spellbook-ai'], 3,
  'Legal research used to mean Westlaw queries plus 4 hours of reading - and AI legal research tools now compress that to a 30-minute guided synthesis with citations. Harvey AI leads law-firm-grade with deep case-law reasoning. Spellbook offers in-Word legal research alongside drafting. Perplexity is the general AI search that handles legal questions well with strong citations for non-bet-the-firm work.',
  'We weighted: case-law database depth, citation quality and verification, jurisdiction handling, and confidentiality posture for client-matter research.',
  '[
    {"q":"Will AI hallucinate case citations?","a":"Yes - and high-profile sanctions for fake citations have hit lawyers who skipped verification. Harvey and Spellbook ground in real databases; Perplexity cites web sources. Always verify every citation against the actual case before filing."},
    {"q":"Harvey vs Westlaw AI?","a":"Harvey is broader with stronger drafting and reasoning. Westlaw AI (CoCounsel by Thomson Reuters) is database-native with cleaner case integration. Many large firms use both."},
    {"q":"Is Perplexity adequate for solo practice?","a":"For non-litigation work and legal commentary, yes. For court filings and matters requiring verified case authority, invest in a legal-specific tool with grounded citations."}
  ]'::jsonb, 'research', 'advanced', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 30. ai-for-essay-writing
(
  'ai-for-essay-writing', 'AI for Essay Writing', '✏️',
  ARRAY['writing-ai'], ARRAY['grammarly','jasper','copy-ai','quillbot','writesonic'], 3,
  'Essay writing for school, college applications, and personal-brand publications all benefit from AI structure plus human voice. Grammarly leads on grammar and clarity polish. Jasper and Copy.ai handle full-draft generation with brand voice. QuillBot adds paraphrasing for variants and original-sounding rewrites. Writesonic covers budget-tier essay needs.',
  'Selection focused on: structure quality (intro to body to conclusion), originality and plagiarism scoring, citation handling for academic essays, and free-tier limits for student use.',
  '[
    {"q":"Will my school detect AI writing?","a":"Detection tools (GPTZero, Turnitin AI) are unreliable - both false positive and false negative. Many schools have policies regardless of detection. Disclose AI use per your institution policy."},
    {"q":"Grammarly vs Jasper for college essays?","a":"Grammarly polishes what you write yourself. Jasper drafts from scratch. For college admissions, write your own draft and use Grammarly only for polish - voice authenticity matters more than convenience."},
    {"q":"Can QuillBot rewrite my essay to avoid AI detection?","a":"This is academically dishonest at most institutions. Detection tools may not catch paraphrased AI but the policy violation stands regardless. Use AI as research and editing aid, not authorship laundering."}
  ]'::jsonb, 'writing', 'beginner', 2400,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 31. ai-for-quiz-generation
(
  'ai-for-quiz-generation', 'AI for Quiz Generation', '❓',
  ARRAY['productivity'], ARRAY['mentimeter','edpuzzle-ai','curipod','classpoint','conker'], 3,
  'Generating 20 quiz questions from a textbook chapter or training video used to take 90 minutes - AI tools compress this to 5 minutes with multiple-choice, true-false, and short-answer mix. Mentimeter leads as the all-purpose interactive presentation and quiz platform. EdPuzzle AI specializes in video-quiz creation. Curipod, ClassPoint, and Conker focus on K-12 classroom workflows.',
  'We weighted: question variety (MC/TF/short answer/matching), source-text-to-quiz fidelity, difficulty calibration, and LMS integration.',
  '[
    {"q":"Will AI generate accurate questions from my source?","a":"For factual, well-structured source material, yes - 85-90% accuracy. For nuanced or interpretive content, AI questions skew literal; review and edit before assigning."},
    {"q":"Mentimeter vs Kahoot for live quizzes?","a":"Mentimeter is more presentation-friendly with broader question types. Kahoot is gamified with stronger engagement for K-12. For corporate training, Mentimeter; for kids, Kahoot."},
    {"q":"Can AI score open-ended quiz answers?","a":"For short-answer with clear right/wrong, yes - 90%+ accuracy. For interpretive essays, AI scoring is unreliable - use rubric assistance, not full automation."}
  ]'::jsonb, 'productivity', 'beginner', 880,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 32. ai-for-lesson-plans
(
  'ai-for-lesson-plans', 'AI for Lesson Plans', '🍎',
  ARRAY['productivity'], ARRAY['magicschool-ai','brisk-teaching','diffit','curipod','almanack-ai'], 3,
  'Teachers spend 5-10 hours weekly on lesson planning - and AI lesson plan tools now generate standards-aligned plans with activities, assessments, and differentiation in minutes. MagicSchool AI leads as the comprehensive teacher-AI platform. Brisk Teaching is the Chrome-extension specialist for in-Google-Docs workflow. Diffit handles differentiation and accessibility. Curipod and Almanack AI cover broader instructional design.',
  'Selection focused on: standards alignment (Common Core, NGSS, state-specific), differentiation by reading level and IEP, assessment generation, and integration with Google Classroom.',
  '[
    {"q":"Will AI lesson plans pass district review?","a":"Most districts permit AI-assisted planning with teacher review. AI plans aligned to standards pass review reliably. Submit standards mapping with the plan to demonstrate alignment."},
    {"q":"MagicSchool vs Brisk?","a":"MagicSchool is broader with 80+ tools across subjects. Brisk is Chrome-extension-native for Google Docs workflow. Many teachers use both."},
    {"q":"Can AI replace curriculum designers?","a":"For day-to-day plans, AI accelerates teachers significantly. For multi-week unit design and program-level curriculum, expert curriculum designers still win on coherence and pedagogy."}
  ]'::jsonb, 'productivity', 'beginner', 1900,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 33. ai-for-tutoring
(
  'ai-for-tutoring', 'AI for Tutoring', '🎓',
  ARRAY['ai-assistants'], ARRAY['photomath','khanmigo','synthesis-tutor','almanack-ai'], 3,
  'AI tutoring crossed the threshold from gimmick to genuine learning aid in 2024-2025 - for the right subjects and student types, it now beats group tutoring at 1/10 the cost. Photomath leads K-12 math with step-by-step solving. Khanmigo from Khan Academy covers broad K-12 subjects with research-backed pedagogy. Synthesis Tutor is the premium adaptive learning pick. Almanack AI handles teacher-led tutoring workflows.',
  'We weighted: subject coverage and depth, pedagogical quality (worked examples vs answer-only), age appropriateness, and parent/teacher visibility into student work.',
  '[
    {"q":"Will AI tutoring replace human tutors?","a":"For routine practice and homework help, increasingly yes - and is more accessible by cost. For coaching, motivation, and complex problem-solving, human tutors still win on relationship and judgment."},
    {"q":"Khanmigo vs ChatGPT for kids?","a":"Khanmigo is research-backed pedagogy with parental controls and aligned content. ChatGPT lacks both. For under-18 students, Khanmigo or similar purpose-built tutor; for adults, ChatGPT is fine."},
    {"q":"Photomath - solving or learning?","a":"Photomath shows step-by-step solutions which can be learning aid or homework cheating depending on use. Encourage students to attempt first then verify with Photomath, not Photomath-first."}
  ]'::jsonb, 'productivity', 'beginner', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 34. ai-for-ticket-classification
(
  'ai-for-ticket-classification', 'AI for Ticket Classification', '🏷️',
  ARRAY['ai-assistants'], ARRAY['intercom','freshdesk','zendesk','forethought','freshchat'], 3,
  'Routing 1,000 inbound tickets to the right team and agent used to take a dedicated triage queue - AI ticket classification now handles 80% with confidence scoring and handoff for ambiguous cases. Zendesk and Intercom lead enterprise with mature AI routing. Freshdesk and Freshchat cover the SMB tier with strong AI at lower cost. Forethought specializes in high-volume deflection with category-specific tuning.',
  'Selection focused on: classification accuracy on real production traffic, custom category support beyond defaults, multi-language handling, and confidence scoring for human escalation.',
  '[
    {"q":"How accurate is AI ticket classification?","a":"For well-defined categories with training data, 85-95%. For ambiguous boundaries (technical-vs-billing), expect 60-75% requiring human review. Tune over 30 days for stable performance."},
    {"q":"Forethought vs Zendesk built-in AI?","a":"Forethought has stronger deflection and routing for high-volume teams (100+ agents). Zendesk built-in AI is good enough for sub-100-agent teams already on Zendesk. Above 100 agents, Forethought adds material lift."},
    {"q":"Can AI handle non-English tickets?","a":"All five support major languages (Spanish, French, German, Portuguese, Japanese). Quality drops outside top-15 languages - verify samples for your specific market before relying on automation."}
  ]'::jsonb, 'support', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 35. ai-for-faq-generation
(
  'ai-for-faq-generation', 'AI for FAQ Generation', '❔',
  ARRAY['ai-assistants'], ARRAY['document360','notion-ai','intercom','freshdesk','zendesk'], 3,
  'A great FAQ deflects 30-40% of support tickets - and AI FAQ generation tools now mine support history to write the questions and answers that actually match user intent. Document360 leads as the customer-facing knowledge base with strong AI authoring. Notion AI handles internal-plus-external FAQs. Intercom, Freshdesk, and Zendesk ship FAQ generation tied to their ticketing systems for closed-loop deflection.',
  'We weighted: source-mining quality (real ticket data vs generic), search and discoverability, freshness signals, and integration with chat-bot deflection.',
  '[
    {"q":"Will AI FAQs match user actual questions?","a":"With ticket-history mining, 70-85% match. Without ticket data (cold-start), AI generates plausible but generic FAQs. Always feed real customer questions for production-quality FAQs."},
    {"q":"Document360 vs Notion AI?","a":"Document360 is purpose-built for customer-facing help with stronger SEO and analytics. Notion AI is broader with internal-plus-external use. For pure customer help, Document360; for blended, Notion AI."},
    {"q":"How often should I refresh AI FAQs?","a":"Monthly, tied to ticket volume changes. Tools like Intercom and Document360 surface stale-FAQ alerts when ticket categories shift. Set up the cadence on day one."}
  ]'::jsonb, 'support', 'intermediate', 720,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 36. ai-for-churn-prediction
(
  'ai-for-churn-prediction', 'AI for Churn Prediction', '📉',
  ARRAY['data-analytics'], ARRAY['vitally','gainsight','planhat','catalyst','custify'], 3,
  'Predicting which customers will churn 30-60 days out lets CS teams intervene before the cancellation form opens - and AI churn prediction tools now make this routine for SaaS. Gainsight leads enterprise customer success with deep AI risk scoring. Vitally is the modern alternative for product-led SaaS. Planhat, Catalyst, and Custify cover mid-market with strong AI playbooks tied to risk scores.',
  'Selection focused on: prediction accuracy 30-60 days out, signal sources (product usage, support tickets, NPS, billing), playbook automation tied to risk scores, and integration with Salesforce or HubSpot.',
  '[
    {"q":"How accurate is churn prediction?","a":"For SaaS with clean usage data, AUC 0.80-0.90 (good). For thin data or first-90-days customers, accuracy drops sharply. Build the prediction model on at least 12 months of churn examples."},
    {"q":"Gainsight vs Vitally?","a":"Gainsight is enterprise-grade with deep customizability and steep learning curve. Vitally is product-led-SaaS-friendly with cleaner UX. For 50+ CS team, Gainsight; for under 20, Vitally."},
    {"q":"Will AI replace customer success managers?","a":"For volume risk-flagging, yes - AI is faster and more consistent. For relationship-led work and complex saves, CSMs still win. AI handles signal; CSMs handle action."}
  ]'::jsonb, 'customer-success', 'intermediate', 480,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 37. ai-for-recruiting
(
  'ai-for-recruiting', 'AI for Recruiting', '👥',
  ARRAY['hr-recruiting'], ARRAY['ashby','goodtime','metaview','greenhouse','lever'], 3,
  'Modern recruiting AI handles sourcing, screening, scheduling, and interview-note synthesis - and the best teams use it across the funnel rather than just at intake. Ashby and Greenhouse lead modern ATS with native AI scoring and analytics. Lever covers mid-market with strong AI candidate matching. GoodTime specializes in interview scheduling AI. Metaview generates interview notes and structured feedback.',
  'We weighted: ATS depth and modernness, AI candidate matching quality, automated scheduling reliability, and interview-note synthesis with bias-aware scoring.',
  '[
    {"q":"Will AI introduce hiring bias?","a":"AI can amplify training-data bias - especially on resume screening where historical patterns include bias. Audit AI scoring against EEOC categories regularly and discount AI signals on protected attributes."},
    {"q":"Ashby vs Greenhouse?","a":"Ashby is modern with stronger built-in analytics and AI. Greenhouse is mature with broader integration ecosystem. For analytics-driven hiring teams, Ashby; for established orgs with existing integrations, Greenhouse."},
    {"q":"Is Lever still competitive in 2026?","a":"Yes - Lever has invested heavily in AI candidate matching and CRM features. Mid-market sweet spot remains. Larger enterprises trend toward Greenhouse or Workday; startups trend toward Ashby."}
  ]'::jsonb, 'hr-recruiting', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 38. ai-for-academic-writing
(
  'ai-for-academic-writing', 'AI for Academic Writing', '🎓',
  ARRAY['research','writing-ai'], ARRAY['perplexity','elicit','scispace','jasper','quillbot'], 3,
  'Academic writing combines literature synthesis, structured argument, and citation discipline - and AI tools now assist all three with different strengths. Elicit leads on structured research synthesis with paper extraction. Perplexity handles broad search with citations. SciSpace specializes in PDF chat with formula support. Jasper and QuillBot cover the writing layer with paraphrasing and structure.',
  'Selection focused on: paper coverage and citation quality, structured extraction for systematic review, paraphrasing without plagiarism risk, and journal-style formatting support.',
  '[
    {"q":"Will journals reject AI-assisted papers?","a":"Most major journals now require disclosure but accept AI-assisted writing. Some (Science, Nature) restrict AI authorship credit but permit assistance. Always disclose per current journal policy."},
    {"q":"Elicit vs Perplexity for thesis work?","a":"Elicit is purpose-built for academic research with structured paper extraction. Perplexity is broader and faster for general literature scans. For thesis-level rigor, Elicit; for early ideation, Perplexity."},
    {"q":"Can QuillBot help avoid plagiarism flags?","a":"Paraphrasing AI to avoid detection is academic dishonesty regardless of tool. QuillBot is appropriate for legitimate paraphrasing of your own draft, not for laundering source material."}
  ]'::jsonb, 'research', 'intermediate', 1300,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 39. ai-for-citation-management
(
  'ai-for-citation-management', 'AI for Citation Management', '🔗',
  ARRAY['research'], ARRAY['perplexity','elicit','scispace','consensus'], 3,
  'Citation management used to mean Zotero plus a 30-minute style-formatting fight before submission - AI citation tools now handle in-line citation, BibTeX export, and source-credibility scoring. Elicit leads academic research with structured citation extraction. SciSpace ships strong PDF-based citation. Consensus surfaces evidence-based answers with confidence scoring. Perplexity covers broad citation needs for non-bet-the-paper work.',
  'We weighted: format coverage (APA, MLA, Chicago, Vancouver), DOI handling, BibTeX export quality, and source-credibility scoring.',
  '[
    {"q":"Should I use AI citations or Zotero?","a":"Zotero remains the gold standard for citation management workflows. AI tools complement by surfacing relevant papers and verifying sources. Many researchers stack both - Zotero for library, AI for discovery."},
    {"q":"Will AI invent fake citations?","a":"Yes - especially Perplexity and ChatGPT on tightly-scoped academic queries. Always verify every DOI and full title against the source database before citing."},
    {"q":"Consensus vs Elicit?","a":"Consensus surfaces yes-no evidence-based answers with confidence scoring. Elicit handles structured paper extraction for systematic review. For clinical questions, Consensus; for thesis literature review, Elicit."}
  ]'::jsonb, 'research', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 40. ai-for-data-cleaning
(
  'ai-for-data-cleaning', 'AI for Data Cleaning', '🧹',
  ARRAY['data-analytics'], ARRAY['deepnote','formula-bot','julius-ai','rows'], 3,
  'Data cleaning eats 60-80% of analyst time - and AI data cleaning tools now handle deduplication, format normalization, and missing-value imputation in seconds. Julius.ai leads conversational data cleaning with code shown. Formula Bot is the spreadsheet-friendly alternative. Deepnote handles notebook-driven cleaning workflows. Rows is the AI-native spreadsheet replacement with built-in cleaning operations.',
  'Selection focused on: deduplication and fuzzy matching quality, format normalization (date, currency, address), imputation strategies for missing data, and reproducibility for compliance audit.',
  '[
    {"q":"Will AI cleaning preserve data integrity?","a":"For clear cases (typos, format inconsistency), yes - AI is more consistent than manual cleaning. For ambiguous cases (which duplicate to keep, how to impute missing), AI guesses; spot-check critical decisions."},
    {"q":"Julius vs Formula Bot?","a":"Julius is conversational with stronger context retention across cleaning steps. Formula Bot is one-shot for individual cleaning operations. For multi-step cleaning, Julius; for quick ad-hoc, Formula Bot."},
    {"q":"Is AI cleaning safe for PII?","a":"Cloud tools send data to vendor servers. For PII or regulated data, use Deepnote with VPC deploy or self-host options, or scrub PII before AI cleaning."}
  ]'::jsonb, 'data-analytics', 'intermediate', 590,
  ARRAY[]::text[], NULL, ARRAY[]::text[], 'published'
),

-- 41. ai-for-data-visualization
(
  'ai-for-data-visualization', 'AI for Data Visualization', '📊',
  ARRAY['data-analytics'], ARRAY['deepnote','metabase','tableau','julius-ai','rows'], 3,
  'Data visualization went from chart-config drudgery to plain-English chart generation - and AI tools now build dashboards from natural-language questions on raw warehouse data. Tableau leads enterprise with the deepest visualization library. Metabase is the open-source self-host favorite. Julius.ai conversational charts paired with analysis. Deepnote and Rows cover notebook and spreadsheet-style visualization with AI assist.',
  'We weighted: chart quality and variety, natural-language to chart accuracy, dashboard sharing and embedding, and pricing for sub-Series-B teams.',
  '[
    {"q":"Tableau vs Metabase for startups?","a":"Metabase is free open-source with 80% of startup needs covered. Tableau is enterprise-tier - powerful but $70+/user/month. For seed to Series B, Metabase. Beyond Series C, Tableau or Looker."},
    {"q":"Can AI pick the right chart type?","a":"For obvious cases (trend over time, distribution), yes. For nuanced choices (when bar vs scatter vs heatmap), AI defaults work but are sometimes suboptimal - learn the basics so you can override."},
    {"q":"Julius vs Tableau?","a":"Different jobs. Julius is conversational analysis with charts as output. Tableau is dashboard-building for shared, governed reporting. Stack both - Julius for ad-hoc analysis, Tableau for governed dashboards."}
  ]'::jsonb, 'data-analytics', 'intermediate', 1900,
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
