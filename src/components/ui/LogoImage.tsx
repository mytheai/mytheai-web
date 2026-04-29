'use client'

import Image from 'next/image'
import { useState } from 'react'

function faviconUrl(websiteUrl: string): string | null {
  try {
    const { hostname } = new URL(websiteUrl)
    return `https://www.google.com/s2/favicons?domain=${hostname}&sz=64`
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
  const fallback = websiteUrl ? faviconUrl(websiteUrl) : null
  const [imgSrc, setImgSrc] = useState(src)
  const [usedFallback, setUsedFallback] = useState(false)

  if (!imgSrc) {
    return <span className={letterClassName}>{name.charAt(0).toUpperCase()}</span>
  }

  return (
    <Image
      src={imgSrc}
      alt={name}
      width={size}
      height={size}
      unoptimized
      className={className}
      onError={() => {
        if (!usedFallback && fallback) {
          setImgSrc(fallback)
          setUsedFallback(true)
        } else {
          setImgSrc(null)
        }
      }}
    />
  )
}
