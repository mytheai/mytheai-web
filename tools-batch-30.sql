-- tools-batch-30.sql
-- 10 new tools: clipdrop, getimg-ai, nightcafe, pixelcut, lensa-ai, playground-ai, artbreeder, fotor, civitai, tensor-art
-- Theme: AI image generation, creative tools, and photo editing
-- krea-ai excluded (already in batch-9), adobe-express excluded (already in batch-3)
-- Safe to re-run: ON CONFLICT (slug) DO NOTHING

-- 1. Clipdrop
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'clipdrop', 'Clipdrop', 'AI image editing tools for removing backgrounds, upscaling, and reimagining photos',
  'Clipdrop is a suite of AI image editing tools built by Stability AI. It bundles a set of single-purpose image tools - background removal, image upscaling, background replacement, uncropping, and sketch-to-image - into one clean web interface. Each tool is designed to do one thing extremely well rather than trying to be a full-featured design platform. Remove background works on complex subjects including hair and transparent materials. Upscaling uses AI to increase resolution without the blurriness of traditional upsampling. The Stable Diffusion image generation tool is integrated directly, so you can generate and edit in the same workflow. Clipdrop integrates with Figma, letting designers remove backgrounds without leaving their design environment. The API makes it practical to embed Clipdrop tools in product workflows. For e-commerce sellers, photographers, and designers who need fast, accurate single-task AI image editing, Clipdrop delivers quality that matches dedicated tools at a fraction of the complexity.',
  'https://www.google.com/s2/favicons?domain=clipdrop.co&sz=64',
  'https://clipdrop.co', 'https://clipdrop.co',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.4, 890, true, true, false,
  ARRAY['Background removal works on complex subjects including hair and translucent materials', 'AI upscaling preserves sharpness better than traditional interpolation', 'Figma plugin integrates removal tools directly into the design workflow', 'API access makes it embeddable in custom product and e-commerce pipelines'],
  ARRAY['Individual tools are excellent but the combined suite lacks a unified editing workflow', 'Free tier limits daily usage on most tools', 'Less powerful than dedicated generation platforms like Midjourney for creative image creation'],
  ARRAY['Removing backgrounds from product photos for e-commerce listings', 'Upscaling low-resolution images for print or large-format display', 'Replacing backgrounds in portrait photography without Photoshop']
) ON CONFLICT (slug) DO NOTHING;

-- 2. GetImg.ai
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'getimg-ai', 'GetImg.ai', 'Full-suite AI image generation platform with 60+ models and video support',
  'GetImg.ai is a comprehensive AI creative platform that aggregates over 60 image generation models in one place - including Stable Diffusion variants, FLUX models, and specialised fine-tunes for different styles. The platform covers text-to-image, image-to-image, inpainting, outpainting, and AI video generation from a single interface. DreamBooth training lets you create a custom model fine-tuned on your own images without machine learning expertise. The ControlNet integration gives precise control over image composition using reference images or depth maps. For teams that work across different generation models, GetImg.ai removes the friction of managing separate tools and accounts for each model. The API supports production workflows where AI image generation is embedded into platforms or content pipelines. At 100 free images per month, the free tier is genuinely useful for evaluation. Best for teams that want model variety and advanced controls without running local infrastructure.',
  'https://www.google.com/s2/favicons?domain=getimg.ai&sz=64',
  'https://getimg.ai', 'https://getimg.ai',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.3, 420, true, true, false,
  ARRAY['60+ models including FLUX, SDXL, and community fine-tunes in one interface', 'DreamBooth training creates custom models without ML expertise', 'ControlNet support for precise composition control with reference images', 'Generous free tier at 100 images/month for evaluation'],
  ARRAY['Quality varies significantly between models - choosing the right model requires experience', 'Less polished UI than consumer-focused tools like Midjourney', 'Video generation is still early compared to dedicated platforms like Runway'],
  ARRAY['Generating product visuals using brand-consistent custom models', 'Iterating on image concepts across different style models in one session', 'Embedding AI image generation into content production pipelines via API']
) ON CONFLICT (slug) DO NOTHING;

-- 3. NightCafe
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'nightcafe', 'NightCafe Studio', 'AI art generator with community features and multiple style algorithms',
  'NightCafe Studio is one of the earliest AI art generation platforms and has built a substantial community around collaborative creation and sharing. It supports multiple generation algorithms including Stable Diffusion, DALL-E, and its own proprietary CLIP-guided diffusion models. The credit-based system gives casual users access without a subscription, and you earn free credits daily just by participating in the community. The bulk creation tool lets you generate multiple variations quickly. The community gallery is one of the most active in AI art, making it a good place to discover what prompts and styles produce strong results. NightCafe is particularly strong for artists exploring AI as a creative medium rather than commercial teams looking for production-ready image generation. The social and community dimension sets it apart from purely professional tools.',
  'https://www.google.com/s2/favicons?domain=nightcafe.studio&sz=64',
  'https://nightcafe.studio', 'https://nightcafe.studio',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.2, 680, false, false, false,
  ARRAY['Active community for discovering prompts and sharing creations', 'Multiple generation algorithms in one platform including DALL-E and Stable Diffusion', 'Daily free credits mean casual users never hit a hard paywall', 'Bulk creation for generating multiple style variations quickly'],
  ARRAY['Credit system can feel limiting for heavy commercial use', 'Less focused on professional production workflows than dedicated tools', 'Quality ceiling is lower than Midjourney for photorealistic or highly detailed outputs'],
  ARRAY['Exploring AI art styles and discovering effective prompt techniques', 'Generating art prints, profile images, and personal creative projects', 'Participating in AI art challenges and competitions within the community']
) ON CONFLICT (slug) DO NOTHING;

-- 4. Pixelcut
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'pixelcut', 'Pixelcut', 'AI product photo editor for creating studio-quality images from phone shots',
  'Pixelcut is an AI photo editing app built specifically for product photography and e-commerce sellers. The central use case is taking a phone photo of a product and transforming it into a professional-quality listing image: remove the background, add a clean studio background, adjust lighting, and resize for different platform specs. The AI background removal works well on products with complex edges. Magic Eraser removes unwanted objects from the scene. The background generation feature replaces plain-coloured backgrounds with AI-generated lifestyle contexts or clean studio setups. Pixelcut is mobile-first, which makes it particularly accessible for small sellers who photograph products themselves rather than working with professional photographers. The template library covers the major e-commerce platforms with pre-sized formats. For sellers on Etsy, Shopify, and Amazon who want professional listing photos without a studio budget, Pixelcut delivers most of what they need from a phone.',
  'https://www.google.com/s2/favicons?domain=pixelcut.app&sz=64',
  'https://pixelcut.app', 'https://pixelcut.app',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.3, 520, false, true, false,
  ARRAY['Purpose-built for e-commerce product photography - not a general image editor', 'Mobile-first design makes it accessible for small sellers without studio equipment', 'AI background generation creates lifestyle contexts from plain product shots', 'Pre-sized templates for major e-commerce platforms reduce formatting friction'],
  ARRAY['Less powerful than desktop tools for complex editing tasks', 'Background generation occasionally produces inconsistent or unnatural results', 'Free tier watermarks images on export'],
  ARRAY['Creating professional product listing photos from phone shots for Etsy and Shopify', 'Batch editing product images with consistent background and lighting', 'Quickly removing backgrounds and adding branded backgrounds for social media content']
) ON CONFLICT (slug) DO NOTHING;

-- 5. Lensa AI
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'lensa-ai', 'Lensa AI', 'AI photo editing and avatar generation app for portraits and selfies',
  'Lensa AI is a mobile photo editing app by Prisma Labs that combines AI portrait enhancement with AI avatar generation. The core editing tools apply AI-powered retouching to faces: skin smoothing, feature adjustment, background blur, and colour grading designed specifically for portraits rather than general photography. The Magic Avatars feature - which went viral in 2022 - trains a personalised AI model on 10-20 selfies and generates a set of AI portraits in different artistic styles. The editing tools have become more sophisticated with each update, and Lensa remains one of the most downloaded AI photo apps in the consumer category. The app is primarily mobile and consumer-focused rather than a professional production tool. For creators who want high-quality avatar images and portrait editing on their phone without Lightroom or Photoshop, Lensa is the most recognised and trusted consumer option.',
  'https://www.google.com/s2/favicons?domain=lensa.ai&sz=64',
  'https://lensa.ai', 'https://lensa.ai',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.1, 2400, false, false, false,
  ARRAY['Magic Avatars generates personalised AI portraits in artistic styles from selfies', 'AI portrait retouching is among the best available in consumer apps', 'Simple mobile interface requires no technical skill or prompt engineering', 'Large user base and recognised brand for trust in portrait editing'],
  ARRAY['Primarily mobile and consumer-focused - not suitable for professional production workflows', 'Magic Avatars is a one-time experience that loses novelty after first use', 'Privacy concerns around uploading selfie data to train personalised models'],
  ARRAY['Creating AI avatar images for social media profiles and professional bios', 'Quick portrait enhancement for headshots without a photographer', 'Generating artistic portrait variations in different styles for personal use']
) ON CONFLICT (slug) DO NOTHING;

-- 6. Playground AI
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'playground-ai', 'Playground AI', 'AI image generation and editing platform with a canvas-based design interface',
  'Playground AI is a web-based AI image generation platform that combines Stable Diffusion-based generation with a canvas-based design interface. Unlike pure generation tools, Playground lets you generate images and then edit them within the same canvas - adding elements, expanding the image outpainting-style, or mixing generated and uploaded images. The mixed image editing mode allows you to combine your own photos with AI-generated elements for hybrid compositions. The real-time generation preview lets you see results update as you adjust the prompt. The free tier is generous at 500 images per day. Playground has cultivated a following among digital artists and designers who want AI generation integrated into a creative design workflow rather than as a standalone generation tool. The community gallery and prompt inspiration features help users develop prompting intuition over time.',
  'https://www.google.com/s2/favicons?domain=playground.com&sz=64',
  'https://playground.com', 'https://playground.com',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.3, 560, true, true, false,
  ARRAY['Canvas-based interface lets you generate and edit in the same workflow', 'Mixed image editing combines AI-generated and uploaded images on one canvas', '500 images/day on the free tier is among the most generous available', 'Real-time generation preview speeds up prompt iteration'],
  ARRAY['Canvas interface has a learning curve compared to simple prompt-and-generate tools', 'Generation quality does not consistently match Midjourney for highly detailed photorealistic images', 'Limited model variety compared to platforms like GetImg.ai'],
  ARRAY['Creating composite images that blend AI generation with photography', 'Expanding product photos with AI-generated contextual backgrounds', 'Iterating on design concepts using AI generation within a design canvas']
) ON CONFLICT (slug) DO NOTHING;

-- 7. Artbreeder
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'artbreeder', 'Artbreeder', 'AI collaborative art tool for blending images and creating character concepts',
  'Artbreeder is a collaborative AI art platform built around the concept of image breeding - combining and blending existing images to create new variations using genetic-algorithm-inspired controls. Instead of writing prompts, you adjust visual sliders (age, emotion, style, colour) and combine images to evolve new results. The character creation tools are particularly popular for generating consistent character concepts for games, books, and animation. The Composer tool lets you build scenes by placing and blending elements. Artbreeder has a large shared library of community-generated images that serve as starting points for exploration. The interaction model is fundamentally different from prompt-based generation: it is more iterative, more visual, and less dependent on prompt engineering skill. For worldbuilders, game designers, and creative writers who need character and scene inspiration rather than production-ready images, Artbreeder offers a unique creative model.',
  'https://www.google.com/s2/favicons?domain=artbreeder.com&sz=64',
  'https://artbreeder.com', 'https://artbreeder.com',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.1, 380, false, false, false,
  ARRAY['Unique slider-based blending model requires no prompt engineering skill', 'Character creation tools produce consistent visual styles across variations', 'Large community library provides strong starting points for creative exploration', 'Collaborative model allows building on and remixing other users'' creations'],
  ARRAY['Output style is distinctive and recognisable - not suitable for photorealistic production images', 'Less control over specific image details than prompt-based generation tools', 'Commercial licensing on community images requires careful review'],
  ARRAY['Creating character concept art for games, books, and animation projects', 'Exploring portrait and landscape styles through visual blending and iteration', 'Generating inspiration images for worldbuilding without precise prompt skill']
) ON CONFLICT (slug) DO NOTHING;

-- 8. Fotor
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'fotor', 'Fotor', 'AI-powered photo editor and design tool for creators and small businesses',
  'Fotor is a web-based photo editor and graphic design platform that combines traditional photo editing with AI enhancement tools. The AI suite includes background removal, face retouching, image upscaling, AI art generation, and smart cutout. The design module covers social media graphics, marketing materials, and presentations with a template library comparable to Canva at a lower price point. Fotor HDR photography tools and one-tap enhancement are popular with photography enthusiasts who want strong results without manual adjustment complexity. The AI art generator supports text-to-image generation in multiple styles. Fotor targets the overlap between photo editing and graphic design - users who need both capabilities without paying for Photoshop and Canva separately. The pro plan is substantially cheaper than Adobe Creative Cloud for teams that do not need professional-grade compositing.',
  'https://www.google.com/s2/favicons?domain=fotor.com&sz=64',
  'https://fotor.com', 'https://fotor.com',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.2, 1100, false, false, false,
  ARRAY['Covers photo editing and graphic design in one tool, reducing the need for multiple subscriptions', 'One-tap AI enhancement produces strong results quickly for non-technical users', 'AI background removal and upscaling quality competes with dedicated tools', 'Template library is extensive and organised for common use cases'],
  ARRAY['Advanced editing capabilities fall short of Photoshop or Lightroom for professional photographers', 'AI art generation quality is competitive but not at the frontier compared to Midjourney or FLUX', 'Free tier places watermarks and limits exports'],
  ARRAY['Creating social media graphics and marketing materials without a design team', 'Enhancing and retouching product photos for e-commerce listings', 'Building photo collages and presentations for small business marketing']
) ON CONFLICT (slug) DO NOTHING;

-- 9. Civitai
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'civitai', 'Civitai', 'Open-source AI model hub and image generation community for Stable Diffusion',
  'Civitai is the largest community hub for Stable Diffusion models, LoRAs, and textual inversions. It hosts thousands of community-contributed fine-tuned models covering specific art styles, characters, photographic techniques, and subject matter. The generation platform lets you run these models directly in the browser without downloading anything or running local infrastructure. The model library is unmatched - if a specific visual style exists as a Stable Diffusion fine-tune, it is almost certainly on Civitai. The community annotations, ratings, and sample images for each model help you choose the right model for your use case without extensive experimentation. Civitai is the right platform for users who have moved beyond general-purpose generation and need fine-grained control over model selection for consistent visual styles. The platform bridges the gap between the research community (which publishes models) and practitioners who want to use them without technical setup.',
  'https://www.google.com/s2/favicons?domain=civitai.com&sz=64',
  'https://civitai.com', 'https://civitai.com',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.4, 890, true, true, false,
  ARRAY['Largest library of Stable Diffusion fine-tunes and LoRAs available anywhere', 'In-browser generation means no local setup or GPU required to use community models', 'Community ratings and sample outputs help select models without trial and error', 'Covers highly specialised styles that general platforms cannot replicate'],
  ARRAY['Some community models are experimental and produce inconsistent results', 'Content moderation has been a persistent challenge on the platform', 'The depth of the model library can be overwhelming without prior experience with Stable Diffusion'],
  ARRAY['Finding and using fine-tuned models for specific art styles or character consistency', 'Running Stable Diffusion generation in the browser without local GPU setup', 'Discovering new model variants and LoRAs for specialised visual effects']
) ON CONFLICT (slug) DO NOTHING;

-- 10. Tensor.Art
INSERT INTO tools (
  slug, name, tagline, description,
  logo_url, website_url, affiliate_url,
  tags, pricing_type, pricing_free_tier, pricing_starting_price,
  rating, review_count, featured, trending, editor_pick,
  pros, cons, use_cases
) VALUES (
  'tensor-art', 'Tensor.Art', 'AI image generation platform with model hosting and community gallery',
  'Tensor.Art is an AI image generation platform and model hosting community that allows users to generate images using community-contributed models and share results in a social gallery. Like Civitai, it hosts a large library of Stable Diffusion models, LoRAs, and VAEs. Unlike Civitai, it is more focused on the generation experience itself - the interface is optimised for image creation rather than model discovery. The generation engine runs models in the cloud, eliminating the need for local GPU setup. The social gallery allows creators to share and sell their model assets. Tensor.Art attracts users who want the variety of community models without the technical overhead of running them locally. The free tier provides daily generation credits that reset each day, making it accessible for casual exploration. For artists who want to use specialised models for consistent character or style output without managing their own infrastructure, Tensor.Art offers a practical web-based workflow.',
  'https://www.google.com/s2/favicons?domain=tensor.art&sz=64',
  'https://tensor.art', 'https://tensor.art',
  ARRAY['design', 'image-generation'],
  'freemium', true, 0.00,
  4.1, 310, false, true, false,
  ARRAY['Large library of community models available for cloud generation without local GPU', 'Daily free credits make exploration accessible without a subscription commitment', 'Social gallery enables model creators to share and monetise their work', 'Generation interface is more user-friendly than running Stable Diffusion locally'],
  ARRAY['Less well-known than Civitai - smaller community and fewer model contributions', 'Generation speed varies depending on server load', 'Model quality consistency depends on community contributions which vary widely'],
  ARRAY['Generating images using specialised community style models without local infrastructure', 'Exploring creative AI art styles through community gallery inspiration', 'Testing different Stable Diffusion model variants for a creative project']
) ON CONFLICT (slug) DO NOTHING;
