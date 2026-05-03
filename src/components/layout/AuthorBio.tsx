import Link from 'next/link'
import { getAuthor } from '@/data/authors'

interface AuthorBioProps {
  context?: 'reviewed' | 'written' | 'curated'
  authorSlug?: string
  className?: string
}

const LABEL: Record<NonNullable<AuthorBioProps['context']>, string> = {
  reviewed: 'Reviewed by',
  written: 'Written by',
  curated: 'Curated by',
}

export default function AuthorBio({ context = 'curated', authorSlug, className = '' }: AuthorBioProps) {
  const author = getAuthor(authorSlug)
  const sameAs = [author.twitter, author.linkedin, author.github].filter(Boolean) as string[]

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
        aria-label={`${author.name}, ${author.role.toLowerCase()} at MytheAi`}
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
          {author.name}
        </p>
        <p className="text-[12px] text-blue-600 font-medium mb-1" itemProp="jobTitle">
          {author.role}
        </p>
        <p className="text-[12px] text-muted-foreground mt-1 leading-relaxed" itemProp="description">
          {author.bio}
        </p>
        <p className="text-[12px] text-muted-foreground mt-2 flex flex-wrap items-center gap-x-1.5 gap-y-1">
          <Link href="/about" className="text-blue-600 hover:underline font-medium" itemProp="url">
            About the editor
          </Link>
          <span>·</span>
          <Link href="/methodology" className="text-blue-600 hover:underline font-medium">
            How we rank tools
          </Link>
          {sameAs.map(href => (
            <span key={href} className="inline-flex items-center">
              <span className="mr-1.5">·</span>
              <a
                href={href}
                target="_blank"
                rel="noopener noreferrer me"
                className="text-blue-600 hover:underline font-medium"
                itemProp="sameAs"
              >
                {hostnameLabel(href)}
              </a>
            </span>
          ))}
        </p>
      </div>
    </div>
  )
}

function hostnameLabel(url: string): string {
  try {
    const h = new URL(url).hostname.replace(/^www\./, '')
    if (h.includes('twitter') || h.includes('x.com')) return 'Twitter'
    if (h.includes('linkedin')) return 'LinkedIn'
    if (h.includes('github')) return 'GitHub'
    return h
  } catch {
    return 'Link'
  }
}
