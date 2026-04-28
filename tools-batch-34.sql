-- tools-batch-34.sql
-- 10 AI video editing and production tools
-- Target: DB ~362 -> ~372 tools
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

INSERT INTO tools (
  slug, name, tagline, description, logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick, pros, cons, use_cases
) VALUES

('kapwing',
 'Kapwing',
 'Online collaborative video editor for modern content teams',
 'Kapwing is a browser-based video editor built for collaborative content production. Teams can edit, subtitle, resize, and publish video without installing software, working from a shared workspace with asset libraries, brand kits, and comment-based review workflows. The AI-powered subtitle generator is fast and accurate across 70+ languages, and the auto-resize feature converts horizontal video to vertical formats in one click for Instagram, TikTok, and YouTube Shorts. The background removal tool runs in the browser at no extra cost, and the AI video summarisation feature generates caption text and show notes from uploaded content. Kapwing is positioned between simple consumer editors like CapCut and professional desktop suites - it handles the full range of social content production tasks without the friction of desktop software installation. For marketing teams producing regular social video content, the collaboration features and team workspace reduce review cycles and asset management overhead significantly.',
 'https://www.google.com/s2/favicons?domain=kapwing.com&sz=64',
 'https://kapwing.com', 'https://go.mytheai.com/kapwing',
 ARRAY['video-generation', 'design', 'productivity'],
 'freemium', true, 24.00,
 4.1, 487, false, false, false,
 ARRAY['Browser-based with no software installation required', 'Strong collaboration features with team workspace and brand kit', 'Auto-resize converts video to vertical formats for all platforms'],
 ARRAY['Export quality limited on free plan', 'Less powerful than desktop editors for complex multi-track projects', 'Slower processing for long-form video compared to native apps'],
 ARRAY['Social media content teams producing multi-platform video', 'Collaborative video editing without desktop software', 'Adding subtitles and resizing video for short-form distribution']
),

('colossyan',
 'Colossyan',
 'AI avatar video platform for enterprise training and L&D teams',
 'Colossyan is an AI avatar video creation platform designed specifically for corporate training, compliance content, and internal communications. The platform provides a library of realistic AI avatars in diverse demographics, a multi-scene video editor for building structured training modules, and an interactive video feature that embeds knowledge checks and branching scenarios directly into the video player. The interactive capability is particularly valuable for compliance training where engagement metrics and completion rates need to be tracked. Colossyan integrates with major LMS platforms including Cornerstone, Docebo, and SAP SuccessFactors, and supports SCORM and xAPI export for seamless integration with existing learning management infrastructure. Custom avatar creation allows organisations to build a branded AI presenter from a short video recording. The collaborative workspace enables L&D teams to work together on script review, avatar selection, and content approval without leaving the platform. Colossyan is ISO 27001 certified and meets enterprise data handling requirements for regulated industries.',
 'https://www.google.com/s2/favicons?domain=colossyan.com&sz=64',
 'https://colossyan.com', 'https://go.mytheai.com/colossyan',
 ARRAY['video-generation', 'operations', 'productivity'],
 'paid', false, 28.00,
 4.2, 312, false, false, false,
 ARRAY['Interactive video with embedded knowledge checks for compliance training', 'LMS integrations with SCORM and xAPI export', 'ISO 27001 certified for enterprise data security requirements'],
 ARRAY['More expensive than general-purpose avatar tools', 'Best value for teams with high training video volume', 'Avatar customisation options fewer than HeyGen'],
 ARRAY['Corporate compliance training video production at scale', 'Enterprise L&D teams building LMS-integrated training modules', 'Internal communications and onboarding video with AI avatars']
),

('elai-io',
 'Elai.io',
 'AI avatar video creation for growing businesses',
 'Elai.io makes AI avatar video creation accessible to teams that need professional video output without enterprise pricing. The platform converts text scripts into polished avatar-narrated videos using a library of over 80 diverse AI avatars, with accurate lip sync across 75+ languages. The text-to-video builder imports blog posts, URLs, or documents and assembles them into structured video presentations, reducing the time from content to video from hours to minutes. Custom avatar creation allows teams to build a branded AI presenter from a five-minute video recording. The template library covers the most common business video use cases: product demos, customer onboarding, training modules, internal announcements, and social content. The built-in video editor supports multi-scene projects, background customisation, and screen recording integration. Elai is particularly popular with SaaS companies producing product walkthroughs and customer education content at scale without maintaining a video production team.',
 'https://www.google.com/s2/favicons?domain=elai.io&sz=64',
 'https://elai.io', 'https://go.mytheai.com/elai-io',
 ARRAY['video-generation', 'productivity', 'operations'],
 'freemium', true, 29.00,
 4.1, 276, false, false, false,
 ARRAY['75+ language support with accurate lip sync for multilingual content', 'Text-to-video converts blog posts and documents into avatar videos automatically', 'Custom avatar creation from a short video recording'],
 ARRAY['Avatar realism below HeyGen for close-up shots', 'Advanced customisation requires higher-tier plans', 'Limited to avatar-based video - not suitable for live footage editing'],
 ARRAY['SaaS product demo and customer onboarding video at scale', 'Multilingual training and support video creation', 'Marketing teams converting written content into video without a production team']
),

('captions-ai',
 'Captions',
 'AI video creator and editor for content creators',
 'Captions is an AI-powered video creation and editing tool built specifically for the creator-to-camera workflow. Its Eye Contact Correction feature adjusts the speaker''s gaze to maintain direct eye contact even when reading from notes or a teleprompter - a meaningful improvement for creators who use scripts. One-click filler word removal cleans up hesitations and false starts across an entire recording automatically. The animated caption styles are optimised for TikTok, Reels, and YouTube Shorts retention, with emoji reactions and motion typography that match platform aesthetics. The AI Script Writer generates content ideas and full scripts from a topic, and the built-in teleprompter integration enables creators to go from idea to recorded video in a single session. AI-generated B-roll suggestions surface relevant stock footage to cut away from talking-head sections. Captions processes everything on-device for mobile, ensuring footage stays private. The studio version supports desktop editing workflows with a full timeline editor for longer-form content.',
 'https://www.google.com/s2/favicons?domain=captions.ai&sz=64',
 'https://captions.ai', 'https://go.mytheai.com/captions-ai',
 ARRAY['video-generation', 'productivity', 'ai-assistants'],
 'freemium', true, 19.99,
 4.3, 523, false, false, false,
 ARRAY['Eye Contact Correction maintains direct gaze even when using a teleprompter', 'One-click filler word removal across entire recordings', 'AI Script Writer and teleprompter in one workflow'],
 ARRAY['Primarily optimised for creator-to-camera content, less suited for multi-person footage', 'Advanced features require paid subscription', 'On-device processing may be slower on older devices'],
 ARRAY['TikTok and Instagram Reels content creation with AI captions', 'Direct-to-camera content with eye contact correction', 'Creator workflow from script generation to published short-form video']
),

('munch',
 'Munch',
 'AI video repurposing with trend analysis and social intelligence',
 'Munch is an AI video repurposing platform that extracts the most engaging moments from long-form content and packages them for short-form distribution. Where basic clip tools detect silence and cut on transitions, Munch uses topic modelling and social trend analysis to identify moments that are likely to perform well on each specific platform. It evaluates clips against current trends on LinkedIn, Instagram, TikTok, and Twitter, scores each clip by predicted engagement, and suggests captions and post copy tailored to the platform. The auto-generated subtitles and caption formatting are platform-specific - the visual style for LinkedIn differs from TikTok. The analytics dashboard shows performance data across platforms to refine future clip selection. Munch is particularly strong for B2B content teams repurposing webinars, conference talks, and thought leadership interviews into a consistent library of short-form clips. The multi-user workspace allows social media managers and content strategists to collaborate on clip review and scheduling.',
 'https://www.google.com/s2/favicons?domain=munchies.tv&sz=64',
 'https://munchies.tv', 'https://go.mytheai.com/munch',
 ARRAY['video-generation', 'seo-marketing', 'productivity'],
 'freemium', true, 49.00,
 4.1, 234, false, false, false,
 ARRAY['Social trend analysis scores clips by predicted platform engagement', 'Platform-specific caption and post copy generation', 'Multi-user workspace for team-based clip review and scheduling'],
 ARRAY['Higher price point than simpler repurposing tools', 'Trend analysis works best for content that overlaps with social trends', 'Less effective for niche B2B content that does not match popular topics'],
 ARRAY['B2B teams repurposing webinars and conference talks into social clips', 'Social media managers building a consistent short-form clip library', 'Content teams automating the long-form to short-form distribution workflow']
),

('wisecut',
 'Wisecut',
 'Automatic video editor that cuts on silence and adds subtitles',
 'Wisecut is an automatic video editing tool that reduces the most repetitive parts of video post-production. It automatically detects and removes silent pauses and long gaps from talking-head footage, adds and synchronises subtitles, applies background music with automatic volume ducking, and generates a punchy edit from raw footage without manual cutting. The one-click workflow makes it particularly useful for educators, online course creators, and anyone recording long tutorial or explanation videos that benefit from tight editing. The Storyboard feature lets creators review the automatically detected cuts and reorder or remove segments before export. Wisecut supports cloud processing of uploaded footage, meaning any device with a browser can use it without local processing requirements. For solo creators and educators who find video editing the biggest barrier to consistent content production, Wisecut reduces a 30-minute edit to a 5-minute review.',
 'https://www.google.com/s2/favicons?domain=wisecut.video&sz=64',
 'https://wisecut.video', 'https://go.mytheai.com/wisecut',
 ARRAY['video-generation', 'productivity', 'ai-assistants'],
 'freemium', true, 10.00,
 4.0, 198, false, false, false,
 ARRAY['Automatic silence removal dramatically reduces editing time for talking-head content', 'Storyboard review lets creators approve cuts before final export', 'Accessible price point makes it practical for solo creators and educators'],
 ARRAY['Best suited to talking-head content - less effective for complex multi-camera footage', 'Limited colour grading and visual effects compared to traditional editors', 'Automatic cuts occasionally remove intentional pauses for emphasis'],
 ARRAY['Online course and tutorial video editing with silence removal', 'Solo educators and creators reducing editing time for long-form content', 'Automatic subtitle generation and background music for instructional video']
),

('steve-ai',
 'Steve.AI',
 'Text-to-video platform for marketing and explainer content',
 'Steve.AI converts scripts, blog posts, and text prompts into marketing videos using stock footage, AI voiceover, and automated editing. The workflow is designed for volume: enter a script or URL, choose a template, and the platform assembles a complete video with relevant stock footage, transitions, and branded elements. The result is an edited video ready for social distribution without filming, recording, or manual editing. Steve.AI is particularly used by marketing agencies and in-house teams that need to produce explainer videos, social content, and product announcements at high volume without a dedicated video production resource. The live-to-animated conversion feature turns recorded footage into an illustrated or animated style, which is useful for teams that want a branded visual identity without realistic footage. The voiceover library covers 28 languages, and the text-to-speech engine produces clear, neutral narration suitable for corporate content.',
 'https://www.google.com/s2/favicons?domain=steve.ai&sz=64',
 'https://steve.ai', 'https://go.mytheai.com/steve-ai',
 ARRAY['video-generation', 'seo-marketing', 'productivity'],
 'freemium', true, 20.00,
 4.0, 312, false, false, false,
 ARRAY['URL-to-video converts blog posts into videos automatically', 'High-volume production at low cost per video', 'Live-to-animated conversion adds branded visual identity to recorded content'],
 ARRAY['Output quality dependent on stock footage relevance to script', 'Less creative control than manual video editing', 'AI voiceover less natural than ElevenLabs or Murf'],
 ARRAY['Marketing teams producing explainer videos at high volume from existing content', 'Social media content creation from blog posts and scripts', 'Agencies automating video production for multiple clients']
),

('vmaker',
 'Vmaker',
 'AI-powered screen recorder and video creation suite',
 'Vmaker is a screen recording and video creation tool that combines asynchronous video communication with AI-powered editing. The screen recorder captures desktop, browser, camera, and audio simultaneously, with a clean floating toolbar that keeps the recording workflow unobtrusive. The AI editor removes filler words, trims silences, and generates video chapters and summaries automatically from the recording. The AI voice changer module replaces the recorded voice with a selected AI voice, which is useful when the recording environment produced unwanted background noise. The team features allow video collections to be organised by project, shared with specific viewers, and tracked for engagement with view analytics. Vmaker is used by sales teams for personalised video outreach, customer success for async product walkthroughs, and product teams for sprint demos and design reviews. The workspace integrations with Notion, Slack, and HubSpot reduce the friction of sharing videos in existing workflows.',
 'https://www.google.com/s2/favicons?domain=vmaker.com&sz=64',
 'https://vmaker.com', 'https://go.mytheai.com/vmaker',
 ARRAY['video-generation', 'productivity', 'team-collaboration'],
 'freemium', true, 15.00,
 4.0, 267, false, false, false,
 ARRAY['AI voice changer replaces recorded audio with a clean AI voice', 'Auto-generated chapters and summaries from recorded content', 'Team workspace with Notion, Slack, and HubSpot integration'],
 ARRAY['Less feature-rich for complex video editing compared to Descript', 'AI editing features require higher-tier plans', 'Less established than Loom for async video communication'],
 ARRAY['Sales teams creating personalised async video outreach', 'Product teams sharing sprint demos and design review recordings', 'Customer success walkthrough videos with AI-cleaned audio and summaries']
),

('topaz-video-ai',
 'Topaz Video AI',
 'AI video upscaling and enhancement for filmmakers and archivists',
 'Topaz Video AI is the leading desktop application for AI-powered video upscaling, frame interpolation, and restoration. Where other video tools generate new content, Topaz enhances existing footage - converting 1080p recordings to 4K without visible artefacts, restoring old or heavily compressed footage, and generating smooth slow-motion sequences from standard frame rates through AI frame interpolation. The application processes video entirely on-device using the local GPU, which means there are no cloud credits, no upload limits, and no subscription fees per video. A one-time purchase or annual plan gives unlimited processing. The Gaia, Proteus, and Iris AI models handle different types of footage and enhancement goals, with the model selection guide helping users choose the right enhancement approach for their source material. Topaz Video AI is used by independent filmmakers working with archival footage, content creators upscaling screen recordings or older camera footage, and broadcasters restoring legacy content for modern distribution.',
 'https://www.google.com/s2/favicons?domain=topazlabs.com&sz=64',
 'https://topazlabs.com', 'https://go.mytheai.com/topaz-video-ai',
 ARRAY['video-generation', 'design', 'coding-tools'],
 'paid', false, 99.00,
 4.3, 412, false, false, false,
 ARRAY['On-device processing with no cloud credits or upload limits', 'Industry-leading upscaling quality with multiple AI models', 'One-time purchase option for unlimited processing'],
 ARRAY['Requires capable GPU for reasonable processing speed', 'Desktop-only - no browser or mobile version', 'High one-time purchase price relative to monthly subscription alternatives'],
 ARRAY['Upscaling archival or low-resolution footage to 4K', 'Creating smooth slow-motion from standard frame rate footage', 'Restoring old or compressed video for modern distribution']
),

('filmora',
 'Wondershare Filmora',
 'AI-enhanced video editor for creators and professionals',
 'Wondershare Filmora is a mainstream video editor that has integrated AI features throughout its editing workflow without sacrificing accessibility for non-professional users. The AI Copilot editor answers questions and applies edits via natural language commands, removing the need to memorise menu locations for common tasks. The AI Portrait Background Remover works in real time on camera footage, the AI Audio Stretch adapts music tracks to match video length automatically, and the AI Text-to-Video feature generates animated content from written descriptions. The asset library includes motion elements, sound effects, titles, and stock footage, reducing the need for external resources. Filmora supports multi-track timelines, colour grading tools, keyframe animation, and export to all major formats. It is positioned between beginner tools like CapCut and professional-grade tools like DaVinci Resolve - covering the full range of creator and small production team needs at an accessible price. The perpetual licence option makes it cost-effective for frequent users who prefer not to pay a subscription.',
 'https://www.google.com/s2/favicons?domain=wondershare.com&sz=64',
 'https://filmora.wondershare.com', 'https://go.mytheai.com/filmora',
 ARRAY['video-generation', 'design', 'productivity'],
 'freemium', true, 49.99,
 4.1, 789, false, false, false,
 ARRAY['AI Copilot applies edits via natural language commands', 'Full multi-track timeline with colour grading and keyframe animation', 'Perpetual licence option available for frequent users'],
 ARRAY['AI features less integrated than dedicated AI-first tools', 'Asset library smaller than industry leaders like Adobe Premiere', 'Annual subscription required to access all AI features'],
 ARRAY['Creator and small team video production with AI-assisted editing', 'Marketing teams needing a full-featured editor without professional software cost', 'Content creators moving from basic mobile editors to desktop-grade production']
)

ON CONFLICT (slug) DO NOTHING;
