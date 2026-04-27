-- compare-batch-27.sql
-- 5 comparison pairs: AI social media and email marketing tools (all tools confirmed in DB after batch-27)
-- All tools confirmed in Supabase DB before writing
-- Requires: tools-batch-27.sql confirmed in DB (sprout-social, brand24, agorapulse, later, loomly, predis-ai, metricool, omnisend, mailerlite, planable already in DB)
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: sprout-social-vs-hootsuite
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'sprout-social-vs-hootsuite',
  'sprout-social',
  'hootsuite',
  'Sprout Social and Hootsuite are the two most widely deployed enterprise social media management platforms, but they serve different points on the team-size and budget spectrum. Sprout Social is built for enterprise marketing and communications teams that need the deepest analytics, the most sophisticated social listening, and integration with CRM and customer success platforms. Its Salesforce and HubSpot integrations, premium listening module, and presentation-ready reports position it for organisations where social media is tied to revenue attribution and brand health metrics. Hootsuite covers a broader range of team sizes and use cases: it has an enterprise tier with comparable capabilities to Sprout, but its lower entry price and larger ecosystem of app integrations (150+) make it more accessible for mid-market teams, agencies, and organisations that need a capable platform without enterprise pricing. Both platforms publish to every major social network, manage a unified social inbox, offer AI caption generation, and provide analytics. The decision between them tends to come down to budget and analytics depth. Sprout Social is the stronger tool if social media analytics and CRM integration are central to how your team reports results. Hootsuite is the better starting point if you need broad platform coverage and integration flexibility at a lower entry price.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'sprout-social-vs-hootsuite', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Analytics and Reporting', 5, 4, 'Sprout Social''s analytics suite is deeper - cross-channel performance, competitor benchmarking, and paid vs organic breakdown with presentation-ready export. Hootsuite analytics are solid but less polished for executive reporting.'),
  ('Social Listening', 4, 4, 'Both offer social listening for brand mentions, keywords, and competitor tracking. Sprout''s listening module is more advanced but costs extra. Hootsuite Streams cover the basics at no additional cost.'),
  ('Publishing and Scheduling', 4, 5, 'Both have strong publishing tools. Hootsuite''s bulk scheduling and content library are slightly more developed for high-volume posting. Sprout''s publishing calendar is cleaner but less feature-dense.'),
  ('AI Content Tools', 4, 4, 'Both offer AI-generated captions and optimal posting time suggestions. Hootsuite''s OwlyWriter AI generates more content formats. Feature parity at a broad level for most teams.'),
  ('CRM and Sales Integration', 5, 3, 'Sprout Social has native Salesforce and HubSpot CRM integrations, tying social interactions to contacts and pipeline data. Hootsuite integrations with CRM platforms are less native and require more configuration.'),
  ('Platform Coverage', 4, 5, 'Both support major networks (Twitter/X, Instagram, LinkedIn, Facebook, TikTok, Pinterest, YouTube). Hootsuite''s 150+ app integrations give it broader ecosystem connectivity.'),
  ('Pricing Accessibility', 2, 3, 'Sprout Social starts at $249/month (5 profiles) - strong for large teams but expensive for small ones. Hootsuite starts at $99/month (10 profiles) and scales more gradually.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'sprout-social-vs-hootsuite')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'sprout-social-vs-hootsuite');

-- Pair 2: omnisend-vs-klaviyo
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'omnisend-vs-klaviyo',
  'omnisend',
  'klaviyo',
  'Omnisend and Klaviyo are the two strongest email and SMS marketing platforms purpose-built for e-commerce, and the choice between them is increasingly a question of complexity tolerance rather than capability gap. Klaviyo is the market leader with deeper segmentation, more advanced predictive analytics (predicted lifetime value, churn risk, next purchase date), and stronger data modelling for large catalogues. It is the tool that a dedicated email marketing manager at a serious e-commerce brand reaches for. Omnisend covers most of the same ground - abandoned cart flows, browse abandonment, post-purchase sequences, SMS alongside email, push notifications - but with a simpler setup process and pre-built automation templates that get teams live faster. The multi-channel advantage is meaningful: Omnisend includes push notifications in all tiers at no additional cost, while Klaviyo charges separately for push. Omnisend also supports more e-commerce platforms (PrestaShop, Magento, WooCommerce, BigCommerce, Shopify) while Klaviyo''s strongest integration is with Shopify. For stores with fewer than 50,000 subscribers that do not need advanced predictive analytics, Omnisend often delivers equivalent results at lower cost and setup time. For stores with large catalogues, high subscriber counts, and a dedicated email marketer, Klaviyo''s deeper data layer justifies its higher price.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'omnisend-vs-klaviyo', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('E-commerce Platform Support', 5, 4, 'Omnisend integrates natively with Shopify, WooCommerce, BigCommerce, PrestaShop, Magento, and more. Klaviyo''s strongest integration is Shopify; other platforms work but with less depth.'),
  ('Segmentation Depth', 3, 5, 'Klaviyo''s behavioural segmentation is the deepest in the category - segments updating in real time based on purchase history, browsing behaviour, and predictive attributes. Omnisend segmentation is solid but less granular.'),
  ('Predictive Analytics', 2, 5, 'Klaviyo''s predicted LTV, churn risk, and next purchase date predictions give e-commerce teams a customer intelligence layer that Omnisend does not match.'),
  ('Multi-channel (SMS and Push)', 5, 3, 'Omnisend includes email, SMS, and push notifications across all plans at no extra cost. Klaviyo charges separately for SMS and does not include push natively.'),
  ('Pre-built Automation Templates', 5, 3, 'Omnisend''s flow library is more ready-to-use out of the box, reducing setup time significantly for teams without a dedicated email marketer. Klaviyo templates require more configuration.'),
  ('Pricing at Scale', 4, 3, 'Omnisend is generally cheaper than Klaviyo at equivalent subscriber counts. Klaviyo''s cost scales faster as the list grows, which is offset by revenue attribution for high-performing stores.'),
  ('Revenue Attribution Reporting', 4, 5, 'Klaviyo''s revenue attribution tracks exact revenue per email, flow, and campaign with multi-touch analysis. Omnisend attribution is solid but less granular for large-scale performance analysis.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'omnisend-vs-klaviyo')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'omnisend-vs-klaviyo');

-- Pair 3: mailerlite-vs-mailchimp
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'mailerlite-vs-mailchimp',
  'mailerlite',
  'mailchimp',
  'Mailerlite and Mailchimp compete directly for small businesses, freelancers, and newsletter creators who need a reliable email marketing platform without the complexity of Klaviyo or ActiveCampaign. The comparison has shifted significantly in Mailerlite''s favour over the past two years as Mailchimp has raised prices and Mailerlite has expanded its feature set. Mailerlite now includes a landing page builder, website builder, pop-up builder, digital product selling, and a paid newsletter subscription feature - all at a price point that undercuts Mailchimp at most subscriber tiers. Mailchimp retains advantages in integrations (300+ vs Mailerlite''s smaller but growing library), brand recognition that some clients and partners find reassuring, and a slightly more polished drag-and-drop editor. Both offer AI writing assistance, send-time optimisation, and A/B testing. The decision between them is increasingly straightforward: if you are starting fresh or switching platforms, Mailerlite''s combination of price, feature breadth, and clean interface is the better default for most small businesses. Mailchimp is easier to justify if you need a specific integration Mailerlite does not support, or if you are already on Mailchimp and the switching cost does not justify the savings.',
  'mailerlite',
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'mailerlite-vs-mailchimp', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Pricing Value', 5, 3, 'Mailerlite is consistently cheaper than Mailchimp at equivalent subscriber counts. At 5,000 subscribers, Mailerlite costs approximately $18/month vs Mailchimp''s $75/month on comparable plans.'),
  ('Free Tier', 4, 4, 'Mailerlite offers 1,000 subscribers and 12,000 emails/month free. Mailchimp offers 500 contacts and 1,000 emails/month free. Mailerlite''s free tier is more generous for growing lists.'),
  ('Feature Breadth', 5, 4, 'Mailerlite includes landing pages, website builder, pop-ups, digital product selling, and paid newsletter subscriptions at all paid tiers. Mailchimp has most of these but at a higher price.'),
  ('Integration Ecosystem', 3, 5, 'Mailchimp integrates with 300+ tools including Shopify, WooCommerce, Salesforce, and most major platforms. Mailerlite has a smaller but growing integration library.'),
  ('AI Writing Features', 4, 4, 'Both offer AI subject line generation and email copy assistance. Neither has a standout advantage over the other on AI writing quality at this price range.'),
  ('Ease of Use', 5, 4, 'Mailerlite''s interface is consistently rated as clean and intuitive by new users. Mailchimp''s editor is capable but has accumulated complexity over years of development.'),
  ('Deliverability', 4, 4, 'Both platforms have strong deliverability reputations. No meaningful difference for most senders. Mailchimp''s larger infrastructure may offer marginal advantage at very high volume.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mailerlite-vs-mailchimp')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'mailerlite-vs-mailchimp');

-- Pair 4: agorapulse-vs-hootsuite
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'agorapulse-vs-hootsuite',
  'agorapulse',
  'hootsuite',
  'Agorapulse and Hootsuite both target social media managers and agencies who need publishing, inbox management, and reporting from one platform, but they have distinct approaches that make each better for specific team types. Agorapulse is built around inbox-first social media management: the unified social inbox that aggregates every comment, DM, mention, and review from all platforms is its central feature, with everything else (publishing, reporting, listening) built around the idea that responding to your community is as important as creating content for it. Its per-profile pricing model (not per user) is particularly favourable for agencies managing many client accounts. Hootsuite is built around publishing-first social media management: the content calendar, bulk scheduling, and broad platform support are its strongest features. Its integration ecosystem (150+ apps) is significantly larger than Agorapulse''s, and it has better brand recognition with clients. For an agency whose workflow is primarily community management, client reporting, and approval workflows, Agorapulse''s inbox management and client portal are the stronger fit. For a team whose workflow is primarily publishing at scale, content planning, and campaign management across many platforms, Hootsuite''s scheduling depth and integrations are the better choice.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'agorapulse-vs-hootsuite', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Social Inbox Management', 5, 3, 'Agorapulse''s unified inbox is its core strength - it aggregates comments, DMs, mentions, and reviews with team assignment, internal notes, and conversation labels. Hootsuite Streams cover this but less elegantly.'),
  ('Publishing and Scheduling', 4, 5, 'Hootsuite''s bulk scheduling, content library, and publishing calendar are more developed. Agorapulse scheduling is solid but secondary to its inbox management focus.'),
  ('Agency Client Management', 5, 3, 'Agorapulse''s client portal allows secure report sharing and approval workflows without client access to the full platform. Hootsuite lacks a comparable native agency portal.'),
  ('Pricing Model', 5, 3, 'Agorapulse charges per social profile (not per user), making it predictable for agencies with many accounts. Hootsuite charges per seat and per profile, which compounds quickly for larger teams.'),
  ('Integration Ecosystem', 3, 5, 'Hootsuite''s 150+ app integrations give it a substantial advantage for teams that rely on connecting social to other marketing and analytics tools. Agorapulse''s integrations are more limited.'),
  ('ROI Reporting', 5, 3, 'Agorapulse''s ROI module links social activity to Google Analytics conversions, giving social teams revenue attribution data for client reporting. Hootsuite analytics are strong but do not offer this natively.'),
  ('AI Content Tools', 4, 4, 'Both offer AI writing assistance for captions and post variations. No meaningful advantage for either platform at a feature level on AI content generation.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'agorapulse-vs-hootsuite')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'agorapulse-vs-hootsuite');

-- Pair 5: later-vs-buffer
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'later-vs-buffer',
  'later',
  'buffer',
  'Later and Buffer are both scheduling tools positioned for creators, small businesses, and social media managers who want to plan and publish content without the complexity or price of enterprise platforms like Hootsuite or Sprout Social. They overlap significantly on core functionality but have different emphases that make each a better fit for different workflows. Later is the stronger choice for visual content planning: its drag-and-drop media library and visual Instagram grid preview let you see exactly how your profile will look before any post goes live - a significant advantage for brands where aesthetic consistency matters. Its Linkin.bio tool is one of the most widely used link-in-bio pages, and its Creator subscription includes an AI caption writer and hashtag suggestions. Buffer is the stronger choice for simplicity and value: its interface is arguably the cleanest and fastest of any scheduling tool, its free plan is more useful than most competitors'' (3 channels, 10 scheduled posts each), and its analytics and engagement features are solid without being overwhelming. Buffer works well for small teams and individuals who want to schedule across multiple platforms quickly without visual planning workflows.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'later-vs-buffer', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Visual Content Planning', 5, 2, 'Later''s drag-and-drop media library and visual Instagram grid preview are its standout features for brands focused on visual aesthetic. Buffer has no equivalent visual planning view.'),
  ('Link in Bio', 5, 3, 'Later''s Linkin.bio is one of the most widely used link-in-bio tools, built natively into the platform. Buffer has a link-in-bio page but it is less developed.'),
  ('Ease of Use', 4, 5, 'Buffer''s interface is consistently rated as the cleanest and fastest to learn of any scheduling tool. Later is more powerful but takes longer to set up and understand.'),
  ('Free Plan', 3, 5, 'Buffer''s free plan covers 3 channels with 10 queued posts each - more generous than Later''s free tier. Buffer free is genuinely useful for small creators.'),
  ('AI Caption and Hashtag Tools', 4, 3, 'Later''s AI caption writer and hashtag suggestion features are built into Creator plans. Buffer''s AI assistant is available but less focused on hashtag strategy.'),
  ('Platform Coverage', 4, 4, 'Both support Instagram, Facebook, Twitter/X, LinkedIn, Pinterest, TikTok, and YouTube. Comparable platform coverage for most social media teams.'),
  ('Analytics', 4, 3, 'Later''s analytics include story analytics, hashtag performance, and best time to post recommendations. Buffer''s analytics cover the essentials but lack the visual content performance depth.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'later-vs-buffer')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'later-vs-buffer');
