-- Compare pages setup
-- Run in Supabase → SQL Editor

-- 1. Create tables
create table if not exists comparisons (
  id uuid default gen_random_uuid() primary key,
  slug text unique not null,
  tool_a_slug text not null references tools(slug) on delete cascade,
  tool_b_slug text not null references tools(slug) on delete cascade,
  summary text,
  winner text,
  updated_at timestamptz default now()
);

create table if not exists comparison_criteria (
  id uuid default gen_random_uuid() primary key,
  comparison_slug text not null references comparisons(slug) on delete cascade,
  name text not null,
  tool_a_score int check (tool_a_score between 1 and 5),
  tool_b_score int check (tool_b_score between 1 and 5),
  notes text,
  sort_order int default 0
);

-- 2. Enable RLS
alter table comparisons enable row level security;
create policy "public_read" on comparisons for select using (true);
alter table comparison_criteria enable row level security;
create policy "public_read" on comparison_criteria for select using (true);

-- 3. Seed 5 comparisons

insert into comparisons (slug, tool_a_slug, tool_b_slug, summary, winner) values

('claude-vs-chatgpt', 'claude', 'chatgpt',
 'Claude and ChatGPT are the two most capable AI assistants in 2025. Claude excels at nuanced reasoning, long documents, and following complex instructions, while ChatGPT leads in plugin integrations, image generation (via DALL-E), and a broader ecosystem. For pure conversation and analysis, Claude edges ahead — but ChatGPT wins on versatility.',
 null),

('cursor-vs-github-copilot', 'cursor', 'github-copilot',
 'Cursor and GitHub Copilot are both AI code editors, but they take different approaches. Cursor is a standalone editor (VS Code fork) with full codebase context and a Composer for multi-file edits. GitHub Copilot lives inside your existing IDE as a plugin with strong inline completions. Cursor is faster to iterate in; Copilot requires less workflow change.',
 'cursor'),

('canva-ai-vs-adobe-firefly', 'canva-ai', 'adobe-firefly',
 'Canva AI and Adobe Firefly both offer AI-powered image generation, but target different users. Canva is a complete design platform — its AI is one tool among many. Adobe Firefly is trained exclusively on licensed content, making it the safe choice for commercial work. Canva wins for accessibility and non-designers; Firefly wins for IP safety and Creative Cloud users.',
 null),

('zapier-vs-make', 'zapier', 'make',
 'Zapier and Make (formerly Integromat) are the two leading no-code automation platforms. Zapier is simpler — great for straightforward app-to-app automations. Make is more powerful with visual workflow logic, data transformation, and better value at scale. Zapier wins for speed and simplicity; Make wins for complex workflows and cost efficiency.',
 null),

('jasper-vs-copy-ai', 'jasper', 'copy-ai',
 'Jasper and Copy.ai both use AI to generate marketing copy, but diverge in focus and price. Jasper is enterprise-grade with brand voice training and campaign management — at $49/mo minimum. Copy.ai has a generous free tier and is lighter-weight, ideal for individuals and small teams. Jasper wins for large marketing teams; Copy.ai wins for budget-conscious creators.',
 null);

-- 4. Seed criteria for each comparison

insert into comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order) values
-- claude-vs-chatgpt
('claude-vs-chatgpt', 'Reasoning Quality',     5, 5, 'Both best-in-class; Claude slightly stronger on complex multi-step tasks', 1),
('claude-vs-chatgpt', 'Context Window',         5, 4, 'Claude supports 200K tokens; ChatGPT-4o supports 128K', 2),
('claude-vs-chatgpt', 'Image Generation',       2, 5, 'ChatGPT has DALL-E 3 built in; Claude has no image generation', 3),
('claude-vs-chatgpt', 'Plugin Ecosystem',       2, 5, 'ChatGPT has 1000+ plugins; Claude has limited integrations', 4),
('claude-vs-chatgpt', 'Instruction Following',  5, 4, 'Claude is notably better at following detailed, nuanced prompts', 5),
('claude-vs-chatgpt', 'Free Tier',              4, 4, 'Both offer capable free tiers with usage limits', 6),
('claude-vs-chatgpt', 'Pricing',                4, 3, 'Both $20/mo Pro; Claude Pro often better value for heavy users', 7),

-- cursor-vs-github-copilot
('cursor-vs-github-copilot', 'Codebase Context',     5, 3, 'Cursor indexes entire repo; Copilot uses open files and recent context', 1),
('cursor-vs-github-copilot', 'Inline Completions',   4, 5, 'Copilot inline suggestions are faster and more accurate for short completions', 2),
('cursor-vs-github-copilot', 'Multi-file Edits',     5, 2, 'Cursor Composer edits across files; Copilot works file by file', 3),
('cursor-vs-github-copilot', 'IDE Flexibility',      2, 5, 'Copilot works in any IDE; Cursor is a standalone app', 4),
('cursor-vs-github-copilot', 'Chat Interface',       5, 4, 'Both have chat; Cursor chat has deeper codebase awareness', 5),
('cursor-vs-github-copilot', 'Pricing',              3, 4, 'Copilot $10/mo; Cursor $20/mo — Copilot better value for basic use', 6),
('cursor-vs-github-copilot', 'Privacy / Enterprise', 3, 5, 'Copilot Enterprise has stronger org controls and IP indemnity', 7),

-- canva-ai-vs-adobe-firefly
('canva-ai-vs-adobe-firefly', 'Image Quality',        4, 5, 'Firefly produces more photorealistic results; Canva better for design assets', 1),
('canva-ai-vs-adobe-firefly', 'Commercial Safety',    3, 5, 'Firefly trained on licensed content only — zero IP risk', 2),
('canva-ai-vs-adobe-firefly', 'Ease of Use',          5, 3, 'Canva is beginner-friendly; Firefly requires Creative Cloud familiarity', 3),
('canva-ai-vs-adobe-firefly', 'Design Templates',     5, 2, 'Canva has 1M+ templates; Firefly is generation-only', 4),
('canva-ai-vs-adobe-firefly', 'Free Tier',            5, 3, 'Canva free tier is very generous; Firefly free credits limited', 5),
('canva-ai-vs-adobe-firefly', 'Integration Depth',    3, 5, 'Firefly deeply integrated in Photoshop and Illustrator', 6),
('canva-ai-vs-adobe-firefly', 'Pricing',              4, 3, 'Canva Pro $15/mo; Firefly requires CC subscription ($55+/mo)', 7),

-- zapier-vs-make
('zapier-vs-make', 'Ease of Setup',       5, 3, 'Zapier''s UI is simpler for beginners; Make has steeper learning curve', 1),
('zapier-vs-make', 'App Integrations',    5, 4, 'Zapier supports 6,000+ apps; Make supports ~1,500', 2),
('zapier-vs-make', 'Complex Logic',       3, 5, 'Make handles iterators, routers, and aggregators natively', 3),
('zapier-vs-make', 'Pricing at Scale',    2, 5, 'Make is significantly cheaper per operation at volume', 4),
('zapier-vs-make', 'Reliability',         5, 4, 'Zapier has stronger uptime track record', 5),
('zapier-vs-make', 'Free Tier',           3, 4, 'Make free tier allows 1,000 ops/mo; Zapier free is 100 tasks/mo', 6),
('zapier-vs-make', 'Data Transformation', 3, 5, 'Make excels at data parsing and transformation; Zapier is basic', 7),

-- jasper-vs-copy-ai
('jasper-vs-copy-ai', 'Output Quality',      5, 4, 'Jasper with brand voice training produces more on-brand content', 1),
('jasper-vs-copy-ai', 'Template Variety',    4, 5, 'Copy.ai has wider range of short-form templates', 2),
('jasper-vs-copy-ai', 'Brand Voice',         5, 2, 'Jasper''s brand voice feature is a major differentiator', 3),
('jasper-vs-copy-ai', 'Free Tier',           1, 4, 'Copy.ai has generous free tier; Jasper is paid-only', 4),
('jasper-vs-copy-ai', 'Pricing',             2, 4, 'Jasper starts at $49/mo; Copy.ai at $49/mo but free tier available', 5),
('jasper-vs-copy-ai', 'Team Collaboration',  5, 3, 'Jasper built for teams; Copy.ai more individual-focused', 6),
('jasper-vs-copy-ai', 'Long-form Content',   5, 3, 'Jasper handles long-form articles better with document mode', 7);
