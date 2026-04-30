'use client'

import { useState } from 'react'

// Single source: Google S2 favicons. Google's CDN is fast worldwide,
// supports every domain, and always returns an image. No fallback chain
// needed - if the image fails to load entirely, the letter avatar shows.
function buildSrc(src: string | null, websiteUrl: string | null): string | null {
  if (src) return src
  if (!websiteUrl) return null
  try {
    const { hostname } = new URL(websiteUrl)
    return `https://www.google.com/s2/favicons?domain=${hostname}&sz=128`
  } catch {
    return null
  }
}

interface Props {
  src: string | null
  websiteUrl: string | null
  name: string
  size?: number
  className?: string
  letterClassName?: string
}

export default function LogoImage({
  src,
  websiteUrl,
  name,
  size = 40,
  className,
  letterClassName = 'text-[14px] font-bold text-gray-400',
}: Props) {
  const initial = buildSrc(src, websiteUrl)
  const [failed, setFailed] = useState(false)

  if (!initial || failed) {
    return <span className={letterClassName}>{name.charAt(0).toUpperCase()}</span>
  }

  return (
    // eslint-disable-next-line @next/next/no-img-element
    <img
      src={initial}
      alt={name}
      width={size}
      height={size}
      loading="lazy"
      decoding="async"
      referrerPolicy="no-referrer"
      className={className}
      onError={() => setFailed(true)}
    />
  )
}
