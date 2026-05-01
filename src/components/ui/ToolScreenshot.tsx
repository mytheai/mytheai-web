'use client'

import { useState } from 'react'

interface ToolScreenshotProps {
  websiteUrl: string | null
  name: string
  className?: string
}

function buildMicrolinkUrl(websiteUrl: string): string | null {
  try {
    const target = new URL(websiteUrl)
    const params = new URLSearchParams({
      url: target.toString(),
      screenshot: 'true',
      meta: 'false',
      embed: 'screenshot.url',
      'viewport.width': '1280',
      'viewport.height': '800',
      'viewport.deviceScaleFactor': '1',
      waitUntil: 'networkidle0',
    })
    return `https://api.microlink.io/?${params.toString()}`
  } catch {
    return null
  }
}

function initial(name: string): string {
  return (name?.[0] ?? '?').toUpperCase()
}

export default function ToolScreenshot({ websiteUrl, name, className = '' }: ToolScreenshotProps) {
  const [errored, setErrored] = useState(false)
  const src = websiteUrl ? buildMicrolinkUrl(websiteUrl) : null

  if (!src || errored) {
    return (
      <div
        className={`relative w-full aspect-[16/10] rounded-xl border border-border overflow-hidden flex items-center justify-center ${className}`}
        style={{ background: 'linear-gradient(135deg, #DBEAFE 0%, #93C5FD 50%, #60A5FA 100%)' }}
        aria-label={`Preview of ${name}`}
      >
        <span className="text-white text-[96px] font-extrabold drop-shadow-lg select-none" aria-hidden="true">
          {initial(name)}
        </span>
      </div>
    )
  }

  return (
    <div className={`relative w-full aspect-[16/10] rounded-xl border border-border overflow-hidden bg-gray-100 dark:bg-gray-900 ${className}`}>
      <img
        src={src}
        alt={`Live screenshot of ${name} homepage`}
        loading="lazy"
        decoding="async"
        onError={() => setErrored(true)}
        className="w-full h-full object-cover object-top"
      />
    </div>
  )
}
