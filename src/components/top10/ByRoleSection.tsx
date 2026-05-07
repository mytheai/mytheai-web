import Link from 'next/link'
import LogoImage from '@/components/ui/LogoImage'
import { createStaticClient } from '@/lib/supabase'
import { ROLES } from '@/data/roles'

interface ToolMeta {
  slug: string
  name: string
  logo_url: string | null
  website_url: string | null
}

export default async function ByRoleSection() {
  const supabase = createStaticClient()
  const previewSlugs = [...new Set(ROLES.flatMap(r => r.primaryToolSlugs.slice(0, 5)))]
  const { data: toolRows } = await supabase
    .from('tools')
    .select('slug,name,logo_url,website_url')
    .in('slug', previewSlugs)
  const toolMap: Record<string, ToolMeta> = {}
  for (const tool of (toolRows ?? []) as ToolMeta[]) toolMap[tool.slug] = tool

  return (
    <section id="by-role" className="mb-12 scroll-mt-20">
      <div className="flex items-baseline justify-between mb-4">
        <h2 className="text-[18px] font-bold text-foreground">By role</h2>
        <span className="text-[12px] text-muted-foreground">8 curated stacks</span>
      </div>
      <p className="text-[13.5px] text-muted-foreground mb-5 max-w-3xl">
        Curated stacks for 8 professional roles. Each role gets a top list scored on the same seven editorial criteria, plus workflow guidance and budget tiers.
      </p>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {ROLES.map(role => {
          const previewTools = role.primaryToolSlugs.slice(0, 5).map(s => toolMap[s]).filter(Boolean) as ToolMeta[]
          return (
            <Link
              key={role.slug}
              href={`/roles/${role.slug}`}
              className="group block border border-border rounded-xl p-4 bg-card transition-all duration-150 hover:border-blue-300 hover:shadow-md"
            >
              <div className="flex items-start gap-3 mb-2">
                <span className="text-2xl flex-shrink-0" aria-hidden="true">{role.emoji}</span>
                <div className="min-w-0 flex-1">
                  <h3 className="text-[15px] font-bold text-foreground group-hover:text-blue-600 transition-colors">{role.title}</h3>
                  <p className="text-[12px] text-muted-foreground">{role.desc}</p>
                </div>
              </div>
              {previewTools.length > 0 && (
                <div className="flex items-center gap-1.5 flex-wrap mt-2">
                  {previewTools.map(tool => (
                    <div key={tool.slug} className="flex items-center gap-1 text-[11.5px] text-foreground bg-background border border-border rounded-full pl-1 pr-2 py-0.5">
                      <LogoImage src={tool.logo_url} websiteUrl={tool.website_url} name={tool.name} size={16} />
                      <span className="font-medium">{tool.name}</span>
                    </div>
                  ))}
                </div>
              )}
              <p className="mt-3 text-[12px] font-semibold text-blue-600 group-hover:underline">
                See role guide →
              </p>
            </Link>
          )
        })}
      </div>
    </section>
  )
}
