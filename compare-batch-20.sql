-- compare-batch-20.sql
-- 5 new comparison pairs using tools already in DB
-- ON CONFLICT DO NOTHING + NOT EXISTS guard (idempotent)

-- 1. claude-vs-perplexity: AI assistant vs AI research engine
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'claude-vs-perplexity', 'claude', 'perplexity',
  'Claude and Perplexity are both popular AI tools, but they serve fundamentally different use cases. Claude is a general-purpose AI assistant built for writing, analysis, coding, and complex reasoning tasks. Perplexity is an AI search engine built for research and information retrieval, with real-time web access that gives it an advantage on current events and fact-checking. For tasks involving current information, citations, or rapid research, Perplexity is the stronger choice. For tasks involving writing, code generation, document analysis, or extended reasoning over complex material, Claude is more capable. Many teams use both: Perplexity for research gathering and Claude for synthesis, writing, and production.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'claude-vs-perplexity');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('claude-vs-perplexity', 'Writing Quality', 5, 3, 'Claude produces significantly better long-form written content. Perplexity is optimised for summarisation and search results, not creative or analytical writing.', 1),
  ('claude-vs-perplexity', 'Real-Time Web Access', 2, 5, 'Perplexity retrieves current information from the web with citations on every response. Claude base model has a knowledge cutoff and requires extensions for web access.', 2),
  ('claude-vs-perplexity', 'Research with Citations', 3, 5, 'Perplexity automatically cites sources for every response. Claude provides strong research synthesis but cannot verify current information without web access.', 3),
  ('claude-vs-perplexity', 'Code Generation', 5, 2, 'Claude is one of the top models for code generation and debugging. Perplexity can answer coding questions but is not optimised for writing or reviewing code.', 4),
  ('claude-vs-perplexity', 'Document Analysis', 5, 2, 'Claude handles long documents and multi-document analysis up to 200K tokens. Perplexity does not accept document uploads for analysis.', 5),
  ('claude-vs-perplexity', 'Pricing', 3, 4, 'Both have free tiers. Perplexity Pro at $20/mo includes web search. Claude Pro at $20/mo delivers more capability for writing and reasoning but without real-time web.', 6),
  ('claude-vs-perplexity', 'Context Window', 5, 2, 'Claude supports up to 200K tokens of context for long document work. Perplexity''s context window is significantly shorter and not designed for document analysis.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'claude-vs-perplexity')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'claude-vs-perplexity');

-- 2. loom-vs-scribe: async video vs auto-generated text documentation
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'loom-vs-scribe', 'loom', 'scribe',
  'Loom and Scribe both help teams capture and communicate processes without live meetings, but they produce completely different output formats. Loom creates async video recordings where a presenter explains something on screen - suitable for walkthroughs, updates, and personal communication where tone and context matter. Scribe automatically generates step-by-step text guides with screenshots from any process you perform, suitable for SOPs, onboarding documentation, and repeatable procedures that need to be updated and searched. The choice depends entirely on the output format the audience needs: Loom for video communication, Scribe for written documentation.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'loom-vs-scribe');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('loom-vs-scribe', 'Video Communication', 5, 1, 'Loom is built for video. Scribe produces text and screenshot guides only - no video output at any plan level.', 1),
  ('loom-vs-scribe', 'Written Process Documentation', 1, 5, 'Scribe automatically generates step-by-step guides with annotated screenshots. Loom produces video only and has no structured text output.', 2),
  ('loom-vs-scribe', 'Capture Ease', 4, 5, 'Scribe captures automatically in the background as you complete a task. Loom requires conscious recording setup and active narration throughout.', 3),
  ('loom-vs-scribe', 'Searchable Output', 2, 5, 'Scribe guides are text-based and fully searchable. Loom videos require transcript search, which is only available on paid plans.', 4),
  ('loom-vs-scribe', 'Personal Communication', 5, 1, 'Loom is better for personal context, tone, and face-to-face async communication. Scribe output is purely procedural with no personality.', 5),
  ('loom-vs-scribe', 'Free Tier', 3, 5, 'Scribe''s free tier covers unlimited guide creation. Loom''s free tier limits video duration and total storage.', 6),
  ('loom-vs-scribe', 'Team Documentation', 4, 5, 'Scribe guides can be embedded in Notion, Confluence, and shared as team SOPs. Loom videos require workspace sharing and cannot be embedded as structured docs.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'loom-vs-scribe')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'loom-vs-scribe');

-- 3. klaviyo-vs-activecampaign: e-commerce email vs B2B marketing automation
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'klaviyo-vs-activecampaign', 'klaviyo', 'activecampaign',
  'Klaviyo and ActiveCampaign are both powerful email marketing platforms with automation, but they serve different core audiences. Klaviyo is built for e-commerce brands with deep Shopify and WooCommerce integrations, product recommendation engines, and revenue attribution tied directly to email campaigns. ActiveCampaign is built for B2B businesses and service companies, with stronger CRM features, lead scoring, and sales automation capabilities that Klaviyo does not offer. For e-commerce brands, Klaviyo is typically the stronger choice. For B2B, SaaS, and service businesses, ActiveCampaign''s CRM and lead lifecycle features make it far more suitable.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'klaviyo-vs-activecampaign');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('klaviyo-vs-activecampaign', 'E-commerce Integration', 5, 3, 'Klaviyo''s native Shopify and WooCommerce integration with revenue tracking is best-in-class for e-commerce. ActiveCampaign integrates but lacks Klaviyo''s product-level e-commerce depth.', 1),
  ('klaviyo-vs-activecampaign', 'CRM and Sales Features', 2, 5, 'ActiveCampaign includes a full CRM with deal pipelines, lead scoring, and sales automation. Klaviyo has no CRM - it is a pure email and SMS marketing platform.', 2),
  ('klaviyo-vs-activecampaign', 'Email Automation', 5, 5, 'Both platforms have advanced visual automation builders. Feature parity on core automation capability for both e-commerce and B2B flows.', 3),
  ('klaviyo-vs-activecampaign', 'AI Personalisation', 5, 3, 'Klaviyo''s predictive analytics and product recommendation engine are more advanced for e-commerce personalisation. ActiveCampaign''s AI features are more general.', 4),
  ('klaviyo-vs-activecampaign', 'Pricing', 3, 4, 'Both scale by contact list size. ActiveCampaign''s Lite plan is cheaper for smaller lists. Klaviyo becomes more competitive at e-commerce scale when revenue attribution is factored in.', 5),
  ('klaviyo-vs-activecampaign', 'B2B Suitability', 2, 5, 'ActiveCampaign with its CRM, lead scoring, and sales pipeline features is purpose-built for B2B and service business workflows. Klaviyo is not suited for B2B.', 6),
  ('klaviyo-vs-activecampaign', 'Revenue Reporting', 5, 3, 'Klaviyo''s revenue attribution and e-commerce reporting are best-in-class. ActiveCampaign has solid reporting but lacks product-level revenue analytics.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'klaviyo-vs-activecampaign')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'klaviyo-vs-activecampaign');

-- 4. linear-vs-clickup: focused engineering PM vs comprehensive work management
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'linear-vs-clickup', 'linear', 'clickup',
  'Linear and ClickUp are both project management tools popular with software and product teams, but they represent fundamentally different philosophies. Linear is opinionated, fast, and minimal - built specifically for software engineering teams with a strong focus on issue tracking, sprint cycles, and engineering workflows. ClickUp is comprehensive, customisable, and expansive - covering project management for any team type with hundreds of features including docs, goals, whiteboards, and time tracking. Linear teams value its speed and focus. ClickUp teams value its flexibility. The core question is whether you want a tool optimised for software teams or a platform that can serve the entire organisation.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'linear-vs-clickup');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('linear-vs-clickup', 'Speed and Performance', 5, 3, 'Linear is notably faster to navigate and load than ClickUp. ClickUp''s feature density can make it feel sluggish, especially on complex workspaces with many nested items.', 1),
  ('linear-vs-clickup', 'Software Engineering Workflows', 5, 3, 'Linear''s sprint cycles, GitHub and GitLab integrations, and issue prioritisation are purpose-built for software teams. ClickUp supports engineering workflows but without the same native depth.', 2),
  ('linear-vs-clickup', 'Feature Breadth', 3, 5, 'ClickUp covers docs, goals, mind maps, whiteboards, time tracking, and CRM features. Linear is focused on issues and projects only - by deliberate design.', 3),
  ('linear-vs-clickup', 'Customisation', 3, 5, 'ClickUp allows extensive customisation of views, custom fields, statuses, and workflows. Linear''s opinionated structure offers significantly less flexibility.', 4),
  ('linear-vs-clickup', 'Onboarding Speed', 5, 3, 'Linear''s minimal setup means engineering teams are productive immediately. ClickUp''s feature density creates a steeper onboarding curve that requires dedicated setup time.', 5),
  ('linear-vs-clickup', 'Free Tier', 4, 5, 'ClickUp has a generous free tier supporting unlimited members. Linear''s free tier is limited to small teams. Both scale reasonably on paid plans.', 6),
  ('linear-vs-clickup', 'Cross-Team Suitability', 2, 5, 'ClickUp can serve marketing, HR, and operations teams alongside engineering. Linear is primarily an engineering tool and is less suitable as an org-wide platform.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'linear-vs-clickup')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'linear-vs-clickup');

-- 5. gamma-vs-pitch: AI-generated decks vs collaborative presentation design
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'gamma-vs-pitch', 'gamma', 'pitch',
  'Gamma and Pitch are both AI-assisted presentation tools, but they take fundamentally different approaches to deck creation. Gamma generates complete presentation decks from a prompt or outline in seconds, prioritising speed and AI-led design over manual control. Pitch is a collaborative presentation editor with AI assistance for copy and design suggestions, prioritising visual quality, team collaboration, and custom brand control. For individuals or teams that need a presentation fast with minimal manual work, Gamma is the stronger choice. For teams that want full creative control, consistent brand styling, and real-time collaboration on ongoing presentation assets, Pitch delivers more.',
  NULL, NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gamma-vs-pitch');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT * FROM (VALUES
  ('gamma-vs-pitch', 'AI Generation Speed', 5, 2, 'Gamma generates a complete presentation from a prompt in seconds. Pitch requires more manual deck building with AI suggestions as assistance rather than full generation.', 1),
  ('gamma-vs-pitch', 'Design Quality', 3, 5, 'Pitch produces more polished, brand-consistent presentations with full design control. Gamma''s auto-generated decks often need refinement for professional external use.', 2),
  ('gamma-vs-pitch', 'Team Collaboration', 3, 5, 'Pitch is built for team presentations with real-time collaboration, comments, and workspace sharing. Gamma''s collaboration features are more basic.', 3),
  ('gamma-vs-pitch', 'Brand Customisation', 3, 5, 'Pitch has a full brand kit system with custom fonts, colors, and templates. Gamma''s design customisation is more limited and less brand-consistent.', 4),
  ('gamma-vs-pitch', 'Free Tier', 4, 4, 'Both have free tiers. Gamma''s free tier includes AI generation credits. Pitch''s free tier covers unlimited decks for small teams with no AI credit limits.', 5),
  ('gamma-vs-pitch', 'Ease of Getting Started', 5, 4, 'Gamma''s AI-first approach has a very low learning curve - a prompt is enough to get started. Pitch requires more time to learn its design system and template structure.', 6),
  ('gamma-vs-pitch', 'Export and Sharing', 4, 5, 'Pitch offers more export formats including PDF, PowerPoint, and offline presentation modes. Gamma exports to PDF and web embed but with fewer format options.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gamma-vs-pitch')
AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'gamma-vs-pitch');
