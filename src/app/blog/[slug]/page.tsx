import { notFound } from 'next/navigation'
import Link from 'next/link'
import type { Metadata } from 'next'
import type { ComponentProps } from 'react'
import { MDXRemote } from 'next-mdx-remote/rsc'
import { readFileSync, readdirSync } from 'fs'
import { join } from 'path'
import matter from 'gray-matter'
import NewsletterForm from '@/components/newsletter/NewsletterForm'
import ScrollNewsletter from '@/components/newsletter/ScrollNewsletter'
import AuthorBio from '@/components/layout/AuthorBio'
import TLDRBox from '@/components/blog/TLDRBox'
import FAQBlock from '@/components/blog/FAQBlock'
import PricingTable from '@/components/blog/PricingTable'
import RelatedSEO from '@/components/blog/RelatedSEO'
import { getAuthorJsonLd, getAuthor } from '@/data/authors'
import { linkGlossary } from '@/lib/glossary-linker'
import { getBlogRelatedSEO } from '@/lib/related-seo'

export const revalidate = 604800

const CONTENT_DIR = join(process.cwd(), 'content/blog')

interface ArticleFrontmatter {
  title: string
  excerpt: string
  category: string
  date: string
  readTime: string
  author?: string
}

function getArticle(slug: string): (ArticleFrontmatter & { content: string }) | null {
  try {
    const raw = readFileSync(join(CONTENT_DIR, `${slug}.mdx`), 'utf-8')
    const { data, content } = matter(raw)
    return { ...(data as ArticleFrontmatter), content }
  } catch {
    return null
  }
}

function getRelatedPosts(currentSlug: string, currentCategory: string): (ArticleFrontmatter & { slug: string })[] {
  try {
    const files = readdirSync(CONTENT_DIR).filter(f => f.endsWith('.mdx'))
    return files
      .map(file => {
        const slug = file.replace('.mdx', '')
        const raw = readFileSync(join(CONTENT_DIR, file), 'utf-8')
        const { data } = matter(raw)
        return { slug, ...(data as ArticleFrontmatter) }
      })
      .filter(p => p.slug !== currentSlug && p.category === currentCategory)
      .slice(0, 2)
  } catch {
    return []
  }
}

const CATEGORY_COLORS: Record<string, string> = {
  Roundup: '#DBEAFE',
  Comparison: '#FEF3C7',
  Guide: '#D1FAE5',
}
const CATEGORY_TEXT: Record<string, string> = {
  Roundup: '#1E40AF',
  Comparison: '#92400E',
  Guide: '#065F46',
}

function renderLinkedString(text: string, keyPrefix: string) {
  return linkGlossary(text).map((seg, i) =>
    seg.type === 'link' ? (
      <Link key={`${keyPrefix}-${i}`} href={seg.href} className="text-blue-600/80 hover:text-blue-600 hover:underline border-b border-dotted border-blue-200 dark:border-blue-900">{seg.value}</Link>
    ) : (
      <span key={`${keyPrefix}-${i}`}>{seg.value}</span>
    )
  )
}

function GlossaryLinkedText({ children }: { children: React.ReactNode }) {
  // Auto-link glossary terms inside paragraphs. String children get linking;
  // non-text children (already-formatted Link, strong, etc.) pass through unchanged.
  // Children can be a single string, JSX element, or an array of mixed nodes.
  const arr = Array.isArray(children) ? children : [children]
  return (
    <>
      {arr.map((node, idx) => {
        if (typeof node === 'string') return <span key={idx}>{renderLinkedString(node, `g${idx}`)}</span>
        return <span key={idx}>{node}</span>
      })}
    </>
  )
}

const mdxComponents = {
  h2: (props: ComponentProps<'h2'>) => (
    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3" {...props} />
  ),
  p: ({ children, ...props }: ComponentProps<'p'>) => (
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4" {...props}>
      <GlossaryLinkedText>{children as React.ReactNode}</GlossaryLinkedText>
    </p>
  ),
  ul: (props: ComponentProps<'ul'>) => (
    <ul className="space-y-3 mb-6" {...props} />
  ),
  ol: (props: ComponentProps<'ol'>) => (
    <ol className="space-y-2 mb-4 list-decimal list-inside text-[15px] text-muted-foreground" {...props} />
  ),
  li: (props: ComponentProps<'li'>) => (
    <li className="text-[15px] text-muted-foreground leading-relaxed" {...props} />
  ),
  a: ({ href, children }: ComponentProps<'a'>) => (
    <Link href={href ?? '#'} className="text-blue-600 hover:underline">{children}</Link>
  ),
  strong: (props: ComponentProps<'strong'>) => (
    <strong className="text-foreground font-semibold" {...props} />
  ),
  blockquote: (props: ComponentProps<'blockquote'>) => (
    <blockquote className="text-[14px] font-semibold text-foreground mb-6 pl-4 border-l-2 border-blue-400 not-italic" {...props} />
  ),
  TLDRBox,
  FAQBlock,
  PricingTable,
}

export function generateStaticParams() {
  try {
    return readdirSync(CONTENT_DIR)
      .filter(f => f.endsWith('.mdx'))
      .map(f => ({ slug: f.replace('.mdx', '') }))
  } catch {
    return []
  }
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const article = getArticle(slug)
  if (!article) return {}
  const articleYear = new Date(article.date).getFullYear() || new Date().getFullYear()
  const titleWithYear = `${article.title} (${articleYear}) | MytheAi Blog`
  const ogImage = `https://mytheai.com/api/og/blog?title=${encodeURIComponent(article.title)}&category=${encodeURIComponent(article.category)}`
  return {
    title: titleWithYear,
    description: article.excerpt,
    alternates: { canonical: `https://mytheai.com/blog/${slug}` },
    openGraph: {
      title: titleWithYear,
      description: article.excerpt,
      url: `https://mytheai.com/blog/${slug}`,
      type: 'article',
      images: [{ url: ogImage, width: 1200, height: 630, alt: article.title }],
    },
    twitter: {
      card: 'summary_large_image',
      title: titleWithYear,
      description: article.excerpt,
      images: [ogImage],
    },
  }
}

export default async function BlogPostPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const article = getArticle(slug)
  if (!article) notFound()

  const related = getRelatedPosts(slug, article.category)
  const relatedSEO = getBlogRelatedSEO(slug)

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'Blog', item: 'https://mytheai.com/blog' },
      { '@type': 'ListItem', position: 3, name: article.title, item: `https://mytheai.com/blog/${slug}` },
    ],
  }

  const author = getAuthor(article.author)
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BlogPosting',
    headline: article.title,
    description: article.excerpt,
    url: `https://mytheai.com/blog/${slug}`,
    datePublished: article.date,
    dateModified: article.date,
    author: getAuthorJsonLd(article.author),
    publisher: {
      '@type': 'Organization',
      name: 'MytheAi',
      url: 'https://mytheai.com',
      logo: { '@type': 'ImageObject', url: 'https://mytheai.com/icon-512.png', width: 512, height: 512 },
    },
    mainEntityOfPage: { '@type': 'WebPage', '@id': `https://mytheai.com/blog/${slug}` },
    image: `https://mytheai.com/api/og/blog?title=${encodeURIComponent(article.title)}&category=${encodeURIComponent(article.category)}`,
    articleSection: article.category,
  }

  // HowTo schema for listicle blogs ("Best X Tools 2026") - extract H2 headings as steps
  // Eligible for HowTo rich result on Google SERP, big CTR boost
  const isListicle = /^best\s+/i.test(article.title) || /how\s+to/i.test(article.title)
  const h2Headings = isListicle
    ? [...article.content.matchAll(/^##\s+(.+)$/gm)]
        .map(m => m[1].trim())
        .filter(h => !/^(faq|frequently|conclusion|summary|tldr|tl;dr|methodology|sources|footnotes?)/i.test(h))
        .slice(0, 12)
    : []
  const howToJsonLd = h2Headings.length >= 3 ? {
    '@context': 'https://schema.org',
    '@type': 'HowTo',
    name: article.title,
    description: article.excerpt,
    totalTime: 'PT' + Math.max(5, parseInt(article.readTime) || 8) + 'M',
    step: h2Headings.map((heading, i) => ({
      '@type': 'HowToStep',
      position: i + 1,
      name: heading,
      url: `https://mytheai.com/blog/${slug}#${heading.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '')}`,
    })),
  } : null

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }} />
      {howToJsonLd && <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(howToJsonLd) }} />}
    <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

      {/* Breadcrumb */}
      <nav className="flex items-center gap-2 text-[12px] text-muted-foreground mb-8">
        <Link href="/" className="hover:text-foreground transition-colors">Home</Link>
        <span>/</span>
        <Link href="/blog" className="hover:text-foreground transition-colors">Blog</Link>
        <span>/</span>
        <span className="text-foreground truncate">{article.title}</span>
      </nav>

      {/* Article header */}
      <header className="mb-8">
        <div className="flex items-center gap-3 mb-4">
          <span
            className="text-[11px] font-semibold px-2 py-0.5 rounded-full"
            style={{
              background: CATEGORY_COLORS[article.category] ?? '#F3F4F6',
              color: CATEGORY_TEXT[article.category] ?? '#374151',
            }}
          >
            {article.category}
          </span>
          <span className="text-[12px] text-muted-foreground">{article.date}</span>
          <span className="text-[12px] text-muted-foreground">·</span>
          <span className="text-[12px] text-muted-foreground">{article.readTime}</span>
        </div>

        <h1 className="text-[26px] md:text-[32px] font-extrabold tracking-tight text-foreground leading-tight mb-4">
          {article.title}
        </h1>
        <p className="text-[16px] text-muted-foreground leading-relaxed mb-4">
          {article.excerpt}
        </p>
        <p className="text-[13px] text-muted-foreground">
          By <Link href={`/authors/${author.slug}`} className="text-blue-600 hover:underline font-medium">{author.name}</Link>, {author.role}
        </p>
      </header>

      {/* Affiliate disclosure */}
      <div className="mb-8 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
        <strong>Disclosure:</strong> Some links in this article are affiliate links. We may earn a commission at no extra cost to you. Our editorial rankings are never influenced by affiliate relationships.
      </div>

      <hr className="border-border mb-8" />

      {/* Article content */}
      <article>
        <MDXRemote source={article.content} components={mdxComponents} />
      </article>

      {/* Inline newsletter capture (high-engagement moment after read) */}
      <div className="mt-10 p-6 rounded-xl border-2 border-blue-100 dark:border-blue-900/40 bg-blue-50/50 dark:bg-blue-950/20">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-700 dark:text-blue-300 mb-1">Weekly Picks</p>
        <h3 className="text-[18px] font-bold text-foreground mb-2">Get the best AI tools in your inbox</h3>
        <p className="text-[14px] text-muted-foreground mb-4">
          Every Tuesday: 5 hand-picked tools, new launches worth trying, and honest takes. No spam, unsubscribe anytime.
        </p>
        <NewsletterForm />
      </div>

      {/* Compare tools CTA */}
      <div className="mt-10 p-5 rounded-xl border border-[#BFDBFE] bg-[#EFF6FF]">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#1E40AF] mb-1">Compare AI Tools</p>
        <p className="text-[14px] text-[#1E40AF] mb-3">
          Evaluating tools mentioned in this article? See our in-depth side-by-side comparisons.
        </p>
        <Link
          href="/compare"
          className="inline-block px-4 py-2 rounded-lg bg-blue-600 text-white text-[13px] font-semibold hover:bg-blue-700 transition-colors"
        >
          Browse all comparisons →
        </Link>
      </div>

      {/* Related programmatic SEO pages - alternatives + free tools */}
      <RelatedSEO target={relatedSEO} />

      <hr className="border-border mt-10 mb-8" />

      {/* Author */}
      <div className="mb-10">
        <AuthorBio context="written" authorSlug={article.author} />
      </div>

      {/* Related posts */}
      {related.length > 0 && (
        <div className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-4">Related Articles</p>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {related.map(post => (
              <Link
                key={post.slug}
                href={`/blog/${post.slug}`}
                className="block border border-border rounded-xl p-4 bg-card hover:border-[#93C5FD] transition-colors"
              >
                <span
                  className="text-[10px] font-semibold px-2 py-0.5 rounded-full inline-block mb-2"
                  style={{
                    background: CATEGORY_COLORS[post.category] ?? '#F3F4F6',
                    color: CATEGORY_TEXT[post.category] ?? '#374151',
                  }}
                >
                  {post.category}
                </span>
                <p className="text-[14px] font-bold text-foreground leading-snug mb-1">{post.title}</p>
                <p className="text-[12px] text-muted-foreground line-clamp-2">{post.excerpt}</p>
                <p className="text-[11px] text-muted-foreground mt-2">{post.readTime}</p>
              </Link>
            ))}
          </div>
        </div>
      )}

      {/* Footer CTA */}
      <div className="flex flex-col sm:flex-row gap-3">
        <Link
          href="/blog"
          className="px-4 py-2 rounded-lg border border-border text-[13px] font-medium text-muted-foreground hover:border-blue-300 hover:text-blue-600 transition-colors text-center"
        >
          ← Back to Blog
        </Link>
        <Link
          href="/tools"
          className="px-4 py-2 rounded-lg bg-blue-600 text-[13px] font-semibold text-white hover:bg-blue-700 transition-colors text-center"
        >
          Browse All AI Tools →
        </Link>
      </div>
    </div>
    <ScrollNewsletter />
    </>
  )
}
