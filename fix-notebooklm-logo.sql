-- fix-notebooklm-logo.sql
-- Issue: Google s2/favicons returns generic Google G for notebooklm.google.com subdomain
-- Fix: switch to DuckDuckGo's icon API which has better subdomain coverage

UPDATE tools
SET logo_url = 'https://icons.duckduckgo.com/ip3/notebooklm.google.com.ico'
WHERE slug = 'notebooklm';

SELECT slug, name, logo_url FROM tools WHERE slug = 'notebooklm';
