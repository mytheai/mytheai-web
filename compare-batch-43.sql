-- compare-batch-43.sql
-- 5 LMS / E-Learning comparison pairs
-- All tools from tools-batch-43 (confirmed in DB)
-- Run AFTER tools-batch-43 confirmed in Supabase

-- 1. articulate-360-vs-ispring-suite
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'articulate-360-vs-ispring-suite', 'articulate-360', 'ispring-suite',
  'Articulate 360 is the industry-standard e-learning authoring suite used by professional instructional designers worldwide. iSpring Suite converts PowerPoint presentations into interactive courses with dialogue simulations, making it ideal for teams already comfortable with PowerPoint. Articulate wins on depth and interactivity; iSpring wins on approachability and price. The choice comes down to whether your L&D team includes dedicated instructional designers (Articulate) or relies on subject matter experts working in familiar tools (iSpring).',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'articulate-360-vs-ispring-suite');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'articulate-360-vs-ispring-suite', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Authoring Depth', 5, 3, 'Articulate Storyline 360 supports custom JavaScript, triggers, and complex branching scenarios that iSpring cannot match. iSpring is limited to PowerPoint-based interactivity.'),
  ('Ease of Use', 3, 5, 'iSpring works inside PowerPoint - zero new interface to learn. Articulate Storyline has a significant learning curve; Rise 360 is simpler but less powerful.'),
  ('SCORM / xAPI Output', 5, 5, 'Both tools export industry-standard SCORM 1.2, SCORM 2004, and xAPI packages that load into any LMS.'),
  ('AI Features', 3, 3, 'Articulate offers AI text generation and auto-translation across 20 languages. iSpring offers TalkMaster dialogue simulation AI. Neither has deep generative AI course creation.'),
  ('Pricing', 2, 4, 'Articulate 360 starts at $108/user/month. iSpring Suite starts at $64/user/month. Both require annual subscriptions.'),
  ('Template Library', 4, 3, 'Articulate Content Library includes 9 million stock assets. iSpring relies on PowerPoint templates and its own smaller asset library.'),
  ('Bundled LMS', 2, 4, 'Articulate does not include an LMS - content must be hosted on a third-party platform. iSpring Suite bundles iSpring Learn LMS for an additional fee.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'articulate-360-vs-ispring-suite')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'articulate-360-vs-ispring-suite');

-- 2. docebo-vs-360learning
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'docebo-vs-360learning', 'docebo', '360learning',
  'Docebo is an AI-powered enterprise LMS that drives personalised learning recommendations at scale for large, top-down L&D programmes. 360Learning flips the model - subject matter experts build content collaboratively, and AI accelerates their authoring. Docebo suits centralised L&D teams managing formal training at scale; 360Learning suits fast-moving organisations where knowledge lives with frontline experts who need to keep training current without bottlenecking through a central team.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'docebo-vs-360learning');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'docebo-vs-360learning', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Personalisation', 5, 3, 'Docebo Shape generates courses from documents and URLs; its recommendation engine personalises learning paths based on role and behaviour. 360Learning Bella AI assists authoring but does not personalise delivery to the same depth.'),
  ('Collaborative Authoring', 2, 5, '360Learning is purpose-built for collaborative authoring - any employee can create a course, peers rate content, and experts update it in real time. Docebo supports collaborative features but they are secondary to the central L&D workflow.'),
  ('Enterprise Scalability', 5, 3, 'Docebo handles hundreds of thousands of learners across complex org structures with multi-tenant portals, advanced reporting, and SSO. 360Learning scales well but is better suited to companies under 5,000 employees.'),
  ('Content Marketplace', 5, 2, 'Docebo integrates with LinkedIn Learning, Coursera, Skillsoft, and other providers for instant access to off-the-shelf content. 360Learning has a marketplace but far fewer options.'),
  ('Pricing', 2, 4, 'Docebo is custom enterprise pricing - typically $25,000 annually and above. 360Learning starts at $8/user/month making it accessible to growing companies.'),
  ('Time to Value', 3, 5, '360Learning can be deployed and producing courses in days. Docebo enterprise implementations typically take weeks to months with professional services.'),
  ('Analytics and Reporting', 5, 3, 'Docebo offers advanced learning analytics, skills gap analysis, and business impact reporting. 360Learning reporting covers engagement and peer ratings but lacks the depth of Docebo.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'docebo-vs-360learning')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'docebo-vs-360learning');

-- 3. talentlms-vs-absorb-lms
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'talentlms-vs-absorb-lms', 'talentlms', 'absorb-lms',
  'TalentLMS is the go-to LMS for small and mid-size businesses that want fast setup, a free tier, and straightforward administration. Absorb LMS targets the mid-market with a more polished interface and AI-powered admin automation. TalentLMS wins on price and simplicity for smaller teams; Absorb wins on UI quality, HRIS integrations, and automated administration for organisations with dedicated HR operations teams.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'talentlms-vs-absorb-lms');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'talentlms-vs-absorb-lms', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Ease of Setup', 5, 4, 'TalentLMS is famous for fast deployment - most admins have a working training environment within hours. Absorb LMS setup is straightforward but typically requires more configuration for HRIS integrations.'),
  ('Pricing', 5, 3, 'TalentLMS offers a free plan (5 users, 10 courses) and paid plans from $69/month. Absorb LMS uses custom pricing - typically more expensive, suited to organisations with 200 or more learners.'),
  ('Interface Quality', 3, 5, 'Absorb has one of the most polished learner interfaces in the mid-market. TalentLMS is functional and clean but less visually refined.'),
  ('AI Administration', 3, 5, 'Absorb Intelligent Assist automates routine admin tasks - drafting emails, generating reports, suggesting learning paths. TalentCraft in TalentLMS generates course content but does not match Absorb for admin automation.'),
  ('HRIS Integrations', 3, 5, 'Absorb integrates natively with Workday, BambooHR, ADP, and UKG for automatic user provisioning. TalentLMS supports integrations via API and Zapier but lacks native HRIS connectors.'),
  ('eCommerce', 4, 4, 'Both platforms support selling courses externally. TalentLMS has a built-in store with Stripe and PayPal. Absorb eCommerce is similarly capable with more enterprise payment options.'),
  ('Gamification', 5, 3, 'TalentLMS has comprehensive gamification out of the box - points, badges, levels, and leaderboards. Absorb supports basic badges and certificates but gamification is less central to the product.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'talentlms-vs-absorb-lms')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'talentlms-vs-absorb-lms');

-- 4. skilljar-vs-learnupon
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'skilljar-vs-learnupon', 'skilljar', 'learnupon',
  'Skilljar is purpose-built for customer and partner education - training external audiences to adopt products and certify resellers. LearnUpon is a multi-audience LMS that handles employees, customers, and partners from one platform with strong Salesforce integration. Skilljar wins on customer education depth and business impact analytics; LearnUpon wins on internal-external flexibility and accessible mid-market pricing.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'skilljar-vs-learnupon');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'skilljar-vs-learnupon', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Customer Education Focus', 5, 3, 'Skilljar is exclusively designed for external audiences. Its analytics track training impact on product adoption and churn reduction. LearnUpon supports customer portals but its core strength is multi-audience flexibility.'),
  ('Multi-Audience Portals', 3, 5, 'LearnUpon allows unlimited portals with separate branding, content libraries, and reporting for employees, partners, and customers. Skilljar is single-audience - external learners only.'),
  ('Salesforce Integration', 4, 5, 'LearnUpon has deep, native Salesforce integration - training data flows into Opportunity, Contact, and Account records. Skilljar integrates with Salesforce but LearnUpon is the preferred choice for Salesforce-centric revenue teams.'),
  ('Certification Programmes', 5, 4, 'Skilljar is optimised for partner and customer certification - custom certificates, expiry management, and Credly digital badge integration. LearnUpon supports certificates but with less sophistication.'),
  ('Business Impact Analytics', 5, 3, 'Skilljar tracks which training correlates with NRR improvement, lower support tickets, and higher CSAT. LearnUpon reports on completion rates and engagement but does not tie directly to revenue metrics.'),
  ('Pricing', 2, 3, 'Neither platform publishes pricing. Skilljar typically runs $20,000 annually and above with no self-serve option. LearnUpon starts at $699/month for 150 users - accessible to mid-market companies.'),
  ('Internal Employee Training', 1, 5, 'Skilljar is designed only for external learners - it cannot effectively run internal employee training. LearnUpon handles both with equal capability.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'skilljar-vs-learnupon')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'skilljar-vs-learnupon');

-- 5. cornerstone-ondemand-vs-docebo
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'cornerstone-ondemand-vs-docebo', 'cornerstone-ondemand', 'docebo',
  'Cornerstone OnDemand is a legacy enterprise talent management suite with one of the broadest content libraries and most comprehensive HR module sets available. Docebo is a modern, AI-native LMS that delivers faster implementation, a cleaner user experience, and more sophisticated learning recommendations. Cornerstone wins on breadth and HR integration depth for large enterprises with dedicated LMS administrators; Docebo wins on AI, UX, and speed to value for organisations that want modern learning without a 6-month implementation project.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'cornerstone-ondemand-vs-docebo');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'cornerstone-ondemand-vs-docebo', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Learning Features', 3, 5, 'Docebo Shape generates courses from documents, Flow embeds learning in daily tools, and its recommendation engine personalises paths continuously. Cornerstone AI is improving but remains less sophisticated than Docebo.'),
  ('Content Library', 5, 4, 'Cornerstone Content Anytime provides 60,000 courses from major providers. Docebo has an extensive marketplace but Cornerstone wins on sheer library breadth.'),
  ('Talent Management Suite', 5, 2, 'Cornerstone includes performance management, succession planning, recruitment, and workforce analytics alongside the LMS. Docebo is LMS-first and does not cover the broader talent lifecycle.'),
  ('User Experience', 2, 5, 'Docebo has a modern, consumer-grade interface that learners find intuitive. Cornerstone carries the UI legacy of a product built over two decades - functional but less polished.'),
  ('Implementation Speed', 2, 4, 'Cornerstone enterprise implementations typically take 3 to 6 months with a partner. Docebo can go live in weeks depending on integration complexity.'),
  ('Social and Informal Learning', 3, 5, 'Docebo Communities enables social learning, user-generated content, and informal knowledge sharing. Cornerstone supports communities but social learning is less central to its architecture.'),
  ('Mid-Market Suitability', 2, 4, 'Docebo serves companies from 200 to 50,000 employees effectively. Cornerstone is optimised for large enterprises - complexity and cost are barriers for mid-market buyers.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'cornerstone-ondemand-vs-docebo')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'cornerstone-ondemand-vs-docebo');
