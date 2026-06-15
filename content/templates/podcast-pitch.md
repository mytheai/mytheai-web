# Podcast Pitch Template

Use this template to pitch AI, SaaS, and founder-focused podcast hosts. Target shows: Lenny's Podcast, Indie Hackers, My First Million, This Week in Startups, The Information's 411, AI Inside, Practical AI, Latent Space, SaaStr, The SaaS Podcast, Software Engineering Daily, plus niche AI/SaaS shows with 5k-50k downloads per episode. The goal is a guest appearance that produces a long-tail backlink from the show notes page plus brand reach.

---

## Target selector heuristics

Send to hosts and bookers whose show matches one or more of these signals:

1. Has hosted at least 3 solo founder guests in the last 90 days. Bootstrapped, single-person stories are an active editorial format for the show.
2. Audience size 5,000 to 100,000 downloads per episode. Below 5k the link value is too low to justify the prep time. Above 100k the show is booked 6 months out and unlikely to take cold pitches without a warm intro.
3. Show notes pages include outbound links to guest websites with descriptive anchor text (not just "guest website"). Some shows nofollow everything - check before pitching.
4. Has covered AI tooling, AI adoption, or directory businesses in the last 6 months. The host already has the framework to slot you into.
5. Active social presence (Twitter/X, LinkedIn) for the host. You will need a way to nudge them after the episode airs to share the show notes URL.

Skip: pure VC-pitch shows (you are not raising), enterprise-only shows (your audience is SMB and prosumer), shows that have not published in over 60 days (dormant).

---

## Subject line variants (A/B test 3 to 4 per outreach wave)

1. Guest pitch: solo founder who hand-tested 214 AI tools (no PR team)
2. Story angle for {{PODCAST_NAME}}: the honest AI directory
3. Pitch: building a directory without pay-to-rank in a $200B market
4. Guest idea - founder vs the AI listicle SEO cartel

---

## Email body template

Subject: {{SUBJECT_LINE_VARIANT}}

Hi {{HOST_NAME}},

I have been listening to {{PODCAST_NAME}} since {{SPECIFIC_EPISODE_DATE}} - the conversation with {{RECENT_GUEST_NAME}} about {{TOPIC}} was particularly sharp on the {{SPECIFIC_INSIGHT}} angle.

Quick pitch for a future episode. I am John Pham, the solo founder of MytheAi (mytheai.com), an AI and SaaS tools directory. The story angle that might fit your show is the "no PR team, no pay-to-rank, one person hand-testing 214 tools" arc - more a story of editorial obsession than a product launch.

What I could bring to a 45 to 60 minute conversation:

- The economics of running a directory business without taking VC and without the pay-to-rank pricing tier that competitors (TAAFT, Futurepedia, Toolify) all monetize through
- What I learned hand-testing 214 of the 593 tools in the catalog over 12 months - which categories are saturated, which are still wide open, which "leaders" do not survive 30 minutes of real use
- The Bing and Yandex SEO play that nobody talks about in the AI directory space (most competitors index only on Google and miss 30 to 40% of search demand)
- The decision to build the editorial moat first (hand-tested reviews, methodology page, founder bylines) before the SEO surface area
- Concrete numbers: 593 tools, 214 hand-tested, 252 comparisons, 73 top-10 lists, 506 tasks, 16 money pages, 101 long-form articles - all bylined, all dated, all human-tested

Story over feature angle. I would rather talk about the editorial philosophy and the trade-offs than walk through the product. Happy to share a brief or do a 15-minute prep call.

Available for recording {{AVAILABILITY_WINDOW_E_G_NEXT_3_WEEKS}}, any timezone. Press kit with bio, headshot, and stats is at mytheai.com/press.

Thanks for the work you do on {{PODCAST_NAME}}.

John Pham
Founder, MytheAi
mytheai.com
info@mytheai.com

---

## Follow-up cadence

- Day 0: send initial pitch
- Day 7 (only if no reply): one short bump - "Wanted to bump in case this is a fit. Available {{NEW_AVAILABILITY_WINDOW}} if the calendar is tight."
- Day 21 (only if still no reply): final note - "Last note. If a guest cancels or the topic comes up for a future episode, my calendar is open."
- After day 21: stop. Move to re-pitch list. Re-pitch every 6 months with a new milestone hook (250 hand-tested, new vertical opened, traffic milestone reached).

---

## Backlink tracking note

Log every outreach in affiliate-tracker.md under a new "Podcast outreach" tab with these columns: date sent, host name, podcast name, estimated downloads, vertical fit, subject line variant, reply received (Y/N), booking date, recording date, episode air date, episode URL, show notes URL, dofollow vs nofollow link, anchor text used. After episode airs, check Ahrefs for the show notes backlink and verify it resolved. Some podcast platforms (Apple Podcasts, Spotify embeds) strip outbound links - the value is in the show's own website show notes page.

---

## Story angles by show type (pick one per pitch)

**Founder-story shows** (Indie Hackers, My First Million, Starter Story):
- Story: "Solo founder builds AI directory without VC, hand-tests 214 tools, refuses pay-to-rank in a $200B market"
- Hook: the editorial-first business model vs the SEO-first business model

**AI/ML practitioner shows** (Latent Space, Practical AI, AI Inside):
- Story: "What 214 hands-on AI tool tests revealed about category leadership, vaporware, and the difference between demo and production"
- Hook: technical patterns across cohorts (code-ai 9-way, video-ai 9-way, etc.)

**SaaS/product shows** (SaaStr, This Week in Startups, The SaaS Podcast):
- Story: "How a directory business uses editorial moat as defensibility against well-funded competitors"
- Hook: the lib/stats.ts to TrustStack to /best/[category] funnel, plus Bing/Yandex multi-engine SEO

**Engineering shows** (Software Engineering Daily, Changelog):
- Story: "Running a 593-tool catalog as a solo developer using Next.js, Supabase, and Vercel"
- Hook: the technical stack, the ISR strategy, the IndexNow automation, the defensive guardrails (em-dash scan, em-dash blocker, vocab check, internal ref audit)

---

## Post-episode amplification checklist

After the episode airs:

1. Day 0: tweet from @mytheai linking show notes URL + 3 to 5 key quotes
2. Day 1: LinkedIn post from John Pham personal profile with longer-form takeaway
3. Day 3: write a "behind the scenes" blog post on mytheai.com/blog (e.g. "What I told {{PODCAST_NAME}} about hand-testing 214 AI tools") with internal link to the show notes URL - this is a 2-way link that boosts both pages
4. Day 7: check Ahrefs to confirm show notes backlink resolved, log dofollow status
5. Day 30: re-share episode on social if traffic referrer data shows the show audience is converting on /tools/[slug] visits
