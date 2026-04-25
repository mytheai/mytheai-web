import Link from 'next/link'
import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Contact MytheAi',
  description: 'Get in touch with the MytheAi team — for corrections, tool submissions, partnership enquiries, or press.',
  alternates: { canonical: 'https://mytheai.com/contact' },
}

const CONTACT_ITEMS = [
  {
    icon: '✉️',
    title: 'General Enquiries',
    body: 'Questions about the platform, corrections to tool data, or anything else.',
    cta: 'info@mytheai.com',
    href: 'mailto:info@mytheai.com',
  },
  {
    icon: '🔧',
    title: 'Submit a Tool',
    body: 'Want to add your product to the directory? Use our submission form.',
    cta: 'Submit a tool →',
    href: '/submit',
  },
  {
    icon: '🤝',
    title: 'Partnerships & Sponsorships',
    body: 'Interested in working with us? We offer sponsored content and directory placements — clearly labelled.',
    cta: 'info@mytheai.com',
    href: 'mailto:info@mytheai.com',
  },
  {
    icon: '📰',
    title: 'Press',
    body: 'Media enquiries, data requests, or quotes for articles.',
    cta: 'info@mytheai.com',
    href: 'mailto:info@mytheai.com',
  },
]

export default function ContactPage() {
  return (
    <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">Contact</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          Get in Touch
        </h1>
        <p className="text-[15px] text-muted-foreground">
          We read every message. Response time is typically 1–2 business days.
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-10">
        {CONTACT_ITEMS.map(item => (
          <div key={item.title} className="border border-border rounded-xl p-5 bg-card">
            <div className="text-[24px] mb-3">{item.icon}</div>
            <h2 className="text-[15px] font-semibold text-foreground mb-1">{item.title}</h2>
            <p className="text-[13px] text-muted-foreground leading-relaxed mb-3">{item.body}</p>
            <Link
              href={item.href}
              className="text-[13px] font-semibold text-[#2563EB] hover:text-[#1D4ED8] transition-colors"
            >
              {item.cta}
            </Link>
          </div>
        ))}
      </div>

      <div className="border border-border rounded-xl p-5 bg-card text-[13px] text-muted-foreground leading-relaxed">
        <span className="font-semibold text-foreground">Response time:</span> We aim to respond within 2 business days. For tool data corrections (wrong pricing, broken links), we prioritise same-day fixes.
      </div>
    </div>
  )
}
