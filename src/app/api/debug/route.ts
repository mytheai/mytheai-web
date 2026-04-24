export async function GET() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  const results: Record<string, unknown> = { url, keyPrefix: key?.slice(0, 15) }

  // Try health endpoint
  for (const path of ['/health', '/rest/v1/', '/rest/v1/tools?select=slug&limit=1']) {
    try {
      const r = await fetch(`${url}${path}`, {
        headers: path.includes('rest') ? { apikey: key ?? '', Authorization: `Bearer ${key}` } : {},
        signal: AbortSignal.timeout(10000),
      })
      results[path] = `http ${r.status}`
    } catch (e) {
      results[path] = String(e)
    }
  }

  return Response.json(results)
}
