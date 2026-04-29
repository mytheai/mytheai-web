-- compare-batch-52.sql
-- 5 social media tool comparison pairs
-- All tool slugs confirmed from tools-batch-52.sql
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. taplio-vs-supergrow (LinkedIn tools)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'taplio-vs-supergrow',
  'taplio',
  'supergrow',
  'Taplio and Supergrow are the two leading AI tools for LinkedIn content creation and personal brand growth. Taplio is the more established platform with stronger writing personalisation, a built-in CRM for tracking warm LinkedIn leads, and richer analytics. Supergrow offers a functional free plan that makes it accessible for founders and creators who want to test LinkedIn AI tools before committing to a paid subscription. Both generate LinkedIn posts, carousels, and threads from prompts or URLs, but Taplio''s AI adapts more convincingly to personal writing voice over time. Supergrow wins on accessibility and price; Taplio wins on output quality and relationship tracking depth.',
  'taplio',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'taplio-vs-supergrow');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'taplio-vs-supergrow', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Writing Quality',        4, 3, 'Taplio adapts to personal voice more convincingly over time'),
  ('Carousel Builder',          4, 3, 'Both build carousels; Taplio has more formatting options'),
  ('Free Plan Availability',    1, 4, 'Taplio has no free plan; Supergrow has a functional free tier'),
  ('LinkedIn CRM Features',     4, 2, 'Taplio tracks warm leads from LinkedIn activity; Supergrow does not'),
  ('Analytics Depth',           4, 3, 'Taplio provides more granular post and profile analytics'),
  ('Content Ideas Engine',      4, 4, 'Both surface trending topics and high-performing content'),
  ('Value at Entry Price',      2, 4, 'Supergrow at $19/mo vs Taplio at $39/mo favours Supergrow')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'taplio-vs-supergrow')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'taplio-vs-supergrow');

-- 2. predis-ai-vs-contentstudio (content generation vs full-stack management)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'predis-ai-vs-contentstudio',
  'predis-ai',
  'contentstudio',
  'Predis.ai and ContentStudio approach social media from different directions. Predis.ai specialises in visual content generation - turning a topic or product description into a complete post with image, caption, and hashtags in seconds. ContentStudio is a full-stack social media management platform covering content discovery, AI writing, scheduling, analytics, and team workflows for multiple platforms. Teams that need high-volume visual content creation will find Predis.ai more productive; teams that need a single platform for the complete social media workflow will find ContentStudio more comprehensive. The tools are often complementary rather than direct alternatives.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'predis-ai-vs-contentstudio');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'predis-ai-vs-contentstudio', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Visual Content Generation',  5, 3, 'Predis.ai is purpose-built for image and video post creation'),
  ('Scheduling and Publishing',  2, 5, 'ContentStudio has a mature multi-platform scheduler; Predis is basic'),
  ('Content Discovery',          2, 4, 'ContentStudio surfaces trending articles for curation; Predis does not'),
  ('Analytics and Reporting',    2, 4, 'ContentStudio has deeper analytics across platforms and content types'),
  ('Team and Agency Features',   2, 4, 'ContentStudio has client dashboards and approval workflows'),
  ('AI Caption Quality',         4, 4, 'Both generate solid captions; Predis is more visually integrated'),
  ('Platform Coverage',          4, 4, 'Both support Instagram, LinkedIn, Facebook, TikTok, Twitter/X')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'predis-ai-vs-contentstudio')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'predis-ai-vs-contentstudio');

-- 3. publer-vs-vista-social (schedulers for agencies and small teams)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'publer-vs-vista-social',
  'publer',
  'vista-social',
  'Publer and Vista Social are both social media schedulers positioned for agencies and growing teams, but at different price points. Publer is the more budget-friendly option with a functional free plan and paid plans starting at $12/month, making it accessible for small agencies and freelancers. Vista Social starts at $39/month but offers stronger analytics, a better mobile app, review management across platforms, and AI features that are more integrated into the posting workflow. For cost-conscious small teams, Publer is the better value. For agencies that prioritise analytics depth and review management alongside scheduling, Vista Social justifies the higher price.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'publer-vs-vista-social');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'publer-vs-vista-social', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Pricing and Free Plan',     5, 3, 'Publer has free plan and lower paid tiers; Vista Social starts at $39/mo'),
  ('Analytics Depth',           3, 5, 'Vista Social has more detailed engagement and audience analytics'),
  ('Review Management',         1, 4, 'Vista Social manages reviews across Google, Facebook, Yelp; Publer does not'),
  ('AI Content Features',       3, 4, 'Vista Social AI assistant is more integrated into the posting workflow'),
  ('Mobile App Quality',        3, 4, 'Vista Social mobile app is rated higher for content management on-the-go'),
  ('Post Recycling',            4, 3, 'Publer has strong evergreen content recycling; Vista Social is more limited'),
  ('Platform Coverage',         4, 4, 'Both cover Instagram, Facebook, LinkedIn, TikTok, Twitter/X, Pinterest')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'publer-vs-vista-social')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'publer-vs-vista-social');

-- 4. flick-social-vs-pallyy (Instagram-focused agency tools)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'flick-social-vs-pallyy',
  'flick-social',
  'pallyy',
  'Flick and Pallyy both serve Instagram-focused creators and agencies, but with different primary strengths. Flick built its reputation on hashtag research and analytics - it provides the deepest insights into hashtag reach, competition, and performance of any tool in this category. Pallyy is stronger on the scheduling and agency management side, with a visual grid planner, link-in-bio tool, and client management features that make it particularly useful for visual-first brands and social media managers running multiple Instagram accounts. Teams that prioritise Instagram hashtag strategy will prefer Flick; agencies that need a complete Instagram management workflow for multiple clients will prefer Pallyy.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'flick-social-vs-pallyy');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'flick-social-vs-pallyy', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Hashtag Research Depth',    5, 2, 'Flick is the clear leader in Instagram hashtag analytics and strategy'),
  ('Visual Grid Planner',       2, 5, 'Pallyy''s visual planner previews how posts will look in the Instagram grid'),
  ('Link-in-Bio Tool',          1, 5, 'Pallyy has a built-in link-in-bio page; Flick does not'),
  ('AI Content Writing',        4, 3, 'Flick AI generates persona-based captions; Pallyy is more basic'),
  ('Agency Client Management',  2, 4, 'Pallyy has cleaner multi-client workspace and reporting tools'),
  ('Analytics and Reporting',   4, 4, 'Both provide solid post analytics; Flick stronger on hashtag-level data'),
  ('Pricing Accessibility',     4, 4, 'Both have free plans; Flick from $14/mo, Pallyy from $18/mo')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'flick-social-vs-pallyy')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'flick-social-vs-pallyy');

-- 5. hypefury-vs-postwise (Twitter/X growth tools)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'hypefury-vs-postwise',
  'hypefury',
  'postwise',
  'Hypefury and Postwise are the two main AI tools focused specifically on Twitter/X audience growth, but they approach it from different angles. Hypefury is stronger on automation features: auto-retweet when posts reach engagement thresholds, auto-plug replies to high-performing tweets, thread scheduling, and a curated inspiration feed. Postwise focuses more on AI writing quality and viral potential prediction - its AI generates higher-quality thread content from prompts, scores drafts on viral potential before publishing, and includes a Growth Retweet network for cross-promotion. For creators who want automation and hands-off growth features, Hypefury is the better choice. For those who prioritise content quality and thread writing assistance, Postwise delivers stronger output.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hypefury-vs-postwise');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'hypefury-vs-postwise', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Writing Quality',        3, 5, 'Postwise generates more polished thread content from prompts'),
  ('Automation Features',       5, 3, 'Hypefury leads with auto-retweet, auto-plug, and smart scheduling'),
  ('Viral Score Predictor',     2, 4, 'Postwise scores drafts on viral potential; Hypefury does not'),
  ('Growth Network',            2, 4, 'Postwise Growth Retweet network exposes content to larger accounts'),
  ('Free Plan Availability',    4, 1, 'Hypefury has a free plan; Postwise does not'),
  ('Inspiration Feed',          4, 2, 'Hypefury surfaces high-performing tweets for inspiration; Postwise is limited'),
  ('Instagram Cross-Posting',   4, 1, 'Hypefury allows auto-posting to Instagram; Postwise is Twitter/X only')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hypefury-vs-postwise')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'hypefury-vs-postwise');
