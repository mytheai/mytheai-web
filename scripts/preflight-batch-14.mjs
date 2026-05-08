// Pre-flight scan for tasks-batch-14.sql
import fs from 'node:fs/promises'

const sql = await fs.readFile('tasks-batch-14.sql', 'utf-8')

// 1. Em-dash check (already verified via grep but double-check here)
const emDashCount = (sql.match(/—/g) || []).length
console.log(`Em-dash count: ${emDashCount}`)

// 2. Apostrophe scan inside JSON content (between '[' jsonb cast)
// Find all FAQ jsonb blocks and check for unescaped single quotes inside JSON values
const faqBlocks = sql.match(/'\[\s*\{[\s\S]*?\}\s*\]'::jsonb/g) || []
console.log(`FAQ blocks found: ${faqBlocks.length}`)

let parseFails = 0
let apostropheIssues = 0
for (let i = 0; i < faqBlocks.length; i++) {
  const block = faqBlocks[i]
  // Strip outer ' and ::jsonb to get raw JSON
  const rawJson = block.slice(1, -8) // remove leading ' and trailing '::jsonb
  // Replace SQL-escaped doubled quotes ('') back to single quote for JSON parsing
  const json = rawJson.replace(/''/g, "'")
  try {
    const parsed = JSON.parse(json)
    if (!Array.isArray(parsed) || parsed.length !== 3) {
      console.log(`  Block ${i+1}: JSON parsed but not 3 FAQs (got ${parsed.length})`)
      parseFails++
    }
  } catch (e) {
    console.log(`  Block ${i+1}: JSON PARSE FAIL - ${e.message.slice(0, 80)}`)
    console.log(`    First 200 chars: ${json.slice(0, 200)}`)
    parseFails++
  }
  // Count unescaped apostrophes in raw block (excluding doubled '')
  const singleApostrophes = rawJson.replace(/''/g, '').match(/'/g)
  if (singleApostrophes && singleApostrophes.length > 0) {
    console.log(`  Block ${i+1}: ${singleApostrophes.length} unescaped apostrophe(s) in raw SQL`)
    apostropheIssues++
  }
}

console.log(`\nSummary: ${faqBlocks.length} blocks, ${parseFails} parse fails, ${apostropheIssues} apostrophe issues`)

// 3. Also scan whole file for likely-unescaped apostrophes in OUTER VALUES strings
// (intro, methodology fields)
const valuesMatches = sql.matchAll(/'((?:[^']|'')*)'\s*::?\s*(?:jsonb|text|TEXT)?\s*[,)]/g)
let valueApostropheCount = 0
for (const m of valuesMatches) {
  const inner = m[1]
  // Inside intro/methodology strings, doubled '' is the escape
  // If we find a single ' (not doubled) it should already be escaped or it's a syntax issue
  // Since the regex captures `[^']|''` we should only see clean text here
  // Just do a sanity check: count occurrences of patterns like `dbt's` or `team's`
  if (/[a-zA-Z]'[a-zA-Z]/.test(inner.replace(/''/g, ''))) {
    console.log(`  POSSIBLE outer-value apostrophe issue in: ${inner.slice(0, 100)}`)
    valueApostropheCount++
  }
}
console.log(`Outer-value apostrophe checks: ${valueApostropheCount} potential issues`)
