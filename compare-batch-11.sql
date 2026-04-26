-- compare-batch-11.sql: 5 new comparison pairs
-- Run in Supabase SQL Editor AFTER confirming all tool slugs exist

-- 1. substack-vs-beehiiv
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'substack-vs-beehiiv', 'substack', 'beehiiv', 'Substack and Beehiiv are the two leading newsletter platforms in 2026. Substack built the creator newsletter category and maintains the largest built-in audience network; Beehiiv was built by former Morning Brew engineers specifically for monetisation and growth. The choice comes down to whether you prioritise discoverability (Substack) or revenue tools and analytics (Beehiiv).', null, now()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'substack-vs-beehiiv');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('substack-vs-beehiiv', 'Built-in Audience Network', 5, 3, 'Substack has a large reader discovery network; Beehiiv relies on the Boosts marketplace for cross-promotion', 1),
  ('substack-vs-beehiiv', 'Monetisation Tools', 3, 5, 'Beehiiv offers paid subscriptions, ad network, and Boosts; Substack is limited to paid subscriptions', 2),
  ('substack-vs-beehiiv', 'Analytics Depth', 3, 5, 'Beehiiv provides detailed subscriber analytics and segmentation; Substack analytics are basic', 3),
  ('substack-vs-beehiiv', 'Email Deliverability', 4, 4, 'Both platforms maintain strong deliverability infrastructure', 4),
  ('substack-vs-beehiiv', 'Design Customisation', 3, 4, 'Beehiiv offers more template variety; Substack design is intentionally minimal', 5),
  ('substack-vs-beehiiv', 'Free Plan Limits', 4, 4, 'Both are free until monetisation - Substack takes 10% of revenue, Beehiiv charges a flat monthly fee', 6),
  ('substack-vs-beehiiv', 'Ease of Setup', 5, 4, 'Substack is the simplest newsletter setup available; Beehiiv requires more configuration', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'substack-vs-beehiiv')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'substack-vs-beehiiv');

-- 2. capcut-vs-veed-io
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'capcut-vs-veed-io', 'capcut', 'veed-io', 'CapCut and VEED.io are the leading browser-based and mobile video editors with strong AI feature sets. CapCut dominates short-form content creation with the best free tier and deepest TikTok integration. VEED.io targets professional teams with collaboration tools, stronger subtitle accuracy, and a cleaner interface for business content.', 'capcut', now()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'capcut-vs-veed-io');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('capcut-vs-veed-io', 'Free Plan Generosity', 5, 3, 'CapCut is free with no watermark; VEED.io free plan adds a watermark', 1),
  ('capcut-vs-veed-io', 'Auto-Captions Accuracy', 4, 5, 'VEED.io subtitle accuracy is marginally stronger across languages', 2),
  ('capcut-vs-veed-io', 'AI Features', 5, 4, 'CapCut has more AI effects, background removal, and auto-edit features', 3),
  ('capcut-vs-veed-io', 'Team Collaboration', 2, 5, 'VEED.io has proper team workspaces; CapCut is primarily solo use', 4),
  ('capcut-vs-veed-io', 'Template Library', 5, 4, 'CapCut has a larger and more current template ecosystem', 5),
  ('capcut-vs-veed-io', 'Export Quality', 4, 5, 'VEED.io offers higher resolution exports on paid plans', 6),
  ('capcut-vs-veed-io', 'Mobile App Quality', 5, 3, 'CapCut mobile app is best-in-class; VEED.io is primarily web-based', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'capcut-vs-veed-io')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'capcut-vs-veed-io');

-- 3. cursor-vs-windsurf
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'cursor-vs-windsurf', 'cursor', 'windsurf', 'Cursor and Windsurf are the two leading AI-native code editors in 2026 - both built on VS Code, both offering deep codebase understanding and agentic coding. Cursor is faster and more aggressive with AI edits; Windsurf''s Flow agent is more transparent and deliberate. The preference is genuinely personal based on working style.', null, now()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'cursor-vs-windsurf');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('cursor-vs-windsurf', 'Codebase Awareness', 5, 5, 'Both have deep multi-file codebase indexing and context', 1),
  ('cursor-vs-windsurf', 'Agentic Capability', 5, 5, 'Cursor Composer and Windsurf Flow are both multi-file agents; Flow shows more reasoning steps', 2),
  ('cursor-vs-windsurf', 'Response Speed', 5, 4, 'Cursor is marginally faster at generating completions', 3),
  ('cursor-vs-windsurf', 'Transparency of Changes', 3, 5, 'Windsurf explains its reasoning at each step; Cursor moves faster with less narration', 4),
  ('cursor-vs-windsurf', 'Free Plan Limits', 3, 4, 'Windsurf free plan is more generous than Cursor''s trial', 5),
  ('cursor-vs-windsurf', 'Pricing', 4, 5, 'Windsurf paid tier is priced below Cursor Pro', 6),
  ('cursor-vs-windsurf', 'Extension Compatibility', 5, 5, 'Both maintain full VS Code extension compatibility', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'cursor-vs-windsurf')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cursor-vs-windsurf');

-- 4. coda-vs-notion-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'coda-vs-notion-ai', 'coda', 'notion-ai', 'Coda and Notion AI are the leading AI-enhanced document and knowledge platforms. Notion has broader adoption and a stronger ecosystem; Coda has a more powerful formula engine and better native automation. For teams that want deep doc-as-app functionality, Coda wins on capability. For teams that want the most-used tool in the market, Notion AI wins on ecosystem.', 'notion-ai', now()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'coda-vs-notion-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('coda-vs-notion-ai', 'AI Writing Quality', 4, 5, 'Notion AI writing features are more polished and widely used', 1),
  ('coda-vs-notion-ai', 'Formula and Automation', 5, 3, 'Coda''s formula engine is significantly more powerful than Notion''s', 2),
  ('coda-vs-notion-ai', 'Database Flexibility', 5, 4, 'Coda offers more view types and cross-doc references', 3),
  ('coda-vs-notion-ai', 'Team Adoption', 3, 5, 'Notion has 10x the user base and a richer template ecosystem', 4),
  ('coda-vs-notion-ai', 'Integration Depth', 4, 5, 'Notion integrations are more numerous; Coda integrations are deeper for specific tools', 5),
  ('coda-vs-notion-ai', 'Pricing', 4, 4, 'Similar pricing tiers; Coda charges per doc-maker, Notion per workspace member', 6),
  ('coda-vs-notion-ai', 'Learning Curve', 3, 4, 'Notion is easier to get started with; Coda requires more investment to unlock its power', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'coda-vs-notion-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'coda-vs-notion-ai');

-- 5. supernormal-vs-fathom
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'supernormal-vs-fathom', 'supernormal', 'fathom', 'Supernormal and Fathom are the two strongest AI meeting note tools in 2026. Fathom is the simplest and most generous free plan - unlimited notes for individual users. Supernormal offers a stronger free tier for teams and more CRM integration options. Both produce high-quality summaries; the choice depends on whether you need solo simplicity or team features.', null, now()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'supernormal-vs-fathom');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('supernormal-vs-fathom', 'Free Plan for Individuals', 4, 5, 'Fathom is unlimited free for individual users; Supernormal limits meetings per month on free', 1),
  ('supernormal-vs-fathom', 'Team Features', 5, 3, 'Supernormal has team workspaces, shared meeting libraries, and collaboration; Fathom is individual-first', 2),
  ('supernormal-vs-fathom', 'Summary Quality', 5, 5, 'Both produce high-quality AI summaries with action items', 3),
  ('supernormal-vs-fathom', 'CRM Integrations', 5, 4, 'Supernormal integrates with HubSpot, Salesforce, and more CRMs natively', 4),
  ('supernormal-vs-fathom', 'Video Recording', 4, 5, 'Fathom''s meeting recording and highlight clipping is more polished', 5),
  ('supernormal-vs-fathom', 'Platform Support', 5, 4, 'Supernormal supports more meeting platforms including Google Meet, Teams, Zoom', 6),
  ('supernormal-vs-fathom', 'Setup Simplicity', 4, 5, 'Fathom is the simplest meeting tool to set up and use', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'supernormal-vs-fathom')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'supernormal-vs-fathom');
