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

const candidates = [
  // AI Infrastructure
  'pinecone','weaviate','qdrant','chroma','langchain','llamaindex','replicate',
  'huggingface','cohere','mistral','anthropic','openai',
  // Design tools
  'framer','invision','sketch','figjam','figma',
  // Note-taking + PKM
  'obsidian','logseq','roam-research','anytype','capacities','tana','reflect',
  // Video AI
  'descript','captions','submagic','kling','viggle','runwayml','pika',
  // Productivity micro
  'todoist','things','fantastical','sunsama','akiflow','motion',
  // Generative
  'leonardo-ai','playground-ai','ideogram','recraft','flux','sora',
  // Writing
  'sudowrite','novelai','rytr','wordtune',
  // Email + outreach
  'superhuman','hey','missive','front',
  // LLM API + infra
  'groq','perplexity','character-ai','poe',
  // Search/research
  'consensus','elicit','scite','semantic-scholar',
  // Workflow
  'n8n','activepieces','pipedream','make-com','bardeen',
  // Data tools
  'dbt','snowflake','databricks','airbyte','fivetran',
  // Vector/AI search
  'glean','dust','exa-ai',
  // Scheduling/forms
  'calendly','savvycal','tally','jotform',
  // Voice
  'eleven-labs','elevenlabs','play-ht','resemble-ai',
  // Code
  'codeium','tabnine','sourcegraph','phind',
]

const { rows } = await client.query(
  `SELECT slug FROM tools WHERE slug = ANY($1::text[]) ORDER BY slug`,
  [candidates]
)
const found = rows.map(r=>r.slug)
console.log('FOUND ('+found.length+' / '+candidates.length+'):')
console.log(found.join(', '))
console.log('\nMISSING ('+(candidates.length-found.length)+'):')
console.log(candidates.filter(s => !found.includes(s)).join(', '))

const { rows: filledRows } = await client.query(
  `SELECT COUNT(*)::int as c FROM tools WHERE array_length(integrations, 1) > 0`
)
console.log('\nCurrent integrations-filled tools:', filledRows[0].c)

const { rows: alreadySeeded } = await client.query(
  `SELECT slug FROM tools WHERE slug = ANY($1::text[]) AND array_length(integrations, 1) > 0 ORDER BY slug`,
  [found]
)
console.log('\nALREADY SEEDED ('+alreadySeeded.length+'):', alreadySeeded.map(r=>r.slug).join(', '))
const needBackfill = found.filter(s => !alreadySeeded.find(r => r.slug === s))
console.log('\nNEED BACKFILL ('+needBackfill.length+'):')
console.log(needBackfill.join(', '))

await client.end()
