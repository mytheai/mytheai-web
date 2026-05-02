-- fix-editor-picks-claude.sql (S80e)
-- Swap Editor's Picks: Lovable -> Claude
-- Reason: Editor's Picks is the homepage first impression for mass-market visitors.
-- Cursor + NotebookLM cover dev + research; Claude adds broader non-technical daily-use appeal.
-- Lovable still strong in app-builder vertical but more dev-leaning than Cursor already is.

UPDATE tools SET editor_pick = FALSE WHERE slug = 'lovable';
UPDATE tools SET editor_pick = TRUE WHERE slug = 'claude';

SELECT slug, name, editor_pick, rating, review_count
FROM tools
WHERE editor_pick = TRUE
ORDER BY slug;
