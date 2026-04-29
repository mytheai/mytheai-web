-- compare-batch-50.sql
-- 5 AI Translation & Localization tool comparison pairs
-- All tools from tools-batch-50 (phrase, lokalise, smartling, crowdin, transifex, weglot, lilt, unbabel, trados, poeditor)
-- Run AFTER tools-batch-50 confirmed in Supabase

-- 1. phrase-vs-lokalise
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'phrase-vs-lokalise', 'phrase', 'lokalise',
  'Phrase and Lokalise are the two leading translation management platforms for software and product teams, and choosing between them comes down to workflow philosophy and technical depth. Phrase is the engineering-first TMS - its branch-based localization model mirrors how developers already work in Git, making it the natural choice for teams where localization is tightly coupled with the software release cycle. Lokalise is the product-first platform - its AI Hub, visual translation editing, and task management make it accessible to non-technical localization managers and marketing teams alongside engineers. Phrase wins for software teams where developers are the primary users and where localization needs to live inside the code workflow. Lokalise wins for product companies where a mix of engineers, product managers, and translators collaborate on localization, and where AI-assisted cultural adaptation for marketing content matters alongside product strings.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'phrase-vs-lokalise');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'phrase-vs-lokalise', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Git and CI/CD Integration', 5, 4, 'Phrase GitHub, GitLab, and Bitbucket integrations are branch-aware - translations follow code branches through the development lifecycle, keeping localization in sync with feature development. Lokalise integrates with the same platforms but is less focused on branch-based workflows as the primary paradigm.'),
  ('AI Translation Quality', 4, 5, 'Lokalise AI Hub provides a single interface for configuring multi-engine AI translation with cultural adaptation suggestions and brand tone enforcement. Phrase supports DeepL, Google, and OpenAI translation but the AI configuration is less centralized than Lokalise''s dedicated AI Hub.'),
  ('Non-Technical User Experience', 3, 5, 'Lokalise is designed for mixed teams where localization managers, marketing teams, and translators work alongside developers - the interface is approachable for non-technical users. Phrase''s power comes from its developer-first architecture, which can feel complex for localization managers without technical backgrounds.'),
  ('String Management and QA', 5, 4, 'Phrase Quality Assurance engine catches missing variables, inconsistent terminology, placeholder errors, and formatting issues with granular control over which checks apply to which content types. Lokalise QA checks are solid but Phrase has a slight edge in engineering-focused QA depth.'),
  ('Translation Memory', 5, 5, 'Both Phrase and Lokalise provide comprehensive translation memory with leverage reporting, pre-translation from TM, and cross-project memory sharing. Translation memory quality is a core feature for both platforms and neither has a meaningful advantage.'),
  ('Pricing', 4, 3, 'Phrase Team plan starts around $27 per month per seat. Lokalise Team plans start around $120 per month for a team. For small teams, Phrase is significantly more accessible. For large teams with high translation volumes, both platforms require enterprise pricing conversations.'),
  ('Mobile OTA Delivery', 3, 4, 'Lokalise OTA SDK enables mobile app translation updates without an app store release. Phrase offers similar over-the-air capabilities but Lokalise''s mobile SDK is more mature and better documented for React Native and Flutter teams.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'phrase-vs-lokalise')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'phrase-vs-lokalise');

-- 2. crowdin-vs-transifex
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'crowdin-vs-transifex', 'crowdin', 'transifex',
  'Crowdin and Transifex are both long-established localization platforms with strong developer integration stories, but they serve different localization maturity levels and workflow models. Crowdin excels at developer-friendly localization with its OTA mobile delivery, in-context translation that shows translators where strings appear in the live product, and a community platform that powers thousands of open-source and game localization projects. Transifex is the platform for enterprise localization programmes with complex multi-stage workflows, dedicated vendor management, and reporting depth that localization programme managers need to track costs and quality across large translation networks. Crowdin wins for product teams and open-source projects that need modern developer integrations and OTA delivery. Transifex wins for enterprise teams running localization as a formal programme with multiple internal teams, external vendors, and complex approval workflows.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'crowdin-vs-transifex');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'crowdin-vs-transifex', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('OTA Mobile Delivery', 5, 3, 'Crowdin OTA delivers translation updates to mobile apps in production without a new app store release - a native feature of the Crowdin iOS and Android SDKs. Transifex Native offers similar capability but Crowdin''s OTA implementation is more mature and widely adopted.'),
  ('Open-Source Community Support', 5, 4, 'Crowdin has powered open-source project localization for over a decade - the community platform is free for open-source projects and hosts thousands of active translation communities. Transifex also has an open-source programme but Crowdin is the default choice in the open-source ecosystem.'),
  ('Enterprise Workflow Management', 3, 5, 'Transifex multi-stage workflow engine supports complex approval chains, vendor routing, quality review stages, and different workflows for different content types and target markets. Crowdin workflows are capable but less sophisticated for large enterprise programmes with multiple vendor relationships.'),
  ('In-Context Localization', 5, 3, 'Crowdin in-context translation shows translators exactly where strings appear in the live web application, dramatically reducing disambiguation errors. Transifex offers basic in-context editing but Crowdin''s implementation is more developed for web app localization.'),
  ('Reporting and Analytics', 3, 5, 'Transifex provides comprehensive localization programme reporting - translation costs, vendor productivity, quality scores, and progress metrics across the full translation pipeline. Crowdin reporting covers project progress but lacks the programme-level financial and quality analytics that Transifex provides.'),
  ('Pricing', 4, 3, 'Crowdin free plan covers open-source projects. Paid plans start around $25 per month for private projects. Transifex has a free tier but meaningful paid features require higher-tier plans. Both offer enterprise pricing on request.'),
  ('Developer Experience', 5, 4, 'Crowdin CLI, GitHub integration, and API are widely praised in developer communities for their documentation quality and reliability. Transifex developer tools are solid but Crowdin has a slight edge in developer-first experience and community resources.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'crowdin-vs-transifex')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'crowdin-vs-transifex');

-- 3. weglot-vs-crowdin
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'weglot-vs-crowdin', 'weglot', 'crowdin',
  'Weglot and Crowdin solve different localization problems despite both serving product and marketing teams. Weglot is a website localization proxy - it intercepts content at the CDN level and serves translated versions without touching your codebase, making it the fastest path to a multilingual marketing website on any CMS or website builder. Crowdin is a translation management system built for localizing software products, mobile apps, and documentation through structured string files and developer integrations. These tools are not direct competitors in most cases - many teams use both. Weglot wins decisively for marketing websites, landing pages, and any web content where no-code deployment and live visual editing matter more than TMS workflow depth. Crowdin wins for product localization where translations live in code files and need to follow the software development lifecycle through CI/CD pipelines.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'weglot-vs-crowdin');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'weglot-vs-crowdin', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Website Localization Speed', 5, 2, 'Weglot installs as a JavaScript snippet or CMS plugin - a non-technical team member can have a multilingual website live within an hour. Crowdin requires developer setup with file exports, translation workflows, and code deployments to localize a website.'),
  ('No-Code Deployment', 5, 1, 'Weglot is explicitly no-code - no developer required beyond initial snippet installation. It works with WordPress, Shopify, Webflow, Wix, and any static site generator out of the box. Crowdin requires developer involvement for every integration and deployment.'),
  ('Software and App Localization', 2, 5, 'Crowdin is purpose-built for software localization - it handles JSON, YAML, PO files, iOS strings, Android XML, and dozens of other developer file formats with native CI/CD integration. Weglot cannot localize native mobile apps or string-file-based software products.'),
  ('Translation Workflow Depth', 2, 5, 'Crowdin provides a full TMS workflow with translation memory, QA checks, contributor roles, and multi-stage review. Weglot''s visual editor handles translation management but lacks the enterprise TMS workflow features needed for large team collaboration.'),
  ('CMS Integration', 5, 3, 'Weglot integrates with every major CMS natively - WordPress, Shopify, Webflow, Squarespace, and more. Crowdin integrates with content-heavy CMSs like Contentful and Phrase but the setup requires technical configuration compared to Weglot''s one-click plugins.'),
  ('Pricing', 4, 4, 'Weglot pricing scales by word count and language pairs - free up to 2,000 words, paid from around $17 per month. Crowdin free for open-source, paid from $25 per month for private projects. Both are accessible for small teams.'),
  ('Visual In-Context Editing', 5, 3, 'Weglot visual editor shows translations in the exact context of the live website as translators edit - non-technical translators immediately see the result of their changes. Crowdin in-context translation is strong for web apps but less seamless for marketing website content.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'weglot-vs-crowdin')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'weglot-vs-crowdin');

-- 4. smartling-vs-trados
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'smartling-vs-trados', 'smartling', 'trados',
  'Smartling and Trados represent two different eras of enterprise translation technology. Trados Studio is the desktop-first computer-aided translation (CAT) tool that professional translators have used for decades - it remains the industry standard for freelance translators and language service providers who need a powerful offline workbench. Smartling is the cloud-first enterprise TMS built for brand localization programmes that need to manage translation at scale across marketing, product, and customer content simultaneously, with AI at the centre of the translation process. Smartling wins for enterprise brands running centralized localization programmes where content volume, speed, and AI quality are the primary metrics. Trados wins for professional translation agencies, freelance translators, and enterprise teams that work closely with language service providers who use Trados as their standard tool - ensuring translation memory and terminology are compatible across the supply chain.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'smartling-vs-trados');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'smartling-vs-trados', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('AI Translation Engine', 5, 3, 'Smartling Neural Translation Engine is custom-fine-tuned on each client''s translation history, delivering higher quality machine translation than generic engines for established programmes. Trados provides AI pre-translation via third-party engines (DeepL, Google) but the fine-tuning capability is less developed than Smartling''s proprietary approach.'),
  ('Professional Translator Adoption', 2, 5, 'Trados Studio is the industry-standard CAT tool for professional translators worldwide - most LSPs and freelance translators already have Trados licences. Smartling provides a browser-based translation editor but professional translators often prefer desktop CAT tools for productivity.'),
  ('Cloud-Native Architecture', 5, 3, 'Smartling is fully cloud-native - all content, translation memory, and workflows live in the cloud with no desktop software required. Trados Studio is primarily a desktop application with cloud features added over time, creating hybrid complexity for teams that want pure cloud deployment.'),
  ('Content Integration Depth', 5, 3, 'Smartling integrates with marketing platforms, CMS systems, and product tools natively - Contentful, Adobe Experience Manager, Salesforce, and more. Trados integrations focus on file-format support and LSP workflows rather than cloud platform connectors.'),
  ('Enterprise Localization Management', 5, 4, 'Smartling provides programme-level reporting, vendor management, cost tracking, and workflow automation that localization programme managers need at enterprise scale. Trados provides these features in its enterprise cloud offering but Smartling''s management layer is more developed for brand localization teams.'),
  ('Pricing', 3, 4, 'Trados Studio licences are available for individual translators from around $115 per year. Smartling is enterprise-only pricing with no self-serve - minimum investment typically $1,000+ per month. For professional translators and small LSPs, Trados is significantly more accessible.'),
  ('Translation Memory Portability', 3, 5, 'Trados TMX format is the universal standard for translation memory exchange - TM built in Trados works with any other CAT tool. Smartling translation memory is highly functional but exporting in formats compatible with other tools requires additional steps.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'smartling-vs-trados')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'smartling-vs-trados');

-- 5. lilt-vs-unbabel
INSERT INTO comparisons (slug, tool_a_slug, tool_b_slug, summary, winner, updated_at)
SELECT 'lilt-vs-unbabel', 'lilt', 'unbabel',
  'Lilt and Unbabel both combine AI machine translation with human linguists to deliver quality above what pure machine translation achieves, but they target completely different content types and business functions. Lilt is a general-purpose AI translation platform that applies its human-in-the-loop model to product documentation, marketing content, legal documents, and technical content - any content type that benefits from the combination of AI speed and human quality assurance. Unbabel specializes in customer support translation - it translates support tickets, chat messages, and emails in real time so global customers receive responses in their language from the same support team without requiring multilingual agents. Lilt wins for companies that need high-quality AI-assisted translation for diverse content types across multiple business functions. Unbabel wins specifically for support operations where the use case is real-time customer communication translation rather than content localization.',
  NULL,
  NOW()
WHERE NOT EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lilt-vs-unbabel');

INSERT INTO comparison_criteria (comparison_slug, name, tool_a_score, tool_b_score, notes)
SELECT 'lilt-vs-unbabel', name, tool_a_score, tool_b_score, notes FROM (VALUES
  ('Content Type Breadth', 5, 2, 'Lilt handles any content type - product documentation, marketing copy, legal documents, technical manuals, and software strings. Unbabel''s strength is narrowly focused on customer support communication - tickets, chat, and email. Using Unbabel for general content translation is not its intended use case.'),
  ('Customer Support Translation', 2, 5, 'Unbabel is purpose-built for support operations - it integrates natively with Zendesk, Salesforce Service Cloud, and other support platforms to translate conversations in real time. Lilt does not provide the real-time support workflow integrations that Unbabel''s support-specific platform offers.'),
  ('Human-in-the-Loop Quality', 5, 4, 'Lilt''s model pairs AI translation with professional human post-editors who improve output quality over time - the AI learns from human corrections, creating a feedback loop that continuously improves quality for each client''s content. Unbabel uses a similar model but optimized for short support messages rather than long-form content.'),
  ('AI Learning and Improvement', 5, 4, 'Lilt''s AI model is fine-tuned on each client''s previous translations, terminology, and style guides - quality improves as more content is translated. Unbabel''s model similarly learns from corrections but the short-form nature of support content limits the depth of style and terminology learning.'),
  ('Integration Ecosystem', 3, 5, 'Unbabel''s integrations are deep and specialized - Zendesk, Salesforce, Freshdesk, and other support platforms receive real-time translated content through native connectors. Lilt integrates with file-based workflows and some CMS platforms but lacks Unbabel''s depth of support platform integration.'),
  ('Real-Time Translation', 2, 5, 'Unbabel real-time translation delivers translated support responses with enough speed for live chat interactions. Lilt is optimized for batch document and content translation workflows where a few hours of turnaround is acceptable rather than real-time conversation flow.'),
  ('Pricing', 3, 3, 'Both Lilt and Unbabel are enterprise-only platforms requiring sales engagement. Pricing for both is based on volume - translation volume, languages, and team size. Neither publishes transparent pricing and both typically require minimum annual commitments for enterprise customers.')
) AS t(name, tool_a_score, tool_b_score, notes)
WHERE EXISTS (SELECT 1 FROM comparisons WHERE slug = 'lilt-vs-unbabel')
  AND NOT EXISTS (SELECT 1 FROM comparison_criteria WHERE comparison_slug = 'lilt-vs-unbabel');
