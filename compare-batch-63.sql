-- compare-batch-63.sql
-- 5 Hospitality / Travel Tech comparison pairs
-- All tool slugs confirmed from tools-batch-63.sql (S77, confirmed in DB)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. mews-vs-cloudbeds (PMS head-to-head)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'mews-vs-cloudbeds',
  'mews',
  'cloudbeds',
  'Mews and Cloudbeds are the two most modern cloud PMS platforms competing for independent hotels and growing hotel groups in 2026. Mews is the stronger choice for design-forward boutique hotels and lifestyle properties that want a premium digital guest experience - its mobile check-in, room selection, and digital key delivery are best-in-class. Cloudbeds is the better all-in-one platform for operators who want PMS, channel management, and booking engine in a single subscription without stitching together integrations. Mews wins on guest experience depth and marketplace breadth; Cloudbeds wins on operational completeness and pricing accessibility for smaller properties. Both are strong replacements for legacy Opera or RMS systems.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mews-vs-cloudbeds');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'mews-vs-cloudbeds', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('PMS Core Functionality',      5, 5, 'Both are full-featured cloud PMS platforms - comparable depth on reservations, folios, and housekeeping'),
  ('Digital Guest Experience',    5, 3, 'Mews digital check-in, room selection, and mobile key are best-in-class; Cloudbeds is functional but less polished'),
  ('Channel Manager Integration', 3, 5, 'Cloudbeds has native channel management built in; Mews requires a third-party channel manager via marketplace'),
  ('Booking Engine',              3, 5, 'Cloudbeds includes a native direct booking engine; Mews direct booking requires integration or marketplace add-on'),
  ('Integration Marketplace',     5, 3, 'Mews Marketplace has 1,000+ integrations; Cloudbeds is more limited for niche hospitality add-ons'),
  ('Pricing and Accessibility',   3, 4, 'Cloudbeds pricing is more transparent and accessible for smaller properties; Mews is premium-priced'),
  ('Implementation Speed',        3, 4, 'Cloudbeds is faster to onboard for simpler properties; Mews has more configuration depth to set up')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mews-vs-cloudbeds')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'mews-vs-cloudbeds');

-- 2. guesty-vs-mews (vacation rental vs full PMS)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'guesty-vs-mews',
  'guesty',
  'mews',
  'Guesty and Mews solve different core problems in hospitality technology. Guesty is purpose-built for vacation rental and short-term rental operators - it excels at managing multi-platform listings (Airbnb, VRBO, Booking.com, direct), automating guest communication, and handling the operational complexity of properties spread across many locations with independent owners. Mews is a traditional hotel PMS evolved for the digital era - it handles the front desk, folios, housekeeping, and guest experience workflows that hotel operators need. The two tools serve different customer types with limited overlap. A vacation rental company with 50 properties across Airbnb needs Guesty; a 50-room boutique hotel needs Mews.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'guesty-vs-mews');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'guesty-vs-mews', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Vacation Rental / STR Management', 5, 1, 'Guesty is purpose-built for STR operators with multi-platform distribution and owner management'),
  ('Hotel PMS Functionality',          1, 5, 'Mews is a full hotel PMS; Guesty does not handle traditional hotel front desk workflows'),
  ('OTA Channel Management',           5, 4, 'Guesty connects to Airbnb, VRBO, Booking.com natively; Mews requires third-party channel manager'),
  ('Guest Communication Automation',   5, 4, 'Both have strong automated messaging; Guesty is more flexible for STR-style guest journeys'),
  ('Digital Guest Experience',         3, 5, 'Mews mobile check-in, digital key, and upsell are hotel-grade; Guesty is STR-focused'),
  ('Owner and Trust Accounting',       5, 1, 'Guesty handles owner statements and trust accounting for property managers; Mews does not'),
  ('Pricing and Revenue Management',   3, 4, 'Mews has stronger revenue management integrations; Guesty covers dynamic pricing via Pricelabs integration')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'guesty-vs-mews')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'guesty-vs-mews');

-- 3. duetto-vs-atomize (revenue management)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'duetto-vs-atomize',
  'duetto',
  'atomize',
  'Duetto and Atomize are both AI-powered hotel revenue management systems, but they serve very different market segments. Duetto is the enterprise platform used by hotel groups, casino resorts, and major independent properties where revenue management is a strategic function with dedicated staff. Its Open Pricing model and ScoreBoard analytics are among the most sophisticated in the industry. Atomize is designed specifically for independent hotels and small groups that want AI-driven dynamic pricing recommendations without requiring a full-time revenue manager to configure and operate the platform. For large hotel groups with revenue management teams, Duetto is the stronger choice. For independent properties that want automation over manual rate management, Atomize delivers strong results at a fraction of the cost.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'duetto-vs-atomize');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'duetto-vs-atomize', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Pricing Sophistication',       5, 3, 'Duetto Open Pricing model handles independent rates per room type, channel, and segment simultaneously'),
  ('AI Automation Level',          4, 5, 'Atomize is more fully automated - requires less manual input from revenue managers to run'),
  ('Ease of Implementation',       2, 5, 'Atomize onboards in days; Duetto implementations take months with dedicated project management'),
  ('Pricing and Affordability',    2, 4, 'Atomize pricing is accessible for independent hotels; Duetto requires enterprise contracts'),
  ('Analytics and Reporting',      5, 3, 'Duetto ScoreBoard analytics are among the deepest in the market; Atomize reporting is functional but lighter'),
  ('PMS Integration Breadth',      5, 4, 'Duetto integrates with more PMS platforms including Opera, Mews, and all major enterprise systems'),
  ('Best Fit',                     3, 4, 'Duetto for groups and large properties; Atomize for independent hotels wanting pricing automation')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'duetto-vs-atomize')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'duetto-vs-atomize');

-- 4. siteminder-vs-cloudbeds (channel manager vs all-in-one PMS)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'siteminder-vs-cloudbeds',
  'siteminder',
  'cloudbeds',
  'SiteMinder and Cloudbeds are frequently compared by independent hoteliers deciding whether to adopt a dedicated channel manager or an all-in-one platform. SiteMinder is the world''s most widely used hotel channel manager, connecting hotel inventory to 450+ booking channels with best-in-class distribution reliability and OTA relationship management. Cloudbeds is a full PMS that includes a channel manager as one of its modules. For properties that already have a PMS they are happy with and just need better OTA distribution, SiteMinder is the cleaner choice. For properties that need a new PMS and want OTA distribution bundled in, Cloudbeds eliminates the need for a separate channel manager. The right choice depends on what is already in the property''s technology stack.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'siteminder-vs-cloudbeds');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'siteminder-vs-cloudbeds', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('OTA Channel Coverage',         5, 4, 'SiteMinder connects to 450+ channels; Cloudbeds covers the major OTAs but with fewer niche channels'),
  ('PMS Functionality',            1, 5, 'Cloudbeds is a full PMS; SiteMinder is a channel manager only and requires a separate PMS'),
  ('Distribution Reliability',     5, 4, 'SiteMinder has deeper OTA relationships and higher uptime on rate and inventory updates'),
  ('All-in-One Value',             1, 5, 'Cloudbeds bundles PMS, channel manager, and booking engine - lower total cost than buying separate tools'),
  ('Booking Engine',               4, 4, 'Both include direct booking engine capabilities; comparable quality for independent properties'),
  ('Revenue Management Tools',     3, 3, 'Both offer basic dynamic pricing tools; neither matches dedicated revenue management platforms'),
  ('Implementation Complexity',    4, 3, 'SiteMinder is simpler to connect to an existing PMS; Cloudbeds requires full PMS migration for existing users')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'siteminder-vs-cloudbeds')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'siteminder-vs-cloudbeds');

-- 5. hopper-vs-navan (consumer vs business travel)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'hopper-vs-navan',
  'hopper',
  'navan',
  'Hopper and Navan are both AI-powered travel platforms but serve almost entirely different markets and use cases. Hopper is a consumer travel booking app built around AI price prediction - it tells leisure travelers when to buy flights and hotels to get the best price, and lets users freeze prices before committing. Navan is a corporate travel management platform that handles business travel booking and expense reporting for companies. The comparison is more about understanding which tool fits which traveler type than a direct head-to-head. Individual leisure travelers benefit from Hopper''s price prediction; companies managing employee travel benefit from Navan''s policy enforcement, spend control, and expense automation.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hopper-vs-navan');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'hopper-vs-navan', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Price Prediction and Savings',  5, 2, 'Hopper''s AI price prediction is the best consumer tool for timing travel purchases; Navan focuses on policy not price timing'),
  ('Corporate Travel Management',  1, 5, 'Navan is built for business travel with policy enforcement, preferred suppliers, and expense integration'),
  ('Expense Reporting',             1, 5, 'Navan auto-generates expense reports from card spend; Hopper has no expense management'),
  ('Travel Policy Compliance',      1, 5, 'Navan enforces travel policy at booking; Hopper has no policy management'),
  ('Consumer Booking Experience',   5, 3, 'Hopper''s consumer app is fast and intuitive; Navan is optimised for corporate workflows not leisure UX'),
  ('Flexible Travel Options',       5, 3, 'Hopper''s Price Freeze and Cancel For Any Reason add-ons give leisure travelers flexibility; Navan handles approvals'),
  ('Total Cost Management',         2, 5, 'Navan gives finance teams real-time spend visibility and budget control; Hopper is individual-focused')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hopper-vs-navan')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'hopper-vs-navan');
