-- S133: Trust Evidence schema migration
-- Adds 4 columns to tools table for hand-tested editorial review evidence.
-- Idempotent (IF NOT EXISTS guards). Safe to re-run.

ALTER TABLE tools
  ADD COLUMN IF NOT EXISTS tested_by text,
  ADD COLUMN IF NOT EXISTS last_tested_at date,
  ADD COLUMN IF NOT EXISTS hands_on_notes text,
  ADD COLUMN IF NOT EXISTS avoid_if text;

COMMENT ON COLUMN tools.tested_by IS 'Name of editorial reviewer who hands-on tested this tool. Drives "Tested by" attribution on tool detail page.';
COMMENT ON COLUMN tools.last_tested_at IS 'Date of most recent hands-on test. Used for trust signal "Last tested" badge.';
COMMENT ON COLUMN tools.hands_on_notes IS 'Multi-paragraph editorial notes from real testing. Replaces generic LLM summary feel with first-person observations.';
COMMENT ON COLUMN tools.avoid_if IS 'Single-paragraph honest disclaimer of when this tool is the wrong choice. Builds trust by saying no.';
