-- S110h: scores_evidence backfill round 8 - 16 more tools.
-- Drops: fathom (trajectory 404), greenly (feature_depth 404).
-- Idempotent.

BEGIN;

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://n8n.io/blog/", "type": "official-docs", "label": "n8n blog"}],
  "pricing_value": [{"url": "https://n8n.io/pricing/", "type": "official-docs", "label": "n8n pricing"}]
}'::jsonb WHERE slug = 'n8n';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.klaviyo.com/blog", "type": "official-docs", "label": "Klaviyo blog"}],
  "pricing_value": [{"url": "https://www.klaviyo.com/pricing", "type": "official-docs", "label": "Klaviyo pricing"}]
}'::jsonb WHERE slug = 'klaviyo';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://huggingface.co/blog", "type": "official-docs", "label": "Hugging Face blog"}],
  "feature_depth": [{"url": "https://huggingface.co/models", "type": "official-docs", "label": "Hugging Face model catalog"}]
}'::jsonb WHERE slug = 'hugging-face';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.hibob.com/blog/", "type": "official-docs", "label": "HiBob blog"}],
  "pricing_value": [{"url": "https://www.hibob.com/pricing/", "type": "official-docs", "label": "HiBob pricing"}]
}'::jsonb WHERE slug = 'hibob';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://bubble.io/blog", "type": "official-docs", "label": "Bubble blog"}],
  "pricing_value": [{"url": "https://bubble.io/pricing", "type": "official-docs", "label": "Bubble pricing"}]
}'::jsonb WHERE slug = 'bubble';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.drift.com/blog/", "type": "official-docs", "label": "Drift blog"}],
  "pricing_value": [{"url": "https://www.drift.com/pricing/", "type": "official-docs", "label": "Drift pricing"}]
}'::jsonb WHERE slug = 'drift';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.pendo.io/blog/", "type": "official-docs", "label": "Pendo blog"}],
  "reliability": [{"url": "https://status.pendo.io/", "type": "uptime-data", "label": "Pendo status"}]
}'::jsonb WHERE slug = 'pendo';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://pieces.app/blog", "type": "official-docs", "label": "Pieces blog"}],
  "pricing_value": [{"url": "https://pieces.app/pricing", "type": "official-docs", "label": "Pieces pricing"}]
}'::jsonb WHERE slug = 'pieces-for-developers';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.gong.io/blog/", "type": "official-docs", "label": "Gong blog"}],
  "pricing_value": [{"url": "https://www.gong.io/pricing/", "type": "official-docs", "label": "Gong pricing"}]
}'::jsonb WHERE slug = 'gong';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://contentstudio.io/blog", "type": "official-docs", "label": "ContentStudio blog"}],
  "pricing_value": [{"url": "https://contentstudio.io/pricing", "type": "official-docs", "label": "ContentStudio pricing"}]
}'::jsonb WHERE slug = 'contentstudio';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://segment.com/blog/", "type": "official-docs", "label": "Segment blog"}],
  "reliability": [{"url": "https://status.segment.com/", "type": "uptime-data", "label": "Segment status"}]
}'::jsonb WHERE slug = 'segment';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.lever.co/blog/", "type": "official-docs", "label": "Lever blog"}],
  "pricing_value": [{"url": "https://www.lever.co/pricing/", "type": "official-docs", "label": "Lever pricing"}]
}'::jsonb WHERE slug = 'lever';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://coda.io/blog", "type": "official-docs", "label": "Coda blog"}],
  "pricing_value": [{"url": "https://coda.io/pricing", "type": "official-docs", "label": "Coda pricing"}]
}'::jsonb WHERE slug = 'coda';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.gorgias.com/blog", "type": "official-docs", "label": "Gorgias blog"}],
  "pricing_value": [{"url": "https://www.gorgias.com/pricing", "type": "official-docs", "label": "Gorgias pricing"}]
}'::jsonb WHERE slug = 'gorgias';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.loomly.com/blog", "type": "official-docs", "label": "Loomly blog"}],
  "pricing_value": [{"url": "https://www.loomly.com/pricing", "type": "official-docs", "label": "Loomly pricing"}]
}'::jsonb WHERE slug = 'loomly';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://blog.hootsuite.com/", "type": "official-docs", "label": "Hootsuite blog"}],
  "pricing_value": [{"url": "https://www.hootsuite.com/plans", "type": "official-docs", "label": "Hootsuite plans"}]
}'::jsonb WHERE slug = 'hootsuite';

COMMIT;
