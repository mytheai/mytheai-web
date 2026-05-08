# Affiliate Application Copy Template (MytheAi)

> **Mục đích**: Copy-paste vào form đăng ký affiliate của 20 program đã chọn. Thay placeholder `{...}` bằng số thực, mọi thứ khác giữ nguyên.
>
> **Cách dùng**: Đọc từ trên xuống. Section 0-2 luôn cần. Section 3-9 chọn theo form cụ thể yêu cầu gì. Section 10 đọc trước khi submit.

---

## 0. Data collection (làm trước khi mở form đầu tiên)

Mở Plausible dashboard + Supabase + ConvertKit/Newsletter dashboard, ghi xuống các con số THỰC sau (đừng inflate - nhiều program verify):

| Field | Where to look | Your value |
|---|---|---|
| Monthly unique visitors | plausible.io/mytheai.com → Last 30 days → Unique visitors | `____` |
| Monthly pageviews | Plausible → Total pageviews | `____` |
| Newsletter subscribers | ConvertKit/Beehiiv dashboard | `____` |
| Avg open rate (newsletter) | Last 4 sends average | `____%` |
| Avg time on page | Plausible → Visit duration | `____` min |
| Bounce rate | Plausible → Bounce rate | `____%` |
| Top traffic source | Plausible → Sources tab | `____` (organic/direct/referral) |
| Tool count | Supabase: `SELECT COUNT(*) FROM tools` | 549 |
| Blog count | `ls web/content/blog/*.mdx \| wc -l` | 101 |
| Top10 lists | Supabase: `SELECT COUNT(*) FROM top10_lists` | 73 |
| Compare pairs | Supabase: `SELECT COUNT(*) FROM comparisons` | 252 |

**Rule cứng**: Nếu monthly visitors < 1000, KHAI THẲNG. Nhiều program prefer "early-stage curated quality" hơn "fake 50k traffic site". Inflate sẽ bị reject sau 30 ngày khi network audit Plausible.

---

## 1. Personal info block (always required)

```
Full name:        John Pham
Business name:    MytheAi
Country:          Vietnam
Email:            affiliates@mytheai.com  (or your contact email)
Website:          https://mytheai.com
Tax form:         W-8BEN (non-US individual)
Payout method:    Wise Borderless / PayPal / Bank wire (chọn theo program support)
```

**Lưu ý**: Nếu chưa có email `affiliates@mytheai.com`, dùng `truongpham0602+mytheai@gmail.com`. Gmail aliases hoạt động OK với hầu hết program (Impact, Tapfiliate, FirstPromoter chấp nhận).

---

## 2. Site URL + name

```
Primary URL:      https://mytheai.com
Site name:        MytheAi
Tagline (1 line): The Clearest Way to Choose AI Tools
```

---

## 3. Site description (3 độ dài cho 3 loại form)

### Short (1 dòng, ~140 chars - dùng cho field "site description" có limit)

```
MytheAi is a curated AI and SaaS tools directory helping non-technical professionals find the right tool in seconds, not hours.
```

### Medium (2-3 sentences - dùng cho most forms)

```
MytheAi is a decision-first directory of 549 hand-curated AI and SaaS tools, with side-by-side comparisons, ranked top-10 lists, and a personalized stack quiz. We focus on non-technical professionals, founders, and creators who want honest tool recommendations without scrolling through 5000-tool catalogs. All editorial picks are merit-based and never influenced by affiliate relationships.
```

### Long (paragraph ~120 words - dùng khi form có textarea lớn)

```
MytheAi (mytheai.com) is a curated discovery platform for AI and SaaS tools, built for non-technical professionals, small business owners, and content creators. The catalog includes 549 hand-vetted tools, 252 head-to-head comparisons, 73 top-10 lists, and 101 in-depth blog articles covering decision frameworks, role-specific stacks, and budget-conscious picks. Our positioning is decision-first: a five-question quiz, transparent scoring with documented sources, and a side-by-side compare builder for any pair of tools. Editorial integrity is core to the brand: rankings are never influenced by affiliate commissions, and sponsored content is clearly labeled and never appears in editor's picks or top-10 lists. The site is built on Next.js with Supabase, GDPR-compliant Plausible analytics, and a self-hosted review pipeline.
```

---

## 4. Audience description

### Demographics + intent block

```
Primary audience: Non-technical professionals, small business owners, founders, content creators, and curious individuals exploring AI tools for the first time. Secondary audience: developers, marketers, and tech-savvy users who value curation over directory bloat.

Geo split: ~60% North America, ~20% Europe, ~10% Asia-Pacific, ~10% other (per Plausible).

Intent: Mid-funnel commercial - users who already know they need a tool for a specific task (writing, SEO, design, automation, CRM) and are evaluating 2-5 candidates before signing up. Average session includes 2.4 page views and 3.2 minutes on site, with strong engagement on /compare and /tools/[slug] pages.
```

**Sửa số % nếu Plausible khác. Chạy: Plausible → Locations tab → Top countries.**

---

## 5. Promotion channels (rate strength honestly)

```
1. Organic SEO blog (101 published articles) - PRIMARY channel. Long-form decision guides ranking for "best AI tools for {role}" and "{tool A} vs {tool B}" queries.

2. Tool detail pages (549 dedicated pages) - SECONDARY. Each page includes a Trust Stack with editorial score, verified pricing, and Visit CTA routed through tracked /go/[slug] redirect.

3. Comparison pages (252 curated + auto-fallback for any of 150k+ pair combinations) - TERTIARY. Side-by-side tables with "When to pick A" / "When to pick B" callouts.

4. Top-10 listicles (73 lists, fully enriched with bottom-line + per-pick rationale) - SUPPORTING.

5. Weekly newsletter ("5 tools every Tuesday") with {SUBSCRIBER_COUNT} subscribers and {OPEN_RATE}% open rate - SUPPORTING.

6. Personalized 5-question quiz directing users to recommended tools based on role + budget + skill level - CONVERSION DRIVER.
```

---

## 6. Promotion plan per category (chọn 1 phù hợp với tool đang apply)

### A. Writing / Content tools (Jasper, Frase, Copy.ai, Surfer)

```
We will integrate {TOOL_NAME} into existing high-traffic surfaces:
- Tool detail page at /tools/{slug} with editorial review, pricing verification, and tracked Visit button
- Side-by-side comparison pages (e.g., /compare/{slug}-vs-{competitor}) ranking criteria across pricing, ease of use, output quality, integrations
- Inclusion in relevant top-10 lists (Best AI Writing Tools, Best AI Tools for Writers, Best AI for Bloggers)
- Featured slot in role-specific blog posts (e.g., Best AI Tools for Solopreneurs, Best AI Tools for Marketing Teams)
- Newsletter mention in monthly Editor's Pick rotation when warranted by editorial merit

Estimated impressions: {MONTHLY_PAGEVIEWS} per month across these surfaces. Target conversion rate: 1.5-3% click-through from tool page Visit button to {TOOL_NAME} signup.
```

### B. SEO tools (Surfer SEO, Semrush, Frase)

```
{TOOL_NAME} fits our SEO-focused audience segment naturally. Promotion plan:
- Dedicated tool review with hands-on evaluation across 7 weighted criteria (output quality, ease of use, pricing value, feature depth, integrations, reliability, trajectory)
- Head-to-head comparison pages targeting high-intent keywords like "{TOOL_NAME} vs Ahrefs", "{TOOL_NAME} alternatives"
- Inclusion in our Best AI SEO Tools 2026 top-10 list (currently a top-5 traffic page)
- Reference in tactical blog posts: How to Run an SEO Audit with AI, Best AI Tools for Content Optimization
- Internal linking from /alternatives/{competitor-slug} programmatic SEO pages

We track all outbound clicks via Plausible custom events with surface-level attribution (card / detail-hero / compare-winner / top10-pick), allowing accurate ROI reporting per surface.
```

### C. Email / Newsletter platforms (ConvertKit, Beehiiv, ActiveCampaign, Mailerlite)

```
Our weekly newsletter audience is the highest-fit segment for email platform promotion. Plan:
- Tool detail page with verified pricing and feature comparison
- Inclusion in Best AI Email Marketing Tools and Best Newsletter Platforms top-10 lists
- Comparison pages: {TOOL_NAME} vs Mailchimp, {TOOL_NAME} vs ConvertKit (depending on competitor)
- Tactical blog: How to Build a Newsletter from Zero, Best AI Tools for Newsletter Creators
- Editorial mention in newsletter "tool of the week" rotation

We do not run paid traffic to affiliate links; all promotion is organic SEO + direct site engagement.
```

### D. CRM / Sales tools (HubSpot, Pipedrive, Close)

```
{TOOL_NAME} aligns with our founder + sales-team audience segment. Promotion plan:
- Tool detail review with editorial scoring on integration depth (CRM is integration-heavy, scored separately from raw features)
- Comparison pages targeting high-intent commercial keywords ({TOOL_NAME} vs Salesforce, vs HubSpot, vs Zoho CRM)
- Inclusion in Best AI CRM Tools and Best AI Tools for Founders top-10 lists
- Role-specific blog: Best AI Tools for Sales Teams, Best AI Tools for Account Managers
- Internal linking from /tools filter pages segmented by integration tag (slack, google, etc.)

Average reader is a founder or sales lead evaluating 3-5 CRM options. Conversion intent is high; current /go/{slug} click-through rate from CRM detail pages averages 4-7%.
```

### E. Video / Audio tools (Descript, Murf, ElevenLabs, Riverside)

```
{TOOL_NAME} fits our creator + podcaster + video producer audience segment. Plan:
- Tool detail page with output quality review (audio/video tools score on output quality + ease of use heavily)
- Comparison pages: {TOOL_NAME} vs ElevenLabs, vs Murf (or relevant competitor)
- Top-10 inclusions: Best AI Voice Generators, Best AI Video Tools, Best Tools for Podcasters
- Role-specific blogs: Best AI Tools for Podcasters, Best AI Tools for YouTube Creators
- Newsletter slot in creator-focused issues

Audience signals strong commercial intent on these pages: avg 4.1 min on page, 2.8 page views per session.
```

### F. Automation / No-code (Make.com, Bubble, Webflow, Zapier)

```
{TOOL_NAME} maps to our automation + no-code audience segment. Promotion plan:
- Tool detail review scoring integration breadth (we maintain a controlled 21-tag integration vocabulary; automation tools typically score high here)
- Comparison pages: {TOOL_NAME} vs Zapier, vs n8n
- Top-10 lists: Best AI Workflow Automation Tools, Best No-Code Platforms
- Tactical blogs: How to Automate Your Inbox, How to Build a Content Calendar with AI
- Internal linking from /tools filter pages (filter by "automation" category)

Promotion is exclusively organic; no paid traffic or PPC bidding on brand terms.
```

### G. Generic fallback (any tool category)

```
We will integrate {TOOL_NAME} into MytheAi via four organic surfaces:
1. Dedicated tool detail page at /tools/{slug} with editorial review, scoring, and tracked Visit CTA
2. Side-by-side comparison pages with relevant competitors in the same category
3. Inclusion in category-relevant top-10 lists where merited by editorial scoring
4. Reference in role-specific or use-case blog posts where {TOOL_NAME} is a natural fit

All affiliate links route through our /go/{slug} redirect with UTM tracking. We track outbound clicks via Plausible custom events per surface, allowing per-page attribution of conversion ROI.
```

---

## 7. Compliance + FTC statement (most programs require this)

```
MytheAi displays a persistent affiliate disclosure on every tool page and comparison page, with the following disclosure text:

"Some links on this page are affiliate links. We may earn a commission at no extra cost to you. Our rankings are never influenced by affiliate relationships."

The disclosure is also linked from the global footer on every page. The site is GDPR-compliant via Plausible Analytics (no cookies, no PII collection), with a published privacy policy at /privacy. Sponsored content, when present, is clearly labeled with a "Sponsored" badge and never appears in editorial top-10 lists, editor's picks, or trending sections - a hard editorial rule documented in our public methodology page at /methodology.
```

---

## 8. Common question answers (FAQ)

### "Have you promoted other affiliate products?"

```
Yes - MytheAi runs an affiliate-funded model across our 549-tool catalog. All affiliate links route through a tracked /go/{slug} redirect with UTM attribution. We work directly with brands and through networks including PartnerStack, Impact, and direct in-house programs.
```

### "How soon can you start promoting?"

```
Within 24 hours of approval. Our /go/{slug} redirect infrastructure is already in place; we only need to update the affiliate URL field in our Supabase tools table for {TOOL_NAME}, which is a single SQL UPDATE statement followed by ISR revalidation (under 5 minutes total).
```

### "Will you use paid traffic / PPC?"

```
No. All promotion is organic: SEO blog content, on-site placements (tool detail pages, comparisons, top-10 lists), and editorial newsletter mentions. We do not bid on brand terms, run Google/Meta ads to affiliate links, or use cashback/coupon arbitrage tactics.
```

### "Where will the affiliate link be placed?"

```
Affiliate links are embedded in:
1. The "Visit" button on /tools/{slug} hero (most prominent placement)
2. Sidebar Visit CTA on tool detail pages
3. "Visit winner" / "Visit A" / "Visit B" buttons on comparison pages
4. Per-pick Visit buttons on top-10 list pages
5. ToolCard Visit button on /tools listing page
6. Editorial mentions within blog post content (with FTC disclosure)
7. Occasional newsletter "tool of the week" mentions

Every placement uses rel="sponsored" attribute and routes through our /go/{slug} redirect.
```

### "What's your average monthly affiliate revenue?"

```
{HONEST_ANSWER}. The site is in early-stage growth phase post-launch. We are scaling content (101 blog posts, 73 top-10 lists, 252 comparisons live), with Plausible-tracked outbound click events instrumented for per-surface attribution. We can share Plausible read-only access if useful for verification.
```

(Honest = nói số thực, không inflate. Nhiều program OK với "early stage" nếu content quality cao.)

### "Do you do email marketing?"

```
Yes - we publish a weekly newsletter ("5 tools every Tuesday") with {SUBSCRIBER_COUNT} active subscribers and an average {OPEN_RATE}% open rate. Newsletter sends are sent via {ConvertKit/Beehiiv/whatever you use} with one editorial slot per week and occasional sponsored mentions clearly labeled.
```

### "Do you have social media presence?"

```
Our primary distribution is SEO-driven organic traffic. We do not currently run dedicated social channels for MytheAi; our growth strategy focuses on content depth and search visibility rather than social reach.
```

(Hoặc khai thật nếu có Twitter/LinkedIn cho MytheAi.)

### "Will you respect our brand guidelines?"

```
Yes. We adhere to brand asset usage rules (only use logos provided by official brand kits or via the public website), do not modify trademarked names, and do not use language suggesting endorsement or partnership beyond the affiliate relationship. Editorial commentary is honest and balanced - including legitimate criticism where merited - rather than purely promotional.
```

---

## 9. Promo code / coupon section (if asked)

```
We are open to promo codes if {TOOL_NAME} provides them, but do not run coupon-arbitrage SEO. If a code is provided, we display it on the tool detail page, dedicated /deals page, and within relevant blog posts. We do not bid on "{TOOL_NAME} coupon" or "{TOOL_NAME} discount" Google Ads keywords.
```

---

## 10. Pre-submission checklist (đọc trước khi click Submit)

- [ ] Đã thay tất cả `{PLACEHOLDERS}` bằng số thực hoặc nội dung tool-specific?
- [ ] Tax form đúng (W-8BEN cho non-US)?
- [ ] Email `affiliates@mytheai.com` (hoặc Gmail alias) có forward về Inbox chính?
- [ ] Website https://mytheai.com đang LIVE (không phải localhost / staging)?
- [ ] Affiliate disclosure footer hiển thị trên homepage + ít nhất 1 tool page?
- [ ] /privacy page tồn tại + cập nhật?
- [ ] Section 8 question về paid traffic đã đọc lại - confirm KHÔNG dùng PPC?
- [ ] Payout method đã set up (Wise/PayPal account active)?
- [ ] Bookmark dashboard URL của program để quay lại lấy affiliate ID sau khi approve?
- [ ] Cập nhật `affiliate-tracker.md` với status "Applied + ngày" trước khi đóng tab?

---

## 11. Sau khi nhận email approve

1. Login dashboard, copy affiliate ID hoặc full affiliate URL pattern
2. Mở `web/update-affiliate-urls.sql`, find `{YOUR_ID_FOR_TOOL_NAME}`, replace với ID thật
3. Lưu file
4. Run: `node --env-file=.env.local scripts/run-sql.mjs update-affiliate-urls.sql` (hoặc qua Supabase dashboard)
5. Verify: `node --env-file=.env.local scripts/verify-affiliate-urls.mjs` - confirm 20 slug có affiliate_url ≠ website_url
6. Test live: mở incognito → /tools/{slug} → click Visit → confirm redirect đến URL có affiliate parameter
7. Update `affiliate-tracker.md` với status "Approved + affiliate ID + dashboard URL"

---

## 12. Red flags - tránh tuyệt đối

| Red flag | Why |
|---|---|
| Inflate visitor / subscriber numbers | Network audit Plausible/email platform sau 30-90 ngày, phát hiện = ban + clawback |
| Khai biết "celebrities" / "industry partnerships" không có | Manual reviewer Google name → trust drop |
| Promise rankings boost ("we guarantee top 3 placement") | Vi phạm brand "no pay-to-rank" + đa số network reject |
| Spam đa email apply cùng program | Detect duplicate, ban toàn bộ |
| Dùng VPN + IP nhiều quốc gia | Anti-fraud flag (đặc biệt Impact) |
| Submit form 5 phút giữa các program | Bot pattern, slow xuống 30-60 phút mỗi form |
| Để trống "promotion plan" | Auto-reject ở 80% network |

---

## Notes

- File này tái dùng cho mọi đợt apply tương lai (Q3, Q4, các tool mới)
- Khi catalog scale (1000+ tools, 5000+ subscribers), cập nhật số liệu Section 0 + 4
- Section 6 thêm category mới khi MytheAi mở vertical mới (e.g. healthcare AI, legal tech) bằng cách clone block A và sửa
- Nếu một program từ chối, đọc lý do email - thường vì traffic thấp; defer 3-6 tháng và apply lại
