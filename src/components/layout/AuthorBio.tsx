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
      <img
        src="https://api.dicebear.com/9.x/notionists-neutral/svg?seed=john-ethan&backgroundColor=f3f4f6&radius=50"
        alt="John Ethan, founder of MytheAi"
        width={48}
        height={48}
        className="w-12 h-12 rounded-full flex-shrink-0 border border-border bg-gray-100"
        loading="lazy"
        decoding="async"
        itemProp="image"
      />
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
