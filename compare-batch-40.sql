-- compare-batch-40.sql
-- 5 AI writing tool comparison pairs for tools-batch-40 (specialized writing tools)
-- DEPENDENCY: tools-batch-40.sql must be run first
-- All pairs verified absent from compare-batch-1 through compare-batch-39
-- NOTE: sudowrite-vs-jasper exists in compare-batch-13; wordtune-vs-grammarly exists in compare-batch-7 - both skipped

-- 1. hypotenuse-ai vs copy-ai: e-commerce copy specialist vs general content automation
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'hypotenuse-ai-vs-copy-ai', 'hypotenuse-ai', 'copy-ai',
  'Hypotenuse AI and Copy.ai both generate marketing copy at scale, but from opposite directions. Hypotenuse AI is built around the product catalog: connect a CSV or Shopify store, and it generates hundreds of product descriptions with consistent style and SEO optimization without manual prompting. Copy.ai is built around the campaign workflow: its Workflow builder chains research, drafting, and multi-format repurposing into automated pipelines that turn a brief into a blog post, social captions, email variants, and meta description simultaneously. Choose Hypotenuse AI when the bottleneck is catalog-scale product content. Choose Copy.ai when the bottleneck is campaign-level content across multiple formats.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hypotenuse-ai-vs-copy-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'hypotenuse-ai-vs-copy-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Product Catalog Scale', 5, 2, 'Hypotenuse AI is purpose-built for catalog-level generation from CSV or Shopify - generating hundreds of product descriptions from structured data without manual prompting for each item. Copy.ai is not designed for catalog ingestion.'),
  ('Campaign Workflow Automation', 2, 5, 'Copy.ai Workflow builder chains multiple tasks into automated pipelines from a single brief. Hypotenuse AI is focused on product content, not cross-format campaign automation.'),
  ('E-commerce SEO Optimization', 5, 3, 'Hypotenuse AI includes keyword targeting and SERP optimization specifically for product and category pages. Copy.ai SEO features are more general.'),
  ('Content Format Breadth', 2, 5, 'Copy.ai covers blog posts, email sequences, ads, social captions, and sales pages in one platform. Hypotenuse AI focuses primarily on product and e-commerce content formats.'),
  ('Style Consistency at Scale', 5, 3, 'Hypotenuse AI style training learns from existing product descriptions and applies length and tone rules consistently across hundreds of items. Copy.ai brand voice features are strong but less optimized for catalog-level consistency.'),
  ('Ease of Use', 4, 4, 'Both are accessible to non-technical marketers. Hypotenuse AI is simpler for catalog workflows; Copy.ai has more setup for Workflow automation.'),
  ('Pricing', 4, 3, 'Hypotenuse AI starts at $24 per month. Copy.ai has a limited free plan and paid plans from $36 per month.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'hypotenuse-ai-vs-copy-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'hypotenuse-ai-vs-copy-ai');

-- 2. narrato vs jasper: content ops platform vs AI writer with brand voice
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'narrato-vs-jasper', 'narrato', 'jasper',
  'Narrato and Jasper both help teams produce more content faster, but they solve different bottlenecks. Jasper is an AI writer - it generates content from a brief with brand voice consistency, making it the right tool when the bottleneck is drafting speed. Narrato is a content operations platform - it manages the full workflow from brief creation and writer assignment through review, client approval, and publishing, with AI integrated at each stage. Choose Jasper when you need faster content generation. Choose Narrato when you need to manage the process of producing content across a team or multiple clients.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'narrato-vs-jasper');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'narrato-vs-jasper', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Content Workflow Management', 5, 1, 'Narrato has project boards, task assignment, deadline tracking, approval stages, and client portals. Jasper has no workflow management features - it is a writing tool only.'),
  ('AI Content Generation Quality', 3, 5, 'Jasper is the category benchmark for AI-generated marketing content quality, especially with brand voice training. Narrato AI generation is solid but secondary to its workflow capabilities.'),
  ('Client Collaboration', 5, 1, 'Narrato has dedicated client portals for review and approval without requiring client accounts. Jasper has no client collaboration features.'),
  ('Brand Voice Consistency', 3, 5, 'Jasper Brand Voice trains on company content samples and maintains consistency across all AI-generated output. Narrato has brand guidelines support but less sophisticated voice training.'),
  ('Multi-user Team Features', 5, 3, 'Narrato is built for team content production with role-based access, writer pools, and editor assignment. Jasper has team features but they are secondary to the writing experience.'),
  ('SEO Brief Generation', 4, 3, 'Narrato generates SEO content briefs from keyword analysis including competitor coverage and recommended outline structure. Jasper has SEO mode but Narrato briefs are more structured for writer handoff.'),
  ('Pricing', 3, 3, 'Narrato Pro starts at $36 per month per user. Jasper Creator starts at $49 per month. Both have team plans at higher price points.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'narrato-vs-jasper')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'narrato-vs-jasper');

-- 3. longshot-ai vs contentatscale: fact-verified long-form vs bulk AI content pipeline
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'longshot-ai-vs-contentatscale', 'longshot-ai', 'contentatscale',
  'Longshot AI and Content at Scale both produce long-form content at volume, but they make different trade-offs. Longshot AI prioritizes factual accuracy: its fact-check engine cross-references claims against live sources and flags potentially inaccurate statements, making it the right choice for health, finance, and legal content where errors have consequences. Content at Scale prioritizes volume and AI detection avoidance: it produces 2,500-word articles optimized to pass AI content detectors, making it the right choice for high-volume SEO content programs where output rate is the primary constraint.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'longshot-ai-vs-contentatscale');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'longshot-ai-vs-contentatscale', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Factual Accuracy', 5, 2, 'Longshot AI fact-checks generated content against live web sources and flags claims with low confidence scores. Content at Scale does not include fact verification - accuracy depends on training data.'),
  ('Content Volume Output', 3, 5, 'Content at Scale is designed for bulk production with one-click article generation from a keyword. Longshot AI is slower due to research and fact-checking steps.'),
  ('AI Detection Resistance', 2, 5, 'Content at Scale specifically trains output to pass AI content detectors like Originality.ai and GPTZero. Longshot AI does not prioritize AI detection avoidance.'),
  ('SEO Optimization', 4, 4, 'Both include SERP analysis and keyword optimization. Longshot AI integrates with Semrush; Content at Scale has built-in keyword research.'),
  ('Research Integration', 5, 2, 'Longshot AI aggregates information from multiple sources before writing, with source attribution in the final output. Content at Scale generates primarily from its own model without live research.'),
  ('Use Case Fit', 5, 3, 'Longshot AI is the right choice for regulated or trust-sensitive verticals. Content at Scale is the right choice for high-volume SEO content at scale where speed matters more than source citation.'),
  ('Pricing', 4, 3, 'Longshot AI Freemium plan is available; paid plans from $19 per month. Content at Scale starts at $250 per month for 8 articles, which is expensive relative to output for small teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'longshot-ai-vs-contentatscale')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'longshot-ai-vs-contentatscale');

-- 4. simplified vs cohesive-ai: all-in-one marketing AI head-to-head
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'simplified-vs-cohesive-ai', 'simplified', 'cohesive-ai',
  'Simplified and Cohesive AI are both all-in-one AI content platforms targeting marketing teams and content creators, but with different scope. Simplified goes further beyond writing: it includes graphic design with 10,000 templates, video editing, and social media scheduling alongside the AI writer - making it a genuine multi-format content production platform. Cohesive AI focuses on the writing layer with 200 templates, a real-time AI editor, and team collaboration features, but does not include design or video. Choose Simplified if you need writing plus design and scheduling in one tool. Choose Cohesive AI if writing quality and template breadth are the priority and you have separate tools for design.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'simplified-vs-cohesive-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'simplified-vs-cohesive-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Format Breadth', 5, 3, 'Simplified covers writing, graphic design, video editing, and scheduling in one platform. Cohesive AI covers writing and collaboration but not design or video.'),
  ('Template Library', 4, 5, 'Cohesive AI has 200 purpose-built writing templates spanning more content categories. Simplified has strong writing templates but the graphic design templates are the standout with 10,000 designs.'),
  ('AI Writing Quality', 3, 4, 'Cohesive AI real-time editing and refinement produces more polished writing output. Simplified writing quality is good but the platform prioritizes breadth over depth in writing.'),
  ('Team Collaboration', 3, 4, 'Cohesive AI has shared workspaces, brand voice settings, and team content libraries. Simplified team features are adequate but less mature for large content teams.'),
  ('Social Media Scheduling', 5, 1, 'Simplified includes a full social media scheduling calendar for Instagram, LinkedIn, Twitter/X, and TikTok. Cohesive AI does not include scheduling.'),
  ('Language Support', 5, 4, 'Simplified supports content generation in 30 languages. Cohesive AI covers major languages but Simplified has broader coverage.'),
  ('Pricing', 4, 4, 'Simplified has a Freemium plan and paid plans from $12 per month. Cohesive AI Starter starts at $16 per month. Both are accessible for individual creators and small teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'simplified-vs-cohesive-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'simplified-vs-cohesive-ai');

-- 5. rapidely vs predis-ai: social media calendar + AI vs visual AI social content
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'rapidely-vs-predis-ai', 'rapidely', 'predis-ai',
  'Rapidely and Predis.ai both use AI to accelerate social media content creation, but they approach it from different starting points. Rapidely starts with strategy: it generates a full monthly content calendar from a brief, then creates the captions, hashtags, and variations for each planned post. Predis.ai starts with the post: it generates visual creatives - images, carousel slides, and short videos - from a prompt or product URL, with captions generated to match the visual. Choose Rapidely for calendar-level content planning across platforms. Choose Predis.ai when visual content creation is the primary bottleneck.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rapidely-vs-predis-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'rapidely-vs-predis-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Monthly Calendar Planning', 5, 2, 'Rapidely generates a full monthly content calendar from a brief with post ideas, captions, and scheduling for each day. Predis.ai does not have a calendar planning feature.'),
  ('Visual Content Creation', 2, 5, 'Predis.ai generates images, carousel slides, and short videos directly from prompts or product URLs. Rapidely does not include visual content generation.'),
  ('Carousel Post Generation', 3, 5, 'Predis.ai carousel maker is a standout feature that produces multi-slide educational posts automatically. Rapidely has carousel tools but they are less automated.'),
  ('Multi-platform Publishing', 4, 3, 'Rapidely supports publishing to Instagram, LinkedIn, Twitter/X, Facebook, and TikTok from the calendar view. Predis.ai supports major platforms but publishing workflow is less central to the product.'),
  ('Caption and Copy Quality', 5, 3, 'Rapidely AI caption generation is a core strength, producing platform-appropriate copy with hashtags for each post type. Predis.ai captions are generated to match visuals but writing depth is secondary.'),
  ('Competitor Analysis', 2, 4, 'Predis.ai includes competitor content analysis to identify what is performing well in the space. Rapidely does not have competitive intelligence features.'),
  ('Pricing', 5, 3, 'Rapidely starts at $9 per month, making it accessible for individual creators. Predis.ai plans start at $32 per month, reflecting the higher cost of AI image and video generation.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rapidely-vs-predis-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'rapidely-vs-predis-ai');
