-- compare-batch-60.sql
-- 5 education / EdTech comparison pairs
-- All tool slugs confirmed from tools-batch-60.sql (added in Session 74)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. photomath-vs-mathgpt (AI math tutoring tools)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'photomath-vs-mathgpt',
  'photomath',
  'mathgpt',
  'Photomath and MathGPT are the two leading AI math tutoring tools in 2026, but they serve different learning styles. Photomath is built around instant scan-and-solve: photograph any printed or handwritten math problem and receive a step-by-step solution with explanations immediately. MathGPT takes a conversational approach, functioning as a dialogue partner that explains concepts in multiple ways, checks student work rather than just solving it, and adapts to the learner''s specific conceptual gaps. Students who want fast, accurate answers on homework will prefer Photomath. Students who want to understand the underlying mathematics more deeply will get more from MathGPT''s tutoring dialogue.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'photomath-vs-mathgpt');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'photomath-vs-mathgpt', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Speed of Answer',           5, 3, 'Photomath returns solutions in seconds; MathGPT takes conversational turns'),
  ('Conceptual Explanation',    3, 5, 'MathGPT explains the why more deeply through guided dialogue'),
  ('Subject Coverage',          4, 4, 'Both cover algebra through calculus; Photomath stronger on geometry'),
  ('Free Plan Availability',    4, 3, 'Photomath core is free; MathGPT free tier has monthly query limits'),
  ('Handwriting Recognition',   5, 1, 'Photomath recognises handwritten problems via camera; MathGPT is text only'),
  ('Adaptive Tutoring',         2, 5, 'MathGPT adapts to student gaps through back-and-forth dialogue'),
  ('Mobile Experience',         5, 3, 'Photomath is purpose-built mobile; MathGPT is primarily web-based')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'photomath-vs-mathgpt')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'photomath-vs-mathgpt');

-- 2. coursera-coach-vs-socratic (AI learning assistance tools)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'coursera-coach-vs-socratic',
  'coursera-coach',
  'socratic',
  'Coursera Coach and Socratic represent two different models of AI learning assistance in 2026. Coursera Coach is deeply contextual - it is trained on specific course content and understands what a learner has already studied, enabling highly relevant guidance tied to the actual material. Socratic by Google is broader and free - it handles questions across subjects for high school and early university students using visual explanations and YouTube video resources. Learners enrolled in Coursera courses will get more value from Coach. Students looking for free homework help across any subject will find Socratic more accessible.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'coursera-coach-vs-socratic');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'coursera-coach-vs-socratic', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Context Awareness',         5, 2, 'Coursera Coach is trained on specific course content; Socratic is generic'),
  ('Free Access',               2, 5, 'Socratic is completely free; Coursera Coach requires Plus subscription'),
  ('Subject Coverage',          3, 5, 'Socratic covers all subjects; Coach is limited to Coursera catalog'),
  ('Explanation Quality',       4, 4, 'Both provide strong explanations; Coach is more course-specific'),
  ('Visual Learning Support',   2, 5, 'Socratic returns diagrams and YouTube videos; Coach is text-focused'),
  ('Study Planning',            4, 1, 'Coursera Coach generates personalised study plans; Socratic does not'),
  ('Enterprise / L and D Use',  5, 1, 'Coursera Coach available in Coursera for Business; Socratic is consumer')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'coursera-coach-vs-socratic')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'coursera-coach-vs-socratic');

-- 3. quizlet-q-chat-vs-kahoot-ai (study and review engagement tools)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'quizlet-q-chat-vs-kahoot-ai',
  'quizlet-q-chat',
  'kahoot-ai',
  'Quizlet Q-Chat and Kahoot AI both use AI to make studying and review more effective in 2026, but they operate in different contexts. Quizlet Q-Chat is for individual students studying independently - the AI asks Socratic questions based on flashcard sets to drive active recall rather than passive review. Kahoot AI is for live classroom review - the AI generates quiz questions from a topic or document so teachers can run engaging competitive games in real time. The two tools are often complementary rather than competing: students use Quizlet Q-Chat to study alone, teachers use Kahoot AI to review with the whole class.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'quizlet-q-chat-vs-kahoot-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'quizlet-q-chat-vs-kahoot-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Question Generation',    4, 5, 'Kahoot AI generates questions from any topic or document upload instantly'),
  ('Individual Study Support',  5, 1, 'Quizlet Q-Chat is designed for solo adaptive studying; Kahoot is group-only'),
  ('Classroom Engagement',      1, 5, 'Kahoot game mechanics create live classroom energy Q-Chat cannot match'),
  ('Active Recall Mechanism',   5, 3, 'Q-Chat Socratic method drives deeper active recall than timed quiz format'),
  ('Teacher Time Savings',      2, 5, 'Kahoot AI eliminates 20-30 min quiz creation per session for teachers'),
  ('Free Plan Value',           3, 4, 'Both have free plans; Kahoot free plan supports basic game creation'),
  ('Setup Friction',            3, 5, 'Kahoot games run in seconds; Quizlet requires existing flashcard sets')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'quizlet-q-chat-vs-kahoot-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'quizlet-q-chat-vs-kahoot-ai');

-- 4. gradescope-ai-vs-eduaide-ai (teacher productivity tools)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'gradescope-ai-vs-eduaide-ai',
  'gradescope-ai',
  'eduaide-ai',
  'Gradescope AI and Eduaide AI both save teachers significant time, but at different stages of the teaching workflow. Gradescope AI focuses on the back end: using machine learning to group similar student responses and apply rubrics at scale, reducing grading time by up to 80% for large classes. Eduaide AI focuses on the front end: generating lesson plans, rubrics, differentiated materials, and parent communications from a topic description, compressing preparation time significantly. University instructors with large classes will get the highest ROI from Gradescope. K-12 teachers spending 3-5 hours per week on planning and admin will get more from Eduaide.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gradescope-ai-vs-eduaide-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'gradescope-ai-vs-eduaide-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Grading Time Reduction',    5, 2, 'Gradescope AI groups responses and applies rubrics to cut grading by 80%'),
  ('Lesson Planning Support',   1, 5, 'Eduaide generates complete lesson plans from a topic or standard'),
  ('Differentiation Features',  1, 5, 'Eduaide creates materials at multiple reading levels for diverse learners'),
  ('Handwriting Recognition',   5, 1, 'Gradescope reads handwritten exams and assignments; Eduaide does not'),
  ('Free Plan Availability',    4, 4, 'Both offer free plans for individual educators with core functionality'),
  ('K-12 vs University Fit',    3, 4, 'Eduaide fits K-12 better; Gradescope fits university large-class grading'),
  ('Assessment Analytics',      5, 2, 'Gradescope surfaces which questions caused widespread confusion in class')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gradescope-ai-vs-eduaide-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'gradescope-ai-vs-eduaide-ai');

-- 5. nearpod-ai-vs-edpuzzle-ai (interactive classroom video tools)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'nearpod-ai-vs-edpuzzle-ai',
  'nearpod-ai',
  'edpuzzle-ai',
  'Nearpod AI and Edpuzzle AI both make classroom content more interactive in 2026, but with different primary formats. Nearpod AI builds complete interactive slide-based lessons with polls, open questions, VR experiences, and drawing activities - AI assists in generating the full lesson structure and embedded checks. Edpuzzle AI specialises in making video content interactive by embedding questions, notes, and comprehension checks directly into video clips from YouTube or teacher uploads. Teachers who want to build full interactive lessons from scratch will prefer Nearpod. Teachers who want to use existing video content more effectively will find Edpuzzle more focused and faster to set up.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'nearpod-ai-vs-edpuzzle-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'nearpod-ai-vs-edpuzzle-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Video Interactivity',       2, 5, 'Edpuzzle is purpose-built for embedding questions into video clips'),
  ('Full Lesson Creation',      5, 2, 'Nearpod AI generates complete multi-activity interactive lessons'),
  ('AI Question Generation',    4, 4, 'Both use AI to generate comprehension questions from content'),
  ('Setup Speed',               3, 5, 'Edpuzzle lets teachers embed questions into any YouTube video in minutes'),
  ('Student Data Granularity',  4, 4, 'Both provide per-student response data during and after the lesson'),
  ('Free Plan Value',           4, 4, 'Both have free plans covering core functionality for individual teachers'),
  ('VR and Simulation Features',5, 1, 'Nearpod has virtual reality experiences; Edpuzzle is video-only')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'nearpod-ai-vs-edpuzzle-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'nearpod-ai-vs-edpuzzle-ai');
