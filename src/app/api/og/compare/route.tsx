import { ImageResponse } from 'next/og'
import { NextRequest } from 'next/server'

export const runtime = 'edge'

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)
  const nameA = searchParams.get('nameA') ?? 'Tool A'
  const nameB = searchParams.get('nameB') ?? 'Tool B'
  const logoA = searchParams.get('logoA') ?? ''
  const logoB = searchParams.get('logoB') ?? ''

  return new ImageResponse(
    (
      <div
        style={{
          width: '1200px',
          height: '630px',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          background: 'linear-gradient(135deg, #0F1117 0%, #1A1D27 100%)',
          fontFamily: 'system-ui, sans-serif',
        }}
      >
        {/* Brand label */}
        <div style={{ display: 'flex', color: '#6B7280', fontSize: '14px', fontWeight: 700, letterSpacing: '0.12em', textTransform: 'uppercase', marginBottom: '56px' }}>
          MytheAi · Head-to-Head Comparison
        </div>

        {/* Tools side by side */}
        <div style={{ display: 'flex', alignItems: 'center', gap: '48px' }}>

          {/* Tool A */}
          <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '20px' }}>
            {logoA ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={logoA}
                width={100}
                height={100}
                style={{ borderRadius: '20px', background: '#fff', objectFit: 'contain' }}
                alt=""
              />
            ) : (
              <div style={{ width: '100px', height: '100px', borderRadius: '20px', background: '#374151', display: 'flex' }} />
            )}
            <div style={{ display: 'flex', color: '#F9FAFB', fontSize: '30px', fontWeight: 800, letterSpacing: '-0.02em' }}>
              {nameA}
            </div>
          </div>

          {/* VS badge */}
          <div style={{ display: 'flex', background: '#2563EB', color: 'white', fontSize: '26px', fontWeight: 900, padding: '18px 30px', borderRadius: '14px', letterSpacing: '0.06em' }}>
            VS
          </div>

          {/* Tool B */}
          <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '20px' }}>
            {logoB ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                src={logoB}
                width={100}
                height={100}
                style={{ borderRadius: '20px', background: '#fff', objectFit: 'contain' }}
                alt=""
              />
            ) : (
              <div style={{ width: '100px', height: '100px', borderRadius: '20px', background: '#374151', display: 'flex' }} />
            )}
            <div style={{ display: 'flex', color: '#F9FAFB', fontSize: '30px', fontWeight: 800, letterSpacing: '-0.02em' }}>
              {nameB}
            </div>
          </div>
        </div>

        {/* Site URL */}
        <div style={{ display: 'flex', color: '#4B5563', fontSize: '16px', fontWeight: 500, marginTop: '56px' }}>
          mytheai.com/compare
        </div>
      </div>
    ),
    { width: 1200, height: 630 }
  )
}
