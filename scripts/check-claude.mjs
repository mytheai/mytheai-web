import pg from 'pg'
const { Client } = pg
const c = new Client({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()
const r = await c.query("SELECT slug, name, website_url, rating, review_count, editor_pick, logo_url FROM tools WHERE slug IN ('claude','lovable') ORDER BY slug")
r.rows.forEach(t => console.log(t))
await c.end()
