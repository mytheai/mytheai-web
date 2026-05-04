-- fix-notebooklm-logo.sql (rev 2)
-- Issue: DuckDuckGo icons API returns a stale 2019 generic favicon (predates NotebookLM 2023).
-- Google s2/favicons returns a generic Google G for *.google.com subdomains.
-- Fix: use NotebookLM's own static branded favicon from the apex domain (notebooklm.google).

BEGIN;

UPDATE tools
SET logo_url = 'https://notebooklm.google/_/static/branding/v4/light_mode/favicon/favicon-32x32.png'
WHERE slug = 'notebooklm';

COMMIT;

SELECT slug, name, logo_url FROM tools WHERE slug = 'notebooklm';
