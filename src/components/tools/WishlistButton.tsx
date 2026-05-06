'use client'

import { useWishlist } from '@/hooks/useWishlist'

interface WishlistButtonProps {
  slug: string
  name: string
  variant?: 'cta' | 'icon'
}

export default function WishlistButton({ slug, name, variant = 'cta' }: WishlistButtonProps) {
  const { has, toggle, hydrated } = useWishlist()
  const saved = has(slug)

  if (!hydrated) {
    return null
  }

  const handleClick = () => {
    toggle(slug)
    if (typeof window !== 'undefined' && (window as { plausible?: (event: string, options?: { props: Record<string, string> }) => void }).plausible) {
      ;(window as { plausible?: (event: string, options?: { props: Record<string, string> }) => void }).plausible?.(
        saved ? 'WishlistRemove' : 'WishlistAdd',
        { props: { tool: slug } }
      )
    }
  }

  if (variant === 'icon') {
    return (
      <button
        type="button"
        onClick={handleClick}
        aria-label={saved ? `Remove ${name} from saved tools` : `Save ${name} to wishlist`}
        aria-pressed={saved}
        className={`p-2 rounded-lg transition-colors ${
          saved
            ? 'text-rose-500 hover:bg-rose-50 dark:hover:bg-rose-950/30'
            : 'text-muted-foreground hover:text-rose-500 hover:bg-gray-100 dark:hover:bg-gray-800'
        }`}
      >
        <svg width="18" height="18" viewBox="0 0 24 24" fill={saved ? 'currentColor' : 'none'} stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
        </svg>
      </button>
    )
  }

  return (
    <button
      type="button"
      onClick={handleClick}
      aria-label={saved ? `Remove ${name} from saved tools` : `Save ${name} to wishlist`}
      aria-pressed={saved}
      className={`inline-flex items-center gap-2 px-5 py-2.5 rounded-lg border font-medium text-[14px] transition-colors ${
        saved
          ? 'border-rose-300 dark:border-rose-700 bg-rose-50 dark:bg-rose-950/30 text-rose-600 dark:text-rose-400'
          : 'border-border bg-card hover:border-rose-300 text-foreground'
      }`}
    >
      <svg width="16" height="16" viewBox="0 0 24 24" fill={saved ? 'currentColor' : 'none'} stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
      </svg>
      {saved ? 'Saved' : 'Save'}
    </button>
  )
}
