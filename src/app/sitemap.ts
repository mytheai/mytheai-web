import { MetadataRoute } from 'next'
import { readdirSync, readFileSync } from 'fs'
import path from 'path'
import matter from 'gray-matter'
import { createStaticClient } from '@/lib/supabase'
import { mockCategories } from '@/data/mock'
import { TOP10_LISTS } from '@/data/top10'

export const revalidate = 86400

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const supabase = createStaticClient()

  const [{ data: toolsData }, { data: comparisonsData }] = await Promise.all([
    supabase.from('tools').select('slug,updated_at'),
    supabase.from('comparisons').select('slug,updated_at'),
  ])

  const toolUrls: MetadataRoute.Sitemap = (toolsData ?? []).map(t => ({
    url: `https://mytheai.com/tools/${t.slug}`,
    lastModified: new Date(t.updated_at),
    changeFrequency: 'weekly',
    priority: 0.8,
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

  const top10Urls: MetadataRoute.Sitemap = TOP10_LISTS.map(list => ({
    url: `https://mytheai.com/top-10/${list.slug}`,
    lastModified: new Date(),
    changeFrequency: 'weekly',
    priority: 0.7,
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
    ...toolUrls,
    ...compareUrls,
    ...categoryUrls,
    ...top10Urls,
    ...blogUrls,
  ]
}
