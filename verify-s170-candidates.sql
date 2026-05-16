-- S170 batch 22 candidate verification
-- Primary: replit, codegpt, photomath, kahoot-ai, copy-ai
-- Backup: blackbox-ai, capcut, tabnine, adobe-express, shopify-magic
SELECT
  slug,
  name,
  review_count,
  rating,
  CASE WHEN hands_on_notes IS NULL THEN 'OPEN' ELSE 'TESTED' END AS status
FROM tools
WHERE slug IN ('replit', 'codegpt', 'photomath', 'kahoot-ai', 'copy-ai', 'blackbox-ai', 'capcut', 'tabnine', 'adobe-express', 'shopify-magic')
ORDER BY review_count DESC NULLS LAST;
