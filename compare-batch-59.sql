-- compare-batch-59.sql
-- 5 AI Construction / Architecture comparison pairs
-- All tool slugs confirmed in DB from tools-batch-59.sql:
--   autodesk-forma, testfit, archistar, openspace, buildots,
--   togal-ai, disperse, join-build, trunk-tools, spacemaker
-- All pair slugs verified fresh - grepped all prior compare-batch-*.sql files, no collisions found

-- 1. autodesk-forma-vs-archistar (generative design and feasibility platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'autodesk-forma-vs-archistar',
  'autodesk-forma',
  'archistar',
  'Autodesk Forma and Archistar both apply AI to early-stage development feasibility analysis, but they address different bottlenecks for different buyer profiles. Autodesk Forma is a 3D generative design environment that runs multi-criteria environmental analysis - daylight, wind, noise, solar, density compliance - simultaneously as a designer adjusts massing in a live 3D model. It is built for architects and urban planners doing conceptual design work who need to evaluate the environmental and regulatory performance of different massing options before committing to a direction. Archistar is a planning intelligence platform that aggregates zoning codes, overlay constraints, and market data for specific addresses and generates indicative compliant building schemes from those constraints. It is built for property developers and buyers agents who need to quickly assess whether a site has viable development potential without commissioning a design study. Forma wins for teams doing active 3D design exploration with complex environmental analysis requirements. Archistar wins for teams doing rapid site screening across a large acquisition pipeline who need planning data and basic feasibility in a single view. Both tools operate at the feasibility stage, but Forma goes deeper on design quality and Archistar goes wider on acquisition volume and planning data integration in 2026.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'autodesk-forma-vs-archistar');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'autodesk-forma-vs-archistar', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Environmental Analysis Depth',     5, 2, 'Forma runs daylight, wind, noise, solar, and density simultaneously in real time; Archistar is more basic'),
  ('Planning Data Integration',        2, 5, 'Archistar connects directly to zoning databases for specific addresses; Forma does not have this data layer'),
  ('3D Design Environment',            5, 2, 'Forma provides a full interactive 3D massing environment; Archistar generates indicative 2D schemes'),
  ('Site Screening at Volume',         2, 5, 'Archistar designed for rapid multi-site acquisition screening; Forma is better for deep single-site analysis'),
  ('Market and Sales Data Overlay',    1, 4, 'Archistar includes rental yields and recent sales data alongside planning controls'),
  ('Autodesk Ecosystem Integration',   5, 1, 'Forma connects to Revit and Autodesk AEC suite; Archistar is a standalone platform'),
  ('Entry Price and Accessibility',    2, 4, 'Archistar freemium from $79/month; Forma requires Autodesk enterprise subscription')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'autodesk-forma-vs-archistar')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'autodesk-forma-vs-archistar');

-- 2. openspace-vs-buildots (construction site capture and progress intelligence)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'openspace-vs-buildots',
  'openspace',
  'buildots',
  'OpenSpace and Buildots are the two leading AI construction site capture platforms in 2026, and they are frequently compared because their core capture workflow - site personnel carrying 360-degree cameras through the building - is similar. The meaningful difference is in what each platform does with the captured data. OpenSpace prioritises automated documentation and deviation detection: geo-referenced images mapped to the floor plan, timestamped archive for dispute protection, and AI comparison of site conditions against BIM and drawings to surface deviations. Buildots prioritises schedule intelligence: AI object detection identifies which construction elements have been installed at the trade and zone level, then compares detected progress against the project schedule to produce a real-time schedule adherence dashboard with quantified delay risk. In practice, these platforms are complementary - some large general contractors use both. OpenSpace is the stronger choice when the primary need is defensible documentation and deviation detection. Buildots is the stronger choice when the primary need is trade-level schedule intelligence and proactive delay identification. For teams that can only adopt one, the decision should be driven by which problem is currently most expensive: documentation liability or schedule slippage.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'openspace-vs-buildots');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'openspace-vs-buildots', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Site Documentation and Archive',   5, 3, 'OpenSpace geo-referenced archive is specifically designed for documentation and dispute protection'),
  ('Schedule Intelligence Depth',      3, 5, 'Buildots trade-level schedule comparison is the more sophisticated progress tracking capability'),
  ('BIM Deviation Detection',          5, 3, 'OpenSpace AI deviation detection against BIM and drawings is a primary feature; Buildots is more schedule-focused'),
  ('Object Detection and Classification', 3, 5, 'Buildots object detection trained to identify specific installed trade elements for schedule comparison'),
  ('Procore / ACC Integration',        5, 4, 'Both integrate with Procore and Autodesk Construction Cloud; OpenSpace integration is more mature'),
  ('Project Type Coverage',            5, 4, 'OpenSpace used across commercial, residential, infrastructure; Buildots strongest on complex commercial'),
  ('Dispute and Claims Protection',    5, 2, 'OpenSpace timestamped archive is built for legal and insurance defensibility; Buildots is not')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'openspace-vs-buildots')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'openspace-vs-buildots');

-- 3. testfit-vs-archistar (development feasibility platforms)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'testfit-vs-archistar',
  'testfit',
  'archistar',
  'TestFit and Archistar both accelerate the early-stage development feasibility process, but they approach it from different angles and serve somewhat different buyer profiles. TestFit is a building program generator and pro forma modelling tool: it takes a site and development parameters and generates multiple compliant building configurations with unit counts, floor area calculations, parking layouts, and financial returns modelled simultaneously. It is purpose-built for the development acquisitions workflow - evaluating land opportunities rapidly against financial hurdles before committing to deeper analysis. Archistar is a planning intelligence and market data aggregator: it connects to government planning databases for specific addresses, consolidates zoning constraints and overlay data, and generates indicative schemes alongside market data for that location. It is purpose-built for site discovery and planning compliance checking. TestFit wins on building program depth, financial modelling, and multifamily structural optimisation. Archistar wins on planning data integration, market data access, and rapid multi-site screening without requiring site geometry inputs. Both platforms are at the pre-design feasibility stage in 2026, and teams running high-volume acquisition pipelines sometimes use both.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'testfit-vs-archistar');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'testfit-vs-archistar', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Building Program Generation',      5, 3, 'TestFit generates detailed floor plate layouts, unit mixes, and parking configurations; Archistar is more indicative'),
  ('Pro Forma Financial Modelling',    5, 1, 'TestFit includes full pro forma with construction cost estimates and return metrics; Archistar does not'),
  ('Planning Data Integration',        2, 5, 'Archistar connects to government zoning databases for specific addresses; TestFit requires manual code input'),
  ('Multifamily Optimisation',         5, 2, 'TestFit purpose-built for multifamily structural efficiency and unit mix optimisation'),
  ('Market and Yield Data',            1, 4, 'Archistar overlays rental yield and recent sales data from market databases'),
  ('Revit Integration',                4, 1, 'TestFit pushes selected schemes to Revit; Archistar is standalone without design software integration'),
  ('Geographic Coverage',              3, 4, 'Archistar has strong AU/NZ coverage and expanding US; TestFit works from user-input zoning data globally')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'testfit-vs-archistar')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'testfit-vs-archistar');

-- 4. togal-ai-vs-trunk-tools (document AI for construction - different workflow stages)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'togal-ai-vs-trunk-tools',
  'togal-ai',
  'trunk-tools',
  'Togal.AI and Trunk Tools both apply AI to construction documents, but they solve entirely different problems in the construction workflow and serve different user personas. Togal.AI is a quantity takeoff platform for estimators: it applies computer vision to construction drawing PDFs to automatically detect, classify, and measure quantities - areas, lengths, counts - that estimators would otherwise extract manually. The value is in the time saved on a task that precedes bid pricing and happens repeatedly across dozens of projects. Trunk Tools is a document AI assistant for field and project management personnel: it uses a construction-trained language model to answer natural language questions from the actual project document set - specifications, RFIs, submittals, drawings - with specific citations to the source document. The value is in faster decision-making on the job site and reduced avoidable RFI volume. These tools address adjacent but non-competing problems. Togal.AI is for the estimating department at bid stage. Trunk Tools is for the field team at construction stage. A construction firm could productively deploy both across different departments without any overlap.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'togal-ai-vs-trunk-tools');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'togal-ai-vs-trunk-tools', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Quantity Takeoff Automation',      5, 1, 'Togal.AI purpose-built for AI quantity extraction from drawings; Trunk Tools does not do takeoff'),
  ('Field Document Q and A',           1, 5, 'Trunk Tools purpose-built for answering field questions from project documents; Togal.AI does not'),
  ('Drawing Version Comparison',       5, 1, 'Togal.AI flags quantity changes between drawing revisions automatically; Trunk Tools does not'),
  ('Construction-Trained LLM',         2, 5, 'Trunk Tools model trained specifically on construction language for reliable technical answers'),
  ('Estimating Software Integration',  5, 1, 'Togal.AI integrates with Sage Estimating and ProContractor; Trunk Tools does not target estimating'),
  ('Procore and ACC Integration',      1, 5, 'Trunk Tools integrates with Procore and Autodesk Construction Cloud for document access'),
  ('Target User',                      3, 3, 'Togal.AI: estimators at bid stage. Trunk Tools: PMs and supers at construction stage')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'togal-ai-vs-trunk-tools')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'togal-ai-vs-trunk-tools');

-- 5. disperse-vs-buildots (AI site capture with quality focus vs. schedule focus)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'disperse-vs-buildots',
  'disperse',
  'buildots',
  'Disperse and Buildots are both AI construction site capture platforms targeting large commercial construction projects, but they have distinct primary value propositions that determine which is the stronger fit for a given team. Disperse focuses on quality monitoring and defect detection: its AI analyses 360-degree site imagery to identify potential defects - cracking, misalignment, incomplete work - before they are concealed by subsequent trades, generating a structured snagging list with photo evidence and location coordinates. The commercial case is based on the cost difference between fixing a defect during active construction versus after completion and concealment. Buildots focuses on schedule intelligence: its AI identifies installed construction elements at the trade and zone level and compares detected progress against the project schedule, quantifying delay risk in real time. The commercial case is based on catching schedule variance early enough to take corrective action before it compounds. Disperse has stronger traction in the UK and European market; Buildots has broader international presence. Both platforms create value on large, complex commercial projects - the choice is driven by whether defect detection or schedule intelligence is the higher-priority problem for the team.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'disperse-vs-buildots');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'disperse-vs-buildots', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Defect Detection and Snagging',    5, 2, 'Disperse AI defect detection before trade concealment is the primary value proposition'),
  ('Schedule Intelligence Depth',      2, 5, 'Buildots trade-level schedule comparison is more sophisticated than Disperse progress tracking'),
  ('UK and European Market Coverage',  5, 3, 'Disperse has stronger track record and integrations in UK and European construction market'),
  ('International Project Coverage',   3, 5, 'Buildots has broader international presence across commercial, healthcare, and data centre projects'),
  ('Snagging List Generation',         5, 2, 'Disperse generates structured snagging lists with photo evidence; Buildots is schedule-focused'),
  ('Multi-Trade Object Detection',     3, 5, 'Buildots detection trained across structural, MEP, and finish categories for schedule comparison'),
  ('Handover Documentation Quality',   5, 3, 'Disperse defect-focused documentation is particularly valuable for handover and warranty management')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'disperse-vs-buildots')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'disperse-vs-buildots');
