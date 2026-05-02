# Google Search Console API - weekly snapshot

Pulls last 28 days of GSC data and writes `D:/MytheAi/gsc-snapshot.md` with totals,
top pages, low-CTR rewrite candidates, and top queries. Run weekly to inform
title/meta rewrites without flying blind.

## One-time setup (~10 min)

### 1. GCP project + Search Console API

1. Go to https://console.cloud.google.com/
2. Create project (or use existing). Note the project ID.
3. Search "Search Console API" in top search bar. Click "Enable".

### 2. Service Account

1. https://console.cloud.google.com/iam-admin/serviceaccounts
2. Click "Create Service Account". Name: `mytheai-gsc-reader`.
3. Skip role assignment (Search Console permission is property-level, set in step 3).
4. After creation, click the service account, go to "Keys" tab.
5. Click "Add Key" -> "Create new key" -> JSON. Download the file.
6. Note the service account email: `mytheai-gsc-reader@<project>.iam.gserviceaccount.com`

### 3. Delegate Search Console access to the service account

1. Open https://search.google.com/search-console
2. Pick the property (mytheai.com).
3. Settings -> Users and permissions -> Add user.
4. Paste the service account email. Permission: "Restricted" (read-only).

### 4. Add env vars to web/.env.local

Open the downloaded JSON and copy the `client_email` and `private_key` fields:

```
GSC_SITE_URL=https://mytheai.com
GSC_SERVICE_ACCOUNT_EMAIL=mytheai-gsc-reader@<project>.iam.gserviceaccount.com
GSC_SERVICE_ACCOUNT_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
```

The private key MUST be on a single line with `\n` literal escapes (the JSON file
already has them in this format - copy as-is including the surrounding quotes).

### 5. Verify property URL format

If your Search Console property is a URL prefix property (mytheai.com), use:
```
GSC_SITE_URL=https://mytheai.com
```

If it is a Domain property (verified via DNS), use:
```
GSC_SITE_URL=sc-domain:mytheai.com
```

## Run

```bash
cd web
node --env-file=.env.local scripts/gsc-fetch.mjs
```

Expected output: `Wrote D:/MytheAi/gsc-snapshot.md` plus totals printed to stdout.

## Cadence

Recommended: run every Monday morning. Use the "Top 10 LOW-CTR pages" section
to pick 2-3 title/meta rewrite candidates that week.

## Troubleshooting

| Error | Cause | Fix |
|---|---|---|
| 403 PERMISSION_DENIED | Service account not added to GSC property | Step 3 above |
| Token exchange failed 400 | Private key not formatted correctly | Re-copy from JSON file with `\n` escapes intact |
| 404 Site not found | GSC_SITE_URL wrong format | Use `https://mytheai.com` for URL prefix or `sc-domain:mytheai.com` for Domain property |
| Empty rows | Property too new or no data yet | Wait 24-48h after first verification, retry |
