-- compare-batch-68.sql
-- 5 Government / Public Sector comparison pairs
-- All tool slugs confirmed from tools-batch-68.sql (granicus, opengov, tyler-technologies, accela, zencity, polco, mark43, axon-ai, civicplus, balancing-act)
-- All pair slugs verified fresh - not in any prior compare-batch file
-- Run after tools-batch-68.sql

-- 1. granicus-vs-opengov (civic platform vs public finance ERP)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'granicus-vs-opengov',
  'granicus',
  'opengov',
  'Granicus and OpenGov are both leading govtech platforms, but they address different government pain points. Granicus owns the constituent-facing side of government operations: digital service portals, mass communications, meeting management, and the public experience layer that residents interact with. OpenGov owns the internal finance side: fund accounting, budget development, permitting workflow, and the financial management infrastructure that government runs on. For most governments, these platforms are complementary rather than competitive. When a government must choose where to invest first, the right answer depends on whether the primary pressure is constituent experience and digital services (Granicus) or financial management modernization and budget transparency (OpenGov). Both are 2026 leaders in their respective domains with no clear overall winner.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'granicus-vs-opengov');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'granicus-vs-opengov', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Constituent-Facing Services',  5, 2, 'Granicus powers the resident portal, digital forms, and online service delivery'),
  ('Government Financial Management', 2, 5, 'OpenGov is built specifically for fund accounting and budget development'),
  ('Mass Communications',          5, 2, 'GovDelivery network reaches 300M+ citizen subscribers for notifications'),
  ('Budget Development Workflow',  2, 5, 'OpenGov Budget replaces spreadsheet-based budget processes with scenario modeling'),
  ('Meeting Management',           5, 2, 'Granicus handles agenda creation, public access, and council meeting archiving'),
  ('AI Capabilities',              3, 4, 'OpenGov anomaly detection and NL budget queries are more operationally impactful'),
  ('Market Penetration',           5, 4, 'Granicus serves 6,000+ agencies; OpenGov serves 1,800+ but growing faster')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'granicus-vs-opengov')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'granicus-vs-opengov');

-- 2. tyler-technologies-vs-accela (govtech platform vs permitting specialist)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'tyler-technologies-vs-accela',
  'tyler-technologies',
  'accela',
  'Tyler Technologies and Accela both serve local government, but at very different scopes. Tyler is the broadest govtech platform in the US - courts, public safety, tax, and administration - while Accela specializes in permitting, licensing, and inspections. For a government choosing a permitting platform specifically, Accela''s purpose-built permitting workflows and deeper AI document review capabilities give it an advantage over Tyler''s more generalist permitting module. For governments that need courts, public safety, AND permitting from a single integrated vendor, Tyler''s platform breadth is the stronger argument. The acquisition of Accela by Granicus has added complexity to the competitive picture, with some governments now reconsidering their Accela roadmap commitment.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'tyler-technologies-vs-accela');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'tyler-technologies-vs-accela', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Platform Breadth',             5, 3, 'Tyler covers courts, public safety, tax, and permitting; Accela focuses on permitting only'),
  ('Permitting Workflow Depth',    3, 5, 'Accela''s permitting workflows are more specialized and configurable than Tyler''s'),
  ('AI Document Review',           3, 4, 'Accela''s AI plan review and document extraction is more mature for permitting'),
  ('Courts and Justice Systems',   5, 1, 'Tyler Odyssey is the US market leader; Accela has no courts functionality'),
  ('Public Safety Integration',    5, 1, 'Tyler''s CAD and RMS are direct public safety platforms; Accela does not compete'),
  ('Government Client Count',      5, 4, 'Tyler serves 42,000+ entities; Accela is a large platform but smaller footprint'),
  ('Vendor Stability',             4, 3, 'Accela acquisition by Granicus introduces roadmap uncertainty for existing customers')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'tyler-technologies-vs-accela')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'tyler-technologies-vs-accela');

-- 3. zencity-vs-polco (community intelligence vs resident polling)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'zencity-vs-polco',
  'zencity',
  'polco',
  'Zencity and Polco both help local governments understand resident opinion, but they take fundamentally different approaches. Zencity is a continuous monitoring platform - it listens passively to social media, 311 data, and other public channels to surface community sentiment shifts and emerging issues without asking residents to do anything. Polco is an active engagement platform - it runs structured surveys and polls to get direct resident input on specific questions. Zencity excels at early warning and trend detection; Polco excels at gathering statistically representative input on specific decisions. Many governments use both: Zencity for ongoing situational awareness and Polco for structured input on specific decisions like capital budgets or policy changes.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zencity-vs-polco');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'zencity-vs-polco', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Passive Sentiment Monitoring', 5, 1, 'Zencity continuously monitors social media, 311, and news; Polco only captures active respondents'),
  ('Structured Survey Tools',      2, 5, 'Polco''s survey platform is purpose-built for government polling with distribution tools'),
  ('National Benchmarking Data',   1, 5, 'Polco has benchmarks from hundreds of US communities; Zencity does not'),
  ('Early Warning Alerts',         5, 2, 'Zencity surfaces emerging issues before they become political problems; Polco is reactive'),
  ('AI Analysis Quality',          4, 4, 'Both provide AI summarization and theme extraction for their respective data types'),
  ('Free Plan Availability',       1, 4, 'Polco has a free tier for basic polling; Zencity requires subscription'),
  ('Demographic Representativeness', 3, 4, 'Polco''s demographic weighting is more rigorous for policy-quality input')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'zencity-vs-polco')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'zencity-vs-polco');

-- 4. mark43-vs-axon-ai (cloud-native RMS vs AI-native public safety)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'mark43-vs-axon-ai',
  'mark43',
  'axon-ai',
  'Mark43 and Axon AI are both cloud-native public safety technology companies, but they compete differently within the law enforcement technology ecosystem. Mark43 is primarily a CAD and RMS platform - it handles dispatch and records management for agencies that want to replace legacy on-premise systems. Axon AI is the intelligence layer built on top of body camera hardware and the Evidence.com platform, with Draft One being the headline 2026 AI capability. Agencies that already have Axon body cameras get the most value from Axon AI, as Draft One generates reports from the camera audio. Mark43 competes more directly with Tyler Technologies on CAD and RMS. For agencies choosing between platforms, the evaluation often comes down to hardware ecosystem: Axon agencies have strong reasons to invest in Axon AI, while agencies on other camera systems often land on Mark43 as the cloud-native RMS alternative to legacy vendors.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mark43-vs-axon-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'mark43-vs-axon-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('CAD and Dispatch Management',  5, 2, 'Mark43 CAD is a full dispatch platform; Axon AI integrates with but does not replace CAD'),
  ('Records Management System',    5, 3, 'Mark43 RMS is the core product; Axon Records is add-on to the evidence platform'),
  ('AI Report Generation',         4, 5, 'Axon Draft One generates reports from body camera audio - faster and more contextual than Mark43'),
  ('Body Camera Integration',      2, 5, 'Axon body cameras with Draft One is the tightest AI-hardware integration in public safety'),
  ('Video Evidence Management',    2, 5, 'Evidence.com is the market standard for digital evidence; Mark43 integrates but does not compete'),
  ('Agency Scale Validation',      4, 5, 'Both deployed at major US cities; Axon''s 17,000-agency base is larger'),
  ('Vendor Ecosystem Independence', 5, 2, 'Mark43 works with any body camera; Axon AI is most valuable with Axon hardware')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'mark43-vs-axon-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'mark43-vs-axon-ai');

-- 5. civicplus-vs-granicus (local government website platform vs constituent engagement platform)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'civicplus-vs-granicus',
  'civicplus',
  'granicus',
  'CivicPlus and Granicus both serve local government digital needs, and their product suites overlap considerably - both offer government website platforms, meeting management, and citizen communications. The meaningful difference is scale and depth. CivicPlus is the most widely deployed local government website platform by client count - over 10,000 clients - largely because it targets smaller cities and counties that need a compliant, maintainable government website without the budget for a larger vendor relationship. Granicus is the market leader by capability depth and enterprise scale, with the GovDelivery communications network and broader platform integrations making it the stronger choice for larger governments with more complex needs. CivicPlus is often the entry point for small governments; Granicus is where larger governments land when they need more sophisticated constituent engagement.',
  'granicus',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'civicplus-vs-granicus');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'civicplus-vs-granicus', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Government Client Count',      5, 4, 'CivicPlus has 10,000+ clients by volume; Granicus leads on large-agency depth'),
  ('Mass Communications Scale',    3, 5, 'Granicus GovDelivery network (300M subscribers) far exceeds CivicPlus notification reach'),
  ('Digital Forms and Services',   3, 5, 'Granicus has deeper transactional digital service capability across more use cases'),
  ('Small Government Accessibility', 5, 3, 'CivicPlus pricing and implementation is more accessible for small cities and towns'),
  ('ADA Compliance Tools',         4, 4, 'Both provide WCAG compliance tools; CivicPlus AI accessibility scanning is well-regarded'),
  ('Meeting Management',           4, 4, 'Both handle agenda-to-minutes workflow; Granicus has more enterprise features'),
  ('Platform Stability Post-Acquisition', 4, 3, 'CivicPlus is independent; Granicus acquired Accela which creates some integration uncertainty')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'civicplus-vs-granicus')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'civicplus-vs-granicus');
