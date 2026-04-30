'use client'

import Image from 'next/image'
import { useState } from 'react'

// Fallback order: logo_url → Clearbit → faviconV2 (always returns an image) → letter avatar.
// faviconV2 is last in the image chain: it may return a placeholder for unknown domains,
// but that is acceptable as a last resort before falling back to the letter avatar.
// favicon.ico is intentionally excluded: it falls outside next.config remotePatterns,
// which can cause failures depending on Next.js version.
function buildFallbacks(src: string | null, websiteUrl: string | null): string[] {
  const list: string[] = []
  if (src) list.push(src)
  if (websiteUrl) {
    try {
      const { hostname } = new URL(websiteUrl)
      list.push(`https://logo.clearbit.com/${hostname}`)
      list.push(`https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url=${websiteUrl}&size=64`)
    } catch {}
  }
  return list
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
  const fallbacks = buildFallbacks(src, websiteUrl)
  const [idx, setIdx] = useState(0)

  if (idx >= fallbacks.length) {
    return <span className={letterClassName}>{name.charAt(0).toUpperCase()}</span>
  }

  return (
    <Image
      src={fallbacks[idx]}
      alt={name}
      width={size}
      height={size}
      unoptimized
      className={className}
      onError={() => setIdx(i => i + 1)}
    />
  )
}
