export interface Top10List {
  slug: string
  title: string
  description: string
  category: string
  emoji: string
  slugs: string[]  // ordered by rank
}

export const TOP10_LISTS: Top10List[] = [
  {
    slug: 'best-code-ai-tools',
    title: 'Best AI Coding Tools',
    description: 'The top AI-powered coding assistants and editors ranked by developer adoption, code quality, and workflow integration.',
    category: 'Code AI',
    emoji: '💻',
    slugs: ['cursor', 'windsurf', 'github-copilot', 'bolt', 'replit'],
  },
  {
    slug: 'best-ai-writing-tools',
    title: 'Best AI Writing Tools',
    description: 'The top AI writing assistants for marketers, creators, and content teams — ranked by output quality, templates, and value.',
    category: 'Writing AI',
    emoji: '✍️',
    slugs: ['grammarly', 'jasper', 'copy-ai', 'writesonic', 'surfer-seo'],
  },
  {
    slug: 'best-free-ai-tools',
    title: 'Best Free AI Tools',
    description: 'The best AI tools available completely free or with generous free tiers — no credit card required to get started.',
    category: 'Free Tools',
    emoji: '🆓',
    slugs: ['claude', 'chatgpt', 'perplexity', 'grammarly', 'canva-ai'],
  },
  {
    slug: 'best-ai-image-generators',
    title: 'Best AI Image Generators',
    description: 'The top AI image generation tools ranked by image quality, style control, commercial licensing, and ease of use.',
    category: 'Image AI',
    emoji: '🎨',
    slugs: ['midjourney', 'canva-ai', 'leonardo-ai', 'adobe-firefly', 'chatgpt'],
  },
  {
    slug: 'best-ai-video-tools',
    title: 'Best AI Video Tools',
    description: 'The top AI video creation and editing tools for content creators, marketers, and video professionals.',
    category: 'Video AI',
    emoji: '🎬',
    slugs: ['runway', 'luma-ai', 'kling', 'heygen', 'descript'],
  },
  {
    slug: 'best-seo-ai-tools',
    title: 'Best AI SEO Tools',
    description: 'The top AI-powered SEO tools for growing organic traffic — keyword research, content optimization, and competitive analysis.',
    category: 'SEO & Marketing',
    emoji: '📈',
    slugs: ['semrush', 'ahrefs', 'surfer-seo', 'grammarly', 'jasper'],
  },
  {
    slug: 'best-ai-productivity-tools',
    title: 'Best AI Productivity Tools',
    description: 'The top AI tools for automating workflows, managing projects, and getting more done — for individuals and teams.',
    category: 'Productivity',
    emoji: '⚡',
    slugs: ['notion-ai', 'linear', 'zapier', 'make', 'airtable'],
  },
  {
    slug: 'best-ai-tools-for-marketers',
    title: 'Best AI Tools for Marketers',
    description: 'The top AI tools used by marketing teams to create content faster, optimize campaigns, and scale their output.',
    category: 'Marketing',
    emoji: '📣',
    slugs: ['jasper', 'canva-ai', 'surfer-seo', 'grammarly', 'hubspot'],
  },
  {
    slug: 'best-ai-voice-tools',
    title: 'Best AI Voice & Audio Tools',
    description: 'The top AI voice generation, transcription, and audio editing tools for creators, podcasters, and businesses.',
    category: 'Voice AI',
    emoji: '🎙️',
    slugs: ['elevenlabs', 'murf', 'otter-ai', 'fireflies-ai', 'riverside'],
  },
  {
    slug: 'best-ai-design-tools',
    title: 'Best AI Design Tools',
    description: 'The top AI-powered design tools for creating visuals, websites, and graphics — from professional UI designers to first-time creators.',
    category: 'Design AI',
    emoji: '🖌️',
    slugs: ['figma', 'canva-ai', 'adobe-firefly', 'framer', 'midjourney'],
  },
  {
    slug: 'best-ai-research-tools',
    title: 'Best AI Research Tools',
    description: 'The top AI tools for research, fact-finding, and knowledge synthesis — for academics, analysts, and curious professionals.',
    category: 'Research AI',
    emoji: '🔬',
    slugs: ['perplexity', 'notebooklm', 'elicit', 'consensus', 'julius-ai'],
  },
  {
    slug: 'best-ai-analytics-tools',
    title: 'Best AI Analytics & BI Tools',
    description: 'The top AI-powered analytics and business intelligence tools for turning data into insights without a data science degree.',
    category: 'Analytics',
    emoji: '📊',
    slugs: ['mixpanel', 'amplitude', 'julius-ai', 'tableau-ai', 'metabase'],
  },
  {
    slug: 'best-ai-meeting-tools',
    title: 'Best AI Meeting Tools',
    description: 'The top AI tools for recording, transcribing, and summarising meetings — so you can focus on the conversation, not the notes.',
    category: 'Productivity',
    emoji: '🎤',
    slugs: ['fathom', 'otter-ai', 'fireflies-ai', 'krisp', 'notebooklm'],
  },
  {
    slug: 'best-ai-app-builders',
    title: 'Best AI App Builders',
    description: 'The top AI-powered tools for building web applications and software without writing code — from idea to deployed product.',
    category: 'Code AI',
    emoji: '🏗️',
    slugs: ['lovable', 'bolt', 'cursor', 'windsurf', 'replit'],
  },
  {
    slug: 'best-email-marketing-tools',
    title: 'Best AI Email Marketing Tools',
    description: 'The top email marketing platforms with AI-powered content generation, send-time optimisation, and audience segmentation.',
    category: 'Marketing',
    emoji: '📧',
    slugs: ['mailchimp', 'beehiiv', 'klaviyo', 'activecampaign', 'hubspot'],
  },
  {
    slug: 'best-social-media-ai-tools',
    title: 'Best AI Social Media Tools',
    description: 'The top AI-powered social media management and content creation tools for scheduling, publishing, and growing an audience.',
    category: 'Marketing',
    emoji: '📱',
    slugs: ['hootsuite', 'buffer', 'typefully', 'canva-ai', 'jasper'],
  },
  {
    slug: 'best-ai-tools-for-students',
    title: 'Best AI Tools for Students',
    description: 'The top free and affordable AI tools that give students a genuine academic edge — from research and writing to coding and presentations.',
    category: 'Education',
    emoji: '🎓',
    slugs: ['perplexity', 'notebooklm', 'grammarly', 'claude', 'github-copilot'],
  },
  {
    slug: 'best-ai-sales-tools',
    title: 'Best AI Sales Tools',
    description: 'The top AI-powered tools for sales teams — from prospecting and enrichment to conversation intelligence and pipeline forecasting.',
    category: 'Sales',
    emoji: '💼',
    slugs: ['clay', 'gong', 'hubspot', 'pipedrive', 'intercom'],
  },
]

export function getList(slug: string): Top10List | undefined {
  return TOP10_LISTS.find(l => l.slug === slug)
}
