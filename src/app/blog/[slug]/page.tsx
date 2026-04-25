import { notFound } from 'next/navigation'
import Link from 'next/link'
import type { Metadata } from 'next'
import type { ComponentProps } from 'react'
import { MDXRemote } from 'next-mdx-remote/rsc'
import { readFileSync, readdirSync } from 'fs'
import { join } from 'path'
import matter from 'gray-matter'

export const revalidate = 604800

const CONTENT_DIR = join(process.cwd(), 'content/blog')

interface ArticleFrontmatter {
  title: string
  excerpt: string
  category: string
  date: string
  readTime: string
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

const mdxComponents = {
  h2: (props: ComponentProps<'h2'>) => (
    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3" {...props} />
  ),
  p: (props: ComponentProps<'p'>) => (
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4" {...props} />
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
  return {
    title: `${article.title} | MytheAi Blog`,
    description: article.excerpt,
    alternates: { canonical: `https://mytheai.com/blog/${slug}` },
    openGraph: {
      title: `${article.title} | MytheAi Blog`,
      description: article.excerpt,
      url: `https://mytheai.com/blog/${slug}`,
      type: 'article',
    },
  }
}

export default async function BlogPostPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const article = getArticle(slug)
  if (!article) notFound()

  return (
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
        <p className="text-[16px] text-muted-foreground leading-relaxed">
          {article.excerpt}
        </p>
      </header>

      <hr className="border-border mb-8" />

      {/* Article content */}
      <article>
        <MDXRemote source={article.content} components={mdxComponents} />
      </article>

      <hr className="border-border mt-12 mb-8" />

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
  )
}
