import type { Metadata } from 'next'
import Link from 'next/link'
import { createStaticClient } from '@/lib/supabase'

export const revalidate = 86400

export const metadata: Metadata = {
  title: 'Transparency Report 2026: Revenue, Editorial, Data | MytheAi',
  description: 'How MytheAi makes money, how affiliate links work, who writes our reviews, and what data we keep. Full transparency on revenue, editorial separation, and ranking integrity.',
  alternates: { canonical: 'https://mytheai.com/transparency' },
  openGraph: {
    title: 'Transparency Report 2026 | MytheAi',
    url: 'https://mytheai.com/transparency',
  },
}

async function getStats() {
  const supabase = createStaticClient()
  const [tools, comparisons, evidenced] = await Promise.all([
    supabase.from('tools').select('*', { count: 'exact', head: true }),
    supabase.from('comparisons').select('*', { count: 'exact', head: true }),
    supabase.from('tools').select('*', { count: 'exact', head: true }).not('scores_evidence', 'is', null),
  ])
  return {
    tools: tools.count ?? 0,
    comparisons: comparisons.count ?? 0,
    evidenced: evidenced.count ?? 0,
  }
}

export default async function TransparencyPage() {
  const stats = await getStats()
  const lastUpdated = new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })

  return (
    <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">
      <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">Transparency</p>
      <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
        How MytheAi works behind the scenes
      </h1>
      <p className="text-[15px] text-muted-foreground mb-8">
        We track {stats.tools} AI tools and publish {stats.comparisons} head-to-head comparisons. This page documents how we make money, who writes our reviews, and the structural protections that keep rankings honest. Last updated {lastUpdated}.
      </p>

      <div className="grid grid-cols-3 gap-3 mb-10">
        <div className="border border-border rounded-xl p-4 bg-card text-center">
          <p className="text-[24px] font-extrabold text-foreground">{stats.tools.toLocaleString()}</p>
          <p className="text-[12px] text-muted-foreground">Tools tracked</p>
        </div>
        <div className="border border-border rounded-xl p-4 bg-card text-center">
          <p className="text-[24px] font-extrabold text-foreground">{stats.comparisons.toLocaleString()}</p>
          <p className="text-[12px] text-muted-foreground">Head-to-head comparisons</p>
        </div>
        <div className="border border-border rounded-xl p-4 bg-card text-center">
          <p className="text-[24px] font-extrabold text-foreground">{stats.evidenced.toLocaleString()}</p>
          <p className="text-[12px] text-muted-foreground">Tools with cited evidence</p>
        </div>
      </div>

      <section className="space-y-10">

        <div>
          <h2 className="text-[20px] font-extrabold text-foreground mb-2">How we make money</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed mb-2">
            MytheAi is funded entirely by affiliate commissions. When you click a Visit button on a tool page and later sign up for a paid plan with that vendor, we may earn a commission. The price you pay is the same with or without our link.
          </p>
          <p className="text-[14px] text-muted-foreground leading-relaxed mb-2">
            We have <strong className="text-foreground">no sponsored Top 10 placements</strong>, no paid Editor&apos;s Picks, and no &quot;featured tool of the month&quot; ad slot. There is no way to buy a higher rank.
          </p>
          <p className="text-[14px] text-muted-foreground leading-relaxed">
            Some tools we recommend pay us nothing. Anthropic Claude, OpenAI ChatGPT, and Google NotebookLM are three of our most-recommended tools across categories and we earn $0 from each of them. We recommend them anyway because the seven-criteria score puts them on top.
          </p>
        </div>

        <div>
          <h2 className="text-[20px] font-extrabold text-foreground mb-2">Editorial and affiliate separation</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed mb-2">
            Affiliate commission rates are not visible to anyone making editorial decisions. The person maintaining affiliate accounts is separate from the person writing reviews and assigning scores. The reviewer cannot see commission data even if they wanted to.
          </p>
          <p className="text-[14px] text-muted-foreground leading-relaxed">
            This is the simplest structural protection: if scoring does not see commission data, scoring cannot be biased by it. A tool that pays a 30% recurring commission can and does rank below a tool that pays 0% if the lower-commission tool scores higher.
          </p>
        </div>

        <div>
          <h2 className="text-[20px] font-extrabold text-foreground mb-2">How rankings are scored</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed mb-2">
            Every tool is scored on the same seven criteria with public weights: Output Quality (25%), Ease of Use (15%), Pricing Value (15%), Feature Depth (15%), Integrations (10%), Reliability (10%), Trajectory (10%). Read the{' '}
            <Link href="/methodology" className="text-blue-600 hover:underline">full methodology</Link>.
          </p>
          <p className="text-[14px] text-muted-foreground leading-relaxed">
            Some scores are backed by evidence URLs (benchmark leaderboards, official docs, third-party reviews, hands-on test logs). {stats.evidenced} of {stats.tools} tools have evidence cited so far. We are backfilling this in editorial cadence and will reach 100% over time.
          </p>
        </div>

        <div>
          <h2 className="text-[20px] font-extrabold text-foreground mb-2">Who writes the reviews</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed">
            Reviews are written by a small editorial team with hands-on testing time on each tool. We do not auto-generate review text from product pages, and we do not paste vendor marketing copy. When we have not used a tool directly (typical for enterprise tools that require a sales call), we say so on the tool page with a &quot;limited hands-on&quot; note.
          </p>
        </div>

        <div>
          <h2 className="text-[20px] font-extrabold text-foreground mb-2">User data and privacy</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed mb-2">
            We use Plausible Analytics, which is privacy-first and does not set cookies or fingerprint visitors. We do not run Google Analytics, Facebook Pixel, or third-party retargeting trackers.
          </p>
          <p className="text-[14px] text-muted-foreground leading-relaxed">
            Newsletter signups store your email and a timestamp. That is it. We do not sell or share email lists. The user-review form on tool pages stores rating, text, and a hashed IP address (for rate-limiting only). Read the{' '}
            <Link href="/privacy" className="text-blue-600 hover:underline">privacy policy</Link>{' '}for the full picture.
          </p>
        </div>

        <div>
          <h2 className="text-[20px] font-extrabold text-foreground mb-2">How tools enter and leave the directory</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed mb-2">
            We add tools that meet at least one of three bars: significant user adoption (recognized brand presence or 10K+ verified users), notable category innovation, or fills a real demand gap our readers ask about. We do not list every AI tool that exists.
          </p>
          <p className="text-[14px] text-muted-foreground leading-relaxed">
            Tools are removed when they shut down, get acquired and folded into another product, or fail our automated monthly dead-tool scan (DNS failure, certificate error, 404 on homepage, parking domain).
          </p>
        </div>

        <div>
          <h2 className="text-[20px] font-extrabold text-foreground mb-2">Mistakes and corrections</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed">
            We get things wrong sometimes. When we do, we correct visibly and quickly. If you spot a factual error, suspicious ranking, or stale pricing, email{' '}
            <a href="mailto:info@mytheai.com" className="text-blue-600 hover:underline">info@mytheai.com</a>{' '}
            with the URL. We respond within 48 hours for factual errors and within 7 days for ranking disputes that require re-scoring. Corrections are noted at the top of the affected page. We do not silently edit history.
          </p>
        </div>

        <div>
          <h2 className="text-[20px] font-extrabold text-foreground mb-2">Contact</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed">
            Press, partnerships, corrections, or general questions:{' '}
            <a href="mailto:info@mytheai.com" className="text-blue-600 hover:underline">info@mytheai.com</a>.
            For tool submissions use the{' '}
            <Link href="/submit" className="text-blue-600 hover:underline">submit form</Link>.
          </p>
        </div>

      </section>

      <div className="mt-12 border-t border-border pt-6 text-[12px] text-muted-foreground">
        <p>
          Related:{' '}
          <Link href="/methodology" className="text-blue-600 hover:underline">Editorial methodology</Link>{' · '}
          <Link href="/about" className="text-blue-600 hover:underline">About MytheAi</Link>{' · '}
          <Link href="/privacy" className="text-blue-600 hover:underline">Privacy policy</Link>
        </p>
      </div>
    </div>
  )
}
