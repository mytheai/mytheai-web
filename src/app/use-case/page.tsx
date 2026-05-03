import Link from 'next/link'
import { USE_CASES } from '@/data/useCases'
import AuthorBio from '@/components/layout/AuthorBio'
import { getAuthorJsonLd } from '@/data/authors'
import type { Metadata } from 'next'

export const revalidate = 604800

export const metadata: Metadata = {
  title: `AI Tools by Use Case ${new Date().getFullYear()}: Top Picks for Every Job | MytheAi`,
  description: `Find AI tools by job to be done. ${USE_CASES.length} curated use cases - blog writing, image generation, meeting notes, coding, and more. Independent rankings.`,
  alternates: { canonical: 'https://mytheai.com/use-case' },
  openGraph: {
    title: 'AI Tools by Use Case | MytheAi',
    description: 'Find AI tools by what you actually want to do.',
    url: 'https://mytheai.com/use-case',
  },
}

export default function UseCaseHub() {
  const year = new Date().getFullYear()
  const sorted = [...USE_CASES].sort((a, b) => a.title.localeCompare(b.title))

  const collectionPageJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    name: `AI Tools by Use Case ${year}`,
    description: `${USE_CASES.length} curated AI use cases with top tool picks.`,
    url: 'https://mytheai.com/use-case',
    inLanguage: 'en',
    isPartOf: { '@type': 'WebSite', name: 'MytheAi', url: 'https://mytheai.com' },
    author: getAuthorJsonLd(),
    publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
    mainEntity: {
      '@type': 'ItemList',
      numberOfItems: USE_CASES.length,
      itemListElement: sorted.map((u, i) => ({
        '@type': 'ListItem',
        position: i + 1,
        name: u.title,
        url: `https://mytheai.com/use-case/${u.slug}`,
      })),
    },
  }

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Use Cases', item: 'https://mytheai.com/use-case' },
    ],
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(collectionPageJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <span className="text-foreground font-medium">Use Cases</span>
        </nav>

        <div className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Browse by job</p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            AI Tools by Use Case ({year})
          </h1>
          <p className="text-[16px] text-muted-foreground leading-relaxed">
            Find AI tools by what you actually want to do. Each use case below maps to the {USE_CASES.length} most common tasks people use AI for in 2026, with curated picks tested in real workflows.
          </p>
        </div>

        <ol className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-10">
          {sorted.map(u => (
            <li key={u.slug}>
              <Link href={`/use-case/${u.slug}`} className="block p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors h-full">
                <p className="text-[14px] font-bold text-foreground mb-1">
                  <span className="mr-1.5">{u.emoji}</span>{u.title}
                </p>
                <p className="text-[12.5px] text-muted-foreground line-clamp-3 leading-snug">{u.intro.split('.')[0]}.</p>
              </Link>
            </li>
          ))}
        </ol>

        <div className="mb-8">
          <AuthorBio context="curated" />
        </div>

        <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          See also: <Link href="/tools" className="text-blue-600 hover:underline">all {USE_CASES.length}+ tools</Link>
          <span className="mx-2">·</span>
          <Link href="/categories" className="text-blue-600 hover:underline">categories</Link>
          <span className="mx-2">·</span>
          <Link href="/top-10" className="text-blue-600 hover:underline">top 10 lists</Link>
          <span className="mx-2">·</span>
          <Link href="/glossary" className="text-blue-600 hover:underline">glossary</Link>
        </div>

      </div>
    </>
  )
}
