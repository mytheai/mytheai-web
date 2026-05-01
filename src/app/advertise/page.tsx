import Link from 'next/link'
import type { Metadata } from 'next'

export const revalidate = 604800

export const metadata: Metadata = {
  title: 'Advertise on MytheAi: Reach 50,000+ AI Tool Buyers | MytheAi',
  description: 'Reach professionals actively researching AI and SaaS tools. Featured placements, sponsored articles, and newsletter sponsorships available.',
  alternates: { canonical: 'https://mytheai.com/advertise' },
  openGraph: {
    title: 'Advertise on MytheAi: Reach AI Tool Buyers',
    url: 'https://mytheai.com/advertise',
  },
}

const TIERS = [
  {
    name: 'Free Listing',
    price: '$0',
    period: 'forever',
    description: 'Get listed in our directory and be discoverable by professionals searching for tools in your category.',
    features: [
      'Standard directory listing',
      'Tool profile page with description',
      'Category and tag filtering',
      'Sitemap inclusion for SEO',
    ],
    cta: 'Submit Your Tool',
    href: '/submit',
    highlight: false,
  },
  {
    name: 'Verified Badge',
    price: '$29',
    period: 'per month',
    description: 'Stand out with a Verified badge, dofollow backlink, and priority placement in category search results.',
    features: [
      'Everything in Free Listing',
      'Verified badge on your tool card',
      'Dofollow link to your website',
      'Priority placement in category results',
      'Priority support for profile updates',
      'Correct pricing kept up to date',
    ],
    cta: 'Get Verified',
    href: 'mailto:hello@mytheai.com?subject=Verified Badge Inquiry',
    highlight: false,
  },
  {
    name: 'Featured Boost',
    price: '$99',
    period: 'per week',
    description: 'Appear at the top of your category page and in the Featured section on the homepage for maximum visibility.',
    features: [
      'Everything in Verified Badge',
      'Featured placement in your category',
      'Homepage Featured section inclusion',
      'Bold card border to stand out',
      'Weekly performance report',
    ],
    cta: 'Book Featured Slot',
    href: 'mailto:hello@mytheai.com?subject=Featured Boost Inquiry',
    highlight: true,
  },
  {
    name: 'Sponsored Article',
    price: '$199',
    period: 'per article',
    description: 'A dedicated editorial-style article on MytheAi about your tool, use cases, and differentiators - clearly labeled as sponsored.',
    features: [
      'Everything in Featured Boost',
      '600-900 word editorial article',
      'Published in /blog with your category tags',
      'Included in sitemap and SEO indexing',
      'Promoted in newsletter (1 mention)',
      'Permanent URL - no expiry',
    ],
    cta: 'Inquire About Article',
    href: 'mailto:hello@mytheai.com?subject=Sponsored Article Inquiry',
    highlight: false,
  },
  {
    name: 'Newsletter Sponsorship',
    price: '$299',
    period: 'per send',
    description: 'Your tool featured in our curated newsletter sent to subscribers actively evaluating AI tools for their workflow.',
    features: [
      'Dedicated sponsor section in newsletter',
      '80-120 word description written by our team',
      'Direct link to your tool or landing page',
      'Sent to full subscriber list',
      'Click-through tracking and report',
    ],
    cta: 'Book Newsletter Slot',
    href: 'mailto:hello@mytheai.com?subject=Newsletter Sponsorship Inquiry',
    highlight: false,
  },
]

const FAQS = [
  {
    q: 'Do sponsored placements affect editorial rankings?',
    a: 'Never. Paid placements are clearly labeled. Our Top 10 lists, Editor\'s Picks, and comparison rankings are based entirely on editorial merit. Sponsored content appears in designated sponsored slots only - never in organic rankings.',
  },
  {
    q: 'Can I cancel a monthly Verified Badge subscription?',
    a: 'Yes. Monthly subscriptions can be cancelled at any time with no penalty. Your badge and priority placement remain active through the end of the paid period.',
  },
  {
    q: 'What is the audience profile?',
    a: 'Our readers are founders, marketers, developers, and operations professionals actively evaluating AI and SaaS tools. The majority are at the decision-making or strong-influence stage of a purchasing decision.',
  },
  {
    q: 'Can I target a specific category?',
    a: 'Featured Boost placements are scoped to your tool\'s primary category. Newsletter sponsorships are sent to the full list. Category-targeted newsletter sends are available for established categories at custom pricing.',
  },
  {
    q: 'How quickly can a sponsored article go live?',
    a: 'We aim for 5-7 business days from brief submission to publication, subject to editorial review. Rush publication is available at an additional fee.',
  },
]

export default function AdvertisePage() {
  return (
    <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

      {/* Header */}
      <div className="mb-12">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Advertise</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
          Reach 50,000+ AI tool buyers
        </h1>
        <p className="text-[16px] text-muted-foreground leading-relaxed max-w-2xl">
          MytheAi is where professionals research, compare, and decide on AI and SaaS tools. Sponsorship puts your tool in front of an audience that is actively evaluating options in your category.
        </p>
      </div>

      {/* Trust bar */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-12">
        {[
          { stat: '50K+', label: 'Monthly visitors' },
          { stat: '400+', label: 'Tools reviewed' },
          { stat: '200+', label: 'Head-to-head comparisons' },
          { stat: '68+', label: 'Top 10 ranking lists' },
        ].map(item => (
          <div key={item.stat} className="border border-border rounded-xl p-4 bg-card text-center">
            <p className="text-[22px] font-extrabold text-foreground">{item.stat}</p>
            <p className="text-[12px] text-muted-foreground">{item.label}</p>
          </div>
        ))}
      </div>

      {/* Tiers */}
      <div className="mb-12">
        <h2 className="text-[20px] font-bold text-foreground mb-6">Sponsorship Options</h2>
        <div className="space-y-4">
          {TIERS.map(tier => (
            <div
              key={tier.name}
              className={`border rounded-xl p-6 ${tier.highlight ? 'border-blue-400 bg-[#EFF6FF]' : 'border-border bg-card'}`}
            >
              <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4">
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 mb-1">
                    <p className="text-[16px] font-bold text-foreground">{tier.name}</p>
                    {tier.highlight && (
                      <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-blue-600 text-white">POPULAR</span>
                    )}
                  </div>
                  <p className="text-[13px] text-muted-foreground mb-4">{tier.description}</p>
                  <ul className="space-y-1.5">
                    {tier.features.map(f => (
                      <li key={f} className="flex items-start gap-2 text-[13px] text-muted-foreground">
                        <span className="text-green-500 flex-shrink-0 mt-0.5">✓</span>
                        {f}
                      </li>
                    ))}
                  </ul>
                </div>
                <div className="flex-shrink-0 flex flex-col items-start sm:items-end gap-3">
                  <div className="text-right">
                    <p className="text-[24px] font-extrabold text-foreground">{tier.price}</p>
                    <p className="text-[12px] text-muted-foreground">{tier.period}</p>
                  </div>
                  <Link
                    href={tier.href}
                    className={`px-4 py-2 rounded-lg text-[13px] font-semibold transition-colors ${
                      tier.highlight
                        ? 'bg-blue-600 text-white hover:bg-blue-700'
                        : 'border border-border text-foreground hover:border-blue-300 hover:text-blue-600'
                    }`}
                  >
                    {tier.cta} →
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Editorial integrity note */}
      <div className="mb-12 p-5 rounded-xl border border-[#BFDBFE] bg-[#EFF6FF]">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#1E40AF] mb-1">Editorial Integrity</p>
        <p className="text-[14px] text-[#1E40AF] leading-relaxed">
          Paid placements never influence our editorial rankings. Top 10 lists, Editor&apos;s Picks, and comparison winners are based entirely on merit. Sponsored content is always clearly labeled. Our readers trust us because we do not sell rankings - and we intend to keep it that way.
        </p>
      </div>

      {/* FAQ */}
      <div className="mb-12">
        <h2 className="text-[20px] font-bold text-foreground mb-5">Frequently Asked Questions</h2>
        <div className="space-y-3">
          {FAQS.map((faq, i) => (
            <details key={i} className="border border-border rounded-xl bg-card group">
              <summary className="flex items-center justify-between p-4 cursor-pointer text-[14px] font-semibold text-foreground list-none hover:text-blue-600 transition-colors">
                {faq.q}
                <span className="text-muted-foreground text-[10px] ml-3 flex-shrink-0 group-open:rotate-180 transition-transform">▼</span>
              </summary>
              <p className="px-4 pb-4 text-[14px] text-muted-foreground leading-relaxed">{faq.a}</p>
            </details>
          ))}
        </div>
      </div>

      {/* Contact CTA */}
      <div className="border border-border rounded-xl p-6 bg-card text-center">
        <p className="text-[16px] font-bold text-foreground mb-2">Custom partnership?</p>
        <p className="text-[14px] text-muted-foreground mb-4">
          We are open to integration partnerships, co-marketing, and custom editorial programs. Reach out to discuss.
        </p>
        <Link
          href="mailto:hello@mytheai.com?subject=Partnership Inquiry"
          className="inline-block px-5 py-2.5 rounded-lg bg-blue-600 text-white text-[13px] font-semibold hover:bg-blue-700 transition-colors"
        >
          Contact Us →
        </Link>
      </div>
    </div>
  )
}
