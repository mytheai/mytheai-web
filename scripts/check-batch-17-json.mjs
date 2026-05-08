import fs from 'node:fs/promises'

const sql = await fs.readFile('tasks-batch-17.sql', 'utf-8')

// Extract every FAQ JSON block (between '[ and ]'::jsonb)
const blockRe = /'\s*(\[[\s\S]*?\])\s*'::jsonb/g
let match
let count = 0
let errors = 0

while ((match = blockRe.exec(sql)) !== null) {
  count++
  const json = match[1]
  try {
    const parsed = JSON.parse(json)
    if (!Array.isArray(parsed)) throw new Error('not an array')
    if (parsed.length !== 3) throw new Error(`expected 3 FAQs, got ${parsed.length}`)
    for (let i = 0; i < parsed.length; i++) {
      const item = parsed[i]
      if (!item.q || !item.a) throw new Error(`FAQ ${i}: missing q or a`)
      if (typeof item.q !== 'string' || typeof item.a !== 'string') throw new Error(`FAQ ${i}: q/a not string`)
    }
    process.stdout.write(`✓ block ${count} (${parsed.length} FAQs)\n`)
  } catch (e) {
    errors++
    process.stdout.write(`✗ block ${count}: ${e.message}\n`)
    process.stdout.write(`   JSON snippet: ${json.slice(0, 100)}...\n`)
  }
}

console.log(`\n=== ${count} FAQ blocks scanned, ${errors} errors ===`)

// Em-dash scan
const emDashCount = (sql.match(/—/g) || []).length
console.log(`Em-dashes: ${emDashCount} (expect 0)`)

// Apostrophe scan: look for unescaped single quotes inside string contexts
// Pattern: a letter followed by ' followed by a letter (likely contraction)
const apostropheMatches = sql.match(/[a-zA-Z]'[a-zA-Z]/g) || []
console.log(`Possible unescaped apostrophes (letter'letter pattern): ${apostropheMatches.length}`)
if (apostropheMatches.length > 0) {
  for (const m of apostropheMatches.slice(0, 10)) console.log(`   "${m}"`)
}

// Show line numbers of any apostrophe trouble
if (apostropheMatches.length > 0) {
  const lines = sql.split('\n')
  for (let i = 0; i < lines.length; i++) {
    if (/[a-zA-Z]'[a-zA-Z]/.test(lines[i])) {
      console.log(`   line ${i+1}: ${lines[i].trim().slice(0, 100)}`)
    }
  }
}

process.exit(errors > 0 || emDashCount > 0 || apostropheMatches.length > 0 ? 1 : 0)
