# Task Taxonomy — Implementation Plan

**Initiative:** Build a long-tail SEO surface of `/tasks/[slug]` pages (e.g. `/tasks/ai-for-cold-emails`, `/tasks/ai-for-invoice-ocr`), each curating 3-10 tools for one specific job-to-be-done.

**Origin:** Competitive research (S111 follow-up) showed TAAFT operates 11,201 task pages — single largest SEO moat in the niche. MytheAi has 549 tools / 73 top10 / ~20 use-cases = ~150x smaller surface than TAAFT. Task taxonomy multiplies long-tail entry points without needing more tools.

**Goal stated by founder:** "làm cho Mytheai trở thành một trang top đầu" (make MytheAi top-tier globally).

**Strategic priority:** #1 post-freeze initiative. Must precede multilingual i18n (multiplying surface BEFORE multiplying language compounds correctly).

---

## 1. Goal & Success Criteria

### Primary outcome
A new route `/tasks/[slug]` rendering ranked tool lists for ultra-specific long-tail tasks, indexed by search engines, surfacing for queries like "best AI for cold emails", "AI invoice OCR tool", "AI to summarize Slack threads".

### Quantitative targets (12-month horizon)

| Metric | Launch (T+0) | T+3mo | T+6mo | T+12mo |
|--------|---|---|---|---|
| Live `/tasks/[slug]` pages | 50 | 200 | 500 | 1,000+ |
| Task pages indexed in GSC | 0 | 150 | 400 | 850+ |
| Organic clicks from /tasks/* | 0 | ~500/mo | ~3,000/mo | ~15,000/mo |
| Outbound conversions from /tasks | 0 | ~30/mo | ~250/mo | ~1,500/mo |
| Sitemap entries for /tasks | 0 | 200 | 500 | 1,000 |

### Qualitative success
- Each task page passes the "grandma test" — non-technical user lands from Google, sees 3-5 ranked tools with clear intro, picks one within 2 minutes.
- Task pages out-rank generic listicles ("Top 10 X tools 2026") for specific queries because they target NARROWER keywords with higher intent.
- Internal linking creates natural funnel: blog → task page → tool detail → /go redirect.

### Out of scope for v1
- Real-time task popularity ranking (defer to Phase 4)
- User-submitted task suggestions (defer indefinitely)
- Multilingual /tasks (defer to i18n phase, after VI/FR launch)
- Task-level vendor sponsorships (defer; first need SEO traffic)

---

## 2. Schema Decision

### Two viable patterns

**Option A — Static TS file (mimics top10.ts + useCases.ts)**
```ts
export const TASKS: Task[] = [
  {
    slug: 'ai-for-cold-emails',
    title: 'AI for Cold Emails',
    emoji: '✉️',
    primaryTags: ['writing-ai', 'sales-engagement'],
    pickedSlugs: ['lavender', 'lemlist', 'instantly', 'apollo-io', 'smartwriter'],
    intro: '...',
    methodology: '...',
    faqs: [...]
  },
  // ...500 entries
]
```

**Option B — Supabase `tasks` table**
```sql
CREATE TABLE tasks (
  slug text PRIMARY KEY,
  title text NOT NULL,
  emoji text,
  primary_tags text[],
  picked_slugs text[],         -- editor-picked tool order
  fallback_tags text[],        -- if picked_slugs < 3, augment via tag query
  intro text,
  methodology text,
  faqs jsonb,                  -- [{q, a}]
  difficulty text,             -- 'beginner' | 'intermediate' | 'advanced'
  monthly_search_volume int,   -- from GSC/keyword tools
  status text DEFAULT 'draft', -- 'draft' | 'published'
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);
```

### Tradeoffs

| Dimension | Option A (static TS) | Option B (Supabase) |
|---|---|---|
| 50 tasks | Fine | Overkill |
| 500 tasks | Painful (~10k LOC file) | Natural |
| 1000+ tasks | Unmaintainable | Natural |
| Edit one task | Code deploy + Vercel rebuild | UPDATE row, ISR refresh |
| Bulk import (CSV → 200 tasks) | Manual TS scaffolding | `\COPY` 1 command |
| Version control | Git diff per task edit | Audit trail via `updated_at` only |
| Build time | +~2-5s per 500 tasks | DB query at ISR refresh |
| Editorial team workflow | Engineer-only | Non-engineer can edit via Supabase Studio |

### Recommendation: **Option B (Supabase table)** — but with hybrid editorial workflow

**Why:**
1. Target is 500-1000 tasks. Static TS becomes unmanageable past ~100.
2. Many task fields (monthly_search_volume, status=draft) need ongoing updates — Supabase Studio gives non-engineer access without touching git.
3. Pattern matches `comparisons` table (also Supabase-backed with hub force-dynamic + detail ISR 86400) — reuses proven shape.
4. ISR weekly (604800s) is plenty fresh for SEO + amortizes any DB cost.

**Hybrid editorial workflow:**
- Tasks live in Supabase. Edit via Supabase Studio OR via SQL files in `web/tasks-batch-N.sql` (mirrors `tools-batch-N.sql` pattern that already works).
- For each batch, an idempotent `INSERT ... ON CONFLICT (slug) DO UPDATE SET ...` SQL ships in git for review.
- Source-of-truth = Supabase. Git SQL = audit trail. Best of both.

**Schema details (final, ready for SQL):**
```sql
CREATE TABLE IF NOT EXISTS tasks (
  slug text PRIMARY KEY,
  title text NOT NULL,           -- "AI for Cold Emails"
  h1_override text,              -- optional H1 (default: title)
  emoji text DEFAULT '🎯',
  primary_tags text[] NOT NULL,  -- maps to tools.tags controlled vocab (21 tags)
  picked_slugs text[],           -- editor-picked tool order, length 3-10
  fallback_min int DEFAULT 3,    -- if picked_slugs.length < fallback_min, augment via tag query (rating ≥ 4.0)
  intro text NOT NULL,           -- 80-180 words
  methodology text,              -- 60-120 words explaining selection criteria
  faqs jsonb DEFAULT '[]',       -- [{q, a}]
  category text,                 -- broad category for hub grouping ('writing'|'sales'|'dev'|'research'|...)
  difficulty text DEFAULT 'beginner',
  monthly_search_volume int,
  related_top10_slugs text[],    -- cross-link to existing top10 lists
  related_use_case_slug text,    -- cross-link to broader use-case
  related_blog_slugs text[],     -- cross-link to blog articles
  status text DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'retired')),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE INDEX idx_tasks_status ON tasks (status) WHERE status = 'published';
CREATE INDEX idx_tasks_category ON tasks (category) WHERE status = 'published';
CREATE INDEX idx_tasks_search_volume ON tasks (monthly_search_volume DESC NULLS LAST) WHERE status = 'published';
```

---

## 3. URL & Slug Rules + Relationship to Existing `/use-case`

### URL structure

| Route | Purpose | Cardinality | ISR |
|---|---|---|---|
| `/use-case/[slug]` (existing) | Broad category landing (e.g. "ai-for-writing", "ai-for-meetings") | ~20-30 | 604800 (weekly) |
| `/tasks` (new) | Hub: searchable index of all 500+ tasks | 1 | force-dynamic |
| `/tasks/[slug]` (new) | Specific task landing (e.g. "ai-for-cold-emails", "ai-for-invoice-ocr") | 500-1,000 | 604800 (weekly) |

### Hierarchy
`/use-case/ai-for-writing` (broad) → links to → `/tasks/ai-for-cold-emails`, `/tasks/ai-for-newsletters`, `/tasks/ai-for-blog-outlines` (specific children)

Use-cases stay = broad parent categories. Tasks = specific children. Both can coexist; they target different SERP intents.

### Slug rules

1. **Format:** `ai-for-{specific-action-or-output}` — kebab-case, lowercase only.
2. **Examples (good):**
   - `ai-for-cold-emails` ✅ specific output
   - `ai-for-invoice-ocr` ✅ specific document type
   - `ai-for-saas-onboarding-emails` ✅ niche but real
   - `ai-for-podcast-show-notes` ✅ specific creator workflow
3. **Examples (bad — too generic, belongs in /use-case):**
   - `ai-for-writing` ❌ → use `/use-case/ai-for-writing`
   - `ai-tools` ❌ → /tools directory
   - `chatgpt-alternatives` ❌ → /tools/chatgpt#alternatives or `/alternatives/chatgpt`
4. **Length cap:** ≤ 60 chars (SEO).
5. **No years in slug** (titles can have year, slug stays evergreen).
6. **No tool brand names in task slug** (those are alternatives pages, not tasks).
7. **Avoid synonym duplication:** `ai-for-cold-email` and `ai-for-cold-emails` cannot both exist; pick the plural by default (matches search query patterns better).

### Slug uniqueness check
Before adding any new task slug, run helper:
```bash
node --env-file=.env.local scripts/check-task-slug-conflicts.mjs <new-slug>
```
Script (to be built in Phase 1) checks: tasks table, top10 slugs, use-cases slugs, alternatives slugs — emits warning if any close match found.

---

## 4. Page Template Structure

### `/tasks/[slug]/page.tsx` sections (top → bottom)

```
┌──────────────────────────────────────────────────────────────┐
│ Breadcrumb: Home › Tasks › AI for Cold Emails                │
│                                                              │
│ <h1>Best AI for Cold Emails (2026)</h1>                      │
│ <p>Editorial intro 80-180 words framing the task.</p>        │
│                                                              │
│ [Updated: May 2026]  [5 tools curated]  [Difficulty: Easy]   │
└──────────────────────────────────────────────────────────────┘

┌─ Quick picks (3 tools above the fold) ──────────────────────┐
│ ┌───────────────┐  ┌───────────────┐  ┌───────────────┐    │
│ │ Best overall  │  │ Best free     │  │ Best for vol  │    │
│ │ Lavender      │  │ Smartwriter   │  │ Lemlist       │    │
│ │ ★ 4.7         │  │ ★ 4.3         │  │ ★ 4.6         │    │
│ │ Visit →       │  │ Visit →       │  │ Visit →       │    │
│ └───────────────┘  └───────────────┘  └───────────────┘    │
└──────────────────────────────────────────────────────────────┘

┌─ Full ranked list (3-10 tools) ──────────────────────────────┐
│ #1 Lavender  ★ 4.7  Freemium                                 │
│   Why it's #1 for cold emails: [1-2 sentence editorial pick] │
│   [Visit →] [Compare with Lemlist →] [Full review →]         │
│                                                              │
│ #2 Lemlist   ★ 4.6  Paid                                     │
│   ...                                                        │
└──────────────────────────────────────────────────────────────┘

┌─ How we picked (methodology) ─────────────────────────────────┐
│ 60-120 words explaining what mattered for THIS task         │
│ (e.g. personalization quality, deliverability, CRM sync).   │
└──────────────────────────────────────────────────────────────┘

┌─ Comparison table (top 2-3 head-to-head) ────────────────────┐
│ Reuses ComparisonTable component from /compare              │
│ Auto-link to /compare/lavender-vs-lemlist                   │
└──────────────────────────────────────────────────────────────┘

┌─ FAQs (3-5 questions) ───────────────────────────────────────┐
│ Q: What's the difference between cold email AI and...?       │
│ A: ...                                                       │
└──────────────────────────────────────────────────────────────┘

┌─ Related tasks (3-6 cross-links) ────────────────────────────┐
│ ai-for-email-newsletters · ai-for-sales-followups            │
│ ai-for-linkedin-messages · ai-for-meeting-followups          │
└──────────────────────────────────────────────────────────────┘

┌─ Related broader categories (1-3 links) ─────────────────────┐
│ Use case: AI for Sales · Top 10 Cold Email Tools 2026       │
│ Blog: How to write cold emails that convert (2026 playbook) │
└──────────────────────────────────────────────────────────────┘

┌─ Affiliate disclosure footer (mandatory) ────────────────────┐
└──────────────────────────────────────────────────────────────┘
```

### Component reuse
- ToolCard (existing)
- ComparisonTable from `/compare/[slug]` route
- TrustStack mini-row on each picked tool
- FAQ accordion from `/use-case/[slug]`
- Affiliate disclosure component

### Data fetch pattern
```ts
// /tasks/[slug]/page.tsx
export const revalidate = 604800

async function getTaskWithTools(slug: string) {
  const supabase = createStaticClient()
  
  const { data: task } = await supabase
    .from('tasks')
    .select('*')
    .eq('slug', slug)
    .eq('status', 'published')
    .single()
  
  if (!task) return null
  
  // Editor-picked first
  let toolSlugs = task.picked_slugs || []
  
  // Augment from tag if below fallback_min
  if (toolSlugs.length < (task.fallback_min || 3)) {
    const { data: augmentTools } = await supabase
      .from('tools')
      .select('slug')
      .overlaps('tags', task.primary_tags)
      .gte('rating', 4.0)
      .order('rating', { ascending: false })
      .limit(10)
    
    const augmentSlugs = (augmentTools || []).map(t => t.slug)
    toolSlugs = [...new Set([...toolSlugs, ...augmentSlugs])].slice(0, 10)
  }
  
  // Fetch full tool data preserving order
  const { data: tools } = await supabase
    .from('tools')
    .select('slug, name, tagline, logo_url, website_url, rating, review_count, pricing_type, scores, use_cases')
    .in('slug', toolSlugs)
  
  const orderedTools = toolSlugs
    .map(s => tools?.find(t => t.slug === s))
    .filter(Boolean)
  
  return { task, tools: orderedTools }
}
```

---

## 5. Top 500 Task Curation Methodology

### Source pyramid (highest signal first)

**Tier 1 — Existing demand (validate first):**
1. **Google Search Console current queries** — `web/scripts/gsc-fetch.mjs` already exists. Pull all queries with ≥5 impressions over last 90 days that contain pattern `ai for *`, `*ai tool`, `ai * generator`, etc. Cluster by intent. Estimate: 200-400 candidate task slugs.
2. **Existing tool `use_cases` array** — 549 tools each have 3-10 use_case strings. Aggregate, normalize, deduplicate. Estimate: 800-1,500 unique strings → cluster down to 200-400 task slugs.

**Tier 2 — Competitive mining:**
3. **TAAFT crawl** — public sitemap.xml at theresanaiforthat.com/sitemap.xml lists all 11,201 task URLs. Slug names alone reveal taxonomy without scraping content. Estimate: 5,000+ candidate slugs after filtering for relevance to MytheAi catalog.
4. **Reddit / IndieHackers / r/Entrepreneur** — search "AI tool for X" within last 6 months. Real user phrasing surfaces tasks that don't show in keyword tools yet (rising demand signal).

**Tier 3 — AI brainstorm + manual editorial:**
5. **Claude/GPT brainstorm** — for each broad category (writing, sales, dev, research, design, ops, support, marketing, finance), generate 50-100 specific task variants. Filter by realism + uniqueness.
6. **Founder editorial picks** — head-term tasks the founder believes high-converting based on affiliate intuition (TAAFT-confirmed but cherry-picked).

### Selection criteria (must pass ALL gates to enter v1 launch list)

**Gate A — Real demand:**
- Has GSC impressions ≥ 5/month (validated demand) OR
- Appears in TAAFT (validated demand by competitor's existing traffic) OR
- Founder has direct evidence from sales/community channels

**Gate B — Mappable to MytheAi catalog:**
- ≥ 3 tools in current 549 catalog plausibly serve this task (via tag overlap OR use_cases overlap OR manual judgment)
- If <3 tools fit → defer task until catalog covers it

**Gate C — Editorial defensibility:**
- Task is specific enough that a curated list adds value over a generic Google search
- Task isn't a thinly disguised brand alternative (those go in /alternatives/)
- Task isn't redundant with existing /use-case or /top-10 (cross-link instead)

### Curation phases

**Phase 1 — v1 launch list (50 tasks):**
- 100% editorial. Founder picks top 50 highest-conviction tasks.
- Each gets full editorial: hand-written intro + methodology + 3-5 FAQs + manually-picked tool order.
- Source: GSC top queries + founder intuition + 5-10 TAAFT-validated head-terms.

**Phase 2 — expand to 200 (Sessions 3-4):**
- 80% editorial / 20% template-driven.
- Pull 150 candidates from GSC (ranked by impressions) + cluster from tool use_cases.
- Each task: short editorial intro (template-fed: "Looking for AI to {action}? Here are the top tools...") + manually-picked tool list of 3-5.
- FAQs auto-derived from common question patterns ("How much does X cost?", "Is X free?", "Best free X?") with task-specific answers.

**Phase 3 — expand to 500 (Sessions 5-7):**
- 50% editorial / 50% template-driven.
- Mine TAAFT slug list + Reddit query mining for next 300 candidates.
- Tasks below top-100 by search volume get template intros (still pass quality bar but lower editorial investment).
- Tool list: tag-based auto-fetch with manual override on top 3.

**Phase 4 — expand to 1,000+ (Sessions 8-12):**
- 30% editorial / 70% template-driven.
- Long-tail tasks. Quality bar: still must pass Gate A (demand) and Gate B (mappable).
- Consider AI-assisted intro generation (Claude API) with founder review queue.

### Anti-pattern: do not launch with 500 thin pages
Spam-tier task pages with auto-generated intros + auto-picked tools = Google de-indexes the whole subdirectory and harms the rest of the site. Phase 1's 50 fully-editorial pages establish quality signal; only after that scale.

---

## 6. Editorial Mapping Process (3-tier system)

### Tier S — Head-term (top 50 tasks, full editorial)

For each task:
1. Founder writes 80-180 word intro framing WHY this task matters and WHO needs it.
2. Methodology: 60-120 words on selection criteria specific to THIS task (e.g., for "AI for cold emails": deliverability + CRM sync + personalization quality).
3. Pick 3-5 tools from 549. Order = editorial conviction (not just rating).
4. Write 1-2 sentence pick reason for each tool ("Why it's #1 for cold emails: ...").
5. 3-5 FAQs answering buying-stage questions specific to task.
6. Set `monthly_search_volume` from GSC data.
7. Cross-link to: 1 broader use-case + 1-2 related top10 + 1-2 related blog articles + 3-6 related tasks.

**Time investment:** ~30-45 min per task. 50 tasks ≈ 25-37 hours.

### Tier A — Mid-tail (tasks 51-200, semi-editorial)

For each task:
1. Intro (40-80 words) — uses template scaffold but founder rewrites bridge sentences.
2. Methodology can reference broader use-case methodology by link.
3. Pick 3-5 tools — order can rely on tag-fetch + manual override of top 2.
4. 2-3 FAQs (lighter than tier S).

**Time:** ~15-20 min per task. 150 tasks ≈ 38-50 hours.

### Tier B — Long-tail (tasks 201-500, template-driven)

For each task:
1. Intro auto-generated from template + founder QA review (not full rewrite).
2. Methodology: short pointer to parent use-case methodology.
3. Tools: auto-fetched by tag query with rating ≥ 4.0; manual override on top 1-2.
4. 1-2 FAQs from question bank.

**Time:** ~5-8 min per task. 300 tasks ≈ 25-40 hours.

### Quality gate at every tier
- ZERO em-dashes (`—`) in any task field — strict project rule. Use ` - ` or `:` instead.
- Every task must have ≥ 3 tools at publish time.
- Internal `related_top10_slugs` and `related_use_case_slug` must verify against live DB before publish (reuse `audit-internal-refs.mjs` pattern).
- Spelling/grammar pass via founder editorial review before flipping `status='draft'` → `status='published'`.

---

## 7. Internal Linking Strategy

The compounding edge of this initiative is internal linking density. A task page in isolation gets ~3-15 organic clicks/month. A task page in a tightly-linked graph gets 50-200 because:
- Existing /tools/[slug] pages funnel tagged-task readers
- Blog articles link to relevant tasks
- Top10 lists link to specific tasks
- /use-case/[slug] hub-and-spokes outward to tasks
- Sitemap surfaces tasks for crawlers

### Linking targets

**A. From `/tools/[slug]` detail page → tasks:**
- New section "Best for these tasks" listing 3-5 task pages where this tool appears in `picked_slugs[]`.
- Reverse-lookup: query `tasks WHERE this_tool_slug = ANY(picked_slugs)` and display top 5 by `monthly_search_volume`.
- Placement: below TrustStack sidebar on detail page.

**B. From `/top-10/[slug]` page → tasks:**
- New section "Specific tasks where these tools shine" — manually curate 3-6 tasks per top10 list (mirrors `related_top10_slugs[]` from tasks table reverse-applied).

**C. From `/use-case/[slug]` page → tasks:**
- Add "Specific use cases" section listing all tasks where `category = use_case_slug`.
- E.g. /use-case/ai-for-writing → links to all `/tasks/ai-for-*` with category='writing'.

**D. From blog articles → tasks:**
- Update blog footer auto-link generator to surface relevant tasks (currently surfaces /alternatives/ + /free-ai-tools/).
- Match blog tags to task primary_tags; surface top 3 tasks.

**E. From `/tasks/[slug]` → other tasks:**
- "Related tasks" section. Auto-derive: tasks with overlapping primary_tags AND different slug.
- Manually override `related_task_slugs[]` for tier S head-terms.

**F. Homepage:**
- New section "Find AI for any task" — searchable autocomplete pulling from tasks. Above-fold placement TBD (test against current quiz CTA).
- Or: replace "Browse by Category" with "Browse by Task" if click-through wins.

**G. /tasks hub page:**
- Searchable index. Group by category (writing, sales, dev, design, research, ops, support, marketing, finance).
- Filter chips: difficulty, free-tier-available, category.
- Shows task title + 3 tool logos preview + monthly_search_volume as social proof.

### Anti-orphan rule
No task page may launch with zero inbound links from existing pages. Every new task added must:
1. Have at least 1 reciprocal link from an existing /tools/[slug] (via picked_slugs membership).
2. Be linked from /tasks hub.
3. Be in sitemap.

---

## 8. SEO + Structured Data + Sitemap

### Title pattern
```
{Task Title} ({Year}) - {N} Top Picks Reviewed | MytheAi
```
Examples:
- "AI for Cold Emails (2026) - 5 Top Picks Reviewed | MytheAi"
- "AI Invoice OCR Tools (2026) - 7 Top Picks Reviewed | MytheAi"

### Meta description pattern (155 chars)
```
The {N} best AI tools for {task action}, ranked by editorial review. {Top tool} leads for {benefit}. Updated {month} {year}.
```

### H1
Same as title minus trailing brand: `Best AI for Cold Emails (2026)`.

### Structured data
- `ItemList` schema with `ListItem` for each picked tool (matches /top-10 pattern).
- `FAQPage` schema for FAQ section.
- `BreadcrumbList`: Home › Tasks › {Task Title}.

### Canonical URL
Always `/tasks/[slug]` — never `/tasks/[slug]?utm=*` etc. Set explicit canonical in metadata.

### Sitemap
Add to `web/src/app/sitemap.ts`:
```ts
const { data: tasks } = await supabase
  .from('tasks')
  .select('slug, updated_at')
  .eq('status', 'published')

const taskUrls = (tasks || []).map(t => ({
  url: `${baseUrl}/tasks/${t.slug}`,
  lastModified: new Date(t.updated_at),
  changeFrequency: 'weekly' as const,
  priority: 0.7,
}))
```

Plus `/tasks` hub itself (priority 0.8, weekly).

### Robots
Allow `/tasks/*`. No disallow.

### IndexNow ping
Reuse existing `web/scripts/indexnow-ping.mjs` to ping Bing/Yandex when new task batch ships. ~50 URLs at once.

---

## 9. Phasing Plan (estimated 8-12 sessions)

| Phase | Sessions | Output | Effort |
|---|---|---|---|
| **Phase 0 — Foundation** | 1 | Schema SQL, route scaffold (`/tasks/page.tsx` hub + `/tasks/[slug]/page.tsx` detail with empty data), sitemap integration, slug-conflict check script | 3-4h |
| **Phase 1 — V1 launch (50 tasks)** | 2-3 | 50 tier-S editorial tasks. Internal linking from /tools/[slug] + /top-10/[slug] + blog footer. Live + indexed in GSC. | 25-37h spread |
| **Phase 2 — Expand to 200** | 4-5 | 150 tier-A tasks. Augment internal linking (use-case hub-spokes). Homepage discovery section. | 38-50h spread |
| **Phase 3 — Expand to 500** | 6-7 | 300 tier-B tasks. TAAFT-mined long-tail. Template-driven scale. | 25-40h spread |
| **Phase 4 — Optimization** | 8 | A/B test hub layouts. Add task-level Plausible events. Identify top-converting tasks → upgrade their tier. Begin VI translation prep. | 4-6h |
| **Phase 5+ — Scale** | 9-12+ | 500 → 1,000+ tasks. Multilingual rollout. Vendor sponsorship slots on task pages (deferred from initial). | Ongoing |

### Per-session block pattern (continues proven Mode A+D 4-block cadence)

**Phase 1 session example (one of 3):**
- Block 1 (~30min) — Curate next 17 tasks: validate against gates, write SQL INSERT scaffold
- Block 2 (~60min) — Editorial: write intros + methodologies + FAQs for those 17
- Block 3 (~30min) — Pick + order tools per task, set picked_slugs[]
- Block 4 (~30min) — Internal link audit (related_top10_slugs[], related_use_case_slug, related_blog_slugs[]), verify against live DB, ship via run-sql.mjs
- Block 5 (~10min) — Build clean check, sitemap regen, IndexNow ping

### Quality gates per session
- Em-dash audit: 0 in any task field
- audit-internal-refs.mjs: 0 broken
- check-vocab.mjs: still 21 tags (no drift)
- Build clean
- Each new task has ≥ 1 inbound link from existing page

---

## 10. Risks, Mitigations, Open Decisions

### Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Google indexes 500 thin pages → de-rank whole site | Medium | High | Phase 1 = 50 fully-editorial; only scale after 30-day GSC indexation health check shows clean indexing |
| Slug naming drift (synonyms collide) | Medium | Medium | check-task-slug-conflicts.mjs script gates new slugs |
| Tool catalog gaps (task has <3 mappable tools) | Medium | Low | Gate B blocks; defer task or extend catalog first |
| Editorial bottleneck — founder writes 50 intros = 25-40h | High | Medium | Phase 1 chunks across 3 sessions; tier A/B reduce per-task time |
| TAAFT crawl gets blocked / TOS issue | Low | Low | TAAFT sitemap.xml is publicly served — slug names are not protected. Don't scrape content, only slug taxonomy. |
| Internal link explosion → "everywhere links everywhere" mess | Medium | Medium | Anti-orphan rule + max 6 related tasks per page + monthly link audit |
| ISR weekly is too slow for tool inventory changes | Low | Low | When a tool deprecates, manual `revalidate=true` on affected task pages (script tbd) |
| Cannibalize existing /use-case + /top-10 traffic | Low | Low | Different SERP intent: /use-case = broad, /tasks = narrow. Should cross-feed, not cannibalize. Monitor GSC for collisions. |

### Decisions LOCKED (founder accepted all defaults 2026-05-07)

All 7 decisions resolved with the recommended option. Phase 0 executes on first session post-freeze without further alignment pause.

1. **Phase 1 size:** ✅ **50 tasks**
2. **Source for top 50:** ✅ **GSC-only Phase 1, TAAFT mining begins Phase 2**
3. **Hub page design:** ✅ **Hybrid — search input above fold + category grid below**
4. **Internal linking from `/tools/[slug]`:** ✅ **Conservative cap of 3 tasks per tool detail page** (A/B test for higher density deferred to Phase 4)
5. **Task category vocabulary:** ✅ **BOTH** — 21-tag controlled vocab continues to drive tool fetch via `primary_tags[]`. NEW `tasks.category` enum field with 8-12 broad buckets (writing / sales / dev / design / research / ops / support / marketing / finance / data-analytics / hr-recruiting / customer-success) drives `/tasks` hub grouping
6. **Route prefix:** ✅ **`/tasks/[slug]`** (not `/find/ai-for-[slug]`)
7. **First batch ship cadence:** ✅ **Phase 0 first** (schema + scaffold + 5 demo tasks for QA), then Phase 1 v1 launch next session

### Phase 0 — autonomous execution checklist (ready to run at unfreeze)

The moment freeze ends (~2026-05-10), Phase 0 runs without any alignment break. All decisions locked, all artifacts pre-specified in §11. The session opens with a TodoWrite listing the 7 actions and proceeds through them in order. No AskUserQuestion needed unless a Gate B mapping issue surfaces (task with <3 mappable tools — defer that task and continue with the other 4).

---

## 11. Phase 0 Concrete Next Actions (Session 1 of work)

The first session executes:

1. **Schema migration** — write `web/migrations/2026-05-XX-create-tasks-table.sql` with the schema in §2. Apply via existing run-sql.mjs.
2. **Slug conflict checker** — write `web/scripts/check-task-slug-conflicts.mjs` (cross-references tasks + top10 + use-cases + alternatives slugs).
3. **Route scaffold** — create `web/src/app/tasks/page.tsx` (hub, force-dynamic) and `web/src/app/tasks/[slug]/page.tsx` (detail, ISR 604800). Empty styling = pass build, no real data yet.
4. **Sitemap update** — patch `web/src/app/sitemap.ts` to include /tasks routes.
5. **Demo data** — INSERT 5 sample tasks via `web/tasks-batch-1.sql`. Pick safest head-terms with strong tag overlap: `ai-for-cold-emails`, `ai-for-meeting-summaries`, `ai-for-blog-outlines`, `ai-for-invoice-ocr`, `ai-for-resume-writing`. Each fully editorial.
6. **Internal link bootstrap** — add task links to those 5 tools' detail pages. Add /tasks hub link to header nav. Confirm sitemap picks up routes.
7. **Smoke test** — visit each /tasks/[slug] in dev, verify tool list renders, no console errors, build clean, audit-internal-refs clean.

**Output of session 1:** Live (preview) `/tasks` route with 5 tasks. Founder QAs each. After approval, ship to prod. Phase 1 session 2 expands by +15-20 tasks.

---

## 12. Reference Patterns to Reuse

| Existing pattern | Reuse for /tasks |
|---|---|
| `web/src/app/use-case/[slug]/page.tsx` data fetch | Same shape, swap static `useCases.ts` for Supabase `tasks` query |
| `web/src/app/top-10/[slug]/page.tsx` ItemList JSON-LD | Identical schema markup |
| `web/src/app/compare/[slug]/page.tsx` auto-fallback (lib/auto-compare.ts) | Conceptually similar: editor-picked first, augment via tags if below fallback_min |
| `web/scripts/audit-internal-refs.mjs` | Extend to also audit task → top10 / task → use-case / task → blog refs |
| `web/scripts/check-vocab.mjs` | Extend to also audit task primary_tags against 21-tag controlled vocab |
| `tools-batch-N.sql` idempotent INSERT pattern | Mirror as `tasks-batch-N.sql` |
| `web/scripts/run-sql.mjs` | Same execution path for tasks SQL |
| `lib/scoring.ts` weighted scoring | If task pages need composite score for ranking, reuse |
| `web/src/components/tools/ToolCard.tsx` | Direct reuse on task pages for picked tools |
| `web/src/components/seo/JsonLd.tsx` (if exists) or inline JSON-LD pattern | Reuse for ItemList + FAQPage + BreadcrumbList |

---

## 13. North Star

The end state, 12 months from launch:

- **1,000+ /tasks/[slug] pages** indexed and ranking
- **15,000+ organic clicks/month** from /tasks (vs current 0)
- **MytheAi ranks top-3 globally for "AI for [task]" queries** in primary domain
- **Multilingual /tasks** in EN + VI + FR (founder native + 2 expansion markets)
- **Vendor partnerships** at task level: "Sponsored pick for AI for cold emails" slot at $497/mo (~$5k MRR if 10 tasks sponsored)
- **MytheAi recognized in industry press** as the top-tier curated AI directory

This is the single biggest structural unlock for outranking comparateur-ia, Futurepedia, TAAFT, and Toolify on long-tail search. Execute step-by-step. Ship Phase 0 first. Quality bar at every tier.
