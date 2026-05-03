#!/usr/bin/env node
// indexnow-ping.mjs - submit URLs to IndexNow (Bing, Yandex, Naver, Seznam).
//
// Setup (1-time):
//   1. INDEXNOW_KEY in web/.env.local (32-char hex)
//   2. web/public/<KEY>.txt must exist with KEY as content
//   3. Deploy. Verify https://mytheai.com/<KEY>.txt is reachable.
//
// Usage:
//   node --env-file=.env.local scripts/indexnow-ping.mjs https://mytheai.com/blog/x
//   node --env-file=.env.local scripts/indexnow-ping.mjs --all              # blast every URL in sitemap
//   node --env-file=.env.local scripts/indexnow-ping.mjs --recent 30        # URLs modified in last 30 days
//
// Exit codes: 0 success, 1 failure

const KEY = process.env.INDEXNOW_KEY
const HOST = 'mytheai.com'
const SITEMAP_URL = `https://${HOST}/sitemap.xml`
const BATCH_SIZE = 10000 // IndexNow API max per request

if (!KEY) {
  console.error('ERROR: INDEXNOW_KEY missing in env. Add to web/.env.local.')
  process.exit(1)
}

const args = process.argv.slice(2)
const allFlag = args.includes('--all')
const recentIdx = args.indexOf('--recent')
const recentDays = recentIdx >= 0 ? parseInt(args[recentIdx + 1] || '30', 10) : null

let urls = []

if (allFlag || recentDays !== null) {
  console.log(`Fetching sitemap ${SITEMAP_URL}...`)
  const sitemapRes = await fetch(SITEMAP_URL)
  if (!sitemapRes.ok) {
    console.error(`ERROR: sitemap fetch failed HTTP ${sitemapRes.status}`)
    process.exit(1)
  }
  const xml = await sitemapRes.text()
  const entries = [...xml.matchAll(/<url>\s*<loc>([^<]+)<\/loc>(?:\s*<lastmod>([^<]+)<\/lastmod>)?/g)]
  urls = entries
    .map(m => ({ loc: m[1], lastmod: m[2] }))
    .filter(e => {
      if (recentDays === null) return true
      if (!e.lastmod) return false
      const ageDays = (Date.now() - new Date(e.lastmod).getTime()) / 86400000
      return ageDays <= recentDays
    })
    .map(e => e.loc)
  console.log(`Found ${urls.length} URL(s) in sitemap${recentDays !== null ? ` (last ${recentDays}d)` : ''}.`)
} else {
  urls = args.filter(u => u.startsWith('http'))
  if (urls.length === 0) {
    console.error('ERROR: pass URLs as args, or use --all / --recent N.')
    console.error('  node --env-file=.env.local scripts/indexnow-ping.mjs --all')
    process.exit(1)
  }
}

if (urls.length === 0) {
  console.error('ERROR: 0 URLs to submit.')
  process.exit(1)
}

const batches = []
for (let i = 0; i < urls.length; i += BATCH_SIZE) {
  batches.push(urls.slice(i, i + BATCH_SIZE))
}

let okCount = 0
let failCount = 0

for (let i = 0; i < batches.length; i++) {
  const batch = batches[i]
  const body = {
    host: HOST,
    key: KEY,
    keyLocation: `https://${HOST}/${KEY}.txt`,
    urlList: batch,
  }
  console.log(`Batch ${i + 1}/${batches.length}: pinging ${batch.length} URL(s)...`)
  const r = await fetch('https://api.indexnow.org/IndexNow', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=utf-8' },
    body: JSON.stringify(body),
  })
  if (r.status === 200 || r.status === 202) {
    console.log(`  OK (HTTP ${r.status})`)
    okCount += batch.length
  } else {
    const text = await r.text().catch(() => '')
    console.error(`  FAILED HTTP ${r.status} ${r.statusText}`)
    if (text) console.error('  ' + text.slice(0, 300))
    failCount += batch.length
  }
}

console.log(`\nTotal: ${okCount} OK, ${failCount} failed.`)

if (failCount > 0) {
  console.error('\nCommon causes:')
  console.error('  422 = key file URL mismatch. Verify https://' + HOST + '/' + KEY + '.txt is reachable.')
  console.error('  403 = key invalid or rate-limited.')
  console.error('  400 = malformed URLs (must be absolute, same host).')
  process.exit(1)
}
process.exit(0)
