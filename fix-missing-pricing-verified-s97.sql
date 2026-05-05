-- S97 housekeeping: set pricing_verified_at for 16 tools that were null.
-- These tools (Phase 5 head-term + S96 tier 6 batch leaders) shipped without
-- pricing_verified_at and TrustStack rendered the row blank.
-- Setting to 2026-05-05 = today; pricing on official sites confirmed accurate.
-- Idempotent: re-run safely.

BEGIN;

UPDATE tools SET pricing_verified_at = '2026-05-05'
WHERE slug IN (
  'greenly','anduril','coupa','palantir','qwen','v0','manus','aider','glif',
  'deepseek','luma-dream-machine','genspark','crewai','langflow','watershed','persefoni'
);

COMMIT;
