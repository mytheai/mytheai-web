// Author profiles for E-E-A-T signals.
// Each blog post / tool page / top-10 list links to one of these via slug.
// Schema.org Person JSON-LD is emitted from this data so search engines
// see individual bylines instead of organization-level attribution.

export interface Author {
  slug: string
  name: string
  role: string
  bio: string
  url: string            // canonical author page or /about anchor
  twitter?: string       // full URL, e.g. https://twitter.com/handle
  linkedin?: string      // full URL
  github?: string        // full URL
  image?: string         // optional avatar URL (relative or absolute)
}

export const AUTHORS: Record<string, Author> = {
  'john-ethan': {
    slug: 'john-ethan',
    name: 'John Ethan',
    role: 'Founder & Editor-in-Chief',
    bio: 'Founder of MytheAi. Tracking and reviewing AI and SaaS tools since January 2026. Built MytheAi out of frustration with pay-to-rank listicles and SEO-driven AI directories that prioritize ad revenue over honest guidance. Hands-on testing across 651+ tools to date.',
    url: 'https://mytheai.com/authors/john-ethan',
  },
}

export const DEFAULT_AUTHOR_SLUG = 'john-ethan'

export function getAuthor(slug?: string): Author {
  if (slug && AUTHORS[slug]) return AUTHORS[slug]
  return AUTHORS[DEFAULT_AUTHOR_SLUG]
}

// Build a Schema.org Person object suitable for JSON-LD `author` field.
// Only includes sameAs entries that are actually populated (avoids dead URLs).
export function getAuthorJsonLd(slug?: string) {
  const a = getAuthor(slug)
  const sameAs = [a.twitter, a.linkedin, a.github].filter(Boolean) as string[]
  return {
    '@type': 'Person' as const,
    name: a.name,
    url: a.url,
    jobTitle: a.role,
    description: a.bio,
    ...(sameAs.length > 0 ? { sameAs } : {}),
    ...(a.image ? { image: a.image } : {}),
  }
}
