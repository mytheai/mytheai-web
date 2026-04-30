-- Fix broken logos for 16 tools.
-- Sets logo_url = NULL so LogoImage fallback chain resolves the best available logo:
--   1. Clearbit (https://logo.clearbit.com/{hostname}) - returns 404 on miss, safe for onError
--   2. favicon.ico at origin - reliable for most established sites
--   3. Letter avatar - clean fallback of last resort
--
-- These tools previously had NULL or Google Favicon API URLs.
-- Google Favicon API blocks the chain: it returns valid placeholder images even for
-- subdomains/unknown domains, so onError never fires and the wrong logo stays.
UPDATE tools SET logo_url = NULL WHERE slug IN (
  'notebooklm',
  'ticktick',
  'aider',
  'clockwise',
  'phind',
  'adobe-podcast',
  'gitpod',
  'adobe-firefly',
  'jamie',
  'shorts-ai',
  'airgram',
  'height-app',
  'detangle-ai',
  'play-ht',
  'lensa-ai',
  'freshchat'
);
