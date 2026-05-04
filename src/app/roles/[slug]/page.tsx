import { notFound } from 'next/navigation'
import Link from 'next/link'
import LogoImage from '@/components/ui/LogoImage'
import { createStaticClient } from '@/lib/supabase'
import { ROLES, getRole, type Role } from '@/data/roles'
import { TOP10_LISTS } from '@/data/top10'
import { getAuthorJsonLd } from '@/data/authors'
import type { Metadata } from 'next'

export const revalidate = 604800

interface ToolRow {
  slug: string
  name: string
  tagline: string
  logo_url: string | null
  website_url: string | null
  pricing_type: string
  pricing_free_tier: boolean
  pricing_starting_price: number | null
  rating: number
}

const PRICING_LABELS: Record<string, string> = {
  free: 'Free',
  freemium: 'Freemium',
  paid: 'Paid',
  ltd: 'Lifetime Deal',
}

const PRICING_COLORS: Record<string, string> = {
  free: 'bg-[#D1FAE5] text-[#065F46]',
  freemium: 'bg-[#DBEAFE] text-[#1E40AF]',
  paid: 'bg-[#F3F4F6] text-[#374151]',
  ltd: 'bg-[#FEF3C7] text-[#92400E]',
}

async function getTools(slugs: string[]): Promise<ToolRow[]> {
  const supabase = createStaticClient()
  const { data } = await supabase.from('tools')
    .select('slug,name,tagline,logo_url,website_url,pricing_type,pricing_free_tier,pricing_starting_price,rating')
    .in('slug', slugs)
  if (!data) return []
  return slugs
    .map(s => data.find((t: ToolRow) => t.slug === s))
    .filter(Boolean) as ToolRow[]
}

export function generateStaticParams() {
  return ROLES.map(r => ({ slug: r.slug }))
}

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params
  const role = getRole(slug)
  if (!role) return { title: 'Not found | MytheAi' }
  const year = new Date().getFullYear()
  const title = `Best AI Tools for ${role.title}s ${year}: Curated Stack | MytheAi`
  return {
    title,
    description: role.intro.slice(0, 160),
    alternates: { canonical: `https://mytheai.com/roles/${slug}` },
    openGraph: {
      title,
      description: role.intro,
      url: `https://mytheai.com/roles/${slug}`,
      type: 'article',
    },
    twitter: {
      card: 'summary_large_image',
      title,
      description: role.intro,
    },
  }
}

function buildJsonLd(role: Role, tools: ToolRow[]) {
  const itemList = {
    '@context': 'https://schema.org',
    '@type': 'ItemList',
    name: `Best AI Tools for ${role.title}s`,
    description: role.intro,
    url: `https://mytheai.com/roles/${role.slug}`,
    itemListElement: tools.map((t, i) => ({
      '@type': 'ListItem',
      position: i + 1,
      url: `https://mytheai.com/tools/${t.slug}`,
      item: {
        '@type': 'SoftwareApplication',
        name: t.name,
        description: t.tagline,
        applicationCategory: 'WebApplication',
        operatingSystem: 'Web',
        offers: { '@type': 'Offer', price: t.pricing_starting_price ?? 0, priceCurrency: 'USD' },
      },
    })),
  }
  const breadcrumb = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://mytheai.com' },
      { '@type': 'ListItem', position: 2, name: 'By Role', item: 'https://mytheai.com/roles' },
      { '@type': 'ListItem', position: 3, name: role.title, item: `https://mytheai.com/roles/${role.slug}` },
    ],
  }
  const faq = role.faqs.length > 0 ? {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: role.faqs.map(f => ({
      '@type': 'Question',
      name: f.q,
      acceptedAnswer: { '@type': 'Answer', text: f.a },
    })),
  } : null
  const collection = {
    '@context': 'https://schema.org',
    '@type': 'CollectionPage',
    name: `Best AI Tools for ${role.title}s ${new Date().getFullYear()}`,
    description: role.longIntro,
    url: `https://mytheai.com/roles/${role.slug}`,
    author: getAuthorJsonLd(),
    publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
  }
  return { itemList, breadcrumb, faq, collection }
}

export default async function RolePage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const role = getRole(slug)
  if (!role) notFound()

  const tools = await getTools(role.primaryToolSlugs)
  const matchedList = TOP10_LISTS.find(l => l.slug === role.topListSlug)
  const jsonLd = buildJsonLd(role, tools)

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd.itemList) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd.breadcrumb) }} />
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd.collection) }} />
      {jsonLd.faq && <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd.faq) }} />}

      <div className="max-w-4xl mx-auto px-4 md:px-5 py-10 md:py-14">

        <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
          <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
          <span>/</span>
          <Link href="/roles" className="hover:text-blue-600 transition-colors">By Role</Link>
          <span>/</span>
          <span className="text-foreground font-medium">{role.title}</span>
        </nav>

        <header className="flex items-start gap-4 mb-8">
          <span className="text-5xl flex-shrink-0" aria-hidden="true">{role.emoji}</span>
          <div className="min-w-0 flex-1">
            <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">By Role</p>
            <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
              Best AI Tools for {role.title}s
            </h1>
            <p className="text-[15px] text-muted-foreground leading-relaxed">{role.longIntro}</p>
          </div>
        </header>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">Your stack</h2>
          {tools.length === 0 ? (
            <p className="text-[14px] text-muted-foreground">Loading picks...</p>
          ) : (
            <ol className="space-y-3">
              {tools.map((t, i) => (
                <li key={t.slug}>
                  <Link href={`/tools/${t.slug}`} className="flex items-start gap-4 p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors">
                    <span className="text-[18px] font-bold text-muted-foreground flex-shrink-0 w-7 text-center">{i + 1}</span>
                    <LogoImage src={t.logo_url} websiteUrl={t.website_url} name={t.name} size={40} />
                    <div className="min-w-0 flex-1">
                      <div className="flex flex-wrap items-center gap-2 mb-1">
                        <p className="text-[15px] font-bold text-foreground">{t.name}</p>
                        <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${PRICING_COLORS[t.pricing_type] ?? PRICING_COLORS.paid}`}>
                          {PRICING_LABELS[t.pricing_type] ?? 'Paid'}
                        </span>
                        {t.rating > 0 && (
                          <span className="text-[12px] text-muted-foreground">★ {t.rating.toFixed(1)}</span>
                        )}
                      </div>
                      <p className="text-[13px] text-muted-foreground line-clamp-2">{t.tagline}</p>
                    </div>
                    <span className="text-[12px] text-blue-600 font-medium hidden md:inline flex-shrink-0">Review →</span>
                  </Link>
                </li>
              ))}
            </ol>
          )}
          {matchedList && (
            <p className="mt-4 text-[13px]">
              <Link href={`/top-10/${matchedList.slug}`} className="text-blue-600 hover:underline font-medium">
                See full ranked list with editorial reasoning →
              </Link>
            </p>
          )}
        </section>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">How {role.title.toLowerCase()}s typically use this stack</h2>
          <ol className="space-y-4">
            {role.workflow.map((step, i) => (
              <li key={i} className="flex gap-4">
                <span className="text-[14px] font-bold text-blue-600 flex-shrink-0 w-7">{i + 1}.</span>
                <div>
                  <p className="text-[15px] font-semibold text-foreground mb-1">{step.title}</p>
                  <p className="text-[14px] text-muted-foreground leading-relaxed">{step.body}</p>
                </div>
              </li>
            ))}
          </ol>
        </section>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">Budget tiers</h2>
          <div className="space-y-3">
            {role.budget.map((b, i) => (
              <div key={i} className="rounded-xl border border-border bg-card p-4">
                <div className="flex items-center justify-between gap-3 mb-1">
                  <p className="text-[15px] font-bold text-foreground">{b.label}</p>
                  <span className="text-[13px] font-semibold text-blue-600 flex-shrink-0">{b.monthly}</span>
                </div>
                <p className="text-[13px] text-muted-foreground leading-relaxed">{b.notes}</p>
              </div>
            ))}
          </div>
        </section>

        <section className="mb-10">
          <h2 className="text-[20px] font-bold text-foreground mb-4">Frequently asked</h2>
          <div className="space-y-3">
            {role.faqs.map((f, i) => (
              <details key={i} className="group rounded-xl border border-border bg-card overflow-hidden">
                <summary className="flex items-center justify-between gap-4 px-5 py-4 cursor-pointer list-none hover:bg-gray-50 dark:hover:bg-gray-900/40 transition-colors">
                  <span className="text-[14.5px] font-semibold text-foreground">{f.q}</span>
                  <svg className="w-4 h-4 text-muted-foreground transition-transform group-open:rotate-180 flex-shrink-0" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24" aria-hidden="true">
                    <polyline points="6 9 12 15 18 9" />
                  </svg>
                </summary>
                <div className="px-5 pb-4 text-[13.5px] text-muted-foreground leading-relaxed">{f.a}</div>
              </details>
            ))}
          </div>
        </section>

        {role.relatedUseCaseLists.length > 0 && (
          <section className="mb-10">
            <h2 className="text-[16px] font-bold text-foreground mb-3">Related use-case lists</h2>
            <ul className="flex flex-wrap gap-2">
              {role.relatedUseCaseLists.map(l => (
                <li key={l.slug}>
                  <Link href={`/top-10/${l.slug}`} className="inline-block px-3 py-1.5 rounded-full border border-border bg-card hover:border-blue-300 hover:text-blue-600 transition-colors text-[13px]">
                    {l.label}
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        )}

        <div className="text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
          See also: <Link href="/roles" className="text-blue-600 hover:underline">All roles</Link>
          <span className="mx-2">·</span>
          <Link href="/top-10" className="text-blue-600 hover:underline">Top 10 by use case</Link>
          <span className="mx-2">·</span>
          <Link href="/quiz" className="text-blue-600 hover:underline">Find your stack quiz</Link>
        </div>

      </div>
    </>
  )
}
