import type { Metadata } from 'next'
import { readFileSync, readdirSync } from 'fs'
import { join } from 'path'
import matter from 'gray-matter'
import BlogGrid from './BlogGrid'
import type { PostMeta } from './BlogGrid'

export const revalidate = 604800

export const metadata: Metadata = {
  title: 'Blog: AI Tools Guides & News | MytheAi',
  description: 'Guides, comparisons, and news about AI and SaaS tools. Learn how to build your AI stack, compare top tools, and stay ahead of the curve.',
  alternates: { canonical: 'https://mytheai.com/blog' },
  openGraph: {
    title: 'Blog: AI Tools Guides & News | MytheAi',
    url: 'https://mytheai.com/blog',
  },
}

const CONTENT_DIR = join(process.cwd(), 'content/blog')

function getAllPosts(): PostMeta[] {
  try {
    const files = readdirSync(CONTENT_DIR).filter(f => f.endsWith('.mdx'))
    const posts = files.map(file => {
      const slug = file.replace('.mdx', '')
      const raw = readFileSync(join(CONTENT_DIR, file), 'utf-8')
      const { data } = matter(raw)
      return { slug, ...(data as Omit<PostMeta, 'slug'>) }
    })
    return posts.sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
  } catch {
    return []
  }
}

const collectionSchema = {
  '@context': 'https://schema.org',
  '@type': 'CollectionPage',
  name: 'MytheAi Blog: AI Tools Guides & News',
  description: 'Guides, comparisons, and news about AI and SaaS tools. Learn how to build your AI stack, compare top tools, and stay ahead of the curve.',
  url: 'https://mytheai.com/blog',
  publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
}

export default function BlogPage() {
  const posts = getAllPosts()

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(collectionSchema) }} />
    <div className="max-w-4xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">Insights</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          Blog
        </h1>
        <p className="text-[15px] text-muted-foreground">
          Guides, tool comparisons, and AI news. Written for professionals who want signal, not noise.
        </p>
      </div>

      <BlogGrid posts={posts} />

      <div className="mt-12 border border-border rounded-xl p-6 bg-card text-center">
        <p className="text-[14px] font-semibold text-foreground mb-1">More articles coming soon</p>
        <p className="text-[13px] text-muted-foreground">
          Subscribe to our newsletter to get new guides and tool reviews delivered to your inbox.
        </p>
      </div>
    </div>
    </>
  )
}
