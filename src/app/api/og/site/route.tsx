import { ImageResponse } from 'next/og'
import { NextRequest } from 'next/server'

export const runtime = 'edge'

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)
  const title = searchParams.get('title') ?? 'MytheAi - Best AI & SaaS Tools 2026'
  const desc =
    searchParams.get('desc') ??
    'Discover and compare 500+ AI & SaaS tools. Honest reviews, verified pricing. No pay-to-rank.'

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
        {/* Brand wordmark */}
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: '14px',
            marginBottom: '40px',
          }}
        >
          <div
            style={{
              background: 'linear-gradient(135deg, #60A5FA 0%, #1D4ED8 100%)',
              width: '52px',
              height: '52px',
              borderRadius: '14px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
            }}
          >
            <svg width="36" height="36" viewBox="0 0 32 32" fill="none">
              <path
                d="M16 4 L19 13 L28 16 L19 19 L16 28 L13 19 L4 16 L13 13 Z"
                fill="white"
              />
            </svg>
          </div>
          <span style={{ color: '#F9FAFB', fontSize: 26, fontWeight: 700, letterSpacing: '-0.02em' }}>
            MytheAi
          </span>
        </div>

        {/* Title */}
        <div
          style={{
            display: 'flex',
            color: '#F9FAFB',
            fontSize: title.length > 50 ? '48px' : '60px',
            fontWeight: 800,
            lineHeight: '1.1',
            letterSpacing: '-0.03em',
            maxWidth: '1040px',
            marginBottom: '28px',
          }}
        >
          {title}
        </div>

        {/* Description */}
        <div
          style={{
            display: 'flex',
            color: '#9CA3AF',
            fontSize: '22px',
            lineHeight: '1.5',
            maxWidth: '860px',
            marginBottom: '48px',
          }}
        >
          {desc.length > 100 ? desc.slice(0, 97) + '...' : desc}
        </div>

        {/* Footer badge */}
        <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
          <div
            style={{
              display: 'flex',
              background: '#2563EB',
              color: 'white',
              padding: '10px 22px',
              borderRadius: '8px',
              fontSize: '18px',
              fontWeight: 700,
            }}
          >
            mytheai.com
          </div>
          <div style={{ display: 'flex', color: '#4B5563', fontSize: '15px' }}>
            AI &amp; SaaS Tool Discovery
          </div>
        </div>
      </div>
    ),
    { width: 1200, height: 630 }
  )
}
