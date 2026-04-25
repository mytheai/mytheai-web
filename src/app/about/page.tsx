import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'About MytheAi — Our Mission & Editorial Standards',
  description: 'MytheAi is an independent AI & SaaS tool directory built for professionals. Learn about our editorial approach, ranking methodology, and affiliate disclosure.',
  alternates: { canonical: 'https://mytheai.com/about' },
  openGraph: {
    title: 'About MytheAi — Our Mission & Editorial Standards',
    url: 'https://mytheai.com/about',
  },
}

export default function AboutPage() {
  return (
    <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

      {/* Header */}
      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">About</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
          We help you find the right tool, faster.
        </h1>
        <p className="text-[16px] text-muted-foreground leading-relaxed">
          MytheAi is an independent directory and review platform for AI and SaaS tools — built for founders, marketers, developers, and creators who need honest, curated guidance before subscribing to something new.
        </p>
      </div>

      {/* Mission */}
      <section className="mb-10">
        <h2 className="text-[20px] font-bold text-foreground mb-3">Our Mission</h2>
        <p className="text-[15px] text-muted-foreground leading-relaxed mb-4">
          The AI tools landscape changes every week. New products launch, pricing shifts, and yesterday&apos;s best option becomes obsolete. We cut through the noise by maintaining a living directory of 500+ tools — each reviewed, verified, and updated regularly.
        </p>
        <p className="text-[15px] text-muted-foreground leading-relaxed">
          We believe tool discovery should feel like getting advice from a knowledgeable friend, not scrolling through a sponsorship-laden listicle. Every ranking on MytheAi is based on editorial merit: feature depth, pricing value, user feedback, and real-world use cases.
        </p>
      </section>

      {/* Editorial Standards */}
      <section className="mb-10">
        <h2 className="text-[20px] font-bold text-foreground mb-3">Editorial Standards</h2>
        <ul className="space-y-3">
          {[
            {
              title: 'Independent rankings',
              body: 'Tools are ranked by editorial score — a combination of feature breadth, pricing value, user ratings, and market momentum. Affiliate relationships never affect rank position.',
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
          MytheAi is free to use. We sustain the platform through affiliate commissions — when you click a &quot;Visit&quot; link on a tool page and sign up, we may earn a small commission at no extra cost to you.
        </p>
        <p className="text-[15px] text-muted-foreground leading-relaxed">
          Not every tool on the platform has an affiliate arrangement, and commission rates are never factored into our editorial rankings. A tool ranked #1 may pay no commission at all; a tool ranked #30 may pay a high rate. Rankings are determined by merit, not monetisation.
        </p>
      </section>

      {/* Affiliate Disclosure — anchor target */}
      <section id="affiliate" className="mb-10 scroll-mt-24">
        <div className="bg-amber-50 dark:bg-amber-950/30 border border-amber-200 dark:border-amber-800 rounded-xl p-6">
          <h2 className="text-[18px] font-bold text-foreground mb-3">Affiliate Disclosure</h2>
          <p className="text-[14px] text-muted-foreground leading-relaxed mb-3">
            Some links on MytheAi are affiliate links. When you click through and make a purchase or sign up for a paid plan, we may receive a commission — at no additional cost to you.
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
