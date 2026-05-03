import Link from 'next/link'
import { getTranslations } from 'next-intl/server'
import { mockCategories } from '@/data/mock'
import type { Metadata } from 'next'

export const revalidate = 604800

export const metadata: Metadata = {
  title: 'AI Tool Categories: Browse by Type | MytheAi',
  description: 'Browse AI and SaaS tools by category: writing, image, video, code, SEO, productivity, analytics, and more.',
  alternates: { canonical: 'https://mytheai.com/categories' },
  openGraph: {
    title: 'AI Tool Categories: Browse by Type | MytheAi',
    url: 'https://mytheai.com/categories',
  },
}

export default async function CategoriesPage() {
  const t = await getTranslations('MiscPages')
  const tSection = await getTranslations('HomeSections')
  return (
    <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">{t('categoriesEyebrow')}</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          {t('categoriesTitle')}
        </h1>
        <p className="text-[15px] text-muted-foreground">
          {t('categoriesIntro', { count: mockCategories.length })}
        </p>
      </div>

      <div className="grid sm:grid-cols-2 gap-3">
        {mockCategories.map(cat => (
          <Link
            key={cat.slug}
            href={`/categories/${cat.slug}`}
            className="flex items-center gap-4 p-4 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors group"
          >
            <span className="text-3xl flex-shrink-0">{cat.emoji}</span>
            <div className="min-w-0 flex-1">
              <p className="text-[15px] font-bold text-foreground group-hover:text-blue-600 transition-colors">{cat.name}</p>
              <p className="text-[13px] text-muted-foreground">{tSection('toolCount', { count: cat.tool_count })}</p>
            </div>
            <span className="text-muted-foreground text-[13px] flex-shrink-0">→</span>
          </Link>
        ))}
      </div>
    </div>
  )
}
