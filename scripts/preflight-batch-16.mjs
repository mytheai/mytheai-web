// Pre-flight scan for tasks-batch-16.sql
import fs from 'node:fs/promises'

const sql = await fs.readFile('tasks-batch-16.sql', 'utf-8')

// 1. Em-dash check
const emDashCount = (sql.match(/—/g) || []).length
console.log(`Em-dash count: ${emDashCount}`)

// 2. Contraction scan
const contractionPattern = /\b(don'|won'|can'|isn'|aren'|wasn'|weren'|haven'|hasn'|hadn'|doesn'|wouldn'|couldn'|shouldn'|i'|you'|we'|they'|it'|that's|there's|here's|let'|who's|what's)/gi
const contractions = sql.match(contractionPattern) || []
console.log(`Contractions: ${contractions.length}`)
if (contractions.length) {
  const sample = [...new Set(contractions.slice(0, 10))]
  console.log(`  Sample: ${sample.join(', ')}`)
}

// 3. FAQ JSON validity
const faqBlocks = sql.match(/'\[\s*\{[\s\S]*?\}\s*\]'::jsonb/g) || []
console.log(`FAQ blocks found: ${faqBlocks.length}`)

let parseFails = 0, apostropheIssues = 0
for (let i = 0; i < faqBlocks.length; i++) {
  const block = faqBlocks[i]
  const rawJson = block.slice(1, -8)
  const json = rawJson.replace(/''/g, "'")
  try {
    const parsed = JSON.parse(json)
    if (!Array.isArray(parsed) || parsed.length !== 3) {
      console.log(`  Block ${i+1}: parsed but not 3 FAQs (got ${parsed.length})`)
      parseFails++
    }
  } catch (e) {
    console.log(`  Block ${i+1}: JSON PARSE FAIL - ${e.message.slice(0, 80)}`)
    console.log(`    First 200 chars: ${json.slice(0, 200)}`)
    parseFails++
  }
  const apostropheCount = (rawJson.replace(/''/g, '').match(/'/g) || []).length
  if (apostropheCount > 0) {
    console.log(`  Block ${i+1}: ${apostropheCount} unescaped apostrophe(s) in raw SQL`)
    apostropheIssues++
  }
}

console.log(`\nSummary: ${faqBlocks.length} blocks, ${parseFails} parse fails, ${apostropheIssues} apostrophe issues`)

// 4. Quoted speech detection
const quotedSpeechPattern = /(said|asked|replied|told|wrote|stated)\s*[,]?\s*['']/gi
const quotedSpeech = sql.match(quotedSpeechPattern) || []
console.log(`Quoted speech patterns: ${quotedSpeech.length}`)
