-- compare-batch-56.sql
-- 5 AI Healthcare tool comparison pairs
-- All tool slugs confirmed in DB from tools-batch-56.sql (heidi-health, freed-ai, deepscribe,
--   ambience-healthcare, viz-ai, aidoc, paige-ai, tempus-ai, regard-clinical, atropos-health)
-- aidoc is confirmed in tools-batch-37.sql
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. heidi-health-vs-freed-ai (primary care scribe vs complex encounter notes)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'heidi-health-vs-freed-ai',
  'heidi-health',
  'freed-ai',
  'Heidi Health and Freed are both AI ambient medical scribes that convert patient encounters into structured clinical notes, but they target different clinical styles. Heidi is optimised for primary care and general practice - fast setup, a generous free tier, and strong accuracy on the conversational, multi-problem consultations common in GP settings. Freed targets specialists and complex encounter types (internal medicine, psychiatry, chronic disease) where note accuracy and clinical nuance matter more than speed alone. Heidi wins on accessibility and cost for solo practitioners. Freed wins on note depth and accuracy for high-complexity encounters. Both are strong choices for outpatient settings in 2026; the decision usually comes down to practice specialty and note complexity requirements.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'heidi-health-vs-freed-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'heidi-health-vs-freed-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Free Tier Availability',       5, 4, 'Heidi has a generous free tier; Freed offers a limited free plan'),
  ('Note Accuracy - Complex Cases', 4, 5, 'Freed rated higher for psychiatry, internal medicine, and chronic disease notes'),
  ('Primary Care Optimisation',    5, 4, 'Heidi is built around GP-style multi-problem consultations'),
  ('After-Visit Summaries',        4, 5, 'Freed generates patient-facing summaries from the same recording'),
  ('Mobile App Experience',        5, 5, 'Both offer strong iOS and Android apps for mobile recording'),
  ('EHR Integration Depth',        4, 4, 'Both offer major EHR integrations; depth varies by EHR system'),
  ('Startup Cost',                 5, 4, 'Heidi free tier makes it lower cost to start for solo practitioners')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'heidi-health-vs-freed-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'heidi-health-vs-freed-ai');

-- 2. deepscribe-vs-ambience-healthcare (enterprise ambient scribes)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'deepscribe-vs-ambience-healthcare',
  'deepscribe',
  'ambience-healthcare',
  'DeepScribe and Ambience Healthcare are both enterprise-tier ambient clinical documentation platforms targeting hospital systems and large group practices. DeepScribe focuses on accuracy and EHR integration across specialty types - it has strong deployment history in specialty care including oncology, orthopaedics, and cardiology. Ambience positions itself as a full clinical AI operating system with broader workflow coverage including pre-visit preparation, structured EHR data push, and post-visit documentation tasks. DeepScribe wins on specialty-specific documentation accuracy. Ambience wins on workflow breadth for health systems that want to consolidate documentation, care gaps, and clinical communication into one platform. Both require enterprise contracts and implementation investment.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'deepscribe-vs-ambience-healthcare');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'deepscribe-vs-ambience-healthcare', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Specialty Documentation Accuracy', 5, 4, 'DeepScribe has strong specialty-specific models for oncology, orthopaedics, cardiology'),
  ('Workflow Breadth',                 3, 5, 'Ambience covers pre-visit prep, structured data push, referral letters, and more'),
  ('EHR Structured Data Push',         4, 5, 'Ambience pushes structured data to EHR fields; DeepScribe primarily note output'),
  ('Pre-Visit Preparation',            2, 5, 'Ambience chart review and briefing before encounters is a core differentiator'),
  ('Hospital-Scale Deployment',        4, 5, 'Ambience built for 50+ clinician health system deployments'),
  ('Individual Clinician Access',      4, 2, 'DeepScribe accessible to individual specialists; Ambience is enterprise-only'),
  ('Implementation Time',              3, 4, 'Both require dedicated implementation; Ambience integration is more complex')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'deepscribe-vs-ambience-healthcare')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'deepscribe-vs-ambience-healthcare');

-- 3. viz-ai-vs-aidoc (time-critical imaging AI platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'viz-ai-vs-aidoc',
  'viz-ai',
  'aidoc',
  'Viz.ai and Aidoc are the two leading AI medical imaging platforms for time-critical condition detection in radiology and emergency medicine. Viz.ai built its reputation on stroke neurovascular care and has expanded to cardiology, pulmonary, and oncology. Aidoc started with incidental findings and built a broader radiology AI platform covering stroke, PE, brain bleeds, and spine pathology. Viz.ai wins on stroke workflow depth - its coordinated care team communication and mobile notification system is the most developed in the market. Aidoc wins on breadth of pathology coverage and the size of its AI model library across radiology subspecialties. Health systems evaluating either platform should consider their primary clinical use case: stroke-centre optimisation favours Viz.ai; broad radiology AI deployment favours Aidoc.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'viz-ai-vs-aidoc');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'viz-ai-vs-aidoc', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Stroke Workflow Depth',            5, 4, 'Viz.ai stroke care team coordination is the most developed in the market'),
  ('Pathology Coverage Breadth',       4, 5, 'Aidoc has a broader AI model library across radiology subspecialties'),
  ('Cardiology AI Capabilities',       5, 4, 'Viz.ai strong in aortic dissection and TAVR; both competitive in PE'),
  ('Care Team Communication',          5, 4, 'Viz.ai mobile notification and coordination workflow is more developed'),
  ('PACS Integration Depth',           4, 5, 'Aidoc integrates with a wider range of PACS systems'),
  ('Incidental Findings Management',   3, 5, 'Aidoc has stronger incidental findings tracking and follow-up workflow'),
  ('FDA Clearances',                   4, 5, 'Aidoc has a larger portfolio of cleared indications across subspecialties')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'viz-ai-vs-aidoc')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'viz-ai-vs-aidoc');

-- 4. paige-ai-vs-tempus-ai (AI-powered oncology diagnostics)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'paige-ai-vs-tempus-ai',
  'paige-ai',
  'tempus-ai',
  'Paige and Tempus AI both apply AI to oncology but at different layers of the cancer care pathway. Paige focuses on AI-powered pathology - analysing digital pathology slides to detect and classify cancer with FDA-cleared models, reducing diagnostic errors and pathologist workload for prostate, breast, and colorectal cancers. Tempus is a broader precision medicine platform combining genomic data, clinical data, and AI analytics for treatment matching, clinical trial identification, and real-world evidence generation. Paige wins for pathology labs and cancer centres focused on slide-based diagnostic accuracy. Tempus wins for oncology programmes that need genomic profiling, molecular tumour boards, and clinical trial matching capabilities. They are complementary rather than competing for most cancer centre workflows.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'paige-ai-vs-tempus-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'paige-ai-vs-tempus-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Pathology Slide Analysis',         5, 2, 'Paige is pathology-native; Tempus primarily genomics and clinical data'),
  ('Genomic Profiling',                2, 5, 'Tempus offers comprehensive genomic sequencing and molecular profiling'),
  ('Clinical Trial Matching',          2, 5, 'Tempus TIME trial matching is a primary clinical workflow'),
  ('FDA-Cleared Diagnostic Models',    5, 3, 'Paige has multiple FDA clearances for pathology indications'),
  ('Real-World Evidence Generation',   2, 5, 'Tempus real-world evidence platform is used by pharma and research'),
  ('Pathologist Workflow Integration', 5, 3, 'Paige integrates into digital pathology scanning and reading workflows'),
  ('Multi-Cancer Type Coverage',       4, 5, 'Tempus covers more cancer types through genomics; Paige focused on path')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'paige-ai-vs-tempus-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'paige-ai-vs-tempus-ai');

-- 5. regard-clinical-vs-atropos-health (clinical decision support approaches)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'regard-clinical-vs-atropos-health',
  'regard-clinical',
  'atropos-health',
  'Regard and Atropos Health both support clinical decision-making with AI, but through fundamentally different mechanisms. Regard integrates directly into the EHR and analyses the patient''s chart in real time during the encounter - surfacing diagnosis suggestions, documentation gaps, and care alerts as the clinician reviews the chart. Atropos Health provides on-demand real-world evidence queries - answering specific clinical questions ("what is the 30-day mortality for this presentation in patients with X comorbidity?") by running queries against large de-identified clinical datasets. Regard wins for routine inpatient decision support embedded in the clinician workflow. Atropos wins for complex clinical questions where randomised trial evidence is absent and real-world data is the best available guide. The two tools address different clinical decision moments and are complementary in advanced clinical settings.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'regard-clinical-vs-atropos-health');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'regard-clinical-vs-atropos-health', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('EHR Workflow Integration',         5, 2, 'Regard embeds directly in EHR sidebar; Atropos is a separate query interface'),
  ('Real-World Evidence Queries',      2, 5, 'Atropos runs on-demand RWE queries against large clinical datasets'),
  ('Routine Inpatient Decision Support', 5, 2, 'Regard designed for hospitalist daily rounding workflow'),
  ('Complex Clinical Question Answering', 2, 5, 'Atropos for rare presentations, treatment dilemmas, evidence gaps'),
  ('Documentation Automation',         5, 1, 'Regard automates diagnosis documentation; Atropos does not'),
  ('Time to Value in Encounter',       5, 3, 'Regard immediate in-chart; Atropos query takes minutes to return'),
  ('Research and Population Analytics', 2, 5, 'Atropos supports clinical research and quality improvement analytics')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'regard-clinical-vs-atropos-health')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'regard-clinical-vs-atropos-health');
