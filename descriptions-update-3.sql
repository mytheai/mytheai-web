-- Session 13: Descriptions Batch B — 19 remaining tools
-- Run in Supabase SQL Editor after descriptions-update-2.sql

UPDATE tools SET description = 'Mistral AI is a European AI company producing open-weight and commercial large language models that compete directly with OpenAI and Anthropic on capability while offering more flexibility in deployment. Mistral''s models can be run locally on your own hardware (open-weight versions), deployed via Mistral''s own API (La Plateforme), or accessed through cloud providers including Microsoft Azure and Google Cloud.

The core appeal of Mistral is the combination of performance and openness. Mistral 7B and Mixtral 8x7B are open-weight models that can run on consumer hardware, making them the preferred choice for developers who want to experiment with AI capabilities without API costs or data privacy concerns. Despite their size, they perform competitively with larger closed models on many benchmarks.

Mistral Large and Mistral Small are the commercial API models. Mistral Large competes with GPT-4 class models on reasoning, coding, and multilingual tasks, while Mistral Small offers a faster, lower-cost option for tasks that do not require top-tier reasoning.

The platform is particularly popular with European enterprises that need AI capabilities with data residency in the EU — Mistral''s infrastructure is EU-based, which simplifies GDPR compliance compared to US-hosted alternatives.

Le Chat, Mistral''s consumer-facing AI assistant, provides a ChatGPT-like interface for everyday tasks and is free to use.

For developers building on top of AI models, Mistral offers a straightforward API with competitive pricing and generous rate limits. It is best suited to teams that value model transparency, EU data residency, or the ability to self-host their AI infrastructure.'
WHERE slug = 'mistral';

UPDATE tools SET description = 'Microsoft Copilot is Microsoft''s AI assistant, embedded across the Microsoft 365 product suite — Word, Excel, PowerPoint, Outlook, Teams, and OneNote — as well as available as a standalone chat interface. For the hundreds of millions of people and organisations already using Microsoft 365, Copilot is the most frictionless path to AI-assisted productivity because it operates directly inside the tools they already use every day.

In Word, Copilot drafts new documents from a brief prompt, rewrites selected sections, and summarises long documents into key points. In Excel, it generates formulas, creates charts from natural language descriptions, and analyses datasets with plain-language queries. In PowerPoint, it creates complete presentations from a prompt or a Word document, adds relevant visuals, and rewrites speaker notes.

Copilot in Teams transcribes and summarises meetings in real time — so participants who join late or miss a meeting entirely can get an accurate summary of what was discussed and what decisions were made. This alone has been one of the most widely cited productivity wins by enterprise customers.

In Outlook, Copilot drafts email replies based on context, summarises long email threads, and helps schedule meetings by understanding the context of conversations.

Microsoft Copilot for Microsoft 365 is available as an add-on to business and enterprise Microsoft 365 subscriptions, priced at $30 per user per month. A free version of Copilot (chat-only, powered by GPT-4) is available at copilot.microsoft.com without a subscription.

Copilot is best suited to organisations already standardised on Microsoft 365 who want AI assistance that works within their existing tools rather than requiring workflow changes.'
WHERE slug = 'copilot-microsoft';

UPDATE tools SET description = 'Otter.ai is an AI meeting assistant that transcribes conversations in real time, generates summaries, and extracts action items automatically. It integrates with Zoom, Google Meet, and Microsoft Teams — joining meetings as a participant to record and transcribe without requiring everyone on the call to use Otter.

The real-time transcription is accurate enough for most professional conversations, including technical discussions and meetings with multiple speakers. Speaker identification labels each speaker''s contributions separately, making it easy to attribute specific statements or decisions to the right person in post-meeting review.

Otter''s AI summary, delivered at the end of each meeting, distills the key discussion points, decisions made, and action items assigned into a short, scannable document. For teams that hold multiple meetings per day, this eliminates the time spent writing meeting notes and reduces the chance that decisions or follow-ups are lost.

The Channels feature allows teams to share meeting recordings and transcripts centrally — so anyone who missed a meeting can review the full transcript or the AI summary without requesting a recording separately.

The Meeting Gems feature lets you highlight and comment on specific moments in a live transcript during the meeting itself — useful for flagging important points or questions as they occur.

The free plan provides 300 minutes of transcription per month — enough for several meetings. Pro at $16.99 per month per user and Business at $30 per month per user unlock longer recordings, more storage, and team features.

Otter is best suited to remote and hybrid teams who hold regular meetings and want an automatic record of what was discussed and agreed without manual note-taking.'
WHERE slug = 'otter-ai';

UPDATE tools SET description = 'HubSpot is the leading CRM and inbound marketing platform for small to mid-sized businesses. It combines contact management, email marketing, sales pipeline tracking, customer support tools, and website management into a single platform — with AI features embedded throughout to assist with content creation, lead scoring, and customer communication.

The free CRM is HubSpot''s entry point and is genuinely capable: contact records, company records, deal tracking, and a basic email integration are all available at no cost. This makes HubSpot the easiest CRM for growing teams to adopt, since the barrier to getting started is low.

HubSpot''s Marketing Hub handles email campaigns, landing pages, forms, and marketing automation. The workflow builder lets you set up sequences triggered by contact behaviour — a series of emails after a form submission, an alert to sales when a lead reaches a certain score, an SMS when a deal reaches a certain stage. The drag-and-drop email editor and template library reduce the technical barrier for non-designers.

Sales Hub adds email sequences for sales outreach, meeting scheduling, quote generation, and a full pipeline view with forecasting. The AI features include email writing assistance, call transcription and summary, and lead scoring based on engagement patterns.

Content Hub (formerly CMS Hub) provides website hosting, blogging, and SEO tools. For teams that want their marketing site, blog, and CRM in the same ecosystem, this eliminates the need for a separate CMS like WordPress.

Pricing varies significantly by hub and tier. The free CRM is genuinely free. Paid hubs start at $20 per month for Starter and scale to thousands for Enterprise. HubSpot is best suited to B2B companies that want their marketing, sales, and support teams working from a single customer data platform.'
WHERE slug = 'hubspot';

UPDATE tools SET description = 'Airtable is a low-code data management platform that sits between a spreadsheet and a database. It lets non-technical teams build custom applications — project trackers, content calendars, product roadmaps, inventory systems, CRM pipelines — using a visual interface, without needing a developer to write and maintain backend code.

The base concept is flexible but intuitive: data is stored in tables, like a spreadsheet, but each column has a defined field type — text, number, date, attachment, linked record, formula, or lookup. Linked records connect tables together relationally, so a project table can link to a contacts table and a tasks table, creating a simple relational database that anyone on the team can update through a clean form or grid interface.

Views let different teams see the same data in different formats: a grid for data entry, a Kanban board for status tracking, a calendar for scheduling, a Gantt for project planning, and a gallery for visual content. All views update the same underlying data — so there is one source of truth regardless of how each team member prefers to work.

Airtable Automations handles routine workflows: sending a notification when a record changes state, creating new records from form submissions, syncing data with external tools. The integration library connects to Slack, Salesforce, Google Workspace, and hundreds of other applications.

The AI features, available on higher tiers, can summarise text fields, categorise records automatically, and generate content based on field values.

The free plan supports unlimited bases up to 1,000 records each. Team plans start at $20 per user per month. Airtable is best suited to operations, marketing, and product teams that have outgrown spreadsheets but do not want to wait for engineering resources to build a custom solution.'
WHERE slug = 'airtable';

UPDATE tools SET description = 'Mem is an AI-powered note-taking app built around the idea that your notes should organise themselves. Rather than requiring you to maintain folders, tags, and hierarchies manually, Mem uses AI to surface relevant notes when you need them, connect related ideas automatically, and help you find anything you have written without remembering where you put it.

The core experience is a fast, frictionless writing surface. Notes are captured quickly — via the app, browser extension, or email — and Mem handles the organisation in the background. Related notes are linked automatically based on content similarity, so your knowledge base develops connections you might not have made manually.

Mem''s AI assistant, built into the app, can generate new content based on what you have already written, summarise groups of related notes, and answer questions about your knowledge base using your own notes as the source. This makes it closer to a personal knowledge assistant than a simple note-taking tool.

For teams, Mem offers shared workspaces where notes flow into a shared pool and the AI helps surface relevant colleague notes in context. This positions Mem between personal note-taking tools like Notion or Obsidian and team knowledge bases like Confluence.

Mem''s design is deliberately minimal — there is no complex hierarchy to maintain, no plugin ecosystem to configure. For knowledge workers who find complex systems like Roam Research or Logseq too technical, Mem offers the benefits of a connected knowledge graph with almost no setup overhead.

Mem pricing starts at $14.99 per month for the individual plan. It is best suited to writers, researchers, and knowledge workers who capture a lot of ideas and want their tool to help connect and retrieve them without manual curation.'
WHERE slug = 'mem-ai';

UPDATE tools SET description = 'Intercom is the customer messaging platform that pioneered the concept of the in-app chat widget — the floating button in the corner of nearly every SaaS product that lets users ask questions without leaving the application. It is used by thousands of technology companies to handle customer support, onboarding, and sales conversations through a unified messaging layer.

The AI agent, Fin, is Intercom''s most significant recent development. Fin is a conversational AI trained on your help documentation and support content that handles incoming customer queries automatically, resolving a significant proportion of requests without human involvement. According to Intercom''s own data, customers using Fin resolve between 40 and 70 percent of support conversations automatically. For support teams managing high volume at scale, this changes the economics of the function meaningfully.

The Inbox product is a shared team inbox for managing all incoming conversations — from in-app chat, email, WhatsApp, Instagram, and other channels — in a single interface. Conversation routing, assignment rules, and macros (templated replies) reduce the manual overhead of managing support queues.

The Messenger is the customisable chat widget embedded in your product or website. Proactive messages — triggered by user behaviour, plan type, or custom events — can be sent automatically to users at the right moment in their journey, which is valuable for onboarding and retention.

Intercom pricing starts at $39 per seat per month for the Essential plan, with usage-based pricing for Fin AI agent conversations. It is best suited to SaaS companies that want a unified platform for customer support, onboarding, and proactive engagement.'
WHERE slug = 'intercom';

UPDATE tools SET description = 'Zendesk AI is the artificial intelligence layer within Zendesk, one of the world''s most widely deployed customer support platforms. Zendesk serves more than 130,000 companies across enterprise, mid-market, and SMB segments, and has embedded AI throughout its Suite product to reduce support volume, accelerate agent resolution times, and improve customer self-service.

The AI triage feature analyses incoming tickets and automatically routes them to the right team, applies appropriate tags, and predicts priority. For high-volume support operations receiving thousands of tickets daily, this reduces the manual triage overhead that typically consumes team leads'' time.

Zendesk''s generative AI features assist agents in composing replies: summarising the ticket history to bring an agent up to speed quickly, suggesting reply drafts based on similar resolved tickets, and expanding bullet points into full responses. These features are most valuable in environments where agents handle many different issue types and cannot always be experts in every area.

The self-service layer — the Help Centre, chatbot, and knowledge base — is enhanced by AI that suggests relevant articles based on customer queries before they submit a ticket, and a conversational bot that handles common questions automatically. For customers, this means faster resolution; for teams, it means fewer tickets for simple questions.

Advanced AI, Zendesk''s premium AI tier, adds intelligent triage, intent detection, sentiment analysis, and more sophisticated automation. It is available as an add-on to Zendesk Suite plans.

Zendesk Suite pricing starts at $55 per agent per month (Team tier), with Professional at $115 and Enterprise at $169. Advanced AI is an additional $50 per agent per month. Zendesk is best suited to enterprise and mid-market companies with dedicated support operations.'
WHERE slug = 'zendesk';

UPDATE tools SET description = 'Pipedrive is a sales CRM designed by salespeople, for salespeople. Its defining feature is the pipeline view — a visual Kanban board of every deal in your sales process, showing exactly where each opportunity sits and what needs to happen next to move it forward. For small sales teams transitioning from spreadsheets or a general-purpose CRM, Pipedrive is typically the fastest to adopt and the easiest to maintain.

The deal-centric design reflects how most B2B sales actually work: a deal moves through stages (lead, qualified, proposal, negotiation, closed) and requires specific activities at each stage. Pipedrive''s interface keeps the next required action — a call, a meeting, a follow-up email — visible and overdue, reducing the likelihood of leads going cold through neglect.

Email integration syncs your inbox with Pipedrive records, automatically associating emails with the relevant deal and contact. The email tracker shows when a prospect opens your email, which allows sales reps to follow up when interest is highest.

Pipedrive AI features include a sales assistant that identifies which deals need attention, suggests follow-up actions based on deal activity, and drafts email messages. Lead scoring predicts which leads are most likely to convert based on historical patterns.

Automations handle repetitive tasks: creating follow-up activities automatically when a deal moves to a new stage, sending template emails on a schedule, updating deal values when conditions change.

Pricing starts at $14 per user per month for the Essential plan (billed annually), with Advanced at $34, Professional at $49, and Power and Enterprise tiers for larger organisations. Pipedrive is best suited to small to mid-sized B2B sales teams who want a CRM that keeps the focus on closing deals.'
WHERE slug = 'pipedrive';

UPDATE tools SET description = 'Tableau is the leading business intelligence and data visualisation platform, used by data analysts and business teams to explore, understand, and share insights from complex datasets. It is owned by Salesforce and is widely deployed in enterprise environments where data analysis is a core business function.

The core Tableau Desktop application connects to virtually any data source — SQL databases, Excel files, cloud data warehouses, Salesforce, Google Analytics, and hundreds of others — and provides a drag-and-drop interface for building visualisations. Charts, maps, scatter plots, heat maps, and custom dashboards can be built without writing code, though calculated fields and table calculations provide a powerful analytical layer for users who need it.

Tableau''s strength is the exploratory analysis experience. The ability to rapidly switch between chart types, add filters, drill into data by dimension, and test hypotheses visually is faster in Tableau than in most alternatives. For analysts who spend their time understanding data rather than just reporting it, this interactivity is a meaningful workflow advantage.

Tableau Server and Tableau Cloud allow published dashboards to be shared with stakeholders who can interact with them in a browser without needing a Tableau licence. Row-level security controls what data different users can see, making it suitable for large organisations with complex data governance requirements.

Tableau AI adds natural language querying (Ask Data) and automatic insights (Explain Data) that identify unusual patterns in the data and surface potential explanations.

Pricing for Tableau is seat-based and varies by deployment method. Creator licences (full authoring) start at $70 per user per month; Viewer licences for stakeholders start at $15 per month. Tableau is best suited to organisations with dedicated data teams and complex analytical requirements.'
WHERE slug = 'tableau';

UPDATE tools SET description = 'Metabase is an open-source business intelligence tool that lets non-technical teams query databases and build dashboards without writing SQL. It is used by startups and growing companies that want to give their teams direct access to their own data without requiring a data analyst to run every query.

The Question interface is Metabase''s core product for non-technical users. You select a table, apply filters, choose how to group the results, and Metabase constructs and runs the query automatically. The result can be saved as a chart, a table, or a single metric, and added to a shared dashboard. For operations managers, marketing teams, or product managers who need to answer data questions regularly without waiting for engineering support, this removes a significant bottleneck.

The Native Query Editor provides full SQL access for analysts and engineers who want more control. Questions built in SQL can be combined with visual questions on the same dashboard, giving teams the flexibility to mix approaches.

Metabase''s open-source edition is free to self-host, which makes it the lowest-cost path to a business intelligence tool for teams with the infrastructure to run it. The Cloud hosted version starts at $500 per month for the Pro tier.

Data permissions control which teams can see which data — essential for organisations where different teams should access only their own data and not cross-functional datasets.

Metabase is best suited to startups and technical teams that want to democratise data access internally without a large BI budget. It requires some technical setup to connect to a database and configure permissions, but the ongoing usage experience is designed for non-technical stakeholders.'
WHERE slug = 'metabase';

UPDATE tools SET description = 'Looker (now Looker Studio for the consumer product, Looker for the enterprise platform) is Google''s business intelligence and data exploration platform. The enterprise Looker platform is built around LookML — a modelling language that defines the relationships and business logic in your data — which makes it different in architecture from traditional BI tools and better suited to large organisations with complex data environments.

LookML is both Looker''s strength and its barrier to entry. A data team defines the metrics, dimensions, and relationships in LookML once — what "revenue" means, how "customer" is defined, which tables join to which — and business users can then explore and combine these definitions freely without needing to understand the underlying SQL. This prevents the common problem of different teams calculating the same metric differently and getting different answers.

Looker Studio (formerly Data Studio) is Google''s free, consumer-facing reporting tool. It connects to Google Analytics, Google Ads, Google Sheets, BigQuery, and hundreds of other sources via partner connectors, and lets anyone build shareable dashboards without writing code. It is not as powerful as the enterprise Looker platform, but is free and sufficient for standard reporting needs.

The enterprise Looker platform integrates deeply with BigQuery and the broader Google Cloud ecosystem, and is available across Google Cloud and major cloud providers. It includes an SDK for embedding Looker-powered analytics into other applications — a capability used by companies that want to offer analytics features inside their own products.

Looker enterprise pricing is custom and typically significant — it is targeted at organisations with established data teams and complex analytics requirements. Looker Studio is free. Looker is best suited to enterprises that need a governed, consistent semantic layer on top of their data warehouse.'
WHERE slug = 'looker';

UPDATE tools SET description = 'Elicit is an AI research assistant built specifically for literature review and evidence synthesis — the work of finding, reading, and making sense of large bodies of academic papers. It is used by researchers, policy analysts, systematic reviewers, and evidence-based practitioners who need to navigate scientific literature efficiently.

The core workflow: you type a research question in natural language, and Elicit searches a database of more than 125 million academic papers, identifies the most relevant studies, and extracts structured information from each — population studied, intervention applied, outcomes measured, and key findings. The extracted data is displayed in a table that makes cross-study comparison far faster than reading each paper individually.

The paper summary feature distils each paper''s abstract and methodology into a short, plain-language summary. For researchers screening dozens or hundreds of papers at the start of a review, this significantly reduces the time spent on initial screening decisions.

Elicit also extracts specific data types across a set of papers — effect sizes, sample sizes, study designs, confidence intervals — and organises them into structured columns. For systematic reviews and meta-analyses, this automates a significant portion of the data extraction work that is otherwise done manually.

The tool handles nuance reasonably well for a research context: it acknowledges uncertainty, distinguishes between papers that directly address a question and those that are tangentially relevant, and flags when search results may be incomplete.

Elicit''s free plan allows a limited number of document uploads and queries. The Plus plan at $12 per month provides higher limits and advanced extraction features. Elicit is best suited to researchers, systematic reviewers, and evidence analysts who need to process large volumes of academic literature efficiently.'
WHERE slug = 'elicit';

UPDATE tools SET description = 'Consensus is an AI-powered academic search engine that answers research questions using evidence drawn directly from peer-reviewed scientific literature. Unlike general-purpose AI assistants that generate answers from training data, Consensus retrieves and cites actual studies — making its outputs verifiable and grounded in published evidence.

The core product is a search interface where you enter a research question — "Does intermittent fasting improve metabolic health?", "What is the effect of sleep deprivation on cognitive performance?" — and Consensus returns a summary of what the scientific evidence shows, alongside the individual studies that support each claim. Every statement in the summary is linked to its source paper.

The Consensus Meter shows, at a glance, what proportion of the relevant studies support, oppose, or are neutral on a given claim. For questions where the evidence is contested or mixed, this gives a clearer picture of the state of the science than a single-source answer would.

Paper details include the study design, sample size, publication year, journal, and a plain-language abstract summary. Users can filter by study type — randomised controlled trials, systematic reviews, cohort studies — to focus on the highest-quality evidence for a given question.

The GPT-4 powered synthesise feature (on Pro) generates a structured summary across all retrieved studies, saving the time of reading each individually.

Consensus is free for up to 20 searches per day. The Premium plan at $8.99 per month (billed annually) offers unlimited searches, advanced filters, and GPT-4 synthesis. Consensus is best suited to healthcare professionals, students, researchers, and evidence-conscious professionals who need scientifically grounded answers to research questions.'
WHERE slug = 'consensus';

UPDATE tools SET description = 'Fireflies.ai is an AI meeting assistant that automatically records, transcribes, and analyses conversations across Zoom, Google Meet, Microsoft Teams, and Webex. It joins calls as a bot participant, captures the audio, and produces a searchable transcript with an AI summary, action items, and sentiment analysis delivered to your inbox after the meeting ends.

The search capability is Fireflies'' most distinctive feature. Every transcript is indexed and full-text searchable across your entire history of recorded meetings. You can search for any topic, name, or phrase across all your calls — making it possible to find a specific conversation from six months ago, retrieve a commitment made in a sales call, or track how many times a particular topic has come up across customer conversations.

The AskFred feature is an AI chatbot trained on your meeting transcripts. You can ask questions about past meetings — "What did we agree to do about the pricing issue?" or "When did the client mention their Q3 deadline?" — and Fred retrieves the relevant information from the appropriate transcripts.

Fireflies integrates with CRM systems including Salesforce and HubSpot, automatically logging call summaries and action items to the relevant contact or deal record. For sales teams, this eliminates manual CRM data entry after every customer call.

Topic tracking allows you to monitor specific keywords across calls — competitor mentions, pricing discussions, feature requests — and receive alerts when they appear.

The free plan records unlimited meetings but stores transcripts for 800 minutes. Pro at $18 per user per month provides unlimited storage and full AI features. Business at $29 per user per month adds CRM integrations and admin controls. Fireflies is best suited to sales, customer success, and distributed teams who want a searchable record of every conversation.'
WHERE slug = 'fireflies-ai';

UPDATE tools SET description = 'Railway is a cloud deployment platform designed to make hosting applications as simple as possible — for developers who want their code running in production without managing infrastructure, configuring servers, or learning a complex platform. It occupies the space between Heroku (which Railway is often compared to) and more complex platforms like AWS or Google Cloud.

The core experience is deployment by linking a GitHub repository. Railway detects the language and framework automatically, infers the build command, and deploys the application with a public URL within minutes. No Dockerfile required, no YAML configuration, no infrastructure provisioning. For developers who want to ship an API, web app, or background service quickly, this simplicity is Railway''s primary appeal.

Railway supports databases as first-class services. You can provision a PostgreSQL, MySQL, Redis, or MongoDB instance directly from the Railway dashboard, and the connection string is automatically injected into your application''s environment. No separate database provider, no manual connection configuration.

The platform handles environment variables, custom domains, private networking between services, and horizontal scaling. Cron jobs and background workers are supported alongside web services in the same project, making it practical for full-stack applications with multiple components.

Pricing is usage-based: you pay for the compute and memory your services consume, billed by the minute. The Trial plan provides $5 of free credits per month — enough to run a small application indefinitely. The Hobby plan at $5 per month adds more included usage. Teams plans are available for organisations needing access controls and larger compute budgets.

Railway is best suited to indie developers, startups, and small teams who prioritise development speed over fine-grained infrastructure control.'
WHERE slug = 'railway';

UPDATE tools SET description = 'v0 by Vercel is a generative UI tool that creates React and Tailwind CSS components from text prompts or design descriptions. Built by the team behind Next.js and Vercel''s deployment platform, v0 is designed specifically for frontend developers who want to generate production-quality UI code rather than static mockups.

The interaction is simple: you describe a component or interface in plain language — "a pricing table with three tiers, a monthly/annual toggle, and a highlighted recommended plan" — and v0 generates the full React component with Tailwind styling. The output is clean, readable code that follows modern React patterns, not a wall of generated markup that needs significant cleanup.

v0 generates multiple variations of each request, allowing you to pick the closest to your intent and iterate from there. You can refine the output by describing changes — "make the recommended badge more prominent", "add a hover state to the cards" — and v0 updates the component accordingly.

The generated code is immediately usable in a Next.js or React project, using shadcn/ui components and Tailwind utility classes by default. For teams already using this stack, v0 output can be dropped directly into a codebase with minimal adaptation.

v0 also accepts images as input — you can upload a screenshot or design file and ask v0 to generate a component that replicates the layout. This bridges the gap between design files and production code faster than manual implementation.

v0 is available at v0.dev with a free tier that includes a generous number of monthly generations. Pro access at $20 per month removes generation limits. It is best suited to frontend developers and full-stack teams building React applications who want to accelerate the UI implementation phase of development.'
WHERE slug = 'vercel-v0';

UPDATE tools SET description = 'Loom is a screen recording and async video communication tool used by remote teams to share information without scheduling a meeting. You record your screen, camera, or both, and Loom generates a shareable link instantly — no file uploading, no editing required. The recipient watches when it is convenient for them and can leave timestamped comments and reactions directly on the video.

The core use case is replacing meetings and long email chains. A product manager can record a five-minute walkthrough of a new feature rather than scheduling a demo call. An engineer can record a bug explanation with a screen recording rather than writing a detailed ticket. A manager can give feedback on a design with voice and screen rather than a lengthy written comment. In each case, the asynchronous video is faster to produce than a written explanation and more clear than text alone.

Loom AI, introduced in 2023, automatically generates a title and summary for every recording — so recipients can decide whether to watch the full video or read the summary. It also produces timestamped chapters, making it easy to jump to the relevant section of a longer recording.

Transcript and closed captions make recordings searchable and accessible. Comments can be left at specific timestamps, creating a thread of feedback tied to exact moments in the video. Reactions — emojis left at specific timestamps — provide a lightweight acknowledgement mechanism that does not require a reply.

Loom integrates with Slack, Notion, Jira, GitHub, Linear, and most common team communication tools — so shared Looms appear as rich previews in the tools teams already use.

The free Starter plan supports 25 videos of up to 5 minutes each. Business at $15 per creator per month removes limits, adds AI features, and enables custom branding. Loom is best suited to remote and distributed teams who want to reduce synchronous meeting overhead.'
WHERE slug = 'loom';
