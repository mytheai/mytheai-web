import type { Metadata } from 'next'
import Link from 'next/link'
import AuthorBio from '@/components/layout/AuthorBio'

export const metadata: Metadata = {
  title: 'How We Rank AI Tools: Editorial Methodology | MytheAi',
  description: 'The exact methodology MytheAi uses to score, rank, and compare 559 AI and SaaS tools. Seven-criteria scoring system, sourcing, and update cadence explained.',
  alternates: { canonical: 'https://mytheai.com/methodology' },
  openGraph: {
    title: 'How We Rank AI Tools: Editorial Methodology | MytheAi',
    url: 'https://mytheai.com/methodology',
  },
}

export default function MethodologyPage() {
  const sections: { title: string; body: string[] }[] = [
    {
      title: 'Why methodology matters',
      body: [
        'Most AI directory sites do not publish how they rank tools because there is no real ranking - listings are sorted by affiliate commission rate, sponsored slot bids, or whoever paid for placement that quarter. The user gets a sorted list that has nothing to do with which tool is actually best for them.',
        'MytheAi takes the opposite approach. Every tool, comparison, and Top 10 list is scored against a public seven-criteria framework. This page documents that framework completely so you can decide for yourself whether our rankings match your priorities, and so you can challenge any score you think is wrong.',
      ],
    },
    {
      title: 'The seven scoring criteria',
      body: [
        'We score each tool on a 1-5 scale across seven criteria. The composite score determines the editorial rating shown on tool pages and the rank order in Top 10 lists.',
      ],
    },
    {
      title: 'How we test tools',
      body: [
        'For tools we can install or sign up for directly (most SaaS), we run a minimum 8-hour evaluation across two work sessions. We use the tool on real tasks from our backlog - drafting blog posts, comparing legal documents, building UI prototypes, summarizing meeting recordings - rather than synthetic prompts.',
        'For enterprise tools that require a sales call to access (some compliance, healthcare, and CLM platforms), we rely on documented features, third-party reviews from G2 and Capterra, customer case studies, and industry analyst reports. These tools are flagged with a "limited hands-on" note where applicable.',
        'For tools that change pricing or features frequently, we re-verify on a 90-day cadence and update the "Last verified" date on the tool page. Pricing is independently verified - we do not trust self-reported pricing on tool websites because it changes faster than vendors update copy.',
      ],
    },
    {
      title: 'How rankings are protected from affiliate influence',
      body: [
        'Affiliate commission rates are not visible to anyone making editorial decisions. The team member who maintains affiliate relationships is separate from the team member writing reviews. This is the simplest structural protection: if scoring does not see commission data, scoring cannot be biased by it.',
        'Specifically: a tool that pays MytheAi a 30% recurring commission can rank below a tool that pays 0% if the lower-commission tool scores higher on the seven criteria. If you find a ranking that looks suspicious - say, a tool that is widely panned ranked above one with strong reviews - email us at info@mytheai.com and we will publish the score breakdown.',
      ],
    },
    {
      title: 'How we choose which tools to include',
      body: [
        'We do not list every AI tool that exists. The directory is curated, currently 559 tools selected for one of three reasons: significant user adoption (10K+ verified users or recognized brand presence), notable category innovation (introduces a workflow or capability others do not have), or fills a real demand gap that readers ask us about.',
        'Tools are removed from the directory when they shut down, get acquired and folded into another product, or fail our automated dead-tool scan (DNS failure, certificate error, 404 on homepage, parking domain). We run this scan monthly. Last cleanup removed 11 dead tools in Session 67.',
      ],
    },
    {
      title: 'How comparisons are scored',
      body: [
        'Side-by-side comparisons (the /compare/ pages) use the same seven criteria, applied to both tools simultaneously. For each criterion, we score both tools independently and write a short note explaining the gap. This produces seven scored rows per comparison plus an overall summary and a "winner" call.',
        'A few comparisons have no winner because the answer genuinely depends on the use case. For these we provide a decision matrix - "Pick A if your priority is X, pick B if your priority is Y" - rather than forcing a single recommendation. About 15% of our comparisons end this way.',
      ],
    },
    {
      title: 'What we update and how often',
      body: [
        'Tool pages are reviewed every 90 days minimum. Pricing changes are caught faster - usually within 7 days - because we monitor pricing pages of major tools weekly. The "Last verified" date on every tool page is the source of truth.',
        'Top 10 lists are reviewed every 60 days. When a new tool from our weekly batch additions reaches Top 10 quality, it can displace a lower-ranked tool. The list is dated and the change is noted.',
        'Comparisons are updated whenever either tool in the pair has a significant feature or pricing change. We do not update for cosmetic site refreshes. Updates are dated.',
      ],
    },
    {
      title: 'Mistakes and corrections',
      body: [
        'We get things wrong. When we do, we correct fast and visibly. If you spot an error - factual, pricing, ranking, or otherwise - email info@mytheai.com with the URL and the issue. We aim to respond and correct within 48 hours for factual errors and within 7 days for ranking disputes that require re-scoring.',
        'Corrections are noted at the top of the affected page. We do not silently edit history.',
      ],
    },
  ]

  const criteria: { name: string; weight: string; what: string }[] = [
    { name: 'Output quality', weight: '25%', what: 'On real tasks at default settings, not benchmarks. The single most heavily weighted criterion because it is what the user actually feels day to day.' },
    { name: 'Ease of use', weight: '15%', what: 'Time from signup to first useful output. Onboarding clarity. UI patterns that match user expectations versus tools that require relearning.' },
    { name: 'Pricing value', weight: '15%', what: 'Price for typical user volume, not list price. Free tier generosity. Hidden costs (per-seat, per-execution, overage). Cancellation friction.' },
    { name: 'Feature depth', weight: '15%', what: 'Coverage of common workflows in the category. Power features for advanced users. Quality of API or extensibility for team integration.' },
    { name: 'Integrations', weight: '10%', what: 'Native integrations with the dominant tools in adjacent categories. Webhook and API quality. Zapier or workflow automation support.' },
    { name: 'Reliability', weight: '10%', what: 'Uptime over the past year (where measurable). Error handling. Customer support response times. Data export options.' },
    { name: 'Trajectory', weight: '10%', what: 'Release velocity. Quality of recent releases. Funding and team stability signals. Whether the tool is improving or stagnating.' },
  ]

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'WebPage',
    name: 'How We Rank AI Tools: Editorial Methodology',
    url: 'https://mytheai.com/methodology',
    description: 'The exact methodology MytheAi uses to score, rank, and compare 559 AI and SaaS tools.',
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        {/* Breadcrumb */}
        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/about" className="hover:text-blue-600 transition-colors">About</Link>
          <span>/</span>
          <span className="text-foreground font-medium">Methodology</span>
        </nav>

        {/* Header */}
        <div className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Editorial Methodology</p>
          <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
            How we rank AI tools
          </h1>
          <p className="text-[16px] text-muted-foreground leading-relaxed">
            The exact framework MytheAi uses to score 559 AI and SaaS tools. No black box, no commission-driven ranking, no sponsored placements in editorial lists. Read the criteria, audit any score, challenge any ranking.
          </p>
        </div>

        {/* First two intro sections */}
        {sections.slice(0, 2).map(s => (
          <section key={s.title} className="mb-10">
            <h2 className="text-[20px] font-bold text-foreground mb-3">{s.title}</h2>
            {s.body.map((p, i) => (
              <p key={i} className="text-[15px] text-muted-foreground leading-relaxed mb-4 last:mb-0">{p}</p>
            ))}
          </section>
        ))}

        {/* Criteria table */}
        <section className="mb-10">
          <div className="overflow-hidden rounded-xl border border-border">
            <table className="w-full text-left">
              <thead className="bg-gray-50 dark:bg-gray-900/40">
                <tr>
                  <th className="px-4 py-3 text-[13px] font-bold text-foreground">Criterion</th>
                  <th className="px-4 py-3 text-[13px] font-bold text-foreground hidden sm:table-cell">Weight</th>
                  <th className="px-4 py-3 text-[13px] font-bold text-foreground">What it measures</th>
                </tr>
              </thead>
              <tbody>
                {criteria.map((c, i) => (
                  <tr key={c.name} className={i % 2 === 0 ? 'bg-card' : 'bg-gray-50/50 dark:bg-gray-900/20'}>
                    <td className="px-4 py-3 text-[14px] font-semibold text-foreground align-top">
                      {c.name}
                      <span className="block sm:hidden text-[12px] text-blue-600 mt-0.5">{c.weight}</span>
                    </td>
                    <td className="px-4 py-3 text-[14px] text-blue-600 font-bold align-top hidden sm:table-cell">{c.weight}</td>
                    <td className="px-4 py-3 text-[13px] text-muted-foreground leading-relaxed align-top">{c.what}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          <p className="mt-3 text-[12px] text-muted-foreground italic">
            Composite score = weighted average of the seven criteria. A tool needs at least 4.0/5 to enter a Top 10 list.
          </p>
        </section>

        {/* Remaining sections */}
        {sections.slice(2).map(s => (
          <section key={s.title} className="mb-10">
            <h2 className="text-[20px] font-bold text-foreground mb-3">{s.title}</h2>
            {s.body.map((p, i) => (
              <p key={i} className="text-[15px] text-muted-foreground leading-relaxed mb-4 last:mb-0">{p}</p>
            ))}
          </section>
        ))}

        {/* Author */}
        <div className="mb-8">
          <AuthorBio context="curated" />
        </div>

        {/* Footer links */}
        <div className="border-t border-border pt-6 text-[14px] text-muted-foreground">
          See also: {' '}
          <Link href="/about" className="text-blue-600 hover:underline font-medium">About</Link>
          <span className="mx-2">·</span>
          <Link href="/about#affiliate" className="text-blue-600 hover:underline font-medium">Affiliate disclosure</Link>
          <span className="mx-2">·</span>
          <Link href="/contact" className="text-blue-600 hover:underline font-medium">Contact</Link>
        </div>

      </div>
    </>
  )
}
