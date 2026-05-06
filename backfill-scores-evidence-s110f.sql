-- S110f: scores_evidence backfill round 6 - 19 more tools.
-- Drops: zoho-desk (both /desk/ paths 404), reply-io (Cloudflare 403),
-- bamboohr trajectory blog 403.
-- Idempotent.

BEGIN;

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://later.com/blog/", "type": "official-docs", "label": "Later blog"}],
  "pricing_value": [{"url": "https://later.com/pricing/", "type": "official-docs", "label": "Later pricing"}]
}'::jsonb WHERE slug = 'later';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://vistasocial.com/insights/", "type": "official-docs", "label": "Vista Social insights"}],
  "pricing_value": [{"url": "https://vistasocial.com/pricing/", "type": "official-docs", "label": "Vista Social pricing"}]
}'::jsonb WHERE slug = 'vista-social';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://mem.ai/blog", "type": "official-docs", "label": "Mem blog"}],
  "pricing_value": [{"url": "https://mem.ai/pricing", "type": "official-docs", "label": "Mem pricing"}]
}'::jsonb WHERE slug = 'mem-ai';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.omnisend.com/blog/", "type": "official-docs", "label": "Omnisend blog"}],
  "pricing_value": [{"url": "https://www.omnisend.com/pricing/", "type": "official-docs", "label": "Omnisend pricing"}]
}'::jsonb WHERE slug = 'omnisend';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.streak.com/blog", "type": "official-docs", "label": "Streak blog"}],
  "pricing_value": [{"url": "https://www.streak.com/pricing", "type": "official-docs", "label": "Streak pricing"}]
}'::jsonb WHERE slug = 'streak';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.15five.com/blog/", "type": "official-docs", "label": "15Five blog"}],
  "pricing_value": [{"url": "https://www.15five.com/pricing", "type": "official-docs", "label": "15Five pricing"}]
}'::jsonb WHERE slug = '15five';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.salesloft.com/resources/blog", "type": "official-docs", "label": "Salesloft blog"}],
  "reliability": [{"url": "https://status.salesloft.com/", "type": "uptime-data", "label": "Salesloft status"}]
}'::jsonb WHERE slug = 'salesloft';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.weglot.com/blog", "type": "official-docs", "label": "Weglot blog"}],
  "pricing_value": [{"url": "https://www.weglot.com/pricing", "type": "official-docs", "label": "Weglot pricing"}]
}'::jsonb WHERE slug = 'weglot';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://posthog.com/blog", "type": "official-docs", "label": "PostHog blog"}],
  "pricing_value": [{"url": "https://posthog.com/pricing", "type": "official-docs", "label": "PostHog pricing"}]
}'::jsonb WHERE slug = 'posthog';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.apollo.io/blog", "type": "official-docs", "label": "Apollo blog"}],
  "pricing_value": [{"url": "https://www.apollo.io/pricing", "type": "official-docs", "label": "Apollo pricing"}]
}'::jsonb WHERE slug = 'apollo';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.greenhouse.com/blog", "type": "official-docs", "label": "Greenhouse blog"}],
  "reliability": [{"url": "https://status.greenhouse.io/", "type": "uptime-data", "label": "Greenhouse status"}]
}'::jsonb WHERE slug = 'greenhouse';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.clio.com/blog/", "type": "official-docs", "label": "Clio blog"}],
  "pricing_value": [{"url": "https://www.clio.com/pricing/", "type": "official-docs", "label": "Clio pricing"}]
}'::jsonb WHERE slug = 'clio';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.articulate.com/blog/", "type": "official-docs", "label": "Articulate blog"}],
  "pricing_value": [{"url": "https://www.articulate.com/360/pricing", "type": "official-docs", "label": "Articulate 360 pricing"}]
}'::jsonb WHERE slug = 'articulate';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://cal.com/blog", "type": "official-docs", "label": "Cal.com blog"}],
  "pricing_value": [{"url": "https://cal.com/pricing", "type": "official-docs", "label": "Cal.com pricing"}]
}'::jsonb WHERE slug = 'cal-com';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://mailchimp.com/resources/", "type": "official-docs", "label": "Mailchimp resources"}],
  "pricing_value": [{"url": "https://mailchimp.com/pricing/", "type": "official-docs", "label": "Mailchimp pricing"}]
}'::jsonb WHERE slug = 'mailchimp';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.helpscout.com/blog/", "type": "official-docs", "label": "Help Scout blog"}],
  "pricing_value": [{"url": "https://www.helpscout.com/pricing/", "type": "official-docs", "label": "Help Scout pricing"}]
}'::jsonb WHERE slug = 'helpscout';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://stability.ai/news", "type": "official-docs", "label": "Stability AI news"}],
  "feature_depth": [{"url": "https://stability.ai/stable-image", "type": "official-docs", "label": "Stable Image product page"}]
}'::jsonb WHERE slug = 'stable-diffusion';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://obsidian.md/changelog/", "type": "official-docs", "label": "Obsidian changelog"}],
  "pricing_value": [{"url": "https://obsidian.md/pricing", "type": "official-docs", "label": "Obsidian pricing"}]
}'::jsonb WHERE slug = 'obsidian';

UPDATE tools SET scores_evidence = '{
  "trajectory": [{"url": "https://www.bardeen.ai/blog", "type": "official-docs", "label": "Bardeen blog"}],
  "pricing_value": [{"url": "https://www.bardeen.ai/pricing", "type": "official-docs", "label": "Bardeen pricing"}]
}'::jsonb WHERE slug = 'bardeen';

COMMIT;
