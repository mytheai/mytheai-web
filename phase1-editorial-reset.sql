-- Phase 1: Editorial Discipline Reset (S87a)
-- Restore signal meaning to editor_pick / featured / trending flags.
-- BEFORE: editor_pick=3 (0.4%), featured=234 (35%), trending=397 (59%) - signal noise
-- AFTER:  editor_pick=12 (1 per core category), featured=~55 (top 5 per cat), trending=30
--
-- User-confirmed Editor's Picks (Claude over ChatGPT, n8n over Zapier per category leadership signal).
-- ChatGPT + Zapier remain in featured (top 5) - just not THE editor pick.

BEGIN;

-- Step 1: Reset all flags
UPDATE tools SET editor_pick = false, featured = false, trending = false;

-- Step 2: Set 12 Editor's Picks (one per core category)
UPDATE tools SET editor_pick = true, featured = true, trending = true
WHERE slug IN (
  'claude',              -- ai-assistants (user-pref over chatgpt)
  'jasper',              -- writing-ai
  'midjourney',          -- image-ai
  'runway',              -- video-ai
  'cursor',              -- code-ai
  'surfer-seo',          -- seo-marketing
  'notion-ai',           -- productivity
  'julius-ai',           -- analytics
  'elevenlabs',          -- voice-audio
  'salesforce-einstein', -- crm-sales
  'beehiiv',             -- email-marketing
  'n8n'                  -- automation (user-pref over zapier)
);

-- Step 3: Set Featured (~55 - top 5 per category, including the 12 editor picks)
UPDATE tools SET featured = true WHERE slug IN (
  -- ai-assistants (5)
  'claude','chatgpt','gemini','perplexity','copilot-microsoft',
  -- writing-ai (5)
  'jasper','grammarly','copy-ai','anyword','writesonic',
  -- image-ai (5)
  'midjourney','adobe-firefly','leonardo-ai','ideogram','flux',
  -- video-ai (5)
  'runway','pika','descript','kling','synthesia',
  -- code-ai (4) - github-copilot not in DB
  'cursor','codeium','windsurf','replit',
  -- seo-marketing (5)
  'surfer-seo','semrush','ahrefs','clearscope','frase',
  -- productivity (4)
  'notion-ai','asana','linear','motion',
  -- analytics (4)
  'julius-ai','akkio','formula-bot','tableau',
  -- voice-audio (4)
  'elevenlabs','murf','suno','hailuo',
  -- crm-sales (5)
  'salesforce-einstein','hubspot','apollo','gong','clari',
  -- email-marketing (4)
  'beehiiv','mailchimp','klaviyo','lavender',
  -- automation (5)
  'n8n','zapier','make-com','bardeen','pipedream'
);

-- Step 4: Set Trending (30 - genuine momentum signals 2025-2026)
UPDATE tools SET trending = true WHERE slug IN (
  -- AI assistant momentum
  'claude','perplexity','gemini','copilot-microsoft',
  -- Code AI momentum (Cursor + Windsurf wave)
  'cursor','windsurf',
  -- Generative media wave
  'midjourney','flux','ideogram','leonardo-ai',
  'runway','pika','kling','hailuo','heygen',
  'suno','elevenlabs','descript',
  -- Productivity / writing momentum
  'notion-ai','jasper','copy-ai','anyword',
  -- Analytics / data momentum
  'julius-ai','akkio',
  -- SEO + automation
  'surfer-seo','n8n','bardeen',
  -- Email + sales momentum
  'beehiiv','lavender','gong'
);

COMMIT;

-- Verification queries (run after to confirm):
-- SELECT COUNT(*) FROM tools WHERE editor_pick = true;  -- expect 12
-- SELECT COUNT(*) FROM tools WHERE featured = true;     -- expect ~55
-- SELECT COUNT(*) FROM tools WHERE trending = true;     -- expect 30
