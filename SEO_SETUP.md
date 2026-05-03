# MytheAi SEO Setup - Tier 2

This doc walks through the **manual steps** required to force-index 890+ URLs across Google + Bing + Yandex. Code-side automation (IndexNow) is already in place; the steps below need browser/account work.

---

## 1. Google Search Console (verify + submit sitemap)

Already verified via meta tag in `layout.tsx`:
```
verification: { google: 'v1XXmGzPAUqEJsSXb3F1bl3TipZYYKmIObnmRK8N2oc' }
```

**Action:**
1. Open https://search.google.com/search-console
2. Property: `https://mytheai.com`
3. Sidebar -> Sitemaps -> Add new sitemap -> `sitemap.xml` -> Submit
4. Sidebar -> URL Inspection -> paste `https://mytheai.com/` -> Request Indexing
5. Repeat for `/tools`, `/blog`, `/compare`, `/top-10`, `/categories`

Coverage report shows discovered vs indexed counts. Initial crawl: 1-7 days.

---

## 2. Bing Webmaster Tools (verify + submit)

**Action:**
1. Open https://www.bing.com/webmasters
2. Sign in with Microsoft account
3. **Import from Google Search Console** (fastest - copies verification + sitemap automatically)
4. If manual: Add Site -> `https://mytheai.com` -> verify via XML file or HTML meta
5. Sitemaps -> Submit -> `https://mytheai.com/sitemap.xml`

Bing typically indexes new URLs in 24-72h vs Google's 1-7 days.

---

## 3. Yandex (optional, but free traffic from CIS markets)

**Action:**
1. Open https://webmaster.yandex.com
2. Add site -> `https://mytheai.com` -> verify via meta tag (paste in `layout.tsx` `verification.yandex`)
3. Submit sitemap

---

## 4. IndexNow blast (one-time, then ongoing)

IndexNow pushes URL changes to Bing + Yandex + Naver + Seznam in seconds (no waiting for crawler).

**Setup verification:**
1. Verify `https://mytheai.com/b5a50bdf01d5436f8dd11b0b8ff12e54.txt` returns `b5a50bdf01d5436f8dd11b0b8ff12e54` (after Vercel deploy)
2. INDEXNOW_KEY is in `.env.local` (matches the .txt content)

**Initial blast (push all 890+ URLs):**
```bash
cd web
npm run indexnow:all
```

**Ongoing (after each session, push only URLs modified in last 7 days):**
```bash
npm run indexnow:recent
```

**Single URL:**
```bash
npm run indexnow https://mytheai.com/blog/state-of-ai-tools-2026
```

---

## 5. Vercel env vars (production)

Add `INDEXNOW_KEY` to Vercel project settings:
1. Vercel dashboard -> mytheai-web project -> Settings -> Environment Variables
2. Add `INDEXNOW_KEY` = `b5a50bdf01d5436f8dd11b0b8ff12e54` (Production + Preview)
3. Redeploy if you want the key accessible to runtime code (not strictly needed - script runs locally).

---

## 6. ProductHunt + Reddit + HN launch (Tier 4 - authority)

After sitemap is indexed, soft launch for backlinks:
- **ProductHunt**: schedule launch via https://www.producthunt.com/posts/new
- **Reddit r/SaaS, r/artificial, r/SideProject**: organic post linking to top10 lists
- **Hacker News Show**: `Show HN: MytheAi - Honest, no-pay-to-rank AI tool directory`

These produce 3-10 immediate backlinks + trigger natural link discovery by Google.

---

## Verification commands

After deploy, verify in this order:
```bash
# Favicon serves static (not Vercel default)
curl -I https://mytheai.com/favicon.ico
# expect: 200 OK, Content-Type: image/x-icon (or image/png)

# IndexNow key file is reachable
curl https://mytheai.com/b5a50bdf01d5436f8dd11b0b8ff12e54.txt
# expect: b5a50bdf01d5436f8dd11b0b8ff12e54

# Sitemap reachable + has 890+ entries
curl -s https://mytheai.com/sitemap.xml | grep -c "<loc>"
# expect: 890+

# Run IndexNow blast (push every URL to Bing + Yandex)
npm run indexnow:all
# expect: Total: 890+ OK, 0 failed
```

---

## Expected impact (after Tier 2 completes)

| Metric | Before | After 7 days | After 30 days |
|---|---|---|---|
| Google indexed pages | ~3 | 50-200 | 500-890 |
| Bing indexed pages | ~0 | 200-500 | 890+ |
| Favicon shown on Google | Vercel logo | MytheAi star | MytheAi star |
| Organic impressions/day | <50 | 100-500 | 1000-3000 |

If after 30 days Google indexing < 500 URLs, audit in this order:
1. GSC Coverage report - find "Discovered, not indexed" reasons
2. Check internal link depth - any URL > 4 clicks deep is rarely indexed
3. Audit thin content - URLs with < 200 words skipped by Google
4. Add backlinks from authoritative AI niche sites
