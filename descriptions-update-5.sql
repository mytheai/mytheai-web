-- descriptions-update-5.sql - Descriptions for tools-batch-13 tools
-- Run in Supabase SQL Editor after tools-batch-13.sql
-- Plain prose, 2 paragraphs each, 150-250 words

UPDATE tools SET description = 'Taskade is an all-in-one AI productivity platform that combines task management, project planning, mind mapping, and real-time collaboration in a single workspace. Powered by its native AI agent, Taskade can generate project outlines, create tasks from prompts, write content, and automate workflows across your entire team.

Teams use Taskade to plan sprints, manage OKRs, brainstorm ideas, and keep everyone aligned. Its AI can summarize meetings, draft emails, and break down complex projects into actionable steps. With cross-platform support and a generous free tier, Taskade suits startups, remote teams, and solo creators who want project management and AI assistance in one place.'
WHERE slug = 'taskade';

UPDATE tools SET description = 'Sudowrite is a creative writing AI designed from the ground up for novelists, screenwriters, and storytellers. Unlike general-purpose writing tools, Sudowrite understands narrative structure, character development, and prose style. Its Describe feature generates sensory-rich descriptions, Brainstorm generates plot ideas, and Write helps you push through writer''s block with style-matched continuations.

Writers use Sudowrite to draft chapters, rewrite scenes in different tones, explore alternative story directions, and develop characters with depth. It learns your writing style to maintain consistency across a manuscript. The tool has become essential for authors working on long-form fiction, where maintaining voice and continuity is critical to reader experience.'
WHERE slug = 'sudowrite';

UPDATE tools SET description = 'Lex is a minimalist AI writing tool focused on helping writers think and draft without distraction. Built around a clean, Google Docs-like interface, Lex features an AI that you summon by typing "+++" when you get stuck. It completes your thought, suggests next sentences, or offers alternative phrasings entirely on demand - never interrupting your flow uninvited.

Writers and professionals use Lex for essays, blog posts, reports, and long-form content where focus and clarity matter. Its commenting and sharing features make it viable for collaborative editing. Lex is intentionally simple: no overwhelming sidebar, no complex menus, just you and your writing with AI available when you need it.'
WHERE slug = 'lex';

UPDATE tools SET description = 'Podcastle is an all-in-one podcast production platform that uses AI to simplify every step of the podcasting process. From browser-based recording with remote guests to AI-powered editing, noise removal, and audio restoration, Podcastle handles the technical complexity so creators can focus on content.

Podcasters use Podcastle to record studio-quality audio directly in their browser, automatically remove filler words and silences, and convert recordings into polished episodes ready for distribution. Its AI voice cloning feature lets hosts record voiceovers in their own cloned voice. The platform supports both solo podcasters and multi-host shows with separate audio tracks per guest.'
WHERE slug = 'podcastle';

UPDATE tools SET description = 'Castmagic is an AI-powered content repurposing platform that turns your audio and video recordings into ready-to-use content assets. Upload a podcast episode, webinar, or video call and Castmagic generates show notes, blog posts, social media clips, email newsletters, and transcripts automatically - all from a single recording.

Content creators, podcasters, and marketers use Castmagic to multiply the value of every piece of content they produce. Instead of manually writing show notes or pulling quotes for social media, Castmagic analyzes the full recording and produces dozens of content pieces in minutes. It supports multiple output templates and lets you define your own content formats using custom prompts for complete control.'
WHERE slug = 'castmagic';

UPDATE tools SET description = 'Typeframes is an AI video creation tool that converts text, scripts, and ideas into polished animated videos. Designed for product teams and marketers, Typeframes specializes in product demos, explainer videos, and social media content. Paste your script or a URL and the AI generates motion graphics, text animations, and smooth transitions ready for export.

Teams use Typeframes to create product launch videos, feature announcements, and marketing content without hiring a video editor. The tool integrates brand colors, logos, and fonts to maintain consistency across campaigns. Export options include vertical formats for TikTok and Instagram Reels, making it practical for social media marketing teams that need to publish video content regularly.'
WHERE slug = 'typeframes';

UPDATE tools SET description = 'MagicSchool AI is the leading AI productivity platform built specifically for educators. Teachers use it to generate lesson plans, rubrics, assignments, quiz questions, email drafts for parents, IEP accommodations, and differentiated materials - all from simple text prompts. The platform offers over 60 AI tools tailored to the specific needs of K-12 and higher education.

School districts adopt MagicSchool AI to reduce teacher planning time while maintaining educational quality. Unlike generic AI tools, MagicSchool understands pedagogical frameworks, grade-level language, and Common Core standards. The student version helps learners with reading comprehension and study skills without doing assignments for them, maintaining academic integrity while still providing meaningful support.'
WHERE slug = 'magicschool-ai';

UPDATE tools SET description = 'Merlin is a browser extension that brings AI assistance to any webpage you visit. Highlight text to get instant explanations, summaries, or translations. Open the sidebar to chat with Claude, GPT-4, or Gemini while browsing without switching tabs. Ask Merlin to summarize YouTube videos, draft replies to emails in Gmail, or explain complex articles as you read them.

Professionals and students use Merlin to accelerate research, understand dense content, and compose messages faster. The extension supports multiple AI models so you can choose Claude for nuanced writing or GPT-4 for technical tasks. Its YouTube summary feature is particularly popular for quickly extracting key points from long videos before deciding whether to watch in full.'
WHERE slug = 'merlin';

UPDATE tools SET description = 'Reflect is a note-taking and knowledge management app that uses AI to help you think better and remember more. Built around networked thinking, Reflect automatically creates backlinks between related notes, building a personal knowledge graph over time. Its AI assistant can summarize notes, generate meeting agendas from your calendar, and help you surface connections between ideas you wrote months apart.

Knowledge workers, writers, and researchers use Reflect to capture fleeting thoughts, organize research, and surface insights from their note archive. The AI can query your entire note collection to answer questions based on your own writing. Daily note templates and calendar integration make it a powerful system for personal knowledge management and structured daily journaling.'
WHERE slug = 'reflect';

UPDATE tools SET description = 'Anytype is an open-source, local-first knowledge management platform that stores your data on your device rather than in the cloud. It offers blocks, databases, wikis, and task management similar to Notion, but with end-to-end encryption and offline-first architecture. AI features help you write, summarize, and organize content within your private workspace.

Privacy-conscious users, developers, and researchers choose Anytype because they want the power of a modern knowledge tool without sending their data to a third-party server. The peer-to-peer sync lets you share workspaces without a central server. Its object-based data model is more flexible than traditional document editors, supporting complex knowledge graphs and custom data types for power users who have outgrown other tools.'
WHERE slug = 'anytype';
