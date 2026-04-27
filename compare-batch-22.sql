-- compare-batch-22.sql
-- 5 new comparison pairs - all tools confirmed in Supabase DB
-- Pairs verified against compare-batch-2 through compare-batch-21 - no duplicates
-- tabnine-vs-codeium, zed-vs-cursor, midjourney-vs-flux, aider-vs-cursor, phind-vs-perplexity
-- ON CONFLICT (slug) DO NOTHING (idempotent)

-- ============================================================
-- PAIR 1: Tabnine vs Codeium
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'tabnine-vs-codeium',
  'tabnine',
  'codeium',
  'Tabnine and Codeium are two of the most widely used AI code completion tools, and both are positioned as privacy-conscious alternatives to GitHub Copilot. Tabnine is the older and more enterprise-focused option - it has been on the market since 2018, offers full self-hosting for regulated industries, and supports over 80 programming languages with configurable AI models. Codeium is the newer challenger, offering a generous free tier with unlimited completions, strong multi-language support, and a chat interface that competes with Copilot Chat.

For individual developers and small teams, Codeium wins on value - its free tier is genuinely useful, and the quality of completions has improved significantly. For enterprise teams with strict data governance requirements, Tabnine wins on control - its self-hosted deployment option means code never leaves your infrastructure.

The code completion quality between the two has converged in 2026. Tabnine''s Pro model and Codeium''s completions both perform well for routine coding tasks. The primary differentiator is the deployment and privacy model: Tabnine for regulated enterprise environments, Codeium for teams and developers who want quality completions without the enterprise price tag.',
  NULL,
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('tabnine-vs-codeium', 'Code Completion Quality', 4, 4, 'Both produce high-quality completions for common languages. Tabnine''s Pro model uses larger context; Codeium''s suggestions have improved significantly in recent updates.', 1),
  ('tabnine-vs-codeium', 'Free Tier Value', 3, 5, 'Codeium offers unlimited free completions with no credit card required. Tabnine''s free tier is limited to basic completions with shorter context windows.', 2),
  ('tabnine-vs-codeium', 'Enterprise and Privacy', 5, 3, 'Tabnine supports full self-hosting and air-gapped deployment, making it the choice for regulated industries. Codeium is cloud-hosted with strong data policies but no self-hosted option.', 3),
  ('tabnine-vs-codeium', 'IDE Support', 5, 5, 'Both support VS Code, JetBrains, Neovim, and most major IDEs. Coverage is comprehensive for both tools.', 4),
  ('tabnine-vs-codeium', 'AI Chat Features', 3, 4, 'Codeium''s chat feature (Codeium Chat) is more polished and actively developed. Tabnine''s chat is available but less capable.', 5),
  ('tabnine-vs-codeium', 'Team Administration', 5, 3, 'Tabnine Teams provides centralised admin, usage analytics, and policy controls. Codeium Teams is simpler and less configurable.', 6),
  ('tabnine-vs-codeium', 'Pricing Value', 3, 5, 'Codeium is free for individuals. Tabnine Pro starts at $12/month - reasonable, but Codeium offers comparable quality for free.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'tabnine-vs-codeium')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'tabnine-vs-codeium');

-- ============================================================
-- PAIR 2: Zed vs Cursor
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'zed-vs-cursor',
  'zed',
  'cursor',
  'Zed and Cursor represent two distinct approaches to AI-assisted coding. Zed is a ground-up, native editor built for performance - written in Rust, it is the fastest editor available, and its AI features (inline generation, AI chat, collaborative editing) are integrated without the weight of the VS Code runtime. Cursor is a VS Code fork that adds powerful AI features on top of the most popular editor ecosystem - it inherits VS Code''s 30,000+ extensions and massive plugin library at the cost of some performance overhead.

For developers who prioritise raw speed and a streamlined experience, Zed is compelling - especially for those who have moved away from VS Code for performance reasons or who work on large codebases where editor latency matters. For developers who rely on specific VS Code extensions, have existing VS Code workflows, or want the most powerful AI context and multi-file editing capabilities available today, Cursor is the stronger choice.

Cursor''s Composer feature, which handles complex multi-file autonomous edits with full codebase context, currently has no equivalent in Zed. Zed''s collaborative editing and performance advantages are real but less impactful for solo development workflows. The practical choice depends heavily on whether VS Code extension compatibility matters to the individual developer.',
  'cursor',
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('zed-vs-cursor', 'Editor Performance', 5, 3, 'Zed is written in Rust and is significantly faster than Cursor. Opening large files, searching codebases, and editor responsiveness are all noticeably better in Zed.', 1),
  ('zed-vs-cursor', 'AI Code Generation', 3, 5, 'Cursor''s Composer handles complex multi-file edits with full codebase context. Zed''s AI features are good but less capable for large, autonomous code changes.', 2),
  ('zed-vs-cursor', 'Extension Ecosystem', 2, 5, 'Cursor inherits VS Code''s 30,000+ extensions. Zed has a growing but much smaller extension library - many developers will find missing tools.', 3),
  ('zed-vs-cursor', 'Collaborative Editing', 5, 2, 'Zed has real-time multiplayer editing built in - multiple developers can edit the same file simultaneously. Cursor collaboration requires external git workflows.', 4),
  ('zed-vs-cursor', 'AI Chat and Context', 3, 5, 'Cursor''s codebase-aware chat is more powerful, with better indexing of large repositories. Zed AI chat is capable but less sophisticated for large codebases.', 5),
  ('zed-vs-cursor', 'Setup and Familiarity', 4, 5, 'Cursor is familiar to VS Code users - settings, keybindings, and extensions carry over. Zed requires learning a new editor configuration system.', 6),
  ('zed-vs-cursor', 'Pricing Value', 4, 4, 'Both offer free tiers. Zed is free and open-source. Cursor Pro is $20/month. For power users who use AI heavily, Cursor Pro is worth the cost.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zed-vs-cursor')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zed-vs-cursor');

-- ============================================================
-- PAIR 3: Midjourney vs Flux
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'midjourney-vs-flux',
  'midjourney',
  'flux',
  'Midjourney and Flux represent two different generations and philosophies of AI image generation. Midjourney is the established leader - it has the best aesthetic quality and stylistic coherence of any image model available, operates through a Discord-first interface that many users now find limiting, and requires a subscription with no free tier. Flux is the open-source challenger from Black Forest Labs, offering model weights that can be run locally or through APIs, with strong photorealistic output and significantly more flexibility in how it can be deployed and fine-tuned.

Midjourney''s output quality - particularly for artistic, stylised, and compositionally complex images - remains best-in-class. The Midjourney team has consistently improved the model''s ability to understand aesthetic intent and produce images that require minimal iteration. Flux excels at photorealism and prompt accuracy, and its open-source nature makes it the practical choice for developers building image generation into applications, for users who want to run models locally, and for anyone who needs fine-tuning control.

For end users wanting the highest aesthetic quality without technical friction, Midjourney wins. For developers, researchers, or power users who need flexibility, local execution, or commercial API access without per-image subscription limits, Flux is the more practical choice.',
  'midjourney',
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('midjourney-vs-flux', 'Image Quality and Aesthetics', 5, 4, 'Midjourney produces the most aesthetically polished and stylistically coherent images of any model. Flux has excellent photorealism but is less consistently "beautiful" for artistic work.', 1),
  ('midjourney-vs-flux', 'Prompt Accuracy', 4, 5, 'Flux follows complex prompts more literally - better for specific technical requirements. Midjourney interprets prompts with creative licence that is sometimes too much.', 2),
  ('midjourney-vs-flux', 'Ease of Use', 4, 3, 'Midjourney''s web interface is polished. Flux requires access through third-party UIs or API integrations; using it directly requires technical setup.', 3),
  ('midjourney-vs-flux', 'Developer and API Access', 2, 5, 'Flux''s open-source weights can be run via Replicate, Together AI, or locally. Midjourney has limited API access and no official developer tier for most users.', 4),
  ('midjourney-vs-flux', 'Fine-tuning and Customisation', 2, 5, 'Flux supports LoRA fine-tuning and model customisation. Midjourney does not support fine-tuning on custom datasets.', 5),
  ('midjourney-vs-flux', 'Free Tier', 1, 4, 'Midjourney has no free tier. Flux is free to run locally and available via pay-per-use APIs with no subscription required.', 6),
  ('midjourney-vs-flux', 'Pricing Value', 3, 5, 'Midjourney starts at $10/month for 200 images. Flux via API costs fractions of a cent per image for high-volume users. Flux is more economical at scale.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'midjourney-vs-flux')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'midjourney-vs-flux');

-- ============================================================
-- PAIR 4: Aider vs Cursor
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'aider-vs-cursor',
  'aider',
  'cursor',
  'Aider and Cursor both enable AI-assisted coding with full codebase context, but they are built for fundamentally different workflows. Aider is a command-line tool - you run it in a terminal alongside your existing editor, and it makes changes directly to your files through a conversational interface. It is model-agnostic, works with any codebase regardless of language, and integrates naturally into Unix-style developer workflows. Cursor is a full IDE built on VS Code that keeps you in a graphical interface and integrates AI into the editing experience visually.

For developers who live in the terminal, use Vim or Emacs or have a deeply customised editor setup, and want maximum flexibility in which AI model they use, Aider is compelling. It is open-source, free, and uses your own API keys - so there are no subscription costs beyond what you pay the model provider directly. For developers who work in VS Code and want a polished, integrated AI experience with powerful multi-file editing through Cursor''s Composer, Cursor is the better choice.

The practical difference is integration: Aider is a tool you use alongside your workflow, while Cursor replaces your editor. Neither is objectively better - the right choice depends entirely on whether the developer wants to stay in their existing environment or move to an AI-first editor.',
  NULL,
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('aider-vs-cursor', 'Workflow Integration', 4, 5, 'Cursor integrates AI into a familiar IDE interface. Aider runs in the terminal alongside your existing editor, requiring a context switch for non-terminal developers.', 1),
  ('aider-vs-cursor', 'Model Flexibility', 5, 3, 'Aider supports any LLM via API - switch between Claude, GPT-4, Gemini, and local models freely. Cursor has fixed model options that change at Cursor''s discretion.', 2),
  ('aider-vs-cursor', 'Codebase Context', 4, 5, 'Cursor''s codebase indexing and Composer feature handle large codebases more reliably. Aider uses git history and file maps effectively but can struggle with very large repositories.', 3),
  ('aider-vs-cursor', 'Cost', 5, 3, 'Aider is free and open-source - you pay only for API calls at cost. Cursor Pro is $20/month on top of any model API costs.', 4),
  ('aider-vs-cursor', 'Ease of Use', 2, 5, 'Cursor works out of the box for VS Code users. Aider requires terminal familiarity, Python installation, and API key setup - higher barrier to entry.', 5),
  ('aider-vs-cursor', 'Autonomous Multi-file Editing', 4, 5, 'Cursor Composer handles complex autonomous changes across many files with visual feedback. Aider does this well in the terminal but lacks the visual confirmation layer.', 6),
  ('aider-vs-cursor', 'Privacy and Data Control', 5, 3, 'Aider sends code only to the model provider you choose. Cursor sends code to Cursor''s servers in addition to the model provider.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'aider-vs-cursor')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'aider-vs-cursor');

-- ============================================================
-- PAIR 5: Phind vs Perplexity
-- ============================================================
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at) VALUES (
  'phind-vs-perplexity',
  'phind',
  'perplexity',
  'Phind and Perplexity are both AI-powered search tools that return sourced, synthesised answers rather than a list of links - but they serve different primary audiences. Phind is built specifically for developers: its training data emphasises programming documentation, Stack Overflow, GitHub, and technical blogs, and its answers come with code examples and technical specificity that general-purpose search engines cannot match. Perplexity is built for general information retrieval - it covers everything from current events to scientific research to product recommendations, with a polished interface and strong source citation.

For developers searching for how to use a specific API, debug an error message, or understand a technical concept, Phind is typically more useful - its answers are more technically precise and the code it generates is directly applicable. For broader research that goes beyond programming - market research, scientific topics, news, or general knowledge questions - Perplexity is the stronger tool.

The practical divide is simple: developers bookmark Phind for technical questions and Perplexity for everything else. Both offer free tiers; both have Pro plans that unlock more powerful models and higher usage limits. If you are primarily a developer and want one tool, Phind delivers more value for that specific use case. If you want one tool for everything, Perplexity''s breadth makes it the more versatile choice.',
  NULL,
  NOW()
) ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
SELECT v.comparison_slug, v.name, v.tool_a_score, v.tool_b_score, v.notes, v.sort_order
FROM (VALUES
  ('phind-vs-perplexity', 'Technical and Coding Answers', 5, 3, 'Phind''s model is trained on developer content and produces more accurate, applicable code examples. Perplexity''s coding answers are good but less technically precise.', 1),
  ('phind-vs-perplexity', 'General Knowledge Search', 2, 5, 'Perplexity covers current events, science, culture, and business with real-time web search. Phind is focused on technical topics and is weak on general research questions.', 2),
  ('phind-vs-perplexity', 'Source Citations', 4, 5, 'Both cite sources. Perplexity''s citation interface is more polished and consistent. Phind''s sources are relevant but presented less cleanly.', 3),
  ('phind-vs-perplexity', 'Interface and Experience', 3, 5, 'Perplexity''s interface is cleaner, faster, and has better mobile support. Phind''s interface is functional but more developer-focused and less polished.', 4),
  ('phind-vs-perplexity', 'Free Tier Limits', 4, 4, 'Both offer useful free tiers. Phind''s free tier includes coding search without strict query limits. Perplexity free tier limits Pro model usage and some features.', 5),
  ('phind-vs-perplexity', 'Code Search and IDE Integration', 5, 2, 'Phind offers VS Code extension and IDE integrations for in-editor technical search. Perplexity has no developer-specific tooling.', 6),
  ('phind-vs-perplexity', 'Pricing Value', 4, 4, 'Both charge $20/month for Pro. Phind Pro unlocks faster models and more queries. Perplexity Pro unlocks GPT-4o, Claude, and unlimited searches. Value depends on use case.', 7)
) AS v(comparison_slug, name, tool_a_score, tool_b_score, notes, sort_order)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'phind-vs-perplexity')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'phind-vs-perplexity');
