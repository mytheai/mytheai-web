import type { Metadata } from 'next'
import SubmitClient from './SubmitClient'

export const metadata: Metadata = {
  title: 'Submit a Tool - Suggest an AI or SaaS Tool | MytheAi',
  description: 'Know a great AI or SaaS tool we are missing? Submit it for editorial review. Our team reviews community submissions weekly.',
  alternates: { canonical: 'https://mytheai.com/submit' },
  openGraph: {
    title: 'Submit a Tool to MytheAi',
    description: 'Suggest an AI or SaaS tool for our editorial team to review.',
    url: 'https://mytheai.com/submit',
    type: 'website',
  },
}

export default function Page() {
  return <SubmitClient />
}
