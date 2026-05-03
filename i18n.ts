import { getRequestConfig } from 'next-intl/server'
import { cookies, headers } from 'next/headers'

export const locales = ['en', 'es', 'pt'] as const
export type Locale = (typeof locales)[number]
export const defaultLocale: Locale = 'en'
export const LOCALE_COOKIE = 'NEXT_LOCALE'
export const RTL_LOCALES = new Set<Locale>()

const ACCEPT_LANG_PREFIX_MAP: Array<[string, Locale]> = [
  ['es', 'es'],
  ['pt', 'pt'],
]

function pickLocale(cookieValue: string | undefined, acceptLanguage: string | null): Locale {
  if (cookieValue && (locales as readonly string[]).includes(cookieValue)) {
    return cookieValue as Locale
  }
  if (acceptLanguage) {
    const lower = acceptLanguage.toLowerCase()
    for (const [prefix, locale] of ACCEPT_LANG_PREFIX_MAP) {
      if (lower.startsWith(prefix)) return locale
    }
  }
  return defaultLocale
}

export default getRequestConfig(async () => {
  const cookieStore = await cookies()
  const headerStore = await headers()
  const locale = pickLocale(
    cookieStore.get(LOCALE_COOKIE)?.value,
    headerStore.get('accept-language'),
  )
  const messages = (await import(`./messages/${locale}.json`)).default
  return { locale, messages }
})
