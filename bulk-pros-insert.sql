-- Bulk update pros, cons, use_cases for 24 tools added in Session 7
-- Run in Supabase → SQL Editor

UPDATE tools SET
  pros = ARRAY['Real-time web search with citations','Fast, accurate answers with source links','Copilot for research and fact-checking','Clean UI, free tier is generous'],
  cons = ARRAY['Pro plan required for unlimited searches','Can hallucinate despite citations','Less capable at creative writing vs ChatGPT'],
  use_cases = ARRAY['Researching topics with up-to-date sources','Fact-checking and verifying claims','Quick Q&A with cited references','Academic and professional research']
WHERE slug = 'perplexity';

UPDATE tools SET
  pros = ARRAY['Open-weight models available for self-hosting','Strong reasoning and coding ability','European privacy standards, GDPR-friendly','Fast inference speed vs comparable models'],
  cons = ARRAY['Smaller community than OpenAI ecosystem','Fewer integrations and plugins','API docs less polished than competitors'],
  use_cases = ARRAY['Privacy-sensitive enterprise deployments','Code generation and technical reasoning','Building AI apps on open models','European companies with data residency needs']
WHERE slug = 'mistral';

UPDATE tools SET
  pros = ARRAY['Built into Windows, Edge, and Microsoft 365','GPT-4 powered, free for most users','Deep Office integration for Word, Excel, Outlook','No extra subscription needed for M365 users'],
  cons = ARRAY['Less customizable than standalone ChatGPT','Tied to Microsoft ecosystem','Web version lags behind GPT-4o features'],
  use_cases = ARRAY['Drafting emails and documents in Outlook/Word','Summarizing Excel data with natural language','Quick AI assistance without new subscriptions','Enterprise users already on Microsoft 365']
WHERE slug = 'copilot-microsoft';

UPDATE tools SET
  pros = ARRAY['Purpose-built for marketing copy at scale','Brand voice training across all outputs','Strong templates for blogs, ads, and emails','Team collaboration and campaign workflows'],
  cons = ARRAY['Expensive starting price ($49/mo)','Outputs need editing for brand specificity','Can feel repetitive without custom training'],
  use_cases = ARRAY['Scaling content production for marketing teams','Writing ad copy across multiple channels','Maintaining consistent brand voice at volume','Campaign brief to first draft in minutes']
WHERE slug = 'jasper';

UPDATE tools SET
  pros = ARRAY['Generous free tier with 2,000 words/month','Wide range of templates for every format','Good for short-form sales and social copy','Fast output, easy to iterate'],
  cons = ARRAY['Long-form quality drops without heavy editing','Paid plan jumps steeply to $49/mo','Less brand-aware than Jasper'],
  use_cases = ARRAY['Social media captions and ad headlines','Email subject lines and CTAs','Product descriptions for e-commerce','Cold outreach messages and sales emails']
WHERE slug = 'copy-ai';

UPDATE tools SET
  pros = ARRAY['SEO-optimized content built into the workflow','Supports 30+ languages','Chatsonic feature adds real-time web search','Good value at $19/mo starter plan'],
  cons = ARRAY['Quality inconsistent on technical topics','SEO features less deep than Surfer SEO','UI can feel cluttered with too many tools'],
  use_cases = ARRAY['Writing SEO blog posts and landing pages','Generating product descriptions at scale','Creating multilingual marketing content','Teams needing affordable AI writing + SEO']
WHERE slug = 'writesonic';

UPDATE tools SET
  pros = ARRAY['Best-in-class grammar and tone suggestions','Plagiarism detection built in','Works across browser, Word, and Google Docs','Clarity and conciseness feedback is actionable'],
  cons = ARRAY['Full AI features require paid plan ($12+/mo)','Can over-correct natural writing style','Privacy concerns around enterprise data'],
  use_cases = ARRAY['Polishing professional emails and reports','Academic writing and plagiarism checking','Non-native English speakers improving fluency','Teams standardizing writing quality']
WHERE slug = 'grammarly';

UPDATE tools SET
  pros = ARRAY['Fine-tuned custom models for specific styles','Generous free tier (150 credits/day)','Inpainting and real-time canvas editing','Large community sharing model presets'],
  cons = ARRAY['Steeper learning curve than Midjourney','Credit system can be confusing for new users','Pro features require paid plan'],
  use_cases = ARRAY['Game asset and character concept art','Marketing visuals with custom style training','Product mockups and e-commerce imagery','Creative projects requiring stylistic consistency']
WHERE slug = 'leonardo-ai';

UPDATE tools SET
  pros = ARRAY['Commercially safe — trained on licensed content','Integrated into Photoshop and Creative Cloud','Generative fill and expand tools are best-in-class','No IP liability concerns for commercial use'],
  cons = ARRAY['Requires Creative Cloud subscription for full access','Less photorealistic than Midjourney','Slower iteration cycle than standalone tools'],
  use_cases = ARRAY['Commercial design work requiring IP safety','Extending and modifying existing photos in Photoshop','Marketing teams using Adobe Creative Cloud','Brand asset creation with legal compliance']
WHERE slug = 'adobe-firefly';

UPDATE tools SET
  pros = ARRAY['Best free tier in the market (generous monthly credits)','Magic Studio AI tools tightly integrated into design','Huge template library for non-designers','Team collaboration built in'],
  cons = ARRAY['AI image quality lags behind Midjourney','Not suitable for professional print design','Advanced features locked behind paid plans'],
  use_cases = ARRAY['Social media graphics and presentations','Small business marketing materials','Quick AI-generated visuals without design skills','Teams needing a shared design + AI workspace']
WHERE slug = 'canva-ai';

UPDATE tools SET
  pros = ARRAY['Leading text-to-video model (Gen-2) quality','Motion Brush for precise animation control','Strong inpainting and video editing tools','Used by professional filmmakers and studios'],
  cons = ARRAY['Expensive at scale ($15+/mo for limited credits)','Generation time can be slow','Short clip length limits (4–16 seconds)'],
  use_cases = ARRAY['Short-form video content for social media','Concept visualization for film and advertising','Adding AI motion to static images','Music video and creative visual production']
WHERE slug = 'runway';

UPDATE tools SET
  pros = ARRAY['Talking avatar quality is best-in-class','Video translation into 40+ languages','Voice cloning from short audio samples','Fast turnaround for corporate video production'],
  cons = ARRAY['Free tier very limited (1 min/month)','Avatar customization requires higher plans','Not suitable for highly emotional/nuanced content'],
  use_cases = ARRAY['Corporate training and onboarding videos','Localizing marketing videos into multiple languages','Personalized sales outreach with talking avatars','YouTube and e-learning content at scale']
WHERE slug = 'heygen';

UPDATE tools SET
  pros = ARRAY['Edit video by editing text transcript — game-changing UX','Automatic filler word removal (ums, uhs)','Overdub AI voice for corrections without re-recording','Works for both video and podcast editing'],
  cons = ARRAY['Transcription accuracy varies for accents','Export quality limited on free plan','Can feel slow for heavy video projects'],
  use_cases = ARRAY['Podcast editing without timeline expertise','YouTube video editing with transcript-first workflow','Removing filler words from interviews and webinars','Remote teams collaborating on video content']
WHERE slug = 'descript';

UPDATE tools SET
  pros = ARRAY['Full codebase context in every AI interaction','Composer for multi-file edits with one prompt','Built on VS Code — zero learning curve','Fastest AI code iteration loop available today'],
  cons = ARRAY['$20/mo after free trial (500 requests)','Can over-generate and introduce unwanted changes','Privacy concerns for proprietary codebases'],
  use_cases = ARRAY['Building new features with full-repo context','Refactoring large codebases with AI assistance','Learning unfamiliar codebases through conversation','Solo developers shipping faster without context switching']
WHERE slug = 'cursor';

UPDATE tools SET
  pros = ARRAY['Full dev environment in browser — no setup','AI coding assistant integrated into IDE','One-click deploy for web apps','Great for learning, prototyping, and hackathons'],
  cons = ARRAY['Free tier has limited compute and storage','Performance slower than local development','Not ideal for large production codebases'],
  use_cases = ARRAY['Rapid prototyping and hackathon projects','Teaching programming without local setup','Sharing live code demos and projects','Building and deploying simple web apps quickly']
WHERE slug = 'replit';

UPDATE tools SET
  pros = ARRAY['Runs privately on your own infrastructure','GDPR-compliant with no code leaving your servers','Supports all major IDEs (VS Code, JetBrains, etc.)','Team and enterprise plans with admin controls'],
  cons = ARRAY['Less conversational than Copilot or Cursor','Setup complexity for self-hosted deployment','Smaller model than cloud-based competitors'],
  use_cases = ARRAY['Enterprise teams with strict data privacy requirements','Healthcare and finance companies with compliance needs','Augmenting developer productivity without cloud exposure','Teams in regulated industries needing on-premise AI']
WHERE slug = 'tabnine';

UPDATE tools SET
  pros = ARRAY['Most comprehensive SEO data platform available','Keyword research, site audit, and competitor analysis in one','Backlink analytics with historical data','Content marketing and social listening tools included'],
  cons = ARRAY['Expensive at $139/mo — not for individuals','Data overload for beginners','Some features overlap with cheaper tools'],
  use_cases = ARRAY['SEO agencies managing multiple client campaigns','Competitive intelligence and market research','Technical SEO audits for large websites','Content gap analysis and keyword planning']
WHERE slug = 'semrush';

UPDATE tools SET
  pros = ARRAY['Content Editor scores articles against top-ranking pages','Keyword density and NLP term suggestions','Audit existing content for SEO improvements','Integrates with Google Docs and WordPress'],
  cons = ARRAY['Expensive at $89/mo — targets professionals','Only useful if you publish content regularly','Learning curve for NLP-based optimization'],
  use_cases = ARRAY['Writing SEO-optimized blog posts that rank','Optimizing existing content for better rankings','Agencies producing content for SEO clients','Content teams targeting specific keyword clusters']
WHERE slug = 'surfer-seo';

UPDATE tools SET
  pros = ARRAY['Connects 6,000+ apps with no code','AI-powered Zaps for workflow suggestions','Reliable, battle-tested automation platform','Large template library to get started instantly'],
  cons = ARRAY['Pricing scales steeply with task volume','Advanced logic requires paid plans','Slower than Make for complex multi-step workflows'],
  use_cases = ARRAY['Automating lead capture from forms to CRM','Syncing data between marketing and sales tools','Triggering notifications from app events','Non-technical teams building automations without code']
WHERE slug = 'zapier';

UPDATE tools SET
  pros = ARRAY['Visual drag-and-drop workflow builder','Handles complex logic (iterators, routers, aggregators)','More affordable than Zapier at scale','Excellent for data transformation workflows'],
  cons = ARRAY['Steeper learning curve than Zapier for beginners','Some connectors less polished than Zapier','Support response times slower on lower plans'],
  use_cases = ARRAY['Complex multi-step automations with branching logic','Data processing and transformation pipelines','E-commerce order management automations','Developers building advanced workflow logic visually']
WHERE slug = 'make';

UPDATE tools SET
  pros = ARRAY['Fastest, most focused issue tracker UX','AI-powered workflow automation and triage','Git integration with automatic issue linking','Cycles and roadmaps built for engineering teams'],
  cons = ARRAY['Limited compared to Jira for enterprise needs','No native time tracking','Learning curve for teams used to Jira/Asana'],
  use_cases = ARRAY['Fast-moving engineering teams tracking bugs and features','Startups wanting Notion-level design with Jira-level power','Teams linking code commits directly to issues','Product managers running sprints with velocity tracking']
WHERE slug = 'linear';

UPDATE tools SET
  pros = ARRAY['Most realistic AI voices available today','Voice cloning from 1 minute of audio','29 languages with natural prosody','Dubbing and translation with lip sync'],
  cons = ARRAY['Can be misused for voice fraud (moderation required)','Cost scales with character volume','Voice cloning requires consent verification'],
  use_cases = ARRAY['Audiobook narration and podcast production','E-learning and training video voiceovers','Localization of video content into other languages','Game character voice generation']
WHERE slug = 'elevenlabs';

UPDATE tools SET
  pros = ARRAY['Real-time transcription in meetings','Action items and summaries auto-generated','Integrates with Zoom, Google Meet, and Teams','Free tier covers most individual needs'],
  cons = ARRAY['Accuracy drops with accents and crosstalk','Privacy concerns storing meeting transcripts','Premium needed for unlimited transcription'],
  use_cases = ARRAY['Transcribing sales calls and client meetings','Capturing action items from team standups','Accessible meeting notes for hearing-impaired users','Journalists and researchers recording interviews']
WHERE slug = 'otter-ai';

UPDATE tools SET
  pros = ARRAY['All-in-one CRM, marketing, and sales platform','Generous free CRM tier forever','AI content assistant built into email and blog tools','Best-in-class marketing automation for SMBs'],
  cons = ARRAY['Can get expensive as contact list grows','UI complexity increases with scale','Some AI features require higher tier plans'],
  use_cases = ARRAY['Small businesses managing leads and customer relationships','Marketing teams running email nurture campaigns','Sales teams tracking pipeline and deal stages','Inbound marketing with landing pages and forms']
WHERE slug = 'hubspot';
