// Generate static favicon.ico + icon PNGs for SEO (Google favicon crawler).
// Run once via: node scripts/generate-icons.mjs
// Then commit the generated binary files.
import sharp from 'sharp'
import { writeFileSync, mkdirSync } from 'fs'
import { join } from 'path'

const SVG = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
  <defs>
    <linearGradient id="g" x1="0" y1="0" x2="32" y2="32" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#60A5FA"/>
      <stop offset="100%" stop-color="#1D4ED8"/>
    </linearGradient>
  </defs>
  <rect width="32" height="32" rx="7" fill="url(#g)"/>
  <path d="M16 4 L19 13 L28 16 L19 19 L16 28 L13 19 L4 16 L13 13 Z" fill="white"/>
</svg>`

const APPLE_SVG = SVG.replace('rx="7"', 'rx="36"').replace('viewBox="0 0 32 32"', 'viewBox="0 0 32 32"')

const root = process.cwd()
const appDir = join(root, 'src', 'app')
const publicDir = join(root, 'public')

mkdirSync(appDir, { recursive: true })
mkdirSync(publicDir, { recursive: true })

const svgBuf = Buffer.from(SVG)
const appleBuf = Buffer.from(APPLE_SVG)

async function gen() {
  // 1. favicon.ico - multi-size 16/32/48 in app/
  const ico16 = await sharp(svgBuf).resize(16, 16).png().toBuffer()
  const ico32 = await sharp(svgBuf).resize(32, 32).png().toBuffer()
  const ico48 = await sharp(svgBuf).resize(48, 48).png().toBuffer()
  // Write as 32x32 PNG (works in Next.js as favicon.ico) + write binary .ico via sharp
  // sharp doesn't natively encode .ico; write 32x32 PNG then rename - browsers accept PNG inside .ico container
  // Simpler: write 32x32 PNG to favicon.ico path (Next.js auto-serves; modern browsers accept PNG bytes for .ico)
  await sharp(svgBuf).resize(32, 32).toFile(join(appDir, 'favicon.ico'))

  // 2. icon.png 512×512 in app/ (Next.js convention - auto-served at /icon)
  await sharp(svgBuf).resize(512, 512).png().toFile(join(appDir, 'icon.png'))

  // 3. apple-icon.png 180×180 in app/
  await sharp(appleBuf).resize(180, 180).png().toFile(join(appDir, 'apple-icon.png'))

  // 4. icon-192.png + icon-512.png in public/ for manifest
  await sharp(svgBuf).resize(192, 192).png().toFile(join(publicDir, 'icon-192.png'))
  await sharp(svgBuf).resize(512, 512).png().toFile(join(publicDir, 'icon-512.png'))

  // 5. Save SVG source in public/ for modern browsers
  writeFileSync(join(publicDir, 'icon.svg'), SVG)

  console.log('Generated:')
  console.log('  src/app/favicon.ico (32x32 PNG-in-ICO)')
  console.log('  src/app/icon.png (512x512)')
  console.log('  src/app/apple-icon.png (180x180)')
  console.log('  public/icon-192.png')
  console.log('  public/icon-512.png')
  console.log('  public/icon.svg')
}

gen().catch(e => { console.error(e); process.exit(1) })
