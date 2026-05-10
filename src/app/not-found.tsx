import Link from 'next/link'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Page Not Found (404) | MytheAi',
  description: 'The page you are looking for does not exist or has been moved. Browse the AI tools directory, top 10 lists, or use search.',
}

export default function NotFound() {
  return (
    <div className="max-w-xl mx-auto px-4 md:px-5 py-20 text-center">
      <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">404</p>
      <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
        Page not found
      </h1>
      <p className="text-[15px] text-muted-foreground leading-relaxed mb-8 max-w-md mx-auto">
        The page you are looking for does not exist or has been moved. Try one of the popular destinations below.
      </p>

      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 mb-8">
        <Link
          href="/tools"
          className="px-4 py-3 rounded-lg border border-border bg-card hover:border-blue-400 hover:bg-blue-50/50 dark:hover:bg-blue-950/30 text-foreground font-semibold text-[14px] transition-colors"
        >
          Browse tools
        </Link>
        <Link
          href="/top-10"
          className="px-4 py-3 rounded-lg border border-border bg-card hover:border-blue-400 hover:bg-blue-50/50 dark:hover:bg-blue-950/30 text-foreground font-semibold text-[14px] transition-colors"
        >
          Top 10 lists
        </Link>
        <Link
          href="/compare"
          className="px-4 py-3 rounded-lg border border-border bg-card hover:border-blue-400 hover:bg-blue-50/50 dark:hover:bg-blue-950/30 text-foreground font-semibold text-[14px] transition-colors"
        >
          Compare tools
        </Link>
      </div>

      <Link
        href="/"
        className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[14px] transition-colors"
      >
        Go to homepage
      </Link>
    </div>
  )
}
