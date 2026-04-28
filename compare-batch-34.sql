-- compare-batch-34.sql
-- 5 comparison pairs: AI avatar and video tools (theme matches batch-34)
-- All pairs use tools confirmed in DB (batch-34 confirmed run)
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: colossyan-vs-heygen
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'colossyan-vs-heygen',
  'colossyan',
  'heygen',
  'Colossyan vs HeyGen is the specialist corporate training platform against the most capable general-purpose AI avatar studio. Both produce high-quality presenter-led videos using digital avatars, but they are designed for different workflows and different buyers. Colossyan is built specifically for L&D teams and instructional designers: it supports SCORM and xAPI export for LMS integration, has built-in branching scenario tools for interactive e-learning, and requires only 60 seconds of source footage for custom avatar creation. The entire platform is oriented around the corporate training video workflow. HeyGen is the broader, more powerful option for teams whose output extends beyond training content. It offers 300+ avatars, real-time avatar generation, video translation into 40+ languages with lip-sync preservation, and a personalised video feature that generates hundreds of individualised videos from a single template - a workflow primarily used by sales and marketing teams. For L&D teams building out SCORM courses and internal training programmes, Colossyan''s authoring-first design and LMS compatibility make it a more natural fit. For agencies, marketing teams, and companies producing multilingual video content across multiple formats, HeyGen offers greater capability and flexibility.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'colossyan-vs-heygen', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Avatar quality and realism', 4, 5, 'HeyGen''s avatar rendering quality and facial expression naturalness are among the best in the category. Colossyan produces professional results suitable for corporate training but does not match HeyGen at the highest quality tier.'),
  ('LMS and SCORM compatibility', 5, 2, 'Colossyan exports SCORM and xAPI packages directly, integrating with most LMS platforms without additional tools. HeyGen focuses on video output rather than e-learning formats - SCORM export requires external tools.'),
  ('Video translation and multilingual output', 3, 5, 'HeyGen''s Video Translation feature dubs existing videos into 40+ languages while preserving lip sync - a capability that has no equivalent in Colossyan. Colossyan supports multilingual avatar scripts but does not offer dubbing of existing footage.'),
  ('Custom avatar creation', 4, 5, 'Both platforms support custom avatar creation from short video footage. HeyGen offers more advanced customisation options. Colossyan''s 60-second clip requirement is notably fast for enterprise custom avatar workflows.'),
  ('Branching and interactive scenario support', 5, 1, 'Colossyan has built-in branching scenario tools designed for interactive e-learning content. HeyGen is a linear video production tool and does not support branching scenarios natively.'),
  ('Personalised video at scale', 2, 5, 'HeyGen''s personalised video feature generates individualised videos from templates at scale - a key feature for sales and marketing outreach. Colossyan does not offer equivalent personalisation at scale.'),
  ('Pricing and value for L&D teams', 4, 3, 'Colossyan''s pricing is positioned for L&D budgets, with plans designed around training video volume rather than general production. HeyGen''s broad capabilities come at a higher price point, and features like video translation are credit-based.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'colossyan-vs-heygen')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'colossyan-vs-heygen');

-- Pair 2: elai-io-vs-synthesia
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'elai-io-vs-synthesia',
  'elai-io',
  'synthesia',
  'Elai.io vs Synthesia is the accessible, budget-friendly entry point against the established enterprise standard in AI avatar video. Synthesia pioneered the commercial AI avatar video category and remains the most trusted platform for enterprise and institutional buyers: 230+ avatars, 140+ languages, SOC 2 Type II compliance, GDPR certification, and SSO support make it the default choice when compliance and brand standards matter. The quality of avatars, voice synchronisation, and overall production polish is consistently high. Elai.io offers the same core capability - text-to-avatar video with multiple presenters in multiple languages - at a substantially lower price point. For teams that need professional avatar video without enterprise compliance requirements, the output quality is solid and the cost-to-value ratio is strong. The gap between the two is meaningful at the top end: Synthesia''s avatar expressiveness, compliance infrastructure, and feature depth justify the price for enterprise buyers. For smaller teams, agencies testing the format, or projects with limited budgets, Elai.io delivers 80% of the result at roughly a third of the cost. The choice is fundamentally about whether enterprise compliance and the highest level of avatar quality justify the price premium.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'elai-io-vs-synthesia', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Avatar quality and expressiveness', 3, 5, 'Synthesia''s avatars have more natural movement, better facial expression, and more consistent lip sync quality. Elai.io produces professional results but the gap in visual quality is noticeable on close comparison.'),
  ('Compliance and enterprise security', 2, 5, 'Synthesia holds SOC 2 Type II certification, GDPR compliance, and offers SSO. Elai.io has standard security measures but lacks the formal compliance certifications that enterprise procurement teams require.'),
  ('Language and voice coverage', 3, 5, 'Synthesia supports 140+ languages with native-quality voice actors. Elai.io supports 75+ languages - solid coverage for most use cases but shorter than Synthesia''s offering for global enterprise deployments.'),
  ('Pricing and accessibility', 5, 3, 'Elai.io''s starting price is significantly lower than Synthesia''s, making it accessible for smaller teams and freelancers. Synthesia''s pricing reflects its enterprise-grade capabilities but creates a meaningful barrier for budget-conscious buyers.'),
  ('Avatar library size', 3, 5, 'Synthesia offers 230+ studio avatars. Elai.io offers 80+. Both cover the range of demographic diversity needed for most global content, but Synthesia provides more choice at scale.'),
  ('Template library and workflow speed', 4, 4, 'Both platforms offer template libraries for common video types. Synthesia''s library is larger and more mature. Elai.io''s editor is intuitive and production speed is comparable for standard use cases.'),
  ('Custom avatar creation', 4, 4, 'Both platforms support custom avatar creation. Synthesia''s Express Avatar requires 5 minutes of footage; Elai.io has similar requirements. Quality of custom avatars is comparable between the two platforms.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'elai-io-vs-synthesia')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'elai-io-vs-synthesia');

-- Pair 3: kapwing-vs-veed-io
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'kapwing-vs-veed-io',
  'kapwing',
  'veed-io',
  'Kapwing vs VEED.io is two browser-based collaborative video editors competing for the same market: content teams that produce regular social and marketing video without desktop editing software. Both run entirely in the browser, support team collaboration, include AI-powered subtitle generation, and handle the full range of social video production tasks. The differences are in positioning and depth. Kapwing is built around team production workflows: shared asset libraries, brand kits, comment-based review, and a workspace designed for multiple editors working on connected projects. It is the stronger choice for marketing teams producing consistent branded content at volume, where the collaboration infrastructure reduces review cycles and asset management overhead. VEED.io takes a more creator-focused approach, with a cleaner interface, strong caption accuracy across many languages, an AI avatar and text-to-speech feature set not found in Kapwing, and a template library oriented toward social content formats. For individual creators and small teams prioritising ease of use and creator-first features, VEED.io has a slight edge. For marketing teams needing shared workspaces, brand consistency, and collaborative production, Kapwing''s team features are stronger. Both tools offer comparable output quality and pricing at equivalent tiers.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'kapwing-vs-veed-io', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Team collaboration and workspace features', 5, 3, 'Kapwing is built around shared team workspaces with asset libraries, brand kits, and comment-based review. VEED.io has team features but they are less central to the product design.'),
  ('AI subtitle accuracy and language coverage', 4, 5, 'VEED.io''s auto-subtitle accuracy is consistently strong across a wide range of languages and accents. Kapwing''s AI captions are good but VEED has a slight edge in accuracy, particularly for non-English content.'),
  ('AI avatar and text-to-speech features', 2, 4, 'VEED.io includes AI avatar creation and text-to-speech presenter features not available in Kapwing. Kapwing focuses on collaborative editing rather than AI content generation.'),
  ('Template library and format coverage', 4, 4, 'Both platforms have strong template libraries covering the main social formats. VEED.io''s templates are more creator-oriented. Kapwing''s include more branded content and marketing-focused layouts.'),
  ('Video resizing and format conversion', 5, 5, 'Both platforms handle automatic video resizing for different social platforms with equal capability. This is a core feature of both tools.'),
  ('Ease of use for individual creators', 3, 5, 'VEED.io''s interface is simpler and faster to use for individual creators who want to produce a single video without setting up a team workspace. Kapwing''s workspace model has more upfront configuration.'),
  ('Pricing and free plan value', 4, 4, 'Both tools offer comparable free tiers with watermarks and similar paid plan pricing. VEED.io''s free plan includes AI avatar access; Kapwing''s free plan includes more collaborative storage.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'kapwing-vs-veed-io')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'kapwing-vs-veed-io');

-- Pair 4: captions-ai-vs-opus-clip
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'captions-ai-vs-opus-clip',
  'captions-ai',
  'opus-clip',
  'Captions AI vs Opus Clip is the mobile-first creator studio against the leading long-form to short-form repurposing tool. Both target video creators, but they serve different parts of the creation workflow. Captions AI is a complete mobile video production app: record or import footage, generate accurate captions automatically, style and animate the text, add B-roll, adjust pacing, and publish - all from a phone. It is designed for creators who produce talking-head content and want a fast, polished, phone-native editing experience with AI automation throughout. Opus Clip solves a specific problem: take a long video (a podcast, webinar, interview, or YouTube video) and automatically identify the most engaging clips for short-form repurposing. Its AI scores each potential clip on a virality scale, identifies hooks, adds animated captions, and formats the output for TikTok, Reels, and Shorts. The two tools are largely complementary rather than competitive. Creators who produce original talking-head content typically reach for Captions AI. Creators and teams who have existing long-form video they want to repurpose into short clips reach for Opus Clip. Teams managing a content strategy across both original and repurposed content often use both. The overlap is in creators who produce short-form original content and occasionally repurpose from longer recordings.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'captions-ai-vs-opus-clip', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Original content creation workflow', 5, 2, 'Captions AI is a full mobile creation tool for recording, editing, and publishing original content. Opus Clip is designed for repurposing existing footage, not creating original content from scratch.'),
  ('Long-form to short-form repurposing', 2, 5, 'Opus Clip''s core capability is automatic clip extraction from long-form video with virality scoring and hook identification. Captions AI does not offer equivalent repurposing automation from long recordings.'),
  ('Caption quality and styling', 5, 4, 'Both produce accurate auto-captions. Captions AI has more caption style customisation for social-first visual aesthetics. Opus Clip''s captions are accurate and functional but less customisable.'),
  ('Mobile-first experience', 5, 2, 'Captions AI is built as a mobile app first. Opus Clip is primarily a web-based tool optimised for desktop upload workflows, with limited mobile functionality.'),
  ('AI content scoring and clip selection', 2, 5, 'Opus Clip''s AI scores each extracted clip on engagement potential, identifies the strongest hook, and ranks clips for social performance. Captions AI does not offer equivalent algorithmic clip analysis.'),
  ('Multi-platform format export', 4, 5, 'Both export to the standard social formats. Opus Clip''s batch export to multiple formats simultaneously is faster for high-volume repurposing workflows. Captions AI handles format conversion well for individual posts.'),
  ('Pricing for volume use', 3, 4, 'Opus Clip''s pricing is structured around video minutes, which suits high-volume repurposing. Captions AI offers a free tier and pro plans suited to individual creator volumes. Both are reasonably priced for their respective workflows.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'captions-ai-vs-opus-clip')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'captions-ai-vs-opus-clip');

-- Pair 5: filmora-vs-capcut
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'filmora-vs-capcut',
  'filmora',
  'capcut',
  'Filmora vs CapCut is the AI-enhanced desktop editor against the mobile-first short-form content platform. Both are accessible video editors with strong AI feature sets, but they serve different creators with different production habits. Filmora is a desktop application for Windows and Mac with a traditional timeline-based editing workflow, a large effects library, professional-grade audio tools, and AI features layered in: AI smart cutout, motion tracking, noise removal, speech enhancement, and an AI portrait filter. It is designed for creators who produce longer, more polished content and are comfortable with a timeline editor - YouTube videos, travel vlogs, tutorials, and branded content. CapCut is the opposite philosophy: fast, mobile-native, optimised for short-form content, with the strongest free tier in the category. Its AI features include auto-captions with animated text, AI-generated video from scripts, face effects, auto-reframe, and a template ecosystem built around trending TikTok and Reels formats. For creators whose primary output is TikTok and Instagram Reels, CapCut''s mobile speed, trend-aware templates, and deep TikTok integration make it the more practical choice. For creators producing longer or more complex video who need a proper timeline editor with professional audio tools, Filmora offers more editing control at an accessible price point.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'filmora-vs-capcut', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Timeline editing capability', 5, 3, 'Filmora offers a full multi-track timeline with professional-grade editing controls. CapCut has a simplified timeline optimised for quick short-form edits, less suited to complex multi-track productions.'),
  ('Mobile-first experience', 2, 5, 'CapCut is one of the best mobile video editors available. Filmora is primarily a desktop application with a mobile version that lacks the full feature set.'),
  ('Short-form and trending content templates', 2, 5, 'CapCut''s template library is built around current TikTok and Reels trends, updated constantly. Filmora''s templates are more general and less oriented toward short-form viral formats.'),
  ('AI features and automation', 4, 5, 'Both have strong AI feature sets. CapCut has more AI features overall, including AI video generation from scripts and more advanced face effects. Filmora''s AI tools are strong for editing enhancement - noise removal, smart cutout, motion tracking.'),
  ('Audio editing and enhancement', 5, 3, 'Filmora has professional-grade audio tools including noise removal, equaliser, audio synchronisation, and speech enhancement. CapCut''s audio editing is functional but significantly less capable for complex audio work.'),
  ('Free plan value', 3, 5, 'CapCut is free with no watermark on most features - one of the most generous free plans in the video editing category. Filmora''s free plan adds a watermark; removing it requires a paid subscription.'),
  ('Effects library and creative assets', 4, 4, 'Both have large effects, transitions, and creative asset libraries. Filmora''s library is more varied for long-form creative content. CapCut''s is more current for social content trends.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'filmora-vs-capcut')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'filmora-vs-capcut');
