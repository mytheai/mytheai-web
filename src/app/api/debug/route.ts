export async function GET() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY

  let result: unknown = null
  try {
    const r = await fetch(`${url}/rest/v1/tools?select=slug&limit=1`, {
      headers: { apikey: key ?? '', Authorization: `Bearer ${key}` },
      signal: AbortSignal.timeout(10000),
    })
    result = `http ${r.status}`
  } catch (e: unknown) {
    const err = e as { message?: string; cause?: { message?: string; code?: string } }
    result = {
      message: err?.message,
      cause: err?.cause?.message,
      code: err?.cause?.code,
    }
  }

  return Response.json({
    url,
    keyPrefix: (key ?? '').slice(0, 15),
    result,
  })
}
