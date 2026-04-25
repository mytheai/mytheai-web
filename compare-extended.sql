-- compare-extended.sql
-- 3 new comparison pairs
-- Run in Supabase → SQL Editor (New query tab)
-- Uses ON CONFLICT DO NOTHING — safe to re-run if any slug already exists

-- ============================================================
-- 1. notion-vs-airtable
-- ============================================================

insert into comparisons (slug, tool_a_slug, tool_b_slug, summary, winner) values
('notion-vs-airtable', 'notion-ai', 'airtable',
 'Notion AI and Airtable both help teams organise information, but they solve different problems. Notion is a flexible all-in-one workspace — documents, wikis, project tracking, and AI writing in one place. Airtable is a structured database platform — ideal for teams managing inventory, CRM data, content calendars, or any workflow that needs relational data. Notion wins for teams that live in docs; Airtable wins for teams that need database logic.',
 null)
ON CONFLICT (slug) DO NOTHING;

insert into comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
select * from (values
  ('notion-vs-airtable', 'Ease of Use',          4, 3, 'Notion is more intuitive for new users; Airtable has a steeper database learning curve', 1),
  ('notion-vs-airtable', 'Document & Wiki',       5, 2, 'Notion is built around documents; Airtable has basic rich text but no wiki system', 2),
  ('notion-vs-airtable', 'Database & Structure',  3, 5, 'Airtable excels at relational data, linked records, and complex field types', 3),
  ('notion-vs-airtable', 'AI Features',           5, 3, 'Notion AI is deeply integrated for writing and summarising; Airtable AI is more limited', 4),
  ('notion-vs-airtable', 'Integrations',          4, 5, 'Airtable has superior API and automation integrations with external tools', 5),
  ('notion-vs-airtable', 'Free Tier',             4, 3, 'Notion free tier is generous for individuals; Airtable free is more restricted', 6),
  ('notion-vs-airtable', 'Pricing',               3, 3, 'Both start around $10–15/user/month — comparable at team scale', 7)
) as v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
where exists (select 1 from comparisons where slug = 'notion-vs-airtable')
  and not exists (select 1 from comparison_criteria where comparison_slug = 'notion-vs-airtable');

-- ============================================================
-- 2. figma-vs-framer
-- ============================================================

insert into comparisons (slug, tool_a_slug, tool_b_slug, summary, winner) values
('figma-vs-framer', 'figma', 'framer',
 'Figma and Framer are both design tools, but they serve different stages of the product lifecycle. Figma is the industry-standard for UI design and collaboration — where product teams design, prototype, and hand off to developers. Framer is a website builder with a designer-first approach — great for marketing sites and landing pages that need to go live without engineering involvement. Figma wins for product design teams; Framer wins for designers who want to ship without writing code.',
 null)
ON CONFLICT (slug) DO NOTHING;

insert into comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
select * from (values
  ('figma-vs-framer', 'UI Design Depth',       5, 3, 'Figma is the gold standard for UI/UX design with components, variants, and auto-layout', 1),
  ('figma-vs-framer', 'Collaboration',         5, 3, 'Figma multiplayer is best-in-class; Framer collaboration is more limited', 2),
  ('figma-vs-framer', 'Publishing to Web',     2, 5, 'Framer publishes live websites; Figma is design-only with no direct publish', 3),
  ('figma-vs-framer', 'AI Features',           3, 5, 'Framer AI generates pages and components from prompts; Figma AI is more limited', 4),
  ('figma-vs-framer', 'Developer Handoff',     5, 2, 'Figma Dev Mode is the industry standard; Framer targets designers not dev handoff', 5),
  ('figma-vs-framer', 'Free Tier',             4, 4, 'Both offer capable free tiers for individual projects', 6),
  ('figma-vs-framer', 'Pricing',               3, 4, 'Figma $15/editor/month; Framer $15/month flat — Framer better value for solo designers', 7)
) as v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
where exists (select 1 from comparisons where slug = 'figma-vs-framer')
  and not exists (select 1 from comparison_criteria where comparison_slug = 'figma-vs-framer');

-- ============================================================
-- 3. semrush-vs-ahrefs
-- ============================================================

insert into comparisons (slug, tool_a_slug, tool_b_slug, summary, winner) values
('semrush-vs-ahrefs', 'semrush', 'ahrefs',
 'SEMrush and Ahrefs are the two most comprehensive SEO platforms on the market. Both cover keyword research, backlink analysis, site auditing, and competitor intelligence — but with different strengths. SEMrush has a broader feature set including PPC research, social media tools, and content marketing. Ahrefs has a larger backlink index and is generally preferred by SEO specialists for link building and technical SEO. SEMrush wins for marketing teams needing an all-in-one suite; Ahrefs wins for dedicated SEO professionals.',
 null)
ON CONFLICT (slug) DO NOTHING;

insert into comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
select * from (values
  ('semrush-vs-ahrefs', 'Keyword Research',     5, 5, 'Both are best-in-class; SEMrush has larger keyword database, Ahrefs has better difficulty scores', 1),
  ('semrush-vs-ahrefs', 'Backlink Analysis',    4, 5, 'Ahrefs backlink index is widely considered the largest and most accurate', 2),
  ('semrush-vs-ahrefs', 'Site Audit',           5, 4, 'SEMrush site audit is more detailed with issue prioritisation', 3),
  ('semrush-vs-ahrefs', 'Content Tools',        5, 3, 'SEMrush has dedicated content marketing tools; Ahrefs content tools are more limited', 4),
  ('semrush-vs-ahrefs', 'PPC / Paid Search',    5, 2, 'SEMrush is the leader for PPC research and ad intelligence', 5),
  ('semrush-vs-ahrefs', 'UI & Ease of Use',     4, 4, 'Both have improved significantly; Ahrefs slightly cleaner for SEO-focused workflows', 6),
  ('semrush-vs-ahrefs', 'Pricing',              3, 3, 'Both start at ~$99-$129/month — expensive but comparable; SEMrush slightly higher entry price', 7)
) as v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
where exists (select 1 from comparisons where slug = 'semrush-vs-ahrefs')
  and not exists (select 1 from comparison_criteria where comparison_slug = 'semrush-vs-ahrefs');
