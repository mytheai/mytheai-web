// Pre-run JSON validator for tasks-batch-10.sql FAQs
// S118 lesson: PostgreSQL JSON parse errors give char-offset only, not line numbers.

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const sqlPath = path.join(__dirname, '..', 'tasks-batch-10.sql')
const sql = await fs.readFile(sqlPath, 'utf-8')

const lines = sql.split('\n')
let inJson = false
let jsonStart = -1
let buf = []
let errors = 0
let total = 0

for (let i = 0; i < lines.length; i++) {
  const line = lines[i]
  if (!inJson && line.trim().startsWith("'[")) {
    inJson = true
    jsonStart = i + 1
    buf = [line.trim().replace(/^'/, '')]
    continue
  }
  if (inJson) {
    if (line.includes("]'::jsonb")) {
      const cleaned = line.replace(/\]'::jsonb.*$/, ']')
      buf.push(cleaned)
      const fullJson = buf.join('\n')
      total++
      try {
        const parsed = JSON.parse(fullJson)
        if (!Array.isArray(parsed) || parsed.length !== 3) {
          console.log(`  WARN line ${jsonStart}: parsed but not 3-FAQ array (${parsed.length})`)
        }
      } catch (e) {
        errors++
        console.log(`  FAIL line ${jsonStart}: ${e.message}`)
        console.log(`  preview: ${fullJson.slice(0, 200)}...`)
      }
      inJson = false
      buf = []
    } else {
      buf.push(line)
    }
  }
}

console.log(`\n=== ${total} FAQ JSON blocks parsed, ${errors} errors ===`)
process.exit(errors > 0 ? 1 : 0)
