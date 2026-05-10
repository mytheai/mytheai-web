-- Fix spiff website_url: spiff.com no longer resolves (Salesforce acquired Spiff)
-- Verified 2026-05-10: spiff.io returns HTTP 200, spiff.com connection-failed
-- Detected during freeze-prep dead-tool sweep S160 follow-up

UPDATE tools
SET website_url = 'https://spiff.io'
WHERE slug = 'spiff';
