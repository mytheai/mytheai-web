'use client'

import { useEffect } from 'react'
import Link from 'next/link'

export default function Error({
  error,
  unstable_retry,
}: {
  error: Error & { digest?: string }
  unstable_retry: () => void
}) {
  useEffect(() => {
    if (typeof window !== 'undefined') {
      console.error(error)
    }
  }, [error])

  return (
    <div className="max-w-xl mx-auto px-4 md:px-5 py-20 text-center">
      <div className="text-5xl mb-4" aria-hidden="true">⚠️</div>
      <h1 className="text-[26px] md:text-[32px] font-extrabold tracking-tight text-foreground mb-3">
        Something went wrong
      </h1>
      <p className="text-[15px] text-muted-foreground leading-relaxed mb-8 max-w-md mx-auto">
        We hit an unexpected snag loading this page. Try again, or head back to the homepage and search for what you need.
      </p>

      <div className="flex flex-col sm:flex-row items-center justify-center gap-3">
        <button
          onClick={() => unstable_retry()}
          className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-[14px] transition-colors"
        >
          Try again
        </button>
        <Link
          href="/"
          className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg border border-border bg-card hover:border-blue-400 text-foreground font-semibold text-[14px] transition-colors"
        >
          Go to homepage
        </Link>
      </div>

      {error.digest && (
        <p className="mt-8 text-[12px] text-muted-foreground">
          Error reference: <code className="px-1.5 py-0.5 rounded bg-gray-100 dark:bg-gray-800 font-mono text-[11px]">{error.digest}</code>
        </p>
      )}
    </div>
  )
}
