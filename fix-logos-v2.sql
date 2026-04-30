-- Fix broken logos v2: use Google faviconV2 directly for 16 tools.
-- t2.gstatic.com/faviconV2 is already in next.config.ts remotePatterns.
-- Returns the actual product favicon (128px) for any real website.
-- More reliable than Clearbit (which 404s for many AI tools) or favicon.ico
-- (which may be outside remotePatterns in some Next.js versions).

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://notebooklm.google.com&size=128'
  WHERE slug = 'notebooklm';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://ticktick.com&size=128'
  WHERE slug = 'ticktick';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://aider.chat&size=128'
  WHERE slug = 'aider';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://getclockwise.com&size=128'
  WHERE slug = 'clockwise';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://phind.com&size=128'
  WHERE slug = 'phind';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://podcast.adobe.com&size=128'
  WHERE slug = 'adobe-podcast';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://gitpod.io&size=128'
  WHERE slug = 'gitpod';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://firefly.adobe.com&size=128'
  WHERE slug = 'adobe-firefly';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://jamie.ai&size=128'
  WHERE slug = 'jamie';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://shortsai.app&size=128'
  WHERE slug = 'shorts-ai';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://airgram.io&size=128'
  WHERE slug = 'airgram';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://height.app&size=128'
  WHERE slug = 'height-app';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://detangle.ai&size=128'
  WHERE slug = 'detangle-ai';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://play.ht&size=128'
  WHERE slug = 'play-ht';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://lensa.ai&size=128'
  WHERE slug = 'lensa-ai';

UPDATE tools SET logo_url = 'https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=https://freshchat.com&size=128'
  WHERE slug = 'freshchat';
