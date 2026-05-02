import type { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Find Your AI Stack Quiz: 5 Questions, Personalized Picks | MytheAi',
  description: '5 quick questions about your role, use case, and budget. Get 5 personalized AI tool picks from our 591-tool directory. Free, no signup, instant results.',
  alternates: { canonical: 'https://mytheai.com/quiz' },
  openGraph: {
    title: 'Find Your AI Stack Quiz: 5 Questions, Personalized Picks',
    description: '5 quick questions, 5 personalized AI tool picks. Free, no signup, instant results.',
    url: 'https://mytheai.com/quiz',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Find Your AI Stack Quiz - MytheAi',
    description: '5 questions, 5 personalized AI tool picks. Free, instant results.',
  },
}

export default function QuizLayout({ children }: { children: React.ReactNode }) {
  return children
}
