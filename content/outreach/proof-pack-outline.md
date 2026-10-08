# MytheAi Partner Proof Pack - Outline

Materials to send vendors who ask for "more info" or "case studies" before closing. Build as 2-3 page PDF OR a /partners-proof URL (private, send link via email).

---

## Section 1 - About MytheAi (quick credibility)

**One-liner**: Editorial AI tools directory with hand-tested rankings - no pay-to-rank.

**Founded**: 2026 (early stage, honest - don't claim 5 years in business).

**Founder**: John Pham. Based in Vietnam. Builds + tests + writes personally. Available for calls.

**Catalog scale** (live from Supabase):
- 593 tools reviewed across 16 categories
- 214 hand-tested editorial reviews (we test, we write, we publish last-tested date)
- 252 side-by-side comparisons with named winners
- 506 use-case guides for specific tasks
- 73 Top 10 ranking lists
- 101 blog articles (long-form explainer content)

**Technical infrastructure**:
- Next.js 16 on Netlify (99.9% uptime target, GitHub Actions monitoring 5-min cadence)
- Supabase Postgres (automated weekly backups to git for disaster recovery)
- IndexNow auto-ping to Bing + Yandex + DuckDuckGo on every content update
- Microsoft Clarity + Plausible for analytics (privacy-first, no cookies required)

---

## Section 2 - Why advertisers invest in us (positioning)

**The problem with mass directories (G2, Capterra, TrustRadius)**:
- Rankings bought via sales calls, not editorial
- Thousands of tools, no quality filter
- Reader bounce rate 70%+ (overwhelmed, leave empty-handed)

**The problem with scraped directories (TAAFT, Futurepedia, Toolify)**:
- No editorial depth (auto-populated, no hands-on testing)
- Volume > quality
- Low purchase intent per visit

**Our positioning**: The Craft/Linear/Notion of AI directories.
- Smaller, higher quality
- Editorial-first (we publish before we pitch sponsorship)
- Audience lands via high-intent queries ("best X AI tool", "X vs Y", "AI for X task")
- Average session includes 2-3 tool detail page views = pre-converted buyers

**Who our readers are** (self-reported via quiz data when available):
- Founders / early-stage SaaS owners (35%)
- Marketing / content professionals (25%)
- Developers / engineering leads (20%)
- Operations / business analysts (15%)
- Students / curious individuals (5%)

---

## Section 3 - Editorial integrity standards

**What sponsored vendors get**:
- Verified Badge on tool card
- Priority placement in /best/[category] page (sits BELOW editorial winners, labeled Sponsored)
- Dofollow backlinks
- Pricing sync (we update your pricing when you ship changes)

**What sponsored vendors do NOT get**:
- Rank in Top 10 lists (editorial only, period)
- Rank as "Winner" in /compare/[X-vs-Y] pages (editorial only)
- Hidden sponsored labels (every placement visibly tagged)
- Removal of competitor from directory

**Why this matters for your brand**: Readers trust our rankings precisely because we don't sell them. Being a Verified sponsor on a trusted directory > being a Featured sponsor on a pay-to-rank directory.

---

## Section 4 - Case studies (fill when available)

**Status**: BUILDING. Add here after first 2-3 sponsors close.

Format for each case study:
```
Vendor: [Name]
Tier: [Verified / Featured / Article]
Duration: [months]
Measurable outcome: [X referral clicks, Y signups, Z MRR added]
Testimonial quote: [1-2 sentences from vendor marketing lead]
```

Until case studies exist, substitute with:
- Screenshots of hand-tested review quality (shows editorial standards)
- Google Analytics screenshot of top organic queries we rank for
- Example /go/ click volume data from Plausible (anonymized aggregate)

---

## Section 5 - Pricing & packages

**See /advertise page for full detail**:
- Verified Badge $29/mo
- Featured Boost $99/week
- Sponsored Article $199/piece
- Newsletter Sponsorship $299/send (available when list reaches 500+)
- Custom partnerships available on request

**Payment terms**:
- Monthly: Stripe recurring (card on file)
- One-time: Stripe invoice (NET-15 for enterprise)
- Annual prepay discount: 2 months free (buy 10 get 12)

---

## Section 6 - Technical specs for sponsors

**Visual guidelines**:
- Logo: provide 128x128 PNG transparent background
- Tagline: 60 chars max
- Description for sponsored article: 150 chars elevator pitch
- Landing page: provide specific URL (deep link better than homepage)

**Analytics access**:
- Monthly: Plausible dashboard snapshot (shared link)
- Weekly: email report (first-click, scroll-depth, outbound CTR)
- Real-time: UTM parameters we'll append to your sponsored links

**Legal**:
- Simple 1-page SOW signed via DocuSign
- 30-day cancellation on monthly tiers
- Pro-rated refund if we fail to deliver placement

---

## Section 7 - Contact + next steps

**Direct contact**: john@mytheai.com (replies within 24h weekdays)

**Call booking**: [Add Calendly link once set up]

**Starter path**:
1. Pick a tier from /advertise (easiest: Verified Badge trial)
2. Reply with preferred start date + any brand guideline
3. We confirm, invoice, go live within 48h
4. First weekly report arrives 7 days post-launch

---

## Delivery format recommendations

**Option A**: 2-page PDF (easiest to send attached to email)
Use Canva or Figma. Keep professional design, our brand colors (blue + white).

**Option B**: Private URL on mytheai.com (e.g. /partners-proof)
Create `src/app/partners-proof/page.tsx` using the above sections. Protect with simple localStorage password check (not high-security but gates casual visitors).

**Option C**: Google Slides deck
If vendor asks for "pitch deck format", 8-slide deck works. Can share view-only link.

Start with Option A (lowest effort). Upgrade to B when 5+ vendors request it.

---

## Last update: 2026-10-08 (initial draft, no case studies yet)
