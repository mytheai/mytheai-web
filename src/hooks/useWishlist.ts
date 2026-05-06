'use client'

import { useEffect, useState, useCallback } from 'react'

const STORAGE_KEY = 'mytheai-wishlist-v1'
const EVENT_NAME = 'mytheai-wishlist-change'

function readSet(): Set<string> {
  if (typeof window === 'undefined') return new Set()
  try {
    const raw = window.localStorage.getItem(STORAGE_KEY)
    if (!raw) return new Set()
    const parsed = JSON.parse(raw)
    return new Set(Array.isArray(parsed) ? parsed.filter(s => typeof s === 'string') : [])
  } catch {
    return new Set()
  }
}

function writeSet(set: Set<string>) {
  if (typeof window === 'undefined') return
  window.localStorage.setItem(STORAGE_KEY, JSON.stringify([...set]))
  window.dispatchEvent(new CustomEvent(EVENT_NAME))
}

export function useWishlist() {
  const [slugs, setSlugs] = useState<string[]>([])
  const [hydrated, setHydrated] = useState(false)

  useEffect(() => {
    setSlugs([...readSet()])
    setHydrated(true)
    const onChange = () => setSlugs([...readSet()])
    window.addEventListener(EVENT_NAME, onChange)
    window.addEventListener('storage', onChange)
    return () => {
      window.removeEventListener(EVENT_NAME, onChange)
      window.removeEventListener('storage', onChange)
    }
  }, [])

  const has = useCallback((slug: string) => slugs.includes(slug), [slugs])

  const toggle = useCallback((slug: string) => {
    const set = readSet()
    if (set.has(slug)) set.delete(slug)
    else set.add(slug)
    writeSet(set)
  }, [])

  const remove = useCallback((slug: string) => {
    const set = readSet()
    set.delete(slug)
    writeSet(set)
  }, [])

  const clear = useCallback(() => {
    writeSet(new Set())
  }, [])

  return { slugs, has, toggle, remove, clear, hydrated, count: slugs.length }
}
