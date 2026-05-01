import Link from 'next/link'

export default function Footer() {
  return (
    <footer className="bg-card border-t border-border mt-16">
      <div className="max-w-7xl mx-auto px-4 md:px-5 py-12">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8 mb-10">

          {/* Brand */}
          <div className="col-span-2 md:col-span-1">
            <div className="flex items-center gap-2 mb-3">
              <svg width="28" height="28" viewBox="0 0 32 32" fill="none" aria-hidden="true">
                <defs>
                  <linearGradient id="footer-grad" x1="0" y1="0" x2="32" y2="32" gradientUnits="userSpaceOnUse">
                    <stop offset="0%" stopColor="#60A5FA" />
                    <stop offset="100%" stopColor="#1D4ED8" />
                  </linearGradient>
                </defs>
                <rect width="32" height="32" rx="8" fill="url(#footer-grad)" />
                <path d="M16 4 L19 13 L28 16 L19 19 L16 28 L13 19 L4 16 L13 13 Z" fill="white" />
              </svg>
              <span
                className="font-bold text-[16px] tracking-tight text-transparent bg-clip-text"
                style={{ backgroundImage: 'linear-gradient(135deg, #60A5FA 0%, #1D4ED8 100%)' }}
              >
                MytheAi
              </span>
            </div>
            <p className="text-[13px] text-muted-foreground leading-relaxed">
              AI & SaaS tools, curated for professionals.
            </p>
          </div>

          {/* Discover */}
          <div>
            <h4 className="text-[12px] font-bold uppercase tracking-wider text-foreground mb-3">Discover</h4>
            <ul className="space-y-2">
              {[
                { href: '/tools', label: 'All Tools' },
                { href: '/categories', label: 'Categories' },
                { href: '/top-10', label: 'Top 10 Lists' },
                { href: '/deals', label: 'Deals & LTDs' },
                { href: '/tools?filter=free', label: 'Free Tools' },
              ].map(l => (
                <li key={l.href}>
                  <Link href={l.href} className="text-[13px] text-muted-foreground hover:text-blue-600 transition-colors">
                    {l.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Reviews */}
          <div>
            <h4 className="text-[12px] font-bold uppercase tracking-wider text-foreground mb-3">Reviews</h4>
            <ul className="space-y-2">
              {[
                { href: '/reviews', label: 'Latest Reviews' },
                { href: '/compare', label: 'Comparisons' },
                { href: '/blog', label: 'Blog' },
                { href: '/submit', label: 'Submit a Tool' },
              ].map(l => (
                <li key={l.href}>
                  <Link href={l.href} className="text-[13px] text-muted-foreground hover:text-blue-600 transition-colors">
                    {l.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Company */}
          <div>
            <h4 className="text-[12px] font-bold uppercase tracking-wider text-foreground mb-3">Company</h4>
            <ul className="space-y-2">
              {[
                { href: '/about', label: 'About' },
                { href: '/methodology', label: 'How We Rank' },
                { href: '/about#affiliate', label: 'Affiliate Disclosure' },
                { href: '/privacy', label: 'Privacy Policy' },
                { href: '/contact', label: 'Contact' },
              ].map(l => (
                <li key={l.href}>
                  <Link href={l.href} className="text-[13px] text-muted-foreground hover:text-blue-600 transition-colors">
                    {l.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Disclosure + copyright */}
        <div className="border-t border-border pt-6 space-y-3">
          <p className="text-[12px] text-muted-foreground leading-relaxed max-w-2xl">
            <span className="font-semibold">Affiliate Disclosure:</span> Some links on this site are affiliate links. We may earn a commission at no extra cost to you. Our rankings are never influenced by affiliate relationships.
          </p>
          <p className="text-[12px] text-muted-foreground">
            © {new Date().getFullYear()} MytheAi. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  )
}
