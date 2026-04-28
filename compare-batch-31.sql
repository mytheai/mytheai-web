-- compare-batch-31.sql
-- 5 comparison pairs: AI SEO tools (theme matches batch-31)
-- All pairs use tools confirmed in DB
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: clearscope-vs-surfer-seo
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'clearscope-vs-surfer-seo',
  'clearscope',
  'surfer-seo',
  'Clearscope vs Surfer SEO is the clearest specialisation divide in AI content optimisation. Clearscope does one thing exceptionally well: it grades your content against the top-ranking competitors for a keyword and gives you a score from F to A++. The grade is reliable, shareable, and used by agencies as the editorial standard for every published piece. Surfer SEO covers more ground - keyword research, SERP analysis, an AI writer, and a Content Score - making it the more complete tool. For teams that need an all-in-one content platform, Surfer wins on breadth. For teams that need the most reliable, agency-grade content scoring standard, Clearscope wins on precision. Price is also a significant differentiator: Clearscope starts at $189/month while Surfer starts at $99/month, which is counterintuitive given Surfer offers more features.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'clearscope-vs-surfer-seo', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Content grading accuracy', 5, 4, 'Clearscope''s content grade is widely considered the most precise in the industry. Agency SEO teams use Clearscope grades as the editorial quality standard because the scoring is calibrated specifically to competitor content rather than generic keyword databases.'),
  ('Keyword research tools', 1, 4, 'Surfer includes keyword research with SERP analysis, volume data, and keyword clustering. Clearscope has minimal keyword research capability - it is designed for optimising content after the keyword has been chosen, not for discovering keywords.'),
  ('AI writing assistance', 1, 5, 'Surfer AI can write full drafts with optimization baked in. Clearscope focuses purely on content grading and does not include an AI writer.'),
  ('SERP competitor analysis', 3, 5, 'Surfer''s SERP Analyzer provides deep competitor data including NLP terms, heading structure, word count benchmarks, and page speed. Clearscope shows competitor terms but less granular competitor page data.'),
  ('Ease of use for non-SEOs', 4, 3, 'Clearscope''s single-metric grade is simple enough for non-SEO writers to act on. Surfer''s multiple scoring dimensions and settings have a steeper learning curve for writers unfamiliar with SEO.'),
  ('Team and agency workflow features', 4, 4, 'Both offer content briefs and editor access for sharing with writers. Clearscope briefs are cleaner and more writer-friendly. Surfer offers more data density which SEO specialists prefer.'),
  ('Pricing value', 3, 5, 'Surfer starts at $99/month for the Essential plan. Clearscope starts at $189/month. Surfer delivers more features at a lower entry price, making it significantly better value for teams on a budget.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'clearscope-vs-surfer-seo')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'clearscope-vs-surfer-seo');

-- Pair 2: marketmuse-vs-clearscope
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'marketmuse-vs-clearscope',
  'marketmuse',
  'clearscope',
  'MarketMuse vs Clearscope serves different stages of the content strategy process. MarketMuse operates at the strategy level: it analyses your entire site, identifies topic gaps versus competitors, prioritises which pages have the highest ranking potential given your existing authority, and builds a full content plan. Clearscope operates at the page level: it tells you exactly which terms and topics to include in the content you are already writing. The tools are complementary rather than competing - MarketMuse answers "what should we create and in what order" while Clearscope answers "how well does this specific piece cover the topic." Teams with content strategy resources use both. Teams that need just one tool choose MarketMuse for planning-heavy strategies and Clearscope for teams that already have keyword plans and need reliable quality control at the content level.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'marketmuse-vs-clearscope', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Site-level content strategy', 5, 1, 'MarketMuse analyses your entire domain to identify content gaps, prioritise pages by ranking potential, and build a full topical authority roadmap. Clearscope does not offer site-level strategic analysis - it is a page-by-page optimisation tool.'),
  ('Page-level content grading', 3, 5, 'Clearscope''s per-page content grade is more precise and widely trusted for editorial quality control. MarketMuse provides page-level scoring but the industry standard for content grading is Clearscope.'),
  ('Competitive gap analysis', 5, 2, 'MarketMuse compares your content coverage to competitors at the topic cluster level, identifying strategic gaps. Clearscope compares your page to competitors for a single keyword but does not provide strategic gap analysis.'),
  ('Content brief generation', 4, 3, 'MarketMuse generates detailed briefs with topic cluster context and authority data. Clearscope briefs are focused on term coverage for a single keyword and are simpler but more writer-friendly.'),
  ('Ease of use for content writers', 2, 5, 'Clearscope is simple enough for any writer to use without SEO training - grade your content, add missing terms, publish. MarketMuse requires more strategic context to use effectively and is primarily a tool for SEO strategists.'),
  ('ROI for high-volume sites', 5, 3, 'MarketMuse''s site-level prioritisation delivers disproportionate ROI on large sites where strategic content planning matters. For small sites or teams publishing a few articles per month, the extra complexity may not justify MarketMuse pricing.'),
  ('Pricing accessibility', 3, 3, 'MarketMuse starts at $149/month. Clearscope starts at $189/month. Both are premium tools. MarketMuse''s limited free plan gives basic access. Clearscope has no free tier.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'marketmuse-vs-clearscope')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'marketmuse-vs-clearscope');

-- Pair 3: contentatscale-vs-jasper
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'contentatscale-vs-jasper',
  'contentatscale',
  'jasper',
  'Content at Scale vs Jasper represents two fundamentally different visions of AI writing. Content at Scale is built for volume: give it a keyword and it researches, outlines, and writes a full 2,000 - 5,000 word SEO article in minutes, with built-in AI detection scoring so teams can verify the output before publishing. It is a pipeline tool for content marketing teams that need to publish at scale. Jasper is built for flexibility: brand voice training, a library of templates for every content format (ads, emails, landing pages, social posts, long-form articles), and an AI assistant that works alongside marketers rather than replacing them. For teams whose primary output is SEO blog posts at high volume, Content at Scale wins on efficiency. For marketing teams producing varied content across multiple formats and channels, Jasper wins on versatility.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'contentatscale-vs-jasper', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Long-form SEO article output', 5, 3, 'Content at Scale produces full-length, research-backed SEO articles from a keyword input in minutes. Jasper generates long-form content but requires more manual structuring and prompting to reach comparable output quality for SEO.'),
  ('Brand voice and tone consistency', 2, 5, 'Jasper''s Brand Voice feature trains on your content samples and applies your tone across all generated output. Content at Scale does not offer comparable brand voice customisation - the output style is relatively consistent regardless of brand.'),
  ('Content format variety', 1, 5, 'Jasper has 50+ templates covering ads, emails, social media, product descriptions, and long-form content. Content at Scale generates SEO blog articles only - it is not designed for short-form or multi-format content production.'),
  ('AI detection resistance', 5, 2, 'Content at Scale includes built-in Originality.ai scanning and is specifically designed to produce content that passes AI detection. Jasper output varies in detectability and does not include built-in detection scoring.'),
  ('Cost per word at scale', 5, 3, 'For teams publishing 20+ long articles per month, Content at Scale''s per-post pricing delivers a significantly lower cost per published word than Jasper at equivalent volume. Jasper becomes more expensive as word volume increases.'),
  ('Research and sourcing', 5, 2, 'Content at Scale pulls from multiple AI models plus real-time web research to support its articles. Jasper relies on the LLM training data and does not incorporate live web research into article generation.'),
  ('Ease of use for marketing teams', 3, 5, 'Jasper''s interface is designed for marketers with varied content needs and is intuitive for non-technical users. Content at Scale is straightforward for SEO article production but is narrower in application.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'contentatscale-vs-jasper')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'contentatscale-vs-jasper');

-- Pair 4: originality-ai-vs-grammarly
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'originality-ai-vs-grammarly',
  'originality-ai',
  'grammarly',
  'Originality.ai vs Grammarly addresses the same content, at opposite ends of the quality control process. Grammarly improves the writing before publishing: grammar, spelling, clarity, tone, and readability. Originality.ai audits the writing after it is created: AI content detection, plagiarism checking, and readability scoring. The tools are not direct competitors - they serve different quality control functions. Teams using AI writing tools need both: Grammarly to improve the output quality and clarity, Originality.ai to verify the content will not be flagged as AI-generated by publishers or search engines. The overlap is in plagiarism and readability, where both tools offer checks. But for pure AI detection, Originality.ai is the specialist - and for pure writing improvement, Grammarly is the benchmark.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'originality-ai-vs-grammarly', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('AI content detection', 5, 1, 'Originality.ai is purpose-built for AI detection with accuracy rates that exceed general-purpose tools. It scans specifically for web-published AI content patterns. Grammarly has limited AI detection capability and does not position itself as a detection tool.'),
  ('Grammar and writing improvement', 1, 5, 'Grammarly is the benchmark for grammar correction, style suggestions, clarity improvements, and tone adjustment. Originality.ai does not improve writing - it only audits it.'),
  ('Plagiarism detection', 4, 3, 'Both tools include plagiarism checking. Originality.ai''s plagiarism checker is particularly useful for flagging AI output that may reproduce training data. Grammarly''s plagiarism detection is solid for human-written content but less tuned for AI content patterns.'),
  ('Real-time writing assistance', 1, 5, 'Grammarly works in real time within email clients, documents, browsers, and IDEs. Originality.ai is a scanning tool - you paste or submit content for review, not a real-time writing assistant.'),
  ('Team and agency workflows', 4, 3, 'Originality.ai includes team plans for agencies to scan batches of AI-generated content before delivery. Grammarly Business serves enterprise writing teams. Both have team features but for different use cases.'),
  ('Value for AI-heavy content teams', 5, 3, 'For teams using AI writing tools extensively, Originality.ai provides essential quality control that Grammarly cannot replace. As AI content detection becomes more consequential for SEO and publisher acceptance, Originality.ai''s role becomes more critical.'),
  ('Pricing accessibility', 4, 3, 'Originality.ai starts at $30/month for 200 credits. Grammarly Pro starts at $12/month. Grammarly is cheaper for individual use, but Originality.ai''s pay-as-you-go credit model is cost-effective for teams with variable content volumes.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'originality-ai-vs-grammarly')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'originality-ai-vs-grammarly');

-- Pair 5: scalenut-vs-frase
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'scalenut-vs-frase',
  'scalenut',
  'frase',
  'Scalenut vs Frase compares two all-in-one SEO content platforms that both aim to take you from keyword to published article in one workflow. Frase''s strength is the research and briefing phase: it rapidly aggregates what the top-ranking pages cover and makes that information accessible to writers in a clean interface. Scalenut goes further by adding Cruise Mode, which chains keyword research, brief generation, and AI writing into a single automated flow. For content teams that primarily need better briefing and research speed, Frase is simpler and gets the job done. For teams that want the briefing and writing fully integrated and automated, Scalenut reduces the manual steps. Both are priced accessibly relative to Surfer and Clearscope, making them popular choices for growing content teams that cannot yet justify premium pricing.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'scalenut-vs-frase', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('End-to-end workflow automation', 5, 3, 'Scalenut''s Cruise Mode chains keyword research, brief generation, and AI article writing into a single automated flow. Frase requires more manual steps between research, brief, and writing - the workflow is less automated end-to-end.'),
  ('Content brief quality', 4, 5, 'Frase''s briefs are widely considered the cleaner output for handing to writers. The competitor question extraction and heading recommendations are more actionable. Scalenut briefs are good but optimised for their own AI writer rather than external writers.'),
  ('AI writing quality', 4, 3, 'Scalenut''s AI writing has improved significantly and produces readable first drafts. Frase''s AI writing is functional but more useful as a starting point that requires substantial editing.'),
  ('SERP and competitor analysis', 4, 5, 'Frase pulls detailed data from the top 20 SERP results including headings, questions, word counts, and key topics. The competitor analysis is Frase''s strongest feature. Scalenut''s competitor analysis is good but less detailed than Frase.'),
  ('Keyword research integration', 5, 2, 'Scalenut includes keyword research and clustering as part of the planning workflow. Frase is primarily focused on page-level research rather than upstream keyword discovery.'),
  ('Pricing accessibility', 5, 4, 'Scalenut starts at $39/month with more features at that tier. Frase starts at $45/month. Both are affordable relative to Surfer and Clearscope. Scalenut offers slightly more value at the entry level.'),
  ('Ease of use for writers', 3, 5, 'Frase''s interface is particularly clean and intuitive for writers who are not SEO specialists. Scalenut''s workflow has more steps and options, which provides more control but requires more time to learn.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'scalenut-vs-frase')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'scalenut-vs-frase');
