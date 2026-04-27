-- tools-batch-27.sql
-- AI Marketing Tools: social media management + email marketing (10 tools)
-- DB: ~292 tools -> ~302 tools
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING
-- Confirmed NOT in DB: sprout-social, brand24, agorapulse, later, loomly, predis-ai, metricool, omnisend, mailerlite, planable
-- Already in DB (skipped): buffer (batch-7), hootsuite (batch-8), anyword (batch-8), taplio (batch-11), activecampaign (batch-6), beehiiv (batch-6)

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES

-- 1. Sprout Social
(
  'sprout-social', 'Sprout Social', 'Enterprise social media management with deep analytics and AI-powered insights',
  'Sprout Social is an enterprise-grade social media management platform used by over 30,000 brands including Unicef, Dropbox, and Subaru. It covers publishing, engagement, analytics, and social listening across every major platform - Twitter/X, Instagram, LinkedIn, Facebook, TikTok, Pinterest, and YouTube - from a unified inbox and calendar. Its AI features include suggested optimal posting times based on historical engagement data, AI-generated caption variations, sentiment analysis on incoming messages, and automated routing of support queries to the right team member. The analytics suite is one of the strongest in the category: cross-channel performance reports, competitor benchmarking, and paid vs organic performance breakdown in a single dashboard. Sprout''s listening tool monitors brand mentions, industry keywords, and competitor activity in real time, surfacing trend alerts before they peak. The approval workflow and publishing calendar make it well-suited to larger teams with content review requirements. Sprout Social integrates with Salesforce, HubSpot, Zendesk, and Google Analytics, making it a natural fit for organisations where social media is integrated into the broader marketing and customer success stack.',
  'https://www.google.com/s2/favicons?domain=sproutsocial.com&sz=64',
  'https://sproutsocial.com', 'https://sproutsocial.com',
  ARRAY['marketing', 'social-media', 'analytics'],
  'paid', false, 249.00,
  4.4, 4800, false, false, false,
  ARRAY['Comprehensive analytics with competitor benchmarking', 'Unified inbox across all social platforms', 'Strong social listening and trend monitoring', 'Enterprise approval workflows and team management'],
  ARRAY['Expensive for small teams - starts at $249/month', 'Feature depth requires onboarding investment', 'Social listening adds significant cost on top of base plan'],
  ARRAY['Marketing teams managing social at enterprise scale', 'Agencies reporting social performance to multiple clients', 'Brand and PR teams monitoring share of voice and sentiment']
),

-- 2. Brand24
(
  'brand24', 'Brand24', 'AI-powered social media monitoring and brand intelligence platform',
  'Brand24 is a social media monitoring and brand intelligence platform that tracks mentions of your brand, products, competitors, and industry keywords across social media, news sites, blogs, forums, podcasts, and review platforms in real time. Its AI analyses the sentiment behind every mention - positive, negative, or neutral - and assigns an influence score to the source so you can prioritise responses to high-reach conversations. The Anomaly Detector alerts you when mention volume spikes unexpectedly, giving PR and community teams early warning of viral moments or reputation incidents. Brand24''s AI reports generate a weekly summary of brand health, top-performing content, and competitive landscape automatically, reducing the manual work of social listening to reading the summary rather than sorting through raw data. The Share of Voice metric compares your brand''s mention volume and sentiment against up to 10 competitors, giving marketing teams a clear view of relative market positioning. Brand24 integrates with Slack, Microsoft Teams, and email for alert delivery. Used by companies including IKEA, Intel, and Twitch for brand reputation monitoring and competitive intelligence.',
  'https://www.google.com/s2/favicons?domain=brand24.com&sz=64',
  'https://brand24.com', 'https://brand24.com',
  ARRAY['marketing', 'analytics', 'ai-assistant'],
  'paid', false, 99.00,
  4.5, 1600, false, false, false,
  ARRAY['Real-time brand monitoring across social, news, and forums', 'AI sentiment analysis and influence scoring on every mention', 'Anomaly Detector for early reputation incident warnings', 'Competitor Share of Voice tracking'],
  ARRAY['No free plan - 14-day trial only', 'Historical data limited on lower plans', 'Coverage of some niche platforms less comprehensive than Brandwatch'],
  ARRAY['PR and communications teams monitoring brand reputation', 'Marketing teams tracking campaign impact and competitor mentions', 'Customer success teams identifying untagged support queries on social']
),

-- 3. Agorapulse
(
  'agorapulse', 'Agorapulse', 'Social media management platform built for agencies and in-house marketing teams',
  'Agorapulse is a social media management platform designed to handle the full workflow of a busy social media team or agency: publishing, scheduling, inbox management, reporting, and team collaboration. Its unified social inbox aggregates every comment, mention, DM, and review from all connected platforms into a single queue, with the ability to assign conversations to team members, add internal notes, and apply labels for routing. The AI Writing Assistant generates caption variations for any platform, adapts tone and length for each social network, and can translate posts for multilingual audiences. Agorapulse''s ROI reporting module links social media activity to website traffic and conversions via Google Analytics integration, giving social teams the revenue attribution data they need to justify budget. The listening feature monitors hashtags, keywords, and competitor accounts across Twitter/X and Instagram. For agencies, Agorapulse''s client portal allows secure report sharing and approval workflows without giving clients access to the full platform. Flat pricing per profile (rather than per user) makes it more predictable than per-seat tools for agencies managing many accounts. Integrates with Canva, Google Drive, Dropbox, and Slack.',
  'https://www.google.com/s2/favicons?domain=agorapulse.com&sz=64',
  'https://agorapulse.com', 'https://agorapulse.com',
  ARRAY['marketing', 'social-media', 'ai-assistant'],
  'freemium', true, 0.00,
  4.5, 2100, false, false, false,
  ARRAY['Unified inbox with assignment and labelling for team management', 'ROI reporting links social activity to Google Analytics conversions', 'Client portal for agency reporting without full platform access', 'Flat per-profile pricing predictable for agencies'],
  ARRAY['Listening features less powerful than Sprout Social or Brandwatch', 'Mobile app less capable than desktop', 'Free plan limited to 1 social profile'],
  ARRAY['Digital marketing agencies managing social for multiple clients', 'In-house social media teams needing inbox management and approval workflows', 'Brands measuring social media ROI against website conversions']
),

-- 4. Later
(
  'later', 'Later', 'Visual social media scheduling platform with AI caption writing and link-in-bio tools',
  'Later is a visual social media scheduling platform built around Instagram-first workflows that has expanded to cover TikTok, Pinterest, LinkedIn, Facebook, and Twitter/X. Its drag-and-drop visual planner lets social media managers plan a feed''s aesthetic appearance before publishing - seeing how scheduled posts will look as a grid before they go live. The AI Caption Writer generates captions from a brief prompt or repurposes existing content into platform-specific variations, adjusting tone and hashtag style for each network. Later''s Best Time to Post feature analyses your account''s historical engagement data to recommend optimal posting windows for each day of the week on each platform. The Linkin.bio tool converts any Instagram post into a clickable landing page, allowing e-commerce brands to drive direct traffic from Instagram without requiring link changes. Later''s analytics track reach, impressions, engagement rate, and follower growth for every post. The media library stores all visual assets with search, labels, and team access controls. Later is particularly strong for visual brands, e-commerce companies, and creator-led businesses where Instagram and TikTok are the primary channels.',
  'https://www.google.com/s2/favicons?domain=later.com&sz=64',
  'https://later.com', 'https://later.com',
  ARRAY['marketing', 'social-media', 'ai-assistant'],
  'freemium', true, 0.00,
  4.4, 3200, false, false, false,
  ARRAY['Visual grid planner for Instagram feed aesthetic', 'AI Caption Writer adapts content to each platform tone', 'Linkin.bio converts posts to clickable landing pages', 'Best Time to Post recommendations from historical data'],
  ARRAY['Less suitable for text-heavy platforms like Twitter/LinkedIn', 'Advanced analytics only on higher plans', 'Automation rules less powerful than Hootsuite or Sprout Social'],
  ARRAY['E-commerce brands using Instagram and TikTok as primary sales channels', 'Lifestyle and fashion brands managing visual content calendars', 'Creator agencies scheduling content for influencer clients']
),

-- 5. Loomly
(
  'loomly', 'Loomly', 'Collaborative social media calendar and content management platform',
  'Loomly is a social media management and content calendar platform designed for teams that need strong collaboration, review, and approval workflows before publishing. Its interface is built around a calendar view that shows all scheduled content across every social platform in a single timeline, making it easy for marketing managers to see gaps, conflicts, and campaign timing at a glance. Loomly''s Post Ideas feature generates content suggestions based on RSS feeds, trending topics, Twitter trends, and date-based events - giving social media managers a starting point when content planning stalls. The AI writing assistance helps draft captions and adapt them to each platform''s character limits and tone. The approval workflow allows multiple stakeholder rounds - social media manager drafts, marketing manager reviews, client or legal sign-off - with full comment trails and change history for accountability. Loomly''s analytics cover organic and paid performance across Facebook, Instagram, LinkedIn, Pinterest, and Twitter/X, with audience growth, engagement, and reach data. The custom roles and permissions system makes it suitable for agencies with multiple client accounts or enterprise teams with complex approval requirements.',
  'https://www.google.com/s2/favicons?domain=loomly.com&sz=64',
  'https://loomly.com', 'https://loomly.com',
  ARRAY['marketing', 'social-media', 'productivity'],
  'paid', false, 42.00,
  4.5, 1900, false, false, false,
  ARRAY['Strong multi-stage approval workflows with comment trails', 'Calendar view shows all content across platforms simultaneously', 'Post Ideas feature surfaces trending topics and event-based suggestions', 'Custom roles and permissions for agency client management'],
  ARRAY['No free plan - 15-day trial only', 'Social listening not included', 'Analytics less granular than Sprout Social'],
  ARRAY['Marketing agencies managing multi-stakeholder content approval', 'Enterprise brands with legal or compliance review requirements', 'Marketing teams planning integrated campaigns across multiple platforms']
),

-- 6. Predis.ai
(
  'predis-ai', 'Predis.ai', 'AI-first social media content generator for posts, reels, and carousels',
  'Predis.ai is an AI-native social media content generation platform that creates complete branded posts - image, video, caption, and hashtags - from a text prompt in seconds. Unlike traditional scheduling tools that require you to create content before scheduling, Predis generates ready-to-publish social media content from a product description, URL, or keyword, adapting the output to each platform''s optimal format. For Instagram, it creates single-image posts, carousel slide decks, and short video reels. For LinkedIn, it generates professional-tone text posts with supporting visuals. For Twitter/X, it drafts thread formats. The brand kit feature stores your fonts, colours, and logo so every generated piece matches brand guidelines automatically. Predis''s competitor analysis tool generates weekly reports on a competitor''s top-performing posts, identifying content formats and topics that are driving their highest engagement. The bulk post generation feature allows marketing teams to create 30 days of social content in a single session. Predis integrates with Canva, allowing generated templates to be fine-tuned before publishing. Particularly strong for small businesses, solo marketers, and e-commerce brands that want consistent social presence without a dedicated design team.',
  'https://www.google.com/s2/favicons?domain=predis.ai&sz=64',
  'https://predis.ai', 'https://predis.ai',
  ARRAY['marketing', 'social-media', 'ai-assistant'],
  'freemium', true, 0.00,
  4.3, 1100, false, false, false,
  ARRAY['Generates complete posts (image + caption + hashtags) from a prompt', 'Brand kit ensures generated content matches brand guidelines', 'Competitor post analysis identifies high-performing content patterns', 'Bulk content generation for 30-day social calendars'],
  ARRAY['AI-generated visuals less polished than professionally designed content', 'Less suited for enterprise teams with complex approval needs', 'Video generation quality still maturing vs image posts'],
  ARRAY['Small businesses needing consistent social content without design resources', 'E-commerce brands generating product-focused social posts at scale', 'Solo marketers managing multiple client social accounts efficiently']
),

-- 7. Metricool
(
  'metricool', 'Metricool', 'All-in-one social media analytics and scheduling platform',
  'Metricool is a social media analytics and scheduling platform that combines content planning, performance reporting, and competitor analysis in a single tool. It supports every major social platform - Instagram, TikTok, LinkedIn, Twitter/X, Facebook, Pinterest, YouTube, and Google Business Profile - as well as Google Ads and Facebook Ads, making it one of the few tools that combines organic and paid social analytics in one dashboard. The SmartLinks feature creates a link-in-bio page that tracks click-through rates for each link, giving content creators and brands visibility into which posts are driving actual website traffic. Metricool''s best-time-to-post analysis reviews your account history and identifies the specific hours and days when your audience is most active and most likely to engage. The competitor analysis feature benchmarks your performance against up to 100 competitor profiles, tracking their follower growth, post frequency, and top content. The AI assistant generates post captions and content ideas. Metricool is particularly strong for performance-focused social media managers who want a single dashboard for both organic social and paid advertising analytics, without the cost of enterprise platforms like Sprout Social.',
  'https://www.google.com/s2/favicons?domain=metricool.com&sz=64',
  'https://metricool.com', 'https://metricool.com',
  ARRAY['marketing', 'social-media', 'analytics'],
  'freemium', true, 0.00,
  4.4, 2400, false, false, false,
  ARRAY['Combines organic and paid social analytics in one dashboard', 'Competitor benchmarking against up to 100 profiles', 'SmartLinks tracks click-throughs from each social post', 'Google Business Profile integration included'],
  ARRAY['Interface less polished than Sprout Social or Later', 'Team collaboration features less developed than competitors', 'Free plan limited to one brand with 1 profile per platform'],
  ARRAY['Performance marketers tracking both paid and organic social in one tool', 'Content creators monitoring competitor posting strategies', 'Small businesses managing social presence and Google Business Profile together']
),

-- 8. Omnisend
(
  'omnisend', 'Omnisend', 'E-commerce email and SMS marketing automation platform',
  'Omnisend is an email and SMS marketing automation platform built specifically for e-commerce brands. Where general-purpose email tools require manual integration with online stores, Omnisend connects natively with Shopify, WooCommerce, BigCommerce, and Wix, automatically syncing product data, purchase history, and customer behaviour for use in segmentation and automation triggers. Its pre-built automation workflows cover the e-commerce essentials: welcome sequences, abandoned cart recovery, post-purchase follow-ups, browse abandonment, and win-back campaigns - all with SMS and email working together in the same automation flow. Omnisend''s product picker lets you add live product listings with images and prices directly into emails without leaving the editor. The segmentation engine builds audiences from any combination of purchase history, web behaviour, email engagement, and lifecycle stage. Omnisend''s AI subject line generator and send-time optimisation improve open rates without A/B testing overhead. The platform sends over 100 million messages per month and is used by over 100,000 e-commerce brands. Compared to Klaviyo, Omnisend is notably easier to set up and more affordable on lower tiers, making it the preferred choice for brands under $5M annual revenue.',
  'https://www.google.com/s2/favicons?domain=omnisend.com&sz=64',
  'https://omnisend.com', 'https://omnisend.com',
  ARRAY['marketing', 'email-marketing', 'ai-assistant'],
  'freemium', true, 0.00,
  4.5, 3100, false, false, false,
  ARRAY['Native Shopify, WooCommerce, and BigCommerce integrations', 'Email and SMS in the same automation workflow', 'Pre-built abandoned cart and post-purchase automation', 'Product picker adds live listings to emails directly'],
  ARRAY['Advanced segmentation less flexible than Klaviyo on enterprise plans', 'SMS available in fewer countries than email', 'Reporting less detailed than Klaviyo''s revenue attribution'],
  ARRAY['E-commerce brands launching email and SMS automation for the first time', 'DTC brands combining abandoned cart email with SMS recovery', 'Shopify stores needing email marketing without Klaviyo''s complexity or price']
),

-- 9. MailerLite
(
  'mailerlite', 'MailerLite', 'Affordable email marketing platform with AI content tools and newsletter monetisation',
  'MailerLite is an email marketing platform known for its clean interface, generous free plan, and strong value for small businesses and independent creators. Its drag-and-drop email builder and pre-designed templates allow teams without design expertise to produce professional newsletters and campaigns quickly. The AI writing assistant generates email body copy, subject lines, and CTA text from a brief prompt, reducing the time to draft a campaign from hours to minutes. MailerLite''s automation builder handles welcome sequences, birthday emails, abandoned cart flows for e-commerce integrations, and re-engagement campaigns with a visual logic editor. The newsletter monetisation features - paid newsletter subscriptions, digital product sales, and website builder - make it a strong alternative to Beehiiv and Substack for creators who want to sell directly from their email list. MailerLite''s free plan allows 12,000 emails per month to up to 1,000 subscribers, which is substantially more generous than Mailchimp''s current free tier. Landing page and sign-up form builders are included on all plans. Integrates with Shopify, WooCommerce, WordPress, and Zapier. Used by over 1 million businesses globally.',
  'https://www.google.com/s2/favicons?domain=mailerlite.com&sz=64',
  'https://mailerlite.com', 'https://mailerlite.com',
  ARRAY['marketing', 'email-marketing', 'ai-assistant'],
  'freemium', true, 0.00,
  4.6, 4200, false, false, false,
  ARRAY['Generous free plan: 12,000 emails/month up to 1,000 subscribers', 'AI writing assistant generates email copy and subject lines', 'Newsletter monetisation with paid subscriptions and digital products', 'Clean interface with fast email builder and landing pages'],
  ARRAY['Automation less powerful than ActiveCampaign or Klaviyo', 'E-commerce features less deep than Omnisend or Klaviyo', 'Deliverability can require careful list hygiene on large sends'],
  ARRAY['Small businesses and startups launching email marketing on a budget', 'Independent creators building and monetising a newsletter audience', 'Bloggers and solopreneurs replacing Mailchimp on a better free tier']
),

-- 10. Planable
(
  'planable', 'Planable', 'Social media content planning and approval platform for marketing teams',
  'Planable is a social media content collaboration and approval platform designed to eliminate the back-and-forth between social media managers, marketing leads, and clients that slows content publishing. Its interface shows a real-time preview of how a post will look when published on each social platform - Instagram feed, LinkedIn article, Twitter/X tweet, Facebook post - so stakeholders can review content exactly as audiences will see it, not as raw text in a spreadsheet or document. Planable''s approval workflow supports three modes: no approval required, optional approval, or mandatory approval with configurable reviewer lists. Comments, @mentions, and revision requests are made directly on the post preview, with full conversation history attached to each piece of content. The universal content view aggregates all scheduled content across every platform in a single feed, list, or calendar view. Planable supports multiple workspaces for agencies managing separate client accounts, with clear permission boundaries between clients. It integrates with Facebook Pages, Instagram, LinkedIn, Twitter/X, TikTok, YouTube, Pinterest, and Google Business Profile. Particularly valued by agencies whose client approval process previously relied on spreadsheets and email threads.',
  'https://www.google.com/s2/favicons?domain=planable.io&sz=64',
  'https://planable.io', 'https://planable.io',
  ARRAY['marketing', 'social-media', 'productivity'],
  'freemium', true, 0.00,
  4.6, 1400, false, false, false,
  ARRAY['Real-time platform preview shows exactly how posts will appear before publishing', 'Flexible approval workflows: none, optional, or mandatory', 'Comments and revisions made directly on post previews', 'Multi-workspace support for agency client separation'],
  ARRAY['Less built-in analytics than Sprout Social or Agorapulse', 'No social listening or competitor monitoring', 'Scheduling less flexible than dedicated scheduling tools'],
  ARRAY['Marketing agencies replacing spreadsheet-based client approval workflows', 'Brand teams requiring legal or management sign-off before publishing', 'Remote social media teams needing asynchronous collaboration on content']
)

ON CONFLICT (slug) DO NOTHING;
