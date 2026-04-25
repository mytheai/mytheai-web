-- Session 17: Newsletter subscribers table
-- Run in Supabase SQL Editor before deploying newsletter form

CREATE TABLE IF NOT EXISTS newsletter_subscribers (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  email text UNIQUE NOT NULL,
  subscribed_at timestamptz DEFAULT now(),
  source text DEFAULT 'website'
);

ALTER TABLE newsletter_subscribers ENABLE ROW LEVEL SECURITY;

-- Allow anonymous inserts (form submissions)
CREATE POLICY "public_insert" ON newsletter_subscribers
  FOR INSERT WITH CHECK (true);

-- Block all reads from frontend (admin only via service key)
CREATE POLICY "no_public_select" ON newsletter_subscribers
  FOR SELECT USING (false);
