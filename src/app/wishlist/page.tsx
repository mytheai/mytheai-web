import type { Metadata } from 'next'
import WishlistClient from './WishlistClient'

export const metadata: Metadata = {
  title: 'Saved Tools - Your Wishlist | MytheAi',
  description: 'Tools you have saved for quick access. Stored locally in your browser, no account needed.',
  alternates: { canonical: 'https://mytheai.com/wishlist' },
  robots: { index: false, follow: true },
}

export default function Page() {
  return <WishlistClient />
}
