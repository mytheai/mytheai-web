-- compare-batch-47.sql
-- 5 AI Proposal & Contract tool comparison pairs
-- All tools from tools-batch-47 (confirmed in DB)
-- Run AFTER tools-batch-47 confirmed in Supabase
-- Actual slugs: pandadoc, proposify, qwilr, dealhub, oneflow, contractbook, juro, ironclad, better-proposals, loopio

-- 1. pandadoc-vs-proposify
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'pandadoc-vs-proposify', 'pandadoc', 'proposify',
  'PandaDoc and Proposify are both leading proposal platforms, but they target different team profiles. PandaDoc is a broad document automation platform covering proposals, contracts, quotes, and HR documents with a generous free tier - built for teams of any size that want one tool for all business documents. Proposify is a focused proposal management platform built specifically for agencies and service businesses that send high volumes of branded proposals - it has stronger team controls, a richer content library, and more detailed proposal analytics. PandaDoc wins for teams that need a versatile all-in-one document workflow at low cost. Proposify wins for agencies and service teams where proposal consistency, close rate analytics, and brand compliance across the whole team are the priority.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pandadoc-vs-proposify');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'pandadoc-vs-proposify', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Document Versatility', 5, 3, 'PandaDoc handles proposals, contracts, quotes, NDAs, HR onboarding documents, and more in a single platform. Proposify is focused on proposals and does not cover contracts or HR documents.'),
  ('Free Plan', 5, 1, 'PandaDoc free plan includes unlimited document uploads and basic e-signature - sufficient for freelancers and small teams. Proposify has no free plan, starting at $49/user/month.'),
  ('Content Library', 4, 5, 'Proposify content library for storing approved copy, images, pricing blocks, and legal terms is more mature and central to the team workflow. PandaDoc has a content library but it is less prominent in the core workflow.'),
  ('Team Approval Workflows', 3, 5, 'Proposify approval workflows route non-standard pricing or scope to a manager before the proposal goes out - critical for agencies with junior sales staff. PandaDoc approval workflows exist but are less central.'),
  ('Proposal Analytics', 4, 5, 'Proposify analytics show close rates by template, page engagement, and which sections prospects skip. PandaDoc tracks opens and engagement but with less depth on close rate analysis by template type.'),
  ('CRM Integration', 5, 4, 'PandaDoc CRM integrations with Salesforce, HubSpot, and Pipedrive are deep and bi-directional. Proposify integrates with major CRMs but with slightly less automation depth on deal data sync.'),
  ('Pricing', 5, 2, 'PandaDoc starts free with paid plans from $19/user/month. Proposify starts at $49/user/month with no free tier - a significant cost difference for small teams evaluating both.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'pandadoc-vs-proposify')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'pandadoc-vs-proposify');

-- 2. qwilr-vs-pandadoc
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'qwilr-vs-pandadoc', 'qwilr', 'pandadoc',
  'Qwilr and PandaDoc are both proposal platforms, but they take fundamentally different approaches to what a proposal should be. Qwilr proposals are interactive web pages - the prospect opens a URL, configures pricing options, embeds video, and accepts and pays in a single browser session without downloading anything. PandaDoc proposals are rich document-style files with e-signature that feel more like a traditional proposal in digital form. Qwilr wins when the buying experience matters - modern buyers who expect a polished web interaction, configurable options, and instant acceptance. PandaDoc wins when document format matters - industries, counterparties, or deal types where a structured PDF-style document is expected, or when the team also needs contracts and HR documents in the same platform.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'qwilr-vs-pandadoc');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'qwilr-vs-pandadoc', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Buyer Experience', 5, 3, 'Qwilr web proposals are more engaging for modern buyers - no download, interactive pricing, embedded video, and one-click acceptance. PandaDoc proposals feel more like a digital PDF with a signature step.'),
  ('Interactive Pricing', 5, 2, 'Qwilr lets prospects configure options and see the total update in real time before accepting. PandaDoc pricing tables are fixed - the prospect cannot interactively adjust scope.'),
  ('Payment Collection', 5, 3, 'Qwilr accepts Stripe payment at the moment of proposal acceptance - useful for collecting a deposit without a separate invoice. PandaDoc has payment integration but it is less central to the flow.'),
  ('Document Versatility', 2, 5, 'PandaDoc covers contracts, NDAs, HR onboarding, and all business documents beyond proposals. Qwilr is focused on proposals and is not a contract management tool.'),
  ('Free Plan', 1, 5, 'PandaDoc has a free plan for basic use cases. Qwilr has no free plan, starting at $35/user/month.'),
  ('Post-Send Editing', 5, 3, 'Qwilr allows updating a live proposal after it has been sent - useful when pricing or scope changes during negotiation. PandaDoc documents are fixed once sent.'),
  ('Enterprise Document Workflows', 2, 5, 'PandaDoc approval workflows, contract templates, and CRM integrations suit enterprise document workflows. Qwilr is better suited to smaller teams sending polished proposals to individual buyers.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'qwilr-vs-pandadoc')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'qwilr-vs-pandadoc');

-- 3. juro-vs-ironclad
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'juro-vs-ironclad', 'juro', 'ironclad',
  'Juro and Ironclad are both enterprise contract lifecycle management platforms, but they approach the problem from different angles. Juro is built around treating contracts as structured data - every clause and commercial term is a queryable data point, and self-service workflows let business teams generate routine contracts independently using approved templates. Ironclad is built around workflow design - a visual tool that maps the complete lifecycle of each contract type with branching approval logic, used by legal teams at large enterprises with complex, multi-jurisdictional contract operations. Juro wins for mid-market legal teams that want to scale contract throughput by enabling business team self-service without sacrificing governance. Ironclad wins for enterprise legal operations teams that need to design and enforce complex, branching contract workflows across multiple jurisdictions and business units.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'juro-vs-ironclad');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'juro-vs-ironclad', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Contracts as Structured Data', 5, 3, 'Juro stores every clause and commercial term as a queryable data point - legal teams can report on portfolio obligations in seconds. Ironclad has contract data extraction but the data layer is less central to the core workflow design.'),
  ('Business Team Self-Service', 5, 3, 'Juro self-service workflows are designed to let sales, HR, and procurement teams generate routine contracts independently using approved templates - reducing legal team bottleneck. Ironclad self-service exists but the platform is more legal-team-centric.'),
  ('Visual Workflow Design', 3, 5, 'Ironclad workflow designer maps the complete contract lifecycle with branching logic for different counterparty types, jurisdictions, and scenarios. Juro workflows are solid but less visually configurable for complex branching conditions.'),
  ('Enterprise Scale', 3, 5, 'Ironclad is used by Dropbox, Mastercard, and L''Oreal for enterprise-scale contract operations across complex organisations. Juro is strong for mid-market legal teams but positions below the largest enterprise deployments.'),
  ('AI Playbook Review', 4, 5, 'Ironclad AI flags deviations from standard playbook positions during contract review with suggestions for alternative language. Juro AI assists with generation and clause suggestions but with less mature playbook deviation detection.'),
  ('Implementation Speed', 4, 2, 'Juro is typically faster to deploy - mid-market teams can be operational within weeks. Ironclad enterprise onboarding involves significant configuration of workflow logic that can take months.'),
  ('Target Company Size', 3, 5, 'Ironclad is purpose-built for large enterprise legal teams with formal legal operations functions. Juro fits mid-market companies that have outgrown basic CLM but are not yet at enterprise legal operations scale.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'juro-vs-ironclad')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'juro-vs-ironclad');

-- 4. oneflow-vs-contractbook
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'oneflow-vs-contractbook', 'oneflow', 'contractbook',
  'Oneflow and Contractbook both automate contract management, but they emphasise different stages of the contract lifecycle. Oneflow is strongest at the active negotiation stage - live documents where both parties collaborate in real time, making it particularly effective for contracts where terms are discussed and revised before signing. Contractbook is strongest at the repository and governance stage - structuring, tagging, and automating the management of a large portfolio of contracts that need to be searchable, tracked for renewal, and reported on. Oneflow wins for sales and procurement teams that negotiate contract terms and want to eliminate PDF email loops. Contractbook wins for operations and legal teams that need to bring order to a scattered contract backlog and build a systematic renewal and obligation tracking process.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'oneflow-vs-contractbook');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'oneflow-vs-contractbook', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Live Negotiation Collaboration', 5, 2, 'Oneflow live documents allow both parties to edit, comment, and propose changes in a shared workspace in real time. Contractbook is more focused on internal workflow and archival rather than real-time external collaboration.'),
  ('Contract Repository', 3, 5, 'Contractbook structured repository with metadata tagging, counterparty linking, and full-text search is more mature and central to the platform. Oneflow archive is functional but secondary to the negotiation workflow.'),
  ('AI Data Extraction', 2, 5, 'Contractbook AI reads existing contracts and pulls key terms including dates, values, and clauses into the database - critical for onboarding a historical contract backlog. Oneflow does not have equivalent data extraction for historical contracts.'),
  ('Renewal Automation', 3, 5, 'Contractbook automated renewal reminders with configurable notice periods and responsible owner assignment are a core feature. Oneflow renewal reminders exist but are less configurable.'),
  ('Free Plan', 5, 1, 'Oneflow free plan is available for small teams with basic contract needs. Contractbook has no free plan, starting from $99/month.'),
  ('CRM Integration', 4, 3, 'Oneflow integrates with Salesforce, HubSpot, Pipedrive, and SuperOffice for contract initiation from deal records. Contractbook CRM integration exists but is less central to the core workflow.'),
  ('Template Creation', 4, 4, 'Both tools provide a template builder with variable fields that pull from connected systems. Oneflow templates feel more modern; Contractbook templates are solid with more configuration options for complex approval routing.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'oneflow-vs-contractbook')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'oneflow-vs-contractbook');

-- 5. better-proposals-vs-proposify
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'better-proposals-vs-proposify', 'better-proposals', 'proposify',
  'Better Proposals and Proposify are both proposal platforms aimed at agencies and service businesses, but they serve very different ends of the market. Better Proposals is built for freelancers, solopreneurs, and small agencies - it is affordable at $19/user/month, quick to learn, and includes Stripe payment collection so clients can pay a deposit at the moment of acceptance. Proposify is built for larger agencies and service businesses with formal sales teams - it has stronger team controls including approval workflows and a content library for brand compliance, and more detailed analytics for managers who want to understand close rates by proposal type. Better Proposals wins on price and simplicity for independent professionals. Proposify wins on team controls, consistency, and analytics for agencies managing a sales team at scale.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'better-proposals-vs-proposify');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'better-proposals-vs-proposify', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Pricing', 5, 2, 'Better Proposals starts at $19/user/month - significantly more affordable for small teams. Proposify starts at $49/user/month with no free plan, making it a meaningful cost difference for freelancers or teams of 1 to 5 people.'),
  ('Payment Collection', 5, 1, 'Better Proposals integrates Stripe and PayPal to collect a deposit or full payment at the moment the proposal is accepted - useful for freelancers who want to start work immediately. Proposify does not include native payment collection.'),
  ('Team Approval Workflows', 2, 5, 'Proposify approval routing for non-standard pricing and scope prevents junior staff from making commitments without manager sign-off. Better Proposals does not have a formal approval workflow for team use.'),
  ('Content Library', 3, 5, 'Proposify team content library for approved copy, images, pricing options, and legal terms is more mature and designed for teams enforcing brand and pricing compliance. Better Proposals has a simpler content section.'),
  ('Close Rate Analytics', 3, 5, 'Proposify analytics show close rates by template type, section engagement, and team performance - useful for managers improving proposal strategy. Better Proposals tracks opens and engagement but without close rate analysis by template.'),
  ('Ease of Setup', 5, 3, 'Better Proposals is learnable in an afternoon - templates are ready to customise and the interface is simple. Proposify has more depth but also more complexity that requires time to configure team workflows and content library.'),
  ('Template Library', 4, 4, 'Both tools offer a substantial library of industry-specific proposal templates. Better Proposals library is strong for freelance verticals; Proposify has more agency-focused and enterprise service templates.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'better-proposals-vs-proposify')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'better-proposals-vs-proposify');
