// S109 IRIA: audit /tools/[slug] references across blog MDX, top10.ts, compareEnrichment.ts
// against the live tools table. Reports broken refs in JSON + summary.
// S123: extended to also audit hardcoded /top-10/, /categories/, /blog/ hrefs in src + content.
import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { Client } from 'pg'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')
const BLOG_DIR = path.join(WEB_ROOT, 'content', 'blog')
const SRC_DIR = path.join(WEB_ROOT, 'src')
const MOCK_PATH = path.join(WEB_ROOT, 'src', 'data', 'mock.ts')
const TOP10_PATH = path.join(WEB_ROOT, 'src', 'data', 'top10.ts')
const COMPARE_PATH = path.join(WEB_ROOT, 'src', 'data', 'compareEnrichment.ts')

const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const client = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()
const { rows } = await client.query('SELECT slug FROM tools')
const live = new Set(rows.map(r => r.slug))
await client.end()

// 1. Scan blog MDX for /tools/[slug] - markdown link pattern + bare URL
const blogFiles = (await fs.readdir(BLOG_DIR)).filter(f => f.endsWith('.mdx'))
const blogBroken = [] // [{file, slug, ctx}]
const blogAllRefs = new Set()

for (const file of blogFiles) {
  const txt = await fs.readFile(path.join(BLOG_DIR, file), 'utf-8')
  // Match /tools/slug-name (alphanumeric + hyphens), exclude trailing punctuation/quotes
  const re = /\/tools\/([a-z0-9][a-z0-9-]*[a-z0-9])(?=[\s\)\]"'#?,.!]|$)/gi
  let m
  const seen = new Set()
  while ((m = re.exec(txt)) !== null) {
    const slug = m[1]
    if (seen.has(slug)) continue
    seen.add(slug)
    blogAllRefs.add(slug)
    if (!live.has(slug)) {
      // capture small context
      const start = Math.max(0, m.index - 60)
      const end = Math.min(txt.length, m.index + 80)
      blogBroken.push({ file, slug, ctx: txt.slice(start, end).replace(/\n/g, ' ') })
    }
  }
}

// 2. Scan top10.ts - both `slugs:` array AND `picks: [{ slug: '...' }]`
const top10Txt = await fs.readFile(TOP10_PATH, 'utf-8')
const top10Broken = [] // [{listSlug, kind, slug}]
// Parse list-by-list: split on opening `slug: '<name>',` per top-level entry
// Simpler approach: extract each list's slugs:[...] and picks:[{slug:''...}]
const listRe = /slug:\s*'([^']+)',[\s\S]*?slugs:\s*\[([^\]]*)\]/g
let lm
while ((lm = listRe.exec(top10Txt)) !== null) {
  const listSlug = lm[1]
  const slugsRaw = lm[2]
  const innerSlugs = [...slugsRaw.matchAll(/'([^']+)'/g)].map(x => x[1])
  for (const s of innerSlugs) {
    if (!live.has(s)) top10Broken.push({ listSlug, kind: 'slugs', slug: s })
  }
}

// picks: [{ slug: 'x', ... }, ...] - scope to inside `picks: [...]` arrays only
const picksBlockRe = /picks:\s*\[([\s\S]*?)\],\s*bottomLine:/g
let pbm
const pickSet = new Set()
while ((pbm = picksBlockRe.exec(top10Txt)) !== null) {
  const block = pbm[1]
  const innerRe = /slug:\s*'([^']+)'/g
  let im
  while ((im = innerRe.exec(block)) !== null) {
    const s = im[1]
    if (pickSet.has(s)) continue
    pickSet.add(s)
    if (!live.has(s)) top10Broken.push({ listSlug: '(pick)', kind: 'pick', slug: s })
  }
}

// 3. Scan compareEnrichment.ts keys
const compareTxt = await fs.readFile(COMPARE_PATH, 'utf-8')
const compareBroken = [] // [{pair, slug, role}]
const keyRe = /^\s*'([a-z0-9-]+-vs-[a-z0-9-]+)':/gm
let km
const compareChains = []
while ((km = keyRe.exec(compareTxt)) !== null) {
  const key = km[1]
  // Detect 3+ way (multiple -vs-)
  const vsCount = (key.match(/-vs-/g) || []).length
  if (vsCount >= 2) {
    compareChains.push(key)
    continue
  }
  // Split on -vs- once for binary pair
  const idx = key.indexOf('-vs-')
  const a = key.slice(0, idx)
  const b = key.slice(idx + 4)
  if (!live.has(a)) compareBroken.push({ pair: key, slug: a, role: 'A' })
  if (!live.has(b)) compareBroken.push({ pair: key, slug: b, role: 'B' })
}

// 4. Scan src/**/*.{tsx,ts} + content/blog/**/*.mdx for HARDCODED literal hrefs
//    /top-10/<slug>, /categories/<slug>, /blog/<slug>. Skip template literals (slug followed by `$`).
const validTop10 = new Set(
  [...top10Txt.matchAll(/^    slug:\s*'([^']+)'/gm)].map(m => m[1])
)
const mockTxt = await fs.readFile(MOCK_PATH, 'utf-8')
const validCategories = new Set(
  [...mockTxt.matchAll(/slug:\s*'([^']+)'/g)].map(m => m[1])
)
const validBlogs = new Set(blogFiles.map(f => f.replace(/\.mdx$/, '')))

const hrefBroken = { top10: [], category: [], blog: [] }

async function walk(dir) {
  const entries = await fs.readdir(dir, { withFileTypes: true })
  for (const e of entries) {
    const p = path.join(dir, e.name)
    if (e.isDirectory()) {
      if (e.name === 'node_modules' || e.name === '.next' || e.name === '.archive') continue
      await walk(p)
    } else if (/\.(tsx|ts|mdx)$/.test(e.name)) {
      const txt = await fs.readFile(p, 'utf-8')
      const lines = txt.split('\n')
      lines.forEach((ln, i) => {
        const scan = (re, validSet, bucket) => {
          let m
          while ((m = re.exec(ln)) !== null) {
            const slug = m[1]
            // Skip if next char is `$` (template literal continuation)
            const nextIdx = m.index + m[0].length
            if (ln[nextIdx] === '$') continue
            if (!validSet.has(slug)) {
              bucket.push({ file: path.relative(WEB_ROOT, p), line: i + 1, slug })
            }
          }
        }
        // Slash must be preceded by quote/paren/whitespace/bracket - excludes template-literal continuations
        scan(/[\s"'(\[]\/top-10\/([a-z0-9][a-z0-9-]*)/g, validTop10, hrefBroken.top10)
        scan(/[\s"'(\[]\/categories\/([a-z0-9][a-z0-9-]*)/g, validCategories, hrefBroken.category)
        scan(/[\s"'(\[]\/blog\/([a-z0-9][a-z0-9-]*)/g, validBlogs, hrefBroken.blog)
      })
    }
  }
}
await walk(SRC_DIR)
await walk(BLOG_DIR)

// Output
const report = {
  blogs_scanned: blogFiles.length,
  blog_total_refs: blogAllRefs.size,
  blog_broken: blogBroken,
  top10_broken: top10Broken,
  compare_broken: compareBroken,
  compare_chains_skipped: compareChains,
  href_broken_top10: hrefBroken.top10,
  href_broken_categories: hrefBroken.category,
  href_broken_blogs: hrefBroken.blog,
  live_tool_count: live.size,
  top10_list_count: validTop10.size,
  categories_count: validCategories.size,
}

console.log('=== Internal Refs Audit ===')
console.log(`Blogs scanned: ${blogFiles.length} (${blogAllRefs.size} distinct slugs referenced)`)
console.log(`Live tools: ${live.size} | Top10 lists: ${validTop10.size} | Categories: ${validCategories.size}`)
console.log()
console.log(`Blog broken /tools/ refs: ${blogBroken.length}`)
blogBroken.slice(0, 30).forEach(b => console.log(`  ${b.file.padEnd(50)} -> /tools/${b.slug}`))
if (blogBroken.length > 30) console.log(`  ...(${blogBroken.length - 30} more)`)
console.log()
console.log(`Top10 broken /tools/ refs: ${top10Broken.length}`)
top10Broken.forEach(t => console.log(`  ${t.listSlug.padEnd(40)} (${t.kind}) -> ${t.slug}`))
console.log()
console.log(`Compare broken /tools/ refs: ${compareBroken.length}`)
compareBroken.forEach(c => console.log(`  ${c.pair.padEnd(40)} (${c.role}) -> ${c.slug}`))
console.log()
console.log(`Compare 3+ way chains skipped (manual review if needed): ${compareChains.length}`)
compareChains.forEach(c => console.log(`  ${c}`))
console.log()
console.log(`Hardcoded /top-10/ broken refs: ${hrefBroken.top10.length}`)
hrefBroken.top10.forEach(b => console.log(`  ${b.file}:${b.line} -> /top-10/${b.slug}`))
console.log(`Hardcoded /categories/ broken refs: ${hrefBroken.category.length}`)
hrefBroken.category.forEach(b => console.log(`  ${b.file}:${b.line} -> /categories/${b.slug}`))
console.log(`Hardcoded /blog/ broken refs: ${hrefBroken.blog.length}`)
hrefBroken.blog.forEach(b => console.log(`  ${b.file}:${b.line} -> /blog/${b.slug}`))

// Write JSON for record
await fs.writeFile(path.join(WEB_ROOT, 'audit-internal-refs.json'), JSON.stringify(report, null, 2))
console.log('\nFull report -> audit-internal-refs.json')

const totalBroken = blogBroken.length + top10Broken.length + compareBroken.length
  + hrefBroken.top10.length + hrefBroken.category.length + hrefBroken.blog.length
if (totalBroken > 0) {
  console.error(`\nFAIL: ${totalBroken} broken internal refs across all dimensions.`)
  process.exit(1)
}
console.log('\nPASS: 0 broken internal refs.')
