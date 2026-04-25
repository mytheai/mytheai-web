-- Submit a tool — DB setup
-- Run in Supabase → SQL Editor

create table if not exists tool_submissions (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  website_url text not null,
  category text,
  pricing_type text,
  free_tier boolean default false,
  submitter_email text,
  created_at timestamptz default now()
);

alter table tool_submissions enable row level security;

-- Allow anonymous inserts (no auth required)
create policy "insert_only" on tool_submissions for insert with check (true);
