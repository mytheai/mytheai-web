import { MetadataRoute } from 'next'
import { createStaticClient } from '@/lib/supabase'

export const revalidate = 86400

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const supabase = createStaticClient()
  const { data } = await supabase.from('tools').select('slug,updated_at')
  const tools = data ?? []

  const toolUrls: MetadataRoute.Sitemap = tools.map(t => ({
    url: `https://mytheai.com/tools/${t.slug}`,
    lastModified: new Date(t.updated_at),
    changeFrequency: 'weekly',
    priority: 0.8,
  }))

  return [
    { url: 'https://mytheai.com', lastModified: new Date(), changeFrequency: 'daily', priority: 1 },
    { url: 'https://mytheai.com/tools', lastModified: new Date(), changeFrequency: 'daily', priority: 0.9 },
    ...toolUrls,
  ]
}
