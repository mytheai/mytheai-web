'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import {
  ROLE_LABELS,
  SKILL_LABELS,
  BUDGET_LABELS,
  TEAM_LABELS,
  USE_CASES,
  encodeAnswers,
  type QuizAnswers,
  type Role,
  type Skill,
  type Budget,
  type TeamSize,
} from '@/lib/quiz-logic'

type Step = 1 | 2 | 3 | 4 | 5

export default function QuizPage() {
  const router = useRouter()
  const [step, setStep] = useState<Step>(1)
  const [answers, setAnswers] = useState<Partial<QuizAnswers>>({})

  const total = 5
  const progress = ((step - 1) / total) * 100

  function pick<K extends keyof QuizAnswers>(key: K, value: QuizAnswers[K]) {
    const next = { ...answers, [key]: value }
    setAnswers(next)

    if (step === total) {
      const finalAnswers = next as QuizAnswers
      router.push(`/quiz/result?stack=${encodeAnswers(finalAnswers)}`)
      return
    }
    setStep((step + 1) as Step)
  }

  function back() {
    if (step === 1) return
    setStep((step - 1) as Step)
  }

  return (
    <div className="max-w-3xl mx-auto px-4 md:px-5 py-10 md:py-14">

      <nav className="flex items-center gap-1.5 text-[13px] text-muted-foreground mb-8">
        <Link href="/" className="hover:text-blue-600 transition-colors">Home</Link>
        <span>/</span>
        <span className="text-foreground font-medium">Find Your Stack</span>
      </nav>

      <div className="mb-8">
        <p className="text-[11px] font-bold uppercase tracking-[0.1em] text-blue-600 mb-1">Quiz · 60 seconds</p>
        <h1 className="text-[28px] md:text-[36px] font-extrabold tracking-tight text-foreground mb-3">
          Find your AI stack
        </h1>
        <p className="text-[15px] text-muted-foreground leading-relaxed">
          Five questions, five tool picks tailored to your role, budget, and goals. No signup required.
        </p>
      </div>

      <div className="mb-6">
        <div className="flex items-center justify-between mb-2 text-[12px] font-medium text-muted-foreground">
          <span>Question {step} of {total}</span>
          <span>{Math.round(progress)}%</span>
        </div>
        <div className="h-1.5 bg-gray-200 dark:bg-gray-800 rounded-full overflow-hidden">
          <div
            className="h-full bg-blue-600 transition-all duration-300"
            style={{ width: `${(step / total) * 100}%` }}
          />
        </div>
      </div>

      {step === 1 && (
        <Question
          title="What is your main role?"
          subtitle="Pick the closest. We tailor the rest of the quiz to it."
          options={(Object.entries(ROLE_LABELS) as [Role, string][]).map(([value, label]) => ({ value, label }))}
          onPick={v => pick('role', v as Role)}
        />
      )}

      {step === 2 && answers.role && (
        <Question
          title="Which use case matters most?"
          subtitle="Your top priority shapes which tools we recommend."
          options={USE_CASES[answers.role].map(u => ({ value: u.value, label: u.label }))}
          onPick={v => pick('useCase', v)}
        />
      )}

      {step === 3 && (
        <Question
          title="How experienced are you with AI tools?"
          subtitle="We balance recommendations toward simplicity or depth."
          options={(Object.entries(SKILL_LABELS) as [Skill, string][]).map(([value, label]) => ({ value, label }))}
          onPick={v => pick('skill', v as Skill)}
        />
      )}

      {step === 4 && (
        <Question
          title="What is your budget per month?"
          subtitle="We do not show tools that bust this number."
          options={(Object.entries(BUDGET_LABELS) as [Budget, string][]).map(([value, label]) => ({ value, label }))}
          onPick={v => pick('budget', v as Budget)}
        />
      )}

      {step === 5 && (
        <Question
          title="Are you solo or part of a team?"
          subtitle="Some tools shine for solo work, others scale with teams."
          options={(Object.entries(TEAM_LABELS) as [TeamSize, string][]).map(([value, label]) => ({ value, label }))}
          onPick={v => pick('team', v as TeamSize)}
        />
      )}

      {step > 1 && (
        <div className="mt-6">
          <button
            onClick={back}
            className="text-[13px] text-muted-foreground hover:text-foreground transition-colors"
          >
            ← Back
          </button>
        </div>
      )}

    </div>
  )
}

function Question({
  title,
  subtitle,
  options,
  onPick,
}: {
  title: string
  subtitle: string
  options: { value: string; label: string }[]
  onPick: (value: string) => void
}) {
  return (
    <div>
      <h2 className="text-[20px] md:text-[22px] font-bold text-foreground mb-2">{title}</h2>
      <p className="text-[14px] text-muted-foreground mb-5">{subtitle}</p>
      <div className="space-y-2">
        {options.map(opt => (
          <button
            key={opt.value}
            onClick={() => onPick(opt.value)}
            className="w-full text-left px-5 py-4 rounded-xl border border-border bg-card hover:border-blue-400 hover:bg-blue-50/50 dark:hover:bg-blue-950/30 transition-colors text-[15px] font-medium text-foreground"
          >
            {opt.label}
          </button>
        ))}
      </div>
    </div>
  )
}
