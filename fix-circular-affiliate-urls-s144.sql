-- S144 fix: 38 tools have affiliate_url = https://go.mytheai.com/{slug}
-- which is circular (the /go/[slug] route reads affiliate_url and redirects
-- to that URL = points back to mytheai infra, breaking Visit CTA).
--
-- Discovered via verify-affiliate-urls.mjs first run (S143). Out-of-scope of
-- S143 commit; fixed here standalone.
--
-- Resolution: set affiliate_url = website_url for the 38 affected rows.
-- Effect: /go/[slug] reads website_url, appends UTM params, redirects to the
-- tool's real website. No affiliate revenue (no real affiliate program approved
-- yet for these 38 tools), but Visit CTA works as a clean tracked outbound link.
-- Once founder gets approved for any of these tools via affiliate program, the
-- update-affiliate-urls.sql workflow overrides website_url with real affiliate
-- URL.

UPDATE tools
SET affiliate_url = website_url
WHERE affiliate_url LIKE 'https://go.mytheai.com/%';

-- Verify post-update: should report 0 circular routes remaining
SELECT COUNT(*)::int AS remaining_circular
FROM tools
WHERE affiliate_url LIKE 'https://go.mytheai.com/%';

-- Spot-check 5 fixed rows
SELECT slug, affiliate_url, website_url
FROM tools
WHERE slug IN ('elai-io', 'munch', 'plane-so', 'capacity', 'vmaker')
ORDER BY slug;
