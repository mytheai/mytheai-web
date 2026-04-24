-- Bulk insert 24 additional tools
-- Run in Supabase → SQL Editor after supabase-migrations.sql

insert into tools (slug, name, tagline, logo_url, website_url, affiliate_url, pricing_type, pricing_free_tier, pricing_starting_price, rating, review_count, featured, trending, editor_pick, tags) values

-- AI Assistants / Writing
('perplexity', 'Perplexity AI', 'The AI-powered answer engine with real-time web search and citations.',
 'https://www.google.com/s2/favicons?domain=perplexity.ai&sz=64', 'https://perplexity.ai', 'https://perplexity.ai',
 'freemium', true, 20, 4.6, 8900, false, true, false, ARRAY['ai-assistants']),

('mistral', 'Mistral AI', 'Fast, open-weight AI models with strong reasoning and European privacy standards.',
 'https://www.google.com/s2/favicons?domain=mistral.ai&sz=64', 'https://mistral.ai', 'https://mistral.ai',
 'freemium', true, 14, 4.4, 3200, false, false, false, ARRAY['ai-assistants','code-ai']),

('copilot-microsoft', 'Microsoft Copilot', 'AI assistant built into Windows, Edge, and Microsoft 365 with GPT-4 inside.',
 'https://www.google.com/s2/favicons?domain=copilot.microsoft.com&sz=64', 'https://copilot.microsoft.com', 'https://copilot.microsoft.com',
 'freemium', true, null, 4.3, 11200, false, false, false, ARRAY['ai-assistants','productivity']),

-- Writing AI
('jasper', 'Jasper AI', 'The leading AI writing platform for marketing teams — copy, blogs, and ads at scale.',
 'https://www.google.com/s2/favicons?domain=jasper.ai&sz=64', 'https://jasper.ai', 'https://jasper.ai',
 'paid', false, 49, 4.4, 6700, false, false, true, ARRAY['writing-ai','seo-marketing']),

('copy-ai', 'Copy.ai', 'AI-powered copywriting for blogs, emails, social media, and sales content.',
 'https://www.google.com/s2/favicons?domain=copy.ai&sz=64', 'https://copy.ai', 'https://copy.ai',
 'freemium', true, 49, 4.3, 5100, false, false, false, ARRAY['writing-ai']),

('writesonic', 'Writesonic', 'AI writer with SEO-optimized content, landing pages, and long-form articles.',
 'https://www.google.com/s2/favicons?domain=writesonic.com&sz=64', 'https://writesonic.com', 'https://writesonic.com',
 'freemium', true, 19, 4.2, 4300, false, false, false, ARRAY['writing-ai','seo-marketing']),

('grammarly', 'Grammarly', 'AI writing assistant for grammar, tone, clarity, and plagiarism detection.',
 'https://www.google.com/s2/favicons?domain=grammarly.com&sz=64', 'https://grammarly.com', 'https://grammarly.com',
 'freemium', true, 12, 4.6, 24500, true, false, false, ARRAY['writing-ai']),

-- Image AI
('leonardo-ai', 'Leonardo AI', 'AI image generation with fine-tuned models, inpainting, and real-time canvas.',
 'https://www.google.com/s2/favicons?domain=leonardo.ai&sz=64', 'https://leonardo.ai', 'https://leonardo.ai',
 'freemium', true, 12, 4.5, 7600, false, true, false, ARRAY['image-ai']),

('adobe-firefly', 'Adobe Firefly', 'Generative AI built into Creative Cloud — commercially safe image generation.',
 'https://www.google.com/s2/favicons?domain=firefly.adobe.com&sz=64', 'https://firefly.adobe.com', 'https://firefly.adobe.com',
 'freemium', true, 5, 4.4, 9800, false, false, true, ARRAY['image-ai']),

('canva-ai', 'Canva AI', 'Design platform with AI image generation, text-to-image, and Magic Studio tools.',
 'https://www.google.com/s2/favicons?domain=canva.com&sz=64', 'https://canva.com', 'https://canva.com',
 'freemium', true, 15, 4.7, 31000, true, false, false, ARRAY['image-ai','productivity']),

-- Video AI
('runway', 'Runway', 'Professional AI video generation and editing — Gen-2 model for text-to-video.',
 'https://www.google.com/s2/favicons?domain=runwayml.com&sz=64', 'https://runwayml.com', 'https://runwayml.com',
 'freemium', true, 15, 4.5, 5400, false, true, true, ARRAY['video-ai']),

('heygen', 'HeyGen', 'AI video creation with talking avatars, voice cloning, and video translation.',
 'https://www.google.com/s2/favicons?domain=heygen.com&sz=64', 'https://heygen.com', 'https://heygen.com',
 'freemium', true, 29, 4.6, 4100, false, true, false, ARRAY['video-ai']),

('descript', 'Descript', 'AI video and podcast editor — edit video by editing text transcript.',
 'https://www.google.com/s2/favicons?domain=descript.com&sz=64', 'https://descript.com', 'https://descript.com',
 'freemium', true, 24, 4.5, 3800, false, false, true, ARRAY['video-ai','voice-audio']),

-- Code AI
('cursor', 'Cursor', 'The AI-first code editor built on VS Code — full codebase context, Composer, and chat.',
 'https://www.google.com/s2/favicons?domain=cursor.com&sz=64', 'https://cursor.com', 'https://cursor.com',
 'freemium', true, 20, 4.8, 11300, true, true, true, ARRAY['code-ai']),

('replit', 'Replit', 'Online IDE with AI coding assistant, deployment, and collaborative coding in browser.',
 'https://www.google.com/s2/favicons?domain=replit.com&sz=64', 'https://replit.com', 'https://replit.com',
 'freemium', true, 25, 4.4, 7200, false, false, false, ARRAY['code-ai']),

('tabnine', 'Tabnine', 'AI code completion that runs privately on your infra — GDPR and compliance friendly.',
 'https://www.google.com/s2/favicons?domain=tabnine.com&sz=64', 'https://tabnine.com', 'https://tabnine.com',
 'freemium', true, 12, 4.3, 4900, false, false, false, ARRAY['code-ai']),

-- SEO & Marketing
('semrush', 'SEMrush', 'The all-in-one SEO and marketing platform for keywords, audits, and competitive research.',
 'https://www.google.com/s2/favicons?domain=semrush.com&sz=64', 'https://semrush.com', 'https://semrush.com',
 'freemium', true, 139, 4.6, 14200, false, false, true, ARRAY['seo-marketing']),

('surfer-seo', 'Surfer SEO', 'AI content optimization tool for writing SEO-targeted articles that rank.',
 'https://www.google.com/s2/favicons?domain=surferseo.com&sz=64', 'https://surferseo.com', 'https://surferseo.com',
 'paid', false, 89, 4.5, 5600, false, false, false, ARRAY['seo-marketing','writing-ai']),

-- Productivity
('zapier', 'Zapier', 'Automation platform connecting 6,000+ apps with AI-powered workflow builder.',
 'https://www.google.com/s2/favicons?domain=zapier.com&sz=64', 'https://zapier.com', 'https://zapier.com',
 'freemium', true, 20, 4.6, 18700, false, false, false, ARRAY['automation','productivity']),

('make', 'Make', 'Visual automation platform (formerly Integromat) with complex workflow logic.',
 'https://www.google.com/s2/favicons?domain=make.com&sz=64', 'https://make.com', 'https://make.com',
 'freemium', true, 9, 4.5, 7800, false, false, false, ARRAY['automation','productivity']),

('linear', 'Linear', 'The issue tracker built for high-performance product teams with AI automation.',
 'https://www.google.com/s2/favicons?domain=linear.app&sz=64', 'https://linear.app', 'https://linear.app',
 'freemium', true, 8, 4.8, 6400, false, false, true, ARRAY['productivity']),

-- Voice & Audio
('elevenlabs', 'ElevenLabs', 'AI voice cloning and text-to-speech with the most realistic voices available.',
 'https://www.google.com/s2/favicons?domain=elevenlabs.io&sz=64', 'https://elevenlabs.io', 'https://elevenlabs.io',
 'freemium', true, 11, 4.8, 9100, false, true, true, ARRAY['voice-audio']),

('otter-ai', 'Otter.ai', 'AI meeting transcription and notes with real-time captions and action items.',
 'https://www.google.com/s2/favicons?domain=otter.ai&sz=64', 'https://otter.ai', 'https://otter.ai',
 'freemium', true, 17, 4.4, 6200, false, false, false, ARRAY['voice-audio','productivity']),

-- CRM & Analytics
('hubspot', 'HubSpot AI', 'CRM and marketing platform with AI-powered sales, email, and content tools.',
 'https://www.google.com/s2/favicons?domain=hubspot.com&sz=64', 'https://hubspot.com', 'https://hubspot.com',
 'freemium', true, 45, 4.5, 21400, false, false, false, ARRAY['crm-sales','email-marketing']);
