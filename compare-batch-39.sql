-- compare-batch-39.sql
-- 5 AI recruitment and HR tech tool comparison pairs
-- DEPENDENCY: tools-batch-39.sql must be run first (greenhouse, lever, ashby, rippling,
--   bamboohr, goodtime, beamery, eightfold, seekout, metaview)
-- All pairs verified absent from compare-batch-1 through compare-batch-38

-- 1. greenhouse vs lever: structured hiring vs relationship-first ATS
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'greenhouse-vs-lever', 'greenhouse', 'lever',
  'Greenhouse and Lever are the two dominant mid-market ATS platforms, but they reflect fundamentally different philosophies. Greenhouse is built around structured hiring - defining scorecards before sourcing begins and applying them consistently to reduce bias. Lever combines ATS and CRM into one platform, treating every candidate as a future hire or future customer. Choose Greenhouse for process discipline; Lever for candidate relationship depth.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'greenhouse-vs-lever');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'greenhouse-vs-lever', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Structured Hiring', 5, 3, 'Greenhouse built the category - scorecards, calibration sessions, and interviewer training are core to the product. Lever has scorecards but they are less central to the workflow.'),
  ('Candidate CRM', 3, 5, 'Lever Nurture automates passive candidate engagement with sequences over months. Greenhouse CRM features are an add-on rather than a core product capability.'),
  ('Integration Ecosystem', 5, 4, 'Greenhouse has 450+ integrations including Workday, LinkedIn, Slack, and every major HR tool. Lever has strong integrations but fewer total partners.'),
  ('Analytics and Reporting', 4, 4, 'Both have solid pipeline analytics, source quality tracking, and time-to-hire reporting. Neither matches Ashby at depth. Greenhouse reporting is more customizable.'),
  ('Ease of Use', 3, 4, 'Lever has a cleaner visual pipeline accessible to occasional hiring managers. Greenhouse requires more TA ops configuration but rewards that investment with process consistency.'),
  ('Bias Reduction', 5, 3, 'Greenhouse structured hiring is explicitly designed to reduce interviewer bias through consistent scorecards and calibrated criteria. Lever supports this but does not enforce it.'),
  ('Pricing', 3, 3, 'Both are enterprise-priced with no self-serve plans. Pricing depends on headcount and modules. Greenhouse is typically higher for equivalent configurations.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'greenhouse-vs-lever')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'greenhouse-vs-lever');

-- 2. ashby vs greenhouse: modern analytics-first ATS vs established structured hiring
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'ashby-vs-greenhouse', 'ashby', 'greenhouse',
  'Ashby and Greenhouse are both serious ATS platforms for structured hiring, but at different points in the market maturity curve. Ashby is the challenger: all-in-one with deeper analytics, automated scheduling, and a modern interface favored by high-growth tech companies. Greenhouse is the established leader with the broadest integration ecosystem and the most mature structured hiring methodology. Teams choosing between them are usually deciding between analytics depth (Ashby) and ecosystem breadth (Greenhouse).',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ashby-vs-greenhouse');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'ashby-vs-greenhouse', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Analytics Depth', 5, 4, 'Ashby tracks interviewer-level throughput, source attribution to campaign level, and offer acceptance by salary band. Greenhouse analytics are strong but require more configuration to reach this depth.'),
  ('Interview Scheduling', 5, 3, 'Ashby scheduling handles complex multi-stage panel loops automatically. Greenhouse scheduling is more manual or requires a third-party integration like Calendly or GoodTime.'),
  ('Integration Ecosystem', 3, 5, 'Greenhouse has 450+ integrations built over a decade. Ashby is newer and has fewer total integrations, though it covers the essential stack for most companies.'),
  ('All-in-One Value', 5, 3, 'Ashby includes ATS, CRM, scheduling, and analytics in one product with one contract. Greenhouse often requires additional tools or modules for CRM and scheduling.'),
  ('Structured Hiring Methodology', 4, 5, 'Greenhouse pioneered the structured hiring category and has the most mature implementation. Ashby supports structured hiring well but Greenhouse has deeper training resources and community.'),
  ('Pricing', 4, 3, 'Both are paid enterprise tools. Ashby is typically less expensive than Greenhouse for comparable configurations, which matters for early-stage companies watching burn.'),
  ('Customer Profile', 4, 4, 'Ashby is favored by high-growth tech companies like Notion, Linear, and Vercel. Greenhouse is favored by mid-market and enterprise companies like Airbnb and HubSpot.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'ashby-vs-greenhouse')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'ashby-vs-greenhouse');

-- 3. rippling vs bamboohr: all-in-one HR+IT+Finance vs SMB-focused HRIS
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'rippling-vs-bamboohr', 'rippling', 'bamboohr',
  'Rippling and BambooHR both serve companies in the 10-500 employee range, but with very different scopes. Rippling unifies HR, IT, and Finance in one platform - provisioning software access automatically when employees onboard and deactivating it when they leave. BambooHR focuses purely on HR: employee records, onboarding, performance management, and basic payroll. If you need IT provisioning and global payroll, Rippling wins clearly. If you want the simplest HR software with the best support, BambooHR is hard to beat.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rippling-vs-bamboohr');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'rippling-vs-bamboohr', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('IT Provisioning', 5, 1, 'Rippling automatically provisions and deprovisions software access when employees join or leave. BambooHR has no IT management capabilities.'),
  ('Ease of Use', 3, 5, 'BambooHR is consistently rated highest for ease of use among HRIS platforms. Rippling has more power but also more configuration complexity.'),
  ('Global Payroll', 5, 2, 'Rippling runs payroll in 50+ countries from the same interface as US payroll. BambooHR payroll is US-focused and a paid add-on.'),
  ('Customer Support', 3, 5, 'BambooHR consistently receives top marks for customer support responsiveness. Rippling support quality varies by plan tier.'),
  ('Onboarding Workflow', 4, 4, 'Both have strong onboarding checklists and e-signature for new hire paperwork. Rippling adds automatic software provisioning on top.'),
  ('Performance Management', 3, 4, 'BambooHR has strong goal setting, 360-degree feedback, and automated review scheduling. Rippling performance management is less mature.'),
  ('Pricing', 3, 4, 'BambooHR pricing is transparent and competitive for SMBs. Rippling pricing starts at $8 per employee per month but scales up significantly with modules added.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'rippling-vs-bamboohr')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'rippling-vs-bamboohr');

-- 4. seekout vs eightfold: sourcing database vs deep learning talent intelligence
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'seekout-vs-eightfold', 'seekout', 'eightfold',
  'SeekOut and Eightfold both use AI to find talent that traditional sourcing misses, but through different mechanisms. SeekOut is a sourcing database of 800M+ profiles with filters for diversity signals, GitHub code contributions, and niche professional databases. Eightfold is a talent intelligence platform trained on hundreds of millions of career trajectories that infers skills and predicts success rather than just matching profiles to requirements. SeekOut wins on sourcing breadth and niche databases; Eightfold wins on career trajectory intelligence and internal mobility.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'seekout-vs-eightfold');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'seekout-vs-eightfold', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Technical Candidate Sourcing', 5, 3, 'SeekOut indexes GitHub profiles and ranks engineers by actual code contributions. Eightfold infers technical skills from career trajectories but lacks the direct code contribution signal.'),
  ('Skills Inference', 3, 5, 'Eightfold infers skills from career paths even when not listed on a resume, trained on hundreds of millions of trajectories. SeekOut matches against listed skills and profile data.'),
  ('Diversity Sourcing', 5, 4, 'SeekOut has explicit diversity filters with gender and ethnicity signals across 800M profiles. Eightfold supports diversity goals but SeekOut is more direct for pipeline composition targeting.'),
  ('Internal Mobility', 2, 5, 'Eightfold identifies internal candidates likely to succeed in open roles before going external and surfaces retention risks. SeekOut is focused on external sourcing.'),
  ('Niche Talent Pools', 5, 3, 'SeekOut covers academic publications, medical databases, and patent filings that LinkedIn Recruiter does not reach. Eightfold focuses on mainstream professional profiles.'),
  ('Implementation Complexity', 4, 2, 'SeekOut is relatively quick to adopt as a sourcing tool. Eightfold requires enterprise implementation and significant configuration to integrate with HR data.'),
  ('Pricing', 3, 2, 'Both are premium tools. SeekOut pricing is competitive with LinkedIn Recruiter. Eightfold is enterprise-only with significant implementation investment required.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'seekout-vs-eightfold')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'seekout-vs-eightfold');

-- 5. goodtime vs metaview: interview scheduling vs interview notes AI
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'goodtime-vs-metaview', 'goodtime', 'metaview',
  'GoodTime and Metaview solve different problems in the interview process and are typically used together rather than chosen between. GoodTime automates before the interview: scheduling complex panel loops, managing interviewer pools, and sending candidates self-scheduling links. Metaview operates during and after: recording and transcribing interviews, then generating structured notes aligned to ATS scorecards. Together they address the two biggest time drains in interview operations.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'goodtime-vs-metaview');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'goodtime-vs-metaview', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Interview Scheduling Automation', 5, 1, 'GoodTime is purpose-built for scheduling - handling complex panel loops, availability coordination, and self-scheduling links. Metaview has no scheduling capability.'),
  ('Interview Quality', 2, 5, 'Metaview lets interviewers stay present in conversation instead of taking notes, directly improving interview quality and candidate experience. GoodTime does not affect what happens during the interview.'),
  ('Post-Interview Admin', 2, 5, 'Metaview reduces post-interview note-writing from 20 minutes to under 2 minutes via AI-generated structured summaries. GoodTime does not help with post-interview documentation.'),
  ('ATS Integration', 4, 5, 'Metaview pushes notes directly to Greenhouse, Lever, and Ashby candidate records. GoodTime integrates with ATS for job and stage data but focuses on calendar and scheduling systems.'),
  ('Coordinator Time Saved', 5, 3, 'GoodTime saves recruiting coordinator time by eliminating manual scheduling across email chains. Metaview saves interviewer and recruiter time on note documentation.'),
  ('Interviewer Load Management', 5, 2, 'GoodTime manages interviewer pools to prevent overburdening and ensure panel diversity. Metaview does not have interviewer management features.'),
  ('ROI Threshold', 3, 4, 'GoodTime ROI requires 50+ hires per quarter for the cost to justify itself. Metaview delivers value at lower volumes since every interview generates notes regardless of hiring pace.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'goodtime-vs-metaview')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'goodtime-vs-metaview');
