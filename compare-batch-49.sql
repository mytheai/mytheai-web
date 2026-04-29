-- compare-batch-49.sql
-- 5 AI Customer Success tool comparison pairs
-- All tools from tools-batch-49 (gainsight, totango, churnzero, planhat, vitally, catalyst, client-success, userpilot, custify, akita)
-- Run AFTER tools-batch-49 confirmed in Supabase

-- 1. gainsight-vs-churnzero
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'gainsight-vs-churnzero', 'gainsight', 'churnzero',
  'Gainsight and ChurnZero are both leading customer success platforms, but they serve different company profiles and CS maturity levels. Gainsight is the comprehensive enterprise CS platform - it handles complex multi-segment books of business with sophisticated playbook engines, Salesforce-depth integrations, and AI-generated account briefings that support large CS teams managing hundreds of enterprise accounts. ChurnZero is built for automation-first mid-market CS teams that want health scores and playbook triggers to run without manual configuration overhead - its real-time alerts, in-app engagement layer, and faster time-to-value make it the stronger choice for teams that need results quickly without a lengthy professional services engagement. Gainsight wins for enterprise SaaS companies with complex CS operations, large deal sizes, and dedicated CS operations teams to configure and maintain the platform. ChurnZero wins for mid-market SaaS companies that want automated CS workflows deployed in weeks rather than months, with built-in in-app messaging that eliminates the need for a separate product adoption tool.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gainsight-vs-churnzero');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'gainsight-vs-churnzero', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Enterprise Playbook Depth', 5, 3, 'Gainsight playbook engine supports multi-step conditional branching, cross-team workflows, and success plan templates that cover the full enterprise CS motion. ChurnZero playbooks are effective for automated triggers and sequences but lack the configurability needed for complex enterprise CS programmes.'),
  ('Time to Value', 2, 5, 'ChurnZero deploys in days to weeks with a self-serve configuration model that does not require professional services. Gainsight enterprise deployments typically take 3 to 6 months with dedicated implementation support - appropriate for enterprise scale but a significant time investment.'),
  ('In-App Engagement', 2, 5, 'ChurnZero includes in-app messaging, walkthroughs, and contextual prompts that CS teams configure without engineering support - eliminating the need for a separate product adoption tool. Gainsight does not include equivalent in-app engagement capabilities in its core platform.'),
  ('AI Account Intelligence', 5, 3, 'Gainsight Horizon AI generates account briefings, next-action recommendations, and renewal likelihood scores from the full history of customer interactions. ChurnZero real-time alerts are strong for event-driven signals but AI synthesis across the full account relationship is less developed.'),
  ('Salesforce Integration', 5, 4, 'Gainsight bidirectional Salesforce integration is among the deepest in the category - CS activity syncs to opportunity records, health scores appear in Salesforce dashboards, and renewal data flows both ways. ChurnZero Salesforce integration is solid but less deeply embedded in the Salesforce workflow.'),
  ('Mid-Market Fit', 2, 5, 'ChurnZero pricing, deployment speed, and product complexity match mid-market SaaS teams managing 100 to 1,000 accounts. Gainsight at enterprise pricing and implementation complexity is not practical for most mid-market CS teams.'),
  ('Pricing', 2, 4, 'ChurnZero starts around $1,250 per month with transparent mid-market pricing. Gainsight enterprise pricing typically starts from $40,000 per year and scales significantly with customer count and seat volume - appropriate for enterprise but out of reach for most mid-market teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'gainsight-vs-churnzero')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'gainsight-vs-churnzero');

-- 2. planhat-vs-vitally
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'planhat-vs-vitally', 'planhat', 'vitally',
  'Planhat and Vitally are both modern customer success platforms built for growth-stage SaaS companies that have outgrown spreadsheets but do not need enterprise CS complexity. The key difference is in their CS philosophy: Planhat is revenue-first - it tracks ARR by customer, models renewal scenarios, and gives CS leadership a portfolio view of net revenue retention that makes CS a business function rather than just a support function. Vitally is product-data-first - it is built for product-led growth companies where product usage is the primary customer health signal, and where automated product-triggered CS workflows replace manual account monitoring at scale. Planhat wins for CS teams where renewal forecasting, expansion revenue tracking, and portfolio NRR visibility are the primary requirements - particularly for companies with high ACV enterprise or mid-market contracts. Vitally wins for PLG SaaS companies with large customer volumes, self-serve adoption models, and product usage data as the core health signal - where CS needs to operate efficiently at scale without proportional headcount growth.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'planhat-vs-vitally');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'planhat-vs-vitally', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Revenue and NRR Visibility', 5, 3, 'Planhat tracks ARR by customer, models renewal scenarios, and shows projected NRR at portfolio level - CS leadership has a single revenue health number without a separate finance tool. Vitally has revenue data but the primary focus is product health metrics rather than revenue portfolio management.'),
  ('PLG and Product Data Depth', 2, 5, 'Vitally is purpose-built for PLG companies - it ingests Segment, Amplitude, and Mixpanel data to build product-usage health scores that update in real time as users engage with features. Planhat handles product data but is not optimised for the PLG model where product signals drive the entire CS motion.'),
  ('Automated CS Workflows at Scale', 3, 5, 'Vitally Blueprints define the ideal customer journey with automated actions at each milestone, enabling a small CS team to manage large customer volumes efficiently. Planhat playbooks are effective but require more manual CS touchpoints for the same account volume.'),
  ('Renewal and Expansion Tracking', 5, 3, 'Planhat renewal management tracks renewal dates, ARR risk, and expansion opportunities across the portfolio with forecasting that supports CS leadership quarterly planning. Vitally renewal tracking is available but less central to the platform experience.'),
  ('Time to Deploy', 4, 4, 'Both Planhat and Vitally deploy in weeks rather than months compared to enterprise platforms. Planhat''s Salesforce and HubSpot integrations are bidirectional and set up quickly. Vitally''s product data integrations via Segment and Amplitude require data pipeline configuration that adds some setup time.'),
  ('Small Team Efficiency', 4, 5, 'Vitally''s automation model is designed specifically for small CS teams managing large account volumes through automated workflows rather than manual monitoring. Planhat is strong for small teams but the NRR and revenue focus requires more active management than Vitally''s automated journey model.'),
  ('Pricing', 4, 4, 'Planhat starts around $1,000 per month. Vitally starts around $750 per month. Both are accessible for growth-stage SaaS teams compared to enterprise CS platform pricing - the difference is not significant enough to be the primary decision factor.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'planhat-vs-vitally')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'planhat-vs-vitally');

-- 3. totango-vs-client-success
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'totango-vs-client-success', 'totango', 'client-success',
  'Totango and ClientSuccess both target mid-market SaaS CS teams, but with fundamentally different approaches to what drives retention. Totango is a journey orchestration platform - it provides pre-built SuccessBLOC playbooks for each customer lifecycle stage and manages CS as a structured journey through defined milestones and automated touchpoints. ClientSuccess is a relationship intelligence platform - it focuses on the human relationship with key stakeholders inside each customer account, tracking relationship strength, contact activity, and engagement patterns alongside product usage. Totango wins for CS teams that need to systematise their CS process quickly using proven playbook templates without building from scratch, and for companies with multiple customer segments requiring different journey models. ClientSuccess wins for B2B companies where the quality of the human relationship with executive sponsors and key stakeholders is the primary retention driver, and where understanding who the decision-makers are and how engaged they are matters as much as product usage data.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'totango-vs-client-success');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'totango-vs-client-success', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Pre-Built Playbooks', 5, 2, 'Totango SuccessBLOCs provide pre-configured playbooks for onboarding, adoption, renewal, and expansion that teams activate and customise rather than building from scratch. ClientSuccess does not provide equivalent pre-built lifecycle playbooks - CS teams configure their own workflows.'),
  ('Relationship Intelligence', 2, 5, 'ClientSuccess tracks relationship strength scores, contact engagement history, and stakeholder mapping for each account - identifying weak relationships with key decision-makers before they become churn risk. Totango focuses on product usage and journey stage rather than relationship quality signals.'),
  ('Multi-Segment Journey Management', 5, 3, 'Totango supports completely separate health scoring models and journey playbooks for Enterprise, Mid-Market, and SMB segments within one platform. ClientSuccess supports segmentation but the multi-segment journey orchestration is less developed.'),
  ('Stakeholder Mapping', 2, 5, 'ClientSuccess maps every contact at a customer account with relationship strength scores, tracking which stakeholders are engaged, which are disengaged, and who the key decision-makers are. Totango tracks contacts but does not provide the same depth of relationship quality analysis.'),
  ('AI Account Intelligence', 4, 3, 'Totango Spark AI generates account summaries and next-best-action recommendations based on usage and journey signals. ClientSuccess AI features are developing but relationship intelligence is the platform''s core strength rather than AI-generated insights.'),
  ('Free Tier', 4, 1, 'Totango offers a free plan for up to 100 customers - meaningful for early-stage teams to start building their CS process before committing to paid. ClientSuccess does not have a free tier.'),
  ('Pricing', 4, 3, 'Totango paid plans start around $2,000 per month with a free tier available. ClientSuccess pricing requires a sales conversation and is typically in the $1,000 to $2,500 per month range depending on customer count and seats.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'totango-vs-client-success')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'totango-vs-client-success');

-- 4. userpilot-vs-catalyst
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'userpilot-vs-catalyst', 'userpilot', 'catalyst',
  'Userpilot and Catalyst sit at the intersection of product adoption and customer success, but they approach the problem from opposite directions. Userpilot is a product adoption platform that gives CS teams the ability to build in-app onboarding flows, feature announcements, and contextual help content without engineering support - then tracks which product adoption patterns correlate with retention and expansion. Catalyst is a modern CS platform that emphasises clean design, fast deployment, and a CSM-first experience that makes it practical for CS teams that have been frustrated by the complexity of legacy enterprise platforms. Userpilot wins for product teams and CS teams that need to directly influence how users adopt key features inside the product - embedding guidance, walkthroughs, and tooltips at the moments of friction rather than relying on email follow-up. Catalyst wins for CS teams that want a full customer success platform with health scoring, playbooks, and Salesforce integration that deploys in days rather than months, without the implementation overhead of Gainsight or ChurnZero.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'userpilot-vs-catalyst');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'userpilot-vs-catalyst', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('In-App Adoption Tools', 5, 1, 'Userpilot builds in-app flows, onboarding checklists, tooltips, and feature announcements without engineering - this is its primary capability. Catalyst is a CS management platform and does not include in-app engagement tools.'),
  ('CS Health Scoring and Playbooks', 2, 5, 'Catalyst provides a full CS platform with health scoring, playbooks, and account management workflows that CSMs use to manage their book of business daily. Userpilot''s health data comes from feature adoption metrics but it is not a full CS platform.'),
  ('Product Adoption Analytics', 5, 2, 'Userpilot tracks feature adoption, activation milestones, and user behaviour inside the product with analytics that show which product experiences correlate with retention. Catalyst focuses on account-level health signals rather than individual user behaviour inside the product.'),
  ('CSM Daily Workflow', 2, 5, 'Catalyst is designed for the CSM daily workflow - account views, task management, customer timeline, and playbook triggers in one place. Userpilot is a product team tool that CS teams use to build guidance but not as the primary daily CS management interface.'),
  ('Deployment Speed', 4, 5, 'Catalyst deploys in days with a clean self-serve configuration model. Userpilot code snippet installation and flow building is also fast for product teams - both are significantly faster than legacy enterprise CS platforms.'),
  ('Pricing', 4, 4, 'Userpilot starts around $249 per month for smaller teams. Catalyst pricing is available on request and typically starts in a similar range for small CS teams. Both are accessible compared to enterprise CS platform pricing.'),
  ('Salesforce Integration', 2, 5, 'Catalyst Salesforce integration is a core feature - health scores appear in Salesforce, CS tasks sync to CRM records, and renewal data flows bidirectionally. Userpilot Salesforce integration is available but product adoption data does not flow into the CRM in the same way.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'userpilot-vs-catalyst')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'userpilot-vs-catalyst');

-- 5. custify-vs-akita
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'custify-vs-akita', 'custify', 'akita',
  'Custify and Akita both serve SaaS companies that need customer health monitoring without the cost and complexity of enterprise CS platforms, but they target different points on the CS sophistication spectrum. Custify is a full customer success platform for SMB SaaS companies - health scoring, automated playbooks, lifecycle stages, and CRM integrations that give a small CS team the tools to manage their book of business proactively. Akita is a lightweight customer health monitoring tool that connects to any data source via API or integrations, surfaces risk alerts and health trends, and provides the visibility a founder or account manager needs to spot churn risk early - without the full CS workflow infrastructure of a platform like Custify. Custify wins for SaaS companies with a dedicated CS team that needs the full CS workflow: health scores, automated playbooks, renewal tracking, and team task management. Akita wins for SaaS companies where the founder or sales team needs customer health visibility without a dedicated CS motion - a signal layer rather than a workflow platform.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'custify-vs-akita');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'custify-vs-akita', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Playbook Automation', 5, 1, 'Custify provides full playbook automation - configure multi-step sequences that trigger based on health score changes, lifecycle events, or date-based rules. Akita surfaces health alerts and trends but does not include playbook or workflow automation.'),
  ('Setup Simplicity', 3, 5, 'Akita connects to data sources via API and integrations in minutes and surfaces health signals without a lengthy configuration process. Custify requires more setup time to configure health scoring models, lifecycle stages, and playbook rules before the CS team sees value.'),
  ('CS Team Workflow', 5, 2, 'Custify is designed as the CSM''s daily workspace - account health views, task management, customer timelines, and playbook triggers in one interface. Akita is a monitoring and alerting layer, not a full CS team workflow tool.'),
  ('Data Integration Flexibility', 3, 5, 'Akita connects to virtually any data source via its open API - Stripe, Intercom, Segment, custom product databases - giving founders and technical teams flexible health signal ingestion. Custify integrations are solid but less API-first for custom data source connections.'),
  ('SMB CS Fit', 5, 3, 'Custify is purpose-built for SMB SaaS CS teams managing 50 to 500 accounts with a small number of CSMs. Akita serves the same company size but as a health monitoring layer rather than a full CS platform - better suited to companies without dedicated CSMs.'),
  ('Pricing', 4, 5, 'Akita is significantly more affordable than Custify - designed as a lightweight monitoring tool rather than a full CS platform. Custify pricing is reasonable for a CS platform but higher than Akita for teams that only need health visibility rather than full CS workflow.'),
  ('Renewal and Expansion Tracking', 4, 2, 'Custify tracks renewal dates, expansion opportunities, and lifecycle stages in the platform. Akita focuses on health signal monitoring and risk alerts rather than renewal workflow management.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'custify-vs-akita')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'custify-vs-akita');
