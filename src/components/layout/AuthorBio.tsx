import Link from 'next/link'

interface AuthorBioProps {
  context?: 'reviewed' | 'written' | 'curated'
  className?: string
}

const LABEL: Record<NonNullable<AuthorBioProps['context']>, string> = {
  reviewed: 'Reviewed by',
  written: 'Written by',
  curated: 'Curated by',
}

export default function AuthorBio({ context = 'curated', className = '' }: AuthorBioProps) {
  return (
    <div
      className={`flex items-start gap-4 p-5 rounded-xl border border-border bg-card ${className}`}
      itemScope
      itemType="https://schema.org/Person"
    >
      <svg
        width="48"
        height="48"
        viewBox="0 0 32 32"
        fill="none"
        className="w-12 h-12 rounded-xl flex-shrink-0"
        aria-label="John Ethan, founder of MytheAi"
        role="img"
      >
        <defs>
          <linearGradient id="author-bio-grad" x1="0" y1="0" x2="32" y2="32" gradientUnits="userSpaceOnUse">
            <stop offset="0%" stopColor="#60A5FA" />
            <stop offset="100%" stopColor="#1D4ED8" />
          </linearGradient>
        </defs>
        <rect width="32" height="32" rx="8" fill="url(#author-bio-grad)" />
        <path d="M16 4 L19 13 L28 16 L19 19 L16 28 L13 19 L4 16 L13 13 Z" fill="white" />
      </svg>
      <div className="flex-1 min-w-0">
        <p className="text-[12px] text-muted-foreground mb-0.5">{LABEL[context]}</p>
        <p className="text-[14px] font-bold text-foreground" itemProp="name">
          John Ethan
        </p>
        <p className="text-[12px] text-muted-foreground mt-1 leading-relaxed" itemProp="description">
          Founder of MytheAi. Tracking and reviewing AI and SaaS tools since January 2026. Built MytheAi out of frustration with pay-to-rank listicles and SEO-driven AI directories that prioritize ad revenue over honest guidance.
        </p>
        <p className="text-[12px] text-muted-foreground mt-2">
          <Link href="/about" className="text-blue-600 hover:underline font-medium">
            About the editor
          </Link>
          <span className="mx-1.5">·</span>
          <Link href="/methodology" className="text-blue-600 hover:underline font-medium">
            How we rank tools
          </Link>
        </p>
      </div>
    </div>
  )
}
