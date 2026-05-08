import type { NextConfig } from 'next'
import createNextIntlPlugin from 'next-intl/plugin'

const withNextIntl = createNextIntlPlugin('./i18n.ts')

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      { protocol: 'https', hostname: 'www.google.com', pathname: '/s2/favicons**' },
      { protocol: 'https', hostname: 't2.gstatic.com', pathname: '/faviconV2**' },
      { protocol: 'https', hostname: 'logo.clearbit.com' },
      { protocol: 'https', hostname: '**.supabase.co' },
      { protocol: 'https', hostname: '**.supabase.in' },
    ],
  },
  async redirects() {
    return [
      { source: '/compare/zapier-vs-make', destination: '/compare/zapier-vs-make-com', permanent: true },
      { source: '/roles', destination: '/top-10#by-role', permanent: true },
      // Money page consolidation: /top-10/best-* → /best/[category] (308 permanent)
      { source: '/top-10/best-ai-writing-tools', destination: '/best/writing', permanent: true },
      { source: '/top-10/best-code-ai-tools', destination: '/best/coding', permanent: true },
      { source: '/top-10/best-ai-seo-tools', destination: '/best/seo', permanent: true },
      { source: '/top-10/best-ai-video-tools', destination: '/best/video', permanent: true },
      { source: '/top-10/best-ai-image-generators', destination: '/best/image', permanent: true },
      { source: '/top-10/best-ai-agent-tools', destination: '/best/agents', permanent: true },
      { source: '/top-10/best-workflow-automation-tools', destination: '/best/automation', permanent: true },
      { source: '/top-10/best-ai-sales-tools', destination: '/best/sales', permanent: true },
      { source: '/top-10/best-ai-customer-service-tools', destination: '/best/customer-support', permanent: true },
      // S142 money page expansion: 7 more verticals
      { source: '/top-10/best-ai-legal-tools', destination: '/best/legal', permanent: true },
      { source: '/top-10/best-ai-tools-for-finance', destination: '/best/finance', permanent: true },
      { source: '/top-10/best-ai-healthcare-tools', destination: '/best/healthcare', permanent: true },
      { source: '/top-10/best-ai-marketing-tools', destination: '/best/marketing', permanent: true },
      { source: '/top-10/best-ai-design-tools', destination: '/best/design', permanent: true },
      { source: '/top-10/best-ai-research-tools', destination: '/best/research', permanent: true },
      { source: '/top-10/best-ai-productivity-tools', destination: '/best/productivity', permanent: true },
    ]
  },
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          { key: 'X-Frame-Options', value: 'SAMEORIGIN' },
          { key: 'X-Content-Type-Options', value: 'nosniff' },
          { key: 'X-XSS-Protection', value: '1; mode=block' },
          { key: 'Referrer-Policy', value: 'strict-origin-when-cross-origin' },
          { key: 'Permissions-Policy', value: 'camera=(), microphone=(), geolocation=()' },
        ],
      },
    ]
  },
}

export default withNextIntl(nextConfig)
