-- compare-batch-17.sql
-- 5 new comparison pairs using tools already in DB
-- ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)

-- 1. klaviyo-vs-mailchimp: email marketing for e-commerce
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'klaviyo-vs-mailchimp', 'klaviyo', 'mailchimp',
  'Klaviyo and Mailchimp are both leading email marketing platforms, but they serve very different segments. Klaviyo is built specifically for e-commerce and integrates deeply with Shopify, WooCommerce, and other store platforms - its segmentation, revenue attribution, and automated flow library are optimised for the online retail workflow. Mailchimp is a general-purpose email platform that works well for newsletters, small businesses, and brands without a transaction-heavy email program. For e-commerce teams above $500k revenue, Klaviyo''s e-commerce-native features deliver significantly higher ROI. For content creators and small businesses with simpler email needs, Mailchimp is easier and more affordable.',
  'klaviyo', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'klaviyo-vs-mailchimp');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('klaviyo-vs-mailchimp', 'E-commerce Integration', 5, 3, 'Klaviyo has native Shopify and WooCommerce integration with real-time purchase data syncing. Mailchimp integrations are more generic.', 1),
  ('klaviyo-vs-mailchimp', 'Segmentation Depth', 5, 3, 'Klaviyo allows segmentation by purchase history, LTV, product viewed, and custom events. Mailchimp is limited to basic demographic and tag-based segments.', 2),
  ('klaviyo-vs-mailchimp', 'Automated Flows', 5, 4, 'Klaviyo''s flow library covers abandoned cart, winback, VIP, and post-purchase with revenue attribution. Mailchimp automations are simpler.', 3),
  ('klaviyo-vs-mailchimp', 'Ease of Use', 3, 5, 'Mailchimp has a simpler drag-and-drop editor. Klaviyo has a steeper learning curve for non-technical marketers.', 4),
  ('klaviyo-vs-mailchimp', 'Pricing', 3, 4, 'Mailchimp free tier covers 500 contacts. Klaviyo free tier covers 250 contacts. Mailchimp is cheaper at small scale; Klaviyo justifies cost at larger volumes.', 5),
  ('klaviyo-vs-mailchimp', 'SMS Marketing', 5, 2, 'Klaviyo has a mature SMS marketing feature tightly integrated with email flows. Mailchimp SMS is limited and only available in some regions.', 6),
  ('klaviyo-vs-mailchimp', 'Revenue Attribution', 5, 2, 'Klaviyo tracks exact revenue generated per email and flow. Mailchimp revenue tracking is basic and requires e-commerce integration.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'klaviyo-vs-mailchimp')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'klaviyo-vs-mailchimp');

-- 2. ideogram-vs-adobe-firefly: text-in-image vs commercial-safe generation
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'ideogram-vs-adobe-firefly', 'ideogram', 'adobe-firefly',
  'Ideogram and Adobe Firefly are both strong AI image generators, but they have different strengths and target different users. Ideogram is the best option for generating images that include accurate, legible text - a weakness of most AI image tools. Adobe Firefly is the strongest choice for commercial work where image licensing matters: it is trained exclusively on licensed Adobe Stock content, making it safe for enterprise clients with strict IP policies. Designers already on Creative Cloud will find Firefly''s integration into Photoshop and Illustrator more valuable than switching to a standalone tool.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ideogram-vs-adobe-firefly');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('ideogram-vs-adobe-firefly', 'Text Rendering in Images', 5, 2, 'Ideogram renders text inside images accurately and legibly. Firefly, like most generators, struggles with text in images.', 1),
  ('ideogram-vs-adobe-firefly', 'Commercial Safety', 3, 5, 'Firefly is trained on licensed Adobe Stock data only - the safest option for enterprise clients. Ideogram''s training data is less transparently documented.', 2),
  ('ideogram-vs-adobe-firefly', 'Creative Cloud Integration', 1, 5, 'Firefly is embedded in Photoshop, Illustrator, and Express. Ideogram is standalone only.', 3),
  ('ideogram-vs-adobe-firefly', 'Photorealism', 4, 4, 'Both produce strong photorealistic results. Firefly edges ahead for human portraits; Ideogram for graphic design styles.', 4),
  ('ideogram-vs-adobe-firefly', 'Free Tier', 5, 3, 'Ideogram offers 10 free generations per day. Firefly gives limited monthly credits on free tier.', 5),
  ('ideogram-vs-adobe-firefly', 'Pricing', 5, 3, 'Ideogram paid plans from $7/mo. Firefly is included with Creative Cloud at $54.99/mo (which includes many other tools).', 6),
  ('ideogram-vs-adobe-firefly', 'Style Range', 4, 4, 'Both support photorealistic, illustration, and graphic styles. Ideogram excels at design styles; Firefly at photographic realism.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ideogram-vs-adobe-firefly')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'ideogram-vs-adobe-firefly');

-- 3. scispace-vs-elicit: AI research tools for academia
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'scispace-vs-elicit', 'scispace', 'elicit',
  'SciSpace and Elicit are both AI research tools designed for academics and researchers, but they approach literature review differently. SciSpace is built around reading and understanding individual papers - its PDF reader explains complex concepts, generates summaries, and answers follow-up questions about specific documents. Elicit is designed for systematic literature search across large paper sets, helping users find, rank, and extract structured data from many papers at once. For deep reading of specific papers, SciSpace is better. For literature review synthesis across dozens or hundreds of papers, Elicit is the stronger choice.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'scispace-vs-elicit');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('scispace-vs-elicit', 'PDF Reading and Explanation', 5, 2, 'SciSpace''s PDF reader explains jargon, summarises sections, and answers questions about specific papers inline. Elicit lacks a PDF reading interface.', 1),
  ('scispace-vs-elicit', 'Literature Search', 4, 5, 'Elicit searches 200M+ papers and ranks by relevance to a research question. SciSpace search is good but less optimised for systematic reviews.', 2),
  ('scispace-vs-elicit', 'Structured Data Extraction', 3, 5, 'Elicit extracts structured fields (sample size, methods, results) from many papers simultaneously. SciSpace extracts from individual papers only.', 3),
  ('scispace-vs-elicit', 'Ease of Use', 5, 4, 'SciSpace has a friendlier interface for researchers new to AI tools. Elicit''s workflow is more structured and requires understanding research methodology.', 4),
  ('scispace-vs-elicit', 'Free Tier', 4, 4, 'Both have free tiers with usage limits. SciSpace free covers reading and basic questions; Elicit free covers limited searches per month.', 5),
  ('scispace-vs-elicit', 'Citation Export', 4, 5, 'Elicit exports structured citation data in multiple formats. SciSpace citation export is available but less flexible.', 6),
  ('scispace-vs-elicit', 'Collaboration', 3, 4, 'Elicit supports shared research projects. SciSpace is primarily a single-user reading tool.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'scispace-vs-elicit')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'scispace-vs-elicit');

-- 4. voiceflow-vs-intercom: AI chatbot builders
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'voiceflow-vs-intercom', 'voiceflow', 'intercom',
  'Voiceflow and Intercom both help businesses build AI-powered customer conversations, but they serve very different use cases. Voiceflow is a visual conversation designer for building custom AI agents and chatbots that can be deployed across web, mobile, WhatsApp, and voice interfaces. It is a development platform used by product and CX teams to build bespoke experiences. Intercom is a complete customer support platform with a built-in AI agent (Fin) that requires no custom development - it reads your help documentation and resolves tickets immediately after setup. For companies that need a tailored conversational experience, Voiceflow is more flexible. For customer support automation with minimal setup, Intercom is faster to value.',
  'intercom', NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'voiceflow-vs-intercom');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('voiceflow-vs-intercom', 'Time to First Value', 2, 5, 'Intercom Fin can resolve tickets within hours of setup by reading existing help docs. Voiceflow requires building conversation flows from scratch.', 1),
  ('voiceflow-vs-intercom', 'Customisation', 5, 3, 'Voiceflow allows fully custom conversation logic, branching, and API integrations. Intercom Fin is less customisable - it works within Intercom''s framework.', 2),
  ('voiceflow-vs-intercom', 'Multi-Channel Deployment', 5, 3, 'Voiceflow deploys to web chat, WhatsApp, Slack, voice, and SMS. Intercom primarily covers web and in-app chat.', 3),
  ('voiceflow-vs-intercom', 'Built-in CRM and Ticketing', 1, 5, 'Intercom is a complete customer support platform with inbox, tickets, and CRM. Voiceflow is a builder only - no support infrastructure included.', 4),
  ('voiceflow-vs-intercom', 'Analytics and Reporting', 4, 5, 'Intercom has mature support analytics with CSAT, resolution rate, and agent performance. Voiceflow analytics are conversation-focused but less business-oriented.', 5),
  ('voiceflow-vs-intercom', 'Pricing', 4, 2, 'Voiceflow free tier is available; teams from $50/mo. Intercom starts at $74/mo and scales steeply with usage.', 6),
  ('voiceflow-vs-intercom', 'Target User', 5, 4, 'Voiceflow targets CX designers and product teams building custom agents. Intercom targets support teams wanting out-of-the-box AI resolution.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'voiceflow-vs-intercom')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'voiceflow-vs-intercom');

-- 5. bland-ai-vs-vapi: AI phone call automation
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'bland-ai-vs-vapi', 'bland-ai', 'vapi',
  'Bland AI and Vapi are both platforms for building AI-powered phone call agents, but they target different buyer profiles. Bland AI is designed for enterprise sales and support teams who want to automate outbound and inbound calling at scale with a no-code campaign builder. Vapi is a developer-first API platform for building custom voice AI applications with full control over the speech stack - voice model, LLM, latency, and turn-taking logic. For non-technical teams wanting phone call automation, Bland AI is faster to deploy. For developers building sophisticated voice applications, Vapi provides the necessary depth.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'bland-ai-vs-vapi');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('bland-ai-vs-vapi', 'No-Code Setup', 5, 2, 'Bland AI has a campaign builder accessible to non-technical users. Vapi requires API integration and developer knowledge to set up.', 1),
  ('bland-ai-vs-vapi', 'Developer API Depth', 2, 5, 'Vapi exposes full control over voice model, LLM provider, turn-taking, and latency tuning. Bland AI abstracts most of this.', 2),
  ('bland-ai-vs-vapi', 'Latency', 4, 5, 'Vapi is optimised for sub-500ms response latency, critical for natural conversation feel. Bland AI latency is good but less configurable.', 3),
  ('bland-ai-vs-vapi', 'Outbound Calling at Scale', 5, 3, 'Bland AI is designed for high-volume outbound campaigns with built-in scheduling and compliance tools. Vapi focuses on the conversation layer, not campaign management.', 4),
  ('bland-ai-vs-vapi', 'Voice Quality', 4, 5, 'Vapi supports multiple TTS providers including ElevenLabs and PlayHT for highest voice quality. Bland AI uses a fixed voice model stack.', 5),
  ('bland-ai-vs-vapi', 'Pricing Model', 3, 4, 'Vapi charges per minute of call time with transparent pricing. Bland AI pricing is enterprise-oriented and less transparent for smaller use cases.', 6),
  ('bland-ai-vs-vapi', 'Documentation', 3, 5, 'Vapi has extensive developer documentation and community. Bland AI documentation is adequate but less developer-focused.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'bland-ai-vs-vapi')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'bland-ai-vs-vapi');
