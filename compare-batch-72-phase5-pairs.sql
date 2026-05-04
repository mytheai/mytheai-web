-- Phase 6 (S87f): 5 high-search-volume comparison pairs involving Phase 5 tools.
-- Pairs target the 2026 head-term search demand: chatgpt-vs-deepseek, claude-vs-deepseek,
-- cursor-vs-v0, runway-vs-luma-dream-machine, aider-vs-cursor.
-- All pair slugs verified fresh against all prior compare-batch-*.sql files.

-- 1. chatgpt-vs-deepseek (frontier vs open-weight reasoning)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'chatgpt-vs-deepseek',
  'chatgpt',
  'deepseek',
  'ChatGPT and DeepSeek represent the two ends of the 2026 LLM market: closed frontier vs open-weight challenger. ChatGPT-5 (the GPT-5 generation in ChatGPT) leads on instruction following, multimodal input/output, real-time browsing, voice mode, and the ecosystem (custom GPTs, plugins, Connectors). DeepSeek-R1 and DeepSeek-V3 match or beat ChatGPT on reasoning-heavy tasks (math, structured logic, code) and cost roughly 1/30th per token via API, while being free and unlimited via the chat.deepseek.com web interface. The trade-off: ChatGPT has a richer agentic ecosystem and broader integrations; DeepSeek has cheaper API economics, open-weight downloadable models, and stronger raw reasoning per dollar. For most consumer chat use cases the user-facing experience tilts ChatGPT. For developers building reasoning-heavy products on a budget, or for self-hosted deployment, DeepSeek wins decisively. Political/sensitive topics about China are filtered on DeepSeek - not an issue for most workflows but a hard constraint for some.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatgpt-vs-deepseek');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'chatgpt-vs-deepseek', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Reasoning Quality',            4, 5, 'DeepSeek-R1 matches or beats ChatGPT on math, code, and structured logic benchmarks in 2026'),
  ('Multimodal (vision + voice)',  5, 3, 'ChatGPT has voice mode, image input/output, video understanding; DeepSeek is text-first with limited multimodal'),
  ('API Cost per Token',           2, 5, 'DeepSeek API is roughly 1/30th the cost of GPT-5 for equivalent reasoning quality'),
  ('Tool/Plugin Ecosystem',        5, 2, 'ChatGPT has Custom GPTs, Connectors, and a wide plugin ecosystem; DeepSeek minimal'),
  ('Open-weight Availability',     1, 5, 'DeepSeek-V3 and R1 are downloadable for self-hosting; ChatGPT closed'),
  ('Content Filter Restrictions',  4, 3, 'DeepSeek filters China-related political topics; ChatGPT has lighter geopolitical filtering'),
  ('Free Tier',                    4, 5, 'DeepSeek chat is free unlimited; ChatGPT free tier is rate-limited and uses smaller model')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'chatgpt-vs-deepseek')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'chatgpt-vs-deepseek');

-- 2. claude-vs-deepseek (long-context reasoning vs open-weight reasoning)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'claude-vs-deepseek',
  'claude',
  'deepseek',
  'Claude and DeepSeek are both reasoning-strong LLMs but optimize different axes. Claude (Anthropic) leads on long-context coherence (200K-1M token windows that hold structure), nuanced writing, instruction following on subtle prompts, and agentic tool use through its Claude Code and Computer Use APIs. DeepSeek-R1 leads on raw mathematical and structured reasoning per dollar, with chain-of-thought traces visible by default and an open-weight architecture you can self-host. For knowledge work that requires careful understanding of large documents (legal, medical, large codebases), Claude is the safer pick - the long-context behavior is more reliable. For high-volume reasoning workloads where API economics matter (math tutoring, code review at scale, automated analysis), DeepSeek wins on cost. Anthropic Constitutional AI gives Claude tighter safety guardrails; DeepSeek''s filters are narrower but include China-political topics.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'claude-vs-deepseek');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'claude-vs-deepseek', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Long-Context Coherence',       5, 3, 'Claude holds structure across 200K-1M tokens; DeepSeek context handling weaker at large scale'),
  ('Math + Structured Reasoning',  4, 5, 'DeepSeek-R1 matches or exceeds Claude on math and logic benchmarks'),
  ('Writing Nuance',               5, 3, 'Claude is preferred by professional writers for prose quality and tone matching'),
  ('Agentic Tool Use',             5, 3, 'Claude Code and Computer Use APIs are mature; DeepSeek tool-use polish behind'),
  ('API Cost per Token',           3, 5, 'DeepSeek API is roughly 1/15th of Claude per equivalent reasoning'),
  ('Self-Hostable',                1, 5, 'DeepSeek weights are downloadable; Claude is closed'),
  ('Safety Guardrails',            5, 3, 'Anthropic Constitutional AI is the most rigorous safety layer in the market 2026')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'claude-vs-deepseek')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'claude-vs-deepseek');

-- 3. cursor-vs-v0 (IDE-native code AI vs UI-generation specialist)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'cursor-vs-v0',
  'cursor',
  'v0',
  'Cursor and v0 solve overlapping but distinctly different problems. Cursor is a full IDE replacement with AI agent baked in - autocomplete, multi-file edits, repo-aware Composer mode, terminal integration. v0 is a focused text-to-UI tool from Vercel that generates React + Tailwind + shadcn/ui components and ships directly to a Vercel preview URL. If you are building a full app or working in a non-trivial codebase, Cursor is the daily driver - v0 cannot navigate, debug, or refactor existing code. If you need a landing page, marketing section, or stakeholder prototype produced in five minutes, v0 is faster than Cursor for that specific task because it is opinionated about React + Tailwind output and has a polished iteration UI. Most production teams use both: v0 to scaffold UI quickly, Cursor to integrate it into the broader codebase.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'cursor-vs-v0');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cursor-vs-v0', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Full Codebase Awareness',      5, 1, 'Cursor reads, navigates, and edits multi-file repos; v0 generates fresh UI in isolation'),
  ('UI-from-Prompt Speed',         3, 5, 'v0 is faster for landing pages and React UI mockups - opinionated stack accelerates output'),
  ('Stack Flexibility',            5, 1, 'Cursor works with any language/framework; v0 is locked to React + Tailwind + shadcn/ui'),
  ('Deploy-to-Production',         2, 5, 'v0 ships to Vercel preview URL in one click; Cursor requires you to handle deployment'),
  ('Backend + Logic Generation',   5, 2, 'Cursor handles full-stack code; v0 is frontend-only'),
  ('Iteration UX',                 4, 5, 'v0 variant generation is the polished iteration loop; Cursor is more conversational'),
  ('Pricing',                      4, 4, 'Cursor $20/mo (similar to v0), v0 free tier covers casual use; cost similar at indie tier')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'cursor-vs-v0')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cursor-vs-v0');

-- 4. runway-vs-luma-dream-machine (cinematic video AI head-to-head)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'runway-vs-luma-dream-machine',
  'runway',
  'luma-dream-machine',
  'Runway and Luma Dream Machine are the two strongest text-to-video tools in 2026, but they optimize different production workflows. Runway Gen-4 emphasizes character consistency across multiple shots, scene direction control (camera moves, motion brushes, masks), and a full editing suite with green-screen and inpainting tools. Luma Dream Machine emphasizes single-shot motion quality - cinematic camera moves, physical realism in cloth, water, and particle behavior - at faster generation times and lower cost per clip. For narrative video production with characters appearing across multiple cuts, Runway wins. For short single-clip content (social videos, animated stills, mood reels), Luma Dream Machine wins on speed and dollar-per-clip. Both produce silent video; audio must be added separately.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'runway-vs-luma-dream-machine');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'runway-vs-luma-dream-machine', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Character Consistency',        5, 3, 'Runway Gen-4 holds character across multiple shots - critical for narrative video'),
  ('Single-Clip Motion Quality',   4, 5, 'Luma Dream Machine has cleaner physical-world motion (cloth, water, particles) per clip'),
  ('Generation Speed',             3, 5, 'Luma generates 5-10s clips faster than Runway Gen-4'),
  ('Editing Suite (post-gen)',     5, 2, 'Runway has green-screen, inpainting, motion brush, and a full timeline editor'),
  ('Image-to-Video Quality',       4, 5, 'Luma image-to-video produces more convincing animation from a still'),
  ('Pricing per Generation',       3, 5, 'Luma starts at $9.99/mo for 30 generations; Runway $15/mo entry, more expensive per clip'),
  ('Resolution + Duration',        5, 4, 'Runway supports longer clips and higher native resolution; Luma capped at 5-10s and 1080p')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'runway-vs-luma-dream-machine')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'runway-vs-luma-dream-machine');

-- 5. aider-vs-cursor (terminal AI pair programmer vs IDE-native code AI)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'aider-vs-cursor',
  'aider',
  'cursor',
  'Aider and Cursor are both AI coding assistants but built for different developer environments. Aider is a terminal-native open-source CLI that integrates with your existing editor (vim, emacs, VS Code, anything) and treats every change as a clean git commit with descriptive messaging. Cursor is a full IDE fork of VS Code with AI baked in - autocomplete, Composer multi-file mode, agent mode, and a polished chat panel. If you live in vim/emacs/CLI workflows or want explicit git history per AI change, Aider is the right pick. If you prefer a polished IDE experience with AI deeply integrated into the editor UI, Cursor wins. Cost-wise, Aider is BYO API key (you pay only the LLM API cost - DeepSeek can run Aider for cents per session); Cursor is $20/month subscription. For visual front-end work and unfamiliar codebases, Cursor''s context handling is smoother. For backend, infrastructure, and CLI-shop work, Aider is faster.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'aider-vs-cursor');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'aider-vs-cursor', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Editor Flexibility',           5, 2, 'Aider works alongside any editor (vim, emacs, VS Code); Cursor IS the editor (VS Code fork)'),
  ('Polished UI',                  3, 5, 'Cursor has a polished IDE-native UX; Aider is text-only terminal'),
  ('Git Workflow Integration',     5, 3, 'Aider commits each change with descriptive messages by default; Cursor leaves git to the user'),
  ('Multi-File Refactoring',       5, 5, 'Both handle multi-file edits well; Aider via repo map, Cursor via Composer'),
  ('Cost Model',                   5, 3, 'Aider is BYO API (cents per session with DeepSeek); Cursor $20/mo flat'),
  ('Onboarding for Beginners',     2, 5, 'Cursor is beginner-friendly; Aider requires terminal comfort and CLI flag knowledge'),
  ('Visual Front-end Work',        3, 4, 'Cursor''s in-editor preview helps front-end iteration; Aider relies on browser side-by-side')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'aider-vs-cursor')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'aider-vs-cursor');
