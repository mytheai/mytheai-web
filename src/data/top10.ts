export interface Top10List {
  slug: string
  title: string
  description: string
  category: string
  slugs: string[]  // ordered by rank
}

export const TOP10_LISTS: Top10List[] = [
  {
    slug: 'best-code-ai-tools',
    title: 'Best AI Coding Tools',
    description: 'The top AI-powered coding assistants and editors ranked by developer adoption, code quality, and workflow integration.',
    category: 'Code AI',
    slugs: ['cursor', 'github-copilot', 'tabnine', 'replit', 'mistral'],
  },
  {
    slug: 'best-ai-writing-tools',
    title: 'Best AI Writing Tools',
    description: 'The top AI writing assistants for marketers, creators, and content teams — ranked by output quality, templates, and value.',
    category: 'Writing AI',
    slugs: ['grammarly', 'jasper', 'copy-ai', 'writesonic', 'surfer-seo'],
  },
  {
    slug: 'best-free-ai-tools',
    title: 'Best Free AI Tools',
    description: 'The best AI tools available completely free or with generous free tiers — no credit card required to get started.',
    category: 'Free Tools',
    slugs: ['claude', 'chatgpt', 'perplexity', 'grammarly', 'canva-ai'],
  },
  {
    slug: 'best-ai-image-generators',
    title: 'Best AI Image Generators',
    description: 'The top AI image generation tools ranked by image quality, style control, commercial licensing, and ease of use.',
    category: 'Image AI',
    slugs: ['midjourney', 'canva-ai', 'leonardo-ai', 'adobe-firefly', 'chatgpt'],
  },
  {
    slug: 'best-ai-video-tools',
    title: 'Best AI Video Tools',
    description: 'The top AI video creation and editing tools for content creators, marketers, and video professionals.',
    category: 'Video AI',
    slugs: ['runway', 'heygen', 'descript'],
  },
]

export function getList(slug: string): Top10List | undefined {
  return TOP10_LISTS.find(l => l.slug === slug)
}
