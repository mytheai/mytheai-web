-- compare-batch-57.sql
-- 5 AI Compliance / Legal Ops comparison pairs
-- All tool slugs confirmed in DB from tools-batch-57.sql (vanta, drata, secureframe, sprinto,
--   onetrust, bigid, securiti, evisort, linksquares, auditboard)
-- All pair slugs verified fresh - grepped all prior compare-batch-*.sql files, no collisions found

-- 1. vanta-vs-drata (SOC 2 compliance automation head-to-head)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'vanta-vs-drata',
  'vanta',
  'drata',
  'Vanta and Drata are the two dominant compliance automation platforms for SOC 2, ISO 27001, and HIPAA certification. Both connect to cloud infrastructure and SaaS tools to automate evidence collection and monitor controls continuously. Vanta wins on breadth of integrations (350+), Trust Center for responding to security questionnaires, and brand recognition with enterprise security teams that see SOC 2 reports from hundreds of vendors. Drata wins on depth of automated control testing - continuous real-time testing rather than periodic checks - and multi-framework crosswalk mapping that reduces duplicate evidence for companies managing 5+ frameworks simultaneously. For a startup pursuing its first SOC 2 Type 2, either platform delivers comparable results. For enterprise compliance teams managing multiple frameworks across complex infrastructure, Drata''s continuous testing depth and crosswalk capabilities provide more value in 2026.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'vanta-vs-drata');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'vanta-vs-drata', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Integration Breadth',              5, 4, 'Vanta supports 350+ integrations; Drata has strong coverage but fewer total'),
  ('Continuous Control Testing',       4, 5, 'Drata runs real-time automated tests; Vanta checks are more periodic'),
  ('Multi-Framework Crosswalk',        4, 5, 'Drata crosswalk mapping reduces duplicate evidence across SOC 2, ISO, HIPAA'),
  ('Trust Center / Questionnaire',     5, 3, 'Vanta Trust Center is a standout feature for enterprise security reviews'),
  ('Startup Accessibility',            4, 4, 'Both have entry pricing around $5K/year; similar accessibility for early-stage'),
  ('Policy Management',                4, 5, 'Drata pre-built policy library with version control and employee acknowledgement'),
  ('Auditor Familiarity',              5, 4, 'Vanta brand recognition is stronger with audit firms across the market')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'vanta-vs-drata')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'vanta-vs-drata');

-- 2. secureframe-vs-sprinto (guided SOC 2 platforms for startups)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'secureframe-vs-sprinto',
  'secureframe',
  'sprinto',
  'Secureframe and Sprinto both target startups and growth-stage companies that need to achieve SOC 2 certification without a dedicated compliance function - and both take a more prescriptive, guided approach than Vanta or Drata. Secureframe has stronger brand recognition in the US market, a larger Preferred Auditor network, and slightly deeper SOC 2 evidence automation. Sprinto offers a more opinionated guided workflow that some non-technical founders find easier to navigate, real-time monitoring that catches configuration drift between audit cycles, and a price point accessible to Series A companies. Both deliver the same core outcome - SOC 2 Type 2 in 90 days - at similar price points. The choice typically comes down to which platform''s guided workflow and auditor network better fit the specific startup''s market and audit firm relationship.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'secureframe-vs-sprinto');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'secureframe-vs-sprinto', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('US Market Brand Recognition',      5, 3, 'Secureframe better known among US enterprise procurement teams'),
  ('Guided Onboarding Clarity',        4, 5, 'Sprinto workflow is more opinionated and easier for first-time compliance'),
  ('Preferred Auditor Network',        5, 4, 'Secureframe has a larger US auditor partner network for fast SOC 2 completion'),
  ('Real-Time Control Monitoring',     4, 5, 'Sprinto real-time monitoring catches drift; Secureframe monitoring is good'),
  ('Startup Entry Price',              4, 5, 'Sprinto entry pricing is slightly lower for Series A companies'),
  ('ISO 27001 Support',               4, 4, 'Both support ISO 27001 with similar depth'),
  ('HIPAA Framework Depth',           4, 3, 'Secureframe has slightly stronger HIPAA coverage than Sprinto')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'secureframe-vs-sprinto')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'secureframe-vs-sprinto');

-- 3. onetrust-vs-bigid (enterprise privacy and data governance)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'onetrust-vs-bigid',
  'onetrust',
  'bigid',
  'OneTrust and BigID both address enterprise privacy compliance and data governance, but from different starting points. OneTrust started as a consent management and privacy workflow platform - cookie banners, privacy impact assessments, and GDPR data subject request orchestration - and expanded into data discovery and AI governance. BigID started as a data intelligence platform focused on automatically discovering and classifying personal data across complex enterprise data estates, and built privacy workflow tools on top of that data foundation. OneTrust wins on breadth of privacy workflow coverage, global regulation support (200+ frameworks), and AI governance capabilities. BigID wins on depth of automated data discovery and classification at petabyte scale, and on data security posture management for identifying over-permissioned sensitive data. Large enterprises often use both - OneTrust for privacy workflows and consent, BigID for data estate visibility and security posture.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'onetrust-vs-bigid');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'onetrust-vs-bigid', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Privacy Workflow Breadth',         5, 3, 'OneTrust covers consent, PIA, DSR, vendor risk in one platform'),
  ('Automated Data Discovery',         3, 5, 'BigID ML classification across unstructured and structured data at scale'),
  ('Global Regulation Coverage',       5, 3, 'OneTrust supports 200+ global privacy frameworks'),
  ('Data Security Posture Mgmt',       2, 5, 'BigID identifies over-permissioned sensitive data across the estate'),
  ('Consent Management Layer',         5, 1, 'OneTrust is market leader for cookie banner and consent management'),
  ('AI Governance Module',             4, 3, 'OneTrust AI governance is more mature for EU AI Act compliance'),
  ('Enterprise Data Estate Scale',     3, 5, 'BigID scales to petabyte-level discovery; OneTrust better for workflow volume')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'onetrust-vs-bigid')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'onetrust-vs-bigid');

-- 4. evisort-vs-linksquares (AI contract intelligence platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'evisort-vs-linksquares',
  'evisort',
  'linksquares',
  'Evisort and LinkSquares are both AI contract intelligence platforms that extract and structure data from contract repositories, but they emphasise different use cases. Evisort is stronger on pure analysis depth - handling large repository uploads, M&A due diligence scenarios with thousands of contracts, and complex extraction of custom non-standard clauses. Evisort''s Workday integration is a significant advantage for companies already on that platform. LinkSquares takes a more combined approach, integrating contract analysis (Analyze) with contract authoring and e-signature workflow (Finalize) in a single platform. The Smart Values feature that allows legal teams to define any custom extraction field they need is a genuine differentiator for in-house teams with specific tracking requirements. Evisort wins for analysis depth and M&A workloads. LinkSquares wins for in-house legal teams that want combined drafting and analysis in one platform with business-readable reporting for GC stakeholders.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'evisort-vs-linksquares');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'evisort-vs-linksquares', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Repository Analysis Depth',        5, 4, 'Evisort handles large M&A due diligence repository uploads with more complex extraction'),
  ('Custom Field Extraction',          4, 5, 'LinkSquares Smart Values lets teams define any custom field without relying on templates'),
  ('Contract Authoring Integration',   2, 5, 'LinkSquares Finalize provides contract drafting and e-signature in the same platform'),
  ('Active Learning Accuracy',         5, 3, 'Evisort improves extraction from reviewer corrections more systematically'),
  ('ERP / Platform Integration',       5, 3, 'Evisort Workday integration is a standout advantage for Workday customers'),
  ('GC Board-Level Reporting',         3, 5, 'LinkSquares reporting layer produces business metrics for board communication'),
  ('Obligation Tracking',              5, 4, 'Both track obligations and deadlines; Evisort notification workflow is more mature')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'evisort-vs-linksquares')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'evisort-vs-linksquares');

-- 5. vanta-vs-secureframe (SOC 2 for startups: established vs guided)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'vanta-vs-secureframe',
  'vanta',
  'secureframe',
  'Vanta and Secureframe are the two most common starting points for startups pursuing SOC 2 Type 2 certification, and the decision is one of the most frequently debated in startup compliance circles. Vanta wins on integration breadth (350+ vs Secureframe''s strong but smaller library), Trust Center for handling incoming enterprise security questionnaires, and brand recognition with audit firms and enterprise procurement teams. Secureframe wins on guided onboarding clarity - the platform is more prescriptive about what to do and in what order, which is valuable for first-time compliance teams who don''t know where to start. Secureframe''s Preferred Auditor programme is strong for fast-track SOC 2 engagements. At similar price points, the choice often comes down to whether the startup values breadth and brand (Vanta) or guidance and clarity (Secureframe).',
  'vanta',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'vanta-vs-secureframe');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'vanta-vs-secureframe', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Integration Breadth',              5, 4, 'Vanta 350+ integrations vs Secureframe strong library but fewer total'),
  ('Guided Onboarding for Non-Experts', 3, 5, 'Secureframe more prescriptive step-by-step guidance for first-time compliance teams'),
  ('Trust Center Feature',             5, 2, 'Vanta Trust Center replaces manual security questionnaire responses - Secureframe does not have equivalent'),
  ('Preferred Auditor Network',        4, 5, 'Secureframe Preferred Auditor programme is strong for fast-track engagements'),
  ('AI Gap Analysis',                  4, 5, 'Secureframe AI-powered gap analysis prioritises remediation by audit risk'),
  ('Brand Recognition',                5, 3, 'Vanta has stronger enterprise and audit firm brand recognition'),
  ('Vendor Risk Management',           5, 3, 'Vanta includes more comprehensive vendor risk management module')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'vanta-vs-secureframe')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'vanta-vs-secureframe');
