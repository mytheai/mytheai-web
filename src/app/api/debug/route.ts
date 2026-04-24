export async function GET() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  // Test 1: can Vercel fetch anything at all?
  let publicFetch: string | null = null
  try {
    const r = await fetch('https://httpbin.org/get', { signal: AbortSignal.timeout(5000) })
    publicFetch = r.ok ? 'ok' : `http ${r.status}`
  } catch (e) { publicFetch = String(e) }

  // Test 2: raw Supabase REST call
  let supabaseFetch: unknown = null
  let supabaseError: string | null = null
  try {
    const r = await fetch(`${url}/rest/v1/tools?select=slug&limit=3`, {
      headers: { apikey: key ?? '', Authorization: `Bearer ${key}` },
      signal: AbortSignal.timeout(8000),
    })
    supabaseFetch = r.ok ? await r.json() : `http ${r.status}: ${await r.text()}`
  } catch (e) { supabaseError = String(e) }

  return Response.json({ publicFetch, supabaseFetch, supabaseError, keyOk: key?.startsWith('eyJ') })
}
