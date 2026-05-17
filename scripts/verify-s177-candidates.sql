-- S177 Block A: verify 5 batch-27 candidates exist in catalog + OPEN for hands-on UPDATE
SELECT slug, name, rating, review_count, hands_on_notes IS NOT NULL AS has_hands_on, tested_by
FROM tools
WHERE slug IN (
  'chatgpt',                    -- head-term AI assistant, peer claude/gemini/deepseek/qwen/manus
  'marketo',                    -- marketing automation peer customer-io/mailchimp/klaviyo
  'picsart',                    -- design 4-way completion canva-ai/adobe-firefly/adobe-express/recraft-ai
  'linkedin-sales-navigator',   -- sales-intel head-term NEW vertical
  'zoominfo',                   -- sales-intel peer-double with linkedin-sales-navigator
  -- Backup candidates if any primary fails
  'wistia',                     -- video hosting
  'guesty',                     -- vacation-rental-ops NEW vertical
  'mailmodo',                   -- email marketing peer
  'optimizely',                 -- experimentation (S173 listed)
  'hubspot-marketing-hub'       -- HubSpot marketing module
)
ORDER BY slug;
