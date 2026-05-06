-- S110c: scores_evidence backfill round 3 - 16 more tools via HEAD-probe verified URLs.
-- All 32 URLs verified via HEAD probe (HTTP 200). Drops: elicit (Cloudflare blocks
-- all canonical pages 403), freshdesk + freshsales (trajectory pages 403; would
-- leave only single-entry reliability which is too thin).
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.semrush.com/blog/", "type": "official-docs", "label": "Semrush blog with product updates"}
  ],
  "pricing_value": [
    {"url": "https://www.semrush.com/pricing/", "type": "official-docs", "label": "Semrush pricing tiers"}
  ]
}'::jsonb WHERE slug = 'semrush';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://ahrefs.com/blog/", "type": "official-docs", "label": "Ahrefs blog"}
  ],
  "pricing_value": [
    {"url": "https://ahrefs.com/pricing", "type": "official-docs", "label": "Ahrefs pricing"}
  ]
}'::jsonb WHERE slug = 'ahrefs';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.zendesk.com/blog/", "type": "official-docs", "label": "Zendesk blog"}
  ],
  "reliability": [
    {"url": "https://status.zendesk.com/", "type": "uptime-data", "label": "Zendesk system status"}
  ]
}'::jsonb WHERE slug = 'zendesk';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://surferseo.com/blog/", "type": "official-docs", "label": "Surfer SEO blog"}
  ],
  "pricing_value": [
    {"url": "https://surferseo.com/pricing/", "type": "official-docs", "label": "Surfer SEO pricing"}
  ]
}'::jsonb WHERE slug = 'surfer-seo';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://codeium.com/blog", "type": "official-docs", "label": "Codeium blog"}
  ],
  "pricing_value": [
    {"url": "https://codeium.com/pricing", "type": "official-docs", "label": "Codeium pricing"}
  ]
}'::jsonb WHERE slug = 'codeium';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.tabnine.com/blog/", "type": "official-docs", "label": "Tabnine blog"}
  ],
  "pricing_value": [
    {"url": "https://www.tabnine.com/pricing/", "type": "official-docs", "label": "Tabnine pricing"}
  ]
}'::jsonb WHERE slug = 'tabnine';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://zed.dev/blog", "type": "official-docs", "label": "Zed editor blog"}
  ],
  "pricing_value": [
    {"url": "https://zed.dev/pricing", "type": "official-docs", "label": "Zed pricing"}
  ]
}'::jsonb WHERE slug = 'zed';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.mailerlite.com/blog", "type": "official-docs", "label": "MailerLite blog"}
  ],
  "pricing_value": [
    {"url": "https://www.mailerlite.com/pricing", "type": "official-docs", "label": "MailerLite pricing"}
  ]
}'::jsonb WHERE slug = 'mailerlite';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://lattice.com/library", "type": "official-docs", "label": "Lattice resource library"}
  ],
  "pricing_value": [
    {"url": "https://lattice.com/pricing", "type": "official-docs", "label": "Lattice pricing"}
  ]
}'::jsonb WHERE slug = 'lattice';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://sproutsocial.com/insights/", "type": "official-docs", "label": "Sprout Social insights blog"}
  ],
  "reliability": [
    {"url": "https://status.sproutsocial.com/", "type": "uptime-data", "label": "Sprout Social status"}
  ]
}'::jsonb WHERE slug = 'sprout-social';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.workato.com/blog", "type": "official-docs", "label": "Workato blog"}
  ],
  "reliability": [
    {"url": "https://status.workato.com/", "type": "uptime-data", "label": "Workato status"}
  ]
}'::jsonb WHERE slug = 'workato';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://writesonic.com/blog", "type": "official-docs", "label": "Writesonic blog"}
  ],
  "pricing_value": [
    {"url": "https://writesonic.com/pricing", "type": "official-docs", "label": "Writesonic pricing"}
  ]
}'::jsonb WHERE slug = 'writesonic';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.pandadoc.com/blog/", "type": "official-docs", "label": "PandaDoc blog"}
  ],
  "reliability": [
    {"url": "https://status.pandadoc.com/", "type": "uptime-data", "label": "PandaDoc status"}
  ]
}'::jsonb WHERE slug = 'pandadoc';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.gong.io/blog/", "type": "official-docs", "label": "Gong blog"}
  ],
  "pricing_value": [
    {"url": "https://www.gong.io/pricing/", "type": "official-docs", "label": "Gong pricing"}
  ]
}'::jsonb WHERE slug = 'gong-io';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://quillbot.com/blog/", "type": "official-docs", "label": "QuillBot blog"}
  ],
  "pricing_value": [
    {"url": "https://quillbot.com/premium", "type": "official-docs", "label": "QuillBot Premium pricing"}
  ]
}'::jsonb WHERE slug = 'quillbot';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.lemonade.com/blog", "type": "official-docs", "label": "Lemonade blog"}
  ],
  "pricing_value": [
    {"url": "https://www.lemonade.com/insurance/", "type": "official-docs", "label": "Lemonade insurance products"}
  ]
}'::jsonb WHERE slug = 'lemonade';

COMMIT;
