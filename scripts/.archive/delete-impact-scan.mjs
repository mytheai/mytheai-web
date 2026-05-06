import pg from 'pg'
const { Client } = pg
const client = new Client({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()
const slugs = [
  'aider','clockwise','evisort','github-copilot','gitpod','immoviewer','jamie',
  'lexis-ai','looka','magician','microsoft-365-copilot','nosto','pabbly-connect',
  'phind','rentlytics','rex-real-estate','seekout','ticktick'
]
const cmpA = await client.query(
  "SELECT slug, tool_a_slug, tool_b_slug FROM comparisons WHERE tool_a_slug = ANY($1) OR tool_b_slug = ANY($1) ORDER BY slug",
  [slugs]
)
console.log(`Comparisons impacted: ${cmpA.rows.length}`)
cmpA.rows.forEach(c => console.log(`  ${c.slug}`))
await client.end()
