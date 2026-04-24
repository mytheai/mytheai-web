export async function GET() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  // Test raw fetch — bypass supabase-js client entirely
  let rawResult: unknown = null
  let rawError: string | null = null
  try {
    const res = await fetch(`${url}/rest/v1/tools?select=slug,name&limit=10`, {
      headers: {
        apikey: key ?? '',
        Authorization: `Bearer ${key}`,
      },
    })
    rawResult = await res.json()
  } catch (e) {
    rawError = String(e)
  }

  return Response.json({
    url: url?.slice(0, 40),
    keyOk: key?.startsWith('eyJ'),
    rawError,
    rawResult,
  })
}
