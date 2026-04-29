import { ImageResponse } from 'next/og'

export const runtime = 'edge'

export async function GET() {
  return new ImageResponse(
    (
      <div
        style={{
          background: '#2563EB',
          width: '100%',
          height: '100%',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          borderRadius: '96px',
          fontFamily: 'sans-serif',
        }}
      >
        <span style={{ color: 'white', fontSize: 240, fontWeight: 800 }}>M</span>
      </div>
    ),
    { width: 512, height: 512 }
  )
}
