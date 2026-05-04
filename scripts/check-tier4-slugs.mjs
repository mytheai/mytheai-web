import fs from 'node:fs/promises'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import { Client } from 'pg'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const WEB_ROOT = path.join(__dirname, '..')
const envText = await fs.readFile(path.join(WEB_ROOT, '.env.local'), 'utf-8')
const env = Object.fromEntries(
  envText.split('\n').filter(l => l.trim() && !l.trim().startsWith('#') && l.includes('='))
    .map(l => { const [k, ...r] = l.split('='); return [k.trim(), r.join('=').trim()] })
)
const client = new Client({ connectionString: env.DATABASE_URL, ssl: { rejectUnauthorized: false } })
await client.connect()

const candidates = [
  'trello','jira','basecamp','todoist','smartsheet','miro','mural','wrike',
  'zendesk','intercom','freshdesk','helpscout','tidio','front','help-scout',
  'mixpanel','amplitude','hotjar','fullstory','posthog','heap','pendo',
  'mailchimp','klaviyo','brevo','convertkit','customer-io','beehiiv',
  'loom','riverside-fm','opus-clip','vidyard',
  'attio','copper','folk','close',
  'vercel','netlify','supabase','retool','bubble','webflow',
  'sentry','datadog','new-relic','segment','rudderstack',
  'calendly','savvycal','superhuman','typeform','jotform','tally','docusign','dropbox-sign',
  'character-ai','poe','tana','reflect','readwise',
  'bardeen','clay','outreach','salesloft','reply-io',
  'sunsama','akiflow','height','shortcut',
  'plaid','stripe','contentful','sanity','strapi'
]
const { rows } = await client.query(`SELECT slug FROM tools WHERE slug = ANY($1::text[]) ORDER BY slug`, [candidates])
const found = rows.map(r=>r.slug)
console.log('FOUND ('+found.length+'):')
console.log(found.join(', '))
console.log('\nMISSING ('+(candidates.length-found.length)+'):')
console.log(candidates.filter(s => !found.includes(s)).join(', '))

const { rows: filledRows } = await client.query(`SELECT COUNT(*)::int as c FROM tools WHERE array_length(integrations, 1) > 0`)
console.log('\nCurrent integrations-filled tools:', filledRows[0].c)

// Now check which of the FOUND slugs already have integrations seeded
const { rows: alreadySeeded } = await client.query(`SELECT slug FROM tools WHERE slug = ANY($1::text[]) AND array_length(integrations, 1) > 0 ORDER BY slug`, [found])
console.log('\nALREADY SEEDED ('+alreadySeeded.length+'):', alreadySeeded.map(r=>r.slug).join(', '))
const needBackfill = found.filter(s => !alreadySeeded.find(r => r.slug === s))
console.log('\nNEED BACKFILL ('+needBackfill.length+'):')
console.log(needBackfill.join(', '))

await client.end()
