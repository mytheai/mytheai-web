-- Final audit pass 2026-05-04 - manual verification of script output.
-- Only 2 confirmed-dead tools after re-probing with real User-Agent + body inspection.
-- Most "DEAD" / "ZOMBIE" candidates from final-audit.mjs were FALSE POSITIVES:
--   - parking-page regex matched "expired" in legitimate body content (framer, d-id, augury, etc.)
--   - HTTP 403/429 from Cloudflare WAF on VN network ≠ dead (gusto, helsing, uptake)
--   - 301 redirects ≠ dead (bloomfire, document360, securiti, planable, hypefury, userpilot)
--
-- Confirmed dead via direct body inspection:
--   chorus -> chorus.ai serves a 1-second redirect stub to zoominfo.com/products/chorus.
--             Product absorbed by ZoomInfo - standalone "Chorus" no longer exists.
--   pyn    -> pyn.com returns "WordPress > Error" page. Pyn was acquired by Sana in 2024,
--             customer-facing domain abandoned.

BEGIN;

DELETE FROM comparisons WHERE tool_a_slug IN ('chorus', 'pyn') OR tool_b_slug IN ('chorus', 'pyn');
DELETE FROM tool_clicks WHERE tool_slug IN ('chorus', 'pyn');
DELETE FROM tools WHERE slug IN ('chorus', 'pyn');

COMMIT;

-- Run after: node scripts/clean-top10.mjs
