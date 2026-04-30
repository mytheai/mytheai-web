#!/usr/bin/env node
// Executes a SQL file against Supabase Postgres directly via pg connection.
// Reads DATABASE_URL from .env.local. Wraps multi-statement files in a single transaction
// unless the file already has BEGIN/COMMIT.
//
// Usage:
//   node scripts/run-sql.mjs <sql-file>
//   node scripts/run-sql.mjs tools-batch-54.sql
//   node scripts/run-sql.mjs --dry-run remove-dead-tools.sql   (prints SQL only, doesn't run)
//
// Env requirement:
//   DATABASE_URL=postgresql://postgres.{ref}:{password}@aws-0-{region}.pooler.supabase.com:5432/postgres

import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { Client } from 'pg'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')

const args = process.argv.slice(2)
const dryRun = args.includes('--dry-run')
const sqlPath = args.find(a => !a.startsWith('--'))

if (!sqlPath) {
  console.error('Usage: node scripts/run-sql.mjs <sql-file> [--dry-run]')
  process.exit(1)
}

const fullPath = path.isAbsolute(sqlPath) ? sqlPath : path.join(WEB_ROOT, sqlPath)
const sql = await fs.readFile(fullPath, 'utf-8')

if (dryRun) {
  console.log(`--- DRY RUN: ${sqlPath} (${sql.length} chars, ${sql.split('\n').length} lines) ---`)
  console.log(sql.slice(0, 1000) + (sql.length > 1000 ? '\n... [truncated]' : ''))
  process.exit(0)
}

// Read DATABASE_URL
const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const DATABASE_URL = env.DATABASE_URL

if (!DATABASE_URL) {
  console.error('ERROR: DATABASE_URL missing from .env.local')
  console.error('')
  console.error('Setup steps:')
  console.error('  1. Go to https://supabase.com/dashboard/project/_/settings/database')
  console.error('  2. Copy the "Connection string" → URI (Session mode)')
  console.error('  3. Add to web/.env.local as: DATABASE_URL=postgresql://...')
  console.error('')
  process.exit(1)
}

const client = new Client({
  connectionString: DATABASE_URL,
  ssl: { rejectUnauthorized: false },
})

const t0 = Date.now()
try {
  console.log(`Connecting to Supabase...`)
  await client.connect()
  console.log(`✓ Connected\n`)

  console.log(`Executing ${sqlPath} (${sql.split('\n').length} lines)...`)
  // pg supports multi-statement queries when not parameterized
  const result = await client.query(sql)

  const elapsed = ((Date.now() - t0) / 1000).toFixed(2)
  console.log(`\n✓ Success in ${elapsed}s`)

  // pg returns array of results when multi-statement
  const results = Array.isArray(result) ? result : [result]
  let totalRowsAffected = 0
  let lastSelectRows = null
  for (const r of results) {
    if (r.command && ['INSERT', 'UPDATE', 'DELETE'].includes(r.command)) {
      console.log(`  ${r.command}: ${r.rowCount} rows`)
      totalRowsAffected += r.rowCount ?? 0
    } else if (r.command === 'SELECT' && r.rows?.length) {
      lastSelectRows = r.rows
      console.log(`  SELECT: ${r.rows.length} rows returned`)
    } else if (r.command) {
      console.log(`  ${r.command}: ok`)
    }
  }
  console.log(`\nTotal rows affected: ${totalRowsAffected}`)
  if (lastSelectRows && lastSelectRows.length <= 20) {
    console.log(`\nLast SELECT result:`)
    console.table(lastSelectRows)
  }
} catch (err) {
  console.error(`\n✗ Failed: ${err.message}`)
  if (err.detail) console.error(`  Detail: ${err.detail}`)
  if (err.hint) console.error(`  Hint: ${err.hint}`)
  if (err.position) console.error(`  Position: char ${err.position}`)
  process.exit(1)
} finally {
  await client.end()
}
