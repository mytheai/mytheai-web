import Link from 'next/link'
import type { Metadata } from 'next'

export const revalidate = 86400

export const metadata: Metadata = {
  title: 'Press & Media Kit | MytheAi',
  description: 'Logos, brand assets, fact sheet, and press contact for journalists and media covering MytheAi - the honest AI & SaaS tools directory.',
  alternates: { canonical: 'https://mytheai.com/press' },
  openGraph: {
    title: 'MytheAi Press & Media Kit',
    description: 'Logos, brand assets, fact sheet, and press contact for journalists.',
    url: 'https://mytheai.com/press',
    type: 'website',
  },
}

const FACTS = [
  { label: 'Tools cataloged', value: '650+' },
  { label: 'Side-by-side comparisons', value: '300+' },
  { label: 'Top 10 ranked lists', value: '120+' },
  { label: 'Editorial articles', value: '67+' },
  { label: 'Founded', value: 'January 2026' },
  { label: 'HQ', value: 'Remote' },
  { label: 'Languages supported', value: '5 (EN, 中文, हिन्दी, ES, FR)' },
  { label: 'Editorial policy', value: 'No pay-to-rank' },
]

const ASSETS = [
  { label: 'Logo (PNG, 512×512)', href: '/icon-512.png', desc: 'Primary brand mark, transparent background' },
  { label: 'Logo (PNG, 192×192)', href: '/icon-192.png', desc: 'Compact size for email, social' },
  { label: 'Logo (SVG)', href: '/icon.svg', desc: 'Vector for print and high-DPI displays' },
  { label: 'Apple touch icon (180×180)', href: '/apple-icon', desc: 'iOS home screen' },
  { label: 'OG share image (1200×630)', href: '/api/og/site', desc: 'Auto-generated default site share card' },
]

export default function PressPage() {
  const orgJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'AboutPage',
    url: 'https://mytheai.com/press',
    name: 'MytheAi Press & Media Kit',
    description: 'Logos, brand assets, fact sheet, and press contact for journalists.',
    mainEntity: {
      '@type': 'Organization',
      name: 'MytheAi',
      url: 'https://mytheai.com',
      logo: 'https://mytheai.com/icon-512.png',
      foundingDate: '2026-01-01',
      description: 'Honest AI & SaaS tools directory with no pay-to-rank editorial policy.',
    },
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(orgJsonLd) }} />

      <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <span className="text-foreground font-medium">Press</span>
        </nav>

        <header className="mb-10">
          <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-2">For media & journalists</p>
          <h1 className="text-[34px] md:text-[42px] font-extrabold tracking-tight text-foreground mb-3">Press & Media Kit</h1>
          <p className="text-[16px] text-muted-foreground leading-relaxed">
            Everything you need to write or talk about MytheAi. Brand assets are free to use without prior permission, provided you do not modify the logo or imply endorsement.
          </p>
        </header>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">Boilerplate (60 words)</h2>
          <div className="rounded-xl border border-border bg-card p-5">
            <p className="text-[14px] text-muted-foreground leading-relaxed">
              MytheAi is a curated directory of 650+ AI and SaaS tools, with side-by-side comparisons, ranked top 10 lists, and editorial reviews scored on a transparent seven-criteria framework. Rankings are never influenced by affiliate commissions - the team that maintains affiliate relationships is structurally separate from editorial. Founded in January 2026.
            </p>
          </div>
        </section>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">By the numbers</h2>
          <dl className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {FACTS.map(f => (
              <div key={f.label} className="rounded-xl border border-border bg-card p-4">
                <dt className="text-[11px] font-semibold text-muted-foreground uppercase tracking-wider mb-1">{f.label}</dt>
                <dd className="text-[18px] font-bold text-foreground">{f.value}</dd>
              </div>
            ))}
          </dl>
        </section>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">Brand assets</h2>
          <ul className="space-y-3">
            {ASSETS.map(a => (
              <li key={a.href}>
                <a href={a.href} download className="block p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors">
                  <p className="text-[15px] font-semibold text-foreground mb-1">{a.label} ↓</p>
                  <p className="text-[13px] text-muted-foreground">{a.desc}</p>
                </a>
              </li>
            ))}
          </ul>
          <p className="mt-4 text-[12px] text-muted-foreground">Brand colors: blue gradient #60A5FA → #1D4ED8. Background: #FAFAFA (light), #0F1117 (dark). Body font: Inter.</p>
        </section>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">Notable resources for citation</h2>
          <ul className="space-y-3 text-[15px]">
            <li>
              <Link href="/blog/state-of-ai-tools-2026" className="text-blue-600 hover:underline font-medium">State of AI Tools 2026</Link>
              <span className="text-muted-foreground"> - original research with 8 findings on AI tool pricing, free-tier patterns, and category growth.</span>
            </li>
            <li>
              <Link href="/glossary" className="text-blue-600 hover:underline font-medium">AI Glossary</Link>
              <span className="text-muted-foreground"> - 30 plain-English definitions, citable as a glossary reference.</span>
            </li>
            <li>
              <Link href="/methodology" className="text-blue-600 hover:underline font-medium">Editorial Methodology</Link>
              <span className="text-muted-foreground"> - seven-criteria scoring framework and conflict-of-interest policy.</span>
            </li>
            <li>
              <Link href="/transparency" className="text-blue-600 hover:underline font-medium">Transparency disclosures</Link>
              <span className="text-muted-foreground"> - affiliate disclosures and editorial separation.</span>
            </li>
          </ul>
        </section>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">Press contact</h2>
          <div className="rounded-xl border border-border bg-card p-5">
            <p className="text-[15px] text-foreground mb-2"><strong>John Ethan</strong>, Founder & Editor-in-Chief</p>
            <p className="text-[14px] text-muted-foreground mb-1">
              Press inquiries: <a href="mailto:press@mytheai.com" className="text-blue-600 hover:underline">press@mytheai.com</a>
            </p>
            <p className="text-[14px] text-muted-foreground mb-1">
              General: <a href="mailto:hello@mytheai.com" className="text-blue-600 hover:underline">hello@mytheai.com</a>
            </p>
            <p className="text-[13px] text-muted-foreground mt-3">Typical response time: 1-2 business days. For urgent fact-check requests, mark email subject [URGENT FACT-CHECK].</p>
          </div>
        </section>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">How to cite MytheAi</h2>
          <div className="rounded-xl border border-border bg-card p-5">
            <p className="text-[12px] font-semibold text-muted-foreground uppercase tracking-wider mb-2">Plain text</p>
            <pre className="text-[13px] text-foreground whitespace-pre-wrap font-mono mb-4">MytheAi (2026). [Title of resource]. https://mytheai.com/[path]. Accessed [date].</pre>
            <p className="text-[12px] font-semibold text-muted-foreground uppercase tracking-wider mb-2">BibTeX</p>
            <pre className="text-[13px] text-foreground whitespace-pre-wrap font-mono">{`@misc{mytheai2026,
  title  = {MytheAi - Honest AI & SaaS Tool Directory},
  author = {{MytheAi Editorial}},
  year   = {2026},
  url    = {https://mytheai.com},
  note   = {Accessed: [date]}
}`}</pre>
          </div>
        </section>

        <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          See also: <Link href="/about" className="text-blue-600 hover:underline">About</Link>
          <span className="mx-2">·</span>
          <Link href="/methodology" className="text-blue-600 hover:underline">Methodology</Link>
          <span className="mx-2">·</span>
          <Link href="/transparency" className="text-blue-600 hover:underline">Transparency</Link>
        </div>

      </div>
    </>
  )
}
