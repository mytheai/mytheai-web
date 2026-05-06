-- S108 Mode D tier 17: honest minimal close for consumer-creative long tail.
-- 87 tools remained after S105 (84.2% coverage). This batch seeds ~55 with
-- 1-3 honest tags from the 21-tag controlled vocab where the integration
-- is widely-documented. ~32 tools intentionally skipped (truly standalone
-- consumer apps - mobile-only, single-vendor lock-in, no SaaS workflow).
-- Idempotent: re-run safely (UPDATE only).

BEGIN;

-- Adobe ecosystem (6) - all integrate with Adobe Cloud + Dropbox + Drive
UPDATE tools SET integrations = ARRAY['dropbox','google'] WHERE slug = 'adobe-express';
UPDATE tools SET integrations = ARRAY['dropbox','google'] WHERE slug = 'adobe-premiere-pro';
UPDATE tools SET integrations = ARRAY['dropbox','google'] WHERE slug = 'adobe-express-video';
UPDATE tools SET integrations = ARRAY['dropbox'] WHERE slug = 'adobe-photoshop';
UPDATE tools SET integrations = ARRAY['dropbox'] WHERE slug = 'adobe-lightroom-ai';
UPDATE tools SET integrations = ARRAY['dropbox'] WHERE slug = 'adobe-podcast';

-- Code/IDE tools (6) - GitHub-native integration
UPDATE tools SET integrations = ARRAY['github'] WHERE slug = 'blackbox-ai';
UPDATE tools SET integrations = ARRAY['github'] WHERE slug = 'codegpt';
UPDATE tools SET integrations = ARRAY['github'] WHERE slug = 'vercel-v0';
UPDATE tools SET integrations = ARRAY['github'] WHERE slug = 'warp';
UPDATE tools SET integrations = ARRAY['github','snowflake'] WHERE slug = 'streamlit';
UPDATE tools SET integrations = ARRAY['github'] WHERE slug = 'locofy';

-- Microsoft ecosystem (1)
UPDATE tools SET integrations = ARRAY['microsoft-365'] WHERE slug = 'microsoft-designer';

-- Google ecosystem (1) - Google's own video model
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'veo';

-- Video creators / repurposers (12) - YouTube + Drive export workflow
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'capcut';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'invideo-ai';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'pictory';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'captions-ai';
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'riverside';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'filmora';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'fliki';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'klap';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'munch';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'vizard';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'wisecut';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'vmaker';

-- Avatar/synthetic-presenter video tools (5) - well-documented Zapier integrations
UPDATE tools SET integrations = ARRAY['zapier','google'] WHERE slug = 'd-id';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'colossyan';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'steve-ai';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'elai-io';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'pipio';

-- Image gen / editing (10) - export to Drive/Dropbox standard
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'picsart';
UPDATE tools SET integrations = ARRAY['google','dropbox'] WHERE slug = 'photoroom';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'kittl';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'fotor';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'clipdrop';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'recraft-ai';
UPDATE tools SET integrations = ARRAY['zapier','google'] WHERE slug = 'remove-bg';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'krea-ai';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'pixelcut';
UPDATE tools SET integrations = ARRAY['zapier'] WHERE slug = 'getimg-ai';

-- Image gen API platforms (2) - Zapier-first
UPDATE tools SET integrations = ARRAY['zapier'] WHERE slug = 'stability-ai';
UPDATE tools SET integrations = ARRAY['zapier'] WHERE slug = 'magnific';

-- Voice / audio API platforms (3) - Zapier ecosystem
UPDATE tools SET integrations = ARRAY['zapier'] WHERE slug = 'wellsaid';
UPDATE tools SET integrations = ARRAY['zapier'] WHERE slug = 'mubert';
UPDATE tools SET integrations = ARRAY['zapier'] WHERE slug = 'stable-audio';

-- Voice notes / cleanup (2) - export workflow
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'voicenotes';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'cleanvoice-ai';

-- Presentation tools (3) - Google Slides ecosystem
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'gamma';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'prezi';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'slides-ai';

-- Multi-tool / all-in-one (1)
UPDATE tools SET integrations = ARRAY['zapier','google'] WHERE slug = 'simplified';

-- LinkedIn-focused social writing (5) - LinkedIn API-native
UPDATE tools SET integrations = ARRAY['linkedin'] WHERE slug = 'postwise';
UPDATE tools SET integrations = ARRAY['linkedin'] WHERE slug = 'taplio';
UPDATE tools SET integrations = ARRAY['linkedin'] WHERE slug = 'supergrow';
UPDATE tools SET integrations = ARRAY['linkedin'] WHERE slug = 'predis-ai';
UPDATE tools SET integrations = ARRAY['linkedin'] WHERE slug = 'rapidely';

-- Open-source design + video (2)
UPDATE tools SET integrations = ARRAY['github'] WHERE slug = 'penpot';
UPDATE tools SET integrations = ARRAY['notion'] WHERE slug = 'diagram';

-- Pro video upscale / model (2)
UPDATE tools SET integrations = ARRAY['dropbox'] WHERE slug = 'topaz-video-ai';
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'luma-ai';

-- AI avatar / video API (1)
UPDATE tools SET integrations = ARRAY['google'] WHERE slug = 'hedra';

COMMIT;
