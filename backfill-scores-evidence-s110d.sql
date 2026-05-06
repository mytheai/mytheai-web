-- S110d: scores_evidence backfill round 4 - 12 more tools.
-- All 24 URLs verified via HEAD probe (HTTP 200). Drops: capcut (only 1 URL
-- verified, too thin), matterport (pricing + industries pages 404), drata
-- (drata.com canonical pages bot-blocked).
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://github.blog/changelog/label/copilot/", "type": "official-docs", "label": "GitHub Copilot changelog"}
  ],
  "pricing_value": [
    {"url": "https://github.com/features/copilot/plans", "type": "official-docs", "label": "Copilot pricing plans"}
  ]
}'::jsonb WHERE slug = 'copilot-microsoft';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.blackbox.ai/blog", "type": "official-docs", "label": "BlackBox AI blog"}
  ],
  "pricing_value": [
    {"url": "https://www.blackbox.ai/pricing", "type": "official-docs", "label": "BlackBox AI pricing"}
  ]
}'::jsonb WHERE slug = 'blackbox-ai';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://blog.railway.com/", "type": "official-docs", "label": "Railway blog"}
  ],
  "pricing_value": [
    {"url": "https://railway.com/pricing", "type": "official-docs", "label": "Railway pricing"}
  ]
}'::jsonb WHERE slug = 'railway';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.docusign.com/blog", "type": "official-docs", "label": "DocuSign blog"}
  ],
  "reliability": [
    {"url": "https://trust.docusign.com/en-us/", "type": "uptime-data", "label": "DocuSign trust + status"}
  ]
}'::jsonb WHERE slug = 'docusign-ai';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://cloud.google.com/looker/docs/release-notes", "type": "official-docs", "label": "Looker release notes"}
  ],
  "pricing_value": [
    {"url": "https://cloud.google.com/looker/pricing", "type": "official-docs", "label": "Looker pricing"}
  ]
}'::jsonb WHERE slug = 'looker';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.zoho.com/crm/whats-new.html", "type": "official-docs", "label": "Zoho CRM what is new"}
  ],
  "pricing_value": [
    {"url": "https://www.zoho.com/crm/pricing.html", "type": "official-docs", "label": "Zoho CRM pricing"}
  ]
}'::jsonb WHERE slug = 'zoho-crm';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://navan.com/blog", "type": "official-docs", "label": "Navan blog"}
  ],
  "pricing_value": [
    {"url": "https://navan.com/pricing", "type": "official-docs", "label": "Navan pricing"}
  ]
}'::jsonb WHERE slug = 'navan';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://kahoot.com/blog/", "type": "official-docs", "label": "Kahoot blog"}
  ],
  "pricing_value": [
    {"url": "https://kahoot.com/pricing/", "type": "official-docs", "label": "Kahoot pricing"}
  ]
}'::jsonb WHERE slug = 'kahoot-ai';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.cloudbeds.com/articles/", "type": "official-docs", "label": "Cloudbeds articles"}
  ],
  "pricing_value": [
    {"url": "https://www.cloudbeds.com/pricing/", "type": "official-docs", "label": "Cloudbeds pricing"}
  ]
}'::jsonb WHERE slug = 'cloudbeds';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.guesty.com/blog/", "type": "official-docs", "label": "Guesty blog"}
  ],
  "pricing_value": [
    {"url": "https://www.guesty.com/pricing/", "type": "official-docs", "label": "Guesty pricing"}
  ]
}'::jsonb WHERE slug = 'guesty';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.shopify.com/news", "type": "official-docs", "label": "Shopify newsroom"}
  ],
  "pricing_value": [
    {"url": "https://www.shopify.com/pricing", "type": "official-docs", "label": "Shopify pricing"}
  ]
}'::jsonb WHERE slug = 'shopify-magic';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.vanta.com/blog", "type": "official-docs", "label": "Vanta blog"}
  ],
  "reliability": [
    {"url": "https://status.vanta.com/", "type": "uptime-data", "label": "Vanta status"}
  ]
}'::jsonb WHERE slug = 'vanta';

COMMIT;
