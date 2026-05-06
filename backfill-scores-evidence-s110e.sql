-- S110e: scores_evidence backfill round 5 - 16 more tools.
-- Drops: heygen, coupa, consensus, everlaw, substack, gainsight, gamma-app,
-- mistral, gradescope-ai (all had 1 or 0 URLs verify cleanly via HEAD probe).
-- Idempotent.

BEGIN;

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.onetrust.com/blog/", "type": "official-docs", "label": "OneTrust blog"}],
  "reliability": [{"url": "https://www.onetrust.com/trust/", "type": "official-docs", "label": "OneTrust trust + status"}]
}'::jsonb WHERE slug = 'onetrust';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.mews.com/en/blog", "type": "official-docs", "label": "Mews blog"}],
  "reliability": [{"url": "https://status.mews.com/", "type": "uptime-data", "label": "Mews status"}]
}'::jsonb WHERE slug = 'mews';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://pipedream.com/blog", "type": "official-docs", "label": "Pipedream blog"}],
  "pricing_value": [{"url": "https://pipedream.com/pricing", "type": "official-docs", "label": "Pipedream pricing"}]
}'::jsonb WHERE slug = 'pipedream';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.outreach.io/blog", "type": "official-docs", "label": "Outreach blog"}],
  "reliability": [{"url": "https://status.outreach.io/", "type": "uptime-data", "label": "Outreach status"}]
}'::jsonb WHERE slug = 'outreach';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.descript.com/blog", "type": "official-docs", "label": "Descript blog"}],
  "pricing_value": [{"url": "https://www.descript.com/pricing", "type": "official-docs", "label": "Descript pricing"}]
}'::jsonb WHERE slug = 'descript';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.cultureamp.com/blog/", "type": "official-docs", "label": "Culture Amp blog"}],
  "pricing_value": [{"url": "https://www.cultureamp.com/pricing", "type": "official-docs", "label": "Culture Amp pricing"}]
}'::jsonb WHERE slug = 'culture-amp';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://blog.publer.com/", "type": "official-docs", "label": "Publer blog"}],
  "pricing_value": [{"url": "https://publer.com/pricing", "type": "official-docs", "label": "Publer pricing"}]
}'::jsonb WHERE slug = 'publer';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.deepl.com/blog", "type": "official-docs", "label": "DeepL blog"}],
  "pricing_value": [{"url": "https://www.deepl.com/pro", "type": "official-docs", "label": "DeepL Pro pricing"}]
}'::jsonb WHERE slug = 'deepl';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.lemlist.com/blog", "type": "official-docs", "label": "Lemlist blog"}],
  "pricing_value": [{"url": "https://www.lemlist.com/pricing", "type": "official-docs", "label": "Lemlist pricing"}]
}'::jsonb WHERE slug = 'lemlist';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.close.com/blog", "type": "official-docs", "label": "Close blog"}],
  "pricing_value": [{"url": "https://www.close.com/pricing", "type": "official-docs", "label": "Close pricing"}]
}'::jsonb WHERE slug = 'close';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.veed.io/blog", "type": "official-docs", "label": "VEED blog"}],
  "pricing_value": [{"url": "https://www.veed.io/pricing", "type": "official-docs", "label": "VEED pricing"}]
}'::jsonb WHERE slug = 'veed-io';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.hotjar.com/blog/", "type": "official-docs", "label": "Hotjar blog"}],
  "pricing_value": [{"url": "https://www.hotjar.com/pricing/", "type": "official-docs", "label": "Hotjar pricing"}]
}'::jsonb WHERE slug = 'hotjar';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://tray.ai/blog", "type": "official-docs", "label": "Tray.ai blog"}],
  "reliability": [{"url": "https://status.tray.io/", "type": "uptime-data", "label": "Tray status"}]
}'::jsonb WHERE slug = 'tray-io';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.rippling.com/blog", "type": "official-docs", "label": "Rippling blog"}],
  "pricing_value": [{"url": "https://www.rippling.com/pricing", "type": "official-docs", "label": "Rippling pricing"}]
}'::jsonb WHERE slug = 'rippling';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://pika.art/blog", "type": "official-docs", "label": "Pika blog"}],
  "pricing_value": [{"url": "https://pika.art/pricing", "type": "official-docs", "label": "Pika pricing"}]
}'::jsonb WHERE slug = 'pika';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.intercom.com/changes", "type": "official-docs", "label": "Intercom product changes (Fin AI)"}],
  "feature_depth": [{"url": "https://www.intercom.com/fin", "type": "official-docs", "label": "Fin AI Agent product page"}]
}'::jsonb WHERE slug = 'intercom-fin';

COMMIT;
