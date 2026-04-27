-- tools-batch-17.sql
-- 10 new tools. Target: DB 192 -> 202 tools.
-- ON CONFLICT (slug) DO NOTHING - safe to re-run.

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

(
  'voiceflow',
  'Voiceflow',
  'Build and deploy AI agents and chatbots without code',
  'Voiceflow is a collaborative platform for designing, prototyping, and deploying AI-powered conversational agents. Product and CX teams use it to build customer support bots, sales assistants, and voice interfaces without requiring engineering resources for every iteration. The visual canvas lets non-technical team members design conversation flows, add AI steps powered by GPT-4 or Claude, test with real users, and publish to web chat, Slack, WhatsApp, and voice channels. Version control and commenting make it suitable for team collaboration at scale.

Voiceflow is used by enterprise teams at companies including IKEA, JP Morgan, and Spotify to manage high-volume customer interactions. The platform handles the infrastructure layer - hosting, analytics, conversation logging - so teams can focus on designing the agent behavior. A free tier supports prototyping and small deployments. Paid plans start at $50/mo and scale with usage. For businesses looking to build internal or customer-facing AI agents without dedicating a full engineering team, Voiceflow is one of the most mature no-code options available.',
  'https://www.google.com/s2/favicons?domain=voiceflow.com&sz=64',
  'https://www.voiceflow.com',
  'https://www.voiceflow.com',
  ARRAY['productivity', 'ai-assistant'],
  'freemium', true, 50,
  4.5, 1100, false, true, false,
  ARRAY['No-code conversation designer', 'Multi-channel deployment (web, Slack, WhatsApp, voice)', 'Strong enterprise adoption', 'Built-in analytics and A/B testing', 'Active template library'],
  ARRAY['Paid plans expensive for small teams', 'Advanced AI steps require prompt engineering knowledge', 'Can be overkill for simple FAQ bots'],
  ARRAY['Customer support automation', 'Internal HR and IT helpdesk bots', 'Sales qualification and lead nurturing', 'Voice interface prototyping']
),

(
  'bland-ai',
  'Bland AI',
  'AI phone call automation at scale',
  'Bland AI is a platform for building and deploying AI-powered phone call agents that can make or receive calls autonomously. Businesses use it to automate outbound sales calls, appointment reminders, customer surveys, and inbound support without expanding headcount. The AI voice is configurable, can follow custom scripts with dynamic branching based on caller responses, transfer calls to human agents when necessary, and integrate with CRMs via webhook. Calls happen in real time with sub-300ms latency, which is low enough that most callers do not realize they are speaking with an AI.

The primary use cases are in high-volume call center operations, healthcare appointment scheduling, real estate lead follow-up, and debt collection. Bland AI is not a consumer tool - it is infrastructure for businesses that currently operate call centers or rely on outsourced phone outreach. Pricing is per-minute with volume discounts, making it cost-effective at scale compared to human agents. A developer API is available for integrating Bland into existing telephony workflows. For any organization spending significant budget on outbound or inbound phone operations, Bland AI provides a compelling ROI case.',
  'https://www.google.com/s2/favicons?domain=bland.ai&sz=64',
  'https://www.bland.ai',
  'https://www.bland.ai',
  ARRAY['ai-assistant', 'productivity'],
  'paid', false, 200,
  4.4, 680, false, true, false,
  ARRAY['Sub-300ms voice latency', 'Handles complex branching call scripts', 'CRM and webhook integrations', 'Scales to thousands of simultaneous calls', 'Human transfer handoff built in'],
  ARRAY['Not suitable for consumer use', 'Per-minute pricing adds up at high volume', 'Requires careful script design to avoid awkward conversations'],
  ARRAY['Outbound sales and lead qualification', 'Healthcare appointment reminders', 'Customer satisfaction surveys', 'Inbound support routing']
),

(
  'swell-ai',
  'Swell AI',
  'Turn podcasts and videos into written content automatically',
  'Swell AI is a content repurposing platform that converts podcast episodes, YouTube videos, and recorded interviews into written assets: show notes, blog posts, newsletters, social media clips, and transcript summaries. After uploading or linking a video, Swell AI transcribes the audio, identifies key topics, and generates structured written outputs formatted for each channel. The blog post generation produces publish-ready drafts with proper headings, pull quotes, and SEO-friendly structure rather than a raw transcript dump.

For solo creators and small content teams, Swell AI eliminates one of the most time-intensive parts of the content workflow - repurposing a single recording into multiple formats. A one-hour podcast episode can yield a 1,500-word blog post, a newsletter recap, ten tweet threads, and a LinkedIn post within minutes. The tool integrates directly with podcast RSS feeds and YouTube channels for automatic processing of new episodes. Plans start around $49/mo. It competes with Castmagic and Descript in the repurposing category but focuses more narrowly on written output quality.',
  'https://www.google.com/s2/favicons?domain=swell.ai&sz=64',
  'https://www.swell.ai',
  'https://www.swell.ai',
  ARRAY['writing-ai', 'productivity'],
  'paid', false, 49,
  4.3, 540, false, false, false,
  ARRAY['Generates multiple content formats from one recording', 'Strong blog post quality', 'Direct RSS and YouTube integration', 'SEO-structured output', 'Fast turnaround'],
  ARRAY['No free tier', 'Video repurposing less strong than audio-first content', 'Requires editing before publishing'],
  ARRAY['Podcast show notes and blog posts', 'Newsletter content from interviews', 'Social media clips from long-form video', 'YouTube video summaries']
),

(
  'podium',
  'Podium',
  'AI-powered customer messaging and reputation management for local businesses',
  'Podium is a customer communication platform built specifically for local and multi-location businesses - dental practices, car dealerships, home services, retail stores, and similar businesses that rely on in-person transactions. Its AI features automate review requests sent after service completion, respond to Google and Facebook reviews with personalized replies, manage inbound messages from multiple channels in a unified inbox, and qualify inbound leads via SMS before routing to staff. The AI texting automation can follow up with leads, collect payments, and answer common questions without human intervention.

The platform is not a general-purpose AI tool - it is purpose-built for the local business use case where Google review volume and response time to inbound inquiries directly impact revenue. Podium''s review request automation has measurable ROI for businesses where online reputation drives foot traffic. Pricing is not publicly listed and is quoted per business location, which places it in the mid-market to enterprise tier. For local business owners and franchisors looking to automate customer communication without hiring dedicated staff, Podium is the category leader.',
  'https://www.google.com/s2/favicons?domain=podium.com&sz=64',
  'https://www.podium.com',
  'https://www.podium.com',
  ARRAY['productivity', 'ai-assistant'],
  'paid', false, 399,
  4.3, 820, false, false, false,
  ARRAY['Purpose-built for local business needs', 'Automated review request sequences', 'Unified multi-channel inbox', 'SMS-based lead qualification', 'Multi-location management'],
  ARRAY['Pricing not transparent - requires sales call', 'Overkill for single-location businesses with low volume', 'Mobile app less polished than desktop'],
  ARRAY['Automating Google review collection after service', 'Managing inbound leads via SMS', 'Multi-location franchise communication', 'Responding to online reviews at scale']
),

(
  'cleanvoice-ai',
  'Cleanvoice AI',
  'Remove filler words, silences, and stutters from podcast recordings automatically',
  'Cleanvoice AI is a specialized audio editing tool that automatically detects and removes filler words (um, uh, like, you know), long silences, stutters, and mouth sounds from podcast recordings and audio interviews. After uploading a recording, Cleanvoice analyzes the audio, marks every filler instance on a timeline, and removes them automatically while preserving natural pacing. The result is a tighter recording that sounds like a professionally edited podcast without the hours of manual editing normally required.

The tool processes audio in a fraction of real time - a one-hour episode is typically cleaned in a few minutes. It handles multiple speakers, supports over 100 languages, and produces an editable timeline view where the creator can review and restore any removed segment before exporting. For solo podcasters and content creators who record themselves or interview guests, Cleanvoice addresses one of the most tedious post-production tasks. Plans start at around $10/mo for individual use, with higher tiers for teams and agencies. It integrates with standard audio formats and exports to common editing platforms.',
  'https://www.google.com/s2/favicons?domain=cleanvoice.ai&sz=64',
  'https://www.cleanvoice.ai',
  'https://www.cleanvoice.ai',
  ARRAY['voice-audio', 'productivity'],
  'freemium', true, 10,
  4.4, 720, false, false, false,
  ARRAY['Automatically removes um/uh and filler words', 'Processes audio much faster than real time', 'Editable timeline to restore removed segments', 'Supports 100+ languages', 'Simple upload-and-export workflow'],
  ARRAY['Cannot fix poor microphone quality', 'Occasionally removes intentional pauses', 'Free tier has limited minutes per month'],
  ARRAY['Podcast editing and post-production', 'Cleaning up interview recordings', 'Reducing filler words in training or course videos', 'Preparing audio for transcription services']
),

(
  'repurpose-io',
  'Repurpose.io',
  'Automatically repurpose content across social media platforms',
  'Repurpose.io is a content automation tool that takes a single piece of content - a podcast episode, YouTube video, Facebook Live, or TikTok - and automatically distributes adapted versions to other platforms on a schedule you define. It handles format conversion, adds captions automatically, trims to platform-appropriate lengths, and publishes without requiring manual intervention for each distribution. The workflow runs continuously: new content published to your primary channel is automatically processed and pushed to all connected secondary channels.

The platform is designed for creators and marketers who publish consistently but cannot afford to manually adapt every piece of content for each platform. A podcast published to RSS is automatically converted to a YouTube video with audiogram waveform animation, uploaded to LinkedIn, clipped to Reels length for Instagram, and captioned for TikTok - all without opening a timeline editor. Repurpose.io is not an AI content generator; it is an automation layer that maximizes the distribution of content you have already created. Plans start around $25/mo. It is widely used by podcast networks, marketing agencies, and solo creators who publish on a regular cadence.',
  'https://www.google.com/s2/favicons?domain=repurpose.io&sz=64',
  'https://www.repurpose.io',
  'https://www.repurpose.io',
  ARRAY['productivity', 'writing-ai'],
  'paid', false, 25,
  4.2, 490, false, false, false,
  ARRAY['Fully automated cross-platform distribution', 'Works continuously without manual triggers', 'Auto-captions for social video', 'Supports all major platforms', 'Good for high-cadence publishers'],
  ARRAY['Does not generate new content - only redistributes', 'Some platform integrations can break when APIs change', 'Less control over per-platform customization'],
  ARRAY['Automating podcast-to-social distribution', 'Repurposing YouTube videos to Reels and Shorts', 'Audiogram creation for audio content', 'Content syndication across multiple channels']
),

(
  'creatoriq',
  'CreatorIQ',
  'Enterprise influencer marketing platform with AI-powered discovery and analytics',
  'CreatorIQ is an enterprise-grade influencer marketing platform used by brands including Disney, Nestlé, and Unilever to manage influencer programs at scale. Its AI-powered creator discovery searches a database of over 15 million creators across YouTube, Instagram, TikTok, and Twitter, filtering by audience demographics, engagement rates, brand safety scores, and content alignment. Campaign management features handle contract workflows, content approval, payment processing, and performance attribution in a single platform.

The AI layer provides predicted campaign performance based on historical data from similar creators and campaigns, identifies fake follower percentages, and flags creators whose audience demographics do not match the brand''s target market before a deal is signed. For large brands running dozens of simultaneous influencer campaigns, CreatorIQ provides the measurement and workflow infrastructure to treat influencer marketing as a managed channel rather than a series of ad hoc deals. Pricing is enterprise-level and requires a custom quote. It is not suitable for small brands or individual creators; the product is designed for teams managing significant influencer marketing budgets.',
  'https://www.google.com/s2/favicons?domain=creatoriq.com&sz=64',
  'https://www.creatoriq.com',
  'https://www.creatoriq.com',
  ARRAY['seo-marketing', 'productivity'],
  'paid', false, 1000,
  4.4, 380, false, false, false,
  ARRAY['Database of 15M+ creators', 'Fake follower and brand safety detection', 'End-to-end campaign workflow', 'Audience demographics verification', 'Used by major enterprise brands'],
  ARRAY['Enterprise pricing - not for small budgets', 'Requires significant onboarding', 'Discovery database less strong for micro-influencers'],
  ARRAY['Large-scale influencer program management', 'Creator vetting before partnership', 'Campaign ROI measurement and attribution', 'Multi-platform influencer reporting']
),

(
  'scispace',
  'SciSpace',
  'AI research assistant for reading and understanding academic papers',
  'SciSpace is an AI-powered platform for reading, understanding, and summarizing academic research papers. It covers a database of over 200 million scientific papers and provides an AI assistant that can explain any passage in plain language, answer questions about a paper''s methodology, summarize findings, and generate literature review sections. The Copilot feature highlights text in a PDF and instantly provides a plain-language explanation of the concept, making dense academic writing accessible to readers outside the field.

SciSpace is used by graduate students, researchers, science journalists, and professionals who need to stay current with academic literature outside their core expertise. The literature review tool searches across its paper database for relevant research on a given topic, ranks results by citation count and relevance, and can draft a structured review with proper citations. The citation management integrates with reference managers like Zotero. Free tier includes limited Copilot queries per month. Paid plans start around $12/mo. For anyone who reads research papers regularly, SciSpace reduces the time needed to extract useful information from complex academic writing.',
  'https://www.google.com/s2/favicons?domain=typeset.io&sz=64',
  'https://typeset.io',
  'https://typeset.io',
  ARRAY['research', 'ai-assistant'],
  'freemium', true, 12,
  4.5, 1200, false, true, false,
  ARRAY['200M+ papers in database', 'Plain-language explanations of complex text', 'Literature review generation with citations', 'PDF upload for any paper', 'Free tier available'],
  ARRAY['AI explanations occasionally oversimplify nuanced findings', 'Database coverage varies by research domain', 'Citation formatting requires manual checking'],
  ARRAY['Graduate student literature reviews', 'Understanding papers outside your field', 'Research summaries for non-technical audiences', 'Staying current with academic publications']
),

(
  'perplexity-pages',
  'Perplexity Pages',
  'Create shareable AI-researched articles and reports instantly',
  'Perplexity Pages is a publishing feature within Perplexity AI that lets users generate structured, shareable articles from AI-powered research. Unlike a standard Perplexity search response, Pages produces a formatted long-form document with sections, embedded citations, and a clean reading layout suitable for sharing publicly. You describe the topic, select an audience level (beginner, intermediate, or expert), and Perplexity generates a comprehensive article pulling from current web sources with inline citations.

The output is a hosted page at a Perplexity URL that can be shared like a blog post or used as a starting point for editing into a final document. Pages are useful for generating initial research drafts, competitor analyses, topic overviews, and educational explainers quickly. Because each citation links to a live source, the content is verifiable and less susceptible to hallucination than uncited AI output. Perplexity Pages is available to all users including the free tier. Pro subscribers get access to more capable underlying models. For knowledge workers who need shareable research documents rather than just answers, Pages extends Perplexity from a search tool into a lightweight publishing platform.',
  'https://www.google.com/s2/favicons?domain=perplexity.ai&sz=64',
  'https://www.perplexity.ai/hub/getting-started/what-is-perplexity-pages',
  'https://www.perplexity.ai',
  ARRAY['research', 'writing-ai'],
  'freemium', true, 20,
  4.4, 890, false, false, false,
  ARRAY['Shareable formatted articles with citations', 'Audience level selector', 'Current web sources for up-to-date content', 'No hallucination risk from cited content', 'Free tier access'],
  ARRAY['Output requires editing before publishing as original content', 'Less control over structure than a dedicated writing tool', 'Not suitable as a replacement for original research'],
  ARRAY['Initial research drafts and outlines', 'Topic overviews for client presentations', 'Competitor and market research summaries', 'Educational explainer documents']
),

(
  'voicenotes',
  'Voicenotes',
  'Capture voice notes that are automatically transcribed and organized by AI',
  'Voicenotes is a voice journaling and note-taking app that uses AI to transcribe, summarize, and organize spoken notes. Record a voice memo on your phone, and Voicenotes transcribes it, generates a title and summary, extracts action items, and makes the content searchable across your entire history. The AI tagging system categorizes notes by topic automatically, so notes about a project, a person, or a theme are grouped together without manual filing.

The app is positioned as a friction-free alternative to typing notes on the go. For professionals who think better out loud, people who want to record ideas during commutes or walks, or anyone who finds voice faster than typing for capturing thoughts, Voicenotes removes the transcription step that made voice memos previously unusable as a productivity tool. The search across all past notes is one of its strongest features - you can find a specific idea mentioned weeks ago by searching for a keyword or asking the AI about the content. Free tier includes limited transcription minutes. Paid plans start around $8/mo for unlimited recording.',
  'https://www.google.com/s2/favicons?domain=voicenotes.com&sz=64',
  'https://www.voicenotes.com',
  'https://www.voicenotes.com',
  ARRAY['productivity', 'voice-audio'],
  'freemium', true, 8,
  4.3, 610, false, false, false,
  ARRAY['Automatic transcription and summarization', 'AI-generated titles and action items', 'Full-text search across all past notes', 'Auto-tagging by topic', 'Simple one-tap recording'],
  ARRAY['Transcription accuracy varies with background noise', 'Free tier limited in recording minutes', 'Less suitable for structured document creation'],
  ARRAY['Capturing ideas during commutes or walks', 'Voice journaling', 'Recording meeting follow-up thoughts', 'Quick note capture without typing']
)

ON CONFLICT (slug) DO NOTHING;
