-- S162 final pre-freeze polish
-- Fix 1: Maze logo override (Google s2/favicons returned generic Google fallback
--        because maze.co serves favicon via datocms-assets CDN, not /favicon.ico).
--        Using the datocms-assets URL extracted from maze.co head tags.
-- Fix 2: Spiff is dead. spiff.com redirects after Salesforce acquired the SaaS,
--        spiff.io is now "Spifftastic" (Noel Cower personal blog, not the product).
--        DELETE the row, remove from any task picked_slugs.
-- Date: 2026-05-10

UPDATE tools
   SET logo_url = 'https://www.datocms-assets.com/38511/1762960626-image.png?w=128&h=128'
 WHERE slug = 'maze';

UPDATE tasks
   SET picked_slugs = array_remove(picked_slugs, 'spiff')
 WHERE slug = 'ai-for-sales-compensation';

DELETE FROM tools WHERE slug = 'spiff';
