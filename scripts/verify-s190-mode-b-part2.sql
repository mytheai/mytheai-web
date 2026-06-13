-- S190 Block A part 2: signature/code/SMM + cohort peer-double confirmations
SELECT slug, name
FROM tools
WHERE slug IN (
  'docusign', 'signnow', 'signwell',
  'copilot', 'github-copilot', 'amazon-codewhisperer', 'aws-codewhisperer',
  'agorapulse', 'sendible', 'metricool',
  -- Cohort peer-double targets (should be present, confirms catalog state)
  'claude', 'gemini', 'midjourney', 'apollo', 'activecampaign',
  'mailchimp', 'klaviyo', 'cursor', 'codeium', 'copilot-microsoft'
)
ORDER BY slug;
