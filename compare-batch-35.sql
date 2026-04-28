-- compare-batch-35.sql
-- 5 comparison pairs: AI EdTech tools (theme matches batch-35)
-- All pairs use tools confirmed in DB (batch-35 confirmed run)
-- Safe to re-run: ON CONFLICT DO NOTHING + NOT EXISTS guard on criteria

-- Pair 1: khanmigo-vs-synthesis-tutor
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'khanmigo-vs-synthesis-tutor',
  'khanmigo',
  'synthesis-tutor',
  'Khanmigo vs Synthesis is the Socratic AI tutor built on Khan Academy''s curriculum library against the games-based adaptive maths platform developed from SpaceX''s school programme. Both are designed to improve student learning outcomes, but they work through fundamentally different approaches and serve different educational contexts. Khanmigo is a text-based tutoring assistant that guides students through subjects using the Socratic method - asking questions rather than providing answers - across a broad curriculum including maths, science, history, and writing. It also functions as a teacher planning tool, generating lesson plans, rubrics, and discussion prompts. Its breadth, curriculum alignment, and SAT preparation partnership with College Board make it a strong fit for K-12 classroom settings and home study across multiple subjects. Synthesis takes a narrower, deeper approach to maths. The platform is built around adaptive strategy games and collaborative problem-solving scenarios that develop mathematical reasoning and intuition rather than just arithmetic fluency. The AI adjusts in real time to each student''s performance and challenge tolerance, building confidence alongside skills. Independent efficacy data supports meaningful learning gains. The choice is primarily about scope: families and teachers who need broad curriculum support across subjects should look at Khanmigo. Families whose primary goal is building mathematical confidence and problem-solving ability in children aged 6-14 will find Synthesis more focused and more effective for that specific outcome.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'khanmigo-vs-synthesis-tutor', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Subject and curriculum breadth', 5, 2, 'Khanmigo covers maths, science, history, literature, writing, and SAT prep across the full K-12 curriculum. Synthesis focuses exclusively on maths and mathematical reasoning - it does not cover other subjects.'),
  ('Maths learning effectiveness', 4, 5, 'Synthesis''s games-based adaptive approach builds mathematical intuition and problem-solving confidence with strong independent efficacy data. Khanmigo''s Socratic tutoring is effective for maths but is a broader tool not optimised specifically for the depth of engagement Synthesis provides.'),
  ('Student engagement and motivation', 3, 5, 'Synthesis is designed from the ground up for student engagement - adaptive challenge, competitive elements, and collaborative puzzles maintain motivation for 6-14 year olds. Khanmigo is more task-oriented and text-based, which suits motivated students but may be less engaging for resistant learners.'),
  ('Teacher and classroom tools', 5, 2, 'Khanmigo includes dedicated teacher tools - lesson planning, rubric generation, discussion prompt creation, and quiz building. Synthesis provides parent and teacher progress dashboards but is not designed as a classroom management tool.'),
  ('Parent and teacher visibility', 3, 5, 'Synthesis provides detailed session data, skill progression tracking, and engagement metrics for parents and teachers. Khanmigo provides progress tracking within Khan Academy''s existing framework, which is good but less granular at the individual session level.'),
  ('Pricing and accessibility', 4, 2, 'Khanmigo is available for $4/month per student, one of the most affordable AI tutoring options available. Synthesis starts at $22/month per student, reflecting its more focused product and independent development. Both require paid subscriptions; neither offers a meaningful free tier.'),
  ('Safe use with minors', 5, 4, 'Khanmigo is built with explicit safeguards for student use including content filtering and age-appropriate responses, making it among the most school-deployable AI tutors available. Synthesis is a closed, purpose-built platform with appropriate child safety measures, though it is not specifically marketed as classroom-deployable.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'khanmigo-vs-synthesis-tutor')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'khanmigo-vs-synthesis-tutor');

-- Pair 2: schoolai-vs-curipod
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'schoolai-vs-curipod',
  'schoolai',
  'curipod',
  'SchoolAI vs Curipod represents two different answers to the question of how AI should enter the K-12 classroom. SchoolAI is a compliance-first AI deployment platform: teachers configure AI-powered learning spaces with defined guardrails, students interact within those boundaries, and teachers maintain full visibility through a centralised monitoring dashboard. The product''s primary value proposition is safe, controlled AI access - COPPA and FERPA compliance, full conversation visibility, and configurable behaviour per assignment. It is the platform for districts that want to give students AI access without the risks of unsupervised general AI tools. Curipod is a lesson creation tool. Teachers enter a topic, grade level, and objective, and the AI generates a complete interactive lesson with slides, discussion prompts, polls, drawing activities, and exit tickets. Students join and participate in real time. The focus is on reducing teacher preparation time and increasing classroom engagement through interactive content, not on managing AI safety. The two tools are not direct competitors - they address different parts of the teaching workflow. SchoolAI is the right choice when a district needs a compliant, monitored environment for student AI interaction. Curipod is the right choice when a teacher needs to build and deliver interactive lessons quickly. Many schools use both: Curipod for rapid lesson creation and classroom delivery, SchoolAI for structured student AI access within curriculum activities.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'schoolai-vs-curipod', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Compliance and student safety controls', 5, 3, 'SchoolAI is purpose-built for COPPA and FERPA compliance with full teacher visibility into all student AI interactions. Curipod is a teacher-facing lesson tool - student interaction is with the lesson''s activities, not an open AI conversation, reducing but not eliminating compliance considerations.'),
  ('Interactive lesson creation speed', 2, 5, 'Curipod generates a full interactive lesson with slides, activities, and exit tickets from a single prompt in minutes. SchoolAI requires teachers to configure learning spaces and guardrails before students access them - it is not a lesson creation tool.'),
  ('Real-time student participation', 3, 5, 'Curipod''s real-time polling, word clouds, and drawing activities create immediate visible participation during class. SchoolAI''s student-facing AI interaction is more asynchronous and task-based.'),
  ('Teacher monitoring and oversight', 5, 3, 'SchoolAI''s dashboard provides centralised visibility into all student AI interactions in real time. Curipod shows teachers aggregated response data from lesson activities but does not provide individual conversation monitoring.'),
  ('Formative assessment integration', 3, 5, 'Curipod embeds multiple formative assessment activity types directly into the lesson flow. SchoolAI supports teacher-designed assessment activities but assessment is not the core product focus.'),
  ('LMS and school system integration', 4, 3, 'SchoolAI integrates with Google Classroom and Microsoft Teams. Curipod supports basic LMS sharing and export. Neither offers deep LMS gradebook integration.'),
  ('Free plan value for individual teachers', 4, 5, 'Curipod''s free tier covers most individual teacher use cases with minimal restrictions. SchoolAI has a free individual teacher plan but the compliance and oversight features that make it valuable for districts require paid plans.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'schoolai-vs-curipod')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'schoolai-vs-curipod');

-- Pair 3: brisk-teaching-vs-magicschool-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'brisk-teaching-vs-magicschool-ai',
  'brisk-teaching',
  'magicschool-ai',
  'Brisk Teaching vs MagicSchool AI is the Chrome extension approach against the standalone AI teaching platform. Both are designed to save teachers time on the preparation and feedback tasks that consume hours outside the classroom, but they differ significantly in workflow philosophy. Brisk Teaching is built entirely around the Chrome extension model: it adds AI capabilities inside Google Docs, Google Slides, Google Forms, and YouTube without switching to a new application. Highlight student work in Google Docs to get instant feedback suggestions; open a YouTube video to generate a quiz. The tool meets teachers inside the workflows they already use, making adoption essentially frictionless for Google Workspace schools. MagicSchool AI is a dedicated platform with a broader suite of AI tools accessible from a single dashboard. The tool count is extensive - over 60 AI tools covering lesson planning, assessment creation, IEP support, email drafting, behaviour management letters, rubric creation, and more. The breadth of MagicSchool''s offering means teachers can address nearly any preparation task in one place, with purpose-built templates and guided workflows for each use case. The choice comes down to workflow preference. Teachers who want AI that works inside their existing tools without context-switching will prefer Brisk. Teachers who want a comprehensive AI toolkit they can reach for across the full range of preparation tasks will find MagicSchool''s broader suite more useful.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'brisk-teaching-vs-magicschool-ai', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Adoption friction and setup', 5, 3, 'Brisk Teaching installs as a Chrome extension and activates inside Google tools immediately - no new platform, no account setup beyond the extension. MagicSchool requires teachers to learn a new interface and switch to a separate application for each use.'),
  ('Feature breadth', 3, 5, 'MagicSchool offers 60+ AI tools covering lesson plans, assessments, IEPs, differentiation, rubrics, parent emails, behaviour support, and more. Brisk''s feature set is focused on feedback, quiz creation, and lesson planning within the browser context.'),
  ('Feedback on student work', 5, 4, 'Brisk Teaching''s core strength is generating detailed feedback on student writing directly inside Google Docs with a single click. MagicSchool includes feedback tools but the browser extension integration makes Brisk notably faster for this specific workflow.'),
  ('Lesson planning capability', 3, 5, 'MagicSchool''s lesson planning templates are more structured and cover more curriculum frameworks with dedicated guided workflows. Brisk''s lesson planning is solid but more generic.'),
  ('Special education and IEP support', 1, 5, 'MagicSchool has dedicated tools for IEP drafting, differentiation plans, and special education documentation. Brisk Teaching does not have specific SPED-focused features.'),
  ('Google Workspace integration', 5, 2, 'Brisk Teaching operates entirely within Google Docs, Slides, Forms, and YouTube. MagicSchool integrates with Google Classroom for assignment import but does not work inside Google Docs directly.'),
  ('Free plan value', 4, 4, 'Both platforms offer meaningful free plans for individual teachers. MagicSchool''s free plan covers most of its core tools. Brisk''s free plan covers common classroom workflows with some per-use credit limits.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'brisk-teaching-vs-magicschool-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'brisk-teaching-vs-magicschool-ai');

-- Pair 4: nearpod-vs-classpoint
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'nearpod-vs-classpoint',
  'nearpod',
  'classpoint',
  'Nearpod vs ClassPoint is the standalone synchronised lesson platform against the PowerPoint add-in - two different models for adding student interactivity to classroom instruction. Nearpod is a dedicated lesson delivery system. Teachers build or import interactive lessons in Nearpod''s editor, and students follow along on their own devices, participating in polls, quizzes, drawing activities, collaborative boards, and VR field trips embedded in the lesson flow. Nearpod has its own lesson creation interface, a large library of pre-built teacher-created content, and integrations with Google Classroom, Canvas, and Schoology. For teachers willing to build or import lessons into Nearpod''s system, the payoff is access to a broader range of engagement features and the VR content library. ClassPoint takes the opposite approach. It is a PowerPoint add-in that adds interactive question slides directly into existing PowerPoint presentations. Teachers do not rebuild their content - they add ClassPoint slides into the decks they already have. The AI quiz generation from slide content, gamification layer, and participation tracking work within the PowerPoint environment teachers already know. For educators with years of PowerPoint material who want engagement without migration, ClassPoint is the natural choice. For educators starting fresh or building curriculum specifically for interactive delivery, Nearpod''s content library and broader feature set offer more. The deciding factor is usually whether the teacher has an existing PowerPoint library they want to keep.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'nearpod-vs-classpoint', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Compatibility with existing content', 2, 5, 'ClassPoint adds interactivity directly to existing PowerPoint files - no migration or rebuild required. Nearpod requires content to be built or imported into its own system, which involves some rework of existing materials.'),
  ('VR and immersive content', 5, 1, 'Nearpod''s 360-degree virtual field trips and 3D simulations are a unique feature with no equivalent in ClassPoint. For geography, science, and history teachers wanting immersive content, Nearpod is the only option.'),
  ('Student engagement activity types', 5, 4, 'Nearpod supports polls, quizzes, drawing, collaborative boards, simulations, and VR. ClassPoint supports multiple choice, short answer, word cloud, image upload, and drawing. Both cover the core types; Nearpod has greater variety.'),
  ('LMS integration depth', 5, 2, 'Nearpod integrates with Google Classroom, Canvas, Schoology, and most major LMS platforms with grade passback. ClassPoint is a PowerPoint add-in and does not have native LMS integration.'),
  ('Pre-built lesson content library', 5, 2, 'Nearpod has a large library of pre-built teacher-created lessons across K-12 subjects that teachers can use or adapt. ClassPoint does not offer a content library.'),
  ('AI quiz generation from content', 3, 5, 'ClassPoint''s AI automatically generates quiz questions from the content of an existing PowerPoint slide in seconds. Nearpod has AI content generation but it is not as tightly integrated with existing slide content.'),
  ('Gamification and engagement mechanics', 3, 5, 'ClassPoint''s points, leaderboards, and class roster system are purpose-built for the gamified classroom. Nearpod has quiz and game modes but ClassPoint''s gamification is more central to the product experience.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'nearpod-vs-classpoint')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'nearpod-vs-classpoint');

-- Pair 5: diffit-vs-conker
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
VALUES (
  'diffit-vs-conker',
  'diffit',
  'conker',
  'Diffit vs Conker are two focused AI tools for teachers that solve adjacent but distinct problems. Diffit is a reading differentiation tool - it takes an article, document, or topic and generates multiple versions of the same content adapted to different reading levels, each with matching comprehension questions, vocabulary lists, and graphic organisers. The core use case is mixed-ability classrooms and ELL support, where producing separate levelled materials for different student groups traditionally takes hours. Conker is a quiz and formative assessment generator - it takes a topic, document, or learning objective and produces multiple choice, true/false, short answer, and open response questions that teachers can share with students via a direct link in seconds. The two tools are complementary rather than competitive. A teacher might use Diffit to create a differentiated reading activity on photosynthesis, then use Conker to generate a quick comprehension check at the end of the lesson. Where they overlap is in comprehension question generation from text materials - both can create questions from a given reading, but with different outputs and depth. Diffit''s comprehension questions are levelled and tied to the adapted text, making them better for assessment within the differentiation workflow. Conker''s questions are faster to generate, more varied in format, and better suited to standalone quiz deployment via link. For teachers who primarily need differentiated reading materials, Diffit is the clear choice. For teachers who primarily need quick formative assessment quizzes across any topic, Conker is the faster and more flexible tool.',
  NULL,
  NOW()
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'diffit-vs-conker', name, tool_a_score, tool_b_score, notes
FROM (VALUES
  ('Reading level differentiation', 5, 1, 'Diffit''s primary function is generating multiple versions of the same content at different reading levels. Conker does not offer reading level adaptation - it generates questions at a single difficulty level.'),
  ('Speed from prompt to deployable activity', 3, 5, 'Conker generates a shareable quiz from a topic or document in under a minute with a direct student link. Diffit generates comprehensive differentiated materials, which is faster than manual creation but produces more content and takes slightly longer to review.'),
  ('Question type variety', 3, 5, 'Conker supports multiple choice, true/false, short answer, open response, and Bloom''s Taxonomy targeting across question types. Diffit''s comprehension questions are more narrowly focused on reading comprehension at the matched level.'),
  ('ELL and multilingual support', 5, 2, 'Diffit generates content in multiple languages and at reduced complexity levels specifically for English language learners. Conker does not have dedicated ELL support features.'),
  ('Google Classroom integration', 3, 5, 'Conker supports direct Google Classroom import for distributing quizzes as assignments within existing class structures. Diffit supports export and sharing but does not have direct Google Classroom push.'),
  ('Supplementary material generation', 5, 2, 'Diffit generates vocabulary lists, graphic organisers, fill-in-the-blank activities, and discussion questions alongside the differentiated texts. Conker is focused on question generation and does not produce supplementary reading materials.'),
  ('Free plan value', 4, 4, 'Both tools offer free tiers that cover most core use cases for individual teachers. Diffit''s free plan covers levelled text generation with some creation limits. Conker''s free plan covers quiz generation with limits on question count and advanced types.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'diffit-vs-conker')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'diffit-vs-conker');
