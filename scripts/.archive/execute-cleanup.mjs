#!/usr/bin/env node
// Executes the dead-tool cleanup directly via Supabase REST API.
// 1. Deletes from comparisons (FK reference)
// 2. Deletes from tool_clicks
// 3. Deletes from tools
// 4. Runs clean-top10.mjs

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { execSync } from 'node:child_process'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')

const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const SUPABASE_URL = env.NEXT_PUBLIC_SUPABASE_URL
const SUPABASE_KEY = env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY

const report = JSON.parse(await fs.readFile(path.join(WEB_ROOT, 'dead-tools-report.json'), 'utf-8'))
const deadSlugs = [...new Set([...report.dead.map(d => d.slug), ...(report.manual_dead_slugs ?? [])])]
console.log(`Cleaning up ${deadSlugs.length} dead tools: ${deadSlugs.join(', ')}\n`)

const headers = {
  apikey: SUPABASE_KEY,
  Authorization: `Bearer ${SUPABASE_KEY}`,
  'Content-Type': 'application/json',
  Prefer: 'return=representation',
}

// Build PostgREST `in.()` filter
const inFilter = `in.(${deadSlugs.map(s => `"${s}"`).join(',')})`

async function tryDelete(table, column) {
  const url = `${SUPABASE_URL}/rest/v1/${table}?${column}=${inFilter}`
  const res = await fetch(url, { method: 'DELETE', headers })
  const body = await res.text()
  return { status: res.status, body, ok: res.ok }
}

console.log('Step 1: DELETE FROM comparisons (tool_a_slug)...')
const r1 = await tryDelete('comparisons', 'tool_a_slug')
console.log(`  ${r1.status} - ${r1.ok ? 'OK' : r1.body.slice(0, 200)}`)

console.log('Step 2: DELETE FROM comparisons (tool_b_slug)...')
const r2 = await tryDelete('comparisons', 'tool_b_slug')
console.log(`  ${r2.status} - ${r2.ok ? 'OK' : r2.body.slice(0, 200)}`)

console.log('Step 3: DELETE FROM tool_clicks (tool_slug)...')
const r3 = await tryDelete('tool_clicks', 'tool_slug')
console.log(`  ${r3.status} - ${r3.ok ? 'OK' : r3.body.slice(0, 200)}`)

console.log('Step 4: DELETE FROM tools (slug)...')
const r4 = await tryDelete('tools', 'slug')
console.log(`  ${r4.status} - ${r4.ok ? 'OK' : r4.body.slice(0, 200)}`)

const allOk = r1.ok && r2.ok && r3.ok && r4.ok
console.log(`\nDB cleanup: ${allOk ? 'SUCCESS' : 'FAILED - check errors above'}`)

if (allOk) {
  // Verify
  const verify = await fetch(`${SUPABASE_URL}/rest/v1/tools?slug=${inFilter}&select=slug`, { headers })
  const remaining = await verify.json()
  console.log(`\nVerify: ${remaining.length} of ${deadSlugs.length} dead tools still in DB`)
  if (remaining.length > 0) {
    console.log('  Still present:', remaining.map(t => t.slug).join(', '))
  }

  console.log('\nStep 5: Running clean-top10.mjs...')
  try {
    const out = execSync(`node ${path.join(__dirname, 'clean-top10.mjs')}`, { encoding: 'utf-8' })
    console.log(out.trim())
  } catch (e) {
    console.log('  Failed:', e.message)
  }
}
