-- Auto-generated 2026-05-04 + manual additions (awhere, prospera) per direct probe.
-- 13 confirmed dead tools.
-- Policy applied: dns-failed, HTTP 404/410, cert-error, ECONNRESET (confirmed on direct probe).
-- Manual additions (verified via curl direct probe from clean network, 2026-05-04):
--   awhere.com  -> HTTP 403 Caddy parking (company effectively defunct after 2021 acquisition)
--   prospera.ag -> ETIMEDOUT (Valmont absorbed product, customer-facing site offline)
-- REJECTED: all-probes-failed verdicts (Cloudflare false positives), ECONNREFUSED on zendesk/ultimate-ai (major live sites).
-- atomwise + benevolentai are ALIVE but rebranded - website_url update only, no delete.

BEGIN;

DELETE FROM comparisons WHERE tool_a_slug IN (
  'autodesk-forma',
  'awhere',
  'balancing-act',
  'detangle-ai',
  'duetto',
  'espressive',
  'heidi-health',
  'lensa-ai',
  'plan-a',
  'prospera',
  'shorts-ai',
  'skyline-ai',
  'snapsheet'
) OR tool_b_slug IN (
  'autodesk-forma',
  'awhere',
  'balancing-act',
  'detangle-ai',
  'duetto',
  'espressive',
  'heidi-health',
  'lensa-ai',
  'plan-a',
  'prospera',
  'shorts-ai',
  'skyline-ai',
  'snapsheet'
);

DELETE FROM tool_clicks WHERE tool_slug IN (
  'autodesk-forma',
  'awhere',
  'balancing-act',
  'detangle-ai',
  'duetto',
  'espressive',
  'heidi-health',
  'lensa-ai',
  'plan-a',
  'prospera',
  'shorts-ai',
  'skyline-ai',
  'snapsheet'
);

DELETE FROM tools WHERE slug IN (
  'autodesk-forma',
  'awhere',
  'balancing-act',
  'detangle-ai',
  'duetto',
  'espressive',
  'heidi-health',
  'lensa-ai',
  'plan-a',
  'prospera',
  'shorts-ai',
  'skyline-ai',
  'snapsheet'
);

-- Update website_url for rebranded but still-operational tools
UPDATE tools SET website_url = 'https://numerionlabs.ai' WHERE slug = 'atomwise';
UPDATE tools SET website_url = 'https://www.benevolent.com' WHERE slug = 'benevolentai';

COMMIT;

-- After running, execute: node scripts/clean-top10.mjs
-- to remove dead slugs from src/data/top10.ts
