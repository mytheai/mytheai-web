import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { Client } from 'pg'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')
const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const client = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()

const all = [
  // best-ai-agent-tools
  'manus','crewai','langflow','devin-ai','n8n','dify','agentops','langsmith',
  // best-ai-tools-for-writers
  'sudowrite','reword','wordtune','grammarly','notion-ai',
  // best-workflow-automation-tools
  'zapier','make-com','activepieces','pipedream','workato','bardeen','integrately','tray-io','albato',
  // best-ux-research-tools
  'dovetail','maze','sprig','lyssna','lookback',
  // best-ai-tools-for-agencies
  'jasper','canva-ai','semrush','descript',
]

const { rows } = await client.query(
  `SELECT slug, name FROM tools WHERE slug = ANY($1::text[]) ORDER BY slug`,
  [all]
)
const found = new Set(rows.map(r => r.slug))
console.log('FOUND in DB ('+rows.length+'/'+all.length+'):')
for (const r of rows) console.log(`  ${r.slug.padEnd(25)} ${r.name}`)
console.log()
const missing = all.filter(s => !found.has(s))
if (missing.length) {
  console.log('MISSING:', missing.join(', '))
}
await client.end()
