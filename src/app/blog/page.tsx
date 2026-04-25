import type { Metadata } from 'next'

export const revalidate = 604800

export const metadata: Metadata = {
  title: 'Blog — AI Tools Guides & News | MytheAi',
  description: 'Guides, comparisons, and news about AI & SaaS tools. Learn how to build your AI stack, compare top tools, and stay ahead of the curve.',
  alternates: { canonical: 'https://mytheai.com/blog' },
  openGraph: {
    title: 'Blog — AI Tools Guides & News | MytheAi',
    url: 'https://mytheai.com/blog',
  },
}

const POSTS = [
  {
    slug: 'best-free-ai-tools-2026',
    title: 'Best Free AI Tools in 2026 (No Credit Card Required)',
    excerpt: 'A curated list of the best AI tools you can start using today for free — covering writing, image generation, coding, productivity, and more.',
    category: 'Roundup',
    date: 'April 20, 2026',
    readTime: '6 min read',
  },
  {
    slug: 'chatgpt-vs-claude',
    title: 'ChatGPT vs Claude: Which AI Assistant Is Better in 2026?',
    excerpt: "We put OpenAI's ChatGPT and Anthropic's Claude head to head across writing, reasoning, coding, and pricing. Here's what we found.",
    category: 'Comparison',
    date: 'April 15, 2026',
    readTime: '8 min read',
  },
  {
    slug: 'how-to-build-your-ai-stack',
    title: 'How to Build the Perfect AI Stack for Your Workflow',
    excerpt: 'The right combination of AI tools can 10x your output. Here is how to pick tools that complement each other without overlapping — for any role or budget.',
    category: 'Guide',
    date: 'April 8, 2026',
    readTime: '7 min read',
  },
]

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

export default function BlogPage() {
  return (
    <div className="max-w-4xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">Insights</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          Blog
        </h1>
        <p className="text-[15px] text-muted-foreground">
          Guides, tool comparisons, and AI news — written for professionals who want signal, not noise.
        </p>
      </div>

      <div className="space-y-6">
        {POSTS.map(post => (
          <article
            key={post.slug}
            className="border border-border rounded-xl p-6 bg-card hover:border-[#93C5FD] transition-colors"
          >
            <div className="flex items-center gap-3 mb-3">
              <span
                className="text-[11px] font-semibold px-2 py-0.5 rounded-full"
                style={{ background: CATEGORY_COLORS[post.category], color: CATEGORY_TEXT[post.category] }}
              >
                {post.category}
              </span>
              <span className="text-[12px] text-muted-foreground">{post.date}</span>
              <span className="text-[12px] text-muted-foreground">·</span>
              <span className="text-[12px] text-muted-foreground">{post.readTime}</span>
            </div>

            <h2 className="text-[18px] font-bold text-foreground mb-2 leading-snug">
              {post.title}
            </h2>
            <p className="text-[14px] text-muted-foreground leading-relaxed mb-4">
              {post.excerpt}
            </p>

            <span className="text-[13px] font-semibold text-muted-foreground cursor-default">
              Coming soon
            </span>
          </article>
        ))}
      </div>

      <div className="mt-12 border border-border rounded-xl p-6 bg-card text-center">
        <p className="text-[14px] font-semibold text-foreground mb-1">More articles coming soon</p>
        <p className="text-[13px] text-muted-foreground">
          Subscribe to our newsletter to get new guides and tool reviews delivered to your inbox.
        </p>
      </div>
    </div>
  )
}
