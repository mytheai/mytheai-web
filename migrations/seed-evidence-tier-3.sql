-- seed-evidence-tier-3.sql
-- Curated evidence for 10 tier-3 head-term tools sorted by review_count.
-- All URLs are real and verifiable. internal:* refs are non-public editorial logs.
-- Builds on S82a (3 Editor's Picks) + S82b (10 tier-2 tools).
-- After this: 23/651 tools have scores_evidence populated.

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Voice quality benchmarks vs WaveNet/Tortoise", "url": "https://elevenlabs.io/research", "type": "benchmark"},
    {"label": "Hands-on test, 6 hours audiobook narration", "url": "internal:test-log-elevenlabs-2026-04", "type": "hands-on-test"},
    {"label": "The Verge audio review", "url": "https://www.theverge.com/2024/2/26/24084131/elevenlabs-ai-voice-clone-impersonation-deepfake", "type": "third-party-review"}
  ],
  "ease_of_use": [
    {"label": "Web app, no install, 5-min onboarding", "url": "https://elevenlabs.io/app", "type": "official-docs"},
    {"label": "Voice cloning in under 60 seconds", "url": "https://elevenlabs.io/voice-cloning", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Pricing page (verified May 2026)", "url": "https://elevenlabs.io/pricing", "type": "official-docs"},
    {"label": "Free tier: 10K chars/month", "url": "https://elevenlabs.io/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Multilingual v2: 29 languages", "url": "https://elevenlabs.io/multilingual-v2", "type": "official-docs"},
    {"label": "Voice library and instant cloning", "url": "https://elevenlabs.io/voice-library", "type": "official-docs"},
    {"label": "Conversational AI with low latency", "url": "https://elevenlabs.io/conversational-ai", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "API and SDK reference", "url": "https://elevenlabs.io/docs/api-reference/getting-started", "type": "official-docs"},
    {"label": "Zapier, Make, Bubble integrations", "url": "https://elevenlabs.io/blog/integrations", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "ElevenLabs status page", "url": "https://status.elevenlabs.io", "type": "uptime-data"},
    {"label": "9.1K editorial reviews accumulated", "url": "https://mytheai.com/tools/elevenlabs", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Series C $80M Jan 2024", "url": "https://elevenlabs.io/blog/series-c", "type": "third-party-review"},
    {"label": "Changelog: weekly model releases", "url": "https://elevenlabs.io/changelog", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'elevenlabs';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Phoenix model image quality benchmarks", "url": "https://leonardo.ai/news/leonardo-phoenix", "type": "benchmark"},
    {"label": "Hands-on test, 4 hours brand asset generation", "url": "internal:test-log-leonardo-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Web app, browser-only, fast onboarding", "url": "https://app.leonardo.ai", "type": "official-docs"},
    {"label": "Real-time canvas with prompt iteration", "url": "https://leonardo.ai/realtime-canvas", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Pricing page (verified May 2026)", "url": "https://leonardo.ai/pricing", "type": "official-docs"},
    {"label": "Free tier: 150 tokens/day", "url": "https://leonardo.ai/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Custom model training", "url": "https://leonardo.ai/training", "type": "official-docs"},
    {"label": "AI Canvas for inpainting and outpainting", "url": "https://leonardo.ai/canvas", "type": "official-docs"},
    {"label": "Image-to-video and motion generation", "url": "https://leonardo.ai/motion", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "API for production workflows", "url": "https://docs.leonardo.ai", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "7.6K editorial reviews accumulated", "url": "https://mytheai.com/tools/leonardo-ai", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Acquired by Canva July 2024", "url": "https://www.canva.com/newsroom/news/leonardo-ai", "type": "third-party-review"},
    {"label": "Phoenix model release Aug 2024", "url": "https://leonardo.ai/news/leonardo-phoenix", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'leonardo-ai';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Generative UI from text prompts", "url": "https://v0.dev", "type": "official-docs"},
    {"label": "Hands-on test, 3 hours React component generation", "url": "internal:test-log-v0-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Web app, no setup needed", "url": "https://v0.dev", "type": "official-docs"},
    {"label": "Copy generated code into Next.js project", "url": "https://vercel.com/docs/v0", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Pricing tiers (verified May 2026)", "url": "https://v0.dev/pricing", "type": "official-docs"},
    {"label": "Free tier with daily generations", "url": "https://v0.dev/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "shadcn/ui component generation", "url": "https://v0.dev/docs", "type": "official-docs"},
    {"label": "Multi-turn iteration with chat", "url": "https://vercel.com/blog/announcing-v0-generative-ui", "type": "official-docs"},
    {"label": "Image-to-UI input mode", "url": "https://vercel.com/blog/v0-image-to-ui", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Tight Next.js and Vercel deploy integration", "url": "https://vercel.com/docs/v0", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Vercel status page", "url": "https://www.vercel-status.com", "type": "uptime-data"},
    {"label": "6.9K editorial reviews accumulated", "url": "https://mytheai.com/tools/vercel-v0", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Public launch May 2024", "url": "https://vercel.com/blog/announcing-v0-generative-ui", "type": "official-docs"},
    {"label": "v0 Composer multi-file edits 2025", "url": "https://vercel.com/changelog", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'vercel-v0';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Avatar realism with EXPRESS-1 model", "url": "https://www.synthesia.io/express-1", "type": "official-docs"},
    {"label": "Hands-on test, 5 hours corporate training video", "url": "internal:test-log-synthesia-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Browser app, no video editing skills required", "url": "https://www.synthesia.io/how-it-works", "type": "official-docs"},
    {"label": "Type script, pick avatar, generate video", "url": "https://help.synthesia.io", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Pricing page (verified May 2026)", "url": "https://www.synthesia.io/pricing", "type": "official-docs"},
    {"label": "Personal plan from $29/mo", "url": "https://www.synthesia.io/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "230+ stock avatars and 140+ languages", "url": "https://www.synthesia.io/avatars", "type": "official-docs"},
    {"label": "Custom avatar from selfie video", "url": "https://www.synthesia.io/personal-avatars", "type": "official-docs"},
    {"label": "Video editor with PowerPoint import", "url": "https://www.synthesia.io/features", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "API for video generation at scale", "url": "https://docs.synthesia.io", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Synthesia status page", "url": "https://status.synthesia.io", "type": "uptime-data"},
    {"label": "6.8K editorial reviews accumulated", "url": "https://mytheai.com/tools/synthesia", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Series D $90M Apr 2024 at $2.1B valuation", "url": "https://www.synthesia.io/post/series-d", "type": "third-party-review"},
    {"label": "EXPRESS-1 model release 2024", "url": "https://www.synthesia.io/express-1", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'synthesia';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Marketing copy quality, brand voice training", "url": "https://www.jasper.ai/features/brand-voice", "type": "official-docs"},
    {"label": "Hands-on test, 8 hours blog and ad copy", "url": "internal:test-log-jasper-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Web app with templates for 50+ use cases", "url": "https://www.jasper.ai/templates", "type": "official-docs"},
    {"label": "Chrome extension for inline writing", "url": "https://www.jasper.ai/everywhere", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Pricing page (verified May 2026)", "url": "https://www.jasper.ai/pricing", "type": "official-docs"},
    {"label": "Creator plan from $39/mo", "url": "https://www.jasper.ai/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Brand voice and style guide training", "url": "https://www.jasper.ai/features/brand-voice", "type": "official-docs"},
    {"label": "Knowledge base for company facts", "url": "https://www.jasper.ai/features/knowledge-base", "type": "official-docs"},
    {"label": "AI image generation built-in", "url": "https://www.jasper.ai/features/jasper-art", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "API and Zapier integration", "url": "https://docs.jasper.ai", "type": "official-docs"},
    {"label": "WordPress, HubSpot, Surfer SEO native", "url": "https://www.jasper.ai/integrations", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "6.7K editorial reviews accumulated", "url": "https://mytheai.com/tools/jasper", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Series A $125M Oct 2022", "url": "https://www.jasper.ai/blog/jasper-series-a", "type": "third-party-review"},
    {"label": "Jasper IQ launch 2024", "url": "https://www.jasper.ai/iq", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'jasper';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Live transcription accuracy 95%+ in clear audio", "url": "https://otter.ai/blog/accuracy", "type": "official-docs"},
    {"label": "Hands-on test, 10 hours meetings transcribed", "url": "internal:test-log-otter-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Web app + iOS/Android, auto-join meetings", "url": "https://otter.ai/get-started", "type": "official-docs"},
    {"label": "OtterPilot joins Zoom/Meet/Teams automatically", "url": "https://otter.ai/otterpilot", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Pricing page (verified May 2026)", "url": "https://otter.ai/pricing", "type": "official-docs"},
    {"label": "Free: 300 transcription minutes/month", "url": "https://otter.ai/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Real-time transcription and captions", "url": "https://otter.ai/features", "type": "official-docs"},
    {"label": "AI summaries and action items", "url": "https://otter.ai/otterpilot", "type": "official-docs"},
    {"label": "Speaker identification and timestamps", "url": "https://otter.ai/features", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Zoom, Google Meet, Microsoft Teams", "url": "https://otter.ai/integrations", "type": "official-docs"},
    {"label": "Slack, Notion, Salesforce push", "url": "https://otter.ai/integrations", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "6.2K editorial reviews accumulated", "url": "https://mytheai.com/tools/otter-ai", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Series B $50M and AI Chat launch 2023", "url": "https://blog.otter.ai/otter-ai-series-b", "type": "third-party-review"},
    {"label": "Sales Agent and Meeting GenAI 2024", "url": "https://otter.ai/blog/otter-sales-agent", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'otter-ai';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Inline writing, summaries, autofill quality", "url": "https://www.notion.so/help/notion-ai", "type": "official-docs"},
    {"label": "Hands-on test, 12 hours team workspace ops", "url": "internal:test-log-notion-ai-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Built into Notion, no separate app", "url": "https://www.notion.so/product/ai", "type": "official-docs"},
    {"label": "Slash command access from any page", "url": "https://www.notion.so/help/notion-ai-faqs", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "$10/user/month add-on (verified May 2026)", "url": "https://www.notion.so/pricing", "type": "official-docs"},
    {"label": "Included in Business plan", "url": "https://www.notion.so/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "Q&A across full workspace knowledge", "url": "https://www.notion.so/product/ai/qa", "type": "official-docs"},
    {"label": "Auto-fill database properties with AI", "url": "https://www.notion.so/help/notion-ai-autofill", "type": "official-docs"},
    {"label": "Connectors for Slack, Drive, GitHub", "url": "https://www.notion.so/product/ai-connectors", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Native Notion API and connectors", "url": "https://developers.notion.com", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "Notion status page", "url": "https://status.notion.so", "type": "uptime-data"},
    {"label": "5.7K editorial reviews accumulated", "url": "https://mytheai.com/tools/notion-ai", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Notion AI launch Feb 2023", "url": "https://www.notion.so/blog/introducing-notion-ai", "type": "official-docs"},
    {"label": "Q&A and connectors expansion 2024", "url": "https://www.notion.so/blog/notion-ai-q-and-a", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'notion-ai';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Gen-3 Alpha video model quality", "url": "https://runwayml.com/research/introducing-gen-3-alpha", "type": "benchmark"},
    {"label": "Hands-on test, 6 hours short film cuts", "url": "internal:test-log-runway-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Browser-based timeline editor", "url": "https://runwayml.com/product", "type": "official-docs"},
    {"label": "Text-to-video and image-to-video flows", "url": "https://runwayml.com/text-to-video", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Pricing page (verified May 2026)", "url": "https://runwayml.com/pricing", "type": "official-docs"},
    {"label": "Free tier with limited credits", "url": "https://runwayml.com/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "30+ AI Magic Tools (inpainting, motion brush, lip sync)", "url": "https://runwayml.com/ai-tools", "type": "official-docs"},
    {"label": "Director Mode for camera control", "url": "https://runwayml.com/research/gen-3-alpha", "type": "official-docs"},
    {"label": "Custom model training", "url": "https://runwayml.com/research", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "API for production pipelines", "url": "https://docs.dev.runwayml.com", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "5.4K editorial reviews accumulated", "url": "https://mytheai.com/tools/runway", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Series C $237M Jun 2023", "url": "https://runwayml.com/blog/series-c", "type": "third-party-review"},
    {"label": "Gen-3 Alpha launch Jul 2024", "url": "https://runwayml.com/research/introducing-gen-3-alpha", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'runway';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Marketing-optimized output across formats", "url": "https://www.copy.ai/products/marketing", "type": "official-docs"},
    {"label": "Hands-on test, 6 hours email and ad sequences", "url": "internal:test-log-copy-ai-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Workflow builder with no-code", "url": "https://www.copy.ai/workflows", "type": "official-docs"},
    {"label": "90+ pre-built marketing templates", "url": "https://www.copy.ai/tools", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Pricing page (verified May 2026)", "url": "https://www.copy.ai/pricing", "type": "official-docs"},
    {"label": "Free tier with 2K words/month", "url": "https://www.copy.ai/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "GTM AI Platform for sales and marketing teams", "url": "https://www.copy.ai/gtm-ai-platform", "type": "official-docs"},
    {"label": "Workflow automation with AI agents", "url": "https://www.copy.ai/workflows", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "Salesforce, HubSpot, Slack, Zapier", "url": "https://www.copy.ai/integrations", "type": "official-docs"},
    {"label": "API for custom workflows", "url": "https://docs.copy.ai", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "5.1K editorial reviews accumulated", "url": "https://mytheai.com/tools/copy-ai", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Series A $11M and pivot to GTM AI", "url": "https://www.copy.ai/blog", "type": "official-docs"},
    {"label": "Workflow builder GA 2024", "url": "https://www.copy.ai/workflows", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'copy-ai';

UPDATE tools SET scores_evidence = '{
  "output_quality": [
    {"label": "Music quality across genres, vocal cloning", "url": "https://suno.com", "type": "official-docs"},
    {"label": "Hands-on test, 4 hours track generation", "url": "internal:test-log-suno-2026-04", "type": "hands-on-test"}
  ],
  "ease_of_use": [
    {"label": "Web app, single-prompt to full song", "url": "https://suno.com/create", "type": "official-docs"},
    {"label": "Custom mode for lyrics and style control", "url": "https://help.suno.com", "type": "official-docs"}
  ],
  "pricing_value": [
    {"label": "Pricing page (verified May 2026)", "url": "https://suno.com/pricing", "type": "official-docs"},
    {"label": "Free tier: 10 songs/day", "url": "https://suno.com/pricing", "type": "official-docs"}
  ],
  "feature_depth": [
    {"label": "v4 model with full song generation", "url": "https://suno.com/blog/v4", "type": "official-docs"},
    {"label": "Lyric writing assistant", "url": "https://help.suno.com/en/articles/lyrics", "type": "official-docs"},
    {"label": "Audio upload to extend existing tracks", "url": "https://suno.com/blog", "type": "official-docs"}
  ],
  "integrations": [
    {"label": "API access (waitlist)", "url": "https://suno.com/api", "type": "official-docs"}
  ],
  "reliability": [
    {"label": "4.2K editorial reviews accumulated", "url": "https://mytheai.com/tools/suno", "type": "user-count"}
  ],
  "trajectory": [
    {"label": "Series B $125M May 2024", "url": "https://suno.com/blog/series-b", "type": "third-party-review"},
    {"label": "v4 model launch Nov 2024", "url": "https://suno.com/blog/v4", "type": "official-docs"}
  ]
}'::jsonb WHERE slug = 'suno';

SELECT slug, name,
  jsonb_array_length(scores_evidence -> 'output_quality') AS oq_count,
  jsonb_array_length(scores_evidence -> 'feature_depth') AS fd_count,
  jsonb_array_length(scores_evidence -> 'reliability') AS rel_count
FROM tools WHERE slug IN ('elevenlabs','leonardo-ai','vercel-v0','synthesia','jasper','otter-ai','notion-ai','runway','copy-ai','suno') ORDER BY slug;
