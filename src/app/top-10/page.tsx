import { TOP10_LISTS } from '@/data/top10'
import { getTranslations } from 'next-intl/server'
import Top10Grid from './Top10Grid'
import type { Metadata } from 'next'

export const revalidate = 604800

export const metadata: Metadata = {
  title: 'Best AI Tools: Top 10 Lists 2026 | MytheAi',
  description: 'Editorial top 10 lists for every AI tool category: code, writing, image, video, and free tools. Ranked by merit, not affiliate rate.',
  alternates: { canonical: 'https://mytheai.com/top-10' },
}

const collectionSchema = {
  '@context': 'https://schema.org',
  '@type': 'CollectionPage',
  name: 'Best AI Tools: Top 10 Lists 2026',
  description: 'Editorial top 10 lists for every AI tool category: code, writing, image, video, and free tools. Ranked by merit, not affiliate rate.',
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

      <Top10Grid items={TOP10_LISTS} />

      <div className="mt-10 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
        <strong>Editorial note:</strong> All rankings are based on independent editorial review: rating, review count, feature quality, and value. Affiliate relationships never influence placement.
      </div>
    </div>
    </>
  )
}
