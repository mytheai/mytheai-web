import { NextRequest, NextResponse } from 'next/server'
import { createHash } from 'crypto'
import { createClient, createServiceClient } from '@/lib/supabase'

export const dynamic = 'force-dynamic'

const RATE_LIMIT_HOURS = 24
const DAILY_CAP_PER_IP = 5
const MIN_FILL_MS = 3000
const MAX_FILL_MS = 30 * 60 * 1000

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

const SPAM_PATTERNS: RegExp[] = [
  /\bhttps?:\/\//i,
  /\bwww\./i,
  /\b(viagra|casino|crypto airdrop|forex signal|loan offer|escort|sex chat|porn|xxx)\b/i,
  /\b(free shipping|click here|act now|limited offer|buy now|order now)\b/i,
  /\b(seo service|backlink|guest post|link exchange|rank #1|rank top)\b/i,
  /\b(write my essay|cheap essay|hire writer|buy followers|cheap likes)\b/i,
  /[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}]{4,}/u,
  /(.)\1{6,}/,
  /[A-Z\s!]{30,}/,
]

interface QualityVerdict {
  ok: boolean
  reason?: string
}

function checkContentQuality(bestFor: string, limitation: string): QualityVerdict {
  const combined = `${bestFor} ${limitation}`.trim()
  for (const pat of SPAM_PATTERNS) {
    if (pat.test(combined)) return { ok: false, reason: 'spam-pattern' }
  }
  const words = combined.split(/\s+/).filter(w => w.length > 0)
  if (words.length < 4) return { ok: false, reason: 'too-few-words' }
  const unique = new Set(words.map(w => w.toLowerCase()))
  if (unique.size / words.length < 0.4) return { ok: false, reason: 'low-uniqueness' }
  const letters = combined.replace(/[^a-zA-Z]/g, '').length
  if (letters < combined.length * 0.5) return { ok: false, reason: 'low-letter-ratio' }
  if (bestFor.toLowerCase().trim() === limitation.toLowerCase().trim()) {
    return { ok: false, reason: 'duplicate-fields' }
  }
  return { ok: true }
}

interface ReviewBody {
  slug?: string
  rating?: number
  bestFor?: string
  limitation?: string
  authorName?: string
  authorRole?: string
  _hp?: string
  _t?: number
}

export async function POST(req: NextRequest) {
  let body: ReviewBody
  try {
    body = await req.json()
  } catch {
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 })
  }

  const { slug, rating, bestFor, limitation, authorName, authorRole, _hp, _t } = body

  if (typeof _hp === 'string' && _hp.trim().length > 0) {
    return NextResponse.json({ ok: true, status: 'pending' })
  }
  if (typeof _t === 'number' && (_t < MIN_FILL_MS || _t > MAX_FILL_MS)) {
    return NextResponse.json({ ok: true, status: 'pending' })
  }

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

  const cutoffPerTool = new Date(Date.now() - RATE_LIMIT_HOURS * 3600_000).toISOString()
  const { count: recentCount } = await supabase
    .from('tool_reviews')
    .select('id', { count: 'exact', head: true })
    .eq('ip_hash', ipHash)
    .eq('tool_slug', slug)
    .gte('created_at', cutoffPerTool)

  if ((recentCount ?? 0) > 0) {
    return NextResponse.json(
      { error: `You already reviewed this tool in the last ${RATE_LIMIT_HOURS}h` },
      { status: 429 }
    )
  }

  const cutoffDaily = new Date(Date.now() - 24 * 3600_000).toISOString()
  const { count: dailyCount } = await supabase
    .from('tool_reviews')
    .select('id', { count: 'exact', head: true })
    .eq('ip_hash', ipHash)
    .gte('created_at', cutoffDaily)

  if ((dailyCount ?? 0) >= DAILY_CAP_PER_IP) {
    return NextResponse.json(
      { error: `Daily review cap reached. Try again in 24h.` },
      { status: 429 }
    )
  }

  const quality = checkContentQuality(bestFor, limitation)
  let status: 'approved' | 'pending' = quality.ok ? 'approved' : 'pending'

  // Service client bypasses RLS so we can write status='approved' directly.
  // Falls back to anon client (status forced to 'pending' by RLS policy) when
  // SUPABASE_SERVICE_ROLE_KEY is missing in deployment.
  let writer
  try {
    writer = createServiceClient()
  } catch {
    writer = supabase
    status = 'pending'
  }

  const { error } = await writer.from('tool_reviews').insert({
    tool_slug: slug,
    rating,
    best_for: bestFor,
    limitation,
    author_name: authorName?.slice(0, 60) || null,
    author_role: authorRole?.slice(0, 60) || null,
    ip_hash: ipHash,
    status,
  })

  if (error) {
    if (error.code === '23503') {
      return NextResponse.json({ error: 'Tool not found' }, { status: 404 })
    }
    return NextResponse.json({ error: 'Submission failed' }, { status: 500 })
  }

  return NextResponse.json({ ok: true, status })
}
