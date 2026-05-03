'use client'

import { useEffect, useRef, useState } from 'react'

const LANGS = [
  { code: 'en', label: 'English', flag: '🇬🇧' },
  { code: 'zh-CN', label: '中文', flag: '🇨🇳' },
  { code: 'hi', label: 'हिन्दी', flag: '🇮🇳' },
  { code: 'es', label: 'Español', flag: '🇪🇸' },
  { code: 'fr', label: 'Français', flag: '🇫🇷' },
] as const

const INCLUDED = LANGS.map(l => l.code).join(',')

declare global {
  interface Window {
    google?: {
      translate?: {
        TranslateElement: new (
          opts: { pageLanguage: string; includedLanguages: string; autoDisplay: boolean },
          el: string
        ) => unknown
      }
    }
    googleTranslateElementInit?: () => void
  }
}

function readCookie(): string {
  if (typeof document === 'undefined') return 'en'
  const m = document.cookie.match(/(?:^|; )googtrans=\/en\/([^;]+)/)
  return m ? decodeURIComponent(m[1]) : 'en'
}

function writeCookie(code: string) {
  const host = window.location.hostname
  const root = host.split('.').slice(-2).join('.')
  if (code === 'en') {
    const expire = 'expires=Thu, 01 Jan 1970 00:00:00 GMT'
    document.cookie = `googtrans=; path=/; ${expire}`
    document.cookie = `googtrans=; domain=${host}; path=/; ${expire}`
    document.cookie = `googtrans=; domain=.${root}; path=/; ${expire}`
    return
  }
  const value = `/en/${code}`
  document.cookie = `googtrans=${value}; path=/`
  document.cookie = `googtrans=${value}; domain=${host}; path=/`
  document.cookie = `googtrans=${value}; domain=.${root}; path=/`
}

export default function LanguagePicker() {
  const [open, setOpen] = useState(false)
  const [current, setCurrent] = useState<string>('en')
  const ref = useRef<HTMLDivElement | null>(null)

  useEffect(() => {
    setCurrent(readCookie())

    if (!document.getElementById('gt-script')) {
      window.googleTranslateElementInit = () => {
        const T = window.google?.translate?.TranslateElement
        if (T) {
          new T(
            { pageLanguage: 'en', includedLanguages: INCLUDED, autoDisplay: false },
            'google_translate_element'
          )
        }
      }
      const s = document.createElement('script')
      s.id = 'gt-script'
      s.src = 'https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit'
      s.async = true
      document.body.appendChild(s)
    }

    // Defensive: remove GT banner iframe + reset body offset whenever they reappear.
    // CSS rules sometimes lose to Google's inline style on body (top: 40px).
    function purgeBanner() {
      document
        .querySelectorAll<HTMLElement>(
          'iframe.skiptranslate, iframe.goog-te-banner-frame, .goog-te-banner-frame'
        )
        .forEach(el => el.remove())
      if (document.body.style.top) document.body.style.top = ''
      if (document.documentElement.style.top) document.documentElement.style.top = ''
    }
    const purgeInterval = window.setInterval(purgeBanner, 300)
    const stopPurge = window.setTimeout(() => window.clearInterval(purgeInterval), 8000)

    function onClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false)
    }
    document.addEventListener('mousedown', onClickOutside)
    return () => {
      document.removeEventListener('mousedown', onClickOutside)
      window.clearInterval(purgeInterval)
      window.clearTimeout(stopPurge)
    }
  }, [])

  function pick(code: string) {
    writeCookie(code)
    setCurrent(code)
    setOpen(false)

    // Switching back to English requires a hard reload: Google Translate
    // does not restore the original DOM content via combo.value='' alone,
    // it only translates forward in-place. Reload reads the cleared
    // googtrans cookie and renders the original EN HTML.
    if (code === 'en') {
      window.location.reload()
      return
    }

    const combo = document.querySelector<HTMLSelectElement>('select.goog-te-combo')
    if (combo) {
      combo.value = code
      combo.dispatchEvent(new Event('change'))
      return
    }
    window.location.reload()
  }

  const cur = LANGS.find(l => l.code === current) ?? LANGS[0]

  return (
    <div ref={ref} className="relative notranslate" translate="no">
      <button
        onClick={() => setOpen(o => !o)}
        className="flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg text-[13px] font-medium text-muted-foreground hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
        aria-label="Select language"
        aria-haspopup="listbox"
        aria-expanded={open}
      >
        <span className="text-[15px] leading-none">{cur.flag}</span>
        <span className="hidden lg:inline">{cur.label}</span>
        <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
          <polyline points="6 9 12 15 18 9" />
        </svg>
      </button>

      {open && (
        <div
          role="listbox"
          className="absolute right-0 top-full mt-2 w-48 rounded-xl border border-border bg-card shadow-lg overflow-hidden z-50"
        >
          {LANGS.map(l => {
            const selected = l.code === current
            return (
              <button
                key={l.code}
                role="option"
                aria-selected={selected}
                onClick={() => pick(l.code)}
                className={`w-full flex items-center gap-2.5 px-3 py-2 text-[13.5px] text-left hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors ${selected ? 'text-blue-600 font-semibold' : 'text-foreground'}`}
              >
                <span className="text-[16px] leading-none">{l.flag}</span>
                <span className="flex-1">{l.label}</span>
                {selected && (
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
                    <polyline points="20 6 9 17 4 12" />
                  </svg>
                )}
              </button>
            )
          })}
        </div>
      )}

      <div id="google_translate_element" style={{ display: 'none' }} />
    </div>
  )
}
