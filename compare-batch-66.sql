-- compare-batch-66.sql
-- 5 Manufacturing / Industry 4.0 comparison pairs
-- All tool slugs confirmed from tools-batch-66.sql (S80)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. landing-ai-vs-cognex (computer vision inspection - software-first vs hardware leader)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'landing-ai-vs-cognex',
  'landing-ai',
  'cognex',
  'Landing AI and Cognex represent two distinct approaches to AI-powered manufacturing inspection in 2026. Landing AI takes a software-first approach: LandingLens enables process engineers to build custom deep learning models from labeled images without ML expertise, deploying to any compatible industrial camera at the factory. Cognex combines proprietary hardware cameras and vision sensors with VisionPro Deep Learning software, offering a fully integrated stack optimized for high-speed production line inspection. Landing AI wins for manufacturers that want to build internal AI capabilities and deploy on existing hardware. Cognex wins for greenfield automation projects where reliability at production line speeds and deep integrations with PLC and robot platforms are the top priority.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'landing-ai-vs-cognex');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'landing-ai-vs-cognex', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Ease of Model Development',    5, 3, 'LandingLens browser workflow is designed for process engineers; Cognex requires more vision expertise'),
  ('Hardware Integration',         3, 5, 'Cognex owns the full hardware stack; Landing AI deploys to third-party cameras'),
  ('Inspection Speed',             3, 5, 'Cognex systems are optimized for high-speed production lines; Landing AI edge deployment has more variability'),
  ('Custom Defect Detection',      5, 4, 'Landing AI active learning compresses custom model development; Cognex VisionPro Deep Learning is also strong'),
  ('Enterprise Support',           4, 5, 'Cognex has a global certified integrator network; Landing AI has expert advisory but smaller field footprint'),
  ('Total Cost of Ownership',      4, 3, 'Landing AI on existing hardware reduces capex; Cognex full deployments require significant hardware investment'),
  ('AI Advisory and Training',     5, 3, 'Landing AI includes AI transformation consulting; Cognex is focused on machine vision product support')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'landing-ai-vs-cognex')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'landing-ai-vs-cognex');

-- 2. augury-vs-uptake (predictive maintenance - rotating equipment vs heavy industrial fleets)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'augury-vs-uptake',
  'augury',
  'uptake',
  'Augury and Uptake are both leading predictive maintenance AI platforms in 2026 but serve different industrial contexts. Augury specializes in continuous vibration and ultrasound monitoring for rotating equipment - pumps, compressors, fans, and motors - in manufacturing facilities, using always-on physical sensors and AI models trained on over a trillion data points. Uptake focuses on heavy industrial assets in energy, rail, construction, and mining, applying machine learning to historian and sensor data from turbines, locomotives, and fleet vehicles without always-on physical sensors. Augury wins for plant maintenance teams monitoring rotating equipment in food, pharma, and manufacturing. Uptake wins for asset-intensive industries managing large fleets of heavy equipment in the field.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'augury-vs-uptake');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'augury-vs-uptake', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Rotating Equipment Coverage',  5, 3, 'Augury is purpose-built for pumps, compressors, fans, motors - Uptake covers broader asset types'),
  ('Heavy Equipment and Fleet',    3, 5, 'Uptake has stronger coverage for turbines, locomotives, and construction equipment fleets'),
  ('Always-On Monitoring',         5, 3, 'Augury uses continuous physical sensors; Uptake relies on existing historian data without new sensors'),
  ('Diagnostic Specificity',       5, 4, 'Augury names specific fault types with recommended actions; Uptake provides risk scores and failure mode probability'),
  ('CMMS Integration',             4, 5, 'Uptake has deeper SAP PM and IBM Maximo integrations for automatic work order generation'),
  ('Human Expert Support',         5, 3, 'Augury pairs software with reliability engineers; Uptake is primarily a self-serve analytics platform'),
  ('Global Deployment Scale',      5, 4, 'Augury claims wider global manufacturing deployments; Uptake has strong North American industrial presence')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'augury-vs-uptake')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'augury-vs-uptake');

-- 3. instrumental-vs-relimetrics (quality inspection - electronics/consumer hardware vs automotive/aerospace)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'instrumental-vs-relimetrics',
  'instrumental',
  'relimetrics',
  'Instrumental and Relimetrics are both AI quality inspection platforms focused on high-value discrete manufacturing, but their target markets differ significantly in 2026. Instrumental was built for consumer electronics, medical device, and complex hardware manufacturers - particularly those operating through contract manufacturing relationships where the OEM brand owner needs visibility into factory quality data without direct control of the production line. Relimetrics specializes in automotive and aerospace inspection, with particular strength in weld inspection and the regulatory traceability requirements of IATF 16949 and AS9100. Instrumental wins for electronics OEMs managing contract manufacturers. Relimetrics wins for Tier 1 and Tier 2 automotive and aerospace suppliers needing weld and structural inspection with full compliance documentation.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'instrumental-vs-relimetrics');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'instrumental-vs-relimetrics', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Electronics and Hardware OEM',   5, 2, 'Instrumental is purpose-built for consumer electronics and medical device contract manufacturing'),
  ('Automotive and Aerospace',       2, 5, 'Relimetrics is specialized for automotive body and aerospace structural component inspection'),
  ('Weld Inspection',                3, 5, 'Relimetrics weld inspection handles morphological variation that defeats rule-based systems'),
  ('Contract Manufacturing Support', 5, 2, 'Instrumental provides OEM-CM shared data visibility; Relimetrics is plant-internal focused'),
  ('Multi-Modal Inspection',         3, 4, 'Relimetrics combines camera, laser, and ultrasound in 2026; Instrumental is primarily image-based'),
  ('Root Cause Analysis Speed',      5, 4, 'Instrumental AI root cause compresses investigations from weeks to hours across manufacturing data'),
  ('Compliance Documentation',       3, 5, 'Relimetrics generates IATF 16949 and AS9100 audit trail per part; Instrumental is less regulatory-focused')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'instrumental-vs-relimetrics')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'instrumental-vs-relimetrics');

-- 4. c3-ai-vs-sight-machine (enterprise industrial AI platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'c3-ai-vs-sight-machine',
  'c3-ai',
  'sight-machine',
  'C3 AI and Sight Machine are both enterprise industrial AI platforms in 2026, but they address different organizational needs. C3 AI is a horizontal enterprise AI platform with pre-built applications spanning predictive maintenance, inventory optimization, fraud detection, and CRM - designed for large enterprises that want a single AI infrastructure investment across multiple use cases. Sight Machine is a manufacturing analytics platform purpose-built for process optimization in production operations, focused on connecting disparate factory data sources to deliver OEE, yield, and quality analytics. C3 AI wins for large enterprises deploying AI across multiple business domains simultaneously. Sight Machine wins for process manufacturers that need to unify factory data and optimize production performance within the plant.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'c3-ai-vs-sight-machine');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'c3-ai-vs-sight-machine', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Multi-Use-Case AI Platform',    5, 2, 'C3 AI spans predictive maintenance, supply chain, CRM, and more; Sight Machine is manufacturing-specific'),
  ('Manufacturing Analytics Depth', 3, 5, 'Sight Machine delivers deeper OEE, yield, and quality analytics purpose-built for production operations'),
  ('Data Source Integration',       4, 4, 'Both handle historian, MES, and ERP integration; Sight Machine has stronger factory-specific connectors'),
  ('Enterprise Scale',              5, 3, 'C3 AI has US Air Force and major oil and gas deployments; Sight Machine is focused on process manufacturers'),
  ('Implementation Complexity',     4, 4, 'Both require significant professional services; C3 AI is broader in scope so typically longer to deploy'),
  ('Time to Value',                 3, 4, 'Sight Machine factory analytics can show OEE results faster than C3 AI multi-domain deployments'),
  ('Total Contract Value',          3, 4, 'C3 AI targets larger contracts; Sight Machine is enterprise but with a lower floor for initial engagement')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'c3-ai-vs-sight-machine')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'c3-ai-vs-sight-machine');

-- 5. elementary-vs-instrumental (visual inspection - SMB self-deploy vs OEM root cause analysis)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'elementary-vs-instrumental',
  'elementary',
  'instrumental',
  'Elementary and Instrumental are both AI visual inspection platforms in 2026, but they target opposite ends of the manufacturing market. Elementary is built for SMB manufacturers replacing manual inspection with affordable, self-deployable AI using standard industrial cameras - making AI quality control accessible without capital-intensive machine vision projects. Instrumental is built for complex hardware OEMs managing multi-million unit production volumes through contract manufacturers, where root cause analysis across thousands of captured images and process variables is the primary value driver. Elementary wins for small and mid-size manufacturers doing initial AI inspection deployment. Instrumental wins for high-volume hardware OEMs where yield improvements of fractions of a percent represent millions of dollars and field failure root cause is a core need.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'elementary-vs-instrumental');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'elementary-vs-instrumental', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('SMB Accessibility',              5, 2, 'Elementary is priced and designed for SMB manufacturers; Instrumental targets OEM enterprise contracts'),
  ('Self-Deployment',                5, 2, 'Elementary deploys without specialist integrators; Instrumental requires an implementation engagement'),
  ('Root Cause Analysis',            2, 5, 'Instrumental AI root cause analysis across captured images is the core differentiator for OEM customers'),
  ('Contract Manufacturing Support', 2, 5, 'Instrumental bridges OEM and CM data visibility gaps; Elementary is focused on single-site operations'),
  ('Camera Compatibility',           5, 3, 'Elementary works with any standard industrial camera; Instrumental requires specific hardware at stations'),
  ('Time to First Deployment',       5, 3, 'Elementary deploys in days from image collection to live station; Instrumental requires longer pilot setup'),
  ('Volume Scale',                   3, 5, 'Instrumental is designed for multi-million unit production volumes; Elementary suits lower-volume SMB lines')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'elementary-vs-instrumental')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'elementary-vs-instrumental');
