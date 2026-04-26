-- tools-batch-4.sql
-- 12 new tools: Voice AI, Dev Tools, Analytics, Productivity, Image AI
-- Run in Supabase SQL Editor

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

(
  'murf',
  'Murf',
  'Studio-quality AI voice generation for any content',
  E'Murf is a professional AI voice generator trusted by content creators, marketers, and corporate teams worldwide. It offers over 120 voices across 20 languages, with precise control over tone, pitch, pace, and emphasis. Unlike basic text-to-speech tools, Murf produces natural-sounding narration that closely mimics human delivery, making it the preferred choice for explainer videos, e-learning modules, podcasts, and product demos. The built-in voice studio lets users sync voiceover with video footage, add background music, and fine-tune timing without leaving the browser.\n\nMurf integrates with Canva and Google Slides, and its API allows developers to embed voice generation directly into applications and workflows. The free tier includes limited monthly voice minutes, sufficient to evaluate quality before committing to a paid plan. The Creator plan at $19 per month unlocks commercial rights, HD audio downloads, and substantially higher usage limits. For teams producing high volumes of narrated content, Murf replaces the cost and scheduling overhead of professional voice talent while delivering results that rival studio recordings for most professional use cases.',
  'https://www.google.com/s2/favicons?domain=murf.ai&sz=64',
  'https://murf.ai',
  'https://murf.ai',
  ARRAY['voice-ai', 'content'],
  'freemium', true, 19,
  4.6, 890, false, true, false,
  ARRAY['120+ voices across 20 languages', 'Built-in video sync and timeline editor', 'Commercial license included on paid plans', 'API access for developer integrations'],
  ARRAY['Free tier limited to 10 minutes per month', 'Team collaboration requires higher-tier plan', 'Voice quality varies across languages'],
  ARRAY['E-learning course narration', 'Explainer and product video voiceover', 'Podcast intros and audio content', 'Corporate training and presentation narration']
),

(
  'speechify',
  'Speechify',
  'Listen to anything at up to 4.5x reading speed with AI voices',
  E'Speechify converts any written content into natural-sounding audio, allowing users to listen to documents, web pages, PDFs, emails, Google Docs, and even physical books photographed with a phone. Its AI voices are among the most natural available, with celebrity voice options on premium plans. The platform is built around consumption speed: users can listen at up to 4.5x normal reading pace with comprehension-optimized processing, making it the preferred tool for professionals who need to absorb large volumes of written material quickly. Research papers, legal documents, reports, and industry news become something that can be processed on a commute or during a workout.\n\nSpeechify works across iOS, Android, Mac, and Chrome with dedicated apps for each platform that stay in sync. It integrates with popular reading sources and pulls content from almost any application without manual copying. The tool is widely used by people with dyslexia and other reading difficulties, as audio processing removes the friction of text reading entirely. The free tier includes basic voices and standard playback speed. Speechify Premium at $11.58 per month unlocks AI voices, maximum playback speed, offline listening, and an AI summarization feature that condenses long documents before listening.',
  'https://www.google.com/s2/favicons?domain=speechify.com&sz=64',
  'https://speechify.com',
  'https://speechify.com',
  ARRAY['voice-ai', 'productivity'],
  'freemium', true, 12,
  4.5, 1240, false, false, false,
  ARRAY['Supports virtually any text source including PDFs and web pages', 'Up to 4.5x playback speed with comprehension optimization', 'Celebrity AI voices on premium plans', 'Strong accessibility features for users with dyslexia'],
  ARRAY['Best features locked behind premium plan', 'Offline mode limited to downloaded content', 'No collaborative or team features'],
  ARRAY['Consuming research papers and industry reports quickly', 'Accessibility tool for users with reading difficulties', 'Keeping up with newsletters and long-form articles', 'Reviewing documents hands-free while multitasking']
),

(
  'windsurf',
  'Windsurf',
  'The AI-native code editor built around agentic programming',
  E'Windsurf is an AI-powered code editor developed by Codeium that competes directly with Cursor for developers who want deep AI integration throughout their workflow. Unlike AI plugins layered onto existing editors, Windsurf was built from the ground up around an agentic AI model called Cascade. Cascade understands the full context of a codebase, plans multi-step changes, runs terminal commands, reads error output, and iterates until a task is complete, all without switching between tools. The experience is closer to delegating work to a capable collaborator than to using an autocomplete tool.\n\nWindsurf uses a familiar VS Code interface, meaning there is no learning curve for existing VS Code or Cursor users. The Flows system logs every AI-assisted action, making it straightforward to review or roll back changes at any point in a session. Cascade maintains context reliably across extended sessions on large codebases, which is a known weakness of some AI coding tools. The free tier includes generous monthly AI credits, making it accessible to developers who want to evaluate it properly before committing. The Pro plan at $15 per month raises usage limits and unlocks access to the most capable underlying models for the most demanding coding tasks.',
  'https://www.google.com/s2/favicons?domain=codeium.com&sz=64',
  'https://codeium.com/windsurf',
  'https://codeium.com/windsurf',
  ARRAY['code-ai'],
  'freemium', true, 15,
  4.7, 1560, false, true, false,
  ARRAY['Agentic Cascade model handles multi-step tasks end to end', 'Familiar VS Code interface with zero learning curve', 'Flows system for reviewing and rolling back AI changes', 'Strong context retention across long coding sessions'],
  ARRAY['Newer product with smaller community than Cursor', 'Some advanced features still maturing', 'Local model support limited compared to alternatives'],
  ARRAY['Autonomous feature implementation across multiple files', 'Debugging complex errors with full codebase context', 'Refactoring and code quality improvements at scale', 'Learning new frameworks and codebases faster']
),

(
  'bolt',
  'Bolt.new',
  'Build and deploy full-stack web apps from a text description',
  E'Bolt is an AI-powered web application builder from StackBlitz that takes users from a text description to a working, deployed web application in minutes. Unlike AI coding assistants that help developers write code faster, Bolt is designed for anyone who wants to build without writing code manually. Users describe what they want — a landing page, a data dashboard, an internal tool — and Bolt generates the complete application including dependencies, configuration, and styling, then runs it in a live browser preview immediately. Changes are made conversationally: describe a new feature, a layout adjustment, or a different color scheme, and the application updates in real time.\n\nBolt is popular among founders validating ideas quickly, marketers building campaign pages, and teams that need internal tools without dedicated engineering resources. Every project includes a live URL for sharing and feedback, and one-click deployment to Netlify makes production launches straightforward. The platform uses frontier AI models under the hood, producing code quality that is genuinely usable rather than throwaway prototype code. The free tier includes a daily token budget sufficient for simple projects. The Pro plan at $20 per month provides substantially higher limits for complex applications and professional use.',
  'https://www.google.com/s2/favicons?domain=bolt.new&sz=64',
  'https://bolt.new',
  'https://bolt.new',
  ARRAY['code-ai'],
  'freemium', true, 20,
  4.5, 980, false, true, false,
  ARRAY['No coding required — build complete apps from text descriptions', 'Instant live preview with real-time conversational updates', 'One-click deployment to production via Netlify', 'Uses frontier AI models for production-quality code output'],
  ARRAY['Daily token limits on free plan can be exhausted quickly', 'Complex applications may require significant iteration', 'Less suitable for highly customized or proprietary codebases'],
  ARRAY['Rapid prototyping and MVP validation for founders', 'Landing pages and marketing microsites', 'Internal tools and admin dashboards without an engineer', 'Non-technical founders building early product demos']
),

(
  'mixpanel',
  'Mixpanel',
  'Event-based product analytics that reveals what drives user behaviour',
  E'Mixpanel is a product analytics platform that helps teams understand user behaviour in digital products at the event level. Where Google Analytics focuses on traffic and page views, Mixpanel tracks discrete actions users take — clicking a feature, completing an onboarding step, upgrading a plan — and enables analysis of how those actions relate to retention, conversion, and revenue. This event-based model makes it the standard analytics tool for SaaS companies, mobile apps, and digital businesses where engagement patterns directly inform product decisions.\n\nThe platform offers funnel visualisation, cohort analysis, retention charts, and user-level data exploration without requiring a data engineering team. Product managers can build complex queries through a drag-and-drop interface with results updating in real time. Mixpanel''s AI-powered Spark feature generates automated insights and flags anomalies before they affect key metrics. The free tier supports up to 20 million monthly tracked events, covering most early-stage products without cost. The Growth plan starts at $28 per month for teams that need custom dashboards, extended data history, and advanced segmentation that goes beyond what the free tier provides.',
  'https://www.google.com/s2/favicons?domain=mixpanel.com&sz=64',
  'https://mixpanel.com',
  'https://mixpanel.com',
  ARRAY['analytics'],
  'freemium', true, 28,
  4.4, 1100, false, false, false,
  ARRAY['Event-based model captures exactly what users do, not just pages viewed', 'Real-time data with no query delay', 'AI-powered Spark surfaces insights automatically', 'Generous free tier at 20 million events per month'],
  ARRAY['Pricing scales steeply at high event volumes', 'Initial implementation requires engineering setup', 'Less suited to content and marketing analytics than product analytics'],
  ARRAY['Tracking user onboarding funnel drop-off points', 'Measuring feature adoption after a product launch', 'Analysing retention cohorts by acquisition channel', 'Identifying which behaviours predict paid conversion']
),

(
  'amplitude',
  'Amplitude',
  'Behavioural analytics and A/B experimentation for product teams',
  E'Amplitude is a digital analytics platform built for product teams that need to understand how users interact with applications and what drives long-term retention. It specialises in behavioural analytics — tracking sequences of actions, identifying which paths lead to conversion, and measuring the impact of product changes through built-in experimentation. Amplitude''s primary advantage over alternatives is its combination of deep behavioural analytics with integrated A/B testing in a single platform, reducing the need to reconcile data across separate tools.\n\nThe platform includes session replay, letting teams watch actual user sessions alongside quantitative data to diagnose why a particular funnel step has a high drop-off rate. AI features generate automated insights that surface trends without manual querying, and predictive tools forecast user behaviour based on historical patterns. The free Starter plan is genuinely usable for small teams, supporting core analytics with up to 10 million monthly events. The Plus plan at $49 per month adds custom dashboards, extended data history, priority support, and more sophisticated segmentation. Amplitude is well established among mid-market and enterprise product teams and integrates with most major data warehouses and CDP tools.',
  'https://www.google.com/s2/favicons?domain=amplitude.com&sz=64',
  'https://amplitude.com',
  'https://amplitude.com',
  ARRAY['analytics'],
  'freemium', true, 49,
  4.4, 950, false, false, false,
  ARRAY['Built-in A/B testing alongside analytics in one platform', 'Session replay for qualitative context on quantitative data', 'AI-generated insights without manual querying', 'Strong integrations with data warehouses and CDPs'],
  ARRAY['Steeper learning curve than some analytics tools', 'Pricing increases significantly at enterprise scale', 'Experimentation features require careful statistical configuration'],
  ARRAY['Measuring the impact of product changes through A/B tests', 'Diagnosing high drop-off rates with session replay', 'Forecasting which user segments are likely to churn', 'Building executive dashboards on retention and engagement']
),

(
  'gamma',
  'Gamma',
  'AI-generated presentations, documents, and webpages in seconds',
  E'Gamma is an AI-powered creation tool that generates polished presentations, documents, and webpages from a brief text description or outline. Where traditional presentation tools require manual formatting of every element, Gamma handles layout, visual hierarchy, and content structure automatically, producing professional-looking results in seconds rather than hours. The AI applies presentation best practices consistently: balanced use of white space, readable typography, logical information flow, and appropriate visual emphasis on key points. Output can be delivered as an interactive web presentation, a downloadable document, or a shareable webpage, making it versatile across different content formats.\n\nGamma is particularly popular with founders preparing investor pitches, marketers creating sales decks, and teams who need professional-looking content without a designer. Unlike static slide exports, Gamma presentations are live web pages with smooth transitions, embedded media, and real-time collaboration. Any slide can be edited after AI generation, giving full manual control without starting from scratch. The free tier includes unlimited AI generation credits with Gamma branding applied. The Pro plan at $8 per month removes branding, unlocks custom fonts and domains, and provides viewer analytics showing who opened your presentation and how long they engaged with each section.',
  'https://www.google.com/s2/favicons?domain=gamma.app&sz=64',
  'https://gamma.app',
  'https://gamma.app',
  ARRAY['productivity', 'content'],
  'freemium', true, 8,
  4.6, 1340, false, true, false,
  ARRAY['Generates complete professional decks from a text outline', 'Output is a live interactive web page, not a static file', 'Built-in collaboration and presenter analytics', 'Pro plan at $8 per month is highly affordable'],
  ARRAY['Less suitable for highly branded corporate templates', 'Limited chart and data visualisation options vs PowerPoint', 'Gamma branding visible on all free-tier exports'],
  ARRAY['Investor pitches and startup fundraising decks', 'Sales proposals and client presentations', 'Internal team briefings and strategy documents', 'Marketing one-pagers and product announcements']
),

(
  'notebooklm',
  'NotebookLM',
  'AI research assistant grounded entirely in your own documents',
  E'NotebookLM is Google''s AI research assistant, built around the principle of grounding AI responses in documents you provide rather than general training data. Users upload sources — PDFs, Google Docs, web pages, YouTube videos, or audio files — and NotebookLM becomes an expert on that specific material. It answers questions, generates summaries, creates study guides, and identifies connections across multiple sources. Every answer cites the exact passage it draws from, making it straightforward to verify accuracy and trace reasoning back to the source. This approach eliminates the hallucination risk that makes general-purpose chatbots unreliable for research.\n\nThe standout feature is Audio Overview, which converts any set of documents into a natural-sounding podcast-style conversation between two AI hosts who discuss, debate, and explain the material. Complex research papers, legal documents, and technical reports become accessible in a format users can listen to on the go. NotebookLM is built on Gemini and benefits from Google''s document understanding capabilities. The base product is free to use with no subscription required. NotebookLM Plus, included with Google One AI Premium at approximately $20 per month, increases usage limits and adds team collaboration features for shared research projects.',
  'https://www.google.com/s2/favicons?domain=notebooklm.google.com&sz=64',
  'https://notebooklm.google.com',
  'https://notebooklm.google.com',
  ARRAY['research', 'productivity'],
  'freemium', true, 20,
  4.7, 1890, false, true, true,
  ARRAY['Every answer cites the exact source passage for verification', 'Audio Overview converts documents into a podcast-style conversation', 'Works with PDFs, Docs, web pages, YouTube, and audio files', 'Free to use with no subscription required'],
  ARRAY['Limited to sources you upload — no general internet search', 'Notebook size capped at 50 sources per project', 'Audio Overview takes a few minutes to generate'],
  ARRAY['Deep research on a specific set of papers or documents', 'Studying complex material through audio on the go', 'Synthesising information across multiple competing sources', 'Extracting key facts from long legal or technical documents']
),

(
  'fathom',
  'Fathom',
  'AI meeting recorder that summarises calls and logs action items automatically',
  E'Fathom is an AI meeting assistant that records, transcribes, and summarises video calls in real time. It works with Zoom, Google Meet, and Microsoft Teams, joining as a notetaker and generating a structured summary with action items, key decisions, and follow-up tasks within minutes of the meeting ending. Unlike manual note-taking, Fathom captures everything discussed without participants splitting attention between listening and writing. The AI identifies who said what, timestamps every exchange, and links each point in the summary to the exact moment in the recording — so any statement can be verified in seconds.\n\nFathom integrates directly with Salesforce and HubSpot, automatically logging call summaries and action items to the relevant CRM record without any manual data entry. Sales teams use it to capture every prospect conversation accurately; managers use it to review team calls without attending; executives use it to stay informed across projects without additional scheduling. The free plan is notably generous: unlimited recordings and AI summaries with no time limit, making it accessible at no cost. The Team Edition at $19 per user per month adds shared call libraries, collaborative editing, custom vocabulary, and advanced CRM logging that automates more of the post-call workflow.',
  'https://www.google.com/s2/favicons?domain=fathom.video&sz=64',
  'https://fathom.video',
  'https://fathom.video',
  ARRAY['productivity'],
  'freemium', true, 19,
  4.8, 2100, false, true, true,
  ARRAY['Free plan includes unlimited recordings and AI summaries', 'Direct CRM integration with Salesforce and HubSpot', 'Timestamped summaries link to exact recording moments', 'Works with Zoom, Google Meet, and Microsoft Teams'],
  ARRAY['Requires a bot to join calls, which some participants find intrusive', 'Advanced CRM integrations on paid plan only', 'Limited to video call platforms — no in-person meeting recording'],
  ARRAY['Capturing every detail from sales and discovery calls', 'Logging customer conversations to CRM without manual entry', 'Reviewing team meetings without attending', 'Creating accurate call records for compliance purposes']
),

(
  'kling',
  'Kling AI',
  'Physically realistic AI video generation up to two minutes long',
  E'Kling AI is a text-to-video and image-to-video generation platform developed by Kuaishou, one of China''s largest technology companies. It produces high-quality, physically realistic video clips up to two minutes long from text descriptions or reference images — substantially longer than most competing tools, which typically cap at four to ten seconds. Kling''s physics simulation understands how objects, liquids, fabrics, and human bodies move in the real world, producing results that look significantly more natural than other AI video generators on complex physical scenes.\n\nThe platform has attracted particular attention for its realistic human motion generation — walking, dancing, and facial expressions — without the uncanny artefacts that make AI video immediately recognisable. This makes it valuable for advertisers, filmmakers, and content creators who need short-form video at scale without a production crew. Kling AI is accessible globally via web browser with a credit-based pricing model. The free tier provides a modest monthly credit allowance suitable for evaluation. Standard paid plans begin at approximately $10 per month, with higher tiers unlocking 1080p resolution, longer clip durations, and faster generation queues for professional production workflows.',
  'https://www.google.com/s2/favicons?domain=klingai.com&sz=64',
  'https://klingai.com',
  'https://klingai.com',
  ARRAY['video-ai'],
  'freemium', true, 10,
  4.5, 760, false, true, false,
  ARRAY['Generates clips up to 2 minutes — far longer than most competitors', 'Realistic physics simulation for natural-looking movement', 'Strong human motion generation without uncanny artefacts', 'Works from text prompts or reference images'],
  ARRAY['Credit system can be depleted quickly on longer generations', 'Queue wait times on free plan during peak hours', 'Less established ecosystem compared to Runway or Pika'],
  ARRAY['Short-form video ads and social media content', 'Product visualisation and concept demonstrations', 'Film and creative project storyboarding', 'Marketing campaigns requiring diverse video assets at scale']
),

(
  'ideogram',
  'Ideogram',
  'AI image generation with industry-leading text rendering accuracy',
  E'Ideogram is an AI image generator that has established a strong reputation for one specific capability: accurately rendering legible text within generated images. Where other AI image tools frequently produce garbled, misspelled, or illegible text, Ideogram handles logos, signage, posters, product packaging, and typographic designs with accuracy that competing tools rarely match. This makes it the preferred generator for any use case where readable text is part of the visual — social media graphics, book covers, marketing materials, and brand assets. Most users find that Ideogram requires significantly fewer iterations to achieve correct text than Midjourney or DALL-E.\n\nBeyond its text rendering advantage, Ideogram produces high-quality photorealistic images, illustrations, and stylised artwork across a wide range of visual styles. Prompt understanding is strong, reliably handling complex multi-element descriptions without excessive iteration. The Magic Prompt feature automatically expands simple inputs into detailed descriptions, improving output quality for users who are not experienced with prompt engineering. The free tier provides a daily credit allowance that resets each day, enabling regular use without payment. The Basic plan at $8 per month significantly increases the monthly credit allocation and removes the queue delays that free users experience during peak hours.',
  'https://www.google.com/s2/favicons?domain=ideogram.ai&sz=64',
  'https://ideogram.ai',
  'https://ideogram.ai',
  ARRAY['image-ai'],
  'freemium', true, 8,
  4.5, 1020, false, false, false,
  ARRAY['Industry-leading text accuracy in generated images', 'Strong prompt understanding for complex multi-element scenes', 'Magic Prompt auto-expands simple inputs for better results', 'Daily free credits reset — usable without payment'],
  ARRAY['Less known for photorealism than Midjourney at its best', 'Daily credit limit restricts high-volume free use', 'Fewer style control options than some dedicated tools'],
  ARRAY['Logos, posters, and graphics requiring legible text', 'Social media content with overlaid text or captions', 'Book covers and editorial illustration', 'Brand asset creation for marketing teams without a designer']
),

(
  'krisp',
  'Krisp',
  'AI noise cancellation and meeting notes for every call',
  E'Krisp is an AI noise cancellation application that removes background noise and echo from calls in real time at the software level, before audio reaches any conferencing application. Unlike hardware noise cancellation built into headphones, Krisp works regardless of which microphone or speakers are in use. Home offices, coffee shops, open-plan offices, and hotel lobbies all produce the same clean audio output. It operates transparently with any application that uses a microphone, including Zoom, Google Meet, Teams, Slack, and WebEx, requiring no changes to existing call setups.\n\nBeyond noise removal, Krisp includes meeting transcription and AI-generated call summaries for recorded conversations, adding lightweight meeting assistant capabilities to what began as an audio tool. Audio is processed locally on the device, meaning calls are never routed through external servers — an important consideration for professionals handling confidential conversations or working under data privacy requirements. The free plan provides a limited number of noise-free minutes per week, sufficient for occasional calls and evaluation. The Pro plan at $8 per month provides unlimited noise cancellation, unlimited transcription, and access to the AI meeting notes feature, making it one of the most cost-effective professional audio tools available.',
  'https://www.google.com/s2/favicons?domain=krisp.ai&sz=64',
  'https://krisp.ai',
  'https://krisp.ai',
  ARRAY['voice-ai', 'productivity'],
  'freemium', true, 8,
  4.7, 1650, false, false, false,
  ARRAY['Works with any microphone and any conferencing app', 'Local audio processing — calls never leave your device', 'Includes meeting transcription and AI call summaries', 'Pro plan at just $8 per month'],
  ARRAY['Free plan limited to 60 noise-free minutes per week', 'Primarily useful for remote workers on frequent calls', 'AI summaries less detailed than dedicated tools like Fathom'],
  ARRAY['Remote workers in noisy home or shared office environments', 'Sales and customer success teams on back-to-back calls', 'Podcast recording and audio cleanup', 'Confidential calls where server-side processing is not acceptable']
)

ON CONFLICT (slug) DO NOTHING;
