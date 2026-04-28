-- compare-batch-29.sql
-- 5 comparison pairs: AI analytics and CDP tools (theme matches batch-29)
-- All pairs use tools confirmed in DB after tools-batch-29 runs
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: segment-vs-rudderstack
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'segment-vs-rudderstack',
  'segment',
  'rudderstack',
  'Segment vs RudderStack is the defining CDP comparison in 2026. Both collect event data from your product and route it to analytics, marketing, and support tools. Segment is the established market leader with a polished interface, the largest pre-built destination library, and minimal engineering setup. RudderStack is the open-source challenger with a warehouse-native architecture that keeps data in your own infrastructure rather than Segment''s cloud. For most growth-stage companies, Segment wins on ease of setup and breadth of integrations. For data-mature teams with compliance requirements or a warehouse-first data strategy, RudderStack offers control that Segment cannot match.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'segment-vs-rudderstack', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Ease of setup', 5, 3, 'Segment has a polished onboarding and the largest library of pre-built source and destination connectors - most teams are live in hours. RudderStack cloud is competitive but self-hosted setup requires more engineering effort.'),
  ('Destination library', 5, 4, 'Segment supports 400+ destinations out of the box. RudderStack supports 150+ with more added regularly - covers the core stack but has gaps in niche destinations.'),
  ('Data ownership and control', 2, 5, 'RudderStack''s warehouse-native architecture stores all data in your own warehouse first. Segment stores data in Segment''s cloud by default - customers can export but don''t own the primary store.'),
  ('Open-source and self-hosting', 1, 5, 'RudderStack is fully open-source and self-hostable with no artificial limits. Segment is a closed-source SaaS product with no self-hosted option.'),
  ('Pricing at scale', 2, 4, 'Segment pricing scales with Monthly Tracked Users and becomes expensive quickly at growth scale. RudderStack self-hosted is free with unlimited events; cloud pricing is competitive at equivalent volumes.'),
  ('Data quality enforcement', 5, 4, 'Segment Protocols provides robust schema validation and event blocking before data reaches destinations. RudderStack Tracking Plans covers the core use case but is less mature.'),
  ('Compliance and data residency', 2, 5, 'RudderStack self-hosted keeps all data on your own infrastructure - critical for GDPR, HIPAA, and data residency requirements. Segment''s cloud is US-hosted by default with EU residency as a paid add-on.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'segment-vs-rudderstack')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'segment-vs-rudderstack');

-- Pair 2: hotjar-vs-fullstory
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'hotjar-vs-fullstory',
  'hotjar',
  'fullstory',
  'Hotjar vs FullStory is the most common comparison in the session intelligence category, but these tools solve meaningfully different problems. Hotjar is the right tool for marketing sites and landing pages - it shows you where visitors click, scroll, and drop off in aggregate through heatmaps and qualitative feedback. FullStory is the right tool for complex web applications - it captures every interaction without pre-instrumentation, enables retroactive querying of historical sessions, and surfaces product experience anomalies through AI. If your primary concern is conversion optimisation on a marketing site, choose Hotjar. If your primary concern is diagnosing friction in a product with complex user flows, choose FullStory.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'hotjar-vs-fullstory', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Heatmap and aggregate visualisation', 5, 3, 'Hotjar''s heatmaps are the best in class for visualising aggregate click, scroll, and move patterns on pages. FullStory has heatmaps but they are not the primary interface.'),
  ('Session replay depth', 3, 5, 'Both record sessions, but FullStory''s DX Data indexes every interaction enabling retroactive search across sessions. Hotjar session replay is strong but limited to forward-looking data.'),
  ('Retroactive querying', 1, 5, 'FullStory''s defining capability: answer questions about past sessions without re-instrumentation. Hotjar cannot do this - data before a question is asked is unavailable.'),
  ('Feedback and survey tools', 5, 2, 'Hotjar has integrated NPS surveys, polls, and feedback widgets that are market-leading. FullStory''s feedback capabilities are minimal by comparison.'),
  ('Pricing accessibility', 5, 2, 'Hotjar starts at $39/month with a generous free tier. FullStory is enterprise-priced with no transparent public pricing.'),
  ('Use case fit - marketing sites', 5, 2, 'Hotjar is purpose-built for marketing site optimisation and landing page conversion analysis. FullStory is focused on product and application experience.'),
  ('AI anomaly detection', 2, 5, 'FullStory''s AI surfaces unusual drop-off patterns and anomalies automatically. Hotjar''s AI is limited to feedback summarisation.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hotjar-vs-fullstory')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'hotjar-vs-fullstory');

-- Pair 3: chartmogul-vs-baremetrics
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'chartmogul-vs-baremetrics',
  'chartmogul',
  'baremetrics',
  'ChartMogul vs Baremetrics is the primary comparison for SaaS subscription analytics tools. Both pull billing data from Stripe and other payment processors and calculate the metrics that matter for SaaS businesses. ChartMogul wins on depth - richer cohort analysis, more payment processor support, stronger revenue recognition, and a more powerful data platform for growing teams. Baremetrics wins on speed and simplicity - faster setup, a cleaner UI, stronger dunning and recovery tools, and a free public metrics dashboard for founders running in public. The right choice depends on whether you need breadth of analytics or speed of insight.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'chartmogul-vs-baremetrics', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Cohort retention analysis', 5, 3, 'ChartMogul''s cohort analysis is the most detailed available for subscription businesses - you can slice cohort retention by plan, acquisition channel, and custom attributes. Baremetrics cohort analysis covers the basics.'),
  ('Payment processor support', 5, 3, 'ChartMogul connects to Stripe, Braintree, Recurly, Chargebee, and custom sources. Baremetrics is primarily Stripe-focused with limited support for other processors.'),
  ('Setup speed', 3, 5, 'Baremetrics connects to Stripe and has live metrics in minutes. ChartMogul requires more configuration, especially for custom plan attribution and revenue recognition rules.'),
  ('Churn recovery tools', 2, 5, 'Baremetrics Recover runs smart dunning sequences for failed payments. Baremetrics Cancellation Insights captures churn reasons automatically. ChartMogul has no equivalent retention tooling.'),
  ('Free tier access', 5, 1, 'ChartMogul offers a free tier up to $10k MRR - genuinely useful for early-stage companies. Baremetrics has no free tier and starts at $108/month.'),
  ('Revenue recognition and compliance', 5, 3, 'ChartMogul''s revenue recognition reports handle complex subscription scenarios including upgrades, downgrades, and partial periods for finance compliance. Baremetrics is less mature here.'),
  ('Public metrics dashboard', 1, 5, 'Baremetrics''s public metrics page lets founders share live revenue data publicly - a popular feature for bootstrapped and open startup founders. ChartMogul has no equivalent feature.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chartmogul-vs-baremetrics')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'chartmogul-vs-baremetrics');

-- Pair 4: heap-vs-mixpanel
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'heap-vs-mixpanel',
  'heap',
  'mixpanel',
  'Heap vs Mixpanel is the central product analytics debate between two fundamentally different instrumentation philosophies. Heap auto-captures everything - every click, scroll, and interaction - enabling retroactive analysis without pre-defining events. Mixpanel requires you to define events in advance but gives you precise control over what you measure. Heap is the better choice when your team does not have the discipline or engineering bandwidth to maintain a rigorous tracking plan. Mixpanel is the better choice when your team is data-mature and wants to build a clean, intentional event taxonomy that scales without noise. Neither is strictly superior - the right answer depends on your team structure and data culture.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'heap-vs-mixpanel', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Auto-capture without instrumentation', 5, 1, 'Heap auto-captures every user interaction without any event tracking code. Mixpanel requires explicit event instrumentation - you only see what you instrument.'),
  ('Retroactive analysis', 5, 1, 'Heap enables retroactive analysis of historical behaviour using data captured before you had a question. Mixpanel can only answer questions about events that were instrumented before the data was captured.'),
  ('Query flexibility and depth', 3, 5, 'Mixpanel''s query builder offers more flexibility for complex funnel, retention, and segmentation analysis. Heap''s queries are powerful but less configurable for non-standard analyses.'),
  ('Data cleanliness', 2, 5, 'Mixpanel''s explicit instrumentation model forces a clean event taxonomy. Heap''s auto-capture produces noisy raw data that requires virtual event definition to organise.'),
  ('AI-powered insights', 5, 3, 'Heap Illuminate automatically identifies paths that lead to conversion and churn without manual analysis. Mixpanel''s AI Spark surfaces anomalies but requires more manual query construction for insights.'),
  ('Pricing at early stage', 4, 5, 'Mixpanel''s free tier covers 20 million events/month - generous for early-stage products. Heap''s free tier has a lower limit and the paid plans start at a higher price point.'),
  ('Integration ecosystem', 4, 5, 'Both integrate with Segment and major data warehouses. Mixpanel has a slightly larger pre-built integration library for marketing and CRM tools.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'heap-vs-mixpanel')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'heap-vs-mixpanel');

-- Pair 5: plausible-vs-posthog
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'plausible-vs-posthog',
  'plausible',
  'posthog',
  'Plausible vs PostHog covers two of the most popular privacy-respecting analytics alternatives for companies that want to move beyond Google Analytics. Plausible is deliberately simple: web traffic, referrers, and top pages in one clean dashboard with no cookies and minimal script weight. PostHog is comprehensive: product analytics, session replay, feature flags, A/B testing, and surveys - all open-source and self-hostable. Plausible is the right choice for content sites and marketing teams who want honest traffic data with zero configuration. PostHog is the right choice for product teams who need to understand in-app user behaviour and want a full experimentation platform alongside analytics.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'plausible-vs-posthog', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Privacy compliance out of the box', 5, 4, 'Plausible requires no cookies and no consent banner - GDPR, CCPA, and PECR compliant by design. PostHog can be configured for privacy compliance but requires more deliberate setup.'),
  ('Script performance impact', 5, 3, 'Plausible''s script is 45x smaller than Google Analytics. PostHog''s script is lightweight but larger than Plausible due to its broader feature set.'),
  ('Product analytics depth', 1, 5, 'PostHog provides full funnel analysis, retention cohorts, user paths, and session replay for in-app behaviour. Plausible is page-level web traffic only.'),
  ('Feature flags and A/B testing', 1, 5, 'PostHog has built-in feature flags and experimentation. Plausible has no feature flag or A/B testing capability.'),
  ('Self-hosting option', 4, 5, 'Both can be self-hosted. PostHog''s self-hosted version has no event limits and is the most capable open-source analytics suite available. Plausible''s self-hosted version is simpler but fully functional.'),
  ('Ease of setup', 5, 4, 'Plausible is the fastest analytics setup available - one script tag and you are done. PostHog requires SDK integration for product analytics beyond basic pageviews.'),
  ('Pricing for web-only use', 4, 5, 'PostHog cloud is free for up to 1 million events/month - covers most content sites at no cost. Plausible starts at $9/month with no free tier.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'plausible-vs-posthog')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'plausible-vs-posthog');
