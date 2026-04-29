-- fix-logos.sql
-- Updates logo_url for all tools to use Clearbit Logo API.
-- Clearbit returns high-quality 200x200px PNG company logos.
-- URL pattern: https://logo.clearbit.com/{domain}
-- Run in Supabase SQL Editor.

UPDATE tools
SET logo_url = 'https://logo.clearbit.com/' ||
  substring(website_url FROM 'https?://(?:www\.)?([^/?#]+)')
WHERE website_url IS NOT NULL
  AND website_url ~ 'https?://'
  AND length(trim(website_url)) > 0
  AND substring(website_url FROM 'https?://(?:www\.)?([^/?#]+)') IS NOT NULL;

-- Verify sample results
SELECT slug, name, logo_url, website_url
FROM tools
ORDER BY rating DESC
LIMIT 20;
