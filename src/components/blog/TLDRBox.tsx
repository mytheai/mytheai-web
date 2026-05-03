import type { ReactNode } from 'react'

interface Props {
  title?: string
  children: ReactNode
}

export default function TLDRBox({ title = 'TL;DR', children }: Props) {
  return (
    <div className="mb-8 p-5 rounded-xl border-2 border-blue-100 dark:border-blue-900/40 bg-blue-50/50 dark:bg-blue-950/20">
      <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-700 dark:text-blue-300 mb-2">{title}</p>
      <div className="text-[15px] text-foreground leading-relaxed [&>p]:mb-2 [&>p:last-child]:mb-0 [&>ul]:list-disc [&>ul]:ml-5 [&>ul]:space-y-1">
        {children}
      </div>
    </div>
  )
}
