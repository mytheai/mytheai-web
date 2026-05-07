-- Phase 0 of Task Taxonomy initiative (S112)
-- Creates tasks table per plan §2 (web/content/plans/task-taxonomy.md)
-- Idempotent: safe to re-run.

CREATE TABLE IF NOT EXISTS tasks (
  slug                  text PRIMARY KEY,
  title                 text NOT NULL,
  h1_override           text,
  emoji                 text DEFAULT '🎯',
  primary_tags          text[] NOT NULL,
  picked_slugs          text[] DEFAULT '{}',
  fallback_min          int DEFAULT 3,
  intro                 text NOT NULL,
  methodology           text,
  faqs                  jsonb DEFAULT '[]'::jsonb,
  category              text,
  difficulty            text DEFAULT 'beginner',
  monthly_search_volume int,
  related_top10_slugs   text[] DEFAULT '{}',
  related_use_case_slug text,
  related_blog_slugs    text[] DEFAULT '{}',
  status                text DEFAULT 'draft',
  created_at            timestamptz DEFAULT now(),
  updated_at            timestamptz DEFAULT now(),
  CONSTRAINT tasks_status_check CHECK (status IN ('draft', 'published', 'retired')),
  CONSTRAINT tasks_difficulty_check CHECK (difficulty IN ('beginner', 'intermediate', 'advanced'))
);

CREATE INDEX IF NOT EXISTS idx_tasks_status_published
  ON tasks (status) WHERE status = 'published';

CREATE INDEX IF NOT EXISTS idx_tasks_category_published
  ON tasks (category) WHERE status = 'published';

CREATE INDEX IF NOT EXISTS idx_tasks_msv_published
  ON tasks (monthly_search_volume DESC NULLS LAST) WHERE status = 'published';

-- updated_at auto-bump trigger
CREATE OR REPLACE FUNCTION tasks_set_updated_at() RETURNS trigger AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_tasks_updated_at ON tasks;
CREATE TRIGGER trg_tasks_updated_at
  BEFORE UPDATE ON tasks
  FOR EACH ROW EXECUTE FUNCTION tasks_set_updated_at();

-- Confirmation row
SELECT
  'tasks' AS table_created,
  count(*) AS existing_rows
FROM tasks;
