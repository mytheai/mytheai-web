import { NextResponse } from 'next/server'
import { createStaticClient } from '@/lib/supabase'

// Cache for 1 hour at the edge, allow serving stale up to 24h while revalidating.
// Index changes only when new tools land in batch SQL files.
export const revalidate = 3600

interface ToolRow {
  slug: string
  name: string
  tagline: string | null
  logo_url: string | null
  website_url: string | null
  pricing_type: 'free' | 'freemium' | 'paid' | 'ltd'
  tags: string[] | null
  rating: number | null
}

// Compact shape - short keys to trim payload (~25% smaller).
// Decoded client-side in SearchDropdown.
interface CompactTool {
  s: string  // slug
  n: string  // name
  t: string  // tagline
  l: string | null  // logo_url
  w: string | null  // website_url
  p: 'free' | 'freemium' | 'paid' | 'ltd'  // pricing_type
  g: string[]  // tags
  r: number  // rating
}

export async function GET() {
  const supabase = createStaticClient()
  const { data, error } = await supabase
    .from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,tags,rating')
    .order('rating', { ascending: false })

  if (error) {
    return NextResponse.json([], { status: 200 })
  }

  const payload: CompactTool[] = (data ?? []).map((r: ToolRow) => ({
    s: r.slug,
    n: r.name,
    t: r.tagline ?? '',
    l: r.logo_url,
    w: r.website_url,
    p: r.pricing_type,
    g: r.tags ?? [],
    r: r.rating ?? 0,
  }))

  return NextResponse.json(payload, {
    headers: {
      'Cache-Control': 'public, s-maxage=3600, stale-while-revalidate=86400',
      'CDN-Cache-Control': 'public, max-age=3600',
    },
  })
}
