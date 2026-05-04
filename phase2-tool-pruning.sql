-- Phase 2: Tool Pruning - Quality over Quantity (S87b)
-- Cut B2B-only verticals and niche tools without consumer search demand.
-- Keep head-term brand-recognition tools even from niche verticals.
--
-- BEFORE: 669 tools
-- AFTER:  ~520 tools (estimated, depends on which slugs exist)
--
-- Strategy:
-- 1. DELETE entirely: B2B-only verticals with no consumer entry point
--    (Aerospace, Biotech, GovTech, Manufacturing, Supply Chain, Construction, AgriTech)
-- 2. KEEP head-term leaders only: brand-recognition tools from B2B verticals
--    (palantir from defense, lemonade from insurtech, compass from realestate, vanta from compliance)
-- 3. PRUNE to top 5: medium-demand verticals with bloat
--    (Climate, Hospitality, Legal, Healthcare, HR, Education, Customer Service, E-commerce)
-- 4. UNTOUCHED: 12 core categories (already curated via Phase 1)
--
-- All deletions cascade: comparisons + tool_clicks + tools.
-- Run: scripts/run-sql.mjs phase2-tool-pruning.sql
-- Then: node scripts/clean-top10.mjs

BEGIN;

-- ============================================================================
-- Tier A: DELETE entire B2B-only verticals (no consumer search demand)
-- ============================================================================

-- Aerospace/Defense (batch-71) - keep palantir + anduril (NYC public-trading brand recognition)
-- Delete: shield-ai, maxar, slingshot-aerospace, hawkeye-360, planet-labs, helsing, rebellion-defense, scale-ai-defense

-- Biotech/Life Sciences (batch-70) - DELETE ALL (pharma R&D, no consumer-facing entry point)

-- GovTech (batch-68) - DELETE ALL (B2G procurement, civic engagement is niche)

-- Procurement/Spend Mgmt (batch-69) - keep coupa (public company NASDAQ) - delete others

-- Manufacturing/Industry 4.0 (batch-66) - DELETE ALL (B2B Industry 4.0 enterprise sales)

-- Supply Chain/Logistics (batch-64) - DELETE ALL (B2B enterprise logistics)

-- Construction/Architecture (batch-59) - DELETE ALL (B2B AEC sector niche)

-- AgriTech (batch-72) - DELETE ALL (B2B precision agriculture - no consumer demand even for John Deere AI)

-- Real Estate/Proptech (batch-58) - keep compass + matterport (consumer brand recognition)
-- Delete: reonomy, cherre, leverton, rex-real-estate, rentlytics, reggora, immoviewer

-- InsurTech (batch-62) - keep lemonade (consumer brand) - delete others
-- Delete: tractable, shift-technology, planck, cape-analytics, zelros, socotra, coalition, next-insurance

-- Compliance/Legal-Ops (batch-57) - keep vanta + onetrust (well-known SOC2/privacy brands)
-- Delete: drata, secureframe, sprinto, bigid, securiti, evisort, linksquares, auditboard

DELETE FROM comparisons WHERE tool_a_slug IN (
  -- Aerospace cuts
  'shield-ai','maxar','slingshot-aerospace','hawkeye-360','planet-labs','helsing','rebellion-defense','scale-ai-defense',
  -- Biotech all
  'insilico-medicine','benevolentai','recursion','schrodinger','atomwise','deep-genomics','exscientia','isomorphic-labs','valence-labs','generate-biomedicines',
  -- GovTech all
  'granicus','opengov','tyler-technologies','accela','zencity','polco','mark43','axon-ai','civicplus',
  -- Procurement (keep coupa)
  'jaggaer','ivalua','zip-procurement','pactum','sievo','keelvar','spendesk','precoro','procurify',
  -- Manufacturing all
  'tulip','uptake','augury','sight-machine','c3-ai','instrumental','cognex','landing-ai','relimetrics','elementary',
  -- Supply Chain all
  'project44','flexport','transfix','stord','shippo','easypost','o9-solutions','kinaxis','blue-yonder','manhattan-associates',
  -- Construction all
  'testfit','archistar','openspace','buildots','togal-ai','disperse','join-build','trunk-tools','spacemaker',
  -- AgriTech all
  'climate-corp','john-deere-ai','indigo-agriculture','granular','taranis','farmers-business-network','blue-river-technology','agworld',
  -- Real Estate cuts
  'reonomy','cherre','leverton','rex-real-estate','rentlytics','reggora','immoviewer',
  -- InsurTech cuts
  'tractable','shift-technology','planck','cape-analytics','zelros','socotra','coalition','next-insurance',
  -- Compliance cuts
  'drata','secureframe','sprinto','bigid','securiti','evisort','linksquares','auditboard'
) OR tool_b_slug IN (
  'shield-ai','maxar','slingshot-aerospace','hawkeye-360','planet-labs','helsing','rebellion-defense','scale-ai-defense',
  'insilico-medicine','benevolentai','recursion','schrodinger','atomwise','deep-genomics','exscientia','isomorphic-labs','valence-labs','generate-biomedicines',
  'granicus','opengov','tyler-technologies','accela','zencity','polco','mark43','axon-ai','civicplus',
  'jaggaer','ivalua','zip-procurement','pactum','sievo','keelvar','spendesk','precoro','procurify',
  'tulip','uptake','augury','sight-machine','c3-ai','instrumental','cognex','landing-ai','relimetrics','elementary',
  'project44','flexport','transfix','stord','shippo','easypost','o9-solutions','kinaxis','blue-yonder','manhattan-associates',
  'testfit','archistar','openspace','buildots','togal-ai','disperse','join-build','trunk-tools','spacemaker',
  'climate-corp','john-deere-ai','indigo-agriculture','granular','taranis','farmers-business-network','blue-river-technology','agworld',
  'reonomy','cherre','leverton','rex-real-estate','rentlytics','reggora','immoviewer',
  'tractable','shift-technology','planck','cape-analytics','zelros','socotra','coalition','next-insurance',
  'drata','secureframe','sprinto','bigid','securiti','evisort','linksquares','auditboard'
);

-- ============================================================================
-- Tier B: PRUNE bloated medium-demand verticals to top 5
-- ============================================================================

-- Climate (batch-67) - keep watershed + persefoni + greenly (3 leaders)
-- Delete: sweep, normative, climatiq, ibm-envizi, emitwise, cogo

-- Hospitality/Travel (batch-63) - keep mews, cloudbeds, guesty, hopper, navan (5)
-- Delete: revinate, canary-technologies, siteminder, atomize

-- Legal Tech (batch-65) - keep paxton-ai, everlaw, kira-systems, draftwise + harvey-ai if exists (5)
-- Delete: relativity, lexion, brightflag, definely, smokeball, filevine

-- Healthcare (batch-56) - keep freed-ai, deepscribe, ambience-healthcare, hippocratic-ai, viz-ai (5)
-- Delete: regard-clinical, paige-ai, atropos-health, tempus-ai

-- HR/People Ops (batch-61) - keep lattice, culture-amp, 15five, gusto, hibob (5)
-- Delete: leapsome, paradox-ai, betterup, peakon

-- Education/EdTech (batch-60) - keep photomath, coursera-coach, gradescope-ai, kahoot-ai, edpuzzle-ai (5)
-- Delete: socratic, quizlet-q-chat, mathgpt, eduaide-ai, nearpod-ai

-- Customer Service (batch-55) - keep intercom-fin, ada-ai, decagon-ai, moveworks, yellow-ai (5)
-- Delete: forethought-ai, ultimate-ai, glia, lang-io

-- E-commerce (batch-54) - keep shopify-magic, octane-ai, recart, nosto, syte (5)
-- Delete: rep-ai, searchspring, lily-ai, rebuy, stamped-io

DELETE FROM comparisons WHERE tool_a_slug IN (
  -- Climate cuts
  'sweep','normative','climatiq','ibm-envizi','emitwise','cogo',
  -- Hospitality cuts
  'revinate','canary-technologies','siteminder','atomize',
  -- Legal Tech cuts
  'relativity','lexion','brightflag','definely','smokeball','filevine',
  -- Healthcare cuts
  'regard-clinical','paige-ai','atropos-health','tempus-ai',
  -- HR cuts
  'leapsome','paradox-ai','betterup','peakon',
  -- Education cuts
  'socratic','quizlet-q-chat','mathgpt','eduaide-ai','nearpod-ai',
  -- Customer Service cuts
  'forethought-ai','ultimate-ai','glia','lang-io',
  -- E-commerce cuts
  'rep-ai','searchspring','lily-ai','rebuy','stamped-io'
) OR tool_b_slug IN (
  'sweep','normative','climatiq','ibm-envizi','emitwise','cogo',
  'revinate','canary-technologies','siteminder','atomize',
  'relativity','lexion','brightflag','definely','smokeball','filevine',
  'regard-clinical','paige-ai','atropos-health','tempus-ai',
  'leapsome','paradox-ai','betterup','peakon',
  'socratic','quizlet-q-chat','mathgpt','eduaide-ai','nearpod-ai',
  'forethought-ai','ultimate-ai','glia','lang-io',
  'rep-ai','searchspring','lily-ai','rebuy','stamped-io'
);

-- ============================================================================
-- Tool DELETE (tier A + tier B combined)
-- ============================================================================

DELETE FROM tool_clicks WHERE tool_slug IN (
  -- Tier A
  'shield-ai','maxar','slingshot-aerospace','hawkeye-360','planet-labs','helsing','rebellion-defense','scale-ai-defense',
  'insilico-medicine','benevolentai','recursion','schrodinger','atomwise','deep-genomics','exscientia','isomorphic-labs','valence-labs','generate-biomedicines',
  'granicus','opengov','tyler-technologies','accela','zencity','polco','mark43','axon-ai','civicplus',
  'jaggaer','ivalua','zip-procurement','pactum','sievo','keelvar','spendesk','precoro','procurify',
  'tulip','uptake','augury','sight-machine','c3-ai','instrumental','cognex','landing-ai','relimetrics','elementary',
  'project44','flexport','transfix','stord','shippo','easypost','o9-solutions','kinaxis','blue-yonder','manhattan-associates',
  'testfit','archistar','openspace','buildots','togal-ai','disperse','join-build','trunk-tools','spacemaker',
  'climate-corp','john-deere-ai','indigo-agriculture','granular','taranis','farmers-business-network','blue-river-technology','agworld',
  'reonomy','cherre','leverton','rex-real-estate','rentlytics','reggora','immoviewer',
  'tractable','shift-technology','planck','cape-analytics','zelros','socotra','coalition','next-insurance',
  'drata','secureframe','sprinto','bigid','securiti','evisort','linksquares','auditboard',
  -- Tier B
  'sweep','normative','climatiq','ibm-envizi','emitwise','cogo',
  'revinate','canary-technologies','siteminder','atomize',
  'relativity','lexion','brightflag','definely','smokeball','filevine',
  'regard-clinical','paige-ai','atropos-health','tempus-ai',
  'leapsome','paradox-ai','betterup','peakon',
  'socratic','quizlet-q-chat','mathgpt','eduaide-ai','nearpod-ai',
  'forethought-ai','ultimate-ai','glia','lang-io',
  'rep-ai','searchspring','lily-ai','rebuy','stamped-io'
);

DELETE FROM tools WHERE slug IN (
  -- Tier A
  'shield-ai','maxar','slingshot-aerospace','hawkeye-360','planet-labs','helsing','rebellion-defense','scale-ai-defense',
  'insilico-medicine','benevolentai','recursion','schrodinger','atomwise','deep-genomics','exscientia','isomorphic-labs','valence-labs','generate-biomedicines',
  'granicus','opengov','tyler-technologies','accela','zencity','polco','mark43','axon-ai','civicplus',
  'jaggaer','ivalua','zip-procurement','pactum','sievo','keelvar','spendesk','precoro','procurify',
  'tulip','uptake','augury','sight-machine','c3-ai','instrumental','cognex','landing-ai','relimetrics','elementary',
  'project44','flexport','transfix','stord','shippo','easypost','o9-solutions','kinaxis','blue-yonder','manhattan-associates',
  'testfit','archistar','openspace','buildots','togal-ai','disperse','join-build','trunk-tools','spacemaker',
  'climate-corp','john-deere-ai','indigo-agriculture','granular','taranis','farmers-business-network','blue-river-technology','agworld',
  'reonomy','cherre','leverton','rex-real-estate','rentlytics','reggora','immoviewer',
  'tractable','shift-technology','planck','cape-analytics','zelros','socotra','coalition','next-insurance',
  'drata','secureframe','sprinto','bigid','securiti','evisort','linksquares','auditboard',
  -- Tier B
  'sweep','normative','climatiq','ibm-envizi','emitwise','cogo',
  'revinate','canary-technologies','siteminder','atomize',
  'relativity','lexion','brightflag','definely','smokeball','filevine',
  'regard-clinical','paige-ai','atropos-health','tempus-ai',
  'leapsome','paradox-ai','betterup','peakon',
  'socratic','quizlet-q-chat','mathgpt','eduaide-ai','nearpod-ai',
  'forethought-ai','ultimate-ai','glia','lang-io',
  'rep-ai','searchspring','lily-ai','rebuy','stamped-io'
);

COMMIT;

-- After SQL completes, run: node scripts/clean-top10.mjs
-- Then manually delete the blog MDX files for verticals being removed:
--   web/content/blog/best-ai-aerospace-and-defense-tools-2026.mdx
--   web/content/blog/best-ai-biotech-and-life-sciences-tools-2026.mdx
--   web/content/blog/best-ai-government-and-public-sector-tools-2026.mdx
--   web/content/blog/best-ai-procurement-and-spend-management-tools-2026.mdx
--   web/content/blog/best-ai-manufacturing-and-industry-4-tools-2026.mdx
--   web/content/blog/best-ai-supply-chain-and-logistics-tools-2026.mdx
--   web/content/blog/best-ai-construction-and-architecture-tools-2026.mdx
