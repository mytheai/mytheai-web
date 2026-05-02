#!/usr/bin/env node
// gsc-fetch.mjs - pull last 28 days of Search Console data and write a markdown snapshot.
//
// Setup (1-time): see scripts/README-gsc.md
//
// Usage:
//   node --env-file=.env.local scripts/gsc-fetch.mjs
//
// Outputs: gsc-snapshot.md in repo root (D:/MytheAi/gsc-snapshot.md)
//
// Required env:
//   GSC_SITE_URL=https://mytheai.com         (or sc-domain:mytheai.com)
//   GSC_SERVICE_ACCOUNT_EMAIL=...@*.gserviceaccount.com
//   GSC_SERVICE_ACCOUNT_PRIVATE_KEY=<full RSA key incl. BEGIN/END lines, \n escaped>

import crypto from 'crypto'
import fs from 'fs/promises'
import path from 'path'

const SITE = process.env.GSC_SITE_URL
const SA_EMAIL = process.env.GSC_SERVICE_ACCOUNT_EMAIL
const SA_KEY_RAW = process.env.GSC_SERVICE_ACCOUNT_PRIVATE_KEY

if (!SITE || !SA_EMAIL || !SA_KEY_RAW) {
  console.error('ERROR: missing GSC_SITE_URL / GSC_SERVICE_ACCOUNT_EMAIL / GSC_SERVICE_ACCOUNT_PRIVATE_KEY')
  console.error('See scripts/README-gsc.md for one-time setup.')
  process.exit(1)
}

const SA_KEY = SA_KEY_RAW.replace(/\\n/g, '\n')

// === Step 1: build + sign JWT for service-account auth ===

function base64url(input) {
  return Buffer.from(input).toString('base64')
    .replace(/=/g, '').replace(/\+/g, '-').replace(/\//g, '_')
}

const now = Math.floor(Date.now() / 1000)
const jwtHeader = base64url(JSON.stringify({ alg: 'RS256', typ: 'JWT' }))
const jwtClaim = base64url(JSON.stringify({
  iss: SA_EMAIL,
  scope: 'https://www.googleapis.com/auth/webmasters.readonly',
  aud: 'https://oauth2.googleapis.com/token',
  iat: now,
  exp: now + 3600,
}))
const signingInput = `${jwtHeader}.${jwtClaim}`
const signature = crypto.sign('RSA-SHA256', Buffer.from(signingInput), SA_KEY)
const signedJwt = `${signingInput}.${base64url(signature)}`

// === Step 2: exchange JWT for access token ===

const tokenRes = await fetch('https://oauth2.googleapis.com/token', {
  method: 'POST',
  headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  body: new URLSearchParams({
    grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
    assertion: signedJwt,
  }),
})
if (!tokenRes.ok) {
  console.error('Token exchange failed:', tokenRes.status, await tokenRes.text())
  process.exit(1)
}
const { access_token } = await tokenRes.json()

// === Step 3: query Search Console ===

const endDate = new Date().toISOString().slice(0, 10)
const startDate = new Date(Date.now() - 28 * 86400_000).toISOString().slice(0, 10)
const apiUrl = `https://searchconsole.googleapis.com/webmasters/v3/sites/${encodeURIComponent(SITE)}/searchAnalytics/query`

async function query(dimensions, rowLimit = 25) {
  const r = await fetch(apiUrl, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${access_token}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ startDate, endDate, dimensions, rowLimit }),
  })
  if (!r.ok) throw new Error(`GSC query failed (${dimensions.join(',')}): ${r.status} ${await r.text()}`)
  const data = await r.json()
  return data.rows ?? []
}

console.log(`Fetching ${startDate} to ${endDate}...`)
const [byPage, byQuery, total] = await Promise.all([
  query(['page'], 25),
  query(['query'], 25),
  query([], 1),
])

// === Step 4: format markdown report ===

const t = total[0] ?? { clicks: 0, impressions: 0, ctr: 0, position: 0 }
const pct = (n) => (n * 100).toFixed(2) + '%'

const lowCtrPages = [...byPage]
  .filter(r => r.impressions >= 100)
  .sort((a, b) => a.ctr - b.ctr)
  .slice(0, 10)

const topClickPages = [...byPage]
  .sort((a, b) => b.clicks - a.clicks)
  .slice(0, 10)

const md = `# GSC Snapshot - ${startDate} to ${endDate}

Generated: ${new Date().toISOString()}
Site: ${SITE}

## Totals (last 28 days)

| Metric | Value |
|---|---|
| Clicks | ${t.clicks.toLocaleString()} |
| Impressions | ${t.impressions.toLocaleString()} |
| CTR | ${pct(t.ctr)} |
| Avg Position | ${(t.position ?? 0).toFixed(1)} |

## Top 10 pages by clicks

| Page | Clicks | Impressions | CTR | Position |
|---|---|---|---|---|
${topClickPages.map(r => `| ${r.keys[0]} | ${r.clicks} | ${r.impressions} | ${pct(r.ctr)} | ${r.position.toFixed(1)} |`).join('\n')}

## Top 10 LOW-CTR pages (>=100 impressions, sorted by lowest CTR)

These are CTR rewrite candidates. Page ranks but title/meta is not pulling clicks.

| Page | Clicks | Impressions | CTR | Position |
|---|---|---|---|---|
${lowCtrPages.map(r => `| ${r.keys[0]} | ${r.clicks} | ${r.impressions} | ${pct(r.ctr)} | ${r.position.toFixed(1)} |`).join('\n')}

## Top 25 queries

| Query | Clicks | Impressions | CTR | Position |
|---|---|---|---|---|
${byQuery.map(r => `| ${r.keys[0]} | ${r.clicks} | ${r.impressions} | ${pct(r.ctr)} | ${r.position.toFixed(1)} |`).join('\n')}

## Action items derived from this snapshot

1. Review the LOW-CTR table. For each page with impressions >= 500 and CTR < 3%, rewrite the title or meta description.
2. For pages where Position is 8-15 and CTR is decent, see if internal linking can push them onto page 1.
3. For top queries with avg position > 10, identify which page should rank for them and improve internal linking + content depth.
`

const outPath = path.resolve(process.cwd(), '..', 'gsc-snapshot.md')
await fs.writeFile(outPath, md, 'utf-8')
console.log(`Wrote ${outPath}`)
console.log(`\n=== TOTALS ===\nClicks: ${t.clicks}\nImpressions: ${t.impressions}\nCTR: ${pct(t.ctr)}\nPosition: ${(t.position ?? 0).toFixed(1)}`)
