import 'dotenv/config'
import pg from 'pg'
import fs from 'node:fs/promises'

const env = Object.fromEntries(
  (await fs.readFile('.env.local', 'utf-8')).split('\n')
    .filter(l => l.trim() && !l.startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const c = new pg.Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()
const slugs = ['ai-assistants','writing-ai','image-ai','video-ai','code-ai','seo-marketing','productivity','analytics','voice-audio','crm-sales','email-marketing','automation']
for (const s of slugs) {
  const r = await c.query(`SELECT COUNT(*) FROM tools WHERE $1 = ANY(tags)`, [s])
  console.log(`${s.padEnd(20)} ${r.rows[0].count}`)
}
await c.end()
