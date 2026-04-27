-- fix-logos.sql v4
-- 1. Fix Microsoft Copilot logo (use microsoft.com parent domain)
-- 2. Delete Tome (site shut down in 2025)

UPDATE tools
SET logo_url = 'https://www.google.com/s2/favicons?domain=microsoft.com&sz=64'
WHERE slug = 'copilot-microsoft';

UPDATE tools
SET logo_url = 'https://www.google.com/s2/favicons?domain=microsoft.com&sz=64'
WHERE slug = 'microsoft-365-copilot';

-- Remove Tome: product shut down, no longer valid
DELETE FROM tools WHERE slug = 'tome';

-- Verify Microsoft Copilot logo updated
SELECT slug, name, logo_url FROM tools
WHERE slug IN ('copilot-microsoft', 'microsoft-365-copilot');
