# Pre-Pause Checklist (Before 3-Day Update Freeze)

Run through this list right before deploying the final pre-pause version. ~45 min total. Anything that fails → fix before deploying, otherwise the 3-day soak will lose data.

## A. Deploy verification (5 min)

- [ ] Push latest commit to main (current head: `0b91cdf` after S110 wave 2)
- [ ] Vercel build completes green (https://vercel.com/[your-project]/deployments)
- [ ] Production URL loads in <2s on first visit (cold cache)
- [ ] No console errors on homepage (open browser DevTools → Console tab)

## B. Plausible events smoke test (10 min)

Open production URL in incognito mode. Open DevTools → Network → filter "plausible". Then:

- [ ] Click any tool's "Visit →" on homepage Editor's Picks → see `event=Outbound, props.tool=card` POST to plausible.io/api/event
- [ ] Open `/tools/chatgpt` → click hero "Visit ChatGPT →" → see `event=Outbound, props.tool=detail-hero`
- [ ] Open `/compare/chatgpt-vs-claude` → click winner "Visit" → see `event=Outbound, props.tool=compare-winner`
- [ ] Open `/quiz` → answer first question → see `event=QuizStart`
- [ ] Complete the quiz to `/quiz/result` → see `event=QuizComplete` with role + budget props
- [ ] **NEW (S110 wave 2):** Open `/tools/notion-ai` → click ♡ Save → see `event=WishlistAdd, props.tool=notion-ai`. Click again → `WishlistRemove`.

If any event fails to fire: check `app/layout.tsx` line 111-116 - Plausible script must load with `data-domain` matching production URL.

## C. Mobile smoke test (10 min)

Open production in mobile emulator (DevTools → device toolbar → iPhone 14 Pro Max + Chrome) OR on actual phone.

- [ ] Homepage hero search input is tappable (not covered by header)
- [ ] Search works on mobile (type "chatgpt", dropdown shows results, tap → navigates)
- [ ] `/tools` filter bar opens, filters apply, page scrolls
- [ ] Tool detail page: TrustStack visible, Visit button tappable, sticky bottom CTA shows
- [ ] **NEW:** `/tools/[slug]` does NOT show newsletter sticky bar (S110 wave 2 fix - was colliding before)
- [ ] `/quiz` answer buttons are large enough to tap (44px minimum)
- [ ] Compare page table scrolls horizontally if needed

## D. Forms smoke test (5 min)

- [ ] Submit a fake newsletter email (e.g., `test+predeploy@example.com`)
  - Verify success message appears
  - Open Supabase dashboard → `newsletter_subscribers` table → row exists
  - Delete the test row after verification
- [ ] Submit a test review on any tool (e.g., `/tools/notion-ai`)
  - Fill required fields (rating + bestFor + limitation)
  - Verify "Thank you" message appears
  - Open Supabase → `tool_reviews` → row exists with `status='approved'` (or `pending` if service-role-key not set)
  - Delete the test row after verification
  - **If service role key missing**: `status='pending'` is fallback - reviews won't show on site. Add `SUPABASE_SERVICE_ROLE_KEY` to Vercel env before pause.

## E. New wishlist feature test (5 min)

- [ ] Open `/tools/chatgpt` → click ♡ Save button → button text changes to "Saved"
- [ ] Header should now show heart icon with count badge "1"
- [ ] Click header heart → navigates to `/wishlist`
- [ ] `/wishlist` shows ChatGPT card with Save/Visit
- [ ] Click ♡ on the wishlist card → tool removed, count drops
- [ ] Refresh page → state persists (localStorage works)
- [ ] Test in incognito window → wishlist empty (correct - localStorage is per-profile)

## F. Catalog hygiene final check (5 min)

```bash
cd web
node --env-file=.env.local scripts/audit-state-s97.mjs    # Should show: 549 tools, no anomalies
node --env-file=.env.local scripts/audit-internal-refs.mjs # Should show: 0 broken refs
node --env-file=.env.local scripts/check-vocab.mjs        # Should show: 21 tags
```

Output expected:
- `audit-state-s97.mjs` → "Pricing verified missing: 0", "Empty descriptions: 0"
- `audit-internal-refs.mjs` → "Blog broken refs: 0, Top10 broken: 0, Compare broken: 0"
- `check-vocab.mjs` → exactly 21 tags (slack, google, salesforce, github, hubspot, zapier, microsoft-365, dropbox, notion, calendar, gmail, snowflake, shopify, stripe, jira, intercom, segment, linkedin, airtable, asana, linear)

## G. During-pause monitoring (zero work, just check daily)

| Day | What to check (3 min/day) |
|---|---|
| Day 1 (T+24h) | Plausible dashboard: Outbound count > 0, mobile bounce rate < 70% |
| Day 2 (T+48h) | Newsletter subscribers grew? Reviews submitted? |
| Day 3 (T+72h) | Vercel error rate < 0.1%, no failed deploys queued |

## H. Post-pause priorities (when back)

1. Read Plausible 24-48h data (S94 Action 5). Identify top-converting Outbound surface, double down.
2. Check QuizComplete data: which roles/budgets were chosen most? Inform new blog topics.
3. Check `tool_reviews` table: any real users submitted? If yes, prioritize that tool's surfaces. If no, kick off beta-tester outreach (template at `content/templates/beta-tester-outreach.md`).
4. Continue scores_evidence push from current 25% → 30% (next batch: rank 100-150 tools, see CLAUDE.md S110 history for HEAD-probe pattern).

## Emergency contact during pause

If site goes down:
1. Vercel dashboard → check deploy status, rollback if needed
2. Supabase dashboard → check service status
3. DNS check via `dig mytheai.com` if domain issues

If a single tool's page breaks (404, blank, broken logo):
- Hot-fix not required during pause
- Note the slug, fix post-pause
- ToolScreenshot uses live Microlink so transient failures are normal

## Why this checklist exists

Without it, the 3-day soak generates useless data. Specifically:
- If Plausible doesn't fire → 3 days of zero analytics
- If service role key missing → reviews silently fail, anti-bot pipeline produces no value
- If mobile sticky bars overlap → 60-70% of traffic has degraded UX
- If newsletter form silently fails → lost conversion + zero feedback

Run all 6 sections (A-F) before deploying. ~45 min investment for 3 days of clean data.
