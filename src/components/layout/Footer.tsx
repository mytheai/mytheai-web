import Link from 'next/link'
import { useTranslations } from 'next-intl'

export default function Footer() {
  const t = useTranslations('Footer')
  const year = new Date().getFullYear()

  const discoverLinks = [
    { href: '/tools', label: t('tools') },
    { href: '/categories', label: t('categories') },
    { href: '/top-10', label: t('top10') },
    { href: '/deals', label: t('deals') },
    { href: '/tools?filter=free', label: t('freeTools') },
  ]

  const reviewsLinks = [
    { href: '/reviews', label: t('reviews') },
    { href: '/compare', label: t('compare') },
    { href: '/blog', label: t('blog') },
    { href: '/submit', label: t('submit') },
  ]

  const companyLinks = [
    { href: '/about', label: t('about') },
    { href: '/methodology', label: t('howWeRank') },
    { href: '/transparency', label: t('transparency') },
    { href: '/about#affiliate', label: t('affiliateDisclosure') },
    { href: '/privacy', label: t('privacyPolicy') },
    { href: '/contact', label: t('contact') },
  ]

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
              {t('tagline')}
            </p>
          </div>

          {/* Discover */}
          <div>
            <h4 className="text-[12px] font-bold uppercase tracking-wider text-foreground mb-3">{t('discoverHeading')}</h4>
            <ul className="space-y-2">
              {discoverLinks.map(l => (
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
            <h4 className="text-[12px] font-bold uppercase tracking-wider text-foreground mb-3">{t('reviewsHeading')}</h4>
            <ul className="space-y-2">
              {reviewsLinks.map(l => (
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
            <h4 className="text-[12px] font-bold uppercase tracking-wider text-foreground mb-3">{t('companyHeading')}</h4>
            <ul className="space-y-2">
              {companyLinks.map(l => (
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
            <span className="font-semibold">{t('affiliateDisclosure')}:</span> Some links on this site are affiliate links. We may earn a commission at no extra cost to you. Our rankings are never influenced by affiliate relationships.
          </p>
          <p className="text-[12px] text-muted-foreground">
            {t('copyright', { year })}
          </p>
        </div>
      </div>
    </footer>
  )
}
