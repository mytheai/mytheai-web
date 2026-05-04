// Phase 3 - tag controlled vocabulary.
// Reduces 243 free-form tags -> 30 controlled-vocabulary tags.
// Outputs phase3-tag-update.sql with one UPDATE per tool.
//
// Usage: node scripts/phase3-tag-consolidation.mjs [--dry]

import { writeFileSync } from 'fs'
import { fileURLToPath } from 'url'
import { dirname, join } from 'path'

const __dirname = dirname(fileURLToPath(import.meta.url))
const SQL_OUT = join(__dirname, '..', 'phase3-tag-update.sql')

// ---- Controlled vocabulary (30 standard tags) ----
export const CONTROLLED = new Set([
  // 12 core categories
  'ai-assistants','writing-ai','image-ai','video-ai','code-ai',
  'seo-marketing','productivity','analytics','voice-audio',
  'crm-sales','email-marketing','automation',
  // 18 cross-cutting / sub-tags
  'customer-service','ecommerce','finance','hr','legal',
  'healthcare','education','design','research','translation',
  'cybersecurity','avatar-generation','presentation',
  'project-management','social-media','meeting-tools',
  'note-taking','chatbot',
])

// ---- Legacy tag -> standard tag mapping ----
const MAP = {
  // Top tier - direct mapping or merge typos
  'ai-assistants': 'ai-assistants',
  'ai-assistant': 'ai-assistants',
  'chatbot': 'chatbot',
  'chatbots': 'chatbot',
  'productivity': 'productivity',
  'team-productivity': 'productivity',
  'personal-productivity': 'productivity',
  'operations': 'productivity',
  'team-collaboration': 'productivity',
  'knowledge-management': 'productivity',
  'document-automation': 'productivity',
  'document': 'productivity',
  'e-signature': 'productivity',
  'esignature': 'productivity',
  'proposals': 'productivity',
  'business': 'productivity',
  'enterprise': 'productivity',
  'note-taking': 'note-taking',
  'notes': 'note-taking',

  'writing-ai': 'writing-ai',
  'writing': 'writing-ai',
  'copywriting': 'writing-ai',
  'content': 'writing-ai',
  'content-writing': 'writing-ai',
  'content-creation': 'writing-ai',
  'cms': 'writing-ai',
  'blogging': 'writing-ai',
  'long-form': 'writing-ai',

  'image-ai': 'image-ai',
  'image-generation': 'image-ai',
  'image-editing': 'image-ai',
  'photo': 'image-ai',
  'photo-editing': 'image-ai',
  'art-generation': 'image-ai',

  'video-ai': 'video-ai',
  'video-generation': 'video-ai',
  'video-editing': 'video-ai',
  'video': 'video-ai',
  'screen-recording': 'video-ai',

  'code-ai': 'code-ai',
  'developer-tools': 'code-ai',
  'devtools': 'code-ai',
  'coding': 'code-ai',
  'no-code': 'automation',
  'low-code': 'automation',
  'automation': 'automation',
  'workflow': 'automation',
  'workflow-automation': 'automation',
  'integration': 'automation',
  'integrations': 'automation',
  'rpa': 'automation',
  'agents': 'automation',
  'ai-agents': 'automation',

  'seo-marketing': 'seo-marketing',
  'seo': 'seo-marketing',
  'marketing': 'seo-marketing',
  'ad-tech': 'seo-marketing',
  'advertising': 'seo-marketing',
  'content-marketing': 'seo-marketing',
  'ppc': 'seo-marketing',

  'analytics': 'analytics',
  'data-analysis': 'analytics',
  'data-analytics': 'analytics',
  'business-intelligence': 'analytics',
  'bi': 'analytics',
  'dashboard': 'analytics',
  'product-analytics': 'analytics',

  'voice-audio': 'voice-audio',
  'voice': 'voice-audio',
  'audio': 'voice-audio',
  'transcription': 'voice-audio',
  'text-to-speech': 'voice-audio',
  'voice-cloning': 'voice-audio',
  'voice-generation': 'voice-audio',
  'podcast': 'voice-audio',
  'music': 'voice-audio',
  'music-generation': 'voice-audio',
  'speech-to-text': 'voice-audio',

  'crm-sales': 'crm-sales',
  'crm': 'crm-sales',
  'sales': 'crm-sales',
  'sales-enablement': 'crm-sales',
  'lead-generation': 'crm-sales',
  'outbound': 'crm-sales',

  'email-marketing': 'email-marketing',
  'email': 'email-marketing',
  'newsletter': 'email-marketing',

  'customer-service': 'customer-service',
  'customer-support': 'customer-service',
  'customer-success': 'customer-service',
  'helpdesk': 'customer-service',
  'support': 'customer-service',
  'churn-reduction': 'customer-service',
  'live-chat': 'customer-service',

  'ecommerce': 'ecommerce',
  'e-commerce': 'ecommerce',
  'shopify': 'ecommerce',
  'commerce': 'ecommerce',
  'product-recommendations': 'ecommerce',

  'finance': 'finance',
  'fintech': 'finance',
  'accounting': 'finance',
  'bookkeeping': 'finance',
  'payments': 'finance',

  'hr': 'hr',
  'hr-tech': 'hr',
  'human-resources': 'hr',
  'people-ops': 'hr',
  'recruiting': 'hr',
  'recruitment': 'hr',
  'talent': 'hr',
  'performance-management': 'hr',
  'onboarding': 'hr',

  'legal': 'legal',
  'legal-ai': 'legal',
  'legaltech': 'legal',
  'contract': 'legal',
  'contract-review': 'legal',
  'compliance': 'legal',

  'healthcare': 'healthcare',
  'medical': 'healthcare',
  'clinical': 'healthcare',
  'medtech': 'healthcare',

  'education': 'education',
  'edtech': 'education',
  'e-learning': 'education',
  'learning': 'education',
  'tutoring': 'education',
  'lms': 'education',
  'classroom': 'education',

  'design': 'design',
  'ui': 'design',
  'ux': 'design',
  'ui-ux': 'design',
  'design-tools': 'design',
  'graphic-design': 'design',

  'research': 'research',
  'research-tools': 'research',
  'ux-research': 'research',
  'user-research': 'research',
  'user-testing': 'research',
  'usability-testing': 'research',
  'qualitative-research': 'research',
  'survey': 'research',

  'translation': 'translation',
  'localization': 'translation',
  'i18n': 'translation',
  'language': 'translation',

  'cybersecurity': 'cybersecurity',
  'security': 'cybersecurity',
  'infosec': 'cybersecurity',
  'devsecops': 'cybersecurity',

  'avatar-generation': 'avatar-generation',
  'avatar': 'avatar-generation',
  'avatars': 'avatar-generation',
  'digital-humans': 'avatar-generation',
  'deepfake': 'avatar-generation',

  'presentation': 'presentation',
  'presentations': 'presentation',
  'slides': 'presentation',
  'pitch-deck': 'presentation',

  'project-management': 'project-management',
  'pm': 'project-management',
  'task-management': 'project-management',
  'roadmap': 'project-management',

  'social-media': 'social-media',
  'social': 'social-media',
  'social-media-management': 'social-media',
  'twitter': 'social-media',
  'linkedin': 'social-media',

  'meeting-tools': 'meeting-tools',
  'meeting-intelligence': 'meeting-tools',
  'meetings': 'meeting-tools',
  'meeting-notes': 'meeting-tools',
  'video-conferencing': 'meeting-tools',

  // Extra mappings from dry-run unmapped tags
  'wiki': 'productivity',
  'documentation': 'productivity',
  'app-builder': 'automation',
  'contracts': 'legal',
  'contract-management': 'legal',
  'figma': 'design',
  'design-software': 'design',
  'prototyping': 'design',
  'legal-tech': 'legal',
  'collaboration': 'productivity',
  'scheduling': 'productivity',
  'internal-tools': 'productivity',
  'ai-agent': 'automation',
  'audio-ai': 'voice-audio',
  'audio-generation': 'voice-audio',
  'audio-editing': 'voice-audio',
  'prototype-testing': 'research',
  'coding-tools': 'code-ai',
  'multilingual': 'translation',
  'teacher-tools': 'education',
  'employee-engagement': 'hr',
  'team-management': 'hr',
  'employee-experience': 'hr',
  'recruitment-software': 'hr',
  'data-engineering': 'analytics',
  'visualization': 'analytics',
  'data-viz': 'analytics',
  'reporting': 'analytics',
  'forecasting': 'analytics',
  'spreadsheets': 'productivity',
  'spreadsheet': 'productivity',
  'database': 'productivity',
  'crm-platform': 'crm-sales',
  'sales-automation': 'crm-sales',
  'sales-intelligence': 'crm-sales',
  'pipeline-management': 'crm-sales',
  'lead-scoring': 'crm-sales',
  'email-platform': 'email-marketing',
  'email-automation': 'email-marketing',
  'cold-email': 'email-marketing',
  'support-automation': 'customer-service',
  'ticketing': 'customer-service',
  'live-support': 'customer-service',
  'shopify-apps': 'ecommerce',
  'product-discovery': 'research',
  'concept-testing': 'research',
  'a/b-testing': 'research',
  'ab-testing': 'research',
  'website-builder': 'design',
  'landing-page': 'design',
  'whiteboard': 'productivity',
  'mind-mapping': 'productivity',
  'flowchart': 'productivity',
  'diagramming': 'productivity',
  'forms': 'productivity',
  'data-collection': 'productivity',
  'feedback': 'research',
  'video-marketing': 'video-ai',
  'video-platform': 'video-ai',
  'streaming': 'video-ai',
  'image-search': 'image-ai',
  'photo-stock': 'image-ai',
  'icons': 'design',
  'illustrations': 'image-ai',
  'logo': 'image-ai',
  'logo-design': 'image-ai',
  'brand': 'design',
  'branding': 'design',
  'typography': 'design',
  'color': 'design',
  'mockup': 'design',
  'mockups': 'design',
  'website-localization': 'translation',
  'subtitles': 'video-ai',
  'captions': 'video-ai',
  'lip-sync': 'avatar-generation',
  'face-swap': 'avatar-generation',
  'character-design': 'avatar-generation',
  'storytelling': 'writing-ai',
  'editing': 'writing-ai',
  'grammar': 'writing-ai',
  'proofreading': 'writing-ai',
  'plagiarism': 'writing-ai',
  'paraphrasing': 'writing-ai',
  'summarization': 'productivity',
  'summarizer': 'productivity',
}

// Tags to explicitly DROP (metadata, vague, removed verticals, or noise)
const DROP = new Set([
  'open-source', 'saas', 'self-hosted', 'free', 'freemium', 'paid',
  'beta', 'startup', 'launched-2024', 'launched-2025', 'launched-2026',
  'ai', 'machine-learning', 'ml', 'gpt', 'llm', 'foundation-model',
  'browser-extension', 'mobile', 'mobile-app', 'mobile-apps', 'web-app', 'desktop',
  'api', 'sdk', 'cli', 'plugin',
  'free-trial', 'trial',
  // Verticals removed in Phase 2
  'sustainability', 'esg', 'climate-tech', 'climate', 'carbon',
  'hospitality', 'travel', 'real-estate', 'proptech',
  'aerospace', 'defense', 'biotech', 'agritech', 'agtech',
  'manufacturing', 'industrial', 'industry-4.0', 'iiot', 'iot',
  'supply-chain', 'logistics', 'shipping',
  'construction', 'architecture', 'aec',
  'government', 'govtech', 'civic',
  'procurement', 'spend-management',
  'insurtech', 'insurance',
  'compliance-automation',
  // Generic noise
  'product', 'ai-generation', 'platform', 'tool', 'tools',
  'health-scoring', 'predictive', 'generative-ai',
])

// Slug-based fallback when a tool ends up with 0 controlled tags
function fallbackFromSlug(slug, name) {
  const s = (slug + ' ' + name).toLowerCase()
  if (/code|copilot|cursor|github|repo|programming|develop/.test(s)) return 'code-ai'
  if (/image|photo|art|paint|midjourney|dall-?e|leonardo|firefly|flux|ideogram/.test(s)) return 'image-ai'
  if (/video|runway|pika|kling|hailuo|sora|movie|film/.test(s)) return 'video-ai'
  if (/voice|audio|speech|tts|transcript|podcast|music|suno|elevenlabs/.test(s)) return 'voice-audio'
  if (/write|content|blog|copy|jasper|grammarly/.test(s)) return 'writing-ai'
  if (/seo|marketing|surfer|semrush|ahrefs/.test(s)) return 'seo-marketing'
  if (/email|newsletter|beehiiv|mailchimp|klaviyo/.test(s)) return 'email-marketing'
  if (/crm|sales|hubspot|salesforce|outreach/.test(s)) return 'crm-sales'
  if (/analyt|data|tableau|julius|akkio/.test(s)) return 'analytics'
  if (/legal|contract|harvey|paxton/.test(s)) return 'legal'
  if (/health|medical|clinical|scribe/.test(s)) return 'healthcare'
  if (/edu|teach|tutor|student|class/.test(s)) return 'education'
  if (/finance|account|payment|brex|ramp/.test(s)) return 'finance'
  if (/hr|recruit|people|culture|gusto/.test(s)) return 'hr'
  if (/customer|support|chat|intercom|zendesk/.test(s)) return 'customer-service'
  if (/automat|zapier|n8n|make|workflow/.test(s)) return 'automation'
  if (/design|figma|canva|sketch/.test(s)) return 'design'
  if (/meet|otter|fireflies|fathom/.test(s)) return 'meeting-tools'
  if (/social|buffer|hootsuite|planable/.test(s)) return 'social-media'
  if (/translat|localiz|deepl/.test(s)) return 'translation'
  return 'productivity' // default fallback
}

const isDry = process.argv.includes('--dry')

// ---- Fetch tools ----
const envText = await import('fs').then(m => m.readFileSync(join(__dirname, '..', '.env.local'), 'utf-8'))
const env = Object.fromEntries(envText.split('\n').filter(l => l.trim() && l.includes('=')).map(l => { const [k, ...rest] = l.split('='); return [k.trim(), rest.join('=').trim()] }))
const supabase = env.NEXT_PUBLIC_SUPABASE_URL
const key = env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY

const r = await fetch(supabase + '/rest/v1/tools?select=slug,name,tags&limit=2000', {
  headers: { apikey: key, Authorization: 'Bearer ' + key }
})
const tools = await r.json()
console.log('Tools fetched:', tools.length)

// ---- Transform per tool ----
const updates = []
const unmappedTags = new Map()
let tagsRemoved = 0
let tagsKept = 0

for (const t of tools) {
  const oldTags = t.tags || []
  const newTagsSet = new Set()
  for (const tag of oldTags) {
    const lower = tag.toLowerCase().trim()
    if (DROP.has(lower)) continue
    const mapped = MAP[lower]
    if (mapped && CONTROLLED.has(mapped)) {
      newTagsSet.add(mapped)
    } else if (CONTROLLED.has(lower)) {
      newTagsSet.add(lower)
    } else {
      unmappedTags.set(lower, (unmappedTags.get(lower) || 0) + 1)
    }
  }
  // Fallback if 0 controlled tags
  if (newTagsSet.size === 0) {
    newTagsSet.add(fallbackFromSlug(t.slug, t.name))
  }
  // Cap at 3 tags max (preserve order: insertion order in Set)
  const newTags = [...newTagsSet].slice(0, 3)

  tagsRemoved += oldTags.length - newTags.length
  tagsKept += newTags.length

  // Skip if unchanged (sorted equality check)
  const oldSorted = [...oldTags].sort().join(',')
  const newSorted = [...newTags].sort().join(',')
  if (oldSorted === newSorted) continue

  updates.push({ slug: t.slug, oldTags, newTags })
}

console.log('Updates needed:', updates.length, '/', tools.length)
console.log('Total tags removed:', tagsRemoved, '| Total tags kept:', tagsKept)
console.log('Unmapped tags (still appearing as noise):', unmappedTags.size)

if (unmappedTags.size > 0) {
  const sortedUnmapped = [...unmappedTags.entries()].sort((a,b) => b[1]-a[1])
  console.log('\nTop 25 unmapped tags (will be dropped):')
  for (const [t,n] of sortedUnmapped.slice(0, 25)) console.log('  ' + t.padEnd(30) + n)
}

if (isDry) { console.log('\n[dry-run, not writing SQL]'); process.exit(0) }

// ---- Generate SQL ----
const sql = []
sql.push('-- Phase 3: Tag Controlled Vocabulary (S87d)')
sql.push('-- ' + tools.length + ' tools, ' + updates.length + ' updates needed')
sql.push('-- Vocabulary: 30 controlled tags (12 core categories + 18 sub-tags)')
sql.push('')
sql.push('BEGIN;')
sql.push('')
for (const u of updates) {
  const arr = '{' + u.newTags.map(t => '"' + t + '"').join(',') + '}'
  sql.push("UPDATE tools SET tags = '" + arr + "' WHERE slug = '" + u.slug + "';")
}
sql.push('')
sql.push('COMMIT;')
sql.push('')
sql.push("-- Verify: SELECT DISTINCT unnest(tags) FROM tools ORDER BY 1; -- expect ~30 tags max")

writeFileSync(SQL_OUT, sql.join('\n'))
console.log('\nWrote SQL:', SQL_OUT)
