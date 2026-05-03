-- add-created-at.sql
-- Add created_at column to tools table for "Recently Added" UX.
-- Backfill all existing rows with their updated_at value (best approximation).
-- New INSERTs default to NOW().

ALTER TABLE tools ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ NOT NULL DEFAULT NOW();

-- Backfill existing rows: use updated_at as a proxy (we did not track creation).
-- For tools where updated_at is NULL or stale, fallback to NOW() via the column default.
UPDATE tools SET created_at = updated_at WHERE updated_at IS NOT NULL AND created_at >= NOW() - INTERVAL '5 minutes';

-- Verify
SELECT COUNT(*) AS total, MIN(created_at) AS earliest, MAX(created_at) AS latest FROM tools;
