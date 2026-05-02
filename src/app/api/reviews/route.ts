import { NextRequest, NextResponse } from 'next/server'
import { createHash } from 'crypto'
import { createClient } from '@/lib/supabase'

export const dynamic = 'force-dynamic'

const RATE_LIMIT_HOURS = 24

function hashIp(ip: string): string {
  const salt = process.env.IP_HASH_SALT ?? 'mytheai-static-salt'
  return createHash('sha256').update(`${salt}:${ip}`).digest('hex').slice(0, 32)
}

function getClientIp(req: NextRequest): string {
  const forwarded = req.headers.get('x-forwarded-for')
  if (forwarded) return forwarded.split(',')[0].trim()
  const real = req.headers.get('x-real-ip')
  if (real) return real
  return 'unknown'
}

interface ReviewBody {
  slug?: string
  rating?: number
  bestFor?: string
  limitation?: string
  authorName?: string
  authorRole?: string
}

export async function POST(req: NextRequest) {
  let body: ReviewBody
  try {
    body = await req.json()
  } catch {
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 })
  }

  const { slug, rating, bestFor, limitation, authorName, authorRole } = body

  if (!slug || typeof slug !== 'string') {
    return NextResponse.json({ error: 'slug required' }, { status: 400 })
  }
  if (!Number.isInteger(rating) || rating! < 1 || rating! > 5) {
    return NextResponse.json({ error: 'rating must be integer 1-5' }, { status: 400 })
  }
  if (!bestFor || typeof bestFor !== 'string' || bestFor.length < 5 || bestFor.length > 280) {
    return NextResponse.json({ error: 'bestFor must be 5-280 chars' }, { status: 400 })
  }
  if (!limitation || typeof limitation !== 'string' || limitation.length < 5 || limitation.length > 280) {
    return NextResponse.json({ error: 'limitation must be 5-280 chars' }, { status: 400 })
  }

  const supabase = await createClient()

  const ipHash = hashIp(getClientIp(req))

  const cutoff = new Date(Date.now() - RATE_LIMIT_HOURS * 3600_000).toISOString()
  const { count: recentCount } = await supabase
    .from('tool_reviews')
    .select('id', { count: 'exact', head: true })
    .eq('ip_hash', ipHash)
    .eq('tool_slug', slug)
    .gte('created_at', cutoff)

  if ((recentCount ?? 0) > 0) {
    return NextResponse.json(
      { error: `You already reviewed this tool in the last ${RATE_LIMIT_HOURS}h` },
      { status: 429 }
    )
  }

  const { error } = await supabase.from('tool_reviews').insert({
    tool_slug: slug,
    rating,
    best_for: bestFor,
    limitation,
    author_name: authorName?.slice(0, 60) || null,
    author_role: authorRole?.slice(0, 60) || null,
    ip_hash: ipHash,
    status: 'pending',
  })

  if (error) {
    if (error.code === '23503') {
      return NextResponse.json({ error: 'Tool not found' }, { status: 404 })
    }
    return NextResponse.json({ error: 'Submission failed' }, { status: 500 })
  }

  return NextResponse.json({ ok: true, message: 'Review submitted, pending moderation' })
}
