import { NextRequest, NextResponse } from 'next/server'
import { createStaticClient } from '@/lib/supabase'

export async function POST(request: NextRequest) {
  const body = await request.json()

  // Honeypot check - bots fill this in, humans don't
  if (body.hp_field) {
    return NextResponse.json({ success: true }) // silent reject
  }

  const { name, website_url, category, pricing_type, free_tier, submitter_email } = body

  if (!name || !website_url) {
    return NextResponse.json({ error: 'Name and website URL are required.' }, { status: 400 })
  }

  const supabase = createStaticClient()
  const { error } = await supabase.from('tool_submissions').insert({
    name: String(name).slice(0, 100),
    website_url: String(website_url).slice(0, 300),
    category: category ? String(category).slice(0, 50) : null,
    pricing_type: pricing_type ? String(pricing_type).slice(0, 20) : null,
    free_tier: Boolean(free_tier),
    submitter_email: submitter_email ? String(submitter_email).slice(0, 200) : null,
  })

  if (error) {
    return NextResponse.json({ error: 'Submission failed. Please try again.' }, { status: 500 })
  }

  return NextResponse.json({ success: true })
}
