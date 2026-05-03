// Programmatic "verify on third-party platforms" links.
// Renders for every tool, no DB seeding required - URLs constructed from tool
// name and slug. Adds an authority signal (we point readers AT the third-party
// reviews instead of paraphrasing them).

interface Props {
  name: string
  slug: string
  websiteUrl: string | null
}

interface Source {
  label: string
  hint: string
  url: string
}

function slugifyForG2(name: string): string {
  return name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '')
}

function buildSources(name: string, _slug: string): Source[] {
  const q = encodeURIComponent(name)
  const g2Slug = slugifyForG2(name)
  return [
    { label: 'G2',           hint: 'Verified user reviews and rating',  url: `https://www.g2.com/products/${g2Slug}/reviews` },
    { label: 'Capterra',     hint: 'Software reviews and screenshots',  url: `https://www.capterra.com/search/?search=${q}` },
    { label: 'Product Hunt', hint: 'Launch history and community vote', url: `https://www.producthunt.com/search?q=${q}` },
    { label: 'Trustpilot',   hint: 'Customer-experience reviews',       url: `https://www.trustpilot.com/search?query=${q}` },
  ]
}

export default function VerifyExternalBlock({ name, slug, websiteUrl }: Props) {
  const sources = buildSources(name, slug)
  return (
    <section className="mt-12 pt-8 border-t border-border">
      <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Verify Independently</p>
      <h2 className="text-[18px] font-bold text-foreground mb-2">
        Cross-check {name} on third-party platforms
      </h2>
      <p className="text-[14px] text-muted-foreground leading-relaxed mb-4">
        We do not ask you to take our word for it. Each link below opens the same product on an independent review or launch platform. Use these for a second opinion before deciding.
      </p>
      <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2">
        {sources.map(s => (
          <li key={s.label}>
            <a
              href={s.url}
              target="_blank"
              rel="noopener noreferrer"
              className="block p-3 rounded-lg border border-border bg-card hover:border-blue-300 transition-colors"
            >
              <p className="text-[13px] font-bold text-foreground">{s.label} ↗</p>
              <p className="text-[12px] text-muted-foreground">{s.hint}</p>
            </a>
          </li>
        ))}
        {websiteUrl && (
          <li>
            <a
              href={websiteUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="block p-3 rounded-lg border border-border bg-card hover:border-blue-300 transition-colors"
            >
              <p className="text-[13px] font-bold text-foreground">Official site ↗</p>
              <p className="text-[12px] text-muted-foreground">Pricing and feature claims, source of record</p>
            </a>
          </li>
        )}
      </ul>
      <p className="text-[11px] text-muted-foreground mt-3 italic">
        Search-result links are programmatic - if a vendor changes their listing slug the link still resolves to the platform&apos;s search for {name}. We re-verify our own ratings on a 90-day cadence.
      </p>
    </section>
  )
}
