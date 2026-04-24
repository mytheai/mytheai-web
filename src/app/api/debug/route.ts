import { supabase } from '@/lib/supabase'

export async function GET() {
  const { data, error, count } = await supabase
    .from('tools')
    .select('slug, name', { count: 'exact' })

  return Response.json({
    ok: !error,
    error: error?.message ?? null,
    count,
    rows: data,
    url: process.env.NEXT_PUBLIC_SUPABASE_URL?.slice(0, 30) + '...',
    keyPrefix: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.slice(0, 20) + '...',
  })
}
