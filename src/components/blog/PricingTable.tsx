interface Row {
  tool: string
  freeTier?: string
  starting?: string
  notes?: string
}

interface Props {
  rows: Row[]
  caption?: string
}

export default function PricingTable({ rows, caption }: Props) {
  if (!rows || rows.length === 0) return null
  return (
    <figure className="my-8">
      <div className="overflow-x-auto rounded-xl border border-border">
        <table className="w-full text-left">
          <thead className="bg-gray-50 dark:bg-gray-900/40">
            <tr>
              <th className="px-4 py-3 text-[12px] font-bold uppercase tracking-wide text-muted-foreground">Tool</th>
              <th className="px-4 py-3 text-[12px] font-bold uppercase tracking-wide text-muted-foreground">Free tier</th>
              <th className="px-4 py-3 text-[12px] font-bold uppercase tracking-wide text-muted-foreground">Starts at</th>
              <th className="px-4 py-3 text-[12px] font-bold uppercase tracking-wide text-muted-foreground hidden md:table-cell">Notes</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((r, i) => (
              <tr key={i} className={i % 2 === 0 ? 'bg-card' : 'bg-gray-50/40 dark:bg-gray-900/20'}>
                <td className="px-4 py-3 text-[13px] font-semibold text-foreground align-top">{r.tool}</td>
                <td className="px-4 py-3 text-[13px] text-muted-foreground align-top">{r.freeTier ?? '-'}</td>
                <td className="px-4 py-3 text-[13px] text-foreground align-top">{r.starting ?? '-'}</td>
                <td className="px-4 py-3 text-[13px] text-muted-foreground align-top hidden md:table-cell">{r.notes ?? ''}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      {caption && (
        <figcaption className="mt-2 text-[12px] text-muted-foreground italic">{caption}</figcaption>
      )}
    </figure>
  )
}
