#!/usr/bin/env node
// indexnow-ping.mjs - submit URLs to IndexNow (Bing, Yandex, Naver, Seznam)
//
// Setup (1-time):
//   1. Generate IndexNow key: 32-char hex via `node -e "console.log(crypto.randomUUID().replace(/-/g,''))"`
//   2. Add to web/.env.local:  INDEXNOW_KEY=<the-key>
//   3. Create web/public/<the-key>.txt with the key as plain text content
//   4. Deploy. Verify https://mytheai.com/<the-key>.txt returns the key.
//
// Usage:
//   node --env-file=.env.local scripts/indexnow-ping.mjs <url1> <url2> ...
//
// Exit codes:
//   0 = HTTP 200/202 success
//   1 = key missing, no URLs, or non-success HTTP

const KEY = process.env.INDEXNOW_KEY
const HOST = 'mytheai.com'

if (!KEY) {
  console.error('ERROR: INDEXNOW_KEY missing in env. Add to web/.env.local.')
  process.exit(1)
}

const urls = process.argv.slice(2).filter(u => u.startsWith('http'))
if (urls.length === 0) {
  console.error('ERROR: pass at least 1 URL as argv. Example:')
  console.error('  node --env-file=.env.local scripts/indexnow-ping.mjs https://mytheai.com/blog/x https://mytheai.com/tools/y')
  process.exit(1)
}

const body = {
  host: HOST,
  key: KEY,
  keyLocation: `https://${HOST}/${KEY}.txt`,
  urlList: urls,
}

console.log(`IndexNow: pinging ${urls.length} URL(s)...`)

const r = await fetch('https://api.indexnow.org/IndexNow', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json; charset=utf-8' },
  body: JSON.stringify(body),
})

if (r.status === 200 || r.status === 202) {
  console.log(`IndexNow: OK (HTTP ${r.status})`)
  process.exit(0)
}

const text = await r.text().catch(() => '')
console.error(`IndexNow: FAILED HTTP ${r.status} ${r.statusText}`)
if (text) console.error(text.slice(0, 500))
console.error('\nCommon causes:')
console.error('  422 = key file URL mismatch. Verify https://mytheai.com/' + KEY + '.txt is reachable.')
console.error('  403 = key invalid or rate-limited.')
console.error('  400 = malformed URLs (must be absolute, same host).')
process.exit(1)
