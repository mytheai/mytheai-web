import pg from 'pg'
const { Client } = pg
const c = new Client({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()
const broken = ['adobe-acrobat-ai', 'scribe', 'detangle-ai', 'make', 'play-ht']
for (const b of broken) {
  const r = await c.query("SELECT slug, name FROM tools WHERE slug LIKE $1 OR name ILIKE $2 LIMIT 3", [`%${b}%`, `%${b.replace(/-/g, ' ')}%`])
  console.log(`Searching for "${b}":`)
  r.rows.forEach(t => console.log(`  ${t.slug} | ${t.name}`))
}
await c.end()
