-- S190 Block A part 1: head-term candidates + cohort confirmations
SELECT slug, name
FROM tools
WHERE slug IN (
  'chatgpt', 'openai-chatgpt', 'gpt-4', 'gpt-5',
  'dall-e', 'dall-e-3', 'dalle', 'dalle-3',
  'zoominfo', 'linkedin-sales-navigator', 'sales-navigator', 'cognism', 'lusha',
  'marketo', 'marketo-engage', 'hubspot-marketing-hub', 'pardot', 'mailmodo',
  'iterable', 'braze', 'wistia', 'vidyard'
)
ORDER BY slug;
