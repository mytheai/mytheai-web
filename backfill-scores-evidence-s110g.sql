-- S110g: scores_evidence backfill round 7 - 19 more tools.
-- Drops with single-entry only: paxton-ai (blog 404), compass (news 404),
-- flick-social (blog network error), ramp (status network error),
-- palantir (blog.palantir.com 403).
-- Idempotent.

BEGIN;

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://sparkmailapp.com/blog", "type": "official-docs", "label": "Spark blog"}],
  "pricing_value": [{"url": "https://sparkmailapp.com/pricing", "type": "official-docs", "label": "Spark pricing"}]
}'::jsonb WHERE slug = 'spark-mail';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://hypefury.com/blog", "type": "official-docs", "label": "Hypefury blog"}],
  "pricing_value": [{"url": "https://hypefury.com/pricing", "type": "official-docs", "label": "Hypefury pricing"}]
}'::jsonb WHERE slug = 'hypefury';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://sourcegraph.com/blog", "type": "official-docs", "label": "Sourcegraph blog"}],
  "pricing_value": [{"url": "https://sourcegraph.com/pricing", "type": "official-docs", "label": "Sourcegraph pricing"}]
}'::jsonb WHERE slug = 'cody';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://metricool.com/blog/", "type": "official-docs", "label": "Metricool blog"}],
  "pricing_value": [{"url": "https://metricool.com/pricing/", "type": "official-docs", "label": "Metricool pricing"}]
}'::jsonb WHERE slug = 'metricool';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://front.com/blog", "type": "official-docs", "label": "Front blog"}],
  "reliability": [{"url": "https://status.frontapp.com/", "type": "uptime-data", "label": "Front status"}]
}'::jsonb WHERE slug = 'front-app';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://blog.continue.dev/", "type": "official-docs", "label": "Continue blog"}],
  "feature_depth": [{"url": "https://docs.continue.dev/", "type": "official-docs", "label": "Continue docs"}]
}'::jsonb WHERE slug = 'continue-dev';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://buffer.com/resources/", "type": "official-docs", "label": "Buffer resources blog"}],
  "pricing_value": [{"url": "https://buffer.com/pricing", "type": "official-docs", "label": "Buffer pricing"}]
}'::jsonb WHERE slug = 'buffer';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://submagic.co/blog", "type": "official-docs", "label": "Submagic blog"}],
  "pricing_value": [{"url": "https://submagic.co/pricing", "type": "official-docs", "label": "Submagic pricing"}]
}'::jsonb WHERE slug = 'submagic';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.kommo.com/blog/", "type": "official-docs", "label": "Kommo blog"}],
  "pricing_value": [{"url": "https://www.kommo.com/pricing/", "type": "official-docs", "label": "Kommo pricing"}]
}'::jsonb WHERE slug = 'kommo';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.photoroom.com/blog", "type": "official-docs", "label": "PhotoRoom blog"}],
  "pricing_value": [{"url": "https://www.photoroom.com/pricing", "type": "official-docs", "label": "PhotoRoom pricing"}]
}'::jsonb WHERE slug = 'photoroom';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://crowdin.com/blog", "type": "official-docs", "label": "Crowdin blog"}],
  "reliability": [{"url": "https://status.crowdin.com/", "type": "uptime-data", "label": "Crowdin status"}]
}'::jsonb WHERE slug = 'crowdin';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://maze.co/blog/", "type": "official-docs", "label": "Maze blog"}],
  "pricing_value": [{"url": "https://maze.co/pricing/", "type": "official-docs", "label": "Maze pricing"}]
}'::jsonb WHERE slug = 'maze';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.talentlms.com/blog", "type": "official-docs", "label": "TalentLMS blog"}],
  "pricing_value": [{"url": "https://www.talentlms.com/pricing", "type": "official-docs", "label": "TalentLMS pricing"}]
}'::jsonb WHERE slug = 'talentlms';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.tenable.com/blog", "type": "official-docs", "label": "Tenable blog"}],
  "reliability": [{"url": "https://status.tenable.com/", "type": "uptime-data", "label": "Tenable status"}]
}'::jsonb WHERE slug = 'tenable-io';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://simplified.com/blog", "type": "official-docs", "label": "Simplified blog"}],
  "pricing_value": [{"url": "https://simplified.com/pricing", "type": "official-docs", "label": "Simplified pricing"}]
}'::jsonb WHERE slug = 'simplified';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://integrately.com/blog", "type": "official-docs", "label": "Integrately blog"}],
  "pricing_value": [{"url": "https://integrately.com/pricing", "type": "official-docs", "label": "Integrately pricing"}]
}'::jsonb WHERE slug = 'integrately';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.agorapulse.com/blog/", "type": "official-docs", "label": "Agorapulse blog"}],
  "pricing_value": [{"url": "https://www.agorapulse.com/pricing/", "type": "official-docs", "label": "Agorapulse pricing"}]
}'::jsonb WHERE slug = 'agorapulse';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.smartlead.ai/blog", "type": "official-docs", "label": "Smartlead blog"}],
  "pricing_value": [{"url": "https://www.smartlead.ai/pricing", "type": "official-docs", "label": "Smartlead pricing"}]
}'::jsonb WHERE slug = 'smartlead';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.close.com/blog", "type": "official-docs", "label": "Close blog"}],
  "pricing_value": [{"url": "https://www.close.com/pricing", "type": "official-docs", "label": "Close pricing"}]
}'::jsonb WHERE slug = 'close-crm';

COMMIT;
