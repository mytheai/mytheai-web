import Link from 'next/link'
import { GLOSSARY } from '@/data/glossary'
import AuthorBio from '@/components/layout/AuthorBio'
import { getAuthorJsonLd } from '@/data/authors'
import type { Metadata } from 'next'

export const revalidate = 604800

export const metadata: Metadata = {
  title: 'AI Glossary 2026: Plain-English Definitions for Every AI Term | MytheAi',
  description: `${GLOSSARY.length}+ AI and machine-learning terms defined in plain English. LLMs, RAG, embeddings, agents, fine-tuning, and more - cross-linked to the tools that use them.`,
  alternates: { canonical: 'https://mytheai.com/glossary' },
  openGraph: {
    title: 'AI Glossary 2026 | MytheAi',
    description: 'Plain-English definitions for every AI and machine-learning term you will run into in 2026.',
    url: 'https://mytheai.com/glossary',
  },
}

export default function GlossaryHub() {
  const sorted = [...GLOSSARY].sort((a, b) => a.term.localeCompare(b.term))
  const year = new Date().getFullYear()

  const collectionPageJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    name: `AI Glossary ${year}`,
    description: `${GLOSSARY.length} essential AI and machine-learning terms defined in plain English.`,
    url: 'https://mytheai.com/glossary',
    inLanguage: 'en',
    isPartOf: { '@type': 'WebSite', name: 'MytheAi', url: 'https://mytheai.com' },
    author: getAuthorJsonLd(),
    publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
    mainEntity: {
      '@type': 'ItemList',
      numberOfItems: GLOSSARY.length,
      itemListElement: sorted.map((g, i) => ({
        '@type': 'ListItem',
        position: i + 1,
        name: g.term,
        url: `https://mytheai.com/glossary/${g.slug}`,
      })),
    },
  }

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Glossary', item: 'https://mytheai.com/glossary' },
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
          <span className="text-foreground font-medium">Glossary</span>
        </nav>

        <div className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Reference</p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            AI Glossary ({year})
          </h1>
          <p className="text-[16px] text-muted-foreground leading-relaxed">
            {GLOSSARY.length} essential AI and machine-learning terms, defined in plain English. Cross-linked to the tools that use them. Updated as the field evolves.
          </p>
        </div>

        <ol className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-10">
          {sorted.map(g => (
            <li key={g.slug}>
              <Link href={`/glossary/${g.slug}`} className="block p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors h-full">
                <p className="text-[14px] font-bold text-foreground mb-1">{g.term}</p>
                <p className="text-[12.5px] text-muted-foreground line-clamp-2 leading-snug">{g.short}</p>
              </Link>
            </li>
          ))}
        </ol>

        <div className="mb-8">
          <AuthorBio context="curated" />
        </div>

        <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          Notice an error or missing term? Email <a href="mailto:info@mytheai.com" className="text-blue-600 hover:underline">info@mytheai.com</a>. Definitions are reviewed quarterly to stay current with the field.
        </div>

      </div>
    </>
  )
}
