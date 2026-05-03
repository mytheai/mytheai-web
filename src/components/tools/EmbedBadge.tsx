'use client'
import { useState } from 'react'

interface Props {
  slug: string
  name: string
}

export default function EmbedBadge({ slug, name }: Props) {
  const [copied, setCopied] = useState(false)
  const url = `https://mytheai.com/tools/${slug}`
  const badgeSrc = `https://mytheai.com/api/badge/${slug}`
  const html = `<a href="${url}" target="_blank" rel="noopener noreferrer"><img src="${badgeSrc}" alt="Featured on MytheAi - ${name}" width="320" height="80" /></a>`
  const markdown = `[![Featured on MytheAi](${badgeSrc})](${url})`

  function copy(text: string) {
    navigator.clipboard.writeText(text)
    setCopied(true)
    setTimeout(() => setCopied(false), 2000)
  }

  return (
    <details className="my-6 group rounded-xl border border-border bg-card overflow-hidden">
      <summary className="flex items-center justify-between gap-3 px-5 py-3 cursor-pointer list-none hover:bg-gray-50 dark:hover:bg-gray-900/40 transition-colors">
        <span className="text-[13px] font-semibold text-foreground">For {name} team: embed our badge</span>
        <svg className="w-4 h-4 text-muted-foreground transition-transform group-open:rotate-180 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24" aria-hidden="true">
          <polyline points="6 9 12 15 18 9" />
        </svg>
      </summary>

      <div className="px-5 pb-5 pt-1 space-y-4">
        <p className="text-[13px] text-muted-foreground leading-relaxed">
          Are you on the {name} team? Add this badge to your website to show you are listed on MytheAi. Free, no permission needed.
        </p>

        <div className="flex items-center justify-center py-3 bg-gray-50 dark:bg-gray-900/40 rounded-lg">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src={badgeSrc} alt={`Featured on MytheAi - ${name}`} width="320" height="80" />
        </div>

        <div>
          <div className="flex items-center justify-between mb-1">
            <p className="text-[11px] font-semibold text-muted-foreground uppercase tracking-wider">HTML</p>
            <button onClick={() => copy(html)} className="text-[11px] font-semibold text-blue-600 hover:underline">
              {copied ? 'Copied' : 'Copy'}
            </button>
          </div>
          <pre className="text-[11px] text-foreground font-mono p-3 bg-gray-50 dark:bg-gray-900/40 rounded-lg overflow-x-auto whitespace-pre-wrap break-all">{html}</pre>
        </div>

        <div>
          <div className="flex items-center justify-between mb-1">
            <p className="text-[11px] font-semibold text-muted-foreground uppercase tracking-wider">Markdown</p>
            <button onClick={() => copy(markdown)} className="text-[11px] font-semibold text-blue-600 hover:underline">
              {copied ? 'Copied' : 'Copy'}
            </button>
          </div>
          <pre className="text-[11px] text-foreground font-mono p-3 bg-gray-50 dark:bg-gray-900/40 rounded-lg overflow-x-auto whitespace-pre-wrap break-all">{markdown}</pre>
        </div>
      </div>
    </details>
  )
}
