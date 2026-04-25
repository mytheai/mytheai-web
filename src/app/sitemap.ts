import { MetadataRoute } from 'next'
import { createStaticClient } from '@/lib/supabase'
import { mockCategories } from '@/data/mock'

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

  return [
    { url: 'https://mytheai.com', lastModified: new Date(), changeFrequency: 'daily', priority: 1 },
    { url: 'https://mytheai.com/tools', lastModified: new Date(), changeFrequency: 'daily', priority: 0.9 },
    { url: 'https://mytheai.com/compare', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.8 },
    { url: 'https://mytheai.com/top-10', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.8 },
    { url: 'https://mytheai.com/categories', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.7 },
    { url: 'https://mytheai.com/deals', lastModified: new Date(), changeFrequency: 'daily', priority: 0.7 },
    { url: 'https://mytheai.com/submit', lastModified: new Date(), changeFrequency: 'monthly', priority: 0.4 },
    ...toolUrls,
    ...compareUrls,
    ...categoryUrls,
  ]
}
