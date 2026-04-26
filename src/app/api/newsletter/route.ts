import { NextResponse } from 'next/server'
import { Resend } from 'resend'
import { createStaticClient } from '@/lib/supabase'

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

export async function POST(req: Request) {
  let email: string
  try {
    const body = await req.json()
    email = (body.email ?? '').trim().toLowerCase()
  } catch {
    return NextResponse.json({ error: 'Invalid request' }, { status: 400 })
  }

  if (!email || !EMAIL_RE.test(email)) {
    return NextResponse.json({ error: 'Please enter a valid email address.' }, { status: 400 })
  }

  const supabase = createStaticClient()
  const { error: dbError } = await supabase
    .from('newsletter_subscribers')
    .insert({ email })

  if (dbError && dbError.code !== '23505') {
    // 23505 = unique violation → already subscribed → treat as success
    return NextResponse.json({ error: 'Something went wrong. Please try again.' }, { status: 500 })
  }

  // Sync to Resend audience if configured
  if (process.env.RESEND_API_KEY && process.env.RESEND_AUDIENCE_ID) {
    try {
      const resend = new Resend(process.env.RESEND_API_KEY)
      await resend.contacts.create({
        email,
        audienceId: process.env.RESEND_AUDIENCE_ID,
      })
    } catch {
      // Non-fatal - subscriber is stored in Supabase
    }
  }

  return NextResponse.json({ success: true })
}
