# MytheAi Runbook

Self-service incident response during founder pause. Use when site behaves unexpectedly and you do not have an agent / Claude session running.

Created: 2026-05-10 (S161 freeze prep). Founder: John Pham.

---

## Daily check (none required)

A GitHub Actions cron job (`.github/workflows/uptime-monitor.yml`) probes production every 5 minutes. On any failure it opens a GitHub Issue in this repo, and GitHub emails you (as the repo owner). If your inbox stays quiet, production is healthy.

Monitor dashboard: https://github.com/mytheai/mytheai-web/actions/workflows/uptime-monitor.yml

To pause monitoring (e.g. during planned maintenance): edit the workflow file and comment out the `schedule:` block, then push.

---

## Scenario 1: mytheai.com returns 5xx / blank page

Most likely cause: **Vercel env vars wiped** (this happened 2026-05-10, see CLAUDE.md S159 row).

### Quick diagnosis

1. Open https://vercel.com/mytheais-projects/project-71zh9/deployments
2. Look at the latest deploy. If it shows "Failed" with `supabaseUrl is required` or similar env-related error: env vars are wiped. Skip to "Restore env vars" below.
3. If deploy shows "Ready" but site still 5xx: it is a runtime issue, not env. Check Supabase status at https://status.supabase.com first.

### Restore env vars

**Source-of-truth:** all 6 env vars can be retrieved from their respective service dashboards. There is no plaintext backup file — pull values fresh each time to avoid stale-key drift.

1. Open the source dashboards in 6 tabs and grab each value:

   | Env var | Where to get it |
   |---|---|
   | `NEXT_PUBLIC_SUPABASE_URL` | https://supabase.com/dashboard/project/_/settings/api → Project URL |
   | `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` | Same page → Project API keys → `anon public` |
   | `SUPABASE_SERVICE_ROLE_KEY` | Same page → Project API keys → `service_role` (CRITICAL — bypasses RLS, never log) |
   | `DATABASE_URL` | https://supabase.com/dashboard/project/_/settings/database → Connection string → URI mode (replace `[YOUR-PASSWORD]` with the DB password from your Supabase signup) |
   | `INDEXNOW_KEY` | https://www.bing.com/indexnow → existing key (or regenerate + re-upload `/public/<key>.txt`) |
   | `PLAUSIBLE_API_KEY` | https://plausible.io/settings/api-keys |

2. Open https://vercel.com/account/tokens, generate a 1-day token (label "incident-fix").
3. In a terminal at `D:\MytheAi\web`:
   ```bash
   export VERCEL_TOKEN=<paste token>
   vercel link --project project-71zh9 --scope mytheais-projects --yes
   ```
4. For each of the 6 env vars:
   ```bash
   echo "<VALUE>" | vercel env add <NAME> production
   ```
5. Redeploy: `vercel --prod`
6. Wait ~30s, then verify: `curl -sI https://mytheai.com` returns `HTTP/2 200`.
7. **Revoke the 1-day token** at https://vercel.com/account/tokens.

---

## Scenario 2: Affiliate /go/ links broken (clicks not redirecting)

Symptom: `/go/claude` returns 404 or stays on mytheai.com instead of redirecting to claude.ai.

### Quick test

```bash
curl -sI https://mytheai.com/go/claude
```

Expected: `HTTP/2 307` with `location:` header pointing to claude.ai. If 404 or no location header: route is broken.

### Likely causes

- **`affiliate_url` field empty in Supabase tools table** for that slug. Check via Supabase Dashboard → Tables → tools → search slug → confirm `affiliate_url` populated.
- **Route file missing** at `D:\MytheAi\web\src\app\go\[slug]\route.ts`. Should exist and read from Supabase. If missing, restore from git history: `git log --all --diff-filter=D -- src/app/go/[slug]/route.ts`.

If only 1-2 specific tools broken, edit affiliate_url in Supabase. If ALL tools broken, restore route file or revert to last working commit.

---

## Scenario 3: Newsletter / Review form not working

Symptom: founder sees "submit failed" reports from users, or nothing arrives in Supabase tables.

### Newsletter check

1. Go to https://mytheai.com, scroll to footer, submit a test email.
2. Open Supabase Dashboard → Tables → `newsletter_subscriptions`. New row should appear.
3. If 500 error in browser console: check Vercel function logs at https://vercel.com/mytheais-projects/project-71zh9/logs. Search for `newsletter`.

### Review form check (anti-bot pipeline per S93)

1. Pick any tool page (e.g. /tools/claude), scroll to reviews section, submit a test review.
2. Wait >4 seconds before clicking submit (timing check).
3. Use realistic content: 4+ words in `bestFor` and `limitation` fields, mostly letters not digits.
4. After submit, check Supabase Dashboard → Tables → `tool_reviews` → filter by tool_slug. Status should be `approved` if all anti-bot gates passed.
5. **If status is `pending`**: SUPABASE_SERVICE_ROLE_KEY is missing on Vercel. Restore via Scenario 1 instructions, then re-test.
6. **If 500 error**: check Vercel logs for `reviews` API errors.

Always delete your test rows after via Supabase SQL Editor: `DELETE FROM tool_reviews WHERE rating = X AND created_at > NOW() - INTERVAL '10 minutes';`

---

## Scenario 4: Search Console showing crawl errors

Open https://search.google.com/search-console for mytheai.com. If you see new "Coverage" issues:

- **404s for /tools/[slug]**: a tool was deleted from DB but URL is still in sitemap or external links. Either re-add the tool (if deletion was wrong) or accept the 404 (Google will drop it after ~30 days).
- **5xx errors**: see Scenario 1.
- **Soft 404**: page renders but Google thinks it is empty. Most often happens on /alternatives/[slug] for tools with no alternatives in DB. Check the tool's `alternatives` array in Supabase.

After fixing, click "Validate fix" in GSC.

---

## Scenario 5: A specific tool page renders broken / missing data

Symptom: /tools/some-tool shows blank logo, missing description, broken comparison link.

### Quick check

1. Open Supabase Dashboard → Tables → tools → search slug.
2. Confirm these fields are populated: `name`, `slug`, `tagline`, `description`, `website_url`, `pricing_type`.
3. If `website_url` is missing or has bad domain: LogoImage component falls back to letter avatar. Update the URL.
4. If `description` is empty: page will render with blank body. Add markdown content.

If many tools broken at once: the Supabase `.select()` query in `src/app/tools/[slug]/page.tsx` may be missing fields after a refactor. Check git log for recent changes to that file.

---

## Scenario 6: Vercel deploy succeeds but new content not appearing

Symptom: you committed + pushed but the change is not live after 5 minutes.

1. Check https://vercel.com/mytheais-projects/project-71zh9/deployments — is there a "Ready" deployment for your commit hash?
2. If yes but content still missing: it is ISR caching. Most pages cache for 7 days. Force revalidation:
   - Open Vercel Dashboard → Project → Settings → Functions → "Purge Cache" (or use the CLI).
   - Or wait for next ISR cycle.
3. If no deployment triggered: check GitHub webhook at Vercel Settings → Git. Re-link if disconnected.

---

## How to know what is normal

After freeze prep (2026-05-10), expected baseline:
- mytheai.com homepage: HTTP 200, ~0.5s response time
- Sitemap: 1684 URLs
- Tools in DB: 584
- Tasks in DB: 506
- Hands-on reviews (`tested_by IS NOT NULL`): 95
- Money pages /best/[category]: 16 routes
- /go/[slug] top-20 affiliate redirects: all 307 with valid location header
- JSON-LD schemas: 6 blocks on /tools/[slug], 5 on /best/[category], 5 on /compare/[a-vs-b]

Any major drift from these numbers warrants investigation when founder returns.

---

## When to call for help

If the issue is not in this runbook AND you cannot fix it in 30 minutes, options:
1. **Revert to last known good commit**: `cd D:\MytheAi\web && git log --oneline -10` find a recent commit before the issue, then `git revert <hash>` (creates new commit with the revert) and push.
2. **Open a Claude Code session** at `D:\MytheAi` and paste this runbook + the symptom — it has full project context via CLAUDE.md.
3. **Vercel support** at https://vercel.com/help — for platform-level outages they will respond fast.
4. **Supabase support** at https://supabase.com/support — for DB-level issues.

---

## Quarterly maintenance reminders

These are not urgent during the pause but worth doing if you have 30 minutes once per quarter:

- **Bump `last_tested_at`** for the 95 hands-on reviews (signals editorial currency):
  ```sql
  UPDATE tools SET last_tested_at = '2026-08-08'
  WHERE tested_by = 'John Pham' AND hands_on_notes IS NOT NULL;
  ```
- **Re-run dead-tool sweep**: `cd D:\MytheAi\web && node --env-file=.env.local scripts/check-dead-tools.mjs` — review `dead-tools-report.json` and `suspect-tools.md`. Most flagged tools are Cloudflare-VN false positives; only act on `dns-fail` / `parking-domain` reasons.
- **Re-ping IndexNow**: `node --env-file=.env.local scripts/indexnow-ping.mjs --recent 90` (URLs modified in last 90 days).
- **Pricing refresh**: bump `pricing_verified_at` on top 100 tools (signals freshness on TrustStack).

---

That is everything. The site is designed to run on autopilot during a multi-month pause. The most likely failure mode is Vercel env var wipe (Scenario 1). Everything else is rare.
