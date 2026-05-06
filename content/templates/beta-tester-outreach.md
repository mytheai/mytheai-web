# Beta Tester Outreach Template

Goal: seed 5-10 verified user reviews for top head-term tools to fill the User Reviews row in TrustStack.

## Why this matters

The TrustStack 4-row card on every tool detail page has 4 signals:
1. Editorial Score (computed from `scores` jsonb)
2. External Aggregate (G2/Capterra `rating` + `review_count`)
3. **User Reviews on MytheAi** ← currently 0 across catalog
4. Pricing Verified (`pricing_verified_at`)

Anti-bot pipeline live since S93 (5-layer defence + service-role auto-approve). Real reviews flow in instantly when users submit. The remaining gap is just outreach to seed the first ~50 reviews.

## Outreach criteria

Pick beta testers who:
- Use the tool weekly+ (not casual try-once)
- Can write 100-300 words on actual workflow value
- Are NOT employees of the tool company
- Are willing to be quoted publicly with first name + role

## Email template

Subject: Quick favour - share your honest [TOOL NAME] review on MytheAi?

Hi [FIRST NAME],

I'm John, founder of MytheAi - a curated AI/SaaS tools directory designed for non-technical professionals (the "search Notion meets Linear" UX angle). We've launched a tool detail page for [TOOL NAME] at https://mytheai.io/tools/[slug] and I'd love to feature your voice.

Could you spare 5 minutes to share an honest 3-paragraph take? Useful angles:
1. Your workflow before [TOOL] vs after
2. The 1-2 things that genuinely matter (not the marketing claims)
3. What you'd warn a new user about

You can submit at https://mytheai.io/tools/[slug] (review form below the tool description) or reply to this email and I'll add it for you.

Two things to confirm:
- I'll show "Verified user - [role] at [industry]" - is that OK?
- Comfortable with us linking your LinkedIn profile (optional, builds trust)?

No incentive offered (we don't pay-to-rank, that's the brand). Pure favour. Will return one when you launch something.

Cheers,
John Pham
john@mytheai.io

---

## Priority outreach list (first wave - 10 tools)

These are head-term tools where User Reviews row most damages trust signal:

1. ChatGPT - target 5 reviewers (heaviest traffic)
2. Claude - target 3 reviewers
3. Cursor - target 3 reviewers (developer audience)
4. Notion AI - target 3 reviewers
5. Midjourney - target 3 reviewers
6. Canva AI - target 3 reviewers
7. Perplexity - target 3 reviewers
8. ElevenLabs - target 2 reviewers
9. Runway - target 2 reviewers
10. Grammarly - target 3 reviewers

Total target: ~30 reviews across 10 tools = first wave.

## Where to find candidates

- LinkedIn search "[TOOL NAME] user" or "uses [TOOL NAME]" with 1-3 month posts
- Twitter/X advanced search: "[TOOL NAME]" replies and quote-tweets
- Reddit r/[ToolName] active commenters last 30 days
- Product Hunt comments on the tool's launch / recent updates
- Personal network first - any contact who has mentioned using the tool

## After receiving review

Submit via /api/reviews POST with:
- tool_slug
- rating (1-5)
- title (optional, 1 line)
- body (3 paragraphs)
- author_name (first name + last initial)
- author_role (role/industry signal)
- author_linkedin (optional, only if reviewer ok'd it)

Auto-approve fires if all anti-bot checks pass. Status='approved' immediately. Reviews show on tool detail page within 60s (ISR cache).

## Tracking

Spreadsheet columns:
- Tool | Reviewer name | Email sent date | Reply | Review submitted date | Status

Target: 30 reviews / 10 tools / 4 weeks = ~7-8 outreach emails per week. Manageable. Most won't reply; conversion target ~30%.

## Anti-fabrication safeguard

NEVER write a review yourself "in the voice of" a hypothetical user. Brand integrity rule (CLAUDE.md): "no pay-to-rank, transparent methodology". Fabricating reviews violates this directly. If real reviews don't materialize for a tool, leave the User Reviews row at 0 - the External Aggregate fallback (S93) handles the empty state gracefully.
