import { ImageResponse } from 'next/og'
import { NextRequest } from 'next/server'

export const runtime = 'edge'

const CATEGORY_COLORS: Record<string, string> = {
  Roundup: '#DBEAFE',
  Comparison: '#FEF3C7',
  Guide: '#D1FAE5',
  'Top 10': '#EDE9FE',
}

const CATEGORY_TEXT: Record<string, string> = {
  Roundup: '#1E40AF',
  Comparison: '#92400E',
  Guide: '#065F46',
  'Top 10': '#5B21B6',
}

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url)
  const title = searchParams.get('title') ?? 'MytheAi Blog'
  const category = searchParams.get('category') ?? 'Guide'

  const bgColor = CATEGORY_COLORS[category] ?? '#F3F4F6'
  const textColor = CATEGORY_TEXT[category] ?? '#374151'

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
        {/* Category badge */}
        <div
          style={{
            display: 'flex',
            background: bgColor,
            color: textColor,
            padding: '8px 18px',
            borderRadius: '999px',
            fontSize: '16px',
            fontWeight: 700,
            letterSpacing: '0.05em',
            marginBottom: '28px',
          }}
        >
          {category}
        </div>

        {/* Brand label */}
        <div
          style={{
            display: 'flex',
            color: '#6B7280',
            fontSize: '14px',
            fontWeight: 700,
            letterSpacing: '0.12em',
            textTransform: 'uppercase',
            marginBottom: '20px',
          }}
        >
          MytheAi · AI Tools Blog
        </div>

        {/* Article title */}
        <div
          style={{
            display: 'flex',
            color: '#F9FAFB',
            fontSize: title.length > 60 ? '44px' : '56px',
            fontWeight: 800,
            lineHeight: '1.15',
            letterSpacing: '-0.02em',
            maxWidth: '1040px',
            marginBottom: '44px',
          }}
        >
          {title.length > 90 ? title.slice(0, 87) + '...' : title}
        </div>

        {/* Footer */}
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
            AI &amp; SaaS Tool Reviews
          </div>
        </div>
      </div>
    ),
    { width: 1200, height: 630 }
  )
}
