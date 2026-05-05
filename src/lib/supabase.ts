import { createServerClient } from '@supabase/ssr'
import { createClient as createBaseClient } from '@supabase/supabase-js'
import { cookies } from 'next/headers'

// For server components and route handlers (has cookies context)
export async function createClient() {
  const cookieStore = await cookies()
  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!,
    {
      cookies: {
        getAll() { return cookieStore.getAll() },
        setAll(cookiesToSet) {
          try {
            cookiesToSet.forEach(({ name, value, options }) =>
              cookieStore.set(name, value, options)
            )
          } catch {}
        },
      },
    }
  )
}

// For generateStaticParams and build-time queries (no cookies context)
export function createStaticClient() {
  return createBaseClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!
  )
}

// Service-role client - bypasses RLS. Use ONLY in server-side route handlers
// for trusted writes (e.g. moderated review insert with status='approved').
// Never import this into a client component.
export function createServiceClient() {
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY
  if (!key) {
    throw new Error('SUPABASE_SERVICE_ROLE_KEY missing - add to .env.local from Supabase dashboard > Settings > API')
  }
  return createBaseClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, key, {
    auth: { autoRefreshToken: false, persistSession: false },
  })
}
