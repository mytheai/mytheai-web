'use client'

import Link from 'next/link'
import { useWishlist } from '@/hooks/useWishlist'

export default function WishlistHeaderLink() {
  const { count, hydrated } = useWishlist()
  if (!hydrated || count === 0) return null

  return (
    <Link
      href="/wishlist"
      aria-label={`View ${count} saved tool${count === 1 ? '' : 's'}`}
      className="relative p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-muted-foreground hover:text-rose-500 transition-colors"
    >
      <svg width="17" height="17" viewBox="0 0 24 24" fill="currentColor" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
      </svg>
      <span className="absolute -top-0.5 -right-0.5 min-w-[16px] h-[16px] px-1 rounded-full bg-rose-500 text-white text-[10px] font-bold flex items-center justify-center">
        {count > 99 ? '99+' : count}
      </span>
    </Link>
  )
}
