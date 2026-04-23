import ToolCard from '@/components/tools/ToolCard'
import { mockTools, mockCategories } from '@/data/mock'

export const metadata = {
  title: 'All AI & SaaS Tools 2026 - Browse 500+ Tools | MytheAi',
  description: 'Browse and filter 500+ AI & SaaS tools by category, pricing, and rating. Find the right tool for your workflow.',
}

export default function ToolsPage() {
  return (
    <div className="max-w-7xl mx-auto px-4 md:px-5 py-10 md:py-14">

      {/* Page header */}
      <div className="mb-8">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Directory</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          All AI & SaaS Tools
        </h1>
        <p className="text-[15px] text-muted-foreground">
          500+ tools reviewed, compared, and ranked. Filter by category, pricing, or use case.
        </p>
      </div>

      {/* Filter bar */}
      <div className="flex flex-wrap gap-2 mb-8">
        <button className="px-3 py-1.5 rounded-lg text-[13px] font-semibold bg-blue-600 text-white">All</button>
        {mockCategories.slice(0, 8).map(cat => (
          <button
            key={cat.id}
            className="px-3 py-1.5 rounded-lg text-[13px] font-medium border border-border bg-card text-muted-foreground hover:border-blue-300 hover:text-blue-600 transition-colors"
          >
            {cat.emoji} {cat.name}
          </button>
        ))}
        <button className="px-3 py-1.5 rounded-lg text-[13px] font-medium border border-border bg-card text-muted-foreground hover:border-blue-300 hover:text-blue-600 transition-colors">
          More →
        </button>
      </div>

      {/* Pricing filter */}
      <div className="flex flex-wrap gap-2 mb-8">
        {['All pricing', 'Free', 'Freemium', 'Paid', 'LTD'].map(label => (
          <button
            key={label}
            className={`px-3 py-1 rounded-full text-[12px] font-medium border transition-colors ${
              label === 'All pricing'
                ? 'border-blue-300 text-blue-600 bg-[#EFF6FF]'
                : 'border-border bg-card text-muted-foreground hover:border-blue-300 hover:text-blue-600'
            }`}
          >
            {label}
          </button>
        ))}
      </div>

      {/* Tool grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
        {mockTools.map(tool => (
          <ToolCard key={tool.id} tool={tool} />
        ))}
      </div>

      {/* Coming soon note */}
      <div className="mt-12 text-center py-10 border border-dashed border-border rounded-xl">
        <p className="text-muted-foreground text-[14px]">
          500+ tools coming once Supabase is connected. Showing {mockTools.length} mock tools.
        </p>
      </div>

    </div>
  )
}
