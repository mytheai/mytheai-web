import { TOP10_LISTS } from '@/data/top10'
import { getTranslations } from 'next-intl/server'
import Link from 'next/link'
import Top10Grid from './Top10Grid'
import type { Metadata } from 'next'

export const revalidate = 604800

export const metadata: Metadata = {
  title: 'Best AI Tools by Use Case 2026: Top Listicles | MytheAi',
  description: 'Editorial top lists for every AI use case: coding, writing, image generation, video, voice, SEO, research, and more. Ranked by merit, not affiliate rate.',
  alternates: { canonical: 'https://mytheai.com/top-10' },
}

// Filter: /top-10 hub shows USE-CASE lists only.
// Role/persona/context-bound lists (best-ai-tools-for-X) live on /roles instead.
// Direct URLs (/top-10/best-ai-tools-for-marketers) still resolve - only hub surfacing changes.
const USE_CASE_LISTS = TOP10_LISTS.filter(l => !l.slug.startsWith('best-ai-tools-for-'))

// Featured use cases at the top - matches the 12 core categories.
// Surfaced as a polished card group above the full grid, so users hitting /top-10
// see the highest-intent lists immediately rather than scanning 61 cards.
const FEATURED_SLUGS = [
  'best-code-ai-tools',
  'best-ai-image-generators',
  'best-ai-video-tools',
  'best-ai-writing-tools',
  'best-ai-voice-tools',
  'best-ai-seo-tools',
  'best-ai-research-tools',
  'best-ai-app-builders',
]
const FEATURED_LISTS = FEATURED_SLUGS
  .map(s => USE_CASE_LISTS.find(l => l.slug === s))
  .filter(Boolean) as typeof USE_CASE_LISTS
const REMAINING_LISTS = USE_CASE_LISTS.filter(l => !FEATURED_SLUGS.includes(l.slug))

const collectionSchema = {
  '@context': 'https://schema.org',
  '@type': 'CollectionPage',
  name: 'Best AI Tools by Use Case 2026',
  description: 'Editorial top lists for every AI use case: coding, writing, image generation, video, voice, SEO, research. Ranked by merit, not affiliate rate.',
  url: 'https://mytheai.com/top-10',
  publisher: { '@type': 'Organization', name: 'MytheAi', url: 'https://mytheai.com' },
}

export default async function Top10HubPage() {
  const t = await getTranslations('HubPages')
  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(collectionSchema) }} />
    <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">{t('top10Eyebrow')}</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          {t('top10Title')}
        </h1>
        <p className="text-[15px] text-muted-foreground">
          {t('top10Intro')}
        </p>
      </div>

      <div className="mb-8 flex items-center gap-2 p-4 rounded-xl border border-blue-200 bg-blue-50/50 dark:bg-blue-900/10 dark:border-blue-800/40">
        <span className="text-xl flex-shrink-0" aria-hidden="true">👤</span>
        <p className="text-[13.5px] text-foreground">
          Looking for tools by professional role?{' '}
          <Link href="/roles" className="text-blue-600 font-semibold hover:underline">Browse by role →</Link>
          <span className="text-muted-foreground"> (developer, marketer, designer, founder, student, sales, support, content creator)</span>
        </p>
      </div>

      {FEATURED_LISTS.length > 0 && (
        <section className="mb-10">
          <h2 className="text-[18px] font-bold text-foreground mb-4">Featured use cases</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
            {FEATURED_LISTS.map(list => (
              <Link
                key={list.slug}
                href={`/top-10/${list.slug}`}
                className="block p-4 rounded-xl border border-border bg-card hover:border-blue-300 hover:shadow-md transition-all"
              >
                <span className="text-2xl block mb-2" aria-hidden="true">{list.emoji}</span>
                <p className="text-[14px] font-bold text-foreground leading-snug mb-1">{list.title}</p>
                <p className="text-[11px] text-blue-600 font-semibold">Top {list.slugs.length} →</p>
              </Link>
            ))}
          </div>
        </section>
      )}

      <h2 className="text-[18px] font-bold text-foreground mb-4">All use-case lists</h2>
      <Top10Grid items={REMAINING_LISTS} />

      <div className="mt-10 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
        <strong>Editorial note:</strong> All rankings are based on independent editorial review: rating, review count, feature quality, and value. Affiliate relationships never influence placement.
      </div>
    </div>
    </>
  )
}
