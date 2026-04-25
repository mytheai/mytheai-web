import { notFound } from 'next/navigation'
import Link from 'next/link'
import type { Metadata } from 'next'

export const revalidate = 604800

// --- Article definitions ---

interface Article {
  slug: string
  title: string
  excerpt: string
  category: string
  date: string
  readTime: string
  content: React.ReactNode
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

// --- Article content ---

const ArticleBestFreeAiTools = (
  <div className="prose-article">
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      The best AI tools used to cost hundreds of dollars a month. In 2026, most of the leading platforms offer
      generous free tiers — no credit card required. Whether you need help with writing, image generation,
      coding, or research, there is a free AI tool that can handle it.
    </p>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-8">
      This list covers the tools we actually use and recommend — tested across categories, ranked by
      quality of the free tier, not by affiliate commission.
    </p>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">Best Free AI Assistants</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-3">
      General-purpose AI assistants are the Swiss Army knives of the AI world. These three are the best
      you can use without spending a cent.
    </p>
    <ul className="space-y-3 mb-6">
      <li className="text-[15px] text-muted-foreground leading-relaxed">
        <strong className="text-foreground"><Link href="/tools/claude" className="text-blue-600 hover:underline">Claude</Link></strong>{' '}
        — Anthropic&apos;s flagship model. The free tier gives you access to Claude 3.5 Sonnet with a
        200K token context window — ideal for long documents, complex research, and nuanced writing.
        Notably strong at following detailed instructions and producing clean, structured output.
      </li>
      <li className="text-[15px] text-muted-foreground leading-relaxed">
        <strong className="text-foreground"><Link href="/tools/chatgpt" className="text-blue-600 hover:underline">ChatGPT</Link></strong>{' '}
        — OpenAI&apos;s free tier includes GPT-4o with limited daily usage. The standout advantage is
        the plugin and GPT ecosystem — thousands of purpose-built tools available directly inside the
        interface, from PDF readers to code interpreters.
      </li>
      <li className="text-[15px] text-muted-foreground leading-relaxed">
        <strong className="text-foreground"><Link href="/tools/perplexity" className="text-blue-600 hover:underline">Perplexity AI</Link></strong>{' '}
        — The best free AI for real-time research. Perplexity searches the web and cites every source
        directly in its response, making it far more trustworthy than standard LLMs for factual queries.
        Free tier is surprisingly capable with unlimited standard searches.
      </li>
    </ul>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">Best Free AI Writing Tools</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-3">
      If you create content, these tools will save you significant time without costing anything to start.
    </p>
    <ul className="space-y-3 mb-6">
      <li className="text-[15px] text-muted-foreground leading-relaxed">
        <strong className="text-foreground"><Link href="/tools/grammarly" className="text-blue-600 hover:underline">Grammarly</Link></strong>{' '}
        — The most-used writing tool in the world for good reason. The free browser extension catches
        grammar, spelling, and tone issues in real time across every site you write on. The free tier
        is genuinely useful without needing a paid plan for basic editing.
      </li>
      <li className="text-[15px] text-muted-foreground leading-relaxed">
        <strong className="text-foreground"><Link href="/tools/copy-ai" className="text-blue-600 hover:underline">Copy.ai</Link></strong>{' '}
        — Offers a free plan with access to over 90 copywriting templates covering everything from
        social captions to email subject lines. If you write marketing copy regularly, the free tier
        gives you enough headroom to test the platform properly before committing.
      </li>
    </ul>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">Best Free AI Image Generators</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-3">
      You no longer need to pay for stock photos or hire a designer for basic visuals. These tools give
      you high-quality AI image generation for free.
    </p>
    <ul className="space-y-3 mb-6">
      <li className="text-[15px] text-muted-foreground leading-relaxed">
        <strong className="text-foreground"><Link href="/tools/canva-ai" className="text-blue-600 hover:underline">Canva AI</Link></strong>{' '}
        — Canva&apos;s free plan includes access to its AI image generator, text-to-image tools, and
        thousands of templates. The combination of design tools and AI generation in one platform makes
        it the most practical free option for non-designers creating content for social, presentations,
        or marketing.
      </li>
      <li className="text-[15px] text-muted-foreground leading-relaxed">
        <strong className="text-foreground"><Link href="/tools/leonardo-ai" className="text-blue-600 hover:underline">Leonardo AI</Link></strong>{' '}
        — A powerful alternative for users who want more creative control. Leonardo&apos;s free tier
        includes 150 tokens daily, access to multiple fine-tuned models, and a canvas editor. The
        output quality rivals Midjourney for many styles, and the interface is built for creative
        professionals.
      </li>
    </ul>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">Best Free AI Coding Tools</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-3">
      AI has transformed software development. These tools are free to start and genuinely accelerate
      how fast you can write, review, and debug code.
    </p>
    <ul className="space-y-3 mb-6">
      <li className="text-[15px] text-muted-foreground leading-relaxed">
        <strong className="text-foreground"><Link href="/tools/github-copilot" className="text-blue-600 hover:underline">GitHub Copilot</Link></strong>{' '}
        — Free for individual developers and open-source contributors. The VS Code extension provides
        inline code completions, multi-line suggestions, and a chat interface with full codebase context.
        For professional developers, this is the highest-value free tool on this list.
      </li>
      <li className="text-[15px] text-muted-foreground leading-relaxed">
        <strong className="text-foreground"><Link href="/tools/replit" className="text-blue-600 hover:underline">Replit</Link></strong>{' '}
        — A browser-based IDE with an AI coding assistant built in. The free tier gives you a full
        development environment accessible from any device, making it ideal for beginners, students,
        or developers who need to code without a local setup.
      </li>
    </ul>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">How to Build Your Free AI Stack</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      The most effective approach is not to use one tool for everything — it is to combine 2–3 specialized
      tools that each excel in their category. A practical starting stack:
    </p>
    <ul className="space-y-2 mb-6 list-disc list-inside text-[15px] text-muted-foreground">
      <li>Claude or ChatGPT for general reasoning and writing assistance</li>
      <li>Perplexity for research and real-time fact-checking</li>
      <li>Grammarly for editing and proofreading</li>
      <li>Canva AI for visual content</li>
      <li>GitHub Copilot if you write code</li>
    </ul>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      All five tools above are free to start. Once you know which ones you use most, it becomes much
      clearer which paid upgrades are worth it.
    </p>
    <p className="text-[15px] text-muted-foreground leading-relaxed">
      Browse the full list of free and freemium tools in our directory:{' '}
      <Link href="/tools?pricing=free" className="text-blue-600 hover:underline">Free AI Tools →</Link>
    </p>
  </div>
)

const ArticleChatgptVsClaude = (
  <div className="prose-article">
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      ChatGPT and Claude are the two most capable general-purpose AI assistants available in 2026.
      Both are built on frontier language models, both offer free tiers, and both are used by millions
      of professionals worldwide. But they are meaningfully different tools — and the right choice
      depends heavily on how you plan to use them.
    </p>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-8">
      We tested both across writing, coding, research, and reasoning tasks over several weeks. Here
      is what we found.
    </p>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">Writing Quality</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      Both tools produce strong prose, but with a different character. Claude tends to write with more
      nuance and restraint — it is less likely to produce filler content and more likely to push back
      when a prompt is ambiguous. ChatGPT is more enthusiastic, which can be an advantage for
      marketing copy but a liability for analytical writing.
    </p>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      For long-form content — reports, articles, structured documents — Claude&apos;s 200K token context
      window is a significant advantage. You can paste an entire book and ask questions about it.
      ChatGPT-4o supports 128K tokens, which is sufficient for most tasks but not all.
    </p>
    <p className="text-[14px] font-semibold text-foreground mb-6">
      Verdict: Claude edges ahead for analytical and long-form writing. ChatGPT for conversational and
      marketing copy.
    </p>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">Coding Ability</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      This is where the competition is closest. Both models can write, review, and debug code across
      most languages. In our testing, Claude produced slightly cleaner, more idiomatic code for
      complex tasks — particularly multi-file refactoring and architecture decisions.
    </p>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      ChatGPT has an advantage in the ecosystem: the Code Interpreter plugin and integration with
      GitHub Copilot give it more practical coding utilities. Claude is stronger at pure code reasoning;
      ChatGPT is stronger at code tooling.
    </p>
    <p className="text-[14px] font-semibold text-foreground mb-6">
      Verdict: Claude for raw code quality. ChatGPT for integrated developer workflows.
    </p>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">Reasoning & Research</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      For complex multi-step reasoning — evaluating arguments, stress-testing assumptions, working
      through logical problems — Claude is demonstrably stronger. It is also more reliable about saying
      &ldquo;I don&apos;t know&rdquo; rather than confabulating a plausible-sounding but wrong answer.
    </p>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      For research with live web data, neither ChatGPT nor Claude (without plugins) has real-time access
      by default. ChatGPT&apos;s web browsing plugin and the Perplexity integration help here. We
      recommend using{' '}
      <Link href="/tools/perplexity" className="text-blue-600 hover:underline">Perplexity AI</Link>{' '}
      alongside either model for any research requiring current information.
    </p>
    <p className="text-[14px] font-semibold text-foreground mb-6">
      Verdict: Claude for reasoning depth and reliability. ChatGPT for real-time research with plugins.
    </p>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">Pricing</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      Both tools offer a free tier and a $20/month Pro tier. The free tier quality is roughly equivalent
      — both give you access to a capable but rate-limited version of their flagship model.
    </p>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
      At the Pro level ($20/month), Claude Pro and ChatGPT Plus offer different value propositions.
      Claude Pro gives you significantly higher usage limits on Claude 3.5 Sonnet and early access to
      new Claude models. ChatGPT Plus gives you access to GPT-4o, DALL-E 3 image generation, and
      the full plugin store. If you need image generation, ChatGPT Plus wins on value. If you are a
      heavy writer or analyst, Claude Pro wins.
    </p>
    <p className="text-[14px] font-semibold text-foreground mb-6">
      Verdict: Comparable pricing. ChatGPT Plus wins if you need image generation. Claude Pro wins
      for text-heavy workloads.
    </p>

    <h2 className="text-[20px] font-bold text-foreground mt-8 mb-3">Which Should You Choose?</h2>
    <p className="text-[15px] text-muted-foreground leading-relaxed mb-3">
      There is no universal answer — both are excellent. Here is how to decide:
    </p>
    <ul className="space-y-2 mb-4 text-[15px] text-muted-foreground">
      <li><strong className="text-foreground">Choose Claude if:</strong> you do a lot of long-form writing, work with large documents, need strong instruction-following, or value a more thoughtful, measured response style.</li>
      <li><strong className="text-foreground">Choose ChatGPT if:</strong> you want image generation (DALL-E 3), need a large plugin ecosystem, work with code tools and integrations, or prefer a more conversational assistant.</li>
      <li><strong className="text-foreground">Use both:</strong> Many professionals use Claude for focused analytical work and ChatGPT for creative and tool-assisted tasks. Both have free tiers — there is no reason to commit to just one.</li>
    </ul>
    <p className="text-[15px] text-muted-foreground leading-relaxed">
      Read our full side-by-side breakdown:{' '}
      <Link href="/compare/claude-vs-chatgpt" className="text-blue-600 hover:underline">Claude vs ChatGPT — Full Comparison →</Link>
      {' '}or visit the individual tool pages:{' '}
      <Link href="/tools/claude" className="text-blue-600 hover:underline">Claude</Link>
      {' / '}
      <Link href="/tools/chatgpt" className="text-blue-600 hover:underline">ChatGPT</Link>
    </p>
  </div>
)

// --- Article registry ---

const ARTICLES: Article[] = [
  {
    slug: 'best-free-ai-tools-2026',
    title: 'Best Free AI Tools in 2026 (No Credit Card Required)',
    excerpt: 'A curated list of the best AI tools you can start using today for free — covering writing, image generation, coding, productivity, and more.',
    category: 'Roundup',
    date: 'April 20, 2026',
    readTime: '6 min read',
    content: ArticleBestFreeAiTools,
  },
  {
    slug: 'chatgpt-vs-claude',
    title: 'ChatGPT vs Claude: Which AI Assistant Is Better in 2026?',
    excerpt: "We put OpenAI's ChatGPT and Anthropic's Claude head to head across writing, reasoning, coding, and pricing. Here's what we found.",
    category: 'Comparison',
    date: 'April 15, 2026',
    readTime: '8 min read',
    content: ArticleChatgptVsClaude,
  },
]

// --- Next.js route functions ---

export function generateStaticParams() {
  return ARTICLES.map(a => ({ slug: a.slug }))
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const article = ARTICLES.find(a => a.slug === slug)
  if (!article) return {}
  return {
    title: `${article.title} | MytheAi Blog`,
    description: article.excerpt,
    alternates: { canonical: `https://mytheai.com/blog/${article.slug}` },
    openGraph: {
      title: `${article.title} | MytheAi Blog`,
      description: article.excerpt,
      url: `https://mytheai.com/blog/${article.slug}`,
      type: 'article',
    },
  }
}

export default async function BlogPostPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const article = ARTICLES.find(a => a.slug === slug)
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
              background: CATEGORY_COLORS[article.category],
              color: CATEGORY_TEXT[article.category],
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
        {article.content}
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
