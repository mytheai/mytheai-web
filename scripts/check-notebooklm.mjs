import pg from 'pg'
const { Client } = pg
const c = new Client({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()
const r = await c.query("SELECT slug, name, website_url, logo_url FROM tools WHERE slug = 'notebooklm'")
console.log(r.rows[0])
await c.end()
