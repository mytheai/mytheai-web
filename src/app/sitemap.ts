import { MetadataRoute } from 'next'
import { readdirSync, readFileSync } from 'fs'
import path from 'path'
import matter from 'gray-matter'
import { createStaticClient } from '@/lib/supabase'
import { mockCategories } from '@/data/mock'
import { TOP10_LISTS } from '@/data/top10'
import { GLOSSARY } from '@/data/glossary'
import { USE_CASES } from '@/data/useCases'
import { AUTHORS } from '@/data/authors'

export const revalidate = 86400

const BASE = 'https://mytheai.com'

const REDIRECTED_TOP10_SLUGS = new Set([
  'best-ai-writing-tools', 'best-code-ai-tools', 'best-ai-seo-tools',
  'best-ai-video-tools', 'best-ai-image-generators', 'best-ai-agent-tools',
  'best-workflow-automation-tools', 'best-ai-sales-tools', 'best-ai-customer-service-tools',
  'best-ai-legal-tools', 'best-ai-tools-for-finance', 'best-ai-healthcare-tools',
  'best-ai-marketing-tools', 'best-ai-design-tools', 'best-ai-research-tools',
  'best-ai-productivity-tools',
])

const BEST_CATEGORIES = [
  'writing','coding','seo','video','image','agents','automation','sales','customer-support',
  'legal','finance','healthcare','marketing','design','research','productivity',
]

const FREE_AI_CATEGORIES = [
  'ai-assistants','writing-ai','image-ai','video-ai','code-ai',
  'seo-marketing','productivity','voice-audio','analytics','automation',
]

const ROLES = ['developer','marketer','creator','designer','founder','student','sales','support']

export async function generateSitemaps() {
  return [
    { id: 'static' },
    { id: 'tools' },
    { id: 'compare' },
    { id: 'tasks' },
    { id: 'top10' },
    { id: 'blog' },
  ]
}

export default async function sitemap(props: { id: Promise<string> }): Promise<MetadataRoute.Sitemap> {
  const id = await props.id
  const supabase = createStaticClient()

  if (id === 'static') {
    const bestCategoryUrls: MetadataRoute.Sitemap = BEST_CATEGORIES.map(c => ({
      url: `${BASE}/best/${c}`,
      lastModified: new Date(),
      changeFrequency: 'weekly',
      priority: 0.85,
    }))

    const roleUrls: MetadataRoute.Sitemap = ROLES.map(s => ({
      url: `${BASE}/roles/${s}`,
      lastModified: new Date(),
      changeFrequency: 'weekly' as const,
      priority: 0.7,
    }))

    const freeAiUrls: MetadataRoute.Sitemap = FREE_AI_CATEGORIES.map(c => ({
      url: `${BASE}/free-ai-tools/${c}`,
      lastModified: new Date(),
      changeFrequency: 'weekly' as const,
      priority: 0.7,
    }))

    return [
      { url: BASE, lastModified: new Date(), changeFrequency: 'daily', priority: 1 },
      { url: `${BASE}/tools`, lastModified: new Date(), changeFrequency: 'daily', priority: 0.9 },
      { url: `${BASE}/compare`, lastModified: new Date(), changeFrequency: 'weekly', priority: 0.8 },
      { url: `${BASE}/top-10`, lastModified: new Date(), changeFrequency: 'weekly', priority: 0.8 },
      { url: `${BASE}/categories`, lastModified: new Date(), changeFrequency: 'weekly', priority: 0.7 },
      { url: `${BASE}/deals`, lastModified: new Date(), changeFrequency: 'daily', priority: 0.7 },
      { url: `${BASE}/reviews`, lastModified: new Date(), changeFrequency: 'daily', priority: 0.8 },
      { url: `${BASE}/blog`, lastModified: new Date(), changeFrequency: 'weekly', priority: 0.6 },
      { url: `${BASE}/about`, lastModified: new Date(), changeFrequency: 'monthly', priority: 0.5 },
      { url: `${BASE}/privacy`, lastModified: new Date(), changeFrequency: 'monthly', priority: 0.3 },
      { url: `${BASE}/contact`, lastModified: new Date(), changeFrequency: 'monthly', priority: 0.4 },
      { url: `${BASE}/submit`, lastModified: new Date(), changeFrequency: 'monthly', priority: 0.4 },
      { url: `${BASE}/methodology`, lastModified: new Date(), changeFrequency: 'monthly', priority: 0.6 },
      { url: `${BASE}/transparency`, lastModified: new Date(), changeFrequency: 'monthly', priority: 0.5 },
      { url: `${BASE}/press`, lastModified: new Date(), changeFrequency: 'monthly', priority: 0.5 },
      { url: `${BASE}/quiz`, lastModified: new Date(), changeFrequency: 'monthly', priority: 0.7 },
      { url: `${BASE}/glossary`, lastModified: new Date(), changeFrequency: 'weekly', priority: 0.6 },
      { url: `${BASE}/use-case`, lastModified: new Date(), changeFrequency: 'weekly', priority: 0.75 },
      { url: `${BASE}/tasks`, lastModified: new Date(), changeFrequency: 'daily', priority: 0.8 },
      { url: `${BASE}/best`, lastModified: new Date(), changeFrequency: 'weekly', priority: 0.85 },
      ...roleUrls,
      ...freeAiUrls,
      ...bestCategoryUrls,
    ]
  }

  if (id === 'tools') {
    const [{ data: toolsData }, { data: altToolsData }] = await Promise.all([
      supabase.from('tools').select('slug,updated_at'),
      supabase
        .from('tools')
        .select('slug,updated_at')
        .or('trending.eq.true,featured.eq.true,editor_pick.eq.true')
        .limit(150),
    ])

    const toolUrls: MetadataRoute.Sitemap = (toolsData ?? []).map(t => ({
      url: `${BASE}/tools/${t.slug}`,
      lastModified: new Date(t.updated_at),
      changeFrequency: 'weekly',
      priority: 0.8,
    }))

    const alternativesUrls: MetadataRoute.Sitemap = (altToolsData ?? []).map(t => ({
      url: `${BASE}/alternatives/${t.slug}`,
      lastModified: new Date(t.updated_at),
      changeFrequency: 'weekly',
      priority: 0.7,
    }))

    return [...toolUrls, ...alternativesUrls]
  }

  if (id === 'compare') {
    const { data: comparisonsData } = await supabase.from('comparisons').select('slug,updated_at')
    return (comparisonsData ?? []).map(c => ({
      url: `${BASE}/compare/${c.slug}`,
      lastModified: new Date(c.updated_at),
      changeFrequency: 'weekly',
      priority: 0.7,
    }))
  }

  if (id === 'tasks') {
    const { data: tasksData } = await supabase
      .from('tasks')
      .select('slug,updated_at')
      .eq('status', 'published')
    return (tasksData ?? []).map(t => ({
      url: `${BASE}/tasks/${t.slug}`,
      lastModified: new Date(t.updated_at),
      changeFrequency: 'weekly',
      priority: 0.75,
    }))
  }

  if (id === 'top10') {
    const top10Urls: MetadataRoute.Sitemap = TOP10_LISTS
      .filter(list => !REDIRECTED_TOP10_SLUGS.has(list.slug))
      .map(list => ({
        url: `${BASE}/top-10/${list.slug}`,
        lastModified: new Date(),
        changeFrequency: 'weekly',
        priority: 0.7,
      }))

    const categoryUrls: MetadataRoute.Sitemap = mockCategories.map(cat => ({
      url: `${BASE}/categories/${cat.slug}`,
      lastModified: new Date(),
      changeFrequency: 'weekly',
      priority: 0.7,
    }))

    const glossaryUrls: MetadataRoute.Sitemap = GLOSSARY.map(g => ({
      url: `${BASE}/glossary/${g.slug}`,
      lastModified: new Date(),
      changeFrequency: 'monthly',
      priority: 0.6,
    }))

    const useCaseUrls: MetadataRoute.Sitemap = USE_CASES.map(u => ({
      url: `${BASE}/use-case/${u.slug}`,
      lastModified: new Date(),
      changeFrequency: 'weekly',
      priority: 0.75,
    }))

    const authorUrls: MetadataRoute.Sitemap = Object.keys(AUTHORS).map(slug => ({
      url: `${BASE}/authors/${slug}`,
      lastModified: new Date(),
      changeFrequency: 'monthly',
      priority: 0.5,
    }))

    return [...top10Urls, ...categoryUrls, ...glossaryUrls, ...useCaseUrls, ...authorUrls]
  }

  if (id === 'blog') {
    const blogDir = path.join(process.cwd(), 'content/blog')
    const blogFiles = readdirSync(blogDir).filter(f => f.endsWith('.mdx'))
    return blogFiles.map(file => {
      const slug = file.replace('.mdx', '')
      const src = readFileSync(path.join(blogDir, file), 'utf-8')
      const { data } = matter(src)
      return {
        url: `${BASE}/blog/${slug}`,
        lastModified: data.date ? new Date(data.date) : new Date(),
        changeFrequency: 'monthly' as const,
        priority: 0.7,
      }
    })
  }

  return []
}
