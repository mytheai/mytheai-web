-- tools-batch-29.sql
-- 10 new tools: fullstory, heap, chartmogul, baremetrics, june-so, pendo, hotjar, segment, rudderstack, plausible
-- Theme: AI analytics, product analytics, and data tools
-- Run AFTER tools-batch-28.sql has been confirmed in DB
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  pricing_type, pricing_starting_price,
  rating, review_count,
  featured, trending, editor_pick,
  pros, cons, use_cases, tags, alternatives
)

-- 1. FullStory
SELECT
  'fullstory', 'FullStory', 'Digital experience intelligence through session replay and DX data',
  'FullStory captures every user interaction on your web and mobile apps, from clicks and scrolls to rage-clicks and dead clicks, and turns that data into actionable digital experience insights. Unlike basic analytics tools that show you what users do in aggregate, FullStory shows you exactly how individual sessions unfold, letting you diagnose friction points with precision. The platform''s DX Data technology auto-indexes every interaction without manual tagging, so product and engineering teams can query user behaviour retroactively - asking questions about data that predates the question itself. AI-powered anomaly detection flags unusual drop-off patterns before they become churn. Session replay, heatmaps, funnels, and event analytics all live in one interface. FullStory integrates with Segment, Amplitude, Salesforce, and major data warehouses. Enterprise teams use it alongside quantitative analytics to understand the human story behind the numbers.',
  NULL, 'https://fullstory.com', 'https://fullstory.com',
  'freemium', 0.00,
  4.5, 1240,
  false, true, false,
  ARRAY['Auto-captures all interactions without manual event tagging', 'Retroactive querying - answer questions about past sessions without re-instrumenting', 'AI anomaly detection surfaces problems automatically', 'Deep session replay with privacy controls for PII masking', 'Integrates with most analytics and data warehouse tools'],
  ARRAY['Pricing is enterprise-focused and not publicly listed', 'Storage limits on free tier restrict historical data access', 'Can feel overwhelming for small teams without a dedicated analytics function', 'Privacy compliance setup requires careful configuration'],
  ARRAY['Diagnosing why users abandon checkout flows', 'Reproducing bugs by watching the exact session that triggered them', 'Validating whether redesigns actually improve user behaviour', 'Supporting customer success with session playback during support calls']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'fullstory');

-- 2. Heap
SELECT
  'heap', 'Heap', 'Auto-capture analytics that retroactively answers any product question',
  'Heap automatically captures every user action in your product - every click, tap, page view, form submission, and gesture - without requiring engineers to add tracking code for each event. This auto-capture model means you never lose data because you forgot to instrument something. The real power is retroactive analysis: you can define new metrics or segments today and immediately see how users behaved months ago, because Heap has already captured the raw data. AI-powered insights surface conversion opportunities, retention patterns, and friction points without requiring manual analysis. Heap''s Illuminate feature automatically identifies the paths that lead to conversion and those that lead to churn. The platform integrates with Salesforce, Marketo, Segment, and major data warehouses. Product managers use Heap to move from intuition-based decisions to behaviour-based product development without depending on engineering every time they have a new question.',
  NULL, 'https://heap.io', 'https://heap.io',
  'freemium', 0.00,
  4.4, 890,
  false, true, false,
  ARRAY['Auto-capture eliminates the need to pre-define events before launch', 'Retroactive analysis answers historical questions without re-instrumentation', 'Illuminate AI surfaces actionable conversion opportunities automatically', 'Strong integration ecosystem with CRM and data warehouse tools', 'Generous free tier for early-stage products'],
  ARRAY['High data volumes can slow query performance on complex analyses', 'Auto-capture can produce noisy data that requires cleaning and organisation', 'Advanced features have a learning curve for non-technical users', 'Enterprise pricing is not publicly listed'],
  ARRAY['Analysing which features drive retention vs churn', 'Identifying where users drop off in multi-step onboarding flows', 'Comparing behaviour of high-value vs low-value user segments', 'Validating product hypotheses without waiting for engineering instrumentation']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'heap');

-- 3. ChartMogul
SELECT
  'chartmogul', 'ChartMogul', 'Subscription analytics and revenue intelligence for SaaS businesses',
  'ChartMogul is the subscription analytics platform built specifically for SaaS companies. It pulls billing data from Stripe, Braintree, Recurly, and other payment processors and calculates the metrics that matter to SaaS businesses: MRR, ARR, churn rate, expansion MRR, LTV, and cohort retention. Unlike general-purpose BI tools, ChartMogul understands subscription business logic natively - it knows what a downgrade means and how to attribute revenue to the right period. The customer-level detail is particularly strong: you can see every metric for individual customers, segment by plan or acquisition channel, and build cohort analyses to understand how different customer groups retain over time. Revenue recognition reports help finance teams with compliance. The API and data platform let engineering teams pipe subscription data to other tools. ChartMogul is the closest thing to a revenue intelligence system that growing SaaS companies can deploy without a data engineering team.',
  NULL, 'https://chartmogul.com', 'https://chartmogul.com',
  'freemium', 0.00,
  4.6, 780,
  true, false, false,
  ARRAY['Purpose-built for subscription businesses - understands SaaS metrics natively', 'Connects to all major payment processors with no custom code', 'Cohort analysis and churn attribution out of the box', 'Customer-level detail lets you see individual MRR and history', 'Free tier up to $10k MRR for early-stage companies'],
  ARRAY['Limited usefulness for non-subscription businesses', 'Advanced segmentation requires the higher-tier plans', 'Data latency can be a few hours on some payment processor integrations', 'Less flexible than general BI tools for custom reporting'],
  ARRAY['Tracking MRR growth and churn trends for investor reporting', 'Building cohort retention analyses to improve product-market fit', 'Identifying high-LTV customer segments to inform acquisition strategy', 'Monthly revenue recognition for finance and audit compliance']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'chartmogul');

-- 4. Baremetrics
SELECT
  'baremetrics', 'Baremetrics', 'Subscription metrics and revenue forecasting for Stripe businesses',
  'Baremetrics connects to Stripe and turns your billing data into a live dashboard of the subscription metrics your business depends on: MRR, ARR, LTV, churn rate, ARPU, and failed charge recovery. Setup takes minutes - connect Stripe and your metrics are live. The platform goes beyond dashboards with Forecasting, which builds revenue projections based on your historical growth trajectory and scenario planning. Cancellation Insights captures why customers churn by sending automated cancellation surveys and displaying the reasons alongside the revenue lost. Recover helps win back failed payments with smart dunning sequences. For Stripe-first SaaS businesses that want instant metrics without building a data pipeline, Baremetrics is the fastest path to subscription intelligence. The public metrics dashboard feature lets companies share live revenue metrics publicly, a popular choice for bootstrapped founders running in public.',
  NULL, 'https://baremetrics.com', 'https://baremetrics.com',
  'paid', 108.00,
  4.3, 560,
  false, false, false,
  ARRAY['Fastest setup for Stripe businesses - metrics live in minutes', 'Cancellation Insights captures churn reasons automatically', 'Recover dunning system reduces failed payment churn', 'Revenue forecasting with scenario planning built in', 'Public metrics dashboard for founders running transparently'],
  ARRAY['Primarily Stripe-focused - less versatile with other payment processors', 'No free tier, pricing starts at $108/month', 'Less powerful cohort analysis than ChartMogul', 'Limited customisation on the standard dashboards'],
  ARRAY['Getting instant MRR visibility without building a data pipeline', 'Reducing involuntary churn through automated payment recovery', 'Understanding cancellation reasons to improve retention', 'Forecasting revenue for fundraising or budget planning']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'baremetrics');

-- 5. June.so
SELECT
  'june-so', 'June', 'Product analytics built for B2B SaaS with company-level insights',
  'June is a product analytics tool designed specifically for B2B SaaS companies where the unit of analysis is the company, not the individual user. Most analytics tools are built for consumer products and require complex workarounds to analyse behaviour at the account level. June makes company-level metrics first-class: you see activation rates, feature adoption, and retention segmented by company, plan, and company size. Templates for B2B-specific reports - activation analysis, feature adoption funnels, churn prediction - are available out of the box without building them from scratch. The Slack integration delivers daily digests of which companies are activating, churning, or expanding, making it practical for small teams without a dedicated analyst. June connects to Segment for event data and integrates with HubSpot and Salesforce for CRM context. It is the most opinionated and easiest-to-use analytics tool specifically for B2B SaaS product teams.',
  NULL, 'https://june.so', 'https://june.so',
  'freemium', 0.00,
  4.5, 320,
  false, true, false,
  ARRAY['Company-level analytics built for B2B without complex workarounds', 'Pre-built B2B report templates reduce setup time significantly', 'Slack alerts surface account health changes in real time', 'Simple enough for non-technical product managers to use daily', 'Free tier generous for early-stage B2B products'],
  ARRAY['Less flexible than Amplitude or Mixpanel for custom event analytics', 'Smaller integration ecosystem than established analytics platforms', 'Primarily useful for B2B - consumer products should look elsewhere', 'Limited historical data on lower-tier plans'],
  ARRAY['Tracking which companies activate vs which go dark after signup', 'Identifying power users within customer accounts to support expansion', 'Monitoring feature adoption by company tier to guide roadmap decisions', 'Building churn risk alerts for customer success teams']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'june-so');

-- 6. Pendo
SELECT
  'pendo', 'Pendo', 'Product experience platform combining analytics, in-app guidance, and feedback',
  'Pendo combines three capabilities that usually require separate tools: product analytics, in-app guides and onboarding, and user feedback collection. The analytics layer tracks feature usage and user paths without code instrumentation. The engagement layer lets product teams build in-app tooltips, walkthroughs, and announcements using a visual editor without engineering support. The feedback layer collects NPS surveys and feature requests directly within the product. This combination makes Pendo particularly valuable for enterprise software companies that need to understand usage, communicate with users inside the product, and gather structured feedback - all without deploying code for every change. The AI layer surfaces underutilised features and user segments at risk of churning. Pendo is the most complete product experience platform available and is particularly strong in enterprise accounts where multiple stakeholders need access to different capabilities.',
  NULL, 'https://pendo.io', 'https://pendo.io',
  'paid', 0.00,
  4.4, 2100,
  true, false, false,
  ARRAY['Combines analytics, in-app guidance, and feedback in one platform', 'No-code in-app guide builder lets product teams move without engineering', 'Strong enterprise features including SSO, data governance, and audit logs', 'NPS and feedback tools integrated directly into the product experience', 'AI-powered feature adoption and churn risk signals'],
  ARRAY['Pricing is enterprise-focused and not publicly listed', 'Can be complex to configure and requires onboarding investment', 'Analytics depth is less than dedicated tools like Amplitude', 'Smaller teams often pay for more capability than they use'],
  ARRAY['Building onboarding walkthroughs for new feature releases', 'Identifying underutilised features to inform sunsetting or re-education decisions', 'Collecting NPS scores in context without external survey tools', 'Tracking enterprise account health across multiple user roles']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'pendo');

-- 7. Hotjar
SELECT
  'hotjar', 'Hotjar', 'Heatmaps, session recordings, and feedback tools for website optimisation',
  'Hotjar is the most widely used tool for understanding visitor behaviour on websites and landing pages. Its core products - heatmaps, session recordings, and feedback surveys - give marketing and UX teams a visual picture of what users do on the page and why. Heatmaps aggregate click, move, and scroll data into colour-coded overlays that immediately show where attention goes and where it drops off. Session recordings let you watch real user journeys without violating privacy, since PII is masked by default. Feedback surveys and polls can be triggered at any point in the user journey to capture qualitative context. Hotjar''s Highlights feature lets you clip and share key session moments with teammates. The AI assistant summarises feedback themes across hundreds of survey responses. Hotjar is primarily a website and landing page tool rather than a web app analytics platform - for deep product analytics, tools like Amplitude or Heap are more appropriate.',
  NULL, 'https://hotjar.com', 'https://hotjar.com',
  'freemium', 0.00,
  4.4, 3200,
  false, false, false,
  ARRAY['Visual heatmaps immediately communicate where users focus and ignore', 'Session recordings with automatic PII masking for privacy compliance', 'Feedback surveys can be triggered contextually at any user journey stage', 'AI feedback summarisation handles large survey datasets automatically', 'Free tier functional for most small websites and early testing'],
  ARRAY['Primarily for marketing sites and landing pages, not complex web apps', 'High session recording volumes can slow site performance if not configured carefully', 'Limited funnel and cohort analytics compared to product analytics platforms', 'Data retention limited on free and lower tiers'],
  ARRAY['Identifying why landing page visitors leave without converting', 'Testing whether new page designs move user attention to key CTAs', 'Collecting contextual feedback on checkout abandonment', 'Supporting UX research with recorded sessions for remote usability testing']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'hotjar');

-- 8. Segment
SELECT
  'segment', 'Segment', 'Customer data platform that collects, cleans, and routes data to every tool',
  'Segment is the market-leading customer data platform (CDP). It sits between your product and your analytics, marketing, and support tools, collecting events from web, mobile, and server sources and routing clean, standardised data to every downstream destination. Instead of implementing separate tracking code for Google Analytics, Amplitude, Intercom, Salesforce, and five other tools, you implement Segment once and route data to all of them from a single source of truth. This eliminates data inconsistency across tools, reduces engineering instrumentation work, and makes it practical to add or swap tools without re-instrumenting your product. Segment''s Protocols feature enforces data quality through a tracking plan that validates events before they reach your destinations. Personas builds real-time user profiles that unify data across touchpoints. For growth-stage companies with multiple analytics and marketing tools, Segment is the infrastructure layer that makes the whole stack coherent.',
  NULL, 'https://segment.com', 'https://segment.com',
  'freemium', 0.00,
  4.5, 1980,
  true, false, false,
  ARRAY['Single instrumentation point for all analytics and marketing tools', 'Eliminates data inconsistency between tools by standardising at the source', 'Reduces engineering time when adding or swapping downstream destinations', 'Protocols enforces data quality with schema validation', 'Free tier for up to 1,000 monthly tracked users'],
  ARRAY['Requires engineering setup - not a no-code solution', 'Costs scale significantly with event volume on growth plans', 'Some destinations have data latency compared to direct integrations', 'Can create over-dependence on Segment as a single point of failure'],
  ARRAY['Routing user events to multiple analytics tools from a single instrumentation', 'Building unified customer profiles that combine product, CRM, and marketing data', 'Enforcing data governance with schema validation across engineering teams', 'Enabling marketing personalisation by syncing behavioural data to ad platforms']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'segment');

-- 9. RudderStack
SELECT
  'rudderstack', 'RudderStack', 'Open-source customer data platform with warehouse-native architecture',
  'RudderStack is the open-source alternative to Segment. It collects event data from your product and routes it to analytics, marketing, and support tools, but with two key differences: the codebase is open and auditable, and its warehouse-native architecture stores all data in your own data warehouse first rather than in a proprietary vendor store. This gives engineering teams full control over their data and avoids vendor lock-in at the data layer. RudderStack supports all major event sources (web, mobile, server, cloud) and hundreds of destinations. The self-hosted option means data never leaves your infrastructure, which is critical for companies with strict data residency requirements. The cloud version competes directly with Segment on features and price. Profiles builds real-time identity graphs across anonymous and identified users. For data-mature companies with a warehouse-first data strategy, RudderStack offers capabilities that Segment does not.',
  NULL, 'https://rudderstack.com', 'https://rudderstack.com',
  'freemium', 0.00,
  4.3, 420,
  false, true, false,
  ARRAY['Open-source codebase - auditable and self-hostable for full data control', 'Warehouse-native: data stored in your warehouse, not in a vendor black box', 'No data residency concerns when self-hosted', 'Competitive pricing vs Segment for high event volumes', 'Active open-source community with frequent updates'],
  ARRAY['More engineering overhead to set up and maintain vs managed alternatives', 'Ecosystem of pre-built integrations smaller than Segment', 'Documentation less polished than enterprise competitors', 'Self-hosted version requires infrastructure management and monitoring'],
  ARRAY['Routing product events to analytics tools while maintaining data sovereignty', 'Building a warehouse-first data stack where the warehouse is the source of truth', 'Replacing Segment for companies with strict data residency or compliance requirements', 'Integrating customer data across product, CRM, and marketing tools on a budget']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'rudderstack');

-- 10. Plausible
SELECT
  'plausible', 'Plausible Analytics', 'Privacy-first web analytics that respects visitors and requires no cookie banner',
  'Plausible is a lightweight, open-source web analytics tool built as the privacy-respecting alternative to Google Analytics. It tracks traffic, sources, pages, and conversions without using cookies or collecting personal data, making it fully compliant with GDPR, CCPA, and PECR without a cookie consent banner. The script is 45x smaller than Google Analytics, adding negligible page weight. The dashboard is intentionally simple: traffic trends, top pages, referrers, countries, and devices in a single view. Plausible also supports custom event tracking and conversion goals for more advanced use cases. The hosted version is run on European servers, keeping data off US infrastructure. Plausible can be self-hosted on your own server for teams that want full control. For content sites, marketing blogs, and businesses that want honest traffic data without Google''s surveillance infrastructure, Plausible offers a clean alternative at a fair price.',
  NULL, 'https://plausible.io', 'https://plausible.io',
  'paid', 9.00,
  4.7, 1100,
  false, false, false,
  ARRAY['No cookies, no personal data, no consent banner required', 'Lightweight script with negligible page performance impact', 'Open-source and self-hostable for full data sovereignty', 'Simple, readable dashboard - no GA4 complexity', 'GDPR, CCPA, and PECR compliant out of the box'],
  ARRAY['Less detailed than Google Analytics for complex funnel or attribution analysis', 'No free tier - starts at $9/month', 'Limited integration ecosystem compared to Google Analytics', 'Not suitable for large-scale ecommerce or complex multi-channel attribution'],
  ARRAY['Replacing Google Analytics on content sites and marketing blogs', 'Running analytics without a cookie consent banner for better UX', 'Monitoring traffic on European sites with GDPR compliance baked in', 'Getting clean, honest traffic data without sampling or data processing delays']
WHERE NOT EXISTS (SELECT 1 FROM tools WHERE slug = 'plausible');
