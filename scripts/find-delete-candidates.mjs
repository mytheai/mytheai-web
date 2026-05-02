import pg from 'pg'
const { Client } = pg
const client = new Client({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()
const candidates = [
  'aider','ticktick','lexis-ai','lexisai','lexis','seekout','nosto','evisort','gitpod',
  'github-copilot','microsoft-copilot','microsoft-365-copilot','copilot',
  'looka','jamie','jamie-ai','pabbly-connect','rentlytics','magician','magician-design',
  'immoviewer','rex-real-estate','clockwise','phind'
]
const r = await client.query(
  "SELECT slug, name, website_url, rating, review_count FROM tools WHERE slug = ANY($1) ORDER BY slug",
  [candidates]
)
console.log('Found', r.rows.length, 'tools:')
r.rows.forEach(t => console.log(`  ${t.slug.padEnd(28)} | ${t.name.padEnd(28)} | ${t.website_url}`))
console.log('\nNot found candidates:', candidates.filter(c => !r.rows.find(t => t.slug === c)))
await client.end()
