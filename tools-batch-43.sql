-- tools-batch-43.sql
-- 10 AI corporate e-learning and LMS tools
-- Run in Supabase SQL Editor
-- All slugs verified absent from prior batch files

INSERT INTO tools (slug, name, tagline, description, logo_url, website_url, affiliate_url, tags, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, pros, cons, use_cases)
VALUES

('articulate',
 'Articulate 360',
 'Build e-learning courses that work on every device',
 'Articulate 360 is the industry-standard e-learning authoring suite used by over 118,000 organizations worldwide. The platform bundles two authoring tools: Storyline 360 for building interactive, timeline-based courses with branching scenarios, quizzes, and simulations, and Rise 360 for creating responsive web-based courses that look polished on any screen without coding. Both tools output industry-standard SCORM and xAPI content that loads into any LMS.

The AI features in Articulate 360 include a content library of 13 million assets (photos, illustrations, icons, videos), AI-assisted text generation for course copy, and Review 360 for stakeholder feedback and approval workflows. For instructional designers building compliance training, product knowledge courses, and onboarding programs, Articulate is the benchmark that all other authoring tools are measured against.

The Articulate community is one of the most active in the e-learning industry, with thousands of templates, tutorials, and free resources shared by experienced designers. Organizations that standardize on Articulate can hire instructional designers who already know the tool.',
 NULL,
 'https://articulate.com',
 'https://articulate.com',
 ARRAY['education', 'business', 'e-learning'],
 'paid',
 false,
 108.00,
 4.7,
 2840,
 false,
 false,
 false,
 ARRAY['Industry-standard SCORM and xAPI output compatible with all LMS platforms', 'Two authoring tools in one subscription: Storyline 360 for interactive courses and Rise 360 for responsive web courses', 'Massive community with 13M+ asset library and thousands of free templates', 'Strong branching scenario and simulation capabilities for complex training', 'Review 360 streamlines stakeholder feedback without email rounds'],
 ARRAY['High annual license cost compared to newer alternatives', 'Storyline has a steep learning curve for beginners', 'Rise 360 is less flexible for complex custom interactions', 'Subscription required for all features; no perpetual license option'],
 ARRAY['Corporate compliance and safety training course development', 'Product knowledge and sales enablement content for enterprise teams', 'Customer onboarding and certification program creation', 'Technical skills training with simulations and branching scenarios']),

('docebo',
 'Docebo',
 'Enterprise LMS with AI-powered learning recommendations',
 'Docebo is an enterprise learning management system known for its AI-powered content curation and recommendation engine. The platform uses machine learning to surface relevant courses, microlearning content, and external resources to each learner based on their role, skills gaps, and learning history - reducing the burden on L&D teams to manually assign training.

The platform serves three training audiences in a single system: employee learning (onboarding, compliance, upskilling), partner training (reseller certification, channel enablement), and customer education (product adoption, certification programs). Multi-portal architecture lets organizations run separate training experiences for each audience from one administrative console.

Docebo integrates with Salesforce, SAP, Workday, Microsoft Teams, and 400-plus other enterprise applications. The content marketplace connects to LinkedIn Learning, Coursera for Business, and major content libraries. For global enterprises with complex training needs across multiple business units and audiences, Docebo provides the governance and scalability that mid-market LMS platforms do not.',
 NULL,
 'https://docebo.com',
 'https://docebo.com',
 ARRAY['education', 'business', 'e-learning'],
 'paid',
 false,
 0.00,
 4.4,
 1620,
 false,
 false,
 false,
 ARRAY['AI recommendation engine surfaces relevant content to each learner automatically', 'Multi-audience architecture supports employee, partner, and customer training in one platform', 'Extensive integration ecosystem with 400-plus enterprise applications', 'Strong compliance and certification management for regulated industries', 'Content marketplace with LinkedIn Learning, Coursera, and major providers'],
 ARRAY['Enterprise pricing with no published rates; custom quotes required', 'Implementation complexity requires dedicated admin time', 'Reporting customization can be limited compared to BI tools', 'Feature richness creates a steep learning curve for new administrators'],
 ARRAY['Enterprise employee learning and compliance training at scale', 'Partner and reseller certification and channel enablement programs', 'Customer education and product adoption training for SaaS companies', 'Multi-audience training with separate portals for each learner group']),

('learnupon',
 'LearnUpon',
 'LMS designed for training partners, customers, and employees',
 'LearnUpon is a learning management system built around the multi-audience training model: organizations use it to deliver separate, branded training experiences to employees, partners, and customers from a single admin hub. The portal architecture allows each audience to have its own branded interface, course catalog, and completion certificates without the overhead of managing separate LMS instances.

The platform is particularly strong for partner and customer education programs that drive product adoption and certification. The Salesforce integration automatically syncs completion data back to opportunity and account records, connecting training completion to revenue outcomes. For SaaS companies building certification programs that differentiate trained partners from untrained ones, LearnUpon provides the portal flexibility and reporting depth that generic LMS platforms lack.

LearnUpon pricing is based on active users, making it predictable for organizations with defined learner populations. The platform has a strong implementation track record with dedicated customer success teams guiding onboarding for enterprise accounts.',
 NULL,
 'https://learnupon.com',
 'https://learnupon.com',
 ARRAY['education', 'business', 'e-learning'],
 'paid',
 false,
 699.00,
 4.6,
 980,
 false,
 false,
 false,
 ARRAY['Multi-portal architecture for separate employee, partner, and customer training experiences', 'Salesforce integration connects training completions to revenue and account data', 'Strong partner certification and reseller enablement capabilities', 'Dedicated customer success support for implementation and onboarding', 'Predictable active-user pricing with no surprise costs'],
 ARRAY['Higher starting price compared to simpler LMS alternatives', 'Less suited for highly interactive SCORM content delivery than Docebo or TalentLMS', 'Reporting is functional but less customizable than enterprise BI tools', 'No native AI content recommendation engine'],
 ARRAY['Partner and reseller certification programs for channel-driven businesses', 'Customer education and product onboarding for SaaS and software companies', 'Employee compliance and onboarding training with multi-portal separation', 'Revenue-connected training programs where Salesforce data integration matters']),

('360learning',
 '360Learning',
 'Collaborative LMS where experts build and share training internally',
 '360Learning is the collaborative learning management system built on a different premise from traditional LMS platforms: instead of L&D teams creating all training content, subject matter experts throughout the organization author and share their knowledge with peers. The platform makes it fast for non-instructional-designers to build courses, record short videos, and share expertise without dedicated e-learning authoring skills.

The AI features include automated course creation suggestions, learner needs analysis, and a recommendation engine that connects employees to internal expert content. The social learning layer lets colleagues comment on courses, flag outdated content, and rate modules - creating a feedback loop that keeps content current without L&D bottleneck.

For organizations where deep technical or product knowledge is distributed across teams (engineering, sales, operations), 360Learning enables those experts to share knowledge directly at a fraction of the cost of commissioning professional e-learning content. The platform starts at $8 per user per month for teams, making it accessible for smaller organizations compared to enterprise LMS pricing.',
 NULL,
 'https://360learning.com',
 'https://360learning.com',
 ARRAY['education', 'business', 'e-learning'],
 'paid',
 false,
 8.00,
 4.5,
 1240,
 false,
 false,
 false,
 ARRAY['Collaborative authoring model lets subject matter experts create training without L&D support', 'Affordable per-user pricing at $8/user/month compared to enterprise LMS alternatives', 'AI-powered learning needs analysis and content recommendations', 'Social learning features with peer ratings and comments keep content current', 'Fast course creation by non-designers through intuitive authoring tools'],
 ARRAY['Less suited for formal compliance training requiring standardized SCORM output', 'Social learning model requires culture shift for organizations used to top-down L&D', 'Advanced reporting is less deep than dedicated analytics-first LMS platforms', 'Collaborative content model can lead to inconsistent quality without editorial governance'],
 ARRAY['Internal knowledge sharing programs where employees train each other', 'Sales enablement with product experts creating training for sales teams', 'Onboarding programs with collaborative input from multiple departments', 'Organizations scaling L&D without adding instructional design headcount']),

('skilljar',
 'Skilljar',
 'Customer education platform for product adoption and certification',
 'Skilljar is the learning management system built specifically for customer and partner education programs. Where traditional LMS platforms are designed for internal employee training, Skilljar is designed for the external training use case: teaching customers how to use your product, certifying partners on your platform, and building a training business that drives adoption and reduces churn.

The platform integrates deeply with Salesforce and Gainsight to connect training completion data to customer health scores, product adoption metrics, and renewal risk. Customer success teams use this data to identify accounts where training could prevent churn. The Skilljar analytics layer tracks course completion, certification rates, and time-to-value metrics at the customer account level.

Monetization features allow organizations to sell access to training academies as a revenue line, with Stripe integration for course purchases and subscription training access. For SaaS companies where product complexity is a churn driver, Skilljar provides the structured customer education infrastructure that generic LMS platforms cannot deliver.',
 NULL,
 'https://skilljar.com',
 'https://skilljar.com',
 ARRAY['education', 'business', 'e-learning'],
 'paid',
 false,
 0.00,
 4.5,
 760,
 false,
 false,
 false,
 ARRAY['Built specifically for customer and partner education (not employee training)', 'Deep Salesforce and Gainsight integration connects training to customer health and churn data', 'Monetization features for selling training access as a revenue line', 'Analytics track customer account-level training completion and adoption correlation', 'Branded training academies that extend the product experience'],
 ARRAY['Enterprise pricing with no published rates', 'Not designed for internal employee training programs', 'Less content authoring capability; requires importing SCORM from Articulate or Rise', 'Narrower use case focus limits flexibility for organizations with mixed training needs'],
 ARRAY['Customer onboarding and product adoption training programs', 'Partner certification and channel enablement academies', 'Training-as-a-service businesses monetizing product expertise', 'SaaS customer success teams using training data to predict and prevent churn']),

('absorb-lms',
 'Absorb LMS',
 'Modern cloud LMS with AI-powered admin automation',
 'Absorb LMS is a corporate learning management system known for its clean learner interface and AI-powered administration tools. The Absorb Intelligent Assist AI automates routine LMS administration tasks: auto-enrolling learners in relevant courses based on department or role changes, sending smart completion reminders, and generating training reports without manual configuration.

The platform serves mid-market and enterprise organizations with compliance training, professional development, and onboarding programs. The eCommerce module supports selling external training and certification programs, making Absorb suitable for training companies and professional associations in addition to corporate L&D teams.

Absorb integrates with HRIS systems including Workday, BambooHR, and ADP to automate learner provisioning based on HR data. When an employee changes roles, Absorb automatically adjusts their course assignments to match their new position requirements.',
 NULL,
 'https://absorblms.com',
 'https://absorblms.com',
 ARRAY['education', 'business', 'e-learning'],
 'paid',
 false,
 0.00,
 4.3,
 890,
 false,
 false,
 false,
 ARRAY['AI-powered administration automates enrollment, reminders, and reporting', 'Clean learner interface with high completion rates versus traditional LMS designs', 'HRIS integration with Workday, BambooHR, and ADP for automated provisioning', 'eCommerce module for selling training externally', 'Strong compliance training management with certificate expiration tracking'],
 ARRAY['Enterprise pricing with custom quotes; no transparent pricing published', 'Advanced customization requires technical implementation support', 'Reporting exports can be limited for organizations needing complex analytics', 'Less community and template resources compared to Articulate or TalentLMS'],
 ARRAY['Corporate compliance and safety training with automatic re-enrollment', 'Mid-market employee onboarding and professional development programs', 'Training companies selling courses externally through eCommerce module', 'Organizations needing HRIS-connected automatic learner provisioning']),

('litmos',
 'SAP Litmos',
 'Cloud-based LMS with a built-in content library for compliance training',
 'SAP Litmos is a cloud-based learning management system backed by SAP, combining LMS infrastructure with a built-in content library of 2,000-plus compliance and professional development courses. The ready-made content library reduces the time-to-launch for organizations that need compliance training immediately without building courses from scratch - covering topics from workplace safety and anti-harassment to cybersecurity and data privacy.

The Litmos platform is particularly strong for organizations already in the SAP ecosystem, with native integration into SAP SuccessFactors for HR data and S/4HANA for operational workflows. The mobile-first learner experience supports offline course completion, which matters for organizations training field-based or deskless workers without consistent internet access.

Litmos pricing starts at a per-user-per-month rate with no minimums for smaller teams, making it accessible for organizations that cannot commit to enterprise contract minimums. The content library subscription is sold separately from the LMS platform.',
 NULL,
 'https://litmos.com',
 'https://litmos.com',
 ARRAY['education', 'business', 'e-learning'],
 'paid',
 false,
 6.00,
 4.2,
 1340,
 false,
 false,
 false,
 ARRAY['Built-in content library of 2,000-plus compliance courses reduces time-to-launch', 'Native SAP SuccessFactors integration for organizations in the SAP ecosystem', 'Mobile-first design supports offline learning for field-based and deskless workers', 'Transparent per-user pricing with no enterprise contract minimums required', 'Strong compliance course coverage across safety, HR, and cybersecurity'],
 ARRAY['Content library is a separate subscription cost from the LMS platform fee', 'Less modern UI compared to newer LMS competitors like Absorb or TalentLMS', 'Reporting capabilities are less advanced than analytics-focused platforms', 'SAP ecosystem advantages are less relevant for organizations not using SAP'],
 ARRAY['Compliance and regulatory training programs that need ready-made content', 'Organizations in the SAP ecosystem integrating with SuccessFactors', 'Deskless and field worker training requiring offline mobile access', 'SMBs starting corporate training programs who need content and LMS in one purchase']),

('ispring',
 'iSpring Suite',
 'PowerPoint-based e-learning authoring with built-in LMS',
 'iSpring Suite is the e-learning authoring tool built on top of PowerPoint, allowing instructional designers and subject matter experts who already know PowerPoint to create professional e-learning courses without learning a new design tool. Courses are built as PowerPoint presentations with iSpring interactivity layers added - quizzes, simulations, branching scenarios, and video narration - then published as SCORM content that loads into any LMS.

The iSpring Learn LMS is included with iSpring Suite, providing a complete authoring-plus-delivery solution in a single subscription. For organizations that do not have an LMS and want to start with a straightforward authoring-plus-hosting solution, iSpring provides the lowest-friction path to launching a corporate training program.

The TalkMaster conversation simulation feature lets instructional designers build role-play scenarios where learners practice sales calls, customer service interactions, and management conversations without the overhead of building complex branching logic.',
 NULL,
 'https://ispringsolutions.com',
 'https://ispringsolutions.com',
 ARRAY['education', 'business', 'e-learning'],
 'paid',
 false,
 64.00,
 4.6,
 1820,
 false,
 false,
 false,
 ARRAY['PowerPoint-based authoring requires no new design tool skills for SMEs', 'iSpring Learn LMS bundled with Suite for complete authoring-plus-hosting solution', 'TalkMaster conversation simulations for sales and customer service role-play training', 'High-quality SCORM output compatible with all major LMS platforms', 'Affordable pricing compared to Articulate 360 with similar output quality'],
 ARRAY['PowerPoint dependency limits design flexibility compared to Storyline or Rise', 'Less suited for large enterprise L&D teams with multiple designers and complex workflows', 'iSpring Learn LMS is functional but less feature-rich than Docebo or LearnUpon', 'Mobile experience is less polished than native mobile-first LMS platforms'],
 ARRAY['SMBs transitioning PowerPoint presentations into structured e-learning courses', 'Organizations wanting complete authoring-plus-LMS at lower cost than Articulate 360', 'Sales and customer service role-play and simulation training programs', 'Subject matter experts building their own training without instructional design support']),

('talentlms',
 'TalentLMS',
 'Flexible LMS for teams of any size with a generous free tier',
 'TalentLMS is a cloud-based learning management system designed for teams from 5 to 5,000, known for its balance of flexibility, ease of use, and pricing accessibility. The free plan supports up to 5 users and 10 courses - genuinely useful for small teams getting started - with paid plans scaling from $69/month for larger learner pools.

The platform supports SCORM, xAPI, and AICC content import from any authoring tool, plus native course authoring for teams without Articulate or iSpring. The gamification layer adds points, badges, and leaderboards to training programs, which has been shown to increase completion rates for compliance and onboarding programs. The TalentLibrary content library includes 800-plus ready-made courses covering compliance, soft skills, and business fundamentals.

TalentLMS integrates with Salesforce, BambooHR, Zoom, Microsoft Teams, and Zapier for workflow automation. The platform is particularly popular with SMBs and high-growth startups that need a professional LMS without the implementation complexity and contract minimums of enterprise alternatives.',
 NULL,
 'https://talentlms.com',
 'https://talentlms.com',
 ARRAY['education', 'business', 'e-learning'],
 'freemium',
 true,
 69.00,
 4.5,
 2240,
 false,
 false,
 false,
 ARRAY['Free plan for up to 5 users makes evaluation genuinely useful without a sales call', 'Flexible pricing from $69/month scales with team size without enterprise minimums', 'Gamification features (points, badges, leaderboards) improve completion rates', 'TalentLibrary with 800-plus ready-made courses reduces content creation overhead', 'Simple setup with no IT implementation required'],
 ARRAY['Reporting depth is less advanced than enterprise LMS platforms', 'Native course authoring is basic; complex courses require an external tool like Articulate', 'Customization of learner interface is limited compared to Docebo or LearnUpon', 'Support quality decreases at lower pricing tiers'],
 ARRAY['SMBs and startups launching first corporate training programs', 'Compliance and onboarding training for growing teams with tight budgets', 'Organizations needing gamified training to improve completion rates', 'Small L&D teams who want an easy-to-manage LMS without technical complexity']),

('cornerstone',
 'Cornerstone OnDemand',
 'Enterprise talent management and learning platform for global organizations',
 'Cornerstone OnDemand is the enterprise talent management and learning platform used by over 7,500 organizations worldwide, covering learning management, performance management, skills intelligence, and succession planning in one unified system. The platform is particularly strong for large global enterprises that need a single system for the full employee lifecycle from onboarding through development and succession.

The Cornerstone Skills Graph uses AI to map employee skill profiles, identify gaps, and recommend learning pathways that connect individual development to business capability needs. This skills intelligence layer feeds into performance reviews, succession planning, and talent mobility decisions - making learning investment visible to HR leadership as a business metric rather than a compliance checkbox.

Cornerstone Content Anytime provides access to 60,000-plus content titles from LinkedIn Learning, Coursera, Harvard ManageMentor, and other providers within the Cornerstone LMS, reducing the need to manage multiple content subscriptions. For enterprises managing 10,000-plus learners across global business units, Cornerstone provides the governance, localization, and compliance reporting that mid-market LMS platforms cannot scale to.',
 NULL,
 'https://cornerstoneondemand.com',
 'https://cornerstoneondemand.com',
 ARRAY['education', 'business', 'e-learning'],
 'paid',
 false,
 0.00,
 4.3,
 1560,
 false,
 false,
 false,
 ARRAY['AI Skills Graph connects learning to organizational capability and succession planning', 'Unified talent management covering learning, performance, and succession in one platform', 'Content Anytime provides 60,000-plus titles from LinkedIn Learning, Coursera, and others', 'Strong compliance and regulatory training management for regulated industries', 'Global deployment capabilities with multi-language and localization support'],
 ARRAY['Enterprise pricing with implementation costs that are significant for smaller organizations', 'Complexity requires dedicated LMS administrator and implementation partner support', 'Interface modernization has lagged behind newer competitors', 'ROI realization timeline is long due to implementation complexity'],
 ARRAY['Global enterprise learning and development programs with 10,000-plus learners', 'Integrated talent management connecting learning to performance and succession', 'Skills-based organizations needing AI-powered gap analysis and learning recommendations', 'Regulated industries requiring comprehensive compliance training reporting and audit trails'])

ON CONFLICT (slug) DO NOTHING;
