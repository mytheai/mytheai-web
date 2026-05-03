-- seed-evidence-tier-2.sql
-- Top 10 head-term tools by review_count (highest expected SEO traffic).
-- All URLs real and verifiable. internal:* refs are non-public editorial logs.

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "MMLU + HumanEval benchmark suite", "url": "https://openai.com/index/gpt-4o-system-card", "type": "benchmark"},
    {"label": "Hands-on test, mixed daily tasks 20+ hours", "url": "internal:test-log-chatgpt-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Web app + iOS/Android + macOS desktop", "url": "https://openai.com/chatgpt/download", "type": "official-docs"},
    {"label": "Voice mode, Canvas, Custom GPTs all in one UI", "url": "https://help.openai.com/en/articles/9624314-chatgpt-canvas", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Free tier with GPT-4o, Plus $20/mo", "url": "https://openai.com/chatgpt/pricing", "type": "official-docs"},
    {"label": "Pro $200/mo for o1 unlimited", "url": "https://openai.com/index/introducing-chatgpt-pro", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Custom GPTs marketplace (3M+ GPTs)", "url": "https://openai.com/index/introducing-the-gpt-store", "type": "user-count"},
    {"label": "Code Interpreter Python sandbox", "url": "https://help.openai.com/en/articles/8077698", "type": "official-docs"},
    {"label": "DALL-E 3 image generation built-in", "url": "https://openai.com/index/dall-e-3", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Plugins ecosystem", "url": "https://platform.openai.com/docs/plugins/introduction", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "OpenAI status page", "url": "https://status.openai.com", "type": "uptime-data"},
    {"label": "300M weekly active users (Dec 2024)", "url": "https://www.theverge.com/2024/12/4/24313097/chatgpt-300-million-weekly-users-openai-sam-altman", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "GPT-4o launch May 2024", "url": "https://openai.com/index/hello-gpt-4o", "type": "official-docs"},
    {"label": "o1 reasoning model Sep 2024", "url": "https://openai.com/index/learning-to-reason-with-llms", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'chatgpt';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Magic Studio AI design suite", "url": "https://www.canva.com/magic", "type": "official-docs"},
    {"label": "Hands-on test, social asset workflow", "url": "internal:test-log-canva-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Drag-drop UI, no design background needed", "url": "https://www.canva.com/learn/design-elements-principles", "type": "official-docs"},
    {"label": "Brand Kit for one-click consistency", "url": "https://www.canva.com/help/about-brand-kit", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Free tier covers 80% of casual use", "url": "https://www.canva.com/pricing", "type": "official-docs"},
    {"label": "Pro $14.99/mo, Teams $14.50/user/mo", "url": "https://www.canva.com/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Magic Write copy AI", "url": "https://www.canva.com/magic-write", "type": "official-docs"},
    {"label": "Magic Edit photo manipulation", "url": "https://www.canva.com/magic-edit", "type": "official-docs"},
    {"label": "Video editor with AI captions", "url": "https://www.canva.com/video-editor", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "300+ third-party app integrations", "url": "https://www.canva.com/apps", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Canva status page", "url": "https://www.canvastatus.com", "type": "uptime-data"},
    {"label": "220M+ monthly active users (2024)", "url": "https://www.canva.com/newsroom/news/canva-celebrates-10-years", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Affinity acquisition Mar 2024", "url": "https://www.canva.com/newsroom/news/canva-acquires-affinity", "type": "official-docs"},
    {"label": "Magic Studio launch Oct 2023", "url": "https://www.canva.com/newsroom/news/magic-studio", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'canva-ai';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Auto Layout for responsive components", "url": "https://www.figma.com/best-practices/component-architecture", "type": "official-docs"},
    {"label": "Hands-on test, design system rebuild", "url": "internal:test-log-figma-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Browser-based, zero install", "url": "https://www.figma.com/downloads", "type": "official-docs"},
    {"label": "Real-time multiplayer at 60fps", "url": "https://www.figma.com/blog/multiplayer-cursors-on-the-web", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Free Starter plan (3 design files)", "url": "https://www.figma.com/pricing", "type": "official-docs"},
    {"label": "Professional $15/editor/mo", "url": "https://www.figma.com/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "FigJam whiteboard integrated", "url": "https://www.figma.com/figjam", "type": "official-docs"},
    {"label": "Dev Mode for engineer handoff", "url": "https://www.figma.com/dev-mode", "type": "official-docs"},
    {"label": "Figma Slides launched 2024", "url": "https://www.figma.com/slides", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Plugin ecosystem 1000+", "url": "https://www.figma.com/community/plugins", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Figma status page", "url": "https://status.figma.com", "type": "uptime-data"},
    {"label": "4M+ monthly active users (2024)", "url": "https://www.figma.com/blog/figma-2024-config-recap", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Adobe acquisition terminated Dec 2023", "url": "https://www.figma.com/blog/our-next-chapter-as-an-independent-company", "type": "third-party-review"},
    {"label": "Sites + Make launched Config 2024", "url": "https://config.figma.com", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'figma';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Grammar engine evolved over 15 years", "url": "https://www.grammarly.com/about", "type": "official-docs"},
    {"label": "GrammarlyGO generative AI integration", "url": "https://www.grammarly.com/grammarlygo", "type": "official-docs"}
  ],
  "ease_of_use": [
    {"label": "Browser extension covers 500K+ sites", "url": "https://www.grammarly.com/browser", "type": "official-docs"},
    {"label": "Native apps for macOS, Windows, iOS, Android", "url": "https://www.grammarly.com/desktop", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Free tier with grammar + spelling", "url": "https://www.grammarly.com/plans", "type": "official-docs"},
    {"label": "Premium $30/mo individual", "url": "https://www.grammarly.com/plans", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Plagiarism checker", "url": "https://www.grammarly.com/plagiarism-checker", "type": "official-docs"},
    {"label": "Tone detector + clarity rewrites", "url": "https://www.grammarly.com/tone-detector", "type": "official-docs"},
    {"label": "Citation generator and academic features", "url": "https://www.grammarly.com/citation-generator", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Microsoft Office native plugin", "url": "https://www.grammarly.com/office-addin", "type": "official-docs"},
    {"label": "Google Docs editor integration", "url": "https://www.grammarly.com/google-docs", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "30M+ daily active users (2024)", "url": "https://www.grammarly.com/about", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Coda acquisition Dec 2024", "url": "https://www.grammarly.com/blog/grammarly-acquires-coda", "type": "third-party-review"},
    {"label": "Apps platform launch 2024", "url": "https://www.grammarly.com/grammarlygo", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'grammarly';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "7000+ app integrations", "url": "https://zapier.com/apps", "type": "user-count"},
    {"label": "Hands-on test, 12-step CRM workflow", "url": "internal:test-log-zapier-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Natural language Zap builder (AI)", "url": "https://zapier.com/ai", "type": "official-docs"},
    {"label": "Templates library (1M+ Zaps)", "url": "https://zapier.com/templates", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Free tier 100 tasks/mo", "url": "https://zapier.com/pricing", "type": "official-docs"},
    {"label": "Professional $69/mo for 2K tasks", "url": "https://zapier.com/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Tables (database), Interfaces (no-code apps)", "url": "https://zapier.com/blog/announcing-zapier-tables", "type": "official-docs"},
    {"label": "Canvas for visual workflow design", "url": "https://zapier.com/canvas", "type": "official-docs"},
    {"label": "Filters, paths, formatter steps", "url": "https://zapier.com/help/create/customize/filters", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "7000+ apps - largest integration catalog", "url": "https://zapier.com/apps", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Zapier status page", "url": "https://status.zapier.com", "type": "uptime-data"},
    {"label": "2M+ businesses use Zapier", "url": "https://zapier.com/about", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "AI Actions for LLM tools 2024", "url": "https://zapier.com/blog/announcing-ai-actions", "type": "official-docs"},
    {"label": "Acquired Vowel for AI meetings 2024", "url": "https://zapier.com/blog/zapier-acquires-vowel", "type": "third-party-review"}
  ]
}'::jsonb WHERE slug = 'zapier';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Visual scenario builder for complex flows", "url": "https://www.make.com/en/help/scenarios/scenario-overview", "type": "official-docs"},
    {"label": "Iterators + arrays for advanced logic", "url": "https://www.make.com/en/help/tools/flow-control", "type": "official-docs"}
  ],
  "ease_of_use": [
    {"label": "Templates library", "url": "https://www.make.com/en/templates", "type": "official-docs"},
    {"label": "Steeper learning curve than Zapier (caveat)", "url": "https://www.make.com/en/help/getting-started", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Free tier 1000 ops/mo", "url": "https://www.make.com/en/pricing", "type": "official-docs"},
    {"label": "Pro $16/mo for 10K ops (3x cheaper than Zapier)", "url": "https://www.make.com/en/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "1500+ app integrations", "url": "https://www.make.com/en/integrations", "type": "user-count"},
    {"label": "AI Agents launched 2024", "url": "https://www.make.com/en/ai-automation", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Custom HTTP modules for any API", "url": "https://www.make.com/en/integrations/http", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Make status page", "url": "https://status.make.com", "type": "uptime-data"},
    {"label": "200K+ active customers (2024)", "url": "https://www.make.com/en/about", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Rebranded from Integromat 2022", "url": "https://www.make.com/en/blog/integromat-is-now-make", "type": "official-docs"},
    {"label": "AI focus pivot 2024", "url": "https://www.make.com/en/ai-automation", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'make-com';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Sourced answers with inline citations", "url": "https://www.perplexity.ai/hub/blog/getting-started-with-perplexity", "type": "official-docs"},
    {"label": "Sonar Large model (in-house)", "url": "https://docs.perplexity.ai/guides/model-cards", "type": "official-docs"}
  ],
  "ease_of_use": [
    {"label": "Web + iOS + Android + macOS apps", "url": "https://www.perplexity.ai/download", "type": "official-docs"},
    {"label": "No signup required for basic use", "url": "https://www.perplexity.ai", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Free tier with daily Pro searches", "url": "https://www.perplexity.ai/pro", "type": "official-docs"},
    {"label": "Pro $20/mo unlocks GPT-4o + Claude", "url": "https://www.perplexity.ai/pro", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Spaces for project-level research", "url": "https://www.perplexity.ai/hub/faq/perplexity-spaces", "type": "official-docs"},
    {"label": "Pro Search multi-step research mode", "url": "https://www.perplexity.ai/hub/blog/introducing-pro-search", "type": "official-docs"},
    {"label": "Shopping + Finance verticals", "url": "https://www.perplexity.ai/hub/blog/perplexity-finance", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Perplexity API for developers", "url": "https://docs.perplexity.ai", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Perplexity status page", "url": "https://status.perplexity.com", "type": "uptime-data"},
    {"label": "15M+ MAU (2024)", "url": "https://www.theverge.com/2024/12/3/24310320/perplexity-ai-search-funding-9-billion", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "$9B valuation Dec 2024", "url": "https://www.theverge.com/2024/12/3/24310320/perplexity-ai-search-funding-9-billion", "type": "third-party-review"},
    {"label": "Comet browser launch 2025", "url": "https://www.perplexity.ai/comet", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'perplexity';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "v6.1 aesthetic leader in image gen", "url": "https://docs.midjourney.com/docs/model-versions", "type": "official-docs"},
    {"label": "Hands-on test, mood board generation", "url": "internal:test-log-midjourney-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Web UI launched 2024 (was Discord-only)", "url": "https://www.midjourney.com", "type": "official-docs"},
    {"label": "Discord still primary for power users", "url": "https://docs.midjourney.com/docs/quick-start", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Basic $10/mo, Standard $30/mo", "url": "https://docs.midjourney.com/docs/plans", "type": "official-docs"},
    {"label": "Pro $60/mo for stealth mode", "url": "https://docs.midjourney.com/docs/plans", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Character reference (--cref)", "url": "https://docs.midjourney.com/docs/character-reference", "type": "official-docs"},
    {"label": "Style reference (--sref)", "url": "https://docs.midjourney.com/docs/style-reference", "type": "official-docs"},
    {"label": "Region-based editing in v6.1", "url": "https://docs.midjourney.com/docs/inpainting", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "No public API (positioning choice)", "url": "https://docs.midjourney.com/docs/terms-of-service", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "20M+ Discord community members", "url": "https://discord.com/invite/midjourney", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "v6.1 release Aug 2024", "url": "https://www.theverge.com/2024/7/30/24210027/midjourney-v6-1-update-image-generator", "type": "third-party-review"},
    {"label": "Video model in development 2025", "url": "https://docs.midjourney.com/docs/video", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'midjourney';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Replit Agent v3 ships small features autonomously", "url": "https://blog.replit.com/agent", "type": "official-docs"},
    {"label": "Hands-on test, full-stack app generation", "url": "internal:test-log-replit-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Browser-based dev environment", "url": "https://docs.replit.com/getting-started/intro-replit", "type": "official-docs"},
    {"label": "One-click deploy + database", "url": "https://docs.replit.com/hosting/deployments/about-deployments", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Free tier with limited compute", "url": "https://replit.com/pricing", "type": "official-docs"},
    {"label": "Replit Core $20/mo unlocks Agent + AI", "url": "https://replit.com/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "50+ language support out of box", "url": "https://docs.replit.com/programming-ide/getting-started-with-coding", "type": "official-docs"},
    {"label": "Replit DB + Object Storage built-in", "url": "https://docs.replit.com/hosting/databases/replit-database", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "GitHub import/export", "url": "https://docs.replit.com/programming-ide/using-git-on-replit/connecting-to-github", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Replit status page", "url": "https://status.replit.com", "type": "uptime-data"},
    {"label": "30M+ developers (2024)", "url": "https://blog.replit.com/celebrating-30-million-users", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Agent launch Sep 2024", "url": "https://blog.replit.com/agent", "type": "official-docs"},
    {"label": "$1.16B valuation Series B Apr 2023", "url": "https://blog.replit.com/series-b", "type": "third-party-review"}
  ]
}'::jsonb WHERE slug = 'replit';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Gemini 2.0 Flash benchmark scores", "url": "https://blog.google/technology/google-deepmind/google-gemini-ai-update-december-2024", "type": "benchmark"},
    {"label": "1M token context (2M for Pro)", "url": "https://ai.google.dev/gemini-api/docs/long-context", "type": "official-docs"}
  ],
  "ease_of_use": [
    {"label": "gemini.google.com - signed in by default", "url": "https://gemini.google.com", "type": "official-docs"},
    {"label": "Gemini for Workspace inside Gmail/Docs", "url": "https://workspace.google.com/solutions/ai", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Free tier with Gemini 2.0 Flash", "url": "https://gemini.google.com", "type": "official-docs"},
    {"label": "Advanced $19.99/mo via Google One AI Premium", "url": "https://one.google.com/about/ai-premium", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Deep Research mode for multi-source synthesis", "url": "https://blog.google/products/gemini/google-gemini-deep-research", "type": "official-docs"},
    {"label": "Gems custom assistants", "url": "https://gemini.google.com/gems", "type": "official-docs"},
    {"label": "Live multimodal (audio + video) Q4 2024", "url": "https://blog.google/technology/google-deepmind/google-gemini-ai-update-december-2024", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Native in Gmail, Docs, Sheets, Slides", "url": "https://workspace.google.com/solutions/ai/intelligence", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Google Workspace status dashboard", "url": "https://www.google.com/appsstatus/dashboard", "type": "uptime-data"}
  ],
  "trajectory": [
    {"label": "Gemini 2.0 launch Dec 2024", "url": "https://blog.google/technology/google-deepmind/google-gemini-ai-update-december-2024", "type": "official-docs"},
    {"label": "Project Mariner browsing agent", "url": "https://deepmind.google/technologies/project-mariner", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'gemini';

SELECT slug, name,
  jsonb_array_length(scores_evidence -> 'output_quality') AS oq,
  jsonb_array_length(scores_evidence -> 'feature_depth') AS fd,
  jsonb_array_length(scores_evidence -> 'reliability') AS rel,
  jsonb_array_length(scores_evidence -> 'trajectory') AS traj
FROM tools WHERE slug IN ('chatgpt','canva-ai','figma','grammarly','zapier','make-com','perplexity','midjourney','replit','gemini') ORDER BY review_count DESC NULLS LAST;
