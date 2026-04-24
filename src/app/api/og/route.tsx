import { ImageResponse } from 'next/og'
import { NextRequest } from 'next/server'

export const runtime = 'edge'

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)
  const name = searchParams.get('name') ?? 'AI Tool'
  const tagline = searchParams.get('tagline') ?? ''
  const rating = searchParams.get('rating') ?? ''
  const logo = searchParams.get('logo') ?? ''

  return new ImageResponse(
    (
      <div
        style={{
          width: '1200px',
          height: '630px',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'flex-start',
          justifyContent: 'center',
          background: 'linear-gradient(135deg, #0F1117 0%, #1A1D27 100%)',
          padding: '80px',
          fontFamily: 'system-ui, sans-serif',
        }}
      >
        {/* Tool logo */}
        {logo && (
          // eslint-disable-next-line @next/next/no-img-element
          <img
            src={logo}
            width={72}
            height={72}
            style={{ borderRadius: '14px', marginBottom: '28px', background: '#fff', objectFit: 'contain' }}
            alt=""
          />
        )}

        {/* Brand label */}
        <div style={{ display: 'flex', color: '#6B7280', fontSize: '14px', fontWeight: 700, letterSpacing: '0.12em', textTransform: 'uppercase', marginBottom: '20px' }}>
          MytheAi · AI Tool Review
        </div>

        {/* Tool name */}
        <div style={{ display: 'flex', color: '#F9FAFB', fontSize: '68px', fontWeight: 800, lineHeight: '1.1', marginBottom: '18px', letterSpacing: '-0.03em' }}>
          {name}
        </div>

        {/* Tagline */}
        {tagline && (
          <div style={{ display: 'flex', color: '#9CA3AF', fontSize: '22px', lineHeight: '1.5', maxWidth: '860px', marginBottom: '44px' }}>
            {tagline.length > 100 ? tagline.slice(0, 97) + '...' : tagline}
          </div>
        )}

        {/* Rating + site */}
        <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
          {rating && (
            <div style={{ display: 'flex', background: '#2563EB', color: 'white', padding: '10px 22px', borderRadius: '8px', fontSize: '20px', fontWeight: 700 }}>
              ★ {rating} / 5.0
            </div>
          )}
          <div style={{ display: 'flex', color: '#4B5563', fontSize: '16px', fontWeight: 500 }}>
            mytheai.com
          </div>
        </div>
      </div>
    ),
    { width: 1200, height: 630 }
  )
}
