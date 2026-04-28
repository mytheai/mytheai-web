-- tools-batch-44.sql
-- 10 AI Knowledge Management & Internal Wiki tools
-- All slugs verified NOT present in any prior tools-batch file
-- Run after compare-batch-43.sql

INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url,
  category, tags,
  pricing_type, pricing_starting_price,
  rating, review_count,
  featured, trending, editor_pick,
  pros, cons, use_cases, alternatives
) VALUES

(
  'guru',
  'Guru',
  'AI-powered company wiki that surfaces verified knowledge where teams work',
  'Guru is a knowledge management platform that embeds verified company information directly into the tools employees already use - Slack, Chrome, Salesforce, and more. Instead of asking a colleague or hunting through folders, employees get the right answer surfaced in context. The AI search layer understands natural language queries and returns the most relevant card from the company wiki. Knowledge owners verify cards on a schedule, ensuring information stays accurate rather than slowly rotting. Guru works well for customer-facing teams where fast, accurate answers directly affect outcomes: support reps get product specs while on a call, sales reps get pricing details before a demo, and onboarding teams get process docs before starting a task. The browser extension makes Guru ubiquitous without requiring users to switch applications. Slack integration brings search into the channel where the question was asked.',
  NULL, 'https://www.getguru.com',
  ARRAY['productivity', 'business'], ARRAY['knowledge-management', 'wiki', 'ai-search', 'team-productivity'],
  'freemium', 0.00,
  4.4, 1840,
  false, false, false,
  ARRAY['Verified knowledge cards prevent outdated information', 'Browser extension surfaces answers in any app', 'Strong Slack and Salesforce integrations', 'AI search understands natural language queries'],
  ARRAY['Card creation is manual - requires ongoing curation effort', 'Less suitable for highly technical documentation', 'Free plan limited to 3 users'],
  ARRAY['Customer support knowledge base', 'Sales playbook and competitive intelligence', 'Employee onboarding documentation'],
  ARRAY['notion-ai', 'confluence', 'tettra']
),

(
  'tettra',
  'Tettra',
  'Simple knowledge base that answers team questions directly in Slack',
  'Tettra is a knowledge base built for teams that live in Slack. When a team member asks a question in a Slack channel, Tettra suggests the relevant internal doc automatically - before anyone has to type a reply. Over time this builds a self-service culture where new hires find answers without interrupting senior colleagues, and repetitive questions get answered by the knowledge base rather than by a person. The platform is deliberately simple: pages, categories, and a search bar. There are no complex hierarchies or nested folder structures to maintain. AI-powered suggestions identify which questions are being asked repeatedly and prompt knowledge owners to document the answers. Tettra suits companies in the 20-200 employee range that want a lightweight wiki without the overhead of a full enterprise knowledge management system. It is not built for external documentation or customer-facing help centres.',
  NULL, 'https://tettra.com',
  ARRAY['productivity', 'business'], ARRAY['knowledge-management', 'wiki', 'slack-integration', 'team-productivity'],
  'freemium', 0.00,
  4.3, 620,
  false, false, false,
  ARRAY['Slack-native question answering reduces interruptions', 'Simple interface requires minimal training', 'AI identifies undocumented repeated questions', 'Good for fast-growing teams building their knowledge base'],
  ARRAY['Limited formatting compared to Notion or Confluence', 'Not designed for external or customer-facing documentation', 'Reporting and analytics are basic'],
  ARRAY['Internal FAQ and process documentation', 'Onboarding guides for new hires', 'Engineering runbooks and team wikis'],
  ARRAY['guru', 'slab', 'notion-ai']
),

(
  'slab',
  'Slab',
  'Modern team knowledge base with powerful search and clean editor',
  'Slab is a team knowledge platform that prioritises clean writing and discoverability over complex structure. The editor is polished and distraction-free, the search is fast and full-text, and the topic-based organisation makes it easy to find information without knowing exactly where it was filed. Unlike Confluence, Slab does not impose a hierarchical space-and-page model that becomes unwieldy at scale. Content is tagged with topics and surfaces through search, letting teams find what they need even if they do not know the exact location. Slab integrates with GitHub, Jira, Figma, Loom, and other tools teams already use for technical documentation. The Unified Search feature searches across Slab content and all connected integrations simultaneously, so employees can find a relevant GitHub PR, Figma design, or Loom walkthrough without switching tabs. Slab works best for engineering, product, and design teams that produce a high volume of technical documentation.',
  NULL, 'https://slab.com',
  ARRAY['productivity', 'business'], ARRAY['knowledge-management', 'wiki', 'documentation', 'team-productivity'],
  'freemium', 0.00,
  4.6, 980,
  false, false, false,
  ARRAY['Clean editor focused on writing rather than formatting complexity', 'Unified Search across Slab and connected tools', 'Topic-based organisation scales better than nested folders', 'Strong GitHub, Jira, and Figma integrations'],
  ARRAY['Less suitable for non-technical teams used to traditional wiki structure', 'No offline mode', 'Guest access limited on lower plans'],
  ARRAY['Engineering runbooks and architecture documentation', 'Product specs and decision logs', 'Cross-functional team wikis'],
  ARRAY['notion-ai', 'confluence', 'guru']
),

(
  'slite',
  'Slite',
  'Async-friendly team wiki with AI-powered knowledge retrieval',
  'Slite is a team knowledge base designed for async-first and remote teams. The platform stores internal documentation, meeting notes, project specs, and company policies in a searchable wiki that the whole team can access. The AI layer - called Ask - answers questions by searching the entire Slite workspace and returning a direct answer with a source citation rather than a list of links. This shifts knowledge retrieval from search-and-read to question-and-answer, reducing the time between having a question and getting a useful response. Slite is particularly strong for remote teams across time zones, where the cost of interrupting a colleague to ask a question is high. Documentation is the asynchronous alternative to the tap-on-the-shoulder, and Slite makes creating and finding that documentation faster than most tools in the category. The interface is clean and the editor supports rich formatting, embeds, and templates without feeling overwhelming.',
  NULL, 'https://slite.com',
  ARRAY['productivity', 'business'], ARRAY['knowledge-management', 'wiki', 'async', 'remote-work', 'ai-search'],
  'freemium', 0.00,
  4.4, 740,
  false, false, false,
  ARRAY['AI Ask feature returns direct answers with source citations', 'Optimised for async and remote team workflows', 'Clean editor with rich formatting and templates', 'Good free tier for small teams'],
  ARRAY['Less depth than Notion for complex project management', 'Mobile app experience less polished than desktop', 'Limited third-party integrations compared to Guru or Slab'],
  ARRAY['Remote team documentation hub', 'Company handbook and policy storage', 'Project retrospectives and meeting notes'],
  ARRAY['notion-ai', 'slab', 'tettra']
),

(
  'helpjuice',
  'Helpjuice',
  'AI-powered knowledge base for customer-facing support and internal wikis',
  'Helpjuice is a knowledge base platform designed for two audiences simultaneously: external customers looking for self-service answers, and internal teams managing support processes. The AI search engine analyses query patterns to identify what customers are searching for and failing to find, prompting knowledge managers to create the missing articles. Over time the gap between what customers ask and what the knowledge base answers narrows automatically. Helpjuice supports multiple knowledge bases under one account, each with its own branding, domain, and access controls. A SaaS company can run a public help centre for customers, a private wiki for the support team, and an internal HR knowledge base from the same Helpjuice account. Customisation is deep - the help centre appearance can be fully branded without engineering involvement. The analytics dashboard shows which articles get the most views, which searches return no results, and which content is driving ticket deflection.',
  NULL, 'https://helpjuice.com',
  ARRAY['productivity', 'business', 'customer-support'], ARRAY['knowledge-management', 'help-center', 'documentation', 'customer-support'],
  'paid', 120.00,
  4.3, 510,
  false, false, false,
  ARRAY['AI identifies gaps between customer searches and existing content', 'Supports internal and external knowledge bases from one account', 'Deep branding customisation without code', 'Strong ticket deflection analytics'],
  ARRAY['More expensive than alternatives at $120/month minimum', 'No free tier', 'Editor less polished than Slab or Slite for internal documentation'],
  ARRAY['Customer self-service help centre', 'Support team internal knowledge base', 'SaaS product documentation'],
  ARRAY['guru', 'document360', 'intercom']
),

(
  'document360',
  'Document360',
  'Professional knowledge base platform for product documentation and help centres',
  'Document360 is a professional knowledge base platform aimed at technical writers, product teams, and support operations that need to produce high-quality, versioned documentation at scale. The editor supports Markdown and WYSIWYG modes, the version control system tracks every edit, and the category manager handles complex multi-level hierarchies without performance degradation. AI features include Eddy - an AI search assistant that answers user questions in natural language - and AI-generated article summaries and SEO meta descriptions that reduce the time technical writers spend on non-writing tasks. Document360 integrates with Intercom, Zendesk, Freshdesk, and Drift, embedding the knowledge base directly into support chat widgets so customers find answers without leaving a conversation. The analytics layer tracks article views, search terms, failed searches, and team contribution activity.',
  NULL, 'https://document360.com',
  ARRAY['productivity', 'business', 'customer-support'], ARRAY['knowledge-management', 'documentation', 'help-center', 'technical-writing'],
  'freemium', 0.00,
  4.7, 1320,
  false, false, false,
  ARRAY['Excellent version control and article history', 'AI search returns natural language answers', 'Deep integration with Zendesk, Intercom, and Freshdesk', 'Strong analytics for measuring knowledge base performance'],
  ARRAY['Higher-tier plans needed for advanced AI features', 'Steeper learning curve for complex category structures', 'Less suitable for quick informal internal wikis'],
  ARRAY['Product documentation and API references', 'Customer self-service help centre', 'Internal process documentation for support teams'],
  ARRAY['helpjuice', 'guru', 'notion-ai']
),

(
  'bloomfire',
  'Bloomfire',
  'Searchable knowledge hub with AI that surfaces expertise across the organisation',
  'Bloomfire is a knowledge engagement platform that focuses on making expertise discoverable rather than just storing documents. Every piece of content - a PDF, a recorded webinar, a slide deck, a written post - is indexed word by word, including spoken words in video and audio files. This means a sales rep searching for competitive intelligence will surface the relevant moment inside a recorded demo call, not just a summary document. The AI search layer understands synonyms and intent, reducing the failed-search rate that plagues traditional knowledge bases. Bloomfire works well for organisations with large libraries of mixed media content: sales enablement teams with recorded calls, consulting firms with case study libraries, or L&D teams with a catalogue of recorded training sessions. The Q&A feature lets employees post questions publicly, and the AI matches the question to existing content before routing it to a human expert.',
  NULL, 'https://bloomfire.com',
  ARRAY['productivity', 'business'], ARRAY['knowledge-management', 'search', 'sales-enablement', 'team-productivity'],
  'paid', 25.00,
  4.2, 830,
  false, false, false,
  ARRAY['Full-text search including spoken words in videos and audio', 'AI surfaces expertise from mixed media content types', 'Q&A routing connects questions to relevant internal experts', 'Strong for sales enablement and L&D content libraries'],
  ARRAY['Interface feels dated compared to newer knowledge tools', 'Pricing per-user can be expensive at scale', 'Less suited to technical documentation or developer wikis'],
  ARRAY['Sales enablement and competitive intelligence', 'L&D content library management', 'Customer success knowledge sharing'],
  ARRAY['guru', 'slab', 'document360']
),

(
  'nuclino',
  'Nuclino',
  'Lightweight team wiki with graph view and real-time collaboration',
  'Nuclino is a minimal, fast team wiki that positions itself as a simpler alternative to Notion and Confluence. Pages link to each other with internal references, and the graph view visualises how knowledge connects across the workspace - similar to a personal knowledge management tool like Obsidian but designed for teams. The editor is clean and loads instantly; there are no nested databases, complex properties, or page types to learn. Real-time collaboration works well, with multiple team members editing simultaneously without conflicts. Nuclino suits teams that have been frustrated by the complexity of Notion or the administrative overhead of Confluence and want a tool that stays out of the way. The AI assistant generates text, summarises pages, and rewrites sections on request. At $6/user/month it is one of the most affordable structured wikis available.',
  NULL, 'https://nuclino.com',
  ARRAY['productivity', 'business'], ARRAY['knowledge-management', 'wiki', 'documentation', 'team-productivity'],
  'freemium', 0.00,
  4.5, 690,
  false, false, false,
  ARRAY['Graph view shows connections between knowledge pages', 'Extremely fast and lightweight compared to Notion or Confluence', 'Real-time collaboration without conflicts', 'Generous free tier and low per-user pricing'],
  ARRAY['Lacks the database and project management features of Notion', 'Less mature integration ecosystem', 'No offline mode'],
  ARRAY['Small team wikis and internal documentation', 'Research and knowledge mapping with graph view', 'Onboarding documentation for new hires'],
  ARRAY['slab', 'notion-ai', 'slite']
),

(
  'gitbook',
  'GitBook',
  'Documentation platform for developer teams with Git-based version control',
  'GitBook is the leading documentation platform for developer and engineering teams. Docs are written in Markdown or the GitBook editor, version-controlled in Git, and published as polished public or private documentation sites. The Git sync feature means technical writers and engineers can contribute via pull requests, applying the same review process to documentation changes as to code changes. GitBook AI can answer questions about any published doc set using the documentation as its source of truth - a powerful feature for developer portals where users ask highly specific API questions. Public GitBook docs are indexed by search engines and load fast on the Edge network, making them suitable for open-source project documentation, API references, and developer onboarding guides. The platform is used by companies including Segment, Vercel, and PostHog for their public developer documentation.',
  NULL, 'https://gitbook.com',
  ARRAY['productivity', 'business', 'coding'], ARRAY['documentation', 'developer-tools', 'knowledge-management', 'technical-writing'],
  'freemium', 0.00,
  4.6, 1150,
  false, false, false,
  ARRAY['Git sync enables PR-based documentation review workflows', 'AI answers questions from published documentation', 'Fast, polished public documentation sites', 'Strong open-source and developer community adoption'],
  ARRAY['Less suitable for non-technical internal wikis', 'Git sync requires familiarity with Git branching model', 'Limited template library compared to Notion or Slab'],
  ARRAY['API documentation and developer portals', 'Open-source project documentation', 'Internal engineering runbooks and architecture docs'],
  ARRAY['slab', 'notion-ai', 'document360']
),

(
  'obsidian',
  'Obsidian',
  'Local-first knowledge graph for notes and research with powerful linking',
  'Obsidian is a local-first knowledge management app that stores all notes as plain Markdown files on the user''s device. The graph view visualises how notes connect to each other through internal links, revealing relationships between ideas that a traditional folder structure would hide. Because notes are plain files, they are portable, version-controllable in Git, and readable without Obsidian. The plugin ecosystem is extensive: community plugins add AI chat, daily notes, Kanban boards, citation management, and hundreds of other capabilities. Obsidian is not a team collaboration tool in the traditional sense - it is personal knowledge management optimised for depth. Researchers, writers, engineers, and knowledge workers who process large volumes of information and need to build connections between concepts find it transformative. The Obsidian Sync service adds end-to-end encrypted syncing across devices without relying on any cloud provider having access to note content.',
  NULL, 'https://obsidian.md',
  ARRAY['productivity'], ARRAY['knowledge-management', 'notes', 'research', 'writing', 'personal-productivity'],
  'freemium', 0.00,
  4.8, 2640,
  false, false, false,
  ARRAY['Local-first storage means full data ownership and privacy', 'Graph view reveals unexpected connections between ideas', 'Massive plugin ecosystem extends functionality significantly', 'Plain Markdown files work with any text editor and Git'],
  ARRAY['Not designed for real-time team collaboration', 'Requires setup effort to configure optimally', 'Mobile experience less polished than desktop'],
  ARRAY['Personal research and knowledge management', 'Second brain and note-taking for writers and researchers', 'Technical documentation with Git version control'],
  ARRAY['notion-ai', 'nuclino', 'slab']
)

ON CONFLICT (slug) DO NOTHING;
