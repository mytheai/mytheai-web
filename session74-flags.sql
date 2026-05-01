-- session74-flags.sql
-- trending/featured flags for tools-batch-60 (AI Education / EdTech)

-- Trending: photomath (220M+ users, strongest brand recognition in AI math), khanmigo->swapped,
--           so using: photomath, coursera-coach (Coursera scale + AI push), gradescope-ai (university adoption momentum)
UPDATE tools SET trending = true  WHERE slug IN ('photomath', 'coursera-coach', 'gradescope-ai');
UPDATE tools SET trending = false WHERE slug IN ('socratic', 'quizlet-q-chat', 'mathgpt', 'eduaide-ai', 'kahoot-ai', 'nearpod-ai', 'edpuzzle-ai');

-- Featured: photomath (highest user volume, clearest consumer brand) + coursera-coach (enterprise L&D scale)
UPDATE tools SET featured = true  WHERE slug IN ('photomath', 'coursera-coach');
UPDATE tools SET featured = false WHERE slug IN (
  'socratic', 'quizlet-q-chat', 'mathgpt', 'eduaide-ai', 'gradescope-ai', 'kahoot-ai', 'nearpod-ai', 'edpuzzle-ai'
);

-- Verify
SELECT slug, name, trending, featured FROM tools WHERE slug IN (
  'coursera-coach', 'socratic', 'quizlet-q-chat', 'photomath', 'mathgpt',
  'eduaide-ai', 'gradescope-ai', 'kahoot-ai', 'nearpod-ai', 'edpuzzle-ai'
) ORDER BY slug;
