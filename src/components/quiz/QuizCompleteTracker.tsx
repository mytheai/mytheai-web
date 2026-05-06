'use client'

import { useEffect } from 'react'

interface QuizCompleteTrackerProps {
  role: string
  budget: string
  toolCount: number
}

export default function QuizCompleteTracker({ role, budget, toolCount }: QuizCompleteTrackerProps) {
  useEffect(() => {
    if (typeof window === 'undefined') return
    const w = window as { plausible?: (event: string, options?: { props: Record<string, string | number> }) => void }
    if (w.plausible) {
      w.plausible('QuizComplete', { props: { role, budget, results: toolCount } })
    }
  }, [role, budget, toolCount])

  return null
}
