import { createClient } from '@/lib/supabase'

interface ReviewRow {
  id: string
  rating: number
  best_for: string
  limitation: string
  author_name: string | null
  author_role: string | null
  created_at: string
}

interface ReviewListProps {
  toolSlug: string
}

export async function getApprovedReviews(toolSlug: string): Promise<ReviewRow[]> {
  const supabase = await createClient()
  const { data } = await supabase
    .from('tool_reviews')
    .select('id, rating, best_for, limitation, author_name, author_role, created_at')
    .eq('tool_slug', toolSlug)
    .eq('status', 'approved')
    .order('created_at', { ascending: false })
    .limit(20)
  return (data ?? []) as ReviewRow[]
}

export default async function ReviewList({ toolSlug }: ReviewListProps) {
  const reviews = await getApprovedReviews(toolSlug)

  if (reviews.length === 0) {
    return (
      <div className="p-5 rounded-xl border border-dashed border-border bg-card text-center">
        <p className="text-[13px] text-muted-foreground">No user reviews yet. Be the first to share your experience above.</p>
      </div>
    )
  }

  return (
    <div className="space-y-4">
      {reviews.map(r => (
        <article key={r.id} className="p-5 rounded-xl border border-border bg-card">
          <div className="flex items-start justify-between gap-4 mb-2">
            <div className="flex items-center gap-1 text-[16px] text-[#F59E0B]" aria-label={`${r.rating} of 5 stars`}>
              {Array.from({ length: 5 }).map((_, i) => (
                <span key={i} className={i < r.rating ? 'text-[#F59E0B]' : 'text-gray-300 dark:text-gray-600'}>★</span>
              ))}
            </div>
            <p className="text-[11px] text-muted-foreground whitespace-nowrap">
              {new Date(r.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-3">
            <div>
              <p className="text-[11px] font-bold uppercase tracking-[0.08em] text-blue-600 mb-1">Best for</p>
              <p className="text-[13px] text-foreground leading-relaxed">{r.best_for}</p>
            </div>
            <div>
              <p className="text-[11px] font-bold uppercase tracking-[0.08em] text-amber-600 mb-1">Limitation</p>
              <p className="text-[13px] text-foreground leading-relaxed">{r.limitation}</p>
            </div>
          </div>

          {(r.author_name || r.author_role) && (
            <p className="text-[12px] text-muted-foreground border-t border-border pt-2 mt-2">
              {r.author_name ?? 'Anonymous'}
              {r.author_role && <span className="opacity-80"> {' - '} {r.author_role}</span>}
            </p>
          )}
        </article>
      ))}
    </div>
  )
}
