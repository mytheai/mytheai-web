-- compare-batch-44.sql
-- 5 AI Knowledge Management comparison pairs
-- All tools from tools-batch-44 (confirmed in DB)
-- Run AFTER tools-batch-44 confirmed in Supabase
-- Actual slugs: guru, tettra, slab, slite, helpjuice, document360,
--               bloomfire, nuclino, gitbook, obsidian

-- 1. guru-vs-tettra
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'guru-vs-tettra', 'guru', 'tettra',
  'Guru and Tettra are both Slack-integrated knowledge bases, but they solve different problems. Guru is built for customer-facing teams that need verified, always-accurate answers surfaced inside any tool employees use. Tettra is built for internal teams that live in Slack and want to reduce repetitive questions with a lightweight, low-maintenance wiki. Guru wins on answer accuracy and integration breadth; Tettra wins on simplicity and price for small teams.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'guru-vs-tettra');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'guru-vs-tettra', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Slack Integration', 4, 5, 'Tettra is purpose-built around Slack - question detection and answer suggestions happen natively inside channels. Guru integrates well with Slack but is built browser-extension-first.'),
  ('Knowledge Verification', 5, 3, 'Guru verification workflows prompt knowledge owners before cards expire, ensuring accuracy. Tettra has no built-in verification mechanism - content freshness depends on manual discipline.'),
  ('Integration Ecosystem', 5, 2, 'Guru integrates with Salesforce, Chrome, Microsoft Teams, Zendesk, and 40 other tools. Tettra focuses on Slack and has limited third-party integrations.'),
  ('AI Search Quality', 4, 4, 'Both use AI to match questions to relevant content. Guru returns verified card answers; Tettra suggests relevant pages automatically when questions are asked in Slack.'),
  ('Pricing', 3, 5, 'Tettra starts at $4/user/month with a generous free tier. Guru is free up to 3 users then $10/user/month - more expensive at team scale.'),
  ('Ease of Setup', 4, 5, 'Tettra is extremely simple to start - connect Slack and begin creating pages. Guru requires more initial content migration and card organisation before it delivers value.'),
  ('Use Case Fit', 4, 3, 'Guru excels for customer support and sales teams where accuracy matters. Tettra is better for internal team FAQs where the priority is reducing repetitive questions.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'guru-vs-tettra')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'guru-vs-tettra');

-- 2. slab-vs-slite
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'slab-vs-slite', 'slab', 'slite',
  'Slab and Slite are both modern team knowledge bases that position themselves as alternatives to Confluence and Notion. Slab wins on integration breadth with its Unified Search across GitHub, Jira, and Figma - making it the stronger choice for technical teams. Slite wins on async workflows and AI question answering with source citations - making it the stronger choice for remote teams that want fewer interruptions.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'slab-vs-slite');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'slab-vs-slite', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Search', 4, 5, 'Slite Ask returns direct answers with source citations - a question-and-answer experience rather than search-and-browse. Slab Unified Search is powerful but returns links, not direct answers.'),
  ('Integration Depth', 5, 3, 'Slab Unified Search crosses GitHub, Jira, Figma, Loom, and Notion simultaneously. Slite has fewer third-party integrations and does not search connected tools.'),
  ('Editor Quality', 5, 4, 'Both editors are clean and polished. Slab has a slight edge with richer embed support and a more refined writing experience for technical documentation.'),
  ('Async and Remote Focus', 3, 5, 'Slite is designed explicitly for async-first teams - the AI Ask feature reduces time zone interruptions. Slab is async-friendly but less specifically optimised for distributed teams.'),
  ('Pricing', 4, 4, 'Slab starts at $6.67/user/month (free up to 10 users). Slite starts at $8/user/month with a free tier. Comparable pricing at SMB scale.'),
  ('Technical Documentation', 5, 3, 'Slab is the stronger choice for engineering and product teams with GitHub and Jira integration, topic organisation, and technical embed support.'),
  ('Organisation Structure', 4, 4, 'Slab uses topic-based organisation that scales better than nested folders. Slite uses channel-style sections that feel familiar to Slack and Notion users.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'slab-vs-slite')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'slab-vs-slite');

-- 3. document360-vs-helpjuice
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'document360-vs-helpjuice', 'document360', 'helpjuice',
  'Document360 and Helpjuice are both professional knowledge base platforms for companies that need both external customer documentation and internal team wikis. Document360 wins on technical writing depth, version control, and support chat integrations. Helpjuice wins on multi-knowledge-base management from a single account and deep branding customisation. Both target similar mid-market buyers at similar price points.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'document360-vs-helpjuice');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'document360-vs-helpjuice', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Search', 5, 4, 'Document360 Eddy answers questions in natural language from the doc content. Helpjuice AI search analyses query patterns and surfaces content gap opportunities - a different but valuable AI application.'),
  ('Version Control', 5, 3, 'Document360 has article-level version history, rollback, and draft workflows. Helpjuice version control is basic - limited edit history without full rollback functionality.'),
  ('Support Chat Integration', 5, 3, 'Document360 integrates natively with Zendesk, Intercom, Freshdesk, and Drift for in-chat knowledge surfacing. Helpjuice has fewer native support integrations.'),
  ('Multi-Knowledge-Base Management', 3, 5, 'Helpjuice allows multiple branded knowledge bases under one account - ideal for separating customer, partner, and internal content. Document360 manages separate projects but with more friction.'),
  ('Branding Customisation', 3, 5, 'Helpjuice allows full CSS and layout customisation without engineering. Document360 customisation is good but less flexible at the HTML/CSS level.'),
  ('Free Tier', 3, 1, 'Document360 offers a free tier for small projects. Helpjuice has no free tier - minimum spend is $120/month.'),
  ('Analytics', 5, 4, 'Both platforms offer strong analytics. Document360 tracks article contribution activity and failed search patterns. Helpjuice analytics focus on search-to-deflection conversion.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'document360-vs-helpjuice')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'document360-vs-helpjuice');

-- 4. gitbook-vs-slab
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'gitbook-vs-slab', 'gitbook', 'slab',
  'GitBook and Slab are both popular knowledge platforms for technical teams, but they serve different primary audiences. GitBook is optimised for external developer documentation - public-facing docs with Git sync, SEO-optimised output, and AI that answers questions from published content. Slab is optimised for internal team knowledge - private wikis, cross-tool search, and onboarding documentation. The choice comes down to whether the primary audience is external developers or internal team members.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gitbook-vs-slab');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'gitbook-vs-slab', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('External Documentation', 5, 2, 'GitBook publishes polished public documentation sites indexed by search engines and hosted on the Edge network. Slab is designed for internal knowledge and is not optimised for public-facing docs.'),
  ('Git Workflow Integration', 5, 3, 'GitBook Git sync enables PR-based documentation reviews with the same workflow used for code. Slab integrates with GitHub for search but does not support Git-based content editing.'),
  ('Internal Team Wiki', 2, 5, 'Slab is purpose-built for internal knowledge - private pages, team onboarding, and cross-tool Unified Search. GitBook can host private docs but lacks the team wiki features of Slab.'),
  ('AI Capabilities', 4, 4, 'GitBook AI answers questions from published documentation. Slab Unified Search finds content across connected tools. Different AI applications for different use cases.'),
  ('Cross-Tool Search', 2, 5, 'Slab Unified Search queries GitHub, Jira, Figma, Loom, and Notion simultaneously. GitBook search is limited to GitBook content only.'),
  ('Pricing', 4, 4, 'GitBook is free for public docs; paid plans from $8/user/month. Slab is free up to 10 users; paid plans from $6.67/user/month. Comparable for private use.'),
  ('Developer Adoption', 5, 3, 'GitBook is the default choice for open-source projects and developer portals. Slab is less common in developer communities but growing among product and engineering teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gitbook-vs-slab')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'gitbook-vs-slab');

-- 5. obsidian-vs-nuclino
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'obsidian-vs-nuclino', 'obsidian', 'nuclino',
  'Obsidian and Nuclino both use graph views to visualise connections between knowledge, but they target fundamentally different users. Obsidian is personal knowledge management - local files, maximum privacy, a massive plugin ecosystem, and no real-time collaboration. Nuclino is team knowledge management - cloud-based, real-time collaborative editing, and designed to replace the team wiki rather than the personal notebook. If the knowledge problem is individual, Obsidian wins. If it is collective, Nuclino wins.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'obsidian-vs-nuclino');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'obsidian-vs-nuclino', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Personal Knowledge Management', 5, 2, 'Obsidian is the gold standard for individual PKM - local files, deep linking, graph view, and a plugin ecosystem that can replicate almost any workflow. Nuclino is not designed for personal use.'),
  ('Team Collaboration', 1, 5, 'Nuclino is purpose-built for team collaboration with real-time editing, shared workspaces, and access controls. Obsidian has no native real-time collaboration features.'),
  ('Data Ownership and Privacy', 5, 2, 'Obsidian stores files locally in plain Markdown - full data ownership with no cloud dependency. Nuclino is cloud-only with no local storage option.'),
  ('Graph View', 5, 4, 'Both tools have graph views. Obsidian graph is more sophisticated and central to the product. Nuclino graph is useful but plays a secondary role to the list-based navigation.'),
  ('Plugin Ecosystem', 5, 1, 'Obsidian has 1,000+ community plugins covering AI chat, calendar, flashcards, citation management, and more. Nuclino has no plugin system - functionality is fixed.'),
  ('Setup and Onboarding', 2, 5, 'Nuclino is extremely fast to set up - create a workspace and start writing. Obsidian requires vault configuration, plugin selection, and workflow design before it delivers value.'),
  ('Pricing', 4, 4, 'Obsidian is free for personal use; Sync add-on from $4/month. Nuclino is free for small teams; paid plans from $6/user/month. Both are affordable entry points.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'obsidian-vs-nuclino')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'obsidian-vs-nuclino');
