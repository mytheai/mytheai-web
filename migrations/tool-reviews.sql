-- tool_reviews: user-submitted micro-reviews on tool detail pages
-- No-account: anyone can submit. Rate-limited by IP hash. Default status pending for moderation.
-- Public reads: only status='approved'.

CREATE TABLE IF NOT EXISTS tool_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tool_slug TEXT NOT NULL REFERENCES tools(slug) ON DELETE CASCADE,
  rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
  best_for TEXT NOT NULL CHECK (length(best_for) BETWEEN 5 AND 280),
  limitation TEXT NOT NULL CHECK (length(limitation) BETWEEN 5 AND 280),
  author_name TEXT,
  author_role TEXT,
  ip_hash TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_tool_reviews_slug_status ON tool_reviews(tool_slug, status);
CREATE INDEX IF NOT EXISTS idx_tool_reviews_ip_slug ON tool_reviews(ip_hash, tool_slug);

ALTER TABLE tool_reviews ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "tool_reviews_public_read_approved" ON tool_reviews;
CREATE POLICY "tool_reviews_public_read_approved"
  ON tool_reviews FOR SELECT
  USING (status = 'approved');

-- Allow public INSERT only if status='pending'. Approval happens via Supabase dashboard manual review.
DROP POLICY IF EXISTS "tool_reviews_public_insert_pending" ON tool_reviews;
CREATE POLICY "tool_reviews_public_insert_pending"
  ON tool_reviews FOR INSERT
  WITH CHECK (status = 'pending');

SELECT 'migration ok' AS status, COUNT(*) AS existing_reviews FROM tool_reviews;
