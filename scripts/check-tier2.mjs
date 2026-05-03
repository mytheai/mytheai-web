import pg from 'pg'
const { Client } = pg
const c = new Client({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()
const candidates = ['chatgpt', 'midjourney', 'perplexity', 'gemini', 'v0', 'vercel-v0', 'bolt', 'windsurf', 'zapier', 'canva-ai', 'grammarly', 'notion-ai', 'replit', 'lovable', 'figma', 'make-com']
const r = await c.query("SELECT slug, name, website_url, review_count, rating FROM tools WHERE slug = ANY($1) ORDER BY review_count DESC NULLS LAST", [candidates])
r.rows.forEach(t => console.log(`${t.slug.padEnd(15)} | ${t.name.padEnd(20)} | ${t.review_count} reviews | ${t.rating}★ | ${t.website_url}`))
console.log('\nMissing:', candidates.filter(c => !r.rows.find(t => t.slug === c)).join(', '))
await c.end()
