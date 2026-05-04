-- compare-batch-71.sql
-- 5 AI Aerospace and Defense comparison pairs
-- All tool slugs confirmed from tools-batch-71.sql (palantir, anduril, shield-ai, maxar, slingshot-aerospace, hawkeye-360, planet-labs, helsing, rebellion-defense, scale-ai-defense)
-- c3-ai from tools-batch-66.sql (confirmed in DB)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. palantir-vs-c3-ai (data fusion platform vs enterprise AI platform)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'palantir-vs-c3-ai',
  'palantir',
  'c3-ai',
  'Palantir and C3.ai are both enterprise AI platforms with significant defense and government revenue, but they approach the problem from fundamentally different architectural angles. Palantir is built around data fusion and intelligence - integrating heterogeneous data sources into a unified operational picture with a graph-based model designed for multi-source intelligence analysis. C3.ai is built around enterprise AI application deployment - providing a model-driven development platform that accelerates building and deploying specific AI applications on top of existing enterprise data. In defense contexts, Palantir wins on operational credibility - it runs on active missions for US Special Operations Command and NATO. C3.ai has strong US Air Force and defense contractor relationships but less mission-critical deployment track record. For commercial enterprise customers, C3.ai''s application library across predictive maintenance, fraud detection, and supply chain optimization is broader and faster to deploy. The choice typically follows the use case: operational intelligence and data fusion favors Palantir; enterprise AI application deployment favors C3.ai.',
  'palantir',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'palantir-vs-c3-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'palantir-vs-c3-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Defense Deployment Track Record', 5, 3, 'Palantir runs on active missions for USSOCOM and NATO; C3.ai has contracts but less mission-critical deployment'),
  ('Multi-Source Data Fusion',        5, 3, 'Palantir''s graph-based intelligence fusion is its core differentiator; C3.ai focuses on application deployment'),
  ('Enterprise AI Application Library', 3, 5, 'C3.ai has a broader pre-built application library for predictive maintenance, fraud, and supply chain in 2026'),
  ('Commercial Enterprise Adoption',  3, 4, 'C3.ai has broader commercial enterprise deployment outside defense; Palantir''s commercial growth is newer'),
  ('Natural Language Querying',       4, 4, 'Both have LLM integration in 2026; Palantir AIP vs C3 Generative AI are comparable in capability'),
  ('Implementation Timeline',         2, 3, 'Both require significant implementation investment; C3.ai application templates reduce initial setup time'),
  ('Pricing Transparency',            2, 2, 'Both require enterprise sales engagement - no self-serve pricing for either platform')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'palantir-vs-c3-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'palantir-vs-c3-ai');

-- 2. anduril-vs-shield-ai (autonomous systems platform vs autonomous flight AI)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'anduril-vs-shield-ai',
  'anduril',
  'shield-ai',
  'Anduril and Shield AI represent two different but complementary approaches to AI-powered autonomous defense systems. Anduril builds a full-stack autonomous defense platform - the Lattice AI operating system integrates sensors, drones, autonomous vehicles, and human operators across multiple domains. Shield AI is specifically focused on AI pilots for autonomous aircraft operation in GPS-denied and communications-denied environments, where commercial autonomous systems fail. Anduril is the more comprehensive platform: it spans border surveillance, maritime monitoring, and multi-domain command and control. Shield AI is the deeper specialist: Hivemind has been demonstrated defeating a human F-16 pilot in simulated air combat, a validated technical claim that Anduril has not matched in the air domain. The two companies are more often complementary than competing - a procurement program might use Anduril''s Lattice for command and control while evaluating Shield AI''s Hivemind for autonomous aircraft integration.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'anduril-vs-shield-ai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'anduril-vs-shield-ai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Multi-Domain Capability',      5, 2, 'Anduril Lattice spans ground, air, and maritime domains; Shield AI focuses primarily on air'),
  ('Autonomous Flight AI',         3, 5, 'Shield AI Hivemind is the leading autonomous aircraft AI - DARPA demonstration vs human F-16 pilot'),
  ('GPS-Denied Operation',         3, 5, 'Shield AI specifically built for GPS and comms-denied environments - Anduril less focused on this scenario'),
  ('Operational Deployment Scale', 4, 3, 'Anduril has broader operational deployments (USCBP, USSOCOM, RAAF); Shield AI has fewer but high-profile deployments'),
  ('Software Development Velocity', 4, 4, 'Both are software-first companies with faster update cycles than traditional defense primes'),
  ('Command and Control Interface', 5, 2, 'Anduril Lattice is purpose-built for multi-system command and control; Shield AI is focused on the aircraft AI layer'),
  ('Platform Licensing Model',     3, 4, 'Shield AI licenses Hivemind to prime contractors; Anduril sells integrated hardware-software systems')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'anduril-vs-shield-ai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'anduril-vs-shield-ai');

-- 3. maxar-vs-planet-labs (high-resolution satellite imagery vs high-revisit satellite data)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'maxar-vs-planet-labs',
  'maxar',
  'planet-labs',
  'Maxar and Planet Labs represent the two dominant commercial satellite imagery approaches in 2026, with a fundamental tradeoff between resolution and revisit frequency. Maxar operates a small constellation of high-capability satellites that capture imagery at 30-centimeter resolution - sufficient to identify individual vehicles and equipment changes at specific facilities. Planet operates a large constellation of smaller satellites that images every point on Earth daily at 3-5 meter resolution. Maxar wins when you need to see exactly what is at a specific location in detail. Planet wins when you need to monitor change across large areas or track events that unfold daily. Intelligence applications typically use both - Maxar for detailed facility analysis and Planet for wide-area change detection that cues tasking of Maxar''s higher-resolution collection. Commercial customers choose based on their monitoring need: supply chain verification and construction monitoring often use Planet for daily coverage; specific facility monitoring and object identification use Maxar.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'maxar-vs-planet-labs');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'maxar-vs-planet-labs', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Image Resolution',           5, 3, 'Maxar captures at 30cm - enough to identify vehicles; Planet at 3-5m for change detection and area monitoring'),
  ('Daily Revisit Frequency',    2, 5, 'Planet images every point on Earth daily; Maxar tasking has lead times for specific collection requests'),
  ('Global Coverage Scale',      3, 5, 'Planet''s 200+ satellite constellation provides near-complete daily Earth coverage'),
  ('Intelligence Validation',    5, 3, 'Maxar imagery has been the public standard for conflict monitoring in Ukraine, Gaza, and other theaters'),
  ('Commercial Pricing Access',  2, 4, 'Planet has more accessible subscription tiers for commercial buyers; Maxar typically requires large contracts'),
  ('AI Analysis Platform',       4, 3, 'Both have geospatial AI analytics; Maxar SecureWatch is more mature for enterprise workflows'),
  ('Change Detection at Scale',  2, 5, 'Planet''s daily revisit enables automated change detection across entire regions - Maxar cannot match this frequency')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'maxar-vs-planet-labs')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'maxar-vs-planet-labs');

-- 4. helsing-vs-rebellion-defense (European sovereign AI vs US AI-native defense software)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'helsing-vs-rebellion-defense',
  'helsing',
  'rebellion-defense',
  'Helsing and Rebellion Defense are both AI-native defense software companies positioned as challengers to traditional prime contractors, but they serve fundamentally different customer bases and geographies. Helsing is the leading European defense AI company, building AI systems for European and NATO military platforms with a strong emphasis on supply chain sovereignty - European defense customers need AI capabilities that do not depend on US-controlled technology for combat aircraft deployment. Rebellion Defense is a US-focused defense AI company that builds AI-enabled software for US DoD missions, positioning itself similarly to Anduril as a faster-moving software-first alternative to legacy primes. Helsing''s BAE Systems Eurofighter partnership and Bundeswehr deployments give it strong European platform credibility. Rebellion''s background in US intelligence community technology and Department of the Air Force focus gives it different but equally valuable US government relationships. The two companies rarely compete directly - Helsing serves European procurement and Rebellion serves US procurement.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'helsing-vs-rebellion-defense');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'helsing-vs-rebellion-defense', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('European Defense Market',    5, 1, 'Helsing is purpose-built for European and NATO defense customers; Rebellion is US-focused'),
  ('US Defense Market',          1, 5, 'Rebellion Defense focuses on US DoD and intelligence community; Helsing has limited US presence'),
  ('Electronic Warfare AI',      5, 3, 'Helsing is deploying EW AI on Eurofighter Typhoon - a validated platform integration'),
  ('Supply Chain Sovereignty',   5, 2, 'Helsing''s European ownership is a strategic requirement for sensitive military platform integration in Europe'),
  ('AI Software Development Speed', 4, 4, 'Both are software-first companies moving faster than traditional primes'),
  ('Platform Deployment Track Record', 4, 3, 'Helsing has BAE Systems Eurofighter and Bundeswehr deployments; Rebellion has DoD program engagements'),
  ('Funding and Stability',      4, 3, 'Helsing raised significant European funding in 2023; Rebellion is well-funded but in a more competitive US market')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'helsing-vs-rebellion-defense')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'helsing-vs-rebellion-defense');

-- 5. slingshot-aerospace-vs-hawkeye-360 (space domain awareness vs RF spectrum intelligence)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'slingshot-aerospace-vs-hawkeye-360',
  'slingshot-aerospace',
  'hawkeye-360',
  'Slingshot Aerospace and HawkEye 360 both operate satellite-based intelligence services for defense, government, and commercial customers, but they collect fundamentally different data. Slingshot Aerospace focuses on space domain awareness - tracking objects in orbit, monitoring satellite behavior, providing debris collision alerts, and characterizing the activities of potentially adversarial satellites. HawkEye 360 operates a constellation of formation-flying satellites that detect and geolocate radio frequency emissions on Earth - finding ships transmitting AIS signals, detecting radar systems, locating communications sources, and monitoring spectrum activity from orbit. Both capabilities are growing in strategic importance as space becomes contested and as RF emitter geolocation becomes a priority intelligence collection method. Defense customers frequently need both: space situational awareness to protect their own satellite assets, and RF geolocation to characterize adversary ground activities. Commercial customers use HawkEye 360 for maritime domain awareness and vessel monitoring; Slingshot serves commercial satellite operators managing debris risk and orbital safety.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'slingshot-aerospace-vs-hawkeye-360');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'slingshot-aerospace-vs-hawkeye-360', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Space Domain Awareness',     5, 1, 'Slingshot is purpose-built for orbital tracking, debris monitoring, and satellite characterization'),
  ('RF Signal Geolocation',      1, 5, 'HawkEye 360 is the leading commercial RF geolocation satellite service - core capability Slingshot lacks'),
  ('Maritime Domain Awareness',  2, 5, 'HawkEye 360 detects dark vessels and monitors AIS signals - widely used for maritime intelligence'),
  ('Commercial Satellite Safety', 5, 2, 'Slingshot''s debris tracking and collision avoidance services are directly relevant for satellite operators'),
  ('Defense Intelligence Value', 4, 4, 'Both provide unique intelligence value - space awareness vs ground-based emitter detection are complementary'),
  ('Commercial Customer Base',   3, 4, 'HawkEye 360 has broader commercial maritime customer base; Slingshot primarily government and satellite operators'),
  ('Data Update Frequency',      4, 4, 'Both provide near-real-time updates from their satellite constellations for their respective domains')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'slingshot-aerospace-vs-hawkeye-360')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'slingshot-aerospace-vs-hawkeye-360');
