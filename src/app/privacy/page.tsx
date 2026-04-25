import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Privacy Policy | MytheAi',
  description: 'How MytheAi collects, uses, and protects your data. We take privacy seriously.',
  alternates: { canonical: 'https://mytheai.com/privacy' },
}

export default function PrivacyPage() {
  return (
    <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <div className="mb-8">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-[#2563EB] mb-1">Legal</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-2">
          Privacy Policy
        </h1>
        <p className="text-[13px] text-muted-foreground">Last updated: April 2026</p>
      </div>

      <div className="space-y-8 text-[15px] text-muted-foreground leading-relaxed">

        <section>
          <h2 className="text-[18px] font-bold text-foreground mb-3">1. What We Collect</h2>
          <p className="mb-3">
            MytheAi collects minimal data to operate the platform:
          </p>
          <ul className="space-y-2 list-disc list-inside">
            <li><span className="font-medium text-foreground">Analytics data</span> — page views, referral source, and general device type via Vercel Analytics. No personal identifiers are stored.</li>
            <li><span className="font-medium text-foreground">Affiliate click data</span> — when you click an affiliate link, we record the tool slug and referrer URL (but not your identity) for commission attribution.</li>
            <li><span className="font-medium text-foreground">Tool submissions</span> — if you submit a tool via our form, we collect your submission details and optionally an email address for follow-up.</li>
            <li><span className="font-medium text-foreground">Newsletter</span> — if you subscribe, we collect your email address only.</li>
          </ul>
        </section>

        <section>
          <h2 className="text-[18px] font-bold text-foreground mb-3">2. Cookies</h2>
          <p className="mb-3">
            We use a single first-party cookie to remember your dark mode preference (<code className="text-[13px] bg-muted rounded px-1">dm</code>). This is stored in your browser&apos;s <code className="text-[13px] bg-muted rounded px-1">localStorage</code> and never sent to our servers.
          </p>
          <p>
            We do not use third-party tracking cookies, advertising cookies, or cross-site identifiers.
          </p>
        </section>

        <section>
          <h2 className="text-[18px] font-bold text-foreground mb-3">3. Third-Party Services</h2>
          <ul className="space-y-2 list-disc list-inside">
            <li><span className="font-medium text-foreground">Vercel</span> — hosts the platform. May log IP addresses as part of infrastructure operation. See <a href="https://vercel.com/legal/privacy-policy" target="_blank" rel="noopener noreferrer" className="text-[#2563EB] hover:underline">Vercel&apos;s Privacy Policy</a>.</li>
            <li><span className="font-medium text-foreground">Supabase</span> — stores tool and category data. No personal data is stored in Supabase.</li>
            <li><span className="font-medium text-foreground">Affiliate networks</span> — when you follow an affiliate link, the destination site has its own data collection practices governed by their privacy policy.</li>
          </ul>
        </section>

        <section>
          <h2 className="text-[18px] font-bold text-foreground mb-3">4. Your Rights (GDPR)</h2>
          <p className="mb-3">
            If you are in the European Economic Area, you have the right to access, correct, or delete any personal data we hold about you. Since we collect very little personal data, in most cases there is nothing to delete.
          </p>
          <p>
            To exercise any rights or ask questions, email us at{' '}
            <a href="mailto:info@mytheai.com" className="text-[#2563EB] hover:underline">
              info@mytheai.com
            </a>.
          </p>
        </section>

        <section>
          <h2 className="text-[18px] font-bold text-foreground mb-3">5. Changes to This Policy</h2>
          <p>
            We may update this policy occasionally. Any significant changes will be noted with a new &quot;Last updated&quot; date at the top of this page.
          </p>
        </section>

      </div>
    </div>
  )
}
