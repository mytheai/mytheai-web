import { redirect } from 'next/navigation'

export async function GET(
  _request: Request,
  { params }: { params: Promise<{ slug: string }> }
) {
  const { slug } = await params
  redirect(`/tools/${slug}`)
}
