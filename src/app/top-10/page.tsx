import Link from 'next/link'
import { TOP10_LISTS } from '@/data/top10'
import type { Metadata } from 'next'

export const revalidate = 604800

export const metadata: Metadata = {
  title: 'Best AI Tools — Top 10 Lists 2026 | MytheAi',
  description: 'Editorial top 10 lists for every AI tool category — code, writing, image, video, and free tools. Ranked by merit, not affiliate rate.',
  alternates: { canonical: 'https://mytheai.com/top-10' },
}

export default function Top10HubPage() {
  return (
    <div className="max-w-4xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-10">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Rankings</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          Top 10 AI Tool Lists
        </h1>
        <p className="text-[15px] text-muted-foreground">
          Ranked by editorial merit. Never influenced by affiliate rates.
        </p>
      </div>

      <div className="grid sm:grid-cols-2 gap-4">
        {TOP10_LISTS.map(list => (
          <Link
            key={list.slug}
            href={`/top-10/${list.slug}`}
            className="flex items-start gap-4 p-5 rounded-xl border border-border bg-card hover:border-blue-300 transition-colors"
          >
            <span className="text-3xl flex-shrink-0">{list.emoji}</span>
            <div className="min-w-0">
              <p className="text-[15px] font-bold text-foreground mb-1">{list.title}</p>
              <p className="text-[13px] text-muted-foreground line-clamp-2 mb-2">{list.description}</p>
              <div className="flex items-center gap-3">
                <span className="text-[11px] font-semibold px-2 py-0.5 rounded-full bg-[#EFF6FF] text-[#1E40AF]">
                  {list.category}
                </span>
                <span className="text-[12px] text-blue-600 font-medium">Top {list.slugs.length} →</span>
              </div>
            </div>
          </Link>
        ))}
      </div>

      <div className="mt-10 text-[12px] text-muted-foreground border border-border rounded-lg p-4 bg-card">
        <strong>Editorial note:</strong> All rankings are based on independent editorial review — rating, review count, feature quality, and value. Affiliate relationships never influence placement.
      </div>
    </div>
  )
}
