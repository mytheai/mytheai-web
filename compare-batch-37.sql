-- compare-batch-37.sql
-- 5 AI Healthcare tool comparison pairs
-- All batch-37 tools confirmed in DB; run AFTER tools-batch-37 confirmed
-- Safe to re-run: ON CONFLICT DO NOTHING + WHERE NOT EXISTS guards

-- 1. nabla vs suki-ai
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'nabla-vs-suki-ai', 'nabla', 'suki-ai',
  'Nabla uses ambient AI to passively listen to physician-patient conversations and generate structured clinical notes automatically, requiring no active input from the clinician. Suki AI is a voice-activated assistant where physicians dictate notes and issue voice commands to navigate the EHR. Nabla wins for completely hands-free ambient documentation; Suki AI wins for physicians who prefer explicit voice control and direct dictation over passive capture.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'nabla-vs-suki-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'nabla-vs-suki-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Note Generation Quality',  5, 4, 'Nabla generates comprehensive SOAP notes from ambient conversation with high accuracy. Suki generates accurate dictated notes but relies on explicit physician input rather than passive capture.'),
  ('Hands-Free Documentation',    5, 2, 'Nabla is fully ambient - the physician does nothing beyond having a conversation. Suki requires active dictation and voice commands throughout the encounter.'),
  ('EHR Integration Depth',       4, 5, 'Suki integrates with Epic, Cerner, and eClinicalWorks with deep voice navigation capabilities. Nabla integrates with major EHRs but with less deep voice command control.'),
  ('Physician Control',           2, 5, 'Suki gives physicians explicit control over note content and structure via voice. Nabla generates notes automatically - physicians review and edit rather than dictate.'),
  ('Mobile Experience',           4, 4, 'Both tools have mobile apps suitable for rounding and on-call workflows. Comparable mobile experience.'),
  ('Adoption Ease',               4, 3, 'Nabla requires minimal training since the physician just talks naturally. Suki has a learning curve for voice command syntax and workflow integration.'),
  ('Pricing',                     3, 3, 'Both are enterprise-priced tools requiring health system contracts. Individual physician plans available on both but pricing is not publicly listed.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'nabla-vs-suki-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'nabla-vs-suki-ai');

-- 2. abridge vs nuance-dax
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'abridge-vs-nuance-dax', 'abridge', 'nuance-dax',
  'Abridge is an ambient AI documentation platform built with academic medical centres, deeply integrated with Epic and validated by peer-reviewed research. Nuance DAX (Dragon Ambient eXperience) is Microsoft''s enterprise ambient documentation solution backed by decades of Dragon voice recognition, integrated with all major EHRs through the Microsoft ecosystem. Abridge wins for Epic-heavy academic centres that prioritise research-grade validation; Nuance DAX wins for large health systems in the Microsoft ecosystem seeking broad EHR compatibility.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'abridge-vs-nuance-dax');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'abridge-vs-nuance-dax', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Note Generation Accuracy',    5, 4, 'Abridge has strong peer-reviewed clinical validation from UPMC. Nuance DAX leverages decades of Dragon accuracy data and Azure OpenAI - both excellent but Abridge has stronger published evidence.'),
  ('EHR Integration Breadth',     3, 5, 'Nuance DAX integrates with Epic, Oracle Health, and all major EHRs through Microsoft partnerships. Abridge is primarily Epic-native with expanding integrations.'),
  ('Academic/Research Validation',5, 3, 'Abridge was developed with UPMC and has multiple peer-reviewed publications. Nuance DAX has strong enterprise evidence but less academic medical centre research.'),
  ('Enterprise Scale',            3, 5, 'Nuance/Microsoft can deploy to very large health systems with existing Microsoft relationships. Abridge is scaling but with a smaller enterprise footprint.'),
  ('Privacy and Compliance',      5, 5, 'Both are HIPAA-compliant with BAAs, SOC 2 Type II, and enterprise security controls. Comparable compliance posture.'),
  ('Physician Time Saved',        5, 5, 'Both tools consistently report 1-2 hours of documentation time saved per physician per day in clinical studies. Comparable outcome.'),
  ('Pricing',                     3, 3, 'Both require enterprise contracts - pricing is not publicly listed. Nuance has Microsoft enterprise agreement bundling which may be advantageous for existing Microsoft customers.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'abridge-vs-nuance-dax')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'abridge-vs-nuance-dax');

-- 3. glass-health vs corti
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'glass-health-vs-corti', 'glass-health', 'corti',
  'Glass Health is a clinical reasoning AI that helps physicians build differential diagnoses and assessment plans from patient descriptions, optimised for planned clinical thinking and education. Corti is a real-time AI that listens during emergency calls and clinical encounters, detecting critical diagnoses and supporting triage decisions as the conversation unfolds. Glass Health wins for clinical reasoning assistance and medical education; Corti wins for real-time emergency triage and decision support.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'glass-health-vs-corti');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'glass-health-vs-corti', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Clinical Reasoning Depth',    5, 3, 'Glass Health generates structured differentials with supporting rationale. Corti focuses on pattern detection and critical flag identification rather than comprehensive differential building.'),
  ('Real-Time Capability',        2, 5, 'Corti processes live audio in real time during calls and encounters. Glass Health requires a physician to actively type a clinical vignette - it is not a passive listener.'),
  ('Emergency Medicine Fit',      2, 5, 'Corti is purpose-built for emergency settings - rapid triage, dispatch support, and critical symptom flagging. Glass Health is not optimised for real-time emergency contexts.'),
  ('Medical Education Value',     5, 2, 'Glass Health is widely used in medical education for case-based learning and differential reasoning practice. Corti is not designed for educational contexts.'),
  ('EHR Integration',             3, 4, 'Corti integrates with emergency dispatch systems and ER EHRs. Glass Health is EHR-agnostic, working as a standalone clinical reasoning tool.'),
  ('Evidence Base',               4, 4, 'Corti has published studies on cardiac arrest detection accuracy. Glass Health is newer but gaining validation in clinical settings. Both have meaningful evidence.'),
  ('Pricing Accessibility',       5, 2, 'Glass Health has a free tier for individual clinicians. Corti is enterprise-priced for health system and dispatch centre deployment.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'glass-health-vs-corti')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'glass-health-vs-corti');

-- 4. aidoc vs regard
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'aidoc-vs-regard', 'aidoc', 'regard',
  'Aidoc is a radiology AI platform that analyzes medical imaging in real time, prioritizing urgent scans and flagging critical findings like pulmonary embolism, intracranial hemorrhage, and aortic dissection. Regard is an inpatient AI diagnostician that monitors hospitalized patient data inside Epic, surfacing missed diagnoses and ICD coding suggestions for complex inpatients. These tools solve fundamentally different problems: Aidoc wins for radiology departments managing imaging triage; Regard wins for hospitalist teams managing complex inpatients and billing accuracy.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'aidoc-vs-regard');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'aidoc-vs-regard', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Primary Clinical Domain',     4, 4, 'Aidoc serves radiology departments - imaging triage and critical finding detection. Regard serves hospital medicine - inpatient diagnosis and ICD coding. Both are best-in-class for their specific domain.'),
  ('Real-Time Processing',        5, 4, 'Aidoc analyzes imaging as it is acquired, flagging findings before the radiologist opens the study. Regard surfaces diagnoses continuously as new patient data is added to Epic.'),
  ('EHR Integration',             4, 5, 'Regard is Epic-native with deep integration. Aidoc integrates with PACS systems and EHRs but requires more complex radiology IT infrastructure.'),
  ('Clinical Evidence Strength',  5, 4, 'Aidoc has FDA clearance for multiple imaging use cases and published studies on PE and ICH detection. Regard has strong UPMC validation evidence for inpatient diagnosis accuracy.'),
  ('Revenue and Billing Impact',  2, 5, 'Regard directly improves ICD coding accuracy and captures missed diagnoses that affect billing. Aidoc''s revenue impact is indirect through workflow efficiency and critical finding response time.'),
  ('Implementation Complexity',   3, 4, 'Aidoc requires PACS integration and radiology IT collaboration. Regard deploys as an Epic application with less integration complexity.'),
  ('Pricing',                     3, 3, 'Both are enterprise-priced tools requiring health system contracts. Neither publishes list pricing publicly.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'aidoc-vs-regard')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'aidoc-vs-regard');

-- 5. doximity vs anterior
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'doximity-vs-anterior', 'doximity', 'anterior',
  'Doximity is the professional network for US physicians, with AI tools for clinical dictation, secure messaging, and telehealth embedded in a platform used by over 80% of US doctors. Anterior is an AI platform that automates prior authorization workflows for health systems and payers, reducing the administrative burden of insurance approval processes. These tools address entirely different needs: Doximity serves physician clinical productivity and networking; Anterior serves payer-provider administrative automation. The comparison is useful for healthcare administrators evaluating where to invest AI budget.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'doximity-vs-anterior');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'doximity-vs-anterior', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Physician Productivity',      5, 2, 'Doximity directly improves physician productivity with dictation, messaging, and EHR-connected tools. Anterior automates administrative workflows - it does not directly impact physician clinical time.'),
  ('Administrative Automation',   2, 5, 'Anterior is purpose-built for prior authorization automation - a major administrative burden in US healthcare. Doximity does not address payer-provider administrative workflows.'),
  ('Market Adoption',             5, 3, 'Doximity is used by over 80% of US physicians - extraordinary network penetration. Anterior is a newer, rapidly growing platform with adoption concentrated in large health systems.'),
  ('Revenue Impact',              3, 5, 'Anterior directly reduces prior auth denial rates and administrative labor cost. Doximity''s revenue impact is indirect through physician retention and satisfaction.'),
  ('Implementation Requirements', 5, 3, 'Doximity requires no IT integration for physicians - they download the app. Anterior requires integration with EHR and payer portals which has meaningful implementation complexity.'),
  ('Time Saved Per Use',          4, 5, 'Anterior can save hours of prior auth work per case. Doximity saves minutes per dictation. Anterior has higher per-task time savings; Doximity affects more daily workflows.'),
  ('Pricing Model',               5, 2, 'Doximity is free for physicians. Anterior requires enterprise contracts with health systems. Doximity wins on accessibility; Anterior is an ROI-justified enterprise investment.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'doximity-vs-anterior')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'doximity-vs-anterior');
