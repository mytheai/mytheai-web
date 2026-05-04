import type { Metadata } from 'next'
import Link from 'next/link'
import AuthorBio from '@/components/layout/AuthorBio'
import { getSiteStats } from '@/lib/stats'

export const revalidate = 86400

export const metadata: Metadata = {
  title: 'About MytheAi: A Decision-First AI Tool Directory',
  description: 'MytheAi is the clearest way to choose AI tools. Editorial scores you can audit, comparisons that pick a winner, verified pricing. No pay-to-rank. Read our editorial standards.',
  alternates: { canonical: 'https://mytheai.com/about' },
  openGraph: {
    title: 'About MytheAi: A Decision-First AI Tool Directory',
    url: 'https://mytheai.com/about',
  },
}

export default async function AboutPage() {
  const stats = await getSiteStats()
  return (
    <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

      {/* Header */}
      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">About</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
          The clearest way to choose AI tools.
        </h1>
        <p className="text-[16px] text-muted-foreground leading-relaxed">
          MytheAi is a decision-first directory of AI and SaaS tools. We are not trying to list every product on the internet - we are trying to be the place you visit when you have to make a choice. Editorial scores you can audit, comparisons that pick a winner, pricing verified on a 90-day cycle. No pay-to-rank.
        </p>
      </div>

      {/* Founder */}
      <section className="mb-10">
        <h2 className="text-[20px] font-bold text-foreground mb-3">Who runs MytheAi</h2>
        <AuthorBio context="curated" className="mb-4" />
        <p className="text-[15px] text-muted-foreground leading-relaxed">
          MytheAi started in January 2026 because every existing AI directory I tried felt like a paid leaderboard with reviews bolted on. Tools ranked because they paid the most, not because they were the best. I am building MytheAi as the directory I wish existed: honest, curated, no pay-to-rank, and transparent about how every score is calculated. <Link href="/methodology" className="text-blue-600 hover:underline font-medium">See the full methodology</Link>.
        </p>
      </section>

      {/* Mission */}
      <section className="mb-10">
        <h2 className="text-[20px] font-bold text-foreground mb-3">Our Mission</h2>
        <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
          Most AI tool directories optimise for breadth: thousands of listings, sorted by paid placement, with no opinion on which one fits your job. That is overwhelming, not useful. MytheAi optimises for the moment a real person has to pick: by role, by budget, by team size, by integration need. {stats.tools} curated tools and {stats.comparisons} head-to-head comparisons, each reviewed, scored on a public seven-criteria framework, and re-verified on a 90-day cycle.
        </p>
        <p className="text-[15px] text-muted-foreground leading-relaxed">
          Tool discovery should feel like advice from a knowledgeable friend, not scrolling a sponsored listicle. Every score on MytheAi is broken down into four trust signals you can audit independently: Editorial Score, External Aggregate, User Reviews on MytheAi, and Pricing Verified date. The full framework is on the <Link href="/methodology" className="text-blue-600 hover:underline font-medium">methodology page</Link>.
        </p>
      </section>

      {/* Editorial Standards */}
      <section className="mb-10">
        <h2 className="text-[20px] font-bold text-foreground mb-3">Editorial Standards</h2>
        <ul className="space-y-3">
          {[
            {
              title: 'Independent rankings',
              body: 'Tools are ranked by editorial score: a combination of feature breadth, pricing value, user ratings, and market momentum. Affiliate relationships never affect rank position.',
            },
            {
              title: 'Verified pricing',
              body: 'All pricing shown is verified at the time of review and dated. We update within 7 days of any confirmed pricing change.',
            },
            {
              title: 'No pay-to-play',
              body: 'Paid placement is not available in Editor\'s Picks, Top 10 lists, or Trending sections. Sponsored tools are clearly labelled and always appear below organic results.',
            },
            {
              title: 'Genuine comparisons',
              body: 'Head-to-head comparisons are scored on neutral criteria. We do not favour tools that pay higher commissions.',
            },
          ].map(item => (
            <li key={item.title} className="border border-border rounded-xl p-4 bg-card">
              <p className="text-[14px] font-semibold text-foreground mb-1">{item.title}</p>
              <p className="text-[13px] text-muted-foreground leading-relaxed">{item.body}</p>
            </li>
          ))}
        </ul>
      </section>

      {/* How we make money */}
      <section className="mb-10">
        <h2 className="text-[20px] font-bold text-foreground mb-3">How MytheAi Makes Money</h2>
        <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
          MytheAi is free to use. We sustain the platform through affiliate commissions. When you click a &quot;Visit&quot; link on a tool page and sign up, we may earn a small commission at no extra cost to you.
        </p>
        <p className="text-[15px] text-muted-foreground leading-relaxed">
          Not every tool on the platform has an affiliate arrangement, and commission rates are never factored into our editorial rankings. A tool ranked #1 may pay no commission at all; a tool ranked #30 may pay a high rate. Rankings are determined by merit, not monetisation.
        </p>
      </section>

      {/* Affiliate Disclosure - anchor target */}
      <section id="affiliate" className="mb-10 scroll-mt-24">
        <div className="bg-amber-50 dark:bg-amber-950/30 border border-amber-200 dark:border-amber-800 rounded-xl p-6">
          <h2 className="text-[18px] font-bold text-foreground mb-3">Affiliate Disclosure</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed mb-3">
            Some links on MytheAi are affiliate links. When you click through and make a purchase or sign up for a paid plan, we may receive a commission at no additional cost to you.
          </p>
          <p className="text-[14px] text-muted-foreground leading-relaxed mb-3">
            This commission helps us keep the platform free and cover the ongoing cost of research, writing, and tool verification. We appreciate your support.
          </p>
          <p className="text-[14px] font-medium text-foreground leading-relaxed">
            Our rankings are <span className="underline">never</span> influenced by affiliate relationships. We do not accept payment to improve a tool&apos;s position in any editorial list.
          </p>
        </div>
      </section>

      {/* Contact */}
      <section>
        <h2 className="text-[20px] font-bold text-foreground mb-3">Get in Touch</h2>
        <p className="text-[15px] text-muted-foreground leading-relaxed">
          Questions, corrections, or tool suggestions? Reach us at{' '}
          <a
            href="mailto:info@mytheai.com"
            className="text-[#2563EB] hover:underline font-medium"
          >
            info@mytheai.com
          </a>{' '}
          or use the{' '}
          <a href="/submit" className="text-[#2563EB] hover:underline font-medium">
            Submit a Tool
          </a>{' '}
          form.
        </p>
      </section>

    </div>
  )
}
