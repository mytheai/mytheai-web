-- fix-logos.sql
-- Updates logo_url for all tools to use Clearbit Logo API.
-- Clearbit returns high-quality 200x200px PNG company logos.
-- URL pattern: https://logo.clearbit.com/{domain}
-- Excludes subdomain tools of Google/Adobe/Microsoft (they return parent logos).
-- Run in Supabase SQL Editor. Then run fix-logos-overrides.sql.

UPDATE tools
SET logo_url = 'https://logo.clearbit.com/' ||
  substring(website_url FROM 'https?://(?:www\.)?([^/?#]+)')
WHERE website_url IS NOT NULL
  AND website_url ~ 'https?://'
  AND length(trim(website_url)) > 0
  AND substring(website_url FROM 'https?://(?:www\.)?([^/?#]+)') IS NOT NULL
  -- Exclude tools on Google/Adobe/Microsoft subdomains (Clearbit returns parent logo)
  AND website_url NOT LIKE '%google.com%'
  AND website_url NOT LIKE '%.adobe.com%'
  AND website_url NOT LIKE '%.microsoft.com%';

-- Verify sample results
SELECT slug, name, logo_url, website_url
FROM tools
ORDER BY rating DESC
LIMIT 20;
