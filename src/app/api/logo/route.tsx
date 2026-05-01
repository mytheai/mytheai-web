import { ImageResponse } from 'next/og'

export const runtime = 'edge'

export async function GET() {
  return new ImageResponse(
    (
      <div
        style={{
          width: '100%',
          height: '100%',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          background: 'linear-gradient(135deg, #60A5FA 0%, #1D4ED8 100%)',
          borderRadius: '96px',
        }}
      >
        <svg width="320" height="320" viewBox="0 0 32 32" fill="none">
          <path
            d="M16 4 L19 13 L28 16 L19 19 L16 28 L13 19 L4 16 L13 13 Z"
            fill="white"
          />
        </svg>
      </div>
    ),
    { width: 512, height: 512 }
  )
}
