import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import Script from 'next/script'
import './globals.css'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'

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
    images: [{ url: '/og-image.png', width: 1200, height: 630, alt: 'MytheAi - AI & SaaS Tools Directory' }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'MytheAi - Best AI & SaaS Tools 2026',
    description: 'Discover, compare and review 500+ AI & SaaS tools. Honest rankings, verified pricing - no pay-to-rank.',
    images: ['/og-image.png'],
  },
  robots: { index: true, follow: true },
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`${inter.variable} antialiased`} suppressHydrationWarning>
      <body className="min-h-screen flex flex-col bg-background text-foreground">
        <Header />
        <main className="flex-1">{children}</main>
        <Footer />
        <Script
          src="https://plausible.io/js/script.outbound-links.file-downloads.js"
          data-domain="mytheai.com"
          strategy="afterInteractive"
          defer
        />
      </body>
    </html>
  )
}
