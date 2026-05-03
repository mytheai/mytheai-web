import { notFound } from 'next/navigation'
import Link from 'next/link'
import { GLOSSARY, getGlossaryEntry } from '@/data/glossary'
import { createStaticClient } from '@/lib/supabase'
import AuthorBio from '@/components/layout/AuthorBio'
import LogoImage from '@/components/ui/LogoImage'
import { getAuthorJsonLd } from '@/data/authors'
import type { Metadata } from 'next'

export const revalidate = 604800

interface ToolStub {
  slug: string
  name: string
  tagline: string
  logo_url: string | null
  website_url: string | null
  rating: number
}

async function getRelatedToolsForGlossary(slugs: string[] = []): Promise<ToolStub[]> {
  if (slugs.length === 0) return []
  const supabase = createStaticClient()
  const { data } = await supabase
    .from('tools')
    .select('slug, name, tagline, logo_url, website_url, rating')
    .in('slug', slugs)
  if (!data) return []
  // Preserve the order from the entry
  return slugs.map(s => data.find(t => t.slug === s)).filter(Boolean) as ToolStub[]
}

export function generateStaticParams() {
  return GLOSSARY.map(g => ({ slug: g.slug }))
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const g = getGlossaryEntry(slug)
  if (!g) return { title: 'Term not found | MytheAi' }
  const year = new Date().getFullYear()
  return {
    title: `${g.term} - Definition (${year}) | MytheAi Glossary`,
    description: g.short,
    alternates: { canonical: `https://mytheai.com/glossary/${slug}` },
    openGraph: {
      title: `${g.term} | MytheAi Glossary`,
      description: g.short,
      url: `https://mytheai.com/glossary/${slug}`,
    },
  }
}

export default async function GlossaryDetailPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const entry = getGlossaryEntry(slug)
  if (!entry) notFound()

  const relatedTools = await getRelatedToolsForGlossary(entry.relatedTools)
  const year = new Date().getFullYear()

  const definedTermJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'DefinedTerm',
    name: entry.term,
    description: entry.short,
    inDefinedTermSet: {
      '@type': 'DefinedTermSet',
      name: 'MytheAi AI Glossary',
      url: 'https://mytheai.com/glossary',
    },
    url: `https://mytheai.com/glossary/${slug}`,
    author: getAuthorJsonLd(),
  }

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Glossary', item: 'https://mytheai.com/glossary' },
      { '@type': 'ListItem', position: 3, name: entry.term, item: `https://mytheai.com/glossary/${slug}` },
    ],
  }

  const relatedEntries = (entry.relatedTerms ?? [])
    .map(s => GLOSSARY.find(g => g.slug === s))
    .filter(Boolean)

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(definedTermJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/glossary" className="hover:text-blue-600 transition-colors">Glossary</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{entry.term}</span>
        </nav>

        <div className="mb-8">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Glossary entry</p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            {entry.term}
          </h1>
          <p className="text-[16px] text-muted-foreground leading-relaxed">
            {entry.short}
          </p>
        </div>

        <article className="mb-10">
          {entry.long.split('\n\n').map((para, i) => (
            <p key={i} className="text-[15px] text-foreground leading-relaxed mb-4">{para}</p>
          ))}
        </article>

        {relatedTools.length > 0 && (
          <section className="mb-10">
            <h2 className="text-[18px] font-bold text-foreground mb-3">Tools that use {entry.term}</h2>
            <ul className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              {relatedTools.map(t => (
                <li key={t.slug}>
                  <Link href={`/tools/${t.slug}`} className="flex items-start gap-3 p-3 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors">
                    <div className="w-9 h-9 rounded-lg border border-border bg-white flex items-center justify-center flex-shrink-0 overflow-hidden">
                      <LogoImage src={t.logo_url} websiteUrl={t.website_url} name={t.name} size={28} />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-[13px] font-bold text-foreground truncate">{t.name}</p>
                      <p className="text-[12px] text-muted-foreground line-clamp-2">{t.tagline}</p>
                      <p className="text-[11px] text-[#F59E0B] mt-1">★ {t.rating.toFixed(1)}</p>
                    </div>
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        )}

        {relatedEntries.length > 0 && (
          <section className="mb-10">
            <h2 className="text-[18px] font-bold text-foreground mb-3">Related terms</h2>
            <ul className="flex flex-wrap gap-2">
              {relatedEntries.map(g => (
                <li key={g!.slug}>
                  <Link href={`/glossary/${g!.slug}`} className="inline-block px-3 py-1.5 rounded-full text-[12.5px] font-medium border border-border bg-card text-foreground hover:border-blue-300 hover:text-blue-600 transition-colors">
                    {g!.term}
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        )}

        <div className="mb-8">
          <AuthorBio context="written" />
        </div>

        <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          See also: <Link href="/glossary" className="text-blue-600 hover:underline">all {GLOSSARY.length} terms</Link>
          <span className="mx-2">·</span>
          <Link href="/methodology" className="text-blue-600 hover:underline">how we research</Link>
          <span className="mx-2">·</span>
          Last reviewed {year}
        </div>

      </div>
    </>
  )
}
