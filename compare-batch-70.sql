-- compare-batch-70.sql
-- 5 biotech / life sciences comparison pairs
-- All tool slugs confirmed from tools-batch-70.sql (batch-70 AI Biotech / Life Sciences)
-- All pair slugs verified fresh - not in any prior compare-batch file

-- 1. insilico-medicine-vs-benevolentai (end-to-end AI pharma vs knowledge graph discovery)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'insilico-medicine-vs-benevolentai',
  'insilico-medicine',
  'benevolentai',
  'Insilico Medicine and BenevolentAI both apply AI to drug discovery but operate at different stages of the pipeline and with different architectural approaches. Insilico leads on end-to-end integration - the Pharma.AI platform covers target identification, generative molecular design, and clinical success prediction in a unified workflow, with Phase II clinical proof-of-concept from an AI-designed molecule providing the strongest validation in the category. BenevolentAI leads at the target identification stage specifically - the biomedical knowledge graph surfaces non-obvious connections across literature, genomics, and clinical data that purely generative approaches miss, with the baricitinib COVID-19 discovery providing commercial validation. For pharma partners that have validated targets and need to accelerate from target to candidate, Insilico provides more complete end-to-end capabilities. For programs where the target biology is the unsolved problem, BenevolentAI''s knowledge graph approach is the more appropriate first step. The two platforms are more complementary than competing in a well-designed AI drug discovery stack.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'insilico-medicine-vs-benevolentai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'insilico-medicine-vs-benevolentai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Clinical Proof-of-Concept',         5, 3, 'Insilico Phase II clinical trial for ISM001-055 is the strongest AI drug discovery validation in 2026'),
  ('Target Identification Capability',  4, 5, 'BenevolentAI knowledge graph is purpose-built for target discovery from biological data connections'),
  ('Generative Molecular Design',       5, 2, 'Insilico Chemistry42 generates optimized small-molecule candidates; BenevolentAI focuses on biology not chemistry'),
  ('Clinical Success Prediction',       5, 2, 'Insilico InClinico predicts trial success probability; BenevolentAI does not offer equivalent capability'),
  ('Disease Area Coverage',             4, 4, 'Both cover oncology, neurodegeneration, and immunology with different depth profiles'),
  ('Platform Integration Depth',        5, 3, 'Pharma.AI covers target-to-candidate workflow; BenevolentAI optimized for discovery hypothesis generation'),
  ('Access Model for New Partners',     3, 4, 'Both require partnership agreements; BenevolentAI has broader academic collaboration history')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'insilico-medicine-vs-benevolentai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'insilico-medicine-vs-benevolentai');

-- 2. recursion-vs-insilico-medicine (phenomics platform vs generative AI pharma)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'recursion-vs-insilico-medicine',
  'recursion',
  'insilico-medicine',
  'Recursion and Insilico Medicine represent two distinct architectural bets on how AI will transform drug discovery in 2026. Recursion''s phenomics approach generates experimental biology data at petabyte scale and trains RecursionOS foundation models on cellular observation rather than chemical knowledge - making the platform strongest for programs where the target is unknown and the biology needs to be explored empirically. Insilico''s generative AI approach starts from a validated target and applies Chemistry42 to design optimized small-molecule candidates, with InClinico predicting clinical success - making Pharma.AI strongest when target validation is complete and the challenge is rapid medicinal chemistry execution. Recursion has the larger proprietary dataset and the more ambitious foundation model program backed by NVIDIA and Roche. Insilico has the more direct clinical validation with a Phase II compound. The right choice depends entirely on where the program''s bottleneck is: target identification versus chemical design.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'recursion-vs-insilico-medicine');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'recursion-vs-insilico-medicine', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Proprietary Biology Dataset Scale', 5, 3, 'Recursion petabyte-scale cellular imaging dataset is the largest AI biology training set in existence'),
  ('Generative Molecular Design',       2, 5, 'Insilico Chemistry42 is the purpose-built generative chemistry module; Recursion is not a medicinal chemistry platform'),
  ('Clinical Program Track Record',     3, 5, 'Insilico Phase II clinical trial is the most direct validation; Recursion programs are earlier stage'),
  ('Foundation Model AI Research',      5, 3, 'RecursionOS NVIDIA partnership is advancing biology foundation model scale; Insilico less focused on foundational AI'),
  ('Target-Unknown Discovery Programs', 5, 2, 'Recursion phenomics approach designed for exploring biology without pre-validated target hypothesis'),
  ('Target-to-Candidate Speed',         2, 5, 'Insilico Chemistry42 and integrated workflow designed to compress target-to-IND timelines'),
  ('Commercial Partnership Validation', 4, 4, 'Recursion has Roche and Bayer; Insilico has demonstrated Phase II - different types of commercial proof')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'recursion-vs-insilico-medicine')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'recursion-vs-insilico-medicine');

-- 3. schrodinger-vs-atomwise (physics-based accuracy vs AI-first virtual screening scale)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'schrodinger-vs-atomwise',
  'schrodinger',
  'atomwise',
  'Schrodinger and Atomwise serve different stages of the computational drug design workflow and are more complementary than competing when deployed together. Schrodinger leads on accuracy - physics-based FEP+ free energy calculations provide the most reliable binding affinity predictions in the industry for lead optimization decisions, and the platform is trusted by Pfizer, BMS, and Takeda for this reason. Atomwise leads on scale at the hit identification stage - AtomNet virtual screening covers billions of compounds in days, a throughput that Schrodinger''s quantum mechanical methods cannot match. In a rational computational drug discovery program, Atomwise is deployed first to screen large compound libraries and identify starting scaffolds, then Schrodinger''s structure-based tools are applied to the prioritized hits for precision optimization. For organizations choosing a single computational platform, Schrodinger is the stronger choice when structural biology is known and optimization accuracy matters most; Atomwise is the stronger choice when the primary goal is efficient hit identification from large chemical space.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'schrodinger-vs-atomwise');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'schrodinger-vs-atomwise', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Binding Affinity Prediction Accuracy', 5, 3, 'Schrodinger FEP+ is the industry benchmark for binding affinity accuracy in lead optimization'),
  ('Virtual Screening Scale',             2, 5, 'Atomwise AtomNet screens billions of compounds in days; Schrodinger physics methods cannot match this throughput'),
  ('Structure-Based Design Workflow',     5, 2, 'Schrodinger Maestro and Glide provide complete SBDD infrastructure; Atomwise optimized for hit identification'),
  ('ADMET Property Prediction',           5, 3, 'Schrodinger QikProp and ADME suite are more comprehensive than Atomwise ADMET capabilities'),
  ('Accessibility for Small Teams',       3, 5, 'Atomwise ADSC program enables academic and small biotech access; Schrodinger licensing is expensive'),
  ('AI-Physics Integration',              4, 3, 'Schrodinger 2026 AI acceleration of FEP+ pipelines advances the integration; Atomwise is purely ML-based'),
  ('Commercial Drug Program Track Record',5, 4, 'Schrodinger has co-discovered clinical candidates with Pfizer and BMS; Atomwise has 1,600+ programs screened')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'schrodinger-vs-atomwise')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'schrodinger-vs-atomwise');

-- 4. exscientia-vs-recursion (automated medicinal chemistry vs phenomics biology platform)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'exscientia-vs-recursion',
  'exscientia',
  'recursion',
  'Exscientia and Recursion are both AI drug discovery platform companies with clinical programs, but they attack the problem from opposite ends. Exscientia''s Centaur Chemist platform is built for speed in medicinal chemistry - automated design-make-test-analyse cycles compress hit-to-candidate timelines from years to under 12 months, with DSP-1181 as the first AI-designed drug in human clinical trials validating the approach. Recursion''s RecursionOS is built for breadth in biology - the platform maps how millions of genetic and chemical perturbations affect cellular phenotype, generating biological insights that inform target selection and disease mechanism understanding rather than directly designing drug candidates. Exscientia delivers the fastest medicinal chemistry execution for validated targets. Recursion delivers the deepest experimental biology for identifying which targets to pursue. For a pharma partner choosing between them, the question is whether the current bottleneck is "which biology to pursue" (Recursion) or "how fast to execute on known biology" (Exscientia). Both have FTSE-listed or NASDAQ-listed valuations indicating commercial investor confidence in the respective approaches.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'exscientia-vs-recursion');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'exscientia-vs-recursion', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Hit-to-Candidate Speed',            5, 2, 'Exscientia consistently delivers IND candidates in under 12 months; Recursion is not a medicinal chemistry platform'),
  ('Biological Dataset Depth',          2, 5, 'Recursion petabyte-scale phenomics dataset is the definitive AI biology training corpus'),
  ('Clinical Program Proof',            5, 3, 'DSP-1181 first AI drug in human trials is stronger near-term validation; Recursion programs in earlier stages'),
  ('Target Identification Capability',  2, 5, 'Recursion RecursionOS phenotype map enables target discovery; Exscientia requires pre-validated target'),
  ('Pharma Partnership Portfolio',      4, 4, 'Exscientia has Sanofi and BMS; Recursion has Roche, Bayer, and NVIDIA - both credible'),
  ('Disease Area Flexibility',          4, 3, 'Exscientia oncology and immunology programs; Recursion broader across rare diseases, oncology, and infectious disease'),
  ('Platform Foundation Model Ambition',2, 5, 'RecursionOS NVIDIA partnership targets biology foundation model at unprecedented scale; Exscientia focused on chemistry')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'exscientia-vs-recursion')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'exscientia-vs-recursion');

-- 5. isomorphic-labs-vs-benevolentai (AlphaFold-powered protein AI vs biomedical knowledge graph)
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT
  'isomorphic-labs-vs-benevolentai',
  'isomorphic-labs',
  'benevolentai',
  'Isomorphic Labs and BenevolentAI both target the upstream biology problem in drug discovery - understanding disease mechanisms and identifying the right therapeutic targets - but from fundamentally different approaches. Isomorphic Labs applies AlphaFold-derived protein structure prediction to understand how proteins function and how small molecules can modulate them, with the $3 billion Eli Lilly and Novartis partnership agreements providing the largest commercial validation in AI drug discovery history. BenevolentAI builds knowledge graphs that synthesize published biology into structured representations of disease mechanisms, enabling hypothesis generation that goes beyond what structural biology alone can provide. Isomorphic is strongest when structural biology is the bottleneck - for programs where protein structure determines the design strategy. BenevolentAI is strongest when the biology hypothesis is the bottleneck - for programs where the right target or mechanism is not yet clear. Both platforms are exclusively available through enterprise partnership agreements, making direct comparison accessible only to organizations operating at pharmaceutical company scale.',
  'isomorphic-labs',
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'isomorphic-labs-vs-benevolentai');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'isomorphic-labs-vs-benevolentai', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Commercial Partnership Validation',  5, 3, 'Isomorphic $3B Lilly and Novartis agreements dwarf BenevolentAI commercial partnerships in scale'),
  ('Protein Structure AI Capability',    5, 2, 'Isomorphic AlphaFold foundations are unmatched for protein structure and ligand interaction modeling'),
  ('Knowledge Graph Biology Synthesis',  2, 5, 'BenevolentAI biomedical knowledge graph integrates literature, genomics, and clinical data more completely'),
  ('Target Identification from Data',    3, 5, 'BenevolentAI optimized for hypothesis generation from biological data connections; Isomorphic is structure-focused'),
  ('Foundation AI Research Quality',     5, 3, 'DeepMind parentage gives Isomorphic access to frontier AI capabilities not available elsewhere'),
  ('Disease Area Track Record',          3, 4, 'BenevolentAI COVID-19 baricitinib discovery provides independent commercial validation in a real clinical context'),
  ('External Research Accessibility',   2, 3, 'Neither is accessible without enterprise partnership; BenevolentAI has broader academic research engagement history')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'isomorphic-labs-vs-benevolentai')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'isomorphic-labs-vs-benevolentai');
