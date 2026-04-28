-- tools-batch-29.sql
-- 10 new tools: fullstory, heap, chartmogul, baremetrics, june-so, pendo, hotjar, segment, rudderstack, plausible
-- Theme: AI analytics, product analytics, and data tools
-- posthog excluded (already in batch-10)
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

-- 1. FullStory
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'fullstory', 'FullStory', 'Digital experience intelligence through session replay and DX data',
  'FullStory captures every user interaction on your web and mobile apps - from clicks and scrolls to rage-clicks and dead clicks - and turns that data into actionable digital experience insights. Unlike basic analytics tools that show you what users do in aggregate, FullStory shows you exactly how individual sessions unfold, letting you diagnose friction points with precision. The platform''s DX Data technology auto-indexes every interaction without manual tagging, so product and engineering teams can query user behaviour retroactively - asking questions about data that predates the question itself. AI-powered anomaly detection flags unusual drop-off patterns before they become churn. Session replay, heatmaps, funnels, and event analytics all live in one interface. FullStory integrates with Segment, Amplitude, Salesforce, and major data warehouses. Enterprise teams use it alongside quantitative analytics to understand the human story behind the numbers.',
  'https://www.google.com/s2/favicons?domain=fullstory.com&sz=64',
  'https://fullstory.com', 'https://fullstory.com',
  ARRAY['analytics', 'research'],
  'freemium', true, 0.00,
  4.5, 1240, false, true, false,
  ARRAY['Auto-captures all interactions without manual event tagging', 'Retroactive querying - answer questions about past sessions without re-instrumenting', 'AI anomaly detection surfaces problems automatically', 'Deep session replay with privacy controls for PII masking'],
  ARRAY['Pricing is enterprise-focused and not publicly listed', 'Storage limits on free tier restrict historical data access', 'Can feel overwhelming for small teams without a dedicated analytics function'],
  ARRAY['Diagnosing why users abandon checkout flows', 'Reproducing bugs by watching the exact session that triggered them', 'Validating whether redesigns actually improve user behaviour']
) ON CONFLICT (slug) DO NOTHING;

-- 2. Heap
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'heap', 'Heap', 'Auto-capture analytics that retroactively answers any product question',
  'Heap automatically captures every user action in your product - every click, tap, page view, form submission, and gesture - without requiring engineers to add tracking code for each event. This auto-capture model means you never lose data because you forgot to instrument something. The real power is retroactive analysis: you can define new metrics or segments today and immediately see how users behaved months ago, because Heap has already captured the raw data. AI-powered insights surface conversion opportunities, retention patterns, and friction points without requiring manual analysis. Heap''s Illuminate feature automatically identifies the paths that lead to conversion and those that lead to churn. The platform integrates with Salesforce, Marketo, Segment, and major data warehouses. Product managers use Heap to move from intuition-based decisions to behaviour-based product development without depending on engineering every time they have a new question.',
  'https://www.google.com/s2/favicons?domain=heap.io&sz=64',
  'https://heap.io', 'https://heap.io',
  ARRAY['analytics', 'research'],
  'freemium', true, 0.00,
  4.4, 890, false, true, false,
  ARRAY['Auto-capture eliminates the need to pre-define events before launch', 'Retroactive analysis answers historical questions without re-instrumentation', 'Illuminate AI surfaces actionable conversion opportunities automatically', 'Strong integration ecosystem with CRM and data warehouse tools'],
  ARRAY['High data volumes can slow query performance on complex analyses', 'Auto-capture can produce noisy data that requires cleaning', 'Advanced features have a learning curve for non-technical users'],
  ARRAY['Analysing which features drive retention vs churn', 'Identifying where users drop off in multi-step onboarding flows', 'Comparing behaviour of high-value vs low-value user segments']
) ON CONFLICT (slug) DO NOTHING;

-- 3. ChartMogul
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'chartmogul', 'ChartMogul', 'Subscription analytics and revenue intelligence for SaaS businesses',
  'ChartMogul is the subscription analytics platform built specifically for SaaS companies. It pulls billing data from Stripe, Braintree, Recurly, and other payment processors and calculates the metrics that matter to SaaS businesses: MRR, ARR, churn rate, expansion MRR, LTV, and cohort retention. Unlike general-purpose BI tools, ChartMogul understands subscription business logic natively - it knows what a downgrade means and how to attribute revenue to the right period. The customer-level detail is particularly strong: you can see every metric for individual customers, segment by plan or acquisition channel, and build cohort analyses to understand how different customer groups retain over time. Revenue recognition reports help finance teams with compliance. The API and data platform let engineering teams pipe subscription data to other tools. ChartMogul is the closest thing to a revenue intelligence system that growing SaaS companies can deploy without a data engineering team.',
  'https://www.google.com/s2/favicons?domain=chartmogul.com&sz=64',
  'https://chartmogul.com', 'https://chartmogul.com',
  ARRAY['analytics', 'business-intelligence'],
  'freemium', true, 0.00,
  4.6, 780, true, false, false,
  ARRAY['Purpose-built for subscription businesses - understands SaaS metrics natively', 'Connects to all major payment processors with no custom code', 'Cohort analysis and churn attribution out of the box', 'Free tier up to $10k MRR for early-stage companies'],
  ARRAY['Limited usefulness for non-subscription businesses', 'Advanced segmentation requires higher-tier plans', 'Less flexible than general BI tools for custom reporting'],
  ARRAY['Tracking MRR growth and churn trends for investor reporting', 'Building cohort retention analyses to improve product-market fit', 'Identifying high-LTV customer segments to inform acquisition strategy']
) ON CONFLICT (slug) DO NOTHING;

-- 4. Baremetrics
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'baremetrics', 'Baremetrics', 'Subscription metrics and revenue forecasting for Stripe businesses',
  'Baremetrics connects to Stripe and turns your billing data into a live dashboard of the subscription metrics your business depends on: MRR, ARR, LTV, churn rate, ARPU, and failed charge recovery. Setup takes minutes - connect Stripe and your metrics are live. The platform goes beyond dashboards with Forecasting, which builds revenue projections based on your historical growth trajectory and scenario planning. Cancellation Insights captures why customers churn by sending automated cancellation surveys and displaying the reasons alongside the revenue lost. Recover helps win back failed payments with smart dunning sequences. For Stripe-first SaaS businesses that want instant metrics without building a data pipeline, Baremetrics is the fastest path to subscription intelligence. The public metrics dashboard feature lets companies share live revenue metrics publicly - a popular choice for bootstrapped founders running in public.',
  'https://www.google.com/s2/favicons?domain=baremetrics.com&sz=64',
  'https://baremetrics.com', 'https://baremetrics.com',
  ARRAY['analytics', 'business-intelligence'],
  'paid', false, 108.00,
  4.3, 560, false, false, false,
  ARRAY['Fastest setup for Stripe businesses - metrics live in minutes', 'Cancellation Insights captures churn reasons automatically', 'Recover dunning system reduces failed payment churn', 'Revenue forecasting with scenario planning built in'],
  ARRAY['Primarily Stripe-focused - less versatile with other payment processors', 'No free tier, pricing starts at $108/month', 'Less powerful cohort analysis than ChartMogul'],
  ARRAY['Getting instant MRR visibility without building a data pipeline', 'Reducing involuntary churn through automated payment recovery', 'Forecasting revenue for fundraising or budget planning']
) ON CONFLICT (slug) DO NOTHING;

-- 5. June.so
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'june-so', 'June', 'Product analytics built for B2B SaaS with company-level insights',
  'June is a product analytics tool designed specifically for B2B SaaS companies where the unit of analysis is the company, not the individual user. Most analytics tools are built for consumer products and require complex workarounds to analyse behaviour at the account level. June makes company-level metrics first-class: you see activation rates, feature adoption, and retention segmented by company, plan, and company size. Templates for B2B-specific reports - activation analysis, feature adoption funnels, churn prediction - are available out of the box without building them from scratch. The Slack integration delivers daily digests of which companies are activating, churning, or expanding, making it practical for small teams without a dedicated analyst. June connects to Segment for event data and integrates with HubSpot and Salesforce for CRM context. It is the most opinionated and easiest-to-use analytics tool specifically for B2B SaaS product teams.',
  'https://www.google.com/s2/favicons?domain=june.so&sz=64',
  'https://june.so', 'https://june.so',
  ARRAY['analytics', 'research'],
  'freemium', true, 0.00,
  4.5, 320, false, true, false,
  ARRAY['Company-level analytics built for B2B without complex workarounds', 'Pre-built B2B report templates reduce setup time significantly', 'Slack alerts surface account health changes in real time', 'Simple enough for non-technical product managers to use daily'],
  ARRAY['Less flexible than Amplitude or Mixpanel for custom event analytics', 'Smaller integration ecosystem than established analytics platforms', 'Primarily useful for B2B - consumer products should look elsewhere'],
  ARRAY['Tracking which companies activate vs which go dark after signup', 'Identifying power users within customer accounts to support expansion', 'Building churn risk alerts for customer success teams']
) ON CONFLICT (slug) DO NOTHING;

-- 6. Pendo
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'pendo', 'Pendo', 'Product experience platform combining analytics, in-app guidance, and feedback',
  'Pendo combines three capabilities that usually require separate tools: product analytics, in-app guides and onboarding, and user feedback collection. The analytics layer tracks feature usage and user paths without code instrumentation. The engagement layer lets product teams build in-app tooltips, walkthroughs, and announcements using a visual editor without engineering support. The feedback layer collects NPS surveys and feature requests directly within the product. This combination makes Pendo particularly valuable for enterprise software companies that need to understand usage, communicate with users inside the product, and gather structured feedback - all without deploying code for every change. The AI layer surfaces underutilised features and user segments at risk of churning. Pendo is the most complete product experience platform available and is particularly strong in enterprise accounts where multiple stakeholders need different capabilities.',
  'https://www.google.com/s2/favicons?domain=pendo.io&sz=64',
  'https://pendo.io', 'https://pendo.io',
  ARRAY['analytics', 'research'],
  'paid', false, 0.00,
  4.4, 2100, true, false, false,
  ARRAY['Combines analytics, in-app guidance, and feedback in one platform', 'No-code in-app guide builder lets product teams move without engineering', 'Strong enterprise features including SSO, data governance, and audit logs', 'NPS and feedback tools integrated directly into the product experience'],
  ARRAY['Pricing is enterprise-focused and not publicly listed', 'Can be complex to configure and requires onboarding investment', 'Analytics depth is less than dedicated tools like Amplitude'],
  ARRAY['Building onboarding walkthroughs for new feature releases', 'Identifying underutilised features to inform sunsetting decisions', 'Collecting NPS scores in context without external survey tools']
) ON CONFLICT (slug) DO NOTHING;

-- 7. Hotjar
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'hotjar', 'Hotjar', 'Heatmaps, session recordings, and feedback tools for website optimisation',
  'Hotjar is the most widely used tool for understanding visitor behaviour on websites and landing pages. Its core products - heatmaps, session recordings, and feedback surveys - give marketing and UX teams a visual picture of what users do on the page and why. Heatmaps aggregate click, move, and scroll data into colour-coded overlays that immediately show where attention goes and where it drops off. Session recordings let you watch real user journeys without violating privacy, since PII is masked by default. Feedback surveys and polls can be triggered at any point in the user journey to capture qualitative context. Hotjar''s Highlights feature lets you clip and share key session moments with teammates. The AI assistant summarises feedback themes across hundreds of survey responses. Hotjar is primarily a website and landing page tool rather than a web app analytics platform - for deep product analytics, tools like Amplitude or Heap are more appropriate.',
  'https://www.google.com/s2/favicons?domain=hotjar.com&sz=64',
  'https://hotjar.com', 'https://hotjar.com',
  ARRAY['analytics', 'research'],
  'freemium', true, 0.00,
  4.4, 3200, false, false, false,
  ARRAY['Visual heatmaps immediately communicate where users focus and ignore', 'Session recordings with automatic PII masking for privacy compliance', 'Feedback surveys can be triggered contextually at any user journey stage', 'AI feedback summarisation handles large survey datasets automatically'],
  ARRAY['Primarily for marketing sites and landing pages, not complex web apps', 'High session recording volumes can slow site performance if not configured carefully', 'Limited funnel and cohort analytics compared to product analytics platforms'],
  ARRAY['Identifying why landing page visitors leave without converting', 'Testing whether new page designs move user attention to key CTAs', 'Supporting UX research with recorded sessions for remote usability testing']
) ON CONFLICT (slug) DO NOTHING;

-- 8. Segment
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'segment', 'Segment', 'Customer data platform that collects, cleans, and routes data to every tool',
  'Segment is the market-leading customer data platform (CDP). It sits between your product and your analytics, marketing, and support tools, collecting events from web, mobile, and server sources and routing clean, standardised data to every downstream destination. Instead of implementing separate tracking code for Google Analytics, Amplitude, Intercom, Salesforce, and five other tools, you implement Segment once and route data to all of them from a single source of truth. This eliminates data inconsistency across tools, reduces engineering instrumentation work, and makes it practical to add or swap tools without re-instrumenting your product. Segment''s Protocols feature enforces data quality through a tracking plan that validates events before they reach your destinations. Personas builds real-time user profiles that unify data across touchpoints. For growth-stage companies with multiple analytics and marketing tools, Segment is the infrastructure layer that makes the whole stack coherent.',
  'https://www.google.com/s2/favicons?domain=segment.com&sz=64',
  'https://segment.com', 'https://segment.com',
  ARRAY['analytics', 'automation'],
  'freemium', true, 0.00,
  4.5, 1980, true, false, false,
  ARRAY['Single instrumentation point for all analytics and marketing tools', 'Eliminates data inconsistency between tools by standardising at the source', 'Reduces engineering time when adding or swapping downstream destinations', 'Protocols enforces data quality with schema validation'],
  ARRAY['Requires engineering setup - not a no-code solution', 'Costs scale significantly with event volume on growth plans', 'Some destinations have data latency compared to direct integrations'],
  ARRAY['Routing user events to multiple analytics tools from a single instrumentation', 'Building unified customer profiles that combine product, CRM, and marketing data', 'Enabling marketing personalisation by syncing behavioural data to ad platforms']
) ON CONFLICT (slug) DO NOTHING;

-- 9. RudderStack
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'rudderstack', 'RudderStack', 'Open-source customer data platform with warehouse-native architecture',
  'RudderStack is the open-source alternative to Segment. It collects event data from your product and routes it to analytics, marketing, and support tools, but with two key differences: the codebase is open and auditable, and its warehouse-native architecture stores all data in your own data warehouse first rather than in a proprietary vendor store. This gives engineering teams full control over their data and avoids vendor lock-in at the data layer. RudderStack supports all major event sources (web, mobile, server, cloud) and hundreds of destinations. The self-hosted option means data never leaves your infrastructure, which is critical for companies with strict data residency requirements. The cloud version competes directly with Segment on features and price. Profiles builds real-time identity graphs across anonymous and identified users. For data-mature companies with a warehouse-first data strategy, RudderStack offers capabilities that Segment does not.',
  'https://www.google.com/s2/favicons?domain=rudderstack.com&sz=64',
  'https://rudderstack.com', 'https://rudderstack.com',
  ARRAY['analytics', 'automation'],
  'freemium', true, 0.00,
  4.3, 420, false, true, false,
  ARRAY['Open-source codebase - auditable and self-hostable for full data control', 'Warehouse-native: data stored in your warehouse, not in a vendor black box', 'No data residency concerns when self-hosted', 'Competitive pricing vs Segment for high event volumes'],
  ARRAY['More engineering overhead to set up and maintain vs managed alternatives', 'Ecosystem of pre-built integrations smaller than Segment', 'Self-hosted version requires infrastructure management and monitoring'],
  ARRAY['Routing product events to analytics tools while maintaining data sovereignty', 'Building a warehouse-first data stack where the warehouse is the source of truth', 'Replacing Segment for companies with strict data residency or compliance requirements']
) ON CONFLICT (slug) DO NOTHING;

-- 10. Plausible
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'plausible', 'Plausible Analytics', 'Privacy-first web analytics that requires no cookie banner',
  'Plausible is a lightweight, open-source web analytics tool built as the privacy-respecting alternative to Google Analytics. It tracks traffic, sources, pages, and conversions without using cookies or collecting personal data, making it fully compliant with GDPR, CCPA, and PECR without a cookie consent banner. The script is 45x smaller than Google Analytics, adding negligible page weight. The dashboard is intentionally simple: traffic trends, top pages, referrers, countries, and devices in a single view. Plausible also supports custom event tracking and conversion goals for more advanced use cases. The hosted version is run on European servers, keeping data off US infrastructure. Plausible can be self-hosted on your own server for teams that want full control. For content sites, marketing blogs, and businesses that want honest traffic data without Google''s surveillance infrastructure, Plausible offers a clean alternative at a fair price.',
  'https://www.google.com/s2/favicons?domain=plausible.io&sz=64',
  'https://plausible.io', 'https://plausible.io',
  ARRAY['analytics', 'seo-marketing'],
  'paid', false, 9.00,
  4.7, 1100, false, false, false,
  ARRAY['No cookies, no personal data, no consent banner required', 'Lightweight script with negligible page performance impact', 'Open-source and self-hostable for full data sovereignty', 'GDPR, CCPA, and PECR compliant out of the box'],
  ARRAY['Less detailed than Google Analytics for complex funnel or attribution analysis', 'No free tier - starts at $9/month', 'Limited integration ecosystem compared to Google Analytics'],
  ARRAY['Replacing Google Analytics on content sites and marketing blogs', 'Running analytics without a cookie consent banner for better UX', 'Monitoring traffic on European sites with GDPR compliance baked in']
) ON CONFLICT (slug) DO NOTHING;
