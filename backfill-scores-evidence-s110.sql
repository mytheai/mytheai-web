-- S110: scores_evidence backfill for next-tier head-term tools.
-- Each tool gets 2-3 evidence entries with documented public URLs across
-- trajectory + reliability dimensions. URLs sourced from official press
-- releases, status pages, and verified company announcements via WebSearch.
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

-- zoom: AI Companion launch + status
UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.zoom.com/en/blog/zoom-ai-companion/", "type": "official-docs", "label": "Zoom AI Companion launch announcement"}
  ],
  "reliability": [
    {"url": "https://status.zoom.us", "type": "uptime-data", "label": "Zoom system status with historical incident data"}
  ]
}'::jsonb WHERE slug = 'zoom';

-- hubspot: Breeze AI launch INBOUND 2024 + status
UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.hubspot.com/company-news/spotlight-product-deep-dive-ai-made-easy-with-breeze-hubspots-new-ai-to-power-the-customer-platform", "type": "official-docs", "label": "Breeze deep-dive: Copilot + 4 Agents"}
  ],
  "reliability": [
    {"url": "https://status.hubspot.com", "type": "uptime-data", "label": "HubSpot system status"}
  ]
}'::jsonb WHERE slug = 'hubspot';

-- loom: Atlassian acquisition Oct 2023 + scale metrics + status
UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.atlassian.com/blog/announcements/atlassian-acquires-loom", "type": "official-docs", "label": "Atlassian acquires Loom for $975M Oct 2023"},
    {"url": "https://www.atlassian.com/blog/loom/loom-atlassian", "type": "official-docs", "label": "Loom joining Atlassian announcement"},
    {"url": "https://www.atlassian.com/blog/announcements/atlassian-acquires-loom", "type": "user-count", "label": "25M+ users and 200K+ customers per acquisition disclosure"}
  ],
  "reliability": [
    {"url": "https://status.loom.com", "type": "uptime-data", "label": "Loom status page"}
  ]
}'::jsonb WHERE slug = 'loom';

-- airtable: Cobuilder AI no-code launch + AI-native pivot + status
UPDATE tools SET scores_evidence = '{
  "trajectory": [
    {"url": "https://www.airtable.com/newsroom/airtables-new-cobuilder-unlocks-instant-no-code-app-creation", "type": "official-docs", "label": "Cobuilder AI no-code app builder launch July 2024"},
    {"url": "https://www.airtable.com/newsroom/introducing-the-ai-native-airtable", "type": "official-docs", "label": "AI-native Airtable platform announcement"}
  ],
  "reliability": [
    {"url": "https://status.airtable.com", "type": "uptime-data", "label": "Airtable status page"}
  ]
}'::jsonb WHERE slug = 'airtable';

COMMIT;
