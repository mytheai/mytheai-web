import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import Script from 'next/script'
import { NextIntlClientProvider } from 'next-intl'
import { getLocale, getMessages } from 'next-intl/server'
import './globals.css'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'
import StickyMobileBar from '@/components/newsletter/StickyMobileBar'
import { STATIC_TOOL_COUNT_DISPLAY } from '@/lib/stats'

const inter = Inter({
  subsets: ['latin'],
  variable: '--font-sans',
  display: 'swap',
})

export const metadata: Metadata = {
  title: 'MytheAi - Best AI & SaaS Tools 2026 | Reviews, Comparisons & Rankings',
  description: `Discover, compare and review ${STATIC_TOOL_COUNT_DISPLAY} AI & SaaS tools. Honest rankings, side-by-side comparisons, verified pricing - no pay-to-rank. Updated weekly.`,
  metadataBase: new URL('https://mytheai.com'),
  alternates: { canonical: '/' },
  openGraph: {
    type: 'website',
    url: 'https://mytheai.com/',
    siteName: 'MytheAi',
    locale: 'en_US',
    title: 'MytheAi - Best AI & SaaS Tools 2026 | Reviews, Comparisons & Rankings',
    description: `Discover, compare and review ${STATIC_TOOL_COUNT_DISPLAY} AI & SaaS tools. Honest rankings, side-by-side comparisons, verified pricing - no pay-to-rank.`,
    images: [{ url: '/api/og/site', width: 1200, height: 630, alt: 'MytheAi - AI & SaaS Tools Directory' }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'MytheAi - Best AI & SaaS Tools 2026',
    description: `Discover, compare and review ${STATIC_TOOL_COUNT_DISPLAY} AI & SaaS tools. Honest rankings, verified pricing - no pay-to-rank.`,
    images: ['/api/og/site'],
  },
  manifest: '/manifest.json',
  icons: {
    icon: [
      { url: '/icon.svg', type: 'image/svg+xml' },
      { url: '/icon-192.png', type: 'image/png', sizes: '192x192' },
      { url: '/icon-512.png', type: 'image/png', sizes: '512x512' },
    ],
    apple: [
      { url: '/apple-icon', sizes: '180x180', type: 'image/png' },
    ],
    shortcut: '/favicon.ico',
  },
  verification: {
    google: 'v1XXmGzPAUqEJsSXb3F1bl3TipZYYKmIObnmRK8N2oc',
    ...(process.env.NEXT_PUBLIC_YANDEX_VERIFICATION
      ? { yandex: process.env.NEXT_PUBLIC_YANDEX_VERIFICATION }
      : {}),
    ...(process.env.NEXT_PUBLIC_BING_VERIFICATION
      ? { other: { 'msvalidate.01': process.env.NEXT_PUBLIC_BING_VERIFICATION } }
      : {}),
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-image-preview': 'large',
      'max-snippet': -1,
      'max-video-preview': -1,
    },
  },
}

const organizationSchema = {
  '@context': 'https://schema.org',
  '@type': 'Organization',
  '@id': 'https://mytheai.com#organization',
  name: 'MytheAi',
  url: 'https://mytheai.com',
  logo: {
    '@type': 'ImageObject',
    url: 'https://mytheai.com/icon-512.png',
    width: 512,
    height: 512,
  },
  description: `Discover, compare and review ${STATIC_TOOL_COUNT_DISPLAY} AI & SaaS tools. Honest rankings, verified pricing - no pay-to-rank.`,
  sameAs: [
    'https://twitter.com/mytheai',
    'https://www.linkedin.com/company/mytheai',
    'https://www.producthunt.com/@mytheai',
  ],
  foundingDate: '2026-01-01',
  founder: {
    '@type': 'Person',
    '@id': 'https://mytheai.com/about#john-pham',
    name: 'John Pham',
    url: 'https://mytheai.com/about',
    jobTitle: 'Founder & Editor-in-Chief',
  },
  knowsAbout: [
    'Artificial Intelligence',
    'SaaS',
    'Software Reviews',
    'AI Tools Directory',
    'Editorial Methodology',
    'Healthcare AI',
    'Legal AI',
    'Code Generation Tools',
    'Marketing Automation',
    'Customer Support Software',
    'Workflow Automation',
    'Design Tools',
    'Image Generation',
    'Video AI',
    'Education Technology',
    'Insurance Technology',
    'Real Estate Technology',
    'Research Assistants',
    'Consumer Finance',
    'Sales Engagement',
  ],
  contactPoint: { '@type': 'ContactPoint', contactType: 'customer support', email: 'info@mytheai.com' },
}

const websiteSchema = {
  '@context': 'https://schema.org',
  '@type': 'WebSite',
  name: 'MytheAi',
  url: 'https://mytheai.com',
  potentialAction: {
    '@type': 'SearchAction',
    target: { '@type': 'EntryPoint', urlTemplate: 'https://mytheai.com/tools?q={search_term_string}' },
    'query-input': 'required name=search_term_string',
  },
}

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  const locale = await getLocale()
  const messages = await getMessages()
  return (
    <html lang={locale} className={`${inter.variable} antialiased`} suppressHydrationWarning>
      <body className="min-h-screen flex flex-col bg-background text-foreground">
        <NextIntlClientProvider locale={locale} messages={messages}>
          <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(organizationSchema) }} />
          <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(websiteSchema) }} />
          <Header />
          <main className="flex-1">{children}</main>
          <Footer />
          <StickyMobileBar />
          <Script
            src="https://plausible.io/js/script.outbound-links.file-downloads.tagged-events.js"
            data-domain="mytheai.com"
            strategy="afterInteractive"
            defer
          />
          {process.env.NEXT_PUBLIC_CLARITY_PROJECT_ID && (
            <Script
              id="clarity-init"
              strategy="afterInteractive"
              dangerouslySetInnerHTML={{
                __html: `(function(c,l,a,r,i,t,y){c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};t=l.createElement(r);t.async=1;t.src="https://www.clarity.ms/tag/"+i;y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);})(window,document,"clarity","script","${process.env.NEXT_PUBLIC_CLARITY_PROJECT_ID}");`,
              }}
            />
          )}
        </NextIntlClientProvider>
      </body>
    </html>
  )
}
