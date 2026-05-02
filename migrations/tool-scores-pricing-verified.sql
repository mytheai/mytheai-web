-- tool-scores-pricing-verified.sql
-- Add scoring breakdown + pricing verification timestamp to tools table.
-- Auto-backfill scores from existing data; editorial team can refine over time.
--
-- Scoring uses methodology page weights (must match web/src/app/methodology/page.tsx):
--   output_quality 25%, ease_of_use 15%, pricing_value 15%, feature_depth 15%,
--   integrations 10%, reliability 10%, trajectory 10%

ALTER TABLE tools ADD COLUMN IF NOT EXISTS scores JSONB;
ALTER TABLE tools ADD COLUMN IF NOT EXISTS pricing_verified_at TIMESTAMPTZ;

-- Backfill pricing_verified_at = updated_at for existing rows
UPDATE tools SET pricing_verified_at = updated_at WHERE pricing_verified_at IS NULL;

-- Auto-derive baseline scores from rating, pricing, review_count, tags, flags.
-- Each criterion is integer 1-5. NULL scores get backfilled; populated scores untouched.
UPDATE tools SET scores = jsonb_build_object(
  'output_quality', CASE
    WHEN rating >= 4.7 THEN 5
    WHEN rating >= 4.4 THEN 4
    WHEN rating >= 4.0 THEN 4
    WHEN rating >= 3.5 THEN 3
    ELSE 2
  END,
  'ease_of_use', 4,
  'pricing_value', CASE
    WHEN pricing_type = 'free' THEN 5
    WHEN pricing_type = 'freemium' THEN 4
    WHEN pricing_free_tier THEN 4
    WHEN pricing_starting_price IS NULL OR pricing_starting_price = 0 THEN 3
    WHEN pricing_starting_price < 30 THEN 4
    WHEN pricing_starting_price < 100 THEN 3
    ELSE 2
  END,
  'feature_depth', CASE
    WHEN review_count >= 5000 THEN 5
    WHEN review_count >= 1500 THEN 4
    WHEN review_count >= 500 THEN 3
    ELSE 3
  END,
  'integrations', CASE
    WHEN COALESCE(array_length(tags, 1), 0) >= 4 THEN 5
    WHEN COALESCE(array_length(tags, 1), 0) >= 3 THEN 4
    ELSE 3
  END,
  'reliability', CASE
    WHEN review_count >= 5000 THEN 5
    WHEN review_count >= 1500 THEN 4
    ELSE 3
  END,
  'trajectory', CASE
    WHEN trending THEN 5
    WHEN featured THEN 4
    WHEN editor_pick THEN 5
    ELSE 3
  END
) WHERE scores IS NULL;

SELECT slug, name, scores, pricing_verified_at FROM tools WHERE slug IN ('cursor','claude','notebooklm') ORDER BY slug;
