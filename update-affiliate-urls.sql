-- Affiliate URL update template
-- Run after each wave of program approvals.
--
-- Workflow:
--   1. Founder gets approval email from a program (e.g., Jasper via Impact)
--   2. Copy the affiliate URL pattern from the network dashboard
--      (typically: https://jasper.ai/?ref={your_id}  OR  https://impact.com/secure/MyApi.aspx?ProgramId=X&Md={your_md}&PartnerId=Y)
--   3. Find the placeholder line below for that tool, replace with real URL
--   4. Run: node --env-file=.env.local scripts/run-sql.mjs update-affiliate-urls.sql
--   5. Verify: node --env-file=.env.local scripts/verify-affiliate-urls.mjs
--   6. Update content/templates/affiliate-tracker.md with status = Live
--
-- Pattern: keep affiliate_url = website_url for tools NOT yet approved (default state)
--          set affiliate_url = '<real-affiliate-link>' for tools APPROVED + LIVE
--
-- Idempotent: re-running this file will overwrite affiliate_url with current values in the file.
-- To revert a tool to website_url default, find the row and uncomment the website_url line.

-- ============================================================================
-- WAVE 1: Writing / Content
-- ============================================================================

-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_JASPER_AFFILIATE_URL}' WHERE slug = 'jasper';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_COPY_AI_AFFILIATE_URL}' WHERE slug = 'copy-ai';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_SURFER_SEO_AFFILIATE_URL}' WHERE slug = 'surfer-seo';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_FRASE_AFFILIATE_URL}' WHERE slug = 'frase';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_WRITESONIC_AFFILIATE_URL}' WHERE slug = 'writesonic';

-- ============================================================================
-- WAVE 1: SEO / Marketing
-- ============================================================================

-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_SEMRUSH_AFFILIATE_URL}' WHERE slug = 'semrush';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_AHREFS_AFFILIATE_URL}' WHERE slug = 'ahrefs';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_HUBSPOT_AFFILIATE_URL}' WHERE slug = 'hubspot';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_ACTIVECAMPAIGN_AFFILIATE_URL}' WHERE slug = 'activecampaign';

-- ============================================================================
-- WAVE 1: Email / Newsletter
-- ============================================================================

-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_CONVERTKIT_AFFILIATE_URL}' WHERE slug = 'convertkit';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_BEEHIIV_AFFILIATE_URL}' WHERE slug = 'beehiiv';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_MAILERLITE_AFFILIATE_URL}' WHERE slug = 'mailerlite';

-- ============================================================================
-- WAVE 1: Automation / No-code
-- ============================================================================

-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_ZAPIER_AFFILIATE_URL}' WHERE slug = 'zapier';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_MAKE_COM_AFFILIATE_URL}' WHERE slug = 'make-com';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_WEBFLOW_AFFILIATE_URL}' WHERE slug = 'webflow';

-- ============================================================================
-- WAVE 1: Video / Audio
-- ============================================================================

-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_DESCRIPT_AFFILIATE_URL}' WHERE slug = 'descript';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_RIVERSIDE_AFFILIATE_URL}' WHERE slug = 'riverside-fm';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_ELEVENLABS_AFFILIATE_URL}' WHERE slug = 'elevenlabs';

-- ============================================================================
-- WAVE 1: Design / Productivity
-- ============================================================================

-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_FRAMER_AFFILIATE_URL}' WHERE slug = 'framer';
-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_NOTION_AFFILIATE_URL}' WHERE slug = 'notion';

-- ============================================================================
-- WAVE 2 placeholders (uncomment + add tools as Wave 1 returns approval data)
-- ============================================================================

-- UPDATE tools SET affiliate_url = '{REPLACE_WITH_REAL_TOOL_AFFILIATE_URL}' WHERE slug = '<slug>';

-- ============================================================================
-- Verification (uncomment to spot-check after running)
-- ============================================================================

-- SELECT slug, name, affiliate_url, website_url FROM tools
-- WHERE affiliate_url IS NOT NULL AND affiliate_url != website_url
-- ORDER BY slug;
