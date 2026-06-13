-- S190 Block A: Verify which Mode B candidate slugs are MISSING vs ALREADY in catalog.
-- Run via: node --env-file=.env.local scripts/run-sql.mjs scripts/verify-s190-mode-b-candidates.sql
-- Expected: rows present = ALREADY_IN_CATALOG (skip); absent slugs = MISSING (proceed to INSERT).
-- Strategy: prioritize head-term slugs that unlock peer-doubles with recent S182-S189 hands-on batches.

SELECT slug, name
FROM tools
WHERE slug IN (
  -- Head-term AI assistants (peer-double for claude/gemini/perplexity)
  'chatgpt',
  'openai-chatgpt',
  'gpt-4',
  'gpt-5',
  -- Image-gen head-term (peer-double for midjourney/firefly/stable-diffusion S184/leonardo S164/flux S165)
  'dall-e',
  'dall-e-3',
  'dalle',
  'dalle-3',
  -- B2B sales/intent (peer-double for apollo S185/clearbit/6sense/demandbase S129)
  'zoominfo',
  'linkedin-sales-navigator',
  'sales-navigator',
  'cognism',
  'lusha',
  -- Enterprise marketing automation (peer-double for activecampaign S189/mailchimp S164/klaviyo S141/customer-io S175)
  'marketo',
  'marketo-engage',
  'hubspot-marketing-hub',
  'pardot',
  'mailmodo',
  'iterable',
  'braze',
  -- Video hosting (peer-double for loom S167/descript S141/vidyard/wistia gap)
  'wistia',
  'vidyard',
  -- E-signature peer (peer-double for adobe-sign S186/docusign-ai S179/pandadoc S179)
  'docusign',
  'signnow',
  'signwell',
  -- Code AI peer-double extension (peer-double for cursor S133/codeium S141/cody S185/copilot-microsoft S141)
  'copilot',
  'github-copilot',
  'amazon-codewhisperer',
  'aws-codewhisperer',
  -- SMM extension (peer-double for buffer S186/later S185/sprout-social S173/hootsuite S173/publer S183)
  'agorapulse',
  'sendible',
  'metricool',
  -- Cohort peer-double targets (should be present)
  'claude',
  'gemini',
  'midjourney',
  'apollo',
  'activecampaign',
  'mailchimp',
  'klaviyo',
  'cursor',
  'codeium',
  'copilot-microsoft',
  'buffer',
  'later',
  'adobe-sign',
  'pandadoc',
  'docusign-ai',
  'cody',
  'stable-diffusion',
  'leonardo-ai',
  'flux'
)
ORDER BY slug;
