# IndexNow Ping

Submits new/updated URLs to IndexNow API (Bing, Yandex, Naver, Seznam). Google
ignores IndexNow but does not penalize the ping.

## One-time setup

1. **Generate the key** (32-char hex):
   ```bash
   node -e "console.log(crypto.randomUUID().replace(/-/g,''))"
   ```

2. **Save to env**: append to `web/.env.local`:
   ```
   INDEXNOW_KEY=<paste-the-32-char-hex>
   ```

3. **Create the verification file**: `web/public/<the-key>.txt` containing
   exactly the key as plain text (no newline, no quotes, no BOM).

4. **Deploy**. Confirm:
   ```bash
   curl https://mytheai.com/<KEY>.txt
   # should print the key string
   ```

## Per-session usage

After each `git push` of a content session, ping the new URLs:

```bash
cd web
node --env-file=.env.local scripts/indexnow-ping.mjs \
  https://mytheai.com/blog/<new-blog-slug> \
  https://mytheai.com/tools/<slug-1> \
  https://mytheai.com/tools/<slug-2> \
  ...
  https://mytheai.com/top-10/<new-list-1> \
  https://mytheai.com/top-10/<new-list-2>
```

Expect HTTP 200 or 202 = success.

## Troubleshooting

| Status | Meaning | Fix |
|---|---|---|
| 200/202 | Success | Done |
| 400 | Malformed URLs | Use absolute URLs on same host |
| 403 | Key invalid or rate-limited | Wait 24h, regenerate key |
| 422 | Key file URL mismatch | Check `public/<key>.txt` is deployed and reachable |

## Verification (Bing Webmaster Tools)

1. Add property in Bing Webmaster Tools (https://www.bing.com/webmasters).
2. Wait 24-48h after first successful ping.
3. Open Configure My Site -> URL Submission -> IndexNow tab.
4. Should show submission count and last-success timestamp.
