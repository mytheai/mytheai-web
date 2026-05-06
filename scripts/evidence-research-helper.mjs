// Evidence research helper - user-driven scores_evidence backfill workflow.
// Usage: prepare a JSON candidate list, run this against URL set, get verified
// URLs out + suggested evidence entries to copy into a backfill SQL.
//
// Lesson from S110: salesforce.com / hubspot.com IR / tableau.com all return
// 403 Cloudflare bot block on direct WebFetch even when URLs are real for
// browsers. This script uses a 2-pass approach:
//   Pass 1: HEAD probe (just checks DNS + cert + status code, less likely
//           to trip bot detection than fetching full content)
//   Pass 2: For 4xx/5xx URLs, mark them as "needs-manual-verify" and let
//           the user paste them into a browser to confirm.
//
// Output: candidates.verified.json with status per URL.

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const inputPath = process.argv[2] || path.join(__dirname, '..', 'evidence-candidates.json')

let candidates
try {
  candidates = JSON.parse(await fs.readFile(inputPath, 'utf-8'))
} catch (e) {
  console.error(`Failed to read ${inputPath}: ${e.message}`)
  console.error('\nExpected JSON shape:')
  console.error(JSON.stringify({
    'tool-slug': {
      criterion_key: [
        { url: 'https://example.com/news', type: 'official-docs', label: 'Description' }
      ]
    }
  }, null, 2))
  process.exit(1)
}

const probe = async (url) => {
  try {
    const ctrl = new AbortController()
    const t = setTimeout(() => ctrl.abort(), 10_000)
    const res = await fetch(url, { method: 'HEAD', signal: ctrl.signal, redirect: 'follow' })
    clearTimeout(t)
    return { ok: res.ok, status: res.status, finalUrl: res.url }
  } catch (e) {
    return { ok: false, status: 0, error: e.message }
  }
}

const results = {}
let total = 0, verified = 0, needsManual = 0
for (const [slug, criteria] of Object.entries(candidates)) {
  results[slug] = {}
  for (const [criterion, entries] of Object.entries(criteria)) {
    results[slug][criterion] = []
    for (const entry of entries) {
      total++
      const probeResult = await probe(entry.url)
      const verdict = probeResult.ok ? 'verified'
        : probeResult.status === 0 ? 'network-error'
        : probeResult.status >= 400 && probeResult.status < 500 ? 'needs-manual-verify'
        : 'server-error'
      if (verdict === 'verified') verified++
      else if (verdict === 'needs-manual-verify') needsManual++
      results[slug][criterion].push({
        ...entry,
        _verdict: verdict,
        _probeStatus: probeResult.status,
        _finalUrl: probeResult.finalUrl,
      })
      console.log(`${verdict.padEnd(22)} ${probeResult.status.toString().padStart(3)}  ${slug}/${criterion}  ${entry.url}`)
    }
  }
}

const outPath = inputPath.replace(/\.json$/, '.verified.json')
await fs.writeFile(outPath, JSON.stringify(results, null, 2))
console.log(`\nTotal: ${total} | Verified (HEAD ok): ${verified} | Needs manual: ${needsManual}`)
console.log(`Output -> ${outPath}`)
console.log(`\nNext: open the .verified.json file. For "needs-manual-verify"`)
console.log(`entries, paste URL into browser and remove if 404. Then build SQL`)
console.log(`UPDATE batch from the verified-only entries.`)
