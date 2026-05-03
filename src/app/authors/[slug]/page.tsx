import { notFound } from 'next/navigation'
import Link from 'next/link'
import { readdirSync, readFileSync } from 'fs'
import { join } from 'path'
import matter from 'gray-matter'
import { AUTHORS, getAuthor, getAuthorJsonLd, type Author } from '@/data/authors'
import type { Metadata } from 'next'

export const revalidate = 86400

interface BlogStub {
  slug: string
  title: string
  excerpt: string
  category: string
  date: string
  readTime: string
}

function getArticlesByAuthor(authorSlug: string): BlogStub[] {
  try {
    const dir = join(process.cwd(), 'content/blog')
    const files = readdirSync(dir).filter(f => f.endsWith('.mdx'))
    const all = files.map(file => {
      const slug = file.replace('.mdx', '')
      const raw = readFileSync(join(dir, file), 'utf-8')
      const { data } = matter(raw)
      return { ...(data as Omit<BlogStub, 'slug'> & { author?: string }), slug }
    })
    // Default author = john-ethan if not specified, so we include those for the founder
    const filtered = all.filter(a => {
      const slug = (a as BlogStub & { author?: string }).author ?? 'john-ethan'
      return slug === authorSlug
    })
    return filtered
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
      .slice(0, 12)
  } catch {
    return []
  }
}

export function generateStaticParams() {
  return Object.keys(AUTHORS).map(slug => ({ slug }))
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const author = AUTHORS[slug]
  if (!author) return { title: 'Author not found | MytheAi' }
  return {
    title: `${author.name} - ${author.role} | MytheAi`,
    description: author.bio.slice(0, 160),
    alternates: { canonical: `https://mytheai.com/authors/${slug}` },
    openGraph: {
      title: `${author.name} | MytheAi`,
      description: author.bio.slice(0, 160),
      url: `https://mytheai.com/authors/${slug}`,
      type: 'profile',
    },
  }
}

export default async function AuthorPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const author: Author | undefined = AUTHORS[slug]
  if (!author) notFound()

  const articles = getArticlesByAuthor(slug)
  const personJsonLd = {
    '@context': 'https://schema.org',
    ...getAuthorJsonLd(slug),
    knowsAbout: ['Artificial Intelligence', 'SaaS', 'Machine Learning', 'Software Reviews', 'AI Tools', 'Editorial Methodology'],
    worksFor: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
  }

  // ProfilePage schema makes the author a first-class entity for Google
  // (eligible for "Author" rich result + Knowledge Graph linkage)
  const profilePageJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'ProfilePage',
    dateCreated: '2026-01-01T00:00:00.000Z',
    dateModified: new Date().toISOString().split('T')[0],
    mainEntity: {
      ...getAuthorJsonLd(slug),
      knowsAbout: ['Artificial Intelligence', 'SaaS', 'Machine Learning', 'Software Reviews', 'AI Tools', 'Editorial Methodology'],
      worksFor: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
    },
  }

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'About', item: 'https://mytheai.com/about' },
      { '@type': 'ListItem', position: 3, name: author.name, item: `https://mytheai.com/authors/${slug}` },
    ],
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(profilePageJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(personJsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/about" className="hover:text-blue-600 transition-colors">About</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{author.name}</span>
        </nav>

        <header className="flex items-start gap-5 mb-10">
          <svg
            width="80" height="80" viewBox="0 0 32 32" fill="none"
            className="w-20 h-20 rounded-2xl flex-shrink-0"
            aria-label={`${author.name}, ${author.role}`}
            role="img"
          >
            <defs>
              <linearGradient id="ap-grad" x1="0" y1="0" x2="32" y2="32" gradientUnits="userSpaceOnUse">
                <stop offset="0%" stopColor="#60A5FA" />
                <stop offset="100%" stopColor="#1D4ED8" />
              </linearGradient>
            </defs>
            <rect width="32" height="32" rx="8" fill="url(#ap-grad)" />
            <path d="M16 4 L19 13 L28 16 L19 19 L16 28 L13 19 L4 16 L13 13 Z" fill="white" />
          </svg>
          <div className="flex-1 min-w-0">
            <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Editorial team</p>
            <h1 className="text-[28px] md:text-[34px] font-extrabold tracking-tight text-foreground mb-1">
              {author.name}
            </h1>
            <p className="text-[15px] font-semibold text-blue-600 mb-3">{author.role}</p>
            <p className="text-[15px] text-muted-foreground leading-relaxed">{author.bio}</p>
            {(author.twitter || author.linkedin || author.github) && (
              <p className="mt-3 flex flex-wrap items-center gap-3 text-[13px]">
                {author.twitter && (
                  <a href={author.twitter} target="_blank" rel="noopener noreferrer me" className="text-blue-600 hover:underline font-medium">Twitter</a>
                )}
                {author.linkedin && (
                  <a href={author.linkedin} target="_blank" rel="noopener noreferrer me" className="text-blue-600 hover:underline font-medium">LinkedIn</a>
                )}
                {author.github && (
                  <a href={author.github} target="_blank" rel="noopener noreferrer me" className="text-blue-600 hover:underline font-medium">GitHub</a>
                )}
              </p>
            )}
          </div>
        </header>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-3">How I review tools</h2>
          <p className="text-[15px] text-muted-foreground leading-relaxed mb-3">
            Every tool on MytheAi is scored on a public seven-criteria framework. For tools I can install or sign up for directly, I run a minimum 8-hour evaluation across two work sessions on real tasks from my backlog - drafting blog posts, comparing legal documents, building UI prototypes, summarising meeting recordings - rather than synthetic prompts.
          </p>
          <p className="text-[15px] text-muted-foreground leading-relaxed">
            For enterprise tools that require a sales call to access, I rely on documented features, third-party reviews from G2 and Capterra, customer case studies, and analyst reports - flagged as "limited hands-on" where applicable. Read the full <Link href="/methodology" className="text-blue-600 hover:underline font-medium">methodology</Link>.
          </p>
        </section>

        {articles.length > 0 && (
          <section className="mb-10">
            <h2 className="text-[20px] font-bold text-foreground mb-4">Recent articles by {author.name}</h2>
            <ul className="space-y-3">
              {articles.map(a => (
                <li key={a.slug}>
                  <Link href={`/blog/${a.slug}`} className="block p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors">
                    <p className="text-[11px] font-semibold text-blue-600 mb-1">{a.category} · {a.date} · {a.readTime}</p>
                    <p className="text-[15px] font-bold text-foreground leading-snug mb-1">{a.title}</p>
                    <p className="text-[13px] text-muted-foreground line-clamp-2 leading-snug">{a.excerpt}</p>
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        )}

        <section className="mb-10 p-5 rounded-xl border border-border bg-card">
          <h2 className="text-[14px] font-bold text-foreground uppercase tracking-wider mb-2">Conflicts of interest</h2>
          <p className="text-[13px] text-muted-foreground leading-relaxed">
            I do not see affiliate commission rates when scoring tools, by design. The team member who maintains affiliate relationships is separate from the team member writing reviews. A tool that pays MytheAi a higher commission rate can rank below a tool that pays nothing if the lower-commission tool scores higher on the seven criteria. If you find a ranking that looks suspicious, email <a href="mailto:info@mytheai.com" className="text-blue-600 hover:underline">info@mytheai.com</a> and I will publish the score breakdown.
          </p>
        </section>

        <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          See also: <Link href="/about" className="text-blue-600 hover:underline">About MytheAi</Link>
          <span className="mx-2">·</span>
          <Link href="/methodology" className="text-blue-600 hover:underline">Editorial methodology</Link>
          <span className="mx-2">·</span>
          <Link href="/transparency" className="text-blue-600 hover:underline">Transparency</Link>
        </div>

      </div>
    </>
  )
}
