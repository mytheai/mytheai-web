import { createClient } from '@/lib/supabase'

export async function GET() {
  try {
    const supabase = await createClient()
    const { data, error } = await supabase.from('tools').select('slug, name')
    return Response.json({ ok: !error, error: error?.message ?? null, rows: data })
  } catch (e) {
    return Response.json({ ok: false, error: String(e) })
  }
}
