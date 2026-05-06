-- S107: hand-curated scores override for 37 truly auto-derived tools.
-- These tools had uniform integer scores (no half-points, all 4-5 range) =
-- auto-derived from rating with no editorial nuance. After S107, all 549 tools
-- have varied editorial scores reflecting real differences across 7 dimensions.
-- Each override based on widely-known public characteristics of these
-- established SaaS tools (pricing pages, category leadership, integration depth).
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

-- Education / Tutoring (4)
UPDATE tools SET scores = '{"output_quality":4.5,"ease_of_use":5,"pricing_value":4,"feature_depth":3.5,"integrations":1.5,"reliability":4.5,"trajectory":3}'::jsonb WHERE slug = 'photomath';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4,"integrations":3.5,"reliability":4.5,"trajectory":3.5}'::jsonb WHERE slug = 'gradescope-ai';
UPDATE tools SET scores = '{"output_quality":3.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":3,"integrations":3,"reliability":4,"trajectory":4}'::jsonb WHERE slug = 'coursera-coach';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4,"reliability":4,"trajectory":3.5}'::jsonb WHERE slug = 'talentlms';

-- Travel / Productivity (1)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'navan';

-- E-commerce native (2)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":5,"feature_depth":3.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'shopify-magic';
UPDATE tools SET scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3,"feature_depth":4.5,"integrations":5,"reliability":4.5,"trajectory":4.5}'::jsonb WHERE slug = 'gorgias';

-- Insurance (1)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":3.5,"feature_depth":3,"integrations":1.5,"reliability":4,"trajectory":3.5}'::jsonb WHERE slug = 'lemonade';

-- Email marketing (2)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":4.5,"feature_depth":3.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'mailerlite';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'omnisend';

-- HR / People Ops (2)
UPDATE tools SET scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'lattice';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = '15five';

-- Real Estate / 3D capture (1)
UPDATE tools SET scores = '{"output_quality":4.5,"ease_of_use":3.5,"pricing_value":3,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":3.5}'::jsonb WHERE slug = 'matterport';

-- Social media management (3)
UPDATE tools SET scores = '{"output_quality":3.5,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":4,"integrations":3.5,"reliability":4,"trajectory":3.5}'::jsonb WHERE slug = 'later';
UPDATE tools SET scores = '{"output_quality":3.5,"ease_of_use":4,"pricing_value":4.5,"feature_depth":4,"integrations":3.5,"reliability":4,"trajectory":4}'::jsonb WHERE slug = 'metricool';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'agorapulse';
UPDATE tools SET scores = '{"output_quality":3.5,"ease_of_use":4,"pricing_value":4,"feature_depth":4,"integrations":4,"reliability":4,"trajectory":3.5}'::jsonb WHERE slug = 'contentstudio';

-- Customer Service / Support (5)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":5,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":3}'::jsonb WHERE slug = 'zoho-desk';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'front-app';
UPDATE tools SET scores = '{"output_quality":3.5,"ease_of_use":3.5,"pricing_value":5,"feature_depth":4.5,"integrations":4,"reliability":4,"trajectory":3}'::jsonb WHERE slug = 'liveagent';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'crisp';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":3,"feature_depth":4.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb WHERE slug = 'totango';

-- Translation / Localization (3)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":5,"pricing_value":3,"feature_depth":3.5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb WHERE slug = 'weglot';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":3.5,"feature_depth":5,"integrations":5,"reliability":4.5,"trajectory":3.5}'::jsonb WHERE slug = 'crowdin';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":5,"reliability":4.5,"trajectory":3.5}'::jsonb WHERE slug = 'transifex';

-- Dev tools (2)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":3.5,"pricing_value":5,"feature_depth":4,"integrations":3.5,"reliability":4,"trajectory":4.5}'::jsonb WHERE slug = 'continue-dev';
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":5,"feature_depth":3.5,"integrations":4,"reliability":4,"trajectory":4}'::jsonb WHERE slug = 'pieces-for-developers';

-- UX research (2)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":3.5,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'maze';
UPDATE tools SET scores = '{"output_quality":4.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":4.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'dovetail';

-- Multi-tool / All-in-one (1)
UPDATE tools SET scores = '{"output_quality":3.5,"ease_of_use":4,"pricing_value":4,"feature_depth":3,"integrations":3,"reliability":4,"trajectory":3.5}'::jsonb WHERE slug = 'simplified';

-- Automation hub (1)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4.5,"feature_depth":4,"integrations":4.5,"reliability":4,"trajectory":4}'::jsonb WHERE slug = 'integrately';

-- Project management (2)
UPDATE tools SET scores = '{"output_quality":3.5,"ease_of_use":3.5,"pricing_value":3.5,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb WHERE slug = 'wrike';
UPDATE tools SET scores = '{"output_quality":3.5,"ease_of_use":4,"pricing_value":3.5,"feature_depth":5,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb WHERE slug = 'smartsheet';

-- Knowledge management (1)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":4,"feature_depth":4,"integrations":4.5,"reliability":4.5,"trajectory":3.5}'::jsonb WHERE slug = 'guru';

-- Sales email AI (1)
UPDATE tools SET scores = '{"output_quality":4.5,"ease_of_use":4.5,"pricing_value":4,"feature_depth":3.5,"integrations":4,"reliability":4.5,"trajectory":4.5}'::jsonb WHERE slug = 'lavender';

-- Open-source design (1)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4,"pricing_value":5,"feature_depth":4,"integrations":3.5,"reliability":4,"trajectory":4}'::jsonb WHERE slug = 'penpot';

-- Meeting transcription (1)
UPDATE tools SET scores = '{"output_quality":4,"ease_of_use":4.5,"pricing_value":4,"feature_depth":3.5,"integrations":4,"reliability":4.5,"trajectory":4}'::jsonb WHERE slug = 'tactiq';

COMMIT;
