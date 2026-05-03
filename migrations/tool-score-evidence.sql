-- tool-score-evidence.sql
-- Add scores_evidence JSONB column. Default NULL.
-- UI gracefully renders 0-evidence rows as before.
-- Shape per row:
--   {
--     output_quality:  [{label, url, type}, ...],
--     ease_of_use:     [{label, url, type}, ...],
--     pricing_value:   [...],
--     feature_depth:   [...],
--     integrations:    [...],
--     reliability:     [...],
--     trajectory:      [...]
--   }
-- type enum: benchmark | third-party-review | user-count | uptime-data | official-docs | analyst-report | hands-on-test
-- url: absolute URL or 'internal:<id>' for non-public refs (rendered as muted non-link)

ALTER TABLE tools ADD COLUMN IF NOT EXISTS scores_evidence JSONB;

SELECT 'migration ok' AS status,
  COUNT(*) AS total_tools,
  COUNT(scores_evidence) AS tools_with_evidence
FROM tools;
