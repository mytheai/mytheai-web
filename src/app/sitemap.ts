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

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const supabase = createStaticClient()

  const [{ data: toolsData }, { data: comparisonsData }, { data: altToolsData }, { data: tasksData }] = await Promise.all([
    supabase.from('tools').select('slug,updated_at'),
    supabase.from('comparisons').select('slug,updated_at'),
    supabase
      .from('tools')
      .select('slug,updated_at')
      .or('trending.eq.true,featured.eq.true,editor_pick.eq.true')
      .limit(150),
    supabase.from('tasks').select('slug,updated_at').eq('status', 'published'),
  ])

  const toolUrls: MetadataRoute.Sitemap = (toolsData ?? []).map(t => ({
    url: `https://mytheai.com/tools/${t.slug}`,
    lastModified: new Date(t.updated_at),
    changeFrequency: 'weekly',
    priority: 0.8,
  }))

  const alternativesUrls: MetadataRoute.Sitemap = (altToolsData ?? []).map(t => ({
    url: `https://mytheai.com/alternatives/${t.slug}`,
    lastModified: new Date(t.updated_at),
    changeFrequency: 'weekly',
    priority: 0.7,
  }))

  const compareUrls: MetadataRoute.Sitemap = (comparisonsData ?? []).map(c => ({
    url: `https://mytheai.com/compare/${c.slug}`,
    lastModified: new Date(c.updated_at),
    changeFrequency: 'weekly',
    priority: 0.7,
  }))

  const categoryUrls: MetadataRoute.Sitemap = mockCategories.map(cat => ({
    url: `https://mytheai.com/categories/${cat.slug}`,
    lastModified: new Date(),
    changeFrequency: 'weekly',
    priority: 0.7,
  }))

  const REDIRECTED_TOP10_SLUGS = new Set([
    'best-ai-writing-tools', 'best-code-ai-tools', 'best-ai-seo-tools',
    'best-ai-video-tools', 'best-ai-image-generators', 'best-ai-agent-tools',
    'best-workflow-automation-tools', 'best-ai-sales-tools', 'best-ai-customer-service-tools',
  ])
  const top10Urls: MetadataRoute.Sitemap = TOP10_LISTS
    .filter(list => !REDIRECTED_TOP10_SLUGS.has(list.slug))
    .map(list => ({
      url: `https://mytheai.com/top-10/${list.slug}`,
      lastModified: new Date(),
      changeFrequency: 'weekly',
      priority: 0.7,
    }))

  const bestCategoryUrls: MetadataRoute.Sitemap = [
    'writing','coding','seo','video','image','agents','automation','sales','customer-support',
  ].map(c => ({
    url: `https://mytheai.com/best/${c}`,
    lastModified: new Date(),
    changeFrequency: 'weekly',
    priority: 0.85,
  }))

  const glossaryUrls: MetadataRoute.Sitemap = GLOSSARY.map(g => ({
    url: `https://mytheai.com/glossary/${g.slug}`,
    lastModified: new Date(),
    changeFrequency: 'monthly',
    priority: 0.6,
  }))

  const useCaseUrls: MetadataRoute.Sitemap = USE_CASES.map(u => ({
    url: `https://mytheai.com/use-case/${u.slug}`,
    lastModified: new Date(),
    changeFrequency: 'weekly',
    priority: 0.75,
  }))

  const taskUrls: MetadataRoute.Sitemap = (tasksData ?? []).map(t => ({
    url: `https://mytheai.com/tasks/${t.slug}`,
    lastModified: new Date(t.updated_at),
    changeFrequency: 'weekly',
    priority: 0.75,
  }))

  const authorUrls: MetadataRoute.Sitemap = Object.keys(AUTHORS).map(slug => ({
    url: `https://mytheai.com/authors/${slug}`,
    lastModified: new Date(),
    changeFrequency: 'monthly',
    priority: 0.5,
  }))

  const blogDir = path.join(process.cwd(), 'content/blog')
  const blogFiles = readdirSync(blogDir).filter(f => f.endsWith('.mdx'))
  const blogUrls: MetadataRoute.Sitemap = blogFiles.map(file => {
    const slug = file.replace('.mdx', '')
    const src = readFileSync(path.join(blogDir, file), 'utf-8')
    const { data } = matter(src)
    return {
      url: `https://mytheai.com/blog/${slug}`,
      lastModified: data.date ? new Date(data.date) : new Date(),
      changeFrequency: 'monthly' as const,
      priority: 0.7,
    }
  })

  return [
    { url: 'https://mytheai.com', lastModified: new Date(), changeFrequency: 'daily', priority: 1 },
    { url: 'https://mytheai.com/tools', lastModified: new Date(), changeFrequency: 'daily', priority: 0.9 },
    { url: 'https://mytheai.com/compare', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.8 },
    { url: 'https://mytheai.com/top-10', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.8 },
    { url: 'https://mytheai.com/categories', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.7 },
    { url: 'https://mytheai.com/deals', lastModified: new Date(), changeFrequency: 'daily', priority: 0.7 },
    { url: 'https://mytheai.com/reviews', lastModified: new Date(), changeFrequency: 'daily', priority: 0.8 },
    { url: 'https://mytheai.com/blog', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.6 },
    { url: 'https://mytheai.com/about', lastModified: new Date(), changeFrequency: 'monthly', priority: 0.5 },
    { url: 'https://mytheai.com/privacy', lastModified: new Date(), changeFrequency: 'monthly', priority: 0.3 },
    { url: 'https://mytheai.com/contact', lastModified: new Date(), changeFrequency: 'monthly', priority: 0.4 },
    { url: 'https://mytheai.com/submit', lastModified: new Date(), changeFrequency: 'monthly', priority: 0.4 },
    { url: 'https://mytheai.com/methodology', lastModified: new Date(), changeFrequency: 'monthly', priority: 0.6 },
    { url: 'https://mytheai.com/transparency', lastModified: new Date(), changeFrequency: 'monthly', priority: 0.5 },
    { url: 'https://mytheai.com/press', lastModified: new Date(), changeFrequency: 'monthly', priority: 0.5 },
    ...['developer','marketer','creator','designer','founder','student','sales','support'].map(s => ({
      url: `https://mytheai.com/roles/${s}`,
      lastModified: new Date(),
      changeFrequency: 'weekly' as const,
      priority: 0.7,
    })),
    { url: 'https://mytheai.com/quiz', lastModified: new Date(), changeFrequency: 'monthly', priority: 0.7 },
    ...['ai-assistants','writing-ai','image-ai','video-ai','code-ai','seo-marketing','productivity','voice-audio','analytics','automation'].map(c => ({
      url: `https://mytheai.com/free-ai-tools/${c}`,
      lastModified: new Date(),
      changeFrequency: 'weekly' as const,
      priority: 0.7,
    })),
    { url: 'https://mytheai.com/glossary', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.6 },
    { url: 'https://mytheai.com/use-case', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.75 },
    { url: 'https://mytheai.com/tasks', lastModified: new Date(), changeFrequency: 'daily', priority: 0.8 },
    { url: 'https://mytheai.com/best', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.85 },
    ...bestCategoryUrls,
    ...toolUrls,
    ...compareUrls,
    ...alternativesUrls,
    ...categoryUrls,
    ...top10Urls,
    ...blogUrls,
    ...glossaryUrls,
    ...useCaseUrls,
    ...taskUrls,
    ...authorUrls,
  ]
}
