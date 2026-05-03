import { ImageResponse } from 'next/og'
import { createStaticClient } from '@/lib/supabase'

export const runtime = 'edge'

// SVG-style badge "Featured on MytheAi" PNG that tool vendors can embed.
// They link the badge image -> https://mytheai.com/tools/<slug>, generating
// a contextual backlink. PNG keeps it broadly compatible (Notion, GitHub
// READMEs, vendor websites).
//
// Usage: <a href="https://mytheai.com/tools/notion"><img src="https://mytheai.com/api/badge/notion" alt="Featured on MytheAi" /></a>

export async function GET(
  _req: Request,
  { params }: { params: Promise<{ slug: string }> }
) {
  const { slug } = await params
  const supabase = createStaticClient()
  const { data: tool } = await supabase
    .from('tools')
    .select('name,rating')
    .eq('slug', slug)
    .single()

  const name = tool?.name ?? 'Tool'
  const rating = tool?.rating ?? 0

  return new ImageResponse(
    (
      <div
        style={{
          width: '100%',
          height: '100%',
          display: 'flex',
          alignItems: 'center',
          padding: '14px 20px',
          background: 'linear-gradient(135deg, #ffffff 0%, #f5f7fb 100%)',
          border: '2px solid #1D4ED8',
          borderRadius: '12px',
          fontFamily: 'sans-serif',
          gap: '14px',
        }}
      >
        <div
          style={{
            width: '52px',
            height: '52px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            background: 'linear-gradient(135deg, #60A5FA 0%, #1D4ED8 100%)',
            borderRadius: '10px',
            flexShrink: 0,
          }}
        >
          <svg width="32" height="32" viewBox="0 0 32 32" fill="none">
            <path d="M16 4 L19 13 L28 16 L19 19 L16 28 L13 19 L4 16 L13 13 Z" fill="white" />
          </svg>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column' }}>
          <div style={{ fontSize: '11px', color: '#6B7280', fontWeight: 700, letterSpacing: '1px', textTransform: 'uppercase' }}>
            Featured on MytheAi
          </div>
          <div style={{ fontSize: '18px', color: '#111827', fontWeight: 800, marginTop: '2px' }}>
            {name}
          </div>
          {rating > 0 && (
            <div style={{ fontSize: '12px', color: '#1D4ED8', fontWeight: 600, marginTop: '2px' }}>
              ★ {rating.toFixed(1)} editorial rating
            </div>
          )}
        </div>
      </div>
    ),
    { width: 320, height: 80 }
  )
}
