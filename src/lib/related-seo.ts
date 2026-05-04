// Maps blog topics + tool tags to /free-ai-tools/[category] and /alternatives/[slug]
// targets so blog footers and tool sidebars can cross-link the 160+ orphaned
// programmatic SEO pages (S72-S73 scaffolds).

export interface RelatedSEOTarget {
  freeCategory: string
  topTool: string
  topToolLabel: string
}

// Keyword tokens scanned in blog slugs to pick the best target. Tested left-to-right
// so put the most-specific keyword first when ambiguity exists (e.g. "transcription"
// before "voice").
const SLUG_KEYWORD_MAP: Array<[string, RelatedSEOTarget]> = [
  ['transcription', { freeCategory: 'voice-audio', topTool: 'otter-ai', topToolLabel: 'Otter.ai' }],
  ['meeting', { freeCategory: 'productivity', topTool: 'notion-ai', topToolLabel: 'Notion AI' }],
  ['note', { freeCategory: 'productivity', topTool: 'notion-ai', topToolLabel: 'Notion AI' }],
  ['voice', { freeCategory: 'voice-audio', topTool: 'elevenlabs', topToolLabel: 'ElevenLabs' }],
  ['audio', { freeCategory: 'voice-audio', topTool: 'elevenlabs', topToolLabel: 'ElevenLabs' }],
  ['podcast', { freeCategory: 'voice-audio', topTool: 'elevenlabs', topToolLabel: 'ElevenLabs' }],
  ['coding', { freeCategory: 'code-ai', topTool: 'cursor', topToolLabel: 'Cursor' }],
  ['code', { freeCategory: 'code-ai', topTool: 'cursor', topToolLabel: 'Cursor' }],
  ['developer', { freeCategory: 'code-ai', topTool: 'cursor', topToolLabel: 'Cursor' }],
  ['no-code', { freeCategory: 'automation', topTool: 'n8n', topToolLabel: 'n8n' }],
  ['workflow', { freeCategory: 'automation', topTool: 'n8n', topToolLabel: 'n8n' }],
  ['automation', { freeCategory: 'automation', topTool: 'n8n', topToolLabel: 'n8n' }],
  ['writing', { freeCategory: 'writing-ai', topTool: 'jasper', topToolLabel: 'Jasper' }],
  ['email', { freeCategory: 'writing-ai', topTool: 'grammarly', topToolLabel: 'Grammarly' }],
  ['copywriting', { freeCategory: 'writing-ai', topTool: 'jasper', topToolLabel: 'Jasper' }],
  ['blog', { freeCategory: 'writing-ai', topTool: 'jasper', topToolLabel: 'Jasper' }],
  ['design', { freeCategory: 'image-ai', topTool: 'figma', topToolLabel: 'Figma AI' }],
  ['image', { freeCategory: 'image-ai', topTool: 'midjourney', topToolLabel: 'Midjourney' }],
  ['avatar', { freeCategory: 'video-ai', topTool: 'heygen', topToolLabel: 'HeyGen' }],
  ['video', { freeCategory: 'video-ai', topTool: 'runway', topToolLabel: 'Runway' }],
  ['seo', { freeCategory: 'seo-marketing', topTool: 'surfer-seo', topToolLabel: 'Surfer SEO' }],
  ['social-media', { freeCategory: 'seo-marketing', topTool: 'jasper', topToolLabel: 'Jasper' }],
  ['marketing', { freeCategory: 'seo-marketing', topTool: 'jasper', topToolLabel: 'Jasper' }],
  ['analytics', { freeCategory: 'analytics', topTool: 'julius-ai', topToolLabel: 'Julius AI' }],
  ['data', { freeCategory: 'analytics', topTool: 'julius-ai', topToolLabel: 'Julius AI' }],
  ['productivity', { freeCategory: 'productivity', topTool: 'notion-ai', topToolLabel: 'Notion AI' }],
  ['project-management', { freeCategory: 'productivity', topTool: 'notion-ai', topToolLabel: 'Notion AI' }],
  ['research', { freeCategory: 'ai-assistants', topTool: 'perplexity', topToolLabel: 'Perplexity' }],
  ['chatbot', { freeCategory: 'ai-assistants', topTool: 'claude', topToolLabel: 'Claude' }],
  ['assistant', { freeCategory: 'ai-assistants', topTool: 'claude', topToolLabel: 'Claude' }],
]

// Tool tags → free category slug (for tool detail sidebar)
const TAG_TO_FREE_CATEGORY: Record<string, string> = {
  'writing': 'writing-ai',
  'writing-ai': 'writing-ai',
  'copywriting': 'writing-ai',
  'image': 'image-ai',
  'image-ai': 'image-ai',
  'image-generation': 'image-ai',
  'design': 'image-ai',
  'video': 'video-ai',
  'video-ai': 'video-ai',
  'video-generation': 'video-ai',
  'avatar': 'video-ai',
  'code': 'code-ai',
  'code-ai': 'code-ai',
  'coding': 'code-ai',
  'developer-tools': 'code-ai',
  'seo': 'seo-marketing',
  'seo-marketing': 'seo-marketing',
  'marketing': 'seo-marketing',
  'social-media': 'seo-marketing',
  'productivity': 'productivity',
  'project-management': 'productivity',
  'note-taking': 'productivity',
  'meeting': 'productivity',
  'voice': 'voice-audio',
  'voice-ai': 'voice-audio',
  'audio': 'voice-audio',
  'transcription': 'voice-audio',
  'analytics': 'analytics',
  'data-analysis': 'analytics',
  'business-intelligence': 'analytics',
  'automation': 'automation',
  'workflow-automation': 'automation',
  'no-code': 'automation',
  'ai-assistant': 'ai-assistants',
  'ai-assistants': 'ai-assistants',
  'chatbot': 'ai-assistants',
}

export function getBlogRelatedSEO(slug: string): RelatedSEOTarget | null {
  const lower = slug.toLowerCase()
  for (const [keyword, target] of SLUG_KEYWORD_MAP) {
    if (lower.includes(keyword)) return target
  }
  return null
}

export function getToolFreeCategory(tags: string[] | null | undefined): string | null {
  if (!tags || tags.length === 0) return null
  for (const tag of tags) {
    const norm = tag.toLowerCase().trim()
    if (TAG_TO_FREE_CATEGORY[norm]) return TAG_TO_FREE_CATEGORY[norm]
  }
  return null
}

export const FREE_CATEGORY_LABELS: Record<string, string> = {
  'ai-assistants': 'AI assistants',
  'writing-ai': 'AI writing',
  'image-ai': 'AI image',
  'video-ai': 'AI video',
  'code-ai': 'AI coding',
  'seo-marketing': 'AI SEO & marketing',
  'productivity': 'AI productivity',
  'voice-audio': 'AI voice & audio',
  'analytics': 'AI analytics',
  'automation': 'AI automation',
}
