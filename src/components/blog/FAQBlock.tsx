interface FAQ {
  q: string
  a: string
}

interface Props {
  items: FAQ[]
  heading?: string
}

export default function FAQBlock({ items, heading = 'Frequently asked' }: Props) {
  if (!items || items.length === 0) return null

  // Emit FAQPage JSON-LD inline so blog FAQs become eligible for featured snippets.
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: items.map(f => ({
      '@type': 'Question',
      name: f.q,
      acceptedAnswer: { '@type': 'Answer', text: f.a },
    })),
  }

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <section className="my-10">
        <h2 className="text-[20px] font-bold text-foreground mb-4">{heading}</h2>
        <div className="space-y-3">
          {items.map((f, i) => (
            <details key={i} className="group rounded-xl border border-border bg-card overflow-hidden">
              <summary className="flex items-center justify-between gap-4 px-5 py-4 cursor-pointer list-none hover:bg-gray-50 dark:hover:bg-gray-900/40 transition-colors">
                <span className="text-[15px] font-semibold text-foreground">{f.q}</span>
                <svg className="w-4 h-4 text-muted-foreground transition-transform group-open:rotate-180 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24" aria-hidden="true">
                  <polyline points="6 9 12 15 18 9" />
                </svg>
              </summary>
              <div className="px-5 pb-4 text-[14px] text-muted-foreground leading-relaxed">{f.a}</div>
            </details>
          ))}
        </div>
      </section>
    </>
  )
}
