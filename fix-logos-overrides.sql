-- fix-logos-overrides.sql
-- Targeted logo fixes for tools hosted on major company subdomains.
-- These tools inherit the parent company logo from Clearbit / Favicon API,
-- which is misleading. Setting logo_url = NULL triggers the letter avatar fallback
-- in LogoImage component (shows first letter of tool name - clean and clear).
--
-- Run AFTER fix-logos.sql (not before).

-- NotebookLM: notebooklm.google.com -> Clearbit/Favicon returns Google "G"
UPDATE tools SET logo_url = NULL WHERE slug = 'notebooklm';

-- Adobe Firefly: firefly.adobe.com -> returns Adobe logo
UPDATE tools SET logo_url = NULL WHERE slug = 'adobe-firefly';

-- Adobe Acrobat AI: acrobat.adobe.com -> returns Adobe logo
UPDATE tools SET logo_url = NULL WHERE slug = 'adobe-acrobat-ai';

-- Adobe Podcast: podcast.adobe.com -> returns Adobe logo
UPDATE tools SET logo_url = NULL WHERE slug = 'adobe-podcast';

-- Adobe Lightroom: lightroom.adobe.com -> returns Adobe logo
UPDATE tools SET logo_url = NULL WHERE slug = 'adobe-lightroom';

-- Microsoft Copilot: copilot.microsoft.com -> returns Microsoft logo
-- Note: if the slug is 'microsoft-copilot' or 'copilot', adjust below
UPDATE tools SET logo_url = NULL WHERE slug IN ('microsoft-copilot', 'copilot');

-- Verify: these should all return NULL for logo_url
SELECT slug, name, logo_url, website_url
FROM tools
WHERE slug IN (
  'notebooklm', 'adobe-firefly', 'adobe-acrobat-ai',
  'adobe-podcast', 'adobe-lightroom', 'microsoft-copilot', 'copilot'
)
ORDER BY slug;
