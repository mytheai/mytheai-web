'use client'

import { useEffect, useRef, useState, useTransition } from 'react'
import { useRouter } from 'next/navigation'
import { useLocale, useTranslations } from 'next-intl'

const LANGS = [
  { code: 'en', label: 'English', flag: '🇬🇧' },
  { code: 'fr', label: 'Français', flag: '🇫🇷' },
  { code: 'es', label: 'Español', flag: '🇪🇸' },
  { code: 'pt', label: 'Português', flag: '🇧🇷' },
  { code: 'zh-CN', label: '中文', flag: '🇨🇳' },
  { code: 'hi', label: 'हिन्दी', flag: '🇮🇳' },
  { code: 'ar', label: 'العربية', flag: '🇸🇦' },
  { code: 'ru', label: 'Русский', flag: '🇷🇺' },
] as const

const LOCALE_COOKIE = 'NEXT_LOCALE'

function setLocaleCookie(code: string) {
  const host = window.location.hostname
  const root = host.split('.').slice(-2).join('.')
  const oneYear = 60 * 60 * 24 * 365
  document.cookie = `${LOCALE_COOKIE}=${code}; path=/; max-age=${oneYear}; SameSite=Lax`
  document.cookie = `${LOCALE_COOKIE}=${code}; domain=.${root}; path=/; max-age=${oneYear}; SameSite=Lax`
}

export default function LanguagePicker() {
  const t = useTranslations('Header')
  const locale = useLocale()
  const router = useRouter()
  const [, startTransition] = useTransition()
  const [open, setOpen] = useState(false)
  const ref = useRef<HTMLDivElement | null>(null)

  useEffect(() => {
    function onClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false)
    }
    document.addEventListener('mousedown', onClickOutside)
    return () => document.removeEventListener('mousedown', onClickOutside)
  }, [])

  function pick(code: string) {
    setOpen(false)
    if (code === locale) return
    setLocaleCookie(code)
    startTransition(() => {
      router.refresh()
    })
  }

  const cur = LANGS.find(l => l.code === locale) ?? LANGS[0]

  return (
    <div ref={ref} className="relative">
      <button
        onClick={() => setOpen(o => !o)}
        className="flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg text-[13px] font-medium text-muted-foreground hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
        aria-label={t('selectLanguage')}
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
          className="absolute right-0 top-full mt-2 w-44 max-h-[80vh] overflow-y-auto rounded-xl border border-border bg-card shadow-lg z-50"
        >
          {LANGS.map(l => {
            const selected = l.code === locale
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
    </div>
  )
}
