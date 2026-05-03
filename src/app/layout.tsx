import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import Script from 'next/script'
import { NextIntlClientProvider } from 'next-intl'
import { getLocale, getMessages } from 'next-intl/server'
import { RTL_LOCALES, type Locale } from '../../i18n'
import './globals.css'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'
import StickyMobileBar from '@/components/newsletter/StickyMobileBar'

const inter = Inter({
  subsets: ['latin'],
  variable: '--font-sans',
  display: 'swap',
})

export const metadata: Metadata = {
  title: 'MytheAi - Best AI & SaaS Tools 2026 | Reviews, Comparisons & Rankings',
  description: 'Discover, compare and review 500+ AI & SaaS tools. Honest rankings, side-by-side comparisons, verified pricing - no pay-to-rank. Updated weekly.',
  metadataBase: new URL('https://mytheai.com'),
  alternates: { canonical: '/' },
  openGraph: {
    type: 'website',
    url: 'https://mytheai.com/',
    siteName: 'MytheAi',
    locale: 'en_US',
    title: 'MytheAi - Best AI & SaaS Tools 2026 | Reviews, Comparisons & Rankings',
    description: 'Discover, compare and review 500+ AI & SaaS tools. Honest rankings, side-by-side comparisons, verified pricing - no pay-to-rank.',
    images: [{ url: '/api/og/site', width: 1200, height: 630, alt: 'MytheAi - AI & SaaS Tools Directory' }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'MytheAi - Best AI & SaaS Tools 2026',
    description: 'Discover, compare and review 500+ AI & SaaS tools. Honest rankings, verified pricing - no pay-to-rank.',
    images: ['/api/og/site'],
  },
  manifest: '/manifest.json',
  verification: { google: 'v1XXmGzPAUqEJsSXb3F1bl3TipZYYKmIObnmRK8N2oc' },
  robots: { index: true, follow: true },
}

const organizationSchema = {
  '@context': 'https://schema.org',
  '@type': 'Organization',
  name: 'MytheAi',
  url: 'https://mytheai.com',
  logo: {
    '@type': 'ImageObject',
    url: 'https://mytheai.com/api/logo',
    width: 512,
    height: 512,
  },
  description: 'Discover, compare and review 500+ AI & SaaS tools. Honest rankings, verified pricing - no pay-to-rank.',
  contactPoint: { '@type': 'ContactPoint', contactType: 'customer support', email: 'hello@mytheai.com' },
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
  const dir = RTL_LOCALES.has(locale as Locale) ? 'rtl' : 'ltr'
  return (
    <html lang={locale} dir={dir} className={`${inter.variable} antialiased`} suppressHydrationWarning>
      <body className="min-h-screen flex flex-col bg-background text-foreground">
        <NextIntlClientProvider locale={locale} messages={messages}>
          <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(organizationSchema) }} />
          <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(websiteSchema) }} />
          <Header />
          <main className="flex-1">{children}</main>
          <Footer />
          <StickyMobileBar />
          <Script
            src="https://plausible.io/js/script.outbound-links.file-downloads.js"
            data-domain="mytheai.com"
            strategy="afterInteractive"
            defer
          />
        </NextIntlClientProvider>
      </body>
    </html>
  )
}
