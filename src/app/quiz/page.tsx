import type { Metadata } from 'next'
import QuizClient from './QuizClient'

export const metadata: Metadata = {
  title: 'AI Tool Recommendation Quiz - Find Your Stack | MytheAi',
  description: 'Answer 5 quick questions about your role, budget, and use case. Get a personalized AI tool stack tailored to your workflow. No signup required.',
  alternates: { canonical: 'https://mytheai.com/quiz' },
  openGraph: {
    title: 'AI Tool Recommendation Quiz - Find Your Stack',
    description: 'Five questions, five tool picks tailored to your role, budget, and goals.',
    url: 'https://mytheai.com/quiz',
    type: 'website',
  },
}

export default function Page() {
  return <QuizClient />
}
