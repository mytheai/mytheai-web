-- fix-all-logos.sql
-- COMPREHENSIVE one-shot fix for all logo_url issues.
-- Run this ONCE in Supabase SQL Editor. Safe to re-run (idempotent).
--
-- Strategy: use Google S2 favicons (https://www.google.com/s2/favicons?...) as
-- the single source for every tool. Google's CDN is fast worldwide (much faster
-- than Clearbit from Asia), always returns an image (never 404), supports every
-- domain including subdomains like notebooklm.google.com and aider.chat that
-- Clearbit and other logo APIs do not have.
--
-- Trade-off: max resolution 128x128 (vs Clearbit's higher-res branded PNG).
-- For thumbnail-sized logos (32-48px in tool cards), 128px is more than enough
-- and the speed/reliability win dominates.

-- ============================================================
-- Reset all logo_url and rebuild from website_url
-- ============================================================
UPDATE tools
SET logo_url = 'https://www.google.com/s2/favicons?domain='
            || regexp_replace(website_url, '^https?://(www\.)?([^/]+).*$', '\2')
            || '&sz=128'
WHERE website_url IS NOT NULL
  AND website_url <> '';

-- ============================================================
-- Verification (uncomment any to run)
-- ============================================================
-- SELECT count(*) AS total FROM tools;
-- SELECT count(*) AS using_s2 FROM tools WHERE logo_url LIKE '%google.com/s2/favicons%';
-- SELECT count(*) AS still_null FROM tools WHERE logo_url IS NULL;
-- SELECT slug, name, logo_url FROM tools ORDER BY random() LIMIT 5;
