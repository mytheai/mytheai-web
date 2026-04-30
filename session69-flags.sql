-- session69-flags.sql
-- trending/featured flags for tools-batch-55 (AI Customer Service / Helpdesk)

-- Trending: AI customer service tools with strong adoption momentum in 2026
UPDATE tools SET trending = true  WHERE slug IN ('intercom-fin', 'decagon-ai');
UPDATE tools SET trending = false WHERE slug IN ('ada-ai', 'forethought-ai', 'moveworks', 'ultimate-ai', 'yellow-ai', 'glia', 'lang-io', 'espressive');

-- Featured: none from this batch - Editor's Picks unchanged
UPDATE tools SET featured = false WHERE slug IN (
  'intercom-fin', 'ada-ai', 'forethought-ai', 'moveworks', 'decagon-ai',
  'ultimate-ai', 'yellow-ai', 'glia', 'lang-io', 'espressive'
);

-- Verify
SELECT slug, name, trending, featured FROM tools
WHERE slug IN (
  'intercom-fin', 'ada-ai', 'forethought-ai', 'moveworks', 'decagon-ai',
  'ultimate-ai', 'yellow-ai', 'glia', 'lang-io', 'espressive'
)
ORDER BY slug;
