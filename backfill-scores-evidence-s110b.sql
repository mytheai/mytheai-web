-- S110b: scores_evidence backfill round 2 - 13 more tools via HEAD-probe verified URLs.
-- Used scripts/evidence-research-helper.mjs to confirm each URL via HTTP HEAD
-- before commit. Canonical pages (status, blog, changelog, pricing) chosen
-- because they avoid Cloudflare bot block that hit S110a's salesforce/hubspot
-- IR / tableau attempts.
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://slack.com/whats-new", "type": "official-docs", "label": "Slack product changelog"}
  ],
  "reliability": [
    {"url": "https://status.slack.com", "type": "uptime-data", "label": "Slack status with historical uptime"}
  ]
}'::jsonb WHERE slug = 'slack';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://monday.com/whats-new", "type": "official-docs", "label": "Monday.com product updates feed"}
  ],
  "reliability": [
    {"url": "https://status.monday.com", "type": "uptime-data", "label": "Monday.com system status"}
  ]
}'::jsonb WHERE slug = 'monday';

UPDATE tools SET scores_evidence = '{
  "reliability": [
    {"url": "https://trust.asana.com/", "type": "uptime-data", "label": "Asana trust + status page"}
  ],
  "trajectory": [
    {"url": "https://asana.com/whats-new", "type": "official-docs", "label": "Asana product release notes"}
  ]
}'::jsonb WHERE slug = 'asana';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.todoist.com/help/articles/what-s-new-in-todoist-IzaJC8YuW", "type": "official-docs", "label": "Todoist what is new"}
  ],
  "pricing_value": [
    {"url": "https://www.todoist.com/pricing", "type": "official-docs", "label": "Todoist pricing tiers"}
  ]
}'::jsonb WHERE slug = 'todoist';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://miro.com/blog/", "type": "official-docs", "label": "Miro blog with product updates"}
  ],
  "pricing_value": [
    {"url": "https://miro.com/pricing/", "type": "official-docs", "label": "Miro pricing tiers"}
  ]
}'::jsonb WHERE slug = 'miro';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.framer.com/updates/", "type": "official-docs", "label": "Framer product updates"}
  ],
  "pricing_value": [
    {"url": "https://www.framer.com/pricing/", "type": "official-docs", "label": "Framer pricing"}
  ]
}'::jsonb WHERE slug = 'framer';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://linear.app/changelog", "type": "official-docs", "label": "Linear public changelog"}
  ],
  "reliability": [
    {"url": "https://status.linear.app/", "type": "uptime-data", "label": "Linear status page"}
  ]
}'::jsonb WHERE slug = 'linear';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://fireflies.ai/blog", "type": "official-docs", "label": "Fireflies product blog"}
  ],
  "pricing_value": [
    {"url": "https://fireflies.ai/pricing", "type": "official-docs", "label": "Fireflies pricing"}
  ]
}'::jsonb WHERE slug = 'fireflies-ai';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.metabase.com/blog", "type": "official-docs", "label": "Metabase blog"}
  ],
  "pricing_value": [
    {"url": "https://www.metabase.com/pricing/", "type": "official-docs", "label": "Metabase pricing"}
  ]
}'::jsonb WHERE slug = 'metabase';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.pipedrive.com/en/blog", "type": "official-docs", "label": "Pipedrive product blog"}
  ],
  "reliability": [
    {"url": "https://status.pipedrive.com", "type": "uptime-data", "label": "Pipedrive status page"}
  ]
}'::jsonb WHERE slug = 'pipedrive';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://clickup.com/blog", "type": "official-docs", "label": "ClickUp blog"}
  ],
  "reliability": [
    {"url": "https://status.clickup.com", "type": "uptime-data", "label": "ClickUp status"}
  ]
}'::jsonb WHERE slug = 'clickup';

UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.intercom.com/changes", "type": "official-docs", "label": "Intercom product changes"}
  ],
  "reliability": [
    {"url": "https://www.intercomstatus.com/", "type": "uptime-data", "label": "Intercom status page"}
  ]
}'::jsonb WHERE slug = 'intercom';

COMMIT;
