# Native EN/FR i18n Migration Plan

Comprehensive plan for replacing the Google Translate widget with native bilingual rendering. Estimated effort: **1-2 dev days**. Run as a dedicated session, not interleaved with content cadence.

## Why this matters

Google Translate widget produces machine-quality FR which:
- Hurts trust on non-English audience (FR market is large, comparateur-ia.com is direct competitor)
- Doesn't index in Google FR (Translate runs client-side; Googlebot sees only EN HTML)
- Breaks layout occasionally on long FR strings (e.g. "Compare" -> "Comparer" wraps badly)

Native i18n unlocks:
- FR organic traffic from Google.fr / Bing.fr
- `mytheai.com/fr/...` URLs in sitemap (separate FR pages)
- Brand credibility ("French version" vs "machine translation")

## Stack decision

**Use `next-intl` v3** (App Router native, supports route segments, server components, streaming).

Alternatives considered:
- `next-i18next`: pages-router era, worse App Router story.
- `react-i18next` standalone: client-only, hurts SEO.
- Custom solution: not worth reinventing.

## Architecture

### Routing

URL pattern: `/{locale}/...`

```
/                  -> redirect to /en (or detect Accept-Language)
/en/tools          -> EN tools page
/fr/tools          -> FR tools page
/en/tools/cursor   -> EN Cursor review
/fr/tools/cursor   -> FR Cursor review
```

Both locales render at build/ISR time. SEO `hreflang` tags on every page link to its sibling locale.

### Source of strings

Two layers:

**Layer 1 (static UI strings)** - JSON files per locale:
```
web/messages/en.json
web/messages/fr.json
```

Example:
```json
// en.json
{
  "Header": { "tools": "Tools", "compare": "Compare", "top10": "Top 10" },
  "ToolCard": { "visit": "Visit", "viewReview": "View Review" }
}
```

**Layer 2 (DB content)** - JSONB per-locale columns on `tools`, `comparisons`, `categories`:
```sql
ALTER TABLE tools ADD COLUMN IF NOT EXISTS tagline_fr TEXT;
ALTER TABLE tools ADD COLUMN IF NOT EXISTS description_fr TEXT;
ALTER TABLE comparisons ADD COLUMN IF NOT EXISTS summary_fr TEXT;
ALTER TABLE categories ADD COLUMN IF NOT EXISTS name_fr TEXT;
ALTER TABLE categories ADD COLUMN IF NOT EXISTS description_fr TEXT;
```

Pros and cons remain EN for v1 (FR-translate later). Same for use_cases. Pricing values are language-neutral.

**Blog content (MDX)** - duplicate per locale:
```
content/blog/en/best-ai-coding-tools-2026.mdx
content/blog/fr/best-ai-coding-tools-2026.mdx
```

Or parallel directory `content/blog-fr/`. Decision: per-locale subdir cleaner.

## Phase breakdown

### Phase 1 - Setup (2-3 hours)

1. `npm i next-intl@latest`
2. Create `i18n.ts` with locale config, default locale `en`, supported `['en', 'fr']`.
3. Add middleware `web/src/middleware.ts` to:
   - Detect locale from URL prefix
   - Fallback to `Accept-Language` header on `/`
   - Rewrite `/tools` -> `/en/tools` (or redirect)
4. Move all routes from `web/src/app/{tools,compare,...}/` to `web/src/app/[locale]/{tools,compare,...}/`.
5. Wrap root layout with `<NextIntlClientProvider>`.
6. Update all `<Link>` references to use `useLocale()` or pathname-relative.

**Risk**: route restructure breaks ISR. Test build after Phase 1 before adding strings.

### Phase 2 - String extraction (4-5 hours)

Walk every page and component:
1. Extract hardcoded EN strings into `messages/en.json` keys.
2. Replace inline strings with `t('Header.tools')` etc.
3. Cover: Header, Footer, all section headers, all CTAs ("Visit", "Read Review", "View All"), error/empty states, form labels, metadata title/description templates.
4. Generate `messages/fr.json` skeleton (same keys, French values - LLM-assist with Claude or DeepL Pro for first pass, then human edit).

**Estimated string count**: ~250-350 keys. ~6-8 hours total to translate well.

### Phase 3 - DB migration (2 hours)

1. Add `_fr` columns (see schema above) via `migrations/i18n-columns.sql`.
2. Backfill FR content for top 50 tools (highest review_count) in v1 launch. Other tools fall back to EN with banner "Translation pending".
3. Top 50 backfill via batch script or Supabase Studio. ~50 tools x 5 fields = 250 string fields. Use Claude API to generate FR drafts, human review.

### Phase 4 - Page rendering (3-4 hours)

Per page type:

**Tool page** (`[locale]/tools/[slug]/page.tsx`):
```tsx
const tagline = locale === 'fr' && tool.tagline_fr ? tool.tagline_fr : tool.tagline
```

**Comparison page**: same pattern with `summary_fr`.

**Top 10 / Categories**: name/description per locale, but slug stays EN (for URL stability).

**Blog**: read from `content/blog/{locale}/{slug}.mdx`. Fallback to EN if FR file missing.

**Metadata**: title/description per locale via `generateMetadata({ params: { locale } })`.

### Phase 5 - SEO + sitemap (1-2 hours)

1. Update `sitemap.ts` to emit both `/en/...` and `/fr/...` URLs with `alternates` (hreflang).
2. Add `<link rel="alternate" hreflang="fr" href=".../fr/..." />` in `<head>` of every page.
3. Add `<link rel="alternate" hreflang="x-default" href=".../en/..." />` for default.
4. Update root `/` redirect to detect `Accept-Language`.
5. Submit FR sitemap separately to Google Search Console (or `mytheai.com/sitemap.xml` includes both).

### Phase 6 - LanguagePicker rewrite (1 hour)

Replace Google Translate widget (`web/src/components/layout/LanguagePicker.tsx`) with:
- Native `<Link>` toggling `/en/...` vs `/fr/...`
- Preserve current path: e.g. on `/en/tools/cursor`, FR link goes to `/fr/tools/cursor`
- Drop Google Translate script entirely (smaller bundle, no banner CSS hacks)

### Phase 7 - QA pass (2 hours)

Manual visit:
1. `/`, `/en`, `/fr` - all render correctly
2. `/en/tools/cursor` and `/fr/tools/cursor` - FR text visible, hreflang correct
3. `/en/blog/best-ai-coding-tools-2026` and `/fr/...`
4. Switch via LanguagePicker on every page type
5. Build size before/after (Google Translate ~50KB removed, next-intl ~30KB added)
6. Lighthouse FR locale - LCP, CLS still <1.8s / <0.05
7. View source: hreflang tags present on top 10 page types

## Critical files to touch

```
web/src/middleware.ts                  (NEW)
web/i18n.ts                            (NEW)
web/src/app/[locale]/...               (route move - 30+ files)
web/messages/en.json                   (NEW)
web/messages/fr.json                   (NEW)
web/src/app/sitemap.ts                 (EDIT - hreflang)
web/src/components/layout/Header.tsx   (EDIT - useTranslations)
web/src/components/layout/Footer.tsx   (EDIT)
web/src/components/layout/LanguagePicker.tsx  (REWRITE)
web/migrations/i18n-columns.sql        (NEW - alter table)
content/blog/en/                       (RENAME from content/blog/)
content/blog/fr/                       (NEW - translate top 10 first)
```

## Hard rules

1. **No em dashes** in any FR translation. Use ` - ` or `:`.
2. **EN URLs unchanged**: `mytheai.com/tools/cursor` must still 200 (or 301 to `/en/tools/cursor`). Don't break existing backlinks.
3. **Slugs stay English**: `/fr/tools/cursor` not `/fr/outils/cursor`. Avoids slug duplication and keeps DB joins simple.
4. **Fallback gracefully**: if `tagline_fr` is NULL, render `tagline` (EN) without warning.
5. **Tag stays EN**: don't translate `tags[]` array. Categories have `name_fr` for display, but `tags` JSONB array stays EN for filter logic.
6. **SQL idempotency**: i18n migration uses `ADD COLUMN IF NOT EXISTS`.

## Out of scope (v1)

- Pros/cons translation (defer; ~5K array entries to translate)
- Use cases translation (defer)
- User reviews translation (no real users yet)
- Spanish, Hindi, Chinese (Phase 2 of i18n - reuse the framework)
- RTL languages (Arabic, Hebrew - separate concern, not on roadmap)
- Localized prices (keep USD; FR users see USD prices, future improvement)

## Verification (end-to-end)

1. `npm run build` clean, both `/en/...` and `/fr/...` routes generated.
2. `curl https://mytheai.com/fr/tools/cursor | grep '<meta name="description"'` shows French text.
3. `curl https://mytheai.com/en/tools/cursor | grep '<link rel="alternate" hreflang="fr"'` returns the FR sibling URL.
4. Lighthouse on `/fr/` locale: LCP <1.8s, CLS <0.05.
5. Google Search Console (after 7-14 days): FR pages start indexing.
6. Sitemap.xml shows both EN and FR URLs.

## Migration checklist (run-day)

- [ ] Phase 1: install next-intl, restructure routes, build green
- [ ] Phase 2: extract ~300 keys to en.json, generate fr.json draft, human-review
- [ ] Phase 3: ALTER TABLE migration on Supabase
- [ ] Phase 3b: backfill FR for top 50 tools (Claude API + human review)
- [ ] Phase 4: render `_fr` fields conditionally on all page types
- [ ] Phase 5: sitemap hreflang, root redirect, GSC re-submit
- [ ] Phase 6: rewrite LanguagePicker, drop Google Translate widget
- [ ] Phase 7: QA pass + Lighthouse + build size diff
- [ ] Commit chain: `i18n-1-scaffold`, `i18n-2-strings`, `i18n-3-db`, `i18n-4-pages`, `i18n-5-seo`, `i18n-6-picker`
- [ ] Update `CLAUDE.md` with i18n session log

## Cost estimate

- Dev time: 12-16 hours (Claude-assisted)
- Translation review: 4-6 hours human (or paid FR native reviewer)
- Claude API for translation drafts: ~$5-10 (300 strings + 50 tool blurbs)
- Total: 1-2 working days

## Quick win before full i18n (optional, 30 min)

If FR launch is far away, at least improve Google Translate banner:
1. Pre-translate Header/Footer strings via JSON config (no full route refactor)
2. Pre-translate hero H1 + tagline
3. Keep Translate widget for body content
4. Better than current state but not worth doing if i18n session is scheduled within 30 days

Recommend skip and go direct to native i18n.
