'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import SearchDropdown from '@/components/search/SearchDropdown'
import LanguagePicker from '@/components/layout/LanguagePicker'

const NAV_LINKS = [
  { href: '/tools', label: 'Tools' },
  { href: '/compare', label: 'Compare' },
  { href: '/top-10', label: 'Top 10' },
  { href: '/blog', label: 'Blog' },
]

export default function Header() {
  const [menuOpen, setMenuOpen] = useState(false)
  const [dark, setDark] = useState(false)

  useEffect(() => {
    const saved = localStorage.getItem('dm') === '1'
    setDark(saved)
    document.documentElement.classList.toggle('dark', saved)
  }, [])

  function toggleDark() {
    const next = !dark
    setDark(next)
    document.documentElement.classList.toggle('dark', next)
    localStorage.setItem('dm', next ? '1' : '0')
  }

  return (
    <header className="header-blur sticky top-0 z-50 border-b border-border">
      <div className="max-w-7xl mx-auto px-4 md:px-5 flex items-center h-[60px] gap-3">

        {/* Logo */}
        <Link href="/" className="flex items-center gap-2 flex-shrink-0">
          <svg width="32" height="32" viewBox="0 0 32 32" fill="none" aria-hidden="true">
            <defs>
              <linearGradient id="logo-grad" x1="0" y1="0" x2="32" y2="32" gradientUnits="userSpaceOnUse">
                <stop offset="0%" stopColor="#60A5FA" />
                <stop offset="100%" stopColor="#1D4ED8" />
              </linearGradient>
            </defs>
            <rect width="32" height="32" rx="8" fill="url(#logo-grad)" />
            {/* AI north-star sparkle */}
            <path d="M16 4 L19 13 L28 16 L19 19 L16 28 L13 19 L4 16 L13 13 Z" fill="white" />
          </svg>
          <span
            className="font-bold text-[17px] tracking-tight text-transparent bg-clip-text"
            style={{ backgroundImage: 'linear-gradient(135deg, #60A5FA 0%, #1D4ED8 100%)' }}
          >
            MytheAi
          </span>
        </Link>

        {/* Right group: nav + actions, always pushed right */}
        <div className="flex items-center gap-3 ml-auto">

          {/* Desktop nav */}
          <nav className="hidden md:flex items-center gap-5 text-[13.5px] font-medium text-muted-foreground">
            {NAV_LINKS.map(l => (
              <Link key={l.href} href={l.href} className="hover:text-blue-600 transition-colors">
                {l.label}
              </Link>
            ))}
          </nav>

          {/* Actions */}
          <div className="flex items-center gap-1.5">
            {/* Language picker */}
            <LanguagePicker />

            {/* Dark mode */}
            <button
              onClick={toggleDark}
              className="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-muted-foreground transition-colors"
              aria-label="Toggle dark mode"
            >
              {dark ? (
                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <circle cx="12" cy="12" r="5" /><line x1="12" y1="1" x2="12" y2="3" /><line x1="12" y1="21" x2="12" y2="23" />
                  <line x1="4.22" y1="4.22" x2="5.64" y2="5.64" /><line x1="18.36" y1="18.36" x2="19.78" y2="19.78" />
                  <line x1="1" y1="12" x2="3" y2="12" /><line x1="21" y1="12" x2="23" y2="12" />
                  <line x1="4.22" y1="19.78" x2="5.64" y2="18.36" /><line x1="18.36" y1="5.64" x2="19.78" y2="4.22" />
                </svg>
              ) : (
                <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z" />
                </svg>
              )}
            </button>

            {/* Find Your Stack */}
            <button className="hidden sm:inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-lg text-[13px] font-semibold text-white bg-blue-600 hover:bg-blue-700 transition-colors">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
                <path d="M12 2l2.5 8H22l-7 5 2.5 8.5L12 19l-6.5 4.5L8 15l-7-5h7.5z" />
              </svg>
              Find Your Stack
            </button>

            {/* Mobile hamburger */}
            <button
              onClick={() => setMenuOpen(o => !o)}
              className="md:hidden p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 text-muted-foreground transition-colors"
              aria-label="Toggle menu"
            >
              {menuOpen ? (
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" />
                </svg>
              ) : (
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <line x1="3" y1="6" x2="21" y2="6" /><line x1="3" y1="12" x2="21" y2="12" /><line x1="3" y1="18" x2="21" y2="18" />
                </svg>
              )}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile drawer */}
      {menuOpen && (
        <div className="md:hidden bg-card border-t border-border">
          {/* Mobile search */}
          <div className="max-w-7xl mx-auto px-4 pt-3 pb-2">
            <SearchDropdown variant="header" />
          </div>
          <nav className="max-w-7xl mx-auto px-4 pb-4 flex flex-col gap-1">
            {NAV_LINKS.map(l => (
              <Link
                key={l.href}
                href={l.href}
                onClick={() => setMenuOpen(false)}
                className="py-2.5 px-3 rounded-lg text-[14px] font-medium text-muted-foreground hover:bg-gray-50 dark:hover:bg-gray-800 hover:text-blue-600 transition-colors"
              >
                {l.label}
              </Link>
            ))}
            <div className="pt-2 mt-1 border-t border-border">
              <button className="py-2.5 px-3 rounded-lg text-[14px] font-semibold flex items-center gap-2 text-blue-600">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M12 2l2.5 8H22l-7 5 2.5 8.5L12 19l-6.5 4.5L8 15l-7-5h7.5z" />
                </svg>
                Find Your Stack
              </button>
            </div>
          </nav>
        </div>
      )}
    </header>
  )
}
