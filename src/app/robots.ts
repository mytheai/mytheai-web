import { MetadataRoute } from 'next'

export default function robots(): MetadataRoute.Robots {
  return {
    rules: {
      userAgent: '*',
      allow: '/',
      disallow: '/go/',
    },
    sitemap: 'https://mytheai.com/sitemap.xml',
  }
}
