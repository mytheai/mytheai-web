# Affiliate Programs Tracker (MytheAi)

Status tracking for 20+ affiliate programs the founder applies to using `affiliate-application-template.md`. Update this file after every form submission and after every approval/rejection email.

**Status enum**: `Not Applied` / `Applied` / `Approved` / `Rejected` / `Live`

**Convention**: Each row is one program. After approval, copy the affiliate ID and dashboard URL into the row, then run the SQL update workflow (see bottom of this file).

---

## Priority Wave 1 (Q2 2026 - apply first)

These are the highest-priority programs based on catalog overlap with /tools detail pages and /best/[category] money pages.

### Writing / Content (5 programs)

| Tool | Network | Status | Date Applied | Affiliate ID | Dashboard URL | Notes |
|---|---|---|---|---|---|---|
| Jasper | Impact | Not Applied | | | | |
| Copy.ai | In-house | Not Applied | | | | |
| Surfer SEO | FirstPromoter | Not Applied | | | | |
| Frase | In-house | Not Applied | | | | |
| Writesonic | In-house | Not Applied | | | | |

### SEO / Marketing (4 programs)

| Tool | Network | Status | Date Applied | Affiliate ID | Dashboard URL | Notes |
|---|---|---|---|---|---|---|
| Semrush | Impact | Not Applied | | | | |
| Ahrefs | In-house | Not Applied | | | | Limited program, application waitlist |
| HubSpot | In-house | Not Applied | | | | |
| ActiveCampaign | In-house | Not Applied | | | | |

### Email / Newsletter (3 programs)

| Tool | Network | Status | Date Applied | Affiliate ID | Dashboard URL | Notes |
|---|---|---|---|---|---|---|
| ConvertKit | PartnerStack | Not Applied | | | | |
| Beehiiv | In-house | Not Applied | | | | |
| Mailerlite | In-house | Not Applied | | | | |

### Automation / No-code (3 programs)

| Tool | Network | Status | Date Applied | Affiliate ID | Dashboard URL | Notes |
|---|---|---|---|---|---|---|
| Zapier | Impact | Not Applied | | | | |
| Make.com | In-house | Not Applied | | | | |
| Webflow | PartnerStack | Not Applied | | | | |

### Video / Audio (3 programs)

| Tool | Network | Status | Date Applied | Affiliate ID | Dashboard URL | Notes |
|---|---|---|---|---|---|---|
| Descript | In-house | Not Applied | | | | |
| Riverside | In-house | Not Applied | | | | |
| ElevenLabs | In-house | Not Applied | | | | |

### Design / Productivity (2 programs)

| Tool | Network | Status | Date Applied | Affiliate ID | Dashboard URL | Notes |
|---|---|---|---|---|---|---|
| Framer | PartnerStack | Not Applied | | | | |
| Notion | In-house | Not Applied | | | | Invite-only, may be waitlist |

---

## Priority Wave 2 (Q3 2026 - after Wave 1 returns approval velocity data)

Add rows here as Wave 1 hit-rate stabilizes and founder has signal on which networks accept early-stage publishers.

| Tool | Network | Status | Date Applied | Affiliate ID | Dashboard URL | Notes |
|---|---|---|---|---|---|---|
| (placeholder) | | Not Applied | | | | |

---

## Pre-application checklist (run once before Wave 1)

Verify these are LIVE on production before submitting first form (most networks audit landing page within 7 days of approval):

- [ ] Footer affiliate disclosure link visible on every page
- [ ] /about page has Affiliate Disclosure section anchored
- [ ] /privacy page exists and is current
- [ ] At least 1 /tools/[slug] page renders Visit CTA routing through /go/[slug]
- [ ] /go/[slug] redirect works (test with curl - should 307/308 to external URL)
- [ ] Plausible analytics live (most networks ask for read-only access for verification)

## Workflow per approval

When approval email arrives:

1. Login to network dashboard (link in row above) and copy the affiliate URL pattern (typically `https://{tool-domain}.com/?ref={your-id}` or `https://{network}.{tool}.com/aff_c?id={your-id}`)
2. Open `web/update-affiliate-urls.sql`, find the placeholder for that tool, replace with the real URL
3. Save file
4. Run: `node --env-file=.env.local scripts/run-sql.mjs update-affiliate-urls.sql`
5. Verify: `node --env-file=.env.local scripts/verify-affiliate-urls.mjs` - confirm slug appears in the "live affiliate URL" list
6. Test live: open incognito, go to `https://mytheai.com/tools/{slug}`, click Visit, confirm landing URL contains your affiliate ID
7. Update this file: change Status to "Live", add Affiliate ID + Dashboard URL columns

## Status across catalog (refresh quarterly)

After every wave of approvals, run `verify-affiliate-urls.mjs` and snapshot the count below:

| Snapshot date | Tools with live affiliate_url | Total catalog | Coverage % |
|---|---|---|---|
| 2026-05-08 (baseline) | 0 | 585 | 0% |

Target: 80%+ catalog coverage by Q4 2026 across the 20 highest-traffic detail pages (head-term tools).
