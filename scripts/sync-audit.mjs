import pg from 'pg'
import fs from 'fs/promises'
import path from 'path'
const { Client } = pg
const c = new Client({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await c.connect()

const tools = await c.query("SELECT slug FROM tools")
const toolSlugs = new Set(tools.rows.map(r => r.slug))

const cmps = await c.query("SELECT slug, tool_a_slug, tool_b_slug FROM comparisons")
const brokenCompares = cmps.rows.filter(r => !toolSlugs.has(r.tool_a_slug) || !toolSlugs.has(r.tool_b_slug))

const top10Path = path.resolve('src/data/top10.ts')
const top10Content = await fs.readFile(top10Path, 'utf-8')
const top10SlugRegex = /slugs:\s*\[([^\]]+)\]/g
const allTop10Slugs = new Set()
let m
while ((m = top10SlugRegex.exec(top10Content)) !== null) {
  m[1].split(',').forEach(s => {
    const cleaned = s.trim().replace(/^['"]|['"]$/g, '')
    if (cleaned) allTop10Slugs.add(cleaned)
  })
}
const brokenTop10Slugs = [...allTop10Slugs].filter(s => !toolSlugs.has(s))

const blogDir = path.resolve('content/blog')
const blogFiles = (await fs.readdir(blogDir)).filter(f => f.endsWith('.mdx'))
const blogBrokenLinks = []
for (const f of blogFiles) {
  const content = await fs.readFile(path.join(blogDir, f), 'utf-8')
  const linkRegex = /\/tools\/([a-z0-9-]+)/g
  let lm
  while ((lm = linkRegex.exec(content)) !== null) {
    if (!toolSlugs.has(lm[1])) {
      blogBrokenLinks.push(`${f}: /tools/${lm[1]}`)
    }
  }
}

const cats = await c.query(`
  SELECT unnest(tags) AS tag, COUNT(*) AS cnt
  FROM tools GROUP BY tag ORDER BY cnt DESC
`)

console.log('=== AUDIT REPORT ===')
console.log(`Total tools in DB: ${toolSlugs.size}`)
console.log(`Total comparisons: ${cmps.rows.length}`)
console.log(`Top10 unique slugs referenced: ${allTop10Slugs.size}`)
console.log(`Blog files: ${blogFiles.length}`)
console.log()
console.log(`Broken comparisons (FK to deleted tool): ${brokenCompares.length}`)
brokenCompares.forEach(r => console.log(`  ${r.slug}: a=${r.tool_a_slug} b=${r.tool_b_slug}`))
console.log()
console.log(`Broken top10 slugs (in top10.ts but not DB): ${brokenTop10Slugs.length}`)
brokenTop10Slugs.forEach(s => console.log(`  ${s}`))
console.log()
console.log(`Broken blog /tools/[slug] links: ${blogBrokenLinks.length}`)
blogBrokenLinks.forEach(l => console.log(`  ${l}`))
console.log()
console.log(`Top 30 tags:`)
cats.rows.slice(0, 30).forEach(r => console.log(`  ${r.tag}: ${r.cnt}`))

await c.end()
