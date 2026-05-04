-- Fix logo_url for tools where Google s2/favicons returns HTML (fails to render).
-- Probed each domain manually; setting direct favicon paths from each site's HTML.
-- Tools without resolvable favicons (qwen) keep NULL -> LogoImage falls back to letter avatar cleanly.

BEGIN;

-- Phase 5 tools (added S87e) + copilot-microsoft + aider (user-reported)
UPDATE tools SET logo_url = 'https://deepseek.com/favicon.ico' WHERE slug = 'deepseek';
UPDATE tools SET logo_url = 'https://v0.dev/assets/icon-light-32x32.png' WHERE slug = 'v0';
UPDATE tools SET logo_url = 'https://lumalabs.ai/favicons/favicon-black.ico' WHERE slug = 'luma-dream-machine';
UPDATE tools SET logo_url = 'https://manus.im/favicon.ico' WHERE slug = 'manus';
UPDATE tools SET logo_url = 'https://www.genspark.ai/favicon.ico' WHERE slug = 'genspark';
UPDATE tools SET logo_url = 'https://www.langflow.org/favicon.ico' WHERE slug = 'langflow';
UPDATE tools SET logo_url = 'https://cdn.prod.website-files.com/69a111972d2e0bbcc6adb934/69a111972d2e0bbcc6adbab3_66e1e4b0efcc40f3abe63988_32x32.png' WHERE slug = 'crewai';
UPDATE tools SET logo_url = 'https://glif.app/favicon.ico' WHERE slug = 'glif';
UPDATE tools SET logo_url = 'https://aider.chat/assets/icons/favicon.ico' WHERE slug = 'aider';

-- copilot.microsoft.com /favicon.ico returns 200 image directly; reset from broken Google s2/favicons URL
UPDATE tools SET logo_url = 'https://copilot.microsoft.com/favicon.ico' WHERE slug = 'copilot-microsoft';

-- qwen has no resolvable favicon (chat.qwen.ai is SPA, all paths return HTML 200)
UPDATE tools SET logo_url = NULL WHERE slug = 'qwen';

COMMIT;
